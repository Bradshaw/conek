local current_folder = (...):gsub('%.init$', '')
local JSON = require(current_folder.."/JSON")
local socket = require("socket")
math.randomseed(os.time())

local conek = {}
local conek_mt = {}

local port = 1337

--local ip = "localhost"
local ip = socket.dns.toip("nanoleptic.net")

local res, err


function conek.new()
	local self = setmetatable({},{__index=conek_mt})
	self.udp = socket.udp()
	self.udp:settimeout(0)
	--self.udp:setsockname(ip,port)
	self.udp:setpeername(ip,port)
	self:send("Hello")
	print(self.udp:getpeername())
	return self
end

function conek_mt:send(data)
	if type(data)~="table" then
		data = {data = data}
	end
	self.udp:send(JSON:encode(data))
end

function conek_mt:recv()
	local msg, ip_err, port = self.udp:receive()
	if msg then
		print("Got: "..msg)
	else
		--print(ip_err)
	end
end


function conek_mt:update(dt)
	self:recv()
end


return conek