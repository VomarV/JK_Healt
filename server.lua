local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","JK_Healt")

RegisterServerEvent("JK_Healt:Server:Checkmoney")
AddEventHandler("JK_Healt:Server:Checkmoney", function(args)
    local src = source
    local user_id = vRP.getUserId({src})
    if user_id ~= nil then
        if vRP.hasPermission({ user_id , Config.Permission }) then
            TriggerClientEvent("JK_Healt:Client:Notify" , src , "الدولة سوف تتكفل في مصاريف العلاج")
            TriggerClientEvent('JK_Healt:Client:Healt', src , args)
        elseif vRP.tryPayment({ user_id , Config.Price }) then
            TriggerClientEvent("JK_Healt:Client:Notify" , src , "لقد دفعت "..Config.Price.." دولار لعلاجك")
            TriggerClientEvent('JK_Healt:Client:Healt', src , args)
        else
            TriggerClientEvent("JK_Healt:Client:Notify" , src , "ليس لديك نقود كافيه")
        end
    end
end)