-- anasmod_my_log
local log_file = require("log_anastas_just_file")
local log_mod_name = require("log_anastas_mod_name")
local clock = require('clock')


local function make_logs_file(interations_num)
    for i = 1, interations_num do
        log_file.info("simle log from first module %d", i)
    end
end

local function make_logs_mod_name(interations_num)
    for i = 1, interations_num do
        log_mod_name.info("simle log from first module %d", i)
    end
end

local function bench_make_logs_file(expirements_num, interations_num)
    local sum = 0.0
    local min_time = 100000000.0
    local max_time = 0.0
    for i = 1, expirements_num do
        local time = clock.bench(make_logs_file, interations_num)[1]
        sum = sum + time
        if time < min_time then
            min_time = time
        end
        if time > max_time then
            max_time = time
        end
    end

    local mean_time = sum / expirements_num
    return mean_time, max_time, min_time
end

local function bench_make_logs_mod_name(expirements_num, interations_num)
    local sum = 0.0
    local min_time = 100000000.0
    local max_time = 0.0
    for i = 1, expirements_num do
        local time = clock.bench(make_logs_mod_name, interations_num)[1]
        sum = sum + time
        if time < min_time then
            min_time = time
        end
        if time > max_time then
            max_time = time
        end
    end

    local mean_time = (sum - min_time - max_time) / (expirements_num - 2)
    return mean_time, max_time, min_time
end

local anasmod_my_log = {
    make_logs_file       = make_logs_file,
    bench_make_logs_file = bench_make_logs_file,
    make_logs_mod_name       = make_logs_mod_name,
    bench_make_logs_mod_name = bench_make_logs_mod_name,
}

return anasmod_my_log
