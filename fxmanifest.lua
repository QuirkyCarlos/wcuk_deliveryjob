fx_version 'cerulean'
game 'gta5'
author 'WildCarlUK Scripts'
print 'WildCarlUK Scripts'

server_scripts {
	--'@mysql-async/lib/MySQL.lua',
	'@oxmysql/lib/MySQL.lua', -- OXMYSQL
	'language.lua',
	'config.lua',
	'server/server.lua',
}

client_scripts {
	'language.lua',
	'config.lua',
	'client/client.lua',
	'client/utils.lua',
}
