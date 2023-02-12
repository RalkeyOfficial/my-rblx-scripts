--[[
	created by: Ralkey
	Game: Speed Run Simulator
	Game Link: https://www.roblox.com/games/5293755937/Speed-Run-Simulator
]]
--

if game.PlaceId ~= 5293755937 then
	return
end

-- == IMPORTS =========================================================

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- == VARIABLES =======================================================

local godlyPets = {
	"Earth Butterfly",
	"St. Patrick's Drake",
	"Heart Dominus",
	"Future Dominus",
	"Past Dominus",
	"Present Dominus",
	"Mimic.exe",
	"Alien.exe",
	"Easter Egg",
	"Panda Monk",
	"Air Jinn",
	"Genie",
	"Pink Dragon",
	"Mimic",
	"Tiger",
	"RobinHoodEgg",
	"DaredevilEgg",
}

local legendPets = {
	"Big Friendly Bumblebee",
	"Summer Sheep",
	"Basket Bunny",
	"Wren Brightblade",
	"AJ Striker",
	"Fey Yoshida",
	"Sparks Kilowatt",
	"Ninja Mantis",
	"Grinch",
	"Evil Santa",
	"Polar Bear",
	"Rainbow Unicorn",
	"ZorroEgg",
}

local epicPets = {
	"Silly Icecream",
	"Lucky Leprechaun",
	"Aged Leprechaun",
	"Rich Leprechaun",
	"Chick-In-Egg",
	"Teddy Bear",
	"Gingerbread",
	"Evil Elf",
	"Snow Wolf",
	"Snowman",
	"Cupid!",
}

local uncommonPets = {
	"Easter Rabbit",
	"Phoenix",
	"Reindeer",
	"Penguin",
	"Snow Owl",
	"Cupcake",
	"Chocolate Heart",
}

local commonPets = {
	"Chicken",
}

local randomPets = {
	"EggOne",
	"EggTwo",
	"EggThree",
	"EggFour",
	"EggFive",
	"EggSix",
	"EggSeven",
	"EggEight",
	"EggNine",
	"EggTen",
	"EggEleven",
	"EggTweleve",
	"EggThirteen",
	"EggFourteen",
	"EggFifteen",
	"EggSixteen",
	"EggCode",
	"EggCode2",
	"Medieval Egg",
}

-- == DEFUALT VALUES ==================================================

getgenv().defaultSpeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
getgenv().defaultJump = game.Players.LocalPlayer.Character.Humanoid.JumpPower

-- == UI ==============================================================

local Window = Rayfield:CreateWindow({
		Name = "Speed Run Simulator GUI | 1.0.2 | by Ralkey",
		LoadingTitle = "Speed Run Simulator GUI",
		LoadingSubtitle = "v1.0.2 | by Ralkey",
		ConfigurationSaving = {
			Enabled = true,
			FolderName = "Speed Run Simulator", -- Create a custom folder for your hub/game
			FileName = "SpeedRunSimHub"
		},
		Discord = {
			Enabled = false,
			Invite = "", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD.
			RememberJoins = true -- Set this to false to make them join the discord every time they load it up
		},
		KeySystem = false, -- Set this to true to use our key system
		KeySettings = {
			Title = "",
			Subtitle = "",
			Note = "",
			FileName = "",
			SaveKey = false,
			GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
			Key = ""
		}
	})

local utilities = Window:CreateTab("Utilities")

utilities:CreateSection("Common utilities")

utilities:CreateToggle({
	Name = "anti-afk kick",
	CurrentValue = false,
	Flag = "antiAfkKick", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		getgenv().antiAfkKick = Value

		task.spawn(function()
			while getgenv().antiAfkKick and task.wait() do
				repeat task.wait() until game:IsLoaded()
				game:GetService("Players").LocalPlayer.Idled:connect(function()
					game:GetService("VirtualUser"):ClickButton2(Vector2.new())
				end)
			end
		end)
	end,
})

utilities:CreateToggle({
	Name = "toggle speed changer",
	CurrentValue = false,
	Flag = "setSpeed", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		getgenv().setSpeed = Value -- boolean

		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().speedValue or 50

		if Value == false then
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().defaultSpeed
		end
	end,
})

utilities:CreateSlider({
	Name = "Speed",
	Range = { 50, 500 },
	Increment = 10,
	Suffix = "speed",
	CurrentValue = 50,
	Flag = "speed", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		getgenv().speedValue = Value

		if getgenv().setSpeed then
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
		end

		task.spawn(function()
			while getgenv().setSpeed and wait() do
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
			end
		end)
	end,
})

utilities:CreateToggle({
	Name = "toggle jump changer",
	CurrentValue = false,
	Flag = "setJump", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		getgenv().setJump = Value -- boolean

		game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().jumpValue or 50

		if Value == false then
			game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().defaultJump
		end
	end,
})

utilities:CreateSlider({
	Name = "Jump power",
	Range = { 50, 300 },
	Increment = 10,
	Suffix = "jump power",
	CurrentValue = 50,
	Flag = "jump", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		getgenv().jumpValue = Value

		if (getgenv().setJump) then
			game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
		end

		task.spawn(function()
			while (getgenv().setJump and wait()) do
				game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
			end
		end)
	end,
})

utilities:CreateButton({
	Name = "Btools",
	Callback = function()
		local Player = game.Players.LocalPlayer
		local Hammer = Instance.new('HopperBin')
		Hammer.BinType = 'Hammer'
		Hammer.Name = 'Hammer'
		Hammer.Parent = Player.Backpack
		Hammer:Clone().Parent = Player.StarterGear

		local Clone = Instance.new('HopperBin')
		Clone.BinType = 'Clone'
		Clone.Name = 'Clone'
		Clone.Parent = Player.Backpack
		Clone:Clone().Parent = Player.StarterGear

		local Grab = Instance.new('HopperBin')
		Grab.BinType = 'Grab'
		Grab.Name = 'Grab'
		Grab.Parent = Player.Backpack
		Grab:Clone().Parent = Player.StarterGear
	end
})

utilities:CreateButton({
	Name = "Infinite Yield FE",
	Callback = function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
	end
})


utilities:CreateSection("Kill hud")

utilities:CreateButton({
	Name = "Kill hud",
	Callback = function()
		Rayfield:Notify({
			Title = "You are going to kill the hud",
			Content = "Are you sure?",
			Duration = 6.5,
			Actions = {
				Ignore = {
					Name = "No",
				},
				Accept = {
					Name = "Yes",
					Callback = function()
						Rayfield:Destroy()
					end
				},
			},
		})
	end,
})



local speed = Window:CreateTab("Speed")

speed:CreateSection("Get speed")

speed:CreateToggle({
	Name = "Passive speed gain (fast)",
	CurrentValue = false,
	Flag = nil, -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		getgenv().passiveSpeed = Value

		task.spawn(function()
			while getgenv().passiveSpeed and task.wait() do
				game:GetService("ReplicatedStorage").Remotes.AddSpeed:FireServer()
			end
		end)
	end,
})

local function collectAllOrbs()
	local user = game.Players.LocalPlayer.Character.Head

	local orbs = game:GetService("Workspace").GameAssets.GlobalAssets.OrbSpawns:GetChildren()
	local maps = game:GetService("Workspace").GameAssets.Maps

	-- go through all maps and get orbs
	for _, _maps in pairs(maps:GetChildren()) do
		for _, _orbs in pairs(_maps.Map.Interactables.Orbs:GetChildren()) do
			table.insert(orbs, _orbs)
		end
	end

	for _, _orb in pairs(orbs) do
		if _orb.Name == "Orb" or _orb.Name == "PurpleOrb" then
			firetouchinterest(user, _orb, 0)
		elseif _orb.Name == "SummerOrb" then
			local summerOrb = _orb["Orb.1"]
			firetouchinterest(user, summerOrb, 0)
		end
	end
end

speed:CreateButton({
	Name = "Collect orbs",
	Callback = collectAllOrbs,
})

speed:CreateToggle({
	Name = "Collect orbs loop",
	CurrentValue = false,
	Flag = nil, -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		getgenv().collectOrbsLoop = Value

		task.spawn(function()
			while getgenv().collectOrbsLoop and task.wait() do
				collectAllOrbs()
			end
		end)
	end,
})

local function collectAllRings()
	local user = game.Players.LocalPlayer.Character.Head

	local rings = game:GetService("Workspace").GameAssets.GlobalAssets.OrbSpawns:GetChildren()
	local maps = game:GetService("Workspace").GameAssets.Maps

	-- go through all maps and get orbs
	for _, _maps in pairs(maps:GetChildren()) do
		if (_maps.Name == "SkyIslands") then -- FUCK SKY ISLANDS
			do break end -- skips this loop itteration
		end

		for _, _rings in pairs(_maps.Map.Interactables.Ramps:GetChildren()) do
			table.insert(rings, _rings)
		end
	end

	for _, _ring in pairs(rings) do
		if (_ring.Name == "Ring") then
			firetouchinterest(user, _ring, 0)
		end
	end
end

speed:CreateButton({
	Name = "Collect rings",
	Callback = collectAllRings,
})

speed:CreateToggle({
	Name = "Collect rings loop",
	CurrentValue = false,
	Flag = nil, -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		getgenv().collectRingsLoop = Value

		task.spawn(function()
			while getgenv().collectRingsLoop and task.wait() do
				collectAllRings()
			end
		end)
	end,
})



local race = Window:CreateTab("Race")

race:CreateSection("Race tool")

race:CreateButton({
	Name = "Win race",
	Callback = function()
		local user = game.Players.LocalPlayer.Character.Head
		local finish = game:GetService("Workspace").GameAssets.Races.Grassy.Course.Finish.RaceEnd

		firetouchinterest(user, finish, 0)
	end,
})



local rebirth = Window:CreateTab("Rebirth")

rebirth:CreateSection("Rebirth")

rebirth:CreateButton({
	Name = "Rebirth",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
	end,
})

rebirth:CreateToggle({
	Name = "Rebirth loop",
	CurrentValue = false,
	Flag = nil, -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		getgenv().rebirthLoop = Value

		task.spawn(function()
			while getgenv().rebirthLoop and task.wait() do
				collectAllOrbs()
				collectAllRings()
				game:GetService("ReplicatedStorage").Remotes.AddSpeed:FireServer()
				game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
			end
		end)
	end,
})



local pets = Window:CreateTab("Pets")

pets:CreateSection("Get pets")

function getPet(petName)
	pets:CreateButton({
		Name = petName,
		Callback = function()
			game:GetService("ReplicatedStorage").Remotes.CanBuyEgg:InvokeServer(petName, false)
		end,
	})
end

pets:CreateSection("Godly")
for _, pet in ipairs(godlyPets) do
	getPet(pet)
end

pets:CreateSection("Legendary")
for _, pet in ipairs(legendPets) do
	getPet(pet)
end

pets:CreateSection("Epic")
for _, pet in ipairs(epicPets) do
	getPet(pet)
end

pets:CreateSection("Uncommon")
for _, pet in ipairs(uncommonPets) do
	getPet(pet)
end

pets:CreateSection("Common")
for _, pet in ipairs(commonPets) do
	getPet(pet)
end

pets:CreateSection("Random pets")
for _, pet in ipairs(randomPets) do
	getPet(pet)
end



Rayfield:LoadConfiguration()
