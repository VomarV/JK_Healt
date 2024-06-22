PlayerProps = {}
PlayerHasProp = false

Citizen.CreateThread(function()
    while true do
        time = 500
        local player = PlayerPedId()
        local coord = GetEntityCoords(player)
        for k , v in ipairs(Config.Location) do
            if #(coord - vector3(Config.Location[k].start[1] , Config.Location[k].start[2] , Config.Location[k].start[3])) <= 2 then 
                time = 1
                DrawMarker(21, Config.Location[k].start[1] , Config.Location[k].start[2] , Config.Location[k].start[3]-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 100, false, true, 2, true, nil, false)
                DrawText3D(Config.Location[k].start[1] , Config.Location[k].start[2] , Config.Location[k].start[3],'ﻚﻟﻮﺧﺩ ﻞﻴﺠﺴﺘﻟ [~r~E~w~] ﻂﻐﺿﺍ')
                if IsControlJustReleased(1, Config.Key) then
                    if GetEntityHealth(player) < 199 then
                        TriggerServerEvent('JK_Healt:Server:Checkmoney' , k )
                    else
                        TriggerEvent("JK_Healt:Client:Notify" , "لا تحتاج لمعالجه")
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)

RegisterNetEvent("JK_Healt:Client:Healt" , function(args)
    local player = PlayerPedId()
    FreezeEntityPosition(player, true)
    TriggerEvent("JK_PogressBar:DrawBar", 7000, 'جاري تسجيل الدخول')
    loadAnimDict( "amb@medic@standing@timeofdeath@enter" )
    loadAnimDict( "amb@medic@standing@timeofdeath@base" )
    loadAnimDict( "amb@medic@standing@timeofdeath@exit" )
    TaskPlayAnim(player,"amb@medic@standing@timeofdeath@enter", "enter",1.0, -1.0, 7000, 0, 7, false, false, false)
    TaskPlayAnim(player,"amb@medic@standing@timeofdeath@base", "base",1.0, -1.0, 7000, 0, 7, false, false, false)
    TaskPlayAnim(player,"amb@medic@standing@timeofdeath@exit", "exit",1.0, -1.0, 7000, 0, 7, false, false, false)
    AddPropToPlayer("prop_pencil_01", 58866, 0.11, -0.02, 0.001, -100.0, 0.0, 0.0)
    AddPropToPlayer("prop_notepad_01", 18905, 0.1, 0.02, 0.05, 10.0, 0.0, 0.0)
    SetTimeout(7000, function()
        DoScreenFadeOut(500)
        DeleteAllProps()
        SetTimeout(500, function()
            SetEntityCoords(player, Config.Location[args].heal[1] , Config.Location[args].heal[2], Config.Location[args].heal[3], 1,0,0,1)
            SetEntityHeading(player, Config.Location[args].heal[4])
            TaskPlayAnim(player,"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false) -- 120000
            SetTimeout(1500, function()
                DoScreenFadeIn(500)
                TriggerEvent("JK_PogressBar:DrawBar", 10000, 'يتم علاجك من قبل المسعفين')
                SetTimeout(10000, function()
                    FreezeEntityPosition(player, false)
                    SetEntityHealth(PlayerPedId(), math.floor(200))
                    DoScreenFadeOut(500)
                    SetTimeout(500, function()
                        SetEntityCoords(player, Config.Location[args].ended[1],Config.Location[args].ended[2],Config.Location[args].ended[3], 1,0,0,1)
                        SetEntityHeading(player, Config.Location[args].ended[4])
                        SetTimeout(1000, function()
                            DoScreenFadeIn(1000)
                            DeleteAllProps()
                        end)
                    end)
                end)
            end)
        end)
    end)
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end
  
function DeleteAllProps()
    for _,v in pairs(PlayerProps) do
      DeleteEntity(v)
    end
    PlayerHasProp = false
end

function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
  
    if not HasModelLoaded(prop1) then
        while not HasModelLoaded(GetHashKey(prop1)) do
            RequestModel(GetHashKey(prop1))
            Wait(10)
        end
    end
  
    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(PlayerProps, prop)
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(prop1)
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    RegisterFontFile('out')
    fontId = RegisterFontId('Arb')
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    ClearDrawOrigin()
end