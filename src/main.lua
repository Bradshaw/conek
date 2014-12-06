require("useful")
function love.load(arg)
	conek = require("conek")
	gstate = require "gamestate"
	game = require("game")
	gstate.registerEvents()
	gstate.switch(game)
end