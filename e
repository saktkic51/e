-- Author: WATDAHECKLOL32
-- Modified by: LightStrikeVex

if not hookmetamethod or not newcclosure or not getgc or not cloneref then
	error("unsupported", 2);
	return;
end;
local isfunctionhooked = isfunctionhooked or isnewcclosure or iscclosure;
if not isfunctionhooked then error("unsupported", 2); return; end;
if getgenv().Loaded then return; end;
getgenv().Loaded = true;
local service = setmetatable({}, {
	__index = function(self, index)
		local ref = cloneref(game:GetService(index));
		rawset(self, index, ref);
		return ref;
	end;
});
local run_service: RunService = service.RunService;
local Players: Players = service.Players;
local Player = Players.LocalPlayer :: Player;
local CollectionService: CollectionService = service.CollectionService;
local network = {};
local wait = task.wait;
local spawn = task.spawn;
for _,v in getgc(false) do
	if type(v) == "function" and islclosure(v) then
		if debug.info(v, "n") == "FireServer" then
			network.FireServer = v;
		elseif debug.info(v, "n") == "InvokeServer" then
			network.InvokeServer = v;
		end;
	end;
end;
local Luna = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/luna", true))();
local Window = Luna:CreateWindow({
	Name = "Site-19 SEX HUB SPECIAL EDITION", 
	Subtitle = "It's so cooked.", 
	LogoID = 82795327169782,
	LoadingEnabled = true, 
	LoadingTitle = "Site-19 SEX HUB V2.0", 
	LoadingSubtitle = "by Director WATDAHECKLOL32, Special Agent Vex, Agent whiz",
	ConfigSettings = {
		RootFolder = nil, 
		ConfigFolder = "S19 Hub" 
	},
	KeySystem = false, 
	KeySettings = {
		Title = "Please input your provided key",
		Subtitle = "Key System",
		Note = "Contact 'Creator' for help.",
		SaveInRoot = false, 
		SaveKey = true, 
		Key = {}, 
		SecondAction = {
			Enabled = false,
			Type = "Link", 
			Parameter = "" 
		}
	}
});
-- when my encryption sys so good the client can decode it
local decode_args;  decode_args = @native function(encoded: string, key: {number}, extra: number): string
	local decoded: string = "";
	local cut_off: number = #encoded;
	if not extra then
		cut_off = #encoded - key[5] ;
	end;
	for i = 1, cut_off do
		for mod = 0, 3 do
			if i % 4 == mod then
				local char: string = string.sub(encoded, i, i);
				local off_set: number = key[mod + 1];
				local code: number = string.byte(char) - 32;
				if extra then
					off_set = -off_set;
				end;
				local original: number = (code - off_set) % 95 + 32;
				decoded = decoded .. string.char(original);
				break;
			end;
		end;
	end;
	return decoded;
end;
local helpful_tab =  Window:CreateTab({
	Name = "Main";
	Icon = "report";
	ImageSource =  "Material";
	ShowTitle = true;	
});
local weapon_tab = Window:CreateTab({
	Name = "Weapons",
	Icon = "pan_tool",
	ImageSource = "Material",
	ShowTitle = true
});
local moderation_tab = Window:CreateTab({
	Name = "Moderation";
	Icon = "security";
	ImageSource = "Material";
	ShowTitle = true
});
local ddos_tab = Window:CreateTab({
	Name = "DDOS";
	Icon = "dns";
	ImageSource = "Material";
	ShowTitle = true;
});
local teleport_tab = Window:CreateTab({
	Name = "Teleport";
	Icon = "public";
	ImageSource = "Material";
	ShowTitle = true;
});
local door_tab = Window:CreateTab({
	Name = "Doors";
	Icon = "sensor_door";
	ImageSource = "Material";
	ShowTitle = true;	
});
local door_section = door_tab:CreateSection("Main");
door_section:CreateButton({
	Name = "Open keycard door nearest to you";
	Description = "Doesnt require a keycard at all";
	Callback = @native function(_: unknown): ()
		for _,v in CollectionService:GetTagged("Door") do
			network:FireServer("interactWith","Door", v:GetAttribute("Id"), "Front");
			network:FireServer("interactWith", "Door", v:GetAttribute("Id"), "Back");
		end;
		return;
	end,
});
door_section:CreateButton({
	Name = "Open all keycard doors";
	Description = "Must have keycard out";
	Callback = @native function(_: unknown): ()
		if not Player.Character or not Player.Character:FindFirstChildWhichIsA("Tool") then
			return;
		end;
		local Card = Player.Character:FindFirstChildWhichIsA("Tool");
		for _, v in CollectionService:GetTagged("Door") do
			for _, part in v:GetDescendants() do
				if part:FindFirstChild("TouchInterest") then
					firetouchinterest(Card.Handle, part, 0);
					firetouchinterest(Card.Handle, part, 1);
				end;
			end;
		end;
		return;
	end,
});
teleport_tab:CreateLabel({
	Text = "Teleports can fail if your ping is too high.";
	Style = 2;
});
local teleport_locations: {[string]: CFrame} = {
	["Tower"] =  CFrame.new(548, 557, 848);
	["CI Base"] = CFrame.new(830, 500, 875);
	["106 CC"] = CFrame.new(655.999939, -5.89998817, -374.19989, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Medical bay"] = CFrame.new(830, 8.99999809, 182.000061, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Cafe"] = CFrame.new(583, 3.50000334, 210.000031, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["SD bay"] = CFrame.new(431.999969, 9.5, 82.0000458, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["MTF spawn"] = CFrame.new(763.000183, 489.698029, 429.000183, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["MTF armory"] = CFrame.new(830.321289, 489.5, 419.206696, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["CDC"] = CFrame.new(1008, 16.5, -171, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Control room"] = CFrame.new(375.999908, 24.4999962, 191.000031, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Gate A"]  = CFrame.new(383.5, 7.5, 292.000031, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Gate B"] = CFrame.new( 718, 8.5, 248.000031, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Shelter 1"] = CFrame.new(529, 8.50000095, 78.1768188, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Warhead"] = CFrame.new(623.999939, -17.4999905, -297.999847, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["Court room"] = CFrame.new(911.927917, 8.5, 150.66571, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["173 CC"] = CFrame.new(1016, 24.5, -66.9999847, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["SCD spawn"] = CFrame.new( 871.999939, 8.5, 199.999985, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["079 CC"] = CFrame.new(828.999939, 0.5, -254.499969, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["008 CC"] = CFrame.new(356.257416, 8.50000763, -335.106445, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	["EZ lockers"] = CFrame.new(465, 10, 166);
	["LCZ lockers"] = CFrame.new(560, 8, -144);
	["Normal armory"] = CFrame.new(591, 7, -153);
	["049 CC"] = CFrame.new(528, -40, -271);
	["914 CC"] = CFrame.new(768, 8, -146);
	["Gate A outside"]  = CFrame.new(426, 537, 783);
	["Gate B outside"]  = CFrame.new(849, 527, 593);
	["Gate B tower"]  = CFrame.new(871, 499, 461);
};
local players_section = teleport_tab:CreateSection("Players");
local teleport_to_location; teleport_to_location = @native function(Cframe: CFrame)
	local root = Player.Character:WaitForChild("HumanoidRootPart");

	local targetPos = Vector3.new(846, 463, 878);
    local distance = 1;

	local heartbeat
    run_service.Heartbeat:Connect(function();
	local currentPos = root.Position;
	root:PivotTo(CFrame.new(538.300049, 34, -191));
	
	if (currentPos - targetPos).Magnitude <= distance then
		root:PivotTo(CFrame.new(Cframe));
		heartbeat:Disconnect();
	end;
end;
players_section:CreateDropdown({
	Name = "Teleport to player";
	Description  = nil;	
	Options = {};
	CurrentOption = {tostring(Player)};
	MultipleOptions = false;
	SpecialType = "Player";
	Callback = @native function(Option: string)
		if Option == tostring(Player) then return; end;
		local plr: Player = Players[tostring(Option)];
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			teleport_to_location(plr.Character.Head.CFrame)
		end;
	end,
});
local helpful_section = helpful_tab:CreateSection("Section 1");
local Containnment = teleport_tab:CreateSection("SCP Cells");
local Bays = teleport_tab:CreateSection("Bays");
local misc_left = teleport_tab:CreateSection("Uncategorized");
local misc_right = teleport_tab:CreateSection("Uncategorized");
local Player = Players.LocalPlayer :: Player;
for i: string, v: CFrame in teleport_locations do
	local group_side;
	if i:find("CC") then
		group_side = Containnment;
	elseif i:find("bay") or i:find("spawn") then
		group_side = Bays;
	else
		local random = math.random(1, 2);
		group_side = random == 1 and misc_left or misc_right;
	end;
	group_side:CreateButton({
		Name = i;
		Description = nil;
		Callback = @native function(_: unknown): ()
			teleport_to_location(v)
			return;
		end,
	});
end;
local other_tab = Window:CreateTab({
	Name = "MISC";
	Icon = "folder";
	ImageSource = "Material";
	ShowTitle = true;
});
local Moderation = moderation_tab:CreateSection("Moderation");
local anti_cheat = moderation_tab:CreateSection("Anti cheat");
local ddos_section = ddos_tab:CreateSection("Config");
local main = ddos_tab:CreateSection("Methods");
local other_section1 = other_tab:CreateSection("Section 1");
local other_section2 = other_tab:CreateSection("Section  2");
local char = Player.Character;
local states = {
	server_bypass = false;
	mod_kick = false;
	mod_notifer = false;
	ddos_send_count = 20;
	fire_rate = 800;
	insta_kill_send_count = 20;	
	avoid = false;
	tesla_spam = false;
	infinite_run = false;
};
ddos_section:CreateLabel({
	Text = "Do not set the count too high or spam too fast else face detection by UDMUX.";
	Style = 3;
});
local toggle_run = @native function(): ()
	for _,v in getgc(true) do
		if type(v) == "table" and rawget(v, "Sprint") and type(rawget(v, "Sprint")) == "number" then
			v.Sprint = math.huge;
		end;
	end;
	return;
end;
local teleport_service: TeleportService = service.TeleportService;
helpful_tab:CreateButton({
	Name = "Teleport to testing place";
	Description = nil;
	Callback = @native function(_: unknown): ()
		teleport_service:Teleport(4346713746, Player);
		return;
	end,
});
helpful_tab:CreateButton({
	Name = "UGC R15 Animations";
	Description = nil;
	Callback = @native function(_: unknown): ()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/LightStrikeVex/dingaling/refs/heads/main/script.luau"))();	
	end;
});
helpful_tab:CreateToggle({
	Name = "Minimap spy (buggy for now)  ";
	Description = "Shows everyone on the minimap regardless of team, colors changes based on team color.";
	Callback = @native function(toggle: boolean): ()
		if toggle then
			local hook; hook = hookmetamethod(game, "__index", newcclosure(function(...)
				if checkcaller() then  return hook(...); end;
				local self, index = ...;
				if self and typeof(self) == "Instance" and tostring(self) == "Foundation" and self.ClassName == "BoolValue" and index == "Value" then
					return true;
				end;
				return hook(...);
			end));
			for _,v in getgc(false) do
				if type(v) == "function" and islclosure(v) and debug.info(v, "n") == "UpdateMinimap" then
					local up_values = debug.getupvalues(v);
					local new_instance = up_values[4];
					local hook; hook = hookfunction(new_instance, newlclosure(function(self: any, class: string, prop: {[string]: any})
						if class == "ImageLabel" and rawget(prop, "ImageColor3") and rawget(prop, "AnchorPoint") and rawget(prop, "ZIndex") then
							rawset(prop, "ImageColor3", Players[rawget(prop, "Name")].TeamColor.Color);
						end;
						return hook(self, class, prop);
					end));
				end;
			end;
			for _,v in Player.PlayerGui.HudGui["#map"].Players:GetChildren() do
				if Players:FindFirstChild(tostring(v)) then
					v.ImageColor3 = Players[tostring(v)].TeamColor.Color;
				end;
			end;
		else
			if isfunctionhooked(getrawmetatable(game).__index) then
				restorefunction(getrawmetatable(game).__index);
			end;
			for _,v in getgc(false) do
				if type(v) == "function" and islclosure(v) and debug.info(v, "n") == "UpdateMinimap" then
					local up_values = debug.getupvalues(v);
					local new_instance = up_values[4];
					if isfunctionhooked(new_instance) then restorefunction(new_instance); end;
				end;
			end;
			for _,v in Player.PlayerGui.HudGui["#map"].Players:GetChildren() do
				if v:IsA("ImageLabel") and Players:FindFirstChild(tostring(v)) then
					v.ImageColor3 = tostring(v) == tostring(Player) and Color3.fromRGB(85, 255, 0) or Color3.fromRGB(0, 0, 255);
				end;
			end;
		end;
		return;
	end,	
});
helpful_section:CreateToggle({
	Name = "Full bright";
	Callback = @native function(enabled: boolean): ()
		if enabled then
			local hook; hook = hookmetamethod(game, "__newindex", newcclosure(function(...)
				local self, index, value = ...;
				if not checkcaller() and self and typeof(self) == "Instance" and self == game:GetService("Lighting") then
					return;
				end;
				hook(...);
			end));
			Luna:Notification({
				Title = "Done";
				Icon  = "check_box";
				ImageSource = "Material";
				Content = "Now run IY full bright"
			});
		else
			restorefunction(getrawmetatable(game).__newindex);
		end;
		return;
	end,	
});
helpful_tab:CreateButton({
	Name = "Trigger autofarm";
	Callback = @native function(_: unknown): ()
		local send_count: number = 999999;
		for _,v in getgc(false) do
			if type(v) == "function" and debug.info(v, "n") == "_createBlood" then
				local hook; hook = hookfunction(v, newlclosure(function(...)
					for i = 1, send_count do
						wait();
						hook(...);
					end;
					return hook(...)
				end));
			end;
		end;
		return;
	end,
});
helpful_tab:CreateDropdown({
	Name = "Get Tool";
	Description = "Buys from CD dealer";
	Options  = {"Locker Keychain", "P90s", "Glock 22", "Keycard Device", "Honey badger", "Kriss Vector", "Level 3", "M16", "P90", "Level 4" , "Level 5", "Kitchen Knife"};
	CurrentOption = {};
	MultipleOptions  = true;
	Callback  = @native function(Options: string | {string}): ()
		if type(Options) == "table" then 
			for _,v in Options do network:InvokeServer("PurchaseItem", v); end;
		elseif type(Options) == 'string' then
			network:InvokeServer("PurchaseItem", Options) 
		end;
		return;
	end,
});
helpful_tab:CreateToggle({
	Name = "Disable sprint";
	Description = "Also known as infinite run";
	Callback = @native function(toogle: boolean): ()
		if toogle then
			toggle_run();
		else
			for _,v in getgc(true) do
				if type(v) == "table" and rawget(v, "Sprint") and type(rawget(v, "Sprint")) == "number" then
					v.Sprint = 21;
				end;
			end;
		end;
		states.infinite_run = toogle;
		return;
	end;
});
helpful_tab:CreateButton({
	Name = "Remove barriers";
	Description = nil;
	Callback = @native function(toggle: boolean): ()
		for _,v in workspace.Ignore:GetChildren() do
			if tostring(v) == "Block" or tostring(v) == "CI" then
				v:Destroy();
			end;
		end;
		return;
	end,
});
helpful_tab:CreateToggle({
	Name = "Disable blinking";
	Description = "Also known as infinite blinking";
	Callback = @native function(toggle: boolean): ()
		if toggle then
			for _,v in getgc(false) do
				if type(v) == "function" and islclosure(v) and debug.info(v, "n") == "ToggleBlink" or debug.info(v, "n") == "UpdateBlink" then
					hookfunction(v, function() end);
				end;
			end;
		else
			for _,v in getgc(false) do
				if type(v) == "function" and islclosure(v) and debug.info(v, "n") == "ToggleBlink" or debug.info(v, "n") == "UpdateBlink" then
					if isfunctionhooked(v) then
						restorefunction(v);
					end;
				end;
			end
		end;
		return;
	end,
});
local Slider = ddos_section:CreateSlider({
	Name = "Packet send count",
	Range = {1, 50},
	Increment = 2, 
	CurrentValue = 20;
	Callback = @native function(value: number): ()
		states.ddos_send_count = value;
		return;
	end;
}, "Slider");
main:CreateButton({
	Name = "Load charecter spam";	
	Description = nil;
	Callback = @native function(): ()
		for i = 1, states.ddos_send_count do
			network:FireServer("switchTeamMenu", "Janitor");	
			network:FireServer("switchTeamMenu", "Janitor");
			network:FireServer("switchTeamMenu", "Janitor");
		end;
		return;
	end,
});
local weapon_section_1 = weapon_tab:CreateSection("Firerate");
weapon_section_1:CreateToggle({
	Name = "Make guns automatic";
	Description = "Makes guns automatic property to true";
	Callback = @native function(enabled: boolean): ()
		if enabled then
			for _,v in getgc(true) do
				if type(v) == "table" and rawget(v, "Variables") and rawget(v, "Name") and type(rawget(v, "Variables")) == "table" and rawget(rawget(v, "Variables"), "Stats") then
					rawset(v.Variables.Stats, "Automatic", true);
				end;
			end;
		else
			for _,v in getgc(true) do
				if type(v) == "table" and rawget(v, "Variables") and rawget(v, "Name") and type(rawget(v, "Variables")) == "table" and rawget(rawget(v, "Variables"), "Stats") then
					if rawget(v, "Name") == "Glock 22" then
						rawset(v.Variables.Stats, "Automatic", false);
					else
						rawset(v.Variables.Stats, "Automatic", true);
					end;
				end;
			end;
		end;
		return;
	end,
});
local toggle_infinite_ammo; toggle_infinite_ammo = @native function(enabled: boolean)
	local LUA_GC = getgc(true);
	local Network;
	local newluaclosure = newlclosure;
	for _,v in LUA_GC do
		if type(v) == "table" then
			if rawget(v, "InvokeServer") then
				Network = v;
			elseif rawget(v, "_discharge") then
				if not enabled then
					restorefunction(rawget(v, "_discharge"));
					break;
				end;
				local hook; hook = hookfunction(rawget(v, "_discharge"), newluaclosure(function(gun_settings)
					Network:FireServer("setToolState", "Reload");
					Network:FireServer("setToolState", "Reloaded");
					gun_settings.Ammo = 999;
					hook(gun_settings);
				end));
			end;
		end;
	end;
end;
weapon_section_1:CreateToggle({
	Name = "Infinite Ammo";
	Description = nil;
	Callback = @native function(state: boolean): ()
		toggle_infinite_ammo(state);
		return;
	end,
});
weapon_section_1:CreateToggle({
	Name = "Disable RPM";
	Description = "Hooks task.wait";
	Callback = @native function(state: boolean): ()
		if state then
			local hook; hook = hookfunction(task.wait, newcclosure(function(...: number?): ()
				if checkcaller() then return hook(...); end;
				local time: number? = ...
				local caller = debug.info(3, "f");
				if caller and debug.info(caller, "n") == "_activateDischarge" then time = nil :: never; end;
				return hook(time);
			end));
		else
			if isfunctionhooked(task.wait) then
				restorefunction(task.wait);
			end;
		end;
		return;
	end,
});
door_section:CreateToggle({
	Name = "Spam teslas";
	Description = "Spam activates teslas";
	Callback = @native function(toggle: boolean): ()
		states.tesla_spam = toggle;
		return;
	end,
});
local toggle_insta_kill; toggle_insta_kill = @native function(enabled: boolean)
	if not enabled then
		restorefunction(getrawmetatable(game).__namecall);
		return;
	end;
	local lua_gc = getgc(true);
	local FireServer;
	for _,v in lua_gc do
		if type(v) == 'table' and rawget(v, "InvokeServer") and rawget(v, "FireServer") then
			FireServer = rawget(v, "FireServer")
			break;
		end;
	end;
	local up_values = debug.getupvalues(FireServer);
	local net_encode = up_values[2];
	local flux_encode;
	local hook; hook = hookfunction(net_encode, newlclosure(function(...)
		local args = {...};
		if not flux_encode then
			-- warn("meow");
			flux_encode = args[2];
		end;
		return hook(...);
	end));
	repeat wait() until flux_encode;
	local hook; hook = hookmetamethod(game, "__namecall", newcclosure(function(...)
		local Args: {any} = {...};
		local Self = Args[1];
		table.remove(Args, 1);
		if not checkcaller() and Self and typeof(Self) == "Instance" and getnamecallmethod() == "FireServer" or getnamecallmethod() == "InvokeServer" and Self.ClassName == "RemoteEvent" or Self.ClassName == "RemoteFunction" then
			local decoded_args = decode_args(Args[1], flux_encode, false);
			local remote_args = string.split(decoded_args, ",");
			if remote_args[3] == '"Discharge"' then
				for i = 1, states.insta_kill_send_count do
					hook(...);
				end;
			end;
		end;
		return hook(...);
	end));
end;
local weapon_section_2 = weapon_tab:CreateSection("Spread");
weapon_section_2:CreateToggle({
	Name = "No Spread";
	Callback = @native function(toggle: boolean)
		if toggle then
			for _,v in getgc(true) do
				if type(v) == 'table' and rawget(v, "Update") and rawget(v, "GetHolstered") and rawget(v, "Crouch") and rawget(v, "Reloaded") then
					local func = rawget(v, "Update");
					if toggle then
						hookfunction(func, newlclosure(function(self)
							rawset(self, "_spray", {0, 0, 0});
						end));
					else
						restorefunction(func)
					end;
				end;			
			end;
		end;
	end,

});
local weapon_section_2 = weapon_tab:CreateSection("Instant kill");
weapon_section_2:CreateLabel({
	Text = "Do not set the count too high or spam too fast else face detection by UDMUX.";
	Style = 3;
})
weapon_section_2:CreateLabel({
	Text = "This is also really harsh on the ears for other players.";
	Style = 2;
});
local Slider = weapon_section_2:CreateSlider({
	Name = "Packet send count",
	Range = {1, 300},
	Increment = 2, 
	CurrentValue = 20;
	Callback = @native function(value: number): ()
		states.insta_kill_send_count = value;
		return;
	end;
}, "Slider");
weapon_section_2:CreateToggle({
	Name = "Toggle Instant kill";
	Description = "One shot. One kill :cold_face_emoji:";
	Callback = @native function(value: boolean)
		toggle_insta_kill(value);
		return;
	end,
});
local server_bypass = @native function(value: boolean)
	if value then
		if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
			return;
		end;
		local humanoid_root: Part = Player.Character:FindFirstChild("HumanoidRootPart");
		local hook; hook = hookmetamethod(game, "__namecall", newcclosure(function(...)
			if checkcaller() then return hook(...); end;
			local args = {...};
			local method = string.lower(getnamecallmethod());
			local self = args[1];
			table.remove(args, 1);
			if typeof(self) == "Instance" and method == "findfirstchild" and args[1] and type(args[1]) == "string" and args[1] == "HumanoidRootPart" and Player.Character and Player.Character.FindFirstChild(Player.Character, "LowerTorso") and self == Player.Character then
				return Player.Character.LowerTorso;
			end;
			return hook(...);
		end));
		local hook; hook = hookmetamethod(game, "__index", newcclosure(function(...)
			if checkcaller() then  return hook(...); end;
			local self, index = ...;
			if typeof(self) == "Instance" and typeof(index) == "string" and index == "HumanoidRootPart" and self ==  char then
				return char.FindFirstChild(char, "LowerTorso");
			end;
			return hook(...);
		end));	
		humanoid_root:Destroy();
	else
		if isfunctionhooked(getrawmetatable(game).__namecall) and isfunctionhooked(getrawmetatable(game).__index) then
			restorefunction(getrawmetatable(game).__namecall);
			restorefunction(getrawmetatable(game).__index);			
		end;
	end;
	return;
end;
local scp_group: number = 3895837;
Moderation:CreateLabel({
	Text = "Moderator scan will only notify you once. Enable notifer for live updates.";
	Style = 3;
})
other_section2:CreateLabel({
	Text = "ESP does NOT have a feature to be toggable.";
	Style = 3;
});
other_section2:CreateButton({
	Name = "Load ESP";
	Description = "A great ESP for Site-19 made by whiz.sk.";
	Callback = @native function(): ()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/sleepyBIOS/scripts/refs/heads/main/site19esp.luau"))(); 
	end,
});
other_section2:CreateButton({
	Name = "Load IY";
	Description = nil;
	Callback = @native function(): ()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))();		
	end,
});
other_section2:CreateButton({
	Name = "Load chatlogs";
	Description = "A great chatlogs UI for Site-19 made by whiz.sk.";
	Callback = @native function(): ()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/sleepyBIOS/scripts/refs/heads/main/site19chatlogs.lua"))();
	end,
});
other_section1:CreateToggle({
	Name = "Always mouse enabled";
	Description = "Prevents the mouse icon from becoming invisible.";
	CurrentValue = false;
	Callback = @native function(value: boolean): ()
		if value then
			local hook; hook = hookmetamethod(game, "__newindex", newcclosure(function(...)
				if checkcaller() then hook(...); return; end;
				local self, index, value = ...;
				if typeof(self) == "Instance" and self ==  Player:GetMouse() then
					if typeof(index) == "string" and string.lower(index) == "icon" and typeof(value) == "string" and string.len(value) <= 0 then
						return;
					end;
				elseif self == game:GetService("UserInputService") then
					if typeof(index) == "string" and string.lower(index) == "mouseiconenabled" and type(value) == "boolean" and not value then
						return;
					end;
				end;
				hook(...);
			end));
			game:GetService("UserInputService").MouseIconEnabled = true;
		else
			if isfunctionhooked(getrawmetatable(game).__newindex) then
				restorefunction(getrawmetatable(game).__newindex);
			end;
		end;
		return;
	end,
});
Moderation:CreateButton({
	Name = "Randomize apperance";
	Description = nil;
	Callback = @native function(): ()
		network:InvokeServer("changeClothing", "Skin", 1);
		network:InvokeServer("changeClothing", "Hair", 1);
		network:InvokeServer("changeClothing", "Face", 1);
		return;
	end,	
});
Moderation:CreateButton({
	Name = "Moderator scan.",
	Description = "Scans for moderators in the game.";
	Callback = @native function()
		local mods: {[number]: string} = {};
		local teams: {[number]: string} = {}
		for _: unknown, v: Player in Players:GetPlayers() do
			if v and v:GetRankInGroup(scp_group) > 8 then
				table.insert(mods, tostring(v));
				table.insert(teams, tostring(v.Team));
			end;
		end;
		if #mods <= 0 then
			Luna:Notification({
				Title = "Scan finished!";
				Icon  = "check_box";
				ImageSource = "Material";
				Content = "No mods are in the game!"
			});
			return;
		end;		
		local yes: string = "Total number: "..tostring(#mods).." list: "..table.concat(mods, " ").." teams: "..table.concat(teams, " ");
		Luna:Notification({
			Title = "Scan finished!";
			Icon  = "local_police";
			ImageSource = "Material";
			Content = yes;
		});
		return;
	end;
});
Moderation:CreateToggle({
	Name = "Kick when moderator arrives";
	Description= nil;
	CurrentValue = false;
	Callback = @native function(value: boolean): ()
		states.mod_kick = value;
		return;
	end,
});
Moderation:CreateToggle({
	Name = "Notifer";
	Description = "Notifies you when a moderator joinned.";
	CurrentValue = false;
	Callback = @native function(value: boolean): ()
		states.mod_notifer = value;
		return;
	end,
});
Moderation:CreateToggle({
	Name = "Avoid";
	Description = "Changes your team and apperance upon mod arrival.";
	CurrentValue = false;
	Callback = @native function(value: boolean): ()
		states.avoid = value;
		return;
	end,	

});
anti_cheat:CreateLabel({
	Text = "Server side AC bypasses has its downsides. these issues cannot be fixed.";
	Style = 3;
});
anti_cheat:CreateToggle({
	Name = "Bypass Server AC";
	Description = "Fully bypases the server side anti cheat, allowing you to fly and noclip without any problems.";
	CurrentValue = false;
	Callback = @native function(value: boolean): ()
		server_bypass(value);
		states.server_bypass = value;
		return;
	end,
});
anti_cheat:CreateToggle({
	Name = "Bypass Client AC";
	Description = "Bypasses the client AC which detects btools. And other map changes.";
	CurrentValue = false;
	Callback = @native function(value: boolean): ()
		if value then
			for _,v in getgc(false) do
				if type(v) == "function" and islclosure(v) and debug.info(v, "n") == "__exploiterkick" then
					hookfunction(v, newlclosure(function() end));
					break;
				end;
			end;
		else
			for _,v in getgc(false) do
				if type(v) == "function" and islclosure(v) and debug.info(v, "n") == "__exploiterkick" then
					restorefunction(v);
					break;
				end;
			end;
		end;
		return;
	end,
});
Players.PlayerAdded:Connect(@native function(player: Player) 
	if Player and Player:GetRankInGroup(scp_group) > 8  then
		if states.avoid then
			network:InvokeServer("changeClothing", "Skin", 1);
			network:InvokeServer("changeClothing", "Hair", 1);
			network:InvokeServer("changeClothing", "Face", 1);
			network:FireServer("switchTeamMenu", "Janitor");
		end;
		if states.mod_kick then
			Player:Kick("Mod joinned "..tostring(player));
		end;
	end;
	return;
end);
local touchies: {[number]: TouchTransmitter} = {};
for _,v in workspace:GetDescendants() do
	if tostring(v) == "TouchInterest" and tostring(v.Parent) == "Caution" then
		table.insert(touchies, v);    
	end;
end;
Player.CharacterAdded:Connect(function(charec: Model): ()
	char = charec;
	server_bypass(states.server_bypass)
	if states.infinite_run then toggle_run(); end;
	return;
end);
run_service.PreRender:Connect(@native function(deltaTimeRender: number) 
	if states.tesla_spam and Player and Player.Character:FindFirstChild("HumanoidRootPart") then
		for _,v: TouchTransmitter in touchies do
			firetouchinterest(Player.Character.HumanoidRootPart, v.Parent, 0);
			wait();
			firetouchinterest(Player.Character.HumanoidRootPart, v.Parent, 1);
		end;
	end;
	return;
end);
