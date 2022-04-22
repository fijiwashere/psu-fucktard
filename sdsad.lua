local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/WetCheezit/Bracket-V2/main/src.lua"))()
local mt = getrawmetatable(game)
local oldindex = mt.__index
-- Window
local Window, MainGUI = Library:CreateWindow("CatWare")

-- Tabs
local Tab1 = Window:CreateTab("Welcome User!")

local Groupbox1 = Tab1:CreateGroupbox("Visuals", "Left")
local Groupbox2 = Tab1:CreateGroupbox("Aim", "Right")
local Groupbox3 = Tab1:CreateGroupbox("Humanoid", "Left")
local Groupbox5 = Tab1:CreateGroupbox("Misc", "Right")
local Groupbox6 = Tab1:CreateGroupbox("Gun Mods", "Right")
local Groupbox7 = Tab1:CreateGroupbox("Knife Changer", "Left")
local Groupbox4 = Tab1:CreateGroupbox("Support", "Right")
function GetAimPart()
    if Client.Values.AimPart == "Head" then
        return "Head"
    end
    if Client.Values.AimPart == "LowerTorso" then
        return "LowerTorso"
    end
    if Client.Values.AimPart == "Random" then
        if math.random(1, 4) == 1 then
            return "Head"
        else
            return "LowerTorso"
        end
    end
end
function ClosestPlayer()
    local w, y = math.huge
    for c, v in pairs(s.GetPlayers(s)) do
        local z = v.Character.FindFirstChild(v.Character, "Head")
        if z then
            local A, B = r.WorldToScreenPoint(r, z.Position)
            if B then
                local C, D = Vector2.new(u.X, u.Y), Vector2.new(A.X, A.Y)
                local E = (D - C).Magnitude
                if E < w and E <= Client.Values.FOV then
                    w = E
                    y = v
                end
            end
        end
    end
    return y
end
function RandomPlr()
    tempPlrs = {}
    for c, v in pairs(game.Players:GetPlayers()) do
        if
            v and v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and
                v.Team ~= game.Players.LocalPlayer.Team and
                v.Character:FindFirstChild("Spawned")
         then
            table.insert(tempPlrs, v)
        end
    end
    return tempPlrs[math.random(1, #tempPlrs)]
end
function KnifeKill()
    OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local L = math.random() > .6 and true or false
    Target = RandomPlr()
    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(Target.Character.Head.CFrame * CFrame.new(0, 0, 0))
end
Groupbox6:CreateToggle("No recoil", function(value)
for c, v in pairs(game:GetService("ReplicatedStorage").Weapons:GetDescendants()) do
    if v.Name == "RecoilControl" or v.Name == "Recoil" then
        if value == true then
            v.Value = 0
        end
        if value == false then
            v.Value = 1
            end
    end
end
end)
Groupbox6:CreateToggle("Fire Rate", function(value)
    for al, v in pairs(game.ReplicatedStorage.Weapons:GetDescendants()) do
            if v.Name == "FireRate" then
                if value == true then
                    v.Value = 0.02
                end
                if value == false then 
                    v.Value = 1
                    end
            end
        end
end)
Groupbox6:CreateToggle("No Spread", function(value)
    for c, v in pairs(game:GetService("ReplicatedStorage").Weapons:GetDescendants()) do
            if v.Name == "MaxSpread" or v.Name == "Spread" or v.Name == "SpreadControl" then
if value == true then
                    v.Value = 0
end 
if value == false then
    v.Value = 1
    end
        end
end

end)

Groupbox6:CreateButton("Inf Ammo", function(value)
    game:GetService("RunService").Stepped:connect(
            function()
                task.spawn(function()
                            getsenv(game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Functions.Weapons).ammocount.Value =
                                25
                            getsenv(game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Functions.Weapons).ammocount.Value =
                                26
                
                end)
            end 
        )
end)
local ExampleSlider = Groupbox1:CreateSlider("FOV", 10, 1000, 0, function(ffff)
 fov = ffff
end)
local ExampleToggle = Groupbox1:CreateToggle("FOV Circle", function(circlefov)
    circle = circlefov
	local Line = Drawing.new("Circle")
	while circle do wait()
		Line.Color = Color3.fromRGB(18,114,243)
		Line.Visible = true
		Line.Radius = fov
		Line.Thickness = 1
		Line.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
	end
	if circle == false then
		Line.Visible = not Line.Visible
	end
end)
local ExampleToggle = Groupbox1:CreateToggle("Crosshair", function(value)
    
	corss = value
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local Camera = workspace.CurrentCamera

	local Typing = false

	local ViewportSize_ = Camera.ViewportSize / 2
	local Axis_X, Axis_Y = ViewportSize_.X, ViewportSize_.Y

	local HorizontalLine = Drawing.new("Line")
	local VerticalLine = Drawing.new("Line")

	_G.ToMouse = false   -- If set to true then the crosshair will be positioned to your mouse cursor's position. If set to false it will be positioned to the center of your screen.

	_G.CrosshairVisible = true   -- If set to true then the crosshair would be visible and vice versa.
	_G.CrosshairSize = 20   -- The size of the crosshair.
	_G.CrosshairThickness = 1   -- The thickness of the crosshair.
	_G.CrosshairColor = Color3.fromRGB(18,114,243)   -- The color of the crosshair
	_G.CrosshairTransparency = 1   -- The transparency of the crosshair.

	RunService.RenderStepped:Connect(function()
		local Real_Size = _G.CrosshairSize / 2

		HorizontalLine.Color = _G.CrosshairColor
		HorizontalLine.Thickness = _G.CrosshairThickness
		HorizontalLine.Visible = _G.CrosshairVisible
		HorizontalLine.Transparency = _G.CrosshairTransparency

		VerticalLine.Color = _G.CrosshairColor
		VerticalLine.Thickness = _G.CrosshairThickness
		VerticalLine.Visible = _G.CrosshairVisible
		VerticalLine.Transparency = _G.CrosshairTransparency

		if _G.ToMouse == true then
			HorizontalLine.From = Vector2.new(UserInputService:GetMouseLocation().X - Real_Size, UserInputService:GetMouseLocation().Y)
			HorizontalLine.To = Vector2.new(UserInputService:GetMouseLocation().X + Real_Size, UserInputService:GetMouseLocation().Y)

			VerticalLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y - Real_Size)
			VerticalLine.To = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y + Real_Size)
		elseif _G.ToMouse == false then
			HorizontalLine.From = Vector2.new(Axis_X - Real_Size, Axis_Y)
			HorizontalLine.To = Vector2.new(Axis_X + Real_Size, Axis_Y)

			VerticalLine.From = Vector2.new(Axis_X, Axis_Y - Real_Size)
			VerticalLine.To = Vector2.new(Axis_X, Axis_Y + Real_Size)
		end
	end)


	if corss == false then
		_G.CrosshairVisible = false
	end
	end)


local ExampleDropdown = Groupbox2:CreateDropdown("Aimbot Hitbox", {"HumanoidRootPart", "Head"}, function(selected)
	selectedpart = selected
end)

local ExampleToggle = Groupbox2:CreateToggle("Aimbot Normal", function(value)
    aimbotpenis = value
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local mouse = LocalPlayer:GetMouse()
	local Camera = workspace.CurrentCamera
	local Debris = game:GetService("Debris")
	local UserInputService = game:GetService("UserInputService")
	local target = false
	local RunService = game:GetService("RunService")

	local features = {
		silentaim = aimbotpenis;
		fov = fov;
	}
	aimbotpenis = value
	function getnearest()
		local nearestmagnitude = math.huge
		local nearestenemy = nil
		local vector = nil
		for i,v in next, game.Players:GetChildren() do
			if v ~= Players.LocalPlayer then
				if v.Character and  v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
					local vector, onScreen = Camera:WorldToScreenPoint(v.Character["HumanoidRootPart"].Position)
					if onScreen then
						local ray = Ray.new(
							Camera.CFrame.p,
							(v.Character["HumanoidRootPart"].Position-Camera.CFrame.p).unit*500
						)
						local ignore = {
							LocalPlayer.Character,
						}
						local hit,position,normal=workspace:FindPartOnRayWithIgnoreList(ray,ignore)
						if hit and hit:FindFirstAncestorOfClass("Model") and Players:FindFirstChild(hit:FindFirstAncestorOfClass("Model").Name)then
							local magnitude = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
							if magnitude < nearestmagnitude and magnitude <= features["fov"] then
								nearestenemy = v
								nearestmagnitude = magnitude
							end
						end
					end
				end
			end
		end
		return nearestenemy
	end
end)
local ExampleToggle = Groupbox2:CreateToggle("TriggerBot", function(value)
    local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()
game:GetService("RunService").RenderStepped:Connect(function()
			if mouse.Target.Parent:FindFirstChild("Humanoid") and mouse.Target.Parent.Name ~= player.Name then
				mouse1press() wait() mouse1release()
			end
end)end)
local ExampleToggle = Groupbox2:CreateToggle("Aimbot Smoothing", function(value)
    aimbotpenis = value
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local mouse = LocalPlayer:GetMouse()
	local Camera = workspace.CurrentCamera
	local Debris = game:GetService("Debris")
	local UserInputService = game:GetService("UserInputService")
	local target = false
	local RunService = game:GetService("RunService")

	local features = {
		silentaim = aimbotpenis;
		fov = fov;
	}
	aimbotpenis = value
	function getnearest()
		local nearestmagnitude = math.huge
		local nearestenemy = nil
		local vector = nil
        wait(.05)
		for i,v in next, game.Players:GetChildren() do
			if v ~= Players.LocalPlayer then
				if v.Character and  v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
					local vector, onScreen = Camera:WorldToScreenPoint(v.Character["HumanoidRootPart"].Position)
					if onScreen then
						local ray = Ray.new(
							Camera.CFrame.p,
							(v.Character["HumanoidRootPart"].Position-Camera.CFrame.p).unit*500
						)
						local ignore = {
							LocalPlayer.Character,
						}
						local hit,position,normal=workspace:FindPartOnRayWithIgnoreList(ray,ignore)
						if hit and hit:FindFirstAncestorOfClass("Model") and Players:FindFirstChild(hit:FindFirstAncestorOfClass("Model").Name)then
							local magnitude = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
							if magnitude < nearestmagnitude and magnitude <= features["fov"] then
								nearestenemy = v
								nearestmagnitude = magnitude
							end
						end
					end
				end
			end
		end
		return nearestenemy
	end
	end)
local aiming = false
local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(function(penis)
	if penis.UserInputType == Enum.UserInputType.MouseButton2 then
		aiming = true
	end
end)
uis.InputEnded:Connect(function(key)
	if key.UserInputType == Enum.UserInputType.MouseButton2 then
		aiming = false
	end
end)



game:GetService("RunService").RenderStepped:Connect(function()
	if aiming and aimbotpenis == true then
		workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position,getnearest().Character[selectedpart].Position)
	end
end)

local ExampleToggle = Groupbox3:CreateButton("Speed", function(value)
local am = 100
            local an = getrawmetatable(game)
            setreadonly(an, false)
            local ao = an.__index
            an.__index =
                newcclosure(
                function(self, ap)
                    if ap == "WalkSpeed" then
                        return 100
                    end
                    return ao(self, ap)
                end
            )
end)

local ExampleToggle = Groupbox3:CreateToggle("Infinite Jump", function(value)
    	tog = value
	while true do wait()
		game:GetService("UserInputService").JumpRequest:Connect(function()
			if tog == true then
				game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
			end
		end)
	end
end)
Groupbox5:CreateButton("T to Fly", function(value)
        repeat
            wait()
        until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and
            game.Players.LocalPlayer.Character:findFirstChild("Head") and
            game.Players.LocalPlayer.Character:findFirstChild("Humanoid")
        local at = game.Players.LocalPlayer:GetMouse()
        repeat
            wait()
        until at
        local au = game.Players.LocalPlayer
        local av = au.Character.Head
        local aw = false
        local ax = true
        local ay = {f = 0, b = 0, l = 0, r = 0}
        local az = {f = 0, b = 0, l = 0, r = 0}
        local aA = 100
        local aB = 0
        function Fly()
            local aC = Instance.new("BodyGyro", av)
            aC.P = 9e4
            aC.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            aC.cframe = av.CFrame
            local aD = Instance.new("BodyVelocity", av)
            aD.velocity = Vector3.new(0, 0.1, 0)
            aD.maxForce = Vector3.new(9e9, 9e9, 9e9)
            repeat
                wait()
                au.Character.Humanoid.PlatformStand = true
                if ay.l + ay.r ~= 0 or ay.f + ay.b ~= 0 then
                    aB = aB + .5 + aB / aA
                    if aB > aA then
                        aB = aA
                    end
                elseif not (ay.l + ay.r ~= 0 or ay.f + ay.b ~= 0) and aB ~= 0 then
                    aB = aB - 1
                    if aB < 0 then
                        aB = 0
                    end
                end
                if ay.l + ay.r ~= 0 or ay.f + ay.b ~= 0 then
                    aD.velocity =
                        (game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ay.f + ay.b) +
                        game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ay.l + ay.r, (ay.f + ay.b) * .2, 0).p -
                        game.Workspace.CurrentCamera.CoordinateFrame.p) *
                        aB
                    az = {f = ay.f, b = ay.b, l = ay.l, r = ay.r}
                elseif ay.l + ay.r == 0 and ay.f + ay.b == 0 and aB ~= 0 then
                    aD.velocity =
                        (game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (az.f + az.b) +
                        game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(az.l + az.r, (az.f + az.b) * .2, 0).p -
                        game.Workspace.CurrentCamera.CoordinateFrame.p) *
                        aB
                else
                    aD.velocity = Vector3.new(0, 0.1, 0)
                end
                aC.cframe =
                    game.Workspace.CurrentCamera.CoordinateFrame *
                    CFrame.Angles(-math.rad((ay.f + ay.b) * 50 * aB / aA), 0, 0)
            until not aw
            ay = {f = 0, b = 0, l = 0, r = 0}
            az = {f = 0, b = 0, l = 0, r = 0}
            aB = 0
            aC:Destroy()
            aD:Destroy()
            au.Character.Humanoid.PlatformStand = false
        end
        at.KeyDown:connect(
            function(aE)
                if aE:lower() == "t" then
                    if aw then
                        aw = false
                    else
                        aw = true
                        Fly()
                    end
                elseif aE:lower() == "w" then
                    ay.f = 1
                elseif aE:lower() == "s" then
                    ay.b = -1
                elseif aE:lower() == "a" then
                    ay.l = -1
                elseif aE:lower() == "d" then
                    ay.r = 1
                end
            end
        )
        at.KeyUp:connect(
            function(aE)
                if aE:lower() == "w" then
                    ay.f = 0
                elseif aE:lower() == "s" then
                    ay.b = 0
                elseif aE:lower() == "a" then
                    ay.l = 0
                elseif aE:lower() == "d" then
                    ay.r = 0
                end
            end
        )
        Fly()
end)
local thubgg = Groupbox5:CreateToggle("Third Person", function(value)
         if value == true then
            game:GetService("Players")["LocalPlayer"].PlayerGui.GUI.Client.Variables.thirdperson.Value = true
        else
            game:GetService("Players")["LocalPlayer"].PlayerGui.GUI.Client.Variables.thirdperson.Value = false
        end   
end)
local Example = Groupbox3:CreateButton("Reset", function(value)
    	game.Players.LocalPlayer.Character.Humanoid.Health = 0
    
end)

local Example = Groupbox4:CreateButton("Copy discord link!", function(value)
    setclipboard("https://discord.gg/MfGB5dUD")
end)
local ESP = "https://raw.githubusercontent.com/Pawel12d/hexagon/main/scripts/ESP.lua"
local ExampleToggle = Groupbox1:CreateToggle("ESP", function(espthig)
	esptog = espthig
	local ESP = loadstring(game:HttpGet("https://pastebin.com/raw/YAv2dt1y"))()
	while wait() do
		if esptog  == true then
			ESP:Toggle(true)
		else
			ESP:Toggle(false)
		end
	end
end)
local fov = Groupbox1:CreateSlider("Screen FOV",10,120,0, function(value)
            game:GetService("Players").LocalPlayer.Settings.FOV.Value = value
end)
Groupbox5:CreateButton("TP to Random", function(value)
KnifeKill()
end)
Groupbox5:CreateButton("Fast Heal", function()
    while game.RunService.RenderStepped:Wait() do
            pcall(
                function()
                    if game.Players.LocalPlayer.Character then
                        if game.Players.LocalPlayer.NRPBS.Health.Value <= 99 then
                            if game.Players.LocalPlayer.Character:FindFirstChild("Spawned") then
                                for al, v in pairs(game.Workspace.Debris:GetChildren()) do
                                    if v.Name == "DeadHP" then
                                        v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                        v.Transparency = 1
                                    end
                                end
                                local aq = {
                                    [1] = game:GetService("ReplicatedStorage").Weapons["Stake Launcher"],
                                    [2] = "Rolled!"
                                }
                                game:GetService("ReplicatedStorage").Events.ApplyGun:FireServer(unpack(aq))
                                game.ReplicatedStorage.Events.HealBoy:FireServer(
                                    game.Players.LocalPlayer.Character.HumanoidRootPart
                                )
                                local aq = {
                                    [1] = game.Players.LocalPlayer.PlayerGui.GUI.Client.Variables.gun.Value,
                                    [2] = "Rolled!"
                                }
                                game:GetService("ReplicatedStorage").Events.ApplyGun:FireServer(unpack(aq))
                                wait(0.1)
                            end
                        end
                    end
                end
            )
        end
end)
local rainbow = Groupbox6:CreateButton("Rainbow Gun", function(value)
local a0 = 1
function zigzag(ci)
     return math.acos(math.cos(ci * math.pi)) / math.pi
 end
game:GetService("RunService").RenderStepped:Connect(
    function()
        if game.Workspace.Camera:FindFirstChild("Arms") then
            for c, v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do
                if v.ClassName == "MeshPart" then
                            v.Color = Color3.fromHSV(zigzag(a0), 1, 1)
                            a0 = a0 + .0001
                        end
                    end
                end
            end
        )
end)
trans = Groupbox6:CreateButton("Gun Transparency", function(value)
local a0 = 1
function zigzag(ci)
     return math.acos(math.cos(ci * math.pi)) / math.pi
 end
game:GetService("RunService").RenderStepped:Connect(
    function()
        if game.Workspace.Camera:FindFirstChild("Arms") then
            for c, v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do
                if v.ClassName == "MeshPart" then
                            v.Transparency = 0.5
                        end
                    end
                end
            end
        )
end)
trans = Groupbox6:CreateButton("Gun Neon", function(value)
local a0 = 1
function zigzag(ci)
     return math.acos(math.cos(ci * math.pi)) / math.pi
 end
game:GetService("RunService").RenderStepped:Connect(
    function()
        if game.Workspace.Camera:FindFirstChild("Arms") then
            for c, v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do
                if v.ClassName == "MeshPart" then
                            v.Material = "Neon"
                        end
                    end
                end
            end
        )
end)
trans = Groupbox6:CreateButton("Invisible Tools", function(value)
local a0 = 1
function zigzag(ci)
     return math.acos(math.cos(ci * math.pi)) / math.pi
 end
game:GetService("RunService").RenderStepped:Connect(
    function()
        if game.Workspace.Camera:FindFirstChild("Arms") then
            for c, v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do
                if v.ClassName == "MeshPart" then
                            v:Destroy()
                        end
                    end
                end
            end
        )
end)
trans = Groupbox6:CreateButton("Fabric Hands", function(value)
local a0 = 1
function zigzag(ci)
     return math.acos(math.cos(ci * math.pi)) / math.pi
 end
game:GetService("RunService").RenderStepped:Connect(
    function()
        if game.Workspace.Camera:FindFirstChild("Arms") then
            for c, v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do
                if v.ClassName == "SpecialMesh" then
                            v:Destroy()
                        end
                    end
                end
    end
        )
end)

Groupbox7:CreateButton("Karambit", function(value)
loadstring(game:HttpGet("https://pastebin.com/raw/XdmqfAhL"))()
end)
Groupbox7:CreateButton("Butterfly", function(value)
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Butterfly Knife"].Name = "v_Dagger"
end)
Groupbox7:CreateButton("Venomshank", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_The Venomshank"].Name = "v_Dagger"
end)
Groupbox7:CreateButton("Illumina", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_The Illumina"].Name = "v_Dagger"
end)
Groupbox7:CreateButton("Frog", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Frog"].Name = "v_Dagger"
end)
Groupbox7:CreateButton("Battle Axe", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Battle Axe"].Name = "v_Dagger"
end)
Groupbox7:CreateButton("Moderation Hammer", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Moderation Hammer"].Name = "v_Dagger"
end)
Groupbox7:CreateButton("Ban Hammer", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Ban Hammer"].Name = "v_Dagger"
end)
Groupbox7:CreateButton("Fish", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Fish"].Name = "v_Dagger"
end)
Groupbox7:CreateButton("Space Katana", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Space Katana"].Name = "v_Dagger"  
end)
Groupbox7:CreateButton("Scythe", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Scythe"].Name = "v_Dagger"
end)
Groupbox7:CreateButton("Claws", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Claws"].Name = "v_Dagger"
end)
Groupbox7:CreateButton("Classic Sword", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Classic Sword"].Name = "v_Dagger"
end)
Groupbox7:CreateButton("Tomahawk", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Tomahawk"].Name = "v_Dagger"
end)
Groupbox7:CreateButton("Tactical Knife", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Tactical Knife"].Name = "v_Dagger"
end)
Groupbox7:CreateButton("Katana", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Katana"].Name = "v_Dagger" 
end)
Groupbox7:CreateButton("Banana", function()
game:GetService("ReplicatedStorage").Viewmodels["v_Dagger"].Name = "Test"
game:GetService("ReplicatedStorage").Viewmodels["v_Banana"].Name = "v_Dagger"
end)







 while true do
    wait(0.1)
    function Message(aZ)
        if not aZ then
            return false
        end
        x = game:GetService("Players").LocalPlayer.PlayerGui.Menew.Main.LAZYBUTTON
        x.Visible = true
        x.Text = "\240\159\147\162" .. aZ
    end
    Message("https://discord.gg/MfGB5dUD")
end








