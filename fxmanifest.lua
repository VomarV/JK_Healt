resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"
fx_version "adamant"
game "gta5"
dependency "vrp"

client_scripts {
    "lib/Tunnel.lua",
    "lib/Proxy.lua",
    "config.lua",
	"client.lua",
}

server_scripts { 
    "@vrp/lib/utils.lua", 
    "config.lua",
    "server.lua",
}