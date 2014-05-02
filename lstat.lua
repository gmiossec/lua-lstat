local stat = require 'lua-lstat'

-- fs stat from statcfs(3)
local fs = stat.fs('/')
print('/', 'size: ' .. fs.size .. ' free: ' .. fs.free)


-- get memory from sysinfo(2)
local mem = stat.mem()
print('Ram size: ' .. mem.total .. ' free: ' .. mem.free)


-- uptime from sysinfo(2)
local uptime = stat.uptime()
local up = {
   up_d = math.floor(uptime / (3600 * 24)),
   up_h = math.floor((uptime % (3600 * 24)) / 3600),
   up_m = math.floor(((uptime % (3600 * 24)) % 3600) / 60)
}
print(up.up_d .. ' days, ' .. up.up_h .. ' hours, ' .. up.up_m .. ' min')
