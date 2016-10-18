--Depth skybox displays from
local sky_start = -100

local player_list = {} 

local timer = 0

minetest.register_globalstep(function(dtime)

	timer = timer + dtime

	if timer < 2 then
		return
	end

	timer = 0

	for _, player in pairs(minetest.get_connected_players()) do

		local name = player:get_player_name()
		local pos = player:getpos()
		local current = player_list[name] or ""

		-- Surface
		if pos.y > sky_start and current ~= "surface" then
			player:set_sky({}, "regular", {})
			player_list[name] = "surface"


		-- Everything else (blackness)
		elseif pos.y < sky_start and current ~= "blackness" then
			player:set_sky(000000, "plain", {})
			player_list[name] = "blackness"
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	player_list[name] = nil
end)