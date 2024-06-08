library = {flags={},items={}};
library.theme = {fontsize=15,titlesize=20,font=Enum.Font.Code,background="rbxassetid://5553946656",tilesize=50,cursor=false,cursorimg="https://t0.rbxcdn.com/42f66da98c40252ee151326a82aab51f",backgroundcolor=Color3.fromRGB(20, 20, 20),tabstextcolor=Color3.fromRGB(240, 240, 240),bordercolor=Color3.fromRGB(60, 60, 60),accentcolor=Color3.fromRGB(255, 0, 0),accentcolor2=Color3.fromRGB(255, 0, 0),outlinecolor=Color3.fromRGB(60, , 60),outlinecolor2=Color3.fromRGB(0, 0, 0),sectorcolor=Color3.fromRGB(30, 30, 30),toptextcolor=Color3.fromRGB(255, 0, 0),topheight=48,dpScrollBarThickness=10,topcolor=Color3.fromRGB(30, 30, 30),topcolor2=Color3.fromRGB(15, 15, 15),buttoncolor=Color3.fromRGB(49, 49, 49),buttoncolor2=Color3.fromRGB(39, 39, 39),itemscolor=Color3.fromRGB(200, 200, 200),itemscolor2=Color3.fromRGB(210, 210, 210)};
if (_G.Color == nil) then
	_G.Color = Color3.fromRGB(255, 0, 0);
end
if (_G.Color2 == nil) then
	_G.Color2 = Color3.fromRGB(255, 0, 0);
end
local players = game:GetService("Players");
local uis = game:GetService("UserInputService");
local runservice = game:GetService("RunService");
local tweenservice = game:GetService("TweenService");
local marketplaceservice = game:GetService("MarketplaceService");
local textservice = game:GetService("TextService");
local coregui = game:GetService("Players").LocalPlayer.PlayerGui
local httpservice = game:GetService("HttpService");
local player = players.LocalPlayer;
local mouse = player:GetMouse();
local camera = game.Workspace.CurrentCamera;
local function RainbowText(text)
	spawn(function()
		local add = 10;
		wait(0.1);
		local k = 1;
		while k <= 255 do
			text.TextColor3 = Color3.new(k / 255, NaN, NaN);
			k = k + add;
			wait();
		end
		while true do
			k = 1;
			while k <= 255 do
				text.TextColor3 = Color3.new(255 / 255, k / 255, NaN);
				k = k + add;
				wait();
			end
			k = 1;
			while k <= 255 do
				text.TextColor3 = Color3.new((255 / 255) - (k / 255), 255 / 255, NaN);
				k = k + add;
				wait();
			end
			k = 1;
			while k <= 255 do
				text.TextColor3 = Color3.new(NaN, 255 / 255, k / 255);
				k = k + add;
				wait();
			end
			k = 1;
			while k <= 255 do
				text.TextColor3 = Color3.new(NaN, (255 / 255) - (k / 255), 255 / 255);
				k = k + add;
				wait();
			end
			k = 1;
			while k <= 255 do
				text.TextColor3 = Color3.new(k / 255, NaN, 255 / 255);
				k = k + add;
				wait();
			end
			k = 1;
			while k <= 255 do
				text.TextColor3 = Color3.new(255 / 255, NaN, (255 / 255) - (k / 255));
				k = k + add;
				wait();
			end
			while k <= 255 do
				text.TextColor3 = Color3.new((255 / 255) - (k / 255), NaN, NaN);
				k = k + add;
				wait();
			end
		end
	end);
end
if (library.theme.cursor and Drawing) then
	local success = pcall(function()
		library.cursor = Drawing.new("Image");
		library.cursor.Data = game:HttpGet(library.theme.cursorimg);
		library.cursor.Size = Vector2.new(64, 64);
		library.cursor.Visible = uis.MouseEnabled;
		library.cursor.Rounding = 0;
		library.cursor.Position = Vector2.new(mouse.X - 32, mouse.Y + 6);
	end);
	if (success and library.cursor) then
		uis.InputChanged:Connect(function(input)
			if uis.MouseEnabled then
				if (input.UserInputType == Enum.UserInputType.MouseMovement) then
					library.cursor.Position = Vector2.new(input.Position.X - 32, input.Position.Y + 7);
				end
			end
		end);
		game:GetService("RunService").RenderStepped:Connect(function()
			uis.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide;
			library.cursor.Visible = uis.MouseEnabled and (uis.MouseIconEnabled or game:GetService("GuiService").MenuIsOpen);
		end);
	elseif (not success and library.cursor) then
		library.cursor:Remove();
	end
end
library.ConfigSystem = function(self, name)
	if not isfolder("!SLH_Hub") then
		makefolder("!SLH_Hub");
	end
	local configSystem = {};
	configSystem.configFolder = "!SLH_Hub/" .. tostring(game.Players.LocalPlayer.Name) .. "";
	if not isfolder(configSystem.configFolder) then
		makefolder(tostring(configSystem.configFolder));
	end
	if not isfile(configSystem.configFolder .. "/" .. name .. ".txt") then
		writefile(configSystem.configFolder .. "/" .. name .. ".txt", "[]");
	end
	configSystem.Load = function(self)
		local Success = pcall(readfile, configSystem.configFolder .. "/" .. name .. ".txt");
		if Success then
			pcall(function()
				local ReadConfig = httpservice:JSONDecode(readfile(configSystem.configFolder .. "/" .. name .. ".txt"));
				local NewConfig = {};
				for i, v in pairs(ReadConfig) do
					if (typeof(v) == "table") then
						if (typeof(v[1]) == "number") then
							NewConfig[i] = Color3.new(v[1], v[2], v[3]);
						elseif (typeof(v[1]) == "table") then
							NewConfig[i] = v[1];
						end
					elseif (tostring(v):find("Enum.KeyCode.")) then
						NewConfig[i] = Enum.KeyCode[tostring(v):gsub("Enum.KeyCode.", "")];
					else
						NewConfig[i] = v;
					end
				end
				library.flags = NewConfig;
				for i, v in pairs(library.flags) do
					for i2, v2 in pairs(library.items) do
						if ((i ~= nil) and (i ~= "") and (i ~= "Configs_Name") and (i ~= "Configs") and (v2.flag ~= nil)) then
							if (v2.flag == i) then
								pcall(function()
									v2:Set(v);
									print(v2.flag, v);
								end);
							end
						end
					end
				end
			end);
		end
	end;
	configSystem.Save = function(self)
		config = {};
		for i, v in pairs(library.flags) do
			if ((v ~= nil) and (v ~= "")) then
				if (typeof(v) == "Color3") then
					config[i] = {v.R,v.G,v.B};
				elseif (tostring(v):find("Enum.KeyCode")) then
					config[i] = "Enum.KeyCode." .. v.Name;
				elseif (typeof(v) == "table") then
					config[i] = {v};
				else
					config[i] = v;
				end
			end
		end
		writefile(configSystem.configFolder .. "/" .. name .. ".txt", httpservice:JSONEncode(config));
	end;
	return configSystem;
end;
local UserInputService = game:GetService("UserInputService");
local function MakeDraggable(topbarobject, object)
	local Dragging = nil;
	local DragInput = nil;
	local DragStart = nil;
	local StartPosition = nil;
	local function Update(input)
		local Delta = input.Position - DragStart;
		local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y);
		object.Position = pos;
	end
	topbarobject.InputBegan:Connect(function(input)
		if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
			Dragging = true;
			DragStart = input.Position;
			StartPosition = object.Position;
			input.Changed:Connect(function()
				if (input.UserInputState == Enum.UserInputState.End) then
					Dragging = false;
				end
			end);
		end
	end);
	topbarobject.InputChanged:Connect(function(input)
		if ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch)) then
			DragInput = input;
		end
	end);
	UserInputService.InputChanged:Connect(function(input)
		if ((input == DragInput) and Dragging) then
			Update(input);
		end
	end);
end
library.CreateWatermark = function(self, name)
	local gamename = marketplaceservice:GetProductInfo(game.PlaceId).Name;
	local watermark = {};
	watermark.Visible = true;
	watermark.text = " " .. name:gsub("{game}", gamename):gsub("{fps}", "0 FPS") .. " ";
	watermark.main = Instance.new("ScreenGui", coregui);
	watermark.main.Name = "Watermark";
	if syn then
		syn.protect_gui(watermark.main);
	end
	if getgenv().watermark then
		getgenv().watermark:Remove();
	end
	getgenv().watermark = watermark.main;
	watermark.mainbar = Instance.new("Frame", watermark.main);
	watermark.mainbar.Name = "Main";
	watermark.mainbar.BorderColor3 = Color3.fromRGB(80, 80, 80);
	watermark.mainbar.Visible = watermark.Visible;
	watermark.mainbar.BorderSizePixel = 0;
	watermark.mainbar.ZIndex = 5;
	watermark.mainbar.Position = UDim2.new(0, 1, 0, 1);
	watermark.mainbar.Size = UDim2.new(0, 0, 0, 25);
	watermark.Gradient = Instance.new("UIGradient", watermark.mainbar);
	watermark.Gradient.Rotation = 90;
	watermark.Gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))});
	watermark.Outline = Instance.new("Frame", watermark.mainbar);
	watermark.Outline.Name = "outline";
	watermark.Outline.ZIndex = 4;
	watermark.Outline.BorderSizePixel = 0;
	watermark.Outline.Visible = watermark.Visible;
	watermark.Outline.BackgroundColor3 = library.theme.outlinecolor;
	watermark.Outline.Position = UDim2.fromOffset(-1, -1);
	watermark.BlackOutline = Instance.new("Frame", watermark.mainbar);
	watermark.BlackOutline.Name = "blackline";
	watermark.BlackOutline.ZIndex = 3;
	watermark.BlackOutline.BorderSizePixel = 0;
	watermark.BlackOutline.BackgroundColor3 = library.theme.outlinecolor2;
	watermark.BlackOutline.Visible = watermark.Visible;
	watermark.BlackOutline.Position = UDim2.fromOffset(-2, -2);
	watermark.label = Instance.new("TextLabel", watermark.mainbar);
	watermark.label.Name = "FPSLabel";
	watermark.label.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	watermark.label.BackgroundTransparency = 1;
	watermark.label.Position = UDim2.new(0, 0, 0, 0);
	watermark.label.Size = UDim2.new(0, 238, 0, 25);
	watermark.label.Font = library.theme.font;
	watermark.label.ZIndex = 6;
	watermark.label.Visible = watermark.Visible;
	watermark.label.Text = watermark.text;
	watermark.label.TextColor3 = Color3.fromRGB(255, 255, 255);
	watermark.label.TextSize = 15;
	watermark.label.TextStrokeTransparency = 0;
	watermark.label.TextXAlignment = Enum.TextXAlignment.Left;
	watermark.label.Size = UDim2.new(0, watermark.label.TextBounds.X + 10, 0, 25);
	watermark.topbar = Instance.new("Frame", watermark.mainbar);
	watermark.topbar.Name = "TopBar";
	watermark.topbar.ZIndex = 6;
	watermark.topbar.BackgroundColor3 = library.theme.accentcolor;
	watermark.topbar.BorderSizePixel = 0;
	watermark.topbar.Visible = watermark.Visible;
	watermark.topbar.Size = UDim2.new(0, 0, 0