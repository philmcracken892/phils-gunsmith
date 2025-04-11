local RSGCore = exports['rsg-core']:GetCoreObject()
local activeCrafting = {}



RegisterNetEvent("rsg-weaponcrafting:craftWeapon")
AddEventHandler("rsg-weaponcrafting:craftWeapon", function(weapon, materials, craftTime)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    
    
    if Config.RequireJob and (not Player or Player.PlayerData.job.name ~= Config.RequiredJob) then
        lib.notify(src, { title = 'Error', description = 'You are not a gunsmith!', type = 'error' })
        return
    end
    
    local hasMaterials = true
    for _, material in pairs(materials) do
        local itemCount = exports['rsg-inventory']:GetItemCount(src, material.item)
        if itemCount < material.amount then
            hasMaterials = false
            lib.notify(src, { title = 'Error', description = 'You need ' .. material.amount .. 'x ' .. material.item .. '!', type = 'error' })
            break
        end
    end

    if hasMaterials then
        for _, material in pairs(materials) do
            exports['rsg-inventory']:RemoveItem(src, material.item, material.amount)
        end
        
        local craftId = src .. "_" .. math.random(100000, 999999)
        activeCrafting[craftId] = {
            type = "weapon",
            item = weapon,
            player = src,
            quantity = 1
        }
        
        TriggerClientEvent("rsg-weaponcrafting:startCrafting", src, craftTime, craftId)
    end
end)

RegisterNetEvent("rsg-weaponcrafting:craftAmmo")
AddEventHandler("rsg-weaponcrafting:craftAmmo", function(ammo, materials, craftTime)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    
    
    if Config.RequireJob and (not Player or Player.PlayerData.job.name ~= Config.RequiredJob) then
        lib.notify(src, { title = 'Error', description = 'You are not a gunsmith!', type = 'error' })
        return
    end
    
    local hasMaterials = true
    for _, material in pairs(materials) do
        local itemCount = exports['rsg-inventory']:GetItemCount(src, material.item)
        if itemCount < material.amount then
            hasMaterials = false
            lib.notify(src, { title = 'Error', description = 'You need ' .. material.amount .. 'x ' .. material.item .. '!', type = 'error' })
            break
        end
    end

    if hasMaterials then
        for _, material in pairs(materials) do
            exports['rsg-inventory']:RemoveItem(src, material.item, material.amount)
        end
        
        local ammoQty = 1 
        for _, recipe in pairs(Config.AmmoRecipes) do
            if recipe.ammo == ammo then
                ammoQty = recipe.quantity or 1
                break
            end
        end
        
        local ammoType = Config.AmmoTypes[ammo] or ammo
        local craftId = src .. "_" .. math.random(100000, 999999)
        
        activeCrafting[craftId] = {
            type = "ammo",
            item = ammoType,
            player = src,
            quantity = ammoQty
        }
        
        TriggerClientEvent("rsg-weaponcrafting:startCrafting", src, craftTime, craftId)
    end
end)

RegisterNetEvent("rsg-weaponcrafting:repairItem")
AddEventHandler("rsg-weaponcrafting:repairItem", function(itemName, itemSlot, serial, cost)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    
    -- Check job only if Config.RequireJob is true
    if Config.RequireJob and (not Player or Player.PlayerData.job.name ~= Config.RequiredJob) then
        lib.notify(src, { title = 'Error', description = 'You are not a gunsmith!', type = 'error' })
        return
    end
    
    if Player.Functions.GetMoney('cash') < cost then
        lib.notify(src, { title = 'Error', description = 'Not enough cash!', type = 'error' })
        return
    end
    
    local item = Player.Functions.GetItemBySlot(itemSlot)
    if not item or item.name ~= itemName then
        lib.notify(src, { title = 'Error', description = 'Item not found!', type = 'error' })
        return
    end
    
    if item.type == "weapon" and serial and (not item.info.serie or item.info.serie ~= serial) then
        lib.notify(src, { title = 'Error', description = 'Invalid weapon serial!', type = 'error' })
        return
    end
    
    Player.Functions.RemoveMoney('cash', cost)
    local info = item.info or {}
    info.quality = 100
    
    Player.Functions.RemoveItem(itemName, 1, itemSlot)
    Player.Functions.AddItem(itemName, 1, itemSlot, info)
    
    lib.notify(src, { 
        title = 'Success', 
        description = 'Repaired ' .. itemName .. ' for $' .. cost .. '!', 
        type = 'success' 
    })
end)


RegisterNetEvent("rsg-weaponcrafting:finishCrafting")
AddEventHandler("rsg-weaponcrafting:finishCrafting", function(success, craftId)
    
    local src = source
    
    if not activeCrafting[craftId] or activeCrafting[craftId].player ~= src then
        return 
    end
    
    local craftData = activeCrafting[craftId]
    
    if success then
        local success = exports['rsg-inventory']:AddItem(src, craftData.item, craftData.quantity)
        if success then
            lib.notify(src, { 
                title = 'Success', 
                description = 'You crafted ' .. craftData.quantity .. 'x ' .. craftData.item .. '!', 
                type = 'success' 
            })
        else
            lib.notify(src, { 
                title = 'Error', 
                description = 'Failed to add item to inventory!', 
                type = 'error' 
            })
        end
    else
        lib.notify(src, { 
            title = 'Canceled', 
            description = 'Crafting canceled!', 
            type = 'error' 
        })
    end
    
    activeCrafting[craftId] = nil
end)