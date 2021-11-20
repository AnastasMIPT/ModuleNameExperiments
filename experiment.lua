#!/usr/bin/env ../src/tarantool

box.cfg{log = '/dev/null'}


local anasmod_my_log = require("anasmod_my_log")
local anasmod_tur_log = require("anasmod_tur_log")
local anasmod_vanil_log = require("anasmod_vanil_log")
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

print('\ndefault log time')
print('mean = ', mean_time_vanil, 'max = ', max_time_vanil, 'min = ', min_time_vanil)

print('\ntime without changing code with module name')
print('mean = ', mean_time_my_mod_name, 'max = ', max_time_my_mod_name, 'min = ', min_time_my_mod_name)

print('\ntime without changing code with just file')
print('mean = ', mean_time_my_file, 'max = ', max_time_my_file, 'min = ', min_time_my_file)


print("\ntime with Alexandr Turenko's approach")
print('mean = ', mean_time_tur, 'max = ', max_time_tur, 'min = ', min_time_tur)


print("\nwithout changing code    ", (mean_time_my_mod_name / mean_time_tur - 1)   * 100, " %    slower than Alexandr Turenko's approach")
print("without changing code    ", (mean_time_my_mod_name / mean_time_vanil - 1) * 100, " %    slower than default approach")

print("\nRPS\n")
print("default log                            ", iterations_num / mean_time_vanil)
print("without changing code with module name ", iterations_num / mean_time_my_mod_name)
print("without changing code with just file   ", iterations_num / mean_time_my_file)
print("Alexandr Turenko's approach            ", iterations_num / mean_time_tur)

box.schema.user.grant('guest', 'read,write,execute', 'universe', nil, {if_not_exists=true})

require 'console'.start()
