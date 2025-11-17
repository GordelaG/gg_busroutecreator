fx_version 'cerulean'
game 'gta5'

author 'Gordela'
description 'Bus Route Creator to gg_busjob'
version '1.0.0'

shared_script '@ox_lib/init.lua'
shared_script 'config.lua'
shared_script 'locales/*.lua'

client_script 'client/client.lua'
server_script 'server/server.lua'

files {
    'data/routescreated.lua'
}

lua54 'yes'