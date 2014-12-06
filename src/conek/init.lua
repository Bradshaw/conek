local current_folder = (...):gsub('%.init$', '')
local JSON = require(current_folder.."/JSON")
local socket = require("socket")
math.randomseed(os.time())

local conek = {}

local port = 1337

local ip = socket.dns.toip("localhost")
--local ip = socket.dns.toip("nanoleptic.net")

local udp = socket.udp()
local res, err

udp:settimeout(0)

---[[

--]]

udp:close()


return conek