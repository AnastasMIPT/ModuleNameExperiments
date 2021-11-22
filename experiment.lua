#!/usr/bin/env ../src/tarantool

local function module_name_by_func(func_level)
    local debug = debug or require('debug')
    local name_of_need_module
    local src_name = debug.getinfo(func_level + 1).short_src
    name_of_need_module = src_name:match'.*/([^.]+)'
    return name_of_need_module
end

old_require = require
require = function(modname)
    if modname == 'log_require' then
        mod_name = module_name_by_func(2)
        print(mod_name)
        local log = old_require(modname)
        log.new(mod_name)
        return log
    end
    return old_require(modname)
end

box.cfg{log = '/dev/null'}


local anasmod_my_log = require("anasmod_my_log")
local anasmod_tur_log = require("anasmod_tur_log")
local anasmod_vanil_log = require("anasmod_vanil_log")
local anasmod_req_log = require("anasmod_require_log")
local log = require("log")

local clock = require('clock')

local iterations_num = 100000
local expirements_num = 10
local first_iterations = 1000000

for i = 1, first_iterations do
    log.info("kakaya-to informatciya")
end

local mean_time_vanil, max_time_vanil, min_time_vanil      = anasmod_vanil_log.bench_make_logs(expirements_num, iterations_num)
local mean_time_my_mod_name, max_time_my_mod_name, min_time_my_mod_name =    anasmod_my_log.bench_make_logs_mod_name(expirements_num, iterations_num)
local mean_time_my_file, max_time_my_file, min_time_my_file         =    anasmod_my_log.bench_make_logs_file(expirements_num, iterations_num)
local mean_time_tur,   max_time_tur,   min_time_tur        =   anasmod_tur_log.bench_make_logs(expirements_num, iterations_num)
local mean_time_req,   max_time_req,   min_time_req        =   anasmod_req_log.bench_make_logs(expirements_num, iterations_num)


print('\ndefault log time')
print('mean = ', mean_time_vanil, 'max = ', max_time_vanil, 'min = ', min_time_vanil)

print('\ntime without changing code with module name')
print('mean = ', mean_time_my_mod_name, 'max = ', max_time_my_mod_name, 'min = ', min_time_my_mod_name)

print('\ntime without changing code with just file')
print('mean = ', mean_time_my_file, 'max = ', max_time_my_file, 'min = ', min_time_my_file)

print("\ntime with Alexandr Turenko's approach")
print('mean = ', mean_time_tur, 'max = ', max_time_tur, 'min = ', min_time_tur)

print("\ntime with Igor Munkin's approach")
print('mean = ', mean_time_req, 'max = ', max_time_req, 'min = ', min_time_req)


print("\nwithout changing code    ", (mean_time_my_mod_name / mean_time_tur - 1)   * 100, " %    slower than Alexandr Turenko's approach")
print("without changing code    ", (mean_time_my_mod_name / mean_time_vanil - 1) * 100, " %    slower than default approach")

print("\nRPS\n")
print("default log                            ", iterations_num / mean_time_vanil)
print("without changing code with module name ", iterations_num / mean_time_my_mod_name)
print("without changing code with just file   ", iterations_num / mean_time_my_file)
print("Alexandr Turenko's approach            ", iterations_num / mean_time_tur)
print("Igor Munkin's approach            ", iterations_num / mean_time_req)


box.schema.user.grant('guest', 'read,write,execute', 'universe', nil, {if_not_exists=true})

require 'console'.start()
