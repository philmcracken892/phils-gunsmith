local RSGCore = exports['rsg-core']:GetCoreObject()
local craftingPrompt
local blips = {}
local promptGroup = GetRandomIntInRange(0, 0xffffff)


Config = Config or {}
Config.RepairTime = 5 -- Repair time in seconds
Config.RepairCostMultiplier = 0.5 -- Base cost multiplier


AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for _, blip in pairs(blips) do
            if DoesEntityExist(blip) then
                RemoveBlip(blip)
            end
        end
        PromptDelete(craftingPrompt)
    end
end)


local function StartCraftingWithCallback(craftTime, cb)
    local dict = "amb_work@world_human_hammer@wall@male_a@trans"
    local anim = "base_trans_base"
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    
    local hammer = CreateObject(`p_hammer01x`, GetEntityCoords(PlayerPedId()), true, true, true)
    AttachEntityToEntity(hammer, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "PH_R_Hand"), 0.02, 0.04, -0.06, 180.0, 180.0, 0.0, true, true, false, true, 1, true)
    
    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8.0, -1, 1, 0, true, 0, false, 0, false)
    
    local finished = lib.progressBar({
        duration = craftTime * 1000,
        label = 'Processing...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false
        },
        anim = {
            dict = dict,
            clip = anim
        }
    })
    
    ClearPedTasks(PlayerPedId())
    DeleteEntity(hammer)
    
    if finished then
        cb(true)
    else
        cb(false)
    end
end


local function GetPlayerInventory()
    local playerData = RSGCore.Functions.GetPlayerData()
    if not playerData or not playerData.items then return {} end
    local inventory = {}
    for _, item in pairs(playerData.items) do
        inventory[item.name] = item.amount or 0
    end
    return inventory
end


local function FormatMaterials(materials, inventory)
    local materialsText = ""
    for i, mat in pairs(materials) do
        local playerAmount = inventory[mat.item] or 0
        materialsText = materialsText .. mat.amount .. "x " .. mat.item .. " - Have: " .. playerAmount
        if i < #materials then
            materialsText = materialsText .. "\n"
        end
    end
    return materialsText
end


local function IsItemRepairable(item)
    return item.type == "weapon" and item.info and item.info.quality and item.info.quality < 100
end


local function CalculateRepairCost(item)
    local multiplier = Config.RepairCostMultiplier
    return math.floor((100 - item.info.quality) * multiplier)
end


local function OpenWeaponMenu()
    local weaponOptions = {}
    local inventory = GetPlayerInventory()

    for _, recipe in pairs(Config.WeaponRecipes) do
        local materialsText = FormatMaterials(recipe.materials, inventory)
        table.insert(weaponOptions, {
            title = recipe.label,
            description = "Craft Time: " .. recipe.craftTime .. "s\nRequired:\n" .. materialsText,
            icon = "fa-solid fa-hammer",
            onSelect = function()
                TriggerServerEvent("rsg-weaponcrafting:craftWeapon", recipe.weapon, recipe.materials, recipe.craftTime)
            end
        })
    end

    lib.registerContext({
        id = 'weapon_crafting_menu',
        title = 'Weapon Crafting',
        options = weaponOptions,
        menu = 'crafting_main_menu'
    })
    lib.showContext('weapon_crafting_menu')
end


local function OpenAmmoMenu()
    local ammoOptions = {}
    local inventory = GetPlayerInventory()

    for _, recipe in pairs(Config.AmmoRecipes) do
        local materialsText = FormatMaterials(recipe.materials, inventory)
        table.insert(ammoOptions, {
            title = recipe.label,
            description = "Craft Time: " .. recipe.craftTime .. "s\nYields: " .. recipe.quantity .. "\nRequired:\n" .. materialsText,
            icon = "fa-solid fa-bullet",
            onSelect = function()
                TriggerServerEvent("rsg-weaponcrafting:craftAmmo", recipe.ammo, recipe.materials, recipe.craftTime)
            end
        })
    end

    lib.registerContext({
        id = 'ammo_crafting_menu',
        title = 'Ammo Crafting',
        options = ammoOptions,
        menu = 'crafting_main_menu'
    })
    lib.showContext('ammo_crafting_menu')
end


local function OpenRepairMenu()
    local repairOptions = {}
    local playerData = RSGCore.Functions.GetPlayerData()
    
    for _, item in pairs(playerData.items) do
        if IsItemRepairable(item) then
            local repairCost = CalculateRepairCost(item)
            table.insert(repairOptions, {
                title = item.label .. " (Quality: " .. item.info.quality .. "%)",
                description = "Repair for $" .. repairCost,
                icon = "fa-solid fa-wrench",
                onSelect = function()
                    StartCraftingWithCallback(Config.RepairTime, function(success)
                        if success then
                            TriggerServerEvent("rsg-weaponcrafting:repairItem", item.name, item.slot, item.info.serie, repairCost)
                        else
                            lib.notify({ title = 'Canceled', description = 'Repair canceled!', type = 'error' })
                        end
                    end)
                end
            })
        end
    end
    
    if #repairOptions == 0 then
        lib.notify({ title = 'Error', description = 'No repairable weapons found!', type = 'error' })
        return
    end

    lib.registerContext({
        id = 'repair_menu',
        title = 'Weapon Repair',
        options = repairOptions,
        menu = 'crafting_main_menu'
    })
    lib.showContext('repair_menu')
end


local function OpenCraftingMenu()
    local options = {
        {
            title = "Craft Weapons",
            description = "Craft firearms and melee weapons",
            icon = "fa-solid fa-hammer",
            onSelect = function()
                OpenWeaponMenu()
            end
        },
        {
            title = "Craft Ammo",
            description = "Craft ammunition for your weapons",
            icon = "fa-solid fa-bullet",
            onSelect = function()
                OpenAmmoMenu()
            end
        },
        {
            title = "Repair Weapons",
            description = "Repair damaged weapons",
            icon = "fa-solid fa-wrench",
            onSelect = function()
                OpenRepairMenu()
            end
        }
    }
    lib.registerContext({
        id = 'crafting_main_menu',
        title = 'Crafting Station',
        options = options
    })
    lib.showContext('crafting_main_menu')
end


local function CreateBlips()
    for _, location in pairs(Config.CraftingLocations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, location.coords.x, location.coords.y, location.coords.z)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, location.name)
        Citizen.InvokeNative(0x662D364ABF16DE2F, blip, GetHashKey('BLIP_MODIFIER_COLOR_YELLOW'))
        table.insert(blips, blip)
    end
end


local function SetupCraftingPrompt()
    craftingPrompt = PromptRegisterBegin()
    PromptSetControlAction(craftingPrompt, 0xF3830D8E)
    PromptSetText(craftingPrompt, CreateVarString(10, 'LITERAL_STRING', 'Craft Weapons & Ammo'))
    PromptSetEnabled(craftingPrompt, true)
    PromptSetVisible(craftingPrompt, true)
    PromptSetStandardMode(craftingPrompt, true)
    PromptSetGroup(craftingPrompt, promptGroup)
    PromptRegisterEnd(craftingPrompt)
end


Citizen.CreateThread(function()
    SetupCraftingPrompt()
    CreateBlips()
    
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local nearestLocation = nil
        local nearestDist = math.huge

        for _, location in pairs(Config.CraftingLocations) do
            local dist = #(coords - location.coords)
            if dist < nearestDist then
                nearestDist = dist
                nearestLocation = location
            end
        end

        if nearestLocation and nearestDist < nearestLocation.radius then
            local promptLabel = CreateVarString(10, 'LITERAL_STRING', 'Weapon Crafting')
            PromptSetActiveGroupThisFrame(promptGroup, promptLabel)
            
            if PromptHasStandardModeCompleted(craftingPrompt) then
                PromptSetEnabled(craftingPrompt, false)
                PromptSetVisible(craftingPrompt, false)
                
                local playerData = RSGCore.Functions.GetPlayerData()
                if not playerData then
                    Wait(100)
                
                elseif not Config.RequireJob or (playerData.job and playerData.job.name == Config.RequiredJob) then
                    OpenCraftingMenu()
                else
                    lib.notify({ title = 'Error', description = 'You are not a gunsmith!', type = 'error' })
                end
                
                Wait(500)
                PromptSetEnabled(craftingPrompt, true)
                PromptSetVisible(craftingPrompt, true)
            end
        end
        Wait(0)
    end
end)


RegisterNetEvent("rsg-weaponcrafting:startCrafting")
AddEventHandler("rsg-weaponcrafting:startCrafting", function(craftTime, craftId)
    StartCraftingWithCallback(craftTime, function(success)
        TriggerServerEvent("rsg-weaponcrafting:finishCrafting", success, craftId)
    end)
end)