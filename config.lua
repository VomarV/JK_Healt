Config = {}

--[[
    ____    ____  ______   .___  ___.      ___      .______     ____    ____ 
	\   \  /   / /  __  \  |   \/   |     /   \     |   _  \    \   \  /   / 
	 \   \/   / |  |  |  | |  \  /  |    /  ^  \    |  |_)  |    \   \/   /  
	  \      /  |  |  |  | |  |\/|  |   /  /_\  \   |      /      \      /   
	   \    /   |  `--'  | |  |  |  |  /  _____  \  |  |\  \----.  \    /    
		\__/     \______/  |__|  |__| /__/     \__\ | _| `._____|   \__/     
    Discord Link : https://discord.gg/VeFBXyDw97
    Discord Account : VomarV
]]

Config.Price = 500                      -- [[ مبلغ الى يدفعه عشان يتعالج ]]
Config.Key = 38                         -- [[ الزر الى يضغطه عشان يبدا العلاج ]]
Config.Permission = "police.pc"         -- [[ صلاحية الاشخاص الى ما يدفعون فلوس ]]


Config.Location = {
    -- [[ الاحداثيات ]]
    [1] = {                                                                         -- [[ الرقم لازم معا كل اضافة احداثيه جديده ]]
        ['start'] = {305.36633300781,-595.68695068359,43.29182434082},              -- [[ مكان تسجيل الدخول ]]
        ['heal'] = {354.1682434082,-592.81365966797,43.104415893555 , 342.62},      -- [[ مكان الانعاش ]]
        ['ended'] = {349.35989379883,-589.73291015625,43.314998626709, 66.78},      -- [[ مكان رسبون الشخص بعد ما ينتهي من المعالجه ]]
    },

    --[[ 
        [1] = {
            ['start'] = { x , y , z },
            ['heal'] = { x , y , z , h },
            ['ended'] = { x , y , z , h },
        }
    ]]
}

RegisterNetEvent("JK_Healt:Client:Notify" , function(msg)
    TriggerEvent("pNotify:SendNotify" , "<b>"..msg.."</b>" , 5000 , "#FFFFFF" , "25px")
end)

return Config