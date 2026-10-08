fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    'shared/*.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

ui_page 'web/build/index.html'

-- development ui page
-- ui_page 'http://localhost:5173/'

files {
    'web/build/**'
}