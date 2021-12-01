#!/usr/bin/env ../src/tarantool

local function mod_name_form_filename(filename)
    local pathes = package.path
    local result = filename
    local cur_dir = os.getenv("PWD") .. '/'
    result = result:gsub(cur_dir, '')

    for path in  pathes:gmatch'/([A-Za-z\\/\\.0-9]+)\\?' do
        result = result:gsub('/' .. path, '');
    end

    result = result:gsub('/init.lua', ''); -- module's name shouldn't contain '/init.lua'
    result = result:gsub('%.lua', '');     -- module's name shouldn't contain '.lua'
    result = result:gsub('/', '.');
    return result
end


local path, mod_name

path = os.getenv("HOME") .. '/.luarocks/share/lua/5.1/box/internal/init.lua'
mod_name = mod_name_form_filename(path)
print('module name = ', mod_name, '\nfrom path = ', path, '\n\n')
assert(mod_name == 'box.internal')

path = os.getenv("HOME") .. '/.luarocks/share/lua/5.1/box/lua/schema.lua'
mod_name = mod_name_form_filename(path)
print('module name = ', mod_name, '\nfrom path = ', path, '\n\n')
assert(mod_name == 'box.lua.schema')

path = '/usr/local/share/tarantool/experationd.lua'
mod_name = mod_name_form_filename(path)
print('module name = ', mod_name, '\nfrom path = ', path, '\n\n')
assert(mod_name == 'experationd')

path = os.getenv("PWD") .. '/anasmod.lua'
mod_name = mod_name_form_filename(path)
print('module name = ', mod_name, '\nfrom path = ', path, '\n\n')
assert(mod_name == 'anasmod')
