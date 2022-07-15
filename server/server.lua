ESX = nil
TriggerEvent(Config.ESXSHAREDOBJECT, function(obj) ESX = obj end)

RegisterServerEvent('wcuk_deliveryjob:fetchCompanyID')
AddEventHandler('wcuk_deliveryjob:fetchCompanyID', function()
    local xPlayers = ESX.GetPlayers()
    local players  = {}
    local DataFected = false
	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, { source = xPlayer.source, identifier = xPlayer.identifier, companyID = 0 })
    end
    MySQL.Async.fetchAll("SELECT * FROM deliveryjob", {}, function(results)
        if #results > 0 then 
            for l,ply in pairs(players) do
                for k,v in pairs(results) do
                    if ply.identifier == v.identifier then
                        ply.companyID = v.companyID
                    end
                    if k == #results then DataFected = true end
                end
            end
        else
            DataFected = true
        end
    end)
    while not DataFected do Wait(5) end
    local plyCompanyID = 0
    if DataFected then 
        for k,v in pairs(players) do
            if v.companyID > 0 then plyCompanyID = v.companyID else plyCompanyID = 0 end
            TriggerClientEvent('wcuk_deliveryjob:fetchCompanyID', v.source, plyCompanyID)
        end
    end
end)

-- Get Owned Companies:
ESX.RegisterServerCallback('wcuk_deliveryjob:getTakenCompanies',function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ownedCompanies = {}
    MySQL.Async.fetchAll("SELECT * FROM deliveryjob",{}, function(data)
        for k,v in pairs(data) do
            table.insert(ownedCompanies,{id = v.companyID, name = v.name})
        end
        cb(ownedCompanies)
    end)
end)

-- Purchase Company:
ESX.RegisterServerCallback('wcuk_deliveryjob:buyCompany',function(source, cb, id, val, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = 0
    if Config.PayCompanyWithCash then
        money = xPlayer.getMoney()
    else
        money = xPlayer.getAccount('bank').money
    end
	if money >= val.price then
		if Config.PayCompanyWithCash then
			xPlayer.removeMoney(val.price)
		else
			xPlayer.removeAccountMoney('bank', val.price)
		end
        MySQL.Sync.execute("INSERT INTO deliveryjob (identifier, companyID, name) VALUES (@identifier, @companyID, @name)", {['identifier'] = xPlayer.identifier, ['companyID'] = id, ['name'] = name})
        cb(true)
    else
        cb(false)
    end
end)

-- Sell Company:
ESX.RegisterServerCallback('wcuk_deliveryjob:sellCompany',function(source, cb, id, val, sellPrice)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT companyID FROM deliveryjob WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
        if data[1].companyID ~= nil then 
            if data[1].companyID == id then
                MySQL.Async.execute("DELETE FROM deliveryjob WHERE companyID=@companyID", {['@companyID'] = id}) 
                if Config.ReciveSoldCompanyCash then
                    xPlayer.addMoney(sellPrice)
                else
                    xPlayer.addAccountMoney('bank',sellPrice)
                end
                cb(true)
            else
                cb(false)
            end
        end
    end)
end)

-- Reanme Company:
ESX.RegisterServerCallback('wcuk_deliveryjob:renameCompany',function(source, cb, id, val, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT companyID FROM deliveryjob WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
        if data[1].companyID ~= nil then 
            if data[1].companyID == id then
                MySQL.Sync.execute("UPDATE deliveryjob SET name = @name WHERE companyID = @companyID", {
                    ['@name'] = name,
                    ['@companyID'] = id
                })
                cb(true)
            else
                cb(false)
            end
        end
    end)
end)

-- Purchase Certificate:
ESX.RegisterServerCallback('wcuk_deliveryjob:buyCertifcate',function(source, cb, id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local certificate = nil
    local certificatePrice = Config.CertificatePrice
    MySQL.Async.fetchAll("SELECT * FROM deliveryjob WHERE identifier = @identifier AND companyID = @companyID", {
        ['@identifier'] = xPlayer.identifier,
        ['@companyID'] = id
    }, function(data)
        if data[1] ~= nil then 
            if data[1].companyID == id then
                if data[1].certificate == 0 then
                    local money = 0
                    if Config.PayCompanyWithCash then
                        money = xPlayer.getMoney()
                    else
                        money = xPlayer.getAccount('bank').money
                    end
                    if money >= certificatePrice then
                        if Config.PayCompanyWithCash then
                            xPlayer.removeMoney(certificatePrice)
                        else
                            xPlayer.removeAccountMoney('bank', certificatePrice)
                        end
                        MySQL.Sync.execute("UPDATE deliveryjob SET certificate = @certificate WHERE companyID = @companyID", {
                            ['@certificate'] = 1,
                            ['@companyID'] = id
                        })
                        cb(true)
                    else
                        cb(false)
                    end
                else
                    cb(1)
                end
            else
                cb(nil)
            end
        end
    end)
end)

ESX.RegisterServerCallback('wcuk_deliveryjob:vehDepositFee',function(source, cb, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local plyMoney = 0
    if Config.DepositInCash then 
        plyMoney = xPlayer.getMoney() 
    else
        plyMoney = xPlayer.getAccount("bank").money
    end
    if plyMoney >= amount then
        if Config.DepositInCash then 
            xPlayer.removeMoney(amount)
            Wait(250)
            plyMoney = xPlayer.getMoney() 
        else
            xPlayer.removeAccountMoney("bank", amount)
        end
        cb(true)
    else
        cb(false)
    end
end)

-- Add reward:
RegisterServerEvent('wcuk_deliveryjob:retrievePaycheck')
AddEventHandler('wcuk_deliveryjob:retrievePaycheck', function(paycheck, vehDeposit, giveDeposit)
    local xPlayer = ESX.GetPlayerFromId(source)
    if giveDeposit then
        xPlayer.addMoney(vehDeposit)
        TriggerClientEvent('wcuk_deliveryjob:ShowNotifyESX', xPlayer.source, (Lang['deposit_returned']:format(vehDeposit)))
    end
    xPlayer.addMoney(paycheck)
    TriggerClientEvent('wcuk_deliveryjob:ShowNotifyESX', xPlayer.source, (Lang['paycheck_received']:format(paycheck)))

    MySQL.Async.fetchAll("SELECT level FROM deliveryjob WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
        if data[1].level ~= nil then 
            MySQL.Sync.execute("UPDATE deliveryjob SET level = @level WHERE identifier = @identifier", {
                ['@level'] = data[1].level + Config.AddLevelAmount,
                ['@identifier'] = xPlayer.identifier
            })
        end
    end)
end)

-- Orders from 5M_Shops (soon to be added)
local orders = {}
RegisterServerEvent('wcuk_deliveryjob:sendOrderSV')
AddEventHandler('wcuk_deliveryjob:sendOrderSV', function(orderData)
    table.insert(orders, {data = orderData, taken = false})
end)

ESX.RegisterServerCallback('wcuk_deliveryjob:fetchShopOrders',function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.T1GER_Shops then
        cb(orders)
    end
end)

RegisterServerEvent('wcuk_deliveryjob:updateOrderState')
AddEventHandler('wcuk_deliveryjob:updateOrderState', function(orderData, state)
    if #orders > 0 then
        for k,v in pairs(orders) do
            if orderData.data.orderItem == v.data.orderItem and orderData.data.shopID == v.data.shopID then
                if orderData.data.itemPrice == v.data.itemPrice then
                    v.taken = true
                end
            end
        end
    end
end)

RegisterServerEvent('wcuk_deliveryjob:orderDeliveryDone')
AddEventHandler('wcuk_deliveryjob:orderDeliveryDone', function(orderData)
    local tableUpdated = false
    if #orders > 0 then
        for k,v in pairs(orders) do
            if orderData.data.orderItem == v.data.orderItem and orderData.data.shopID == v.data.shopID then
                if orderData.data.itemPrice == v.data.itemPrice then
                    table.remove(orders, k)
                    tableUpdated = true
                end
            end 
        end
        while not tableUpdated do Wait(5) end
        if tableUpdated then
            TriggerEvent('t1ger_shops:addOrderToStock', orderData) 
        end
    end
end)

ESX.RegisterServerCallback('wcuk_deliveryjob:getCompanyData', function(source, cb, id)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT * FROM deliveryjob WHERE identifier = @identifier AND companyID = @companyID", {
        ['@identifier'] = xPlayer.identifier,
        ['@companyID'] = id
        }, function (data)
                --print(data[1].level,data[1].certificate)
                if data[1].companyID ~= nil then
                    if data == 0 then
                        cb(nil)
                    else
                        cb(data[1].level,data[1].certificate)
                    end
                end
        end)
end)