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


function conek.new( options )
	local self = setmetatable({},{__index=conek_mt})
	self.udp = socket.udp()
	self.udp:settimeout(0)
	--self.udp:setsockname(ip,port)
	self.udp:setpeername(ip,port)
	self:send("Hello")
	self.tickrate = 50
	self.tick = 0
	self.valqueue = {}
	self.eventqueue = {}
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
		return JSON:decode(msg)
	end
end

function conek_mt:value(key, value)
	self.valqueue[key] = value
end

function conek_mt:event(key, data)
	
end


function conek_mt:update(dt)
	self.tick = self.tick+dt
	if self.tick>=(1/self.tickrate) then
		print("tick")
		self.tick = 0
		self:send({
			values = self.valqueue
		})
		self.valqueue = {}
	end
	local data = self:recv()
	if data then
		self.data = data
	end
end


return conek