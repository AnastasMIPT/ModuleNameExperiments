-- anasmod_tur_log
local log = require("log_tur")
local clock = require('clock')

log.new('anasmod_tur_log')

local function make_logs(interations_num)
    for i = 1, interations_num do
        log.info("simle log from first module %d", i)
    end
end

local function bench_make_logs(expirements_num, interations_num)
    local sum = 0.0
    local min_time = 100000000.0
    local max_time = 0.0
    for i = 1, expirements_num do
        local time = clock.bench(make_logs, interations_num)[1]
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


local anasmod_tur_log = {
    make_logs       = make_logs,
    bench_make_logs = bench_make_logs,
}

return anasmod_tur_log
