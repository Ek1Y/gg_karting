fx_version 'cerulean'

game 'gta5'

author 'VuleGG'

description 'Karting Script'

version "v1.0.0"

lua54 'yes'

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'klijent.lua'
}

server_scripts {
    'server.lua'
}

dependency {
	'es_extended'
}


