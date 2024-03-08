
-- [FX Information]
fx_version 'cerulean'
use_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

-- [Resource Information]
name 'NK-Repair'
author 'NK-Development | Nikuez'
version '1.8.0'
description 'An simple repair system for FiveM with cool animations'

-- [Manifest]
shared_scripts {
	'shared.lua',
}

client_script 'client/main.lua'

server_script 'server/main.lua'