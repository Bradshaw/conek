local socket = require("socket")
math.randomseed(os.time()) 

local ip = socket.dns.toip("localhost")
--local ip = socket.dns.toip("undefined-conek.jit.su")

print(type(ip),ip)

local udp = socket.udp()
local res, err

udp:settimeout(0)

--[[
res, err = udp:setpeername(ip, 1337)
print(res, err)
res, err = udp:send("Testing")
print(res, err)

--]]

res, err = udp:sendto("This message is much longer", ip, 8080)
print(res, err)

udp:close()