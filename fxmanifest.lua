fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'Fractal Game Studios'
description 'A simple script to get player time and server time with exports'

client_scripts {
    'client/cl_main.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    "shared/sh_config.lua",
}

server_scripts {
    'server/sv_main.lua',
}

ui_page 'web/index.html'
files {
    'web/index.html',
}