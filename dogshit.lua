local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("Imperial (CSU Gui)", "Ocean")
    local Tab = Window:NewTab("General")
    local Tab_1 = Window:NewTab("Aimlock")
    local Tab_2 = Window:NewTab("Other")
    local Tab_3 = Window:NewTab("Combat")
    local Tab_4 = Window:NewTab('Camera')
    local Section = Tab:NewSection("General")
    local Aimbot_Section = Tab_1:NewSection("Aimbot")
    local misc = Tab_2:NewSection("Other")
    local Combat = Tab_3:NewSection("Combat")
    local Camera = Tab_4:NewSection('Camlock')
    local CCamera = Tab_4:NewSection('CurrentCamera')
    local Tab_5 = Window:NewTab('Settings')
    local LocalPlayer_Settings = Tab_5:NewSection('LocalPlayer Settings')
    local Tab_6 = Window:NewTab('Server');
    local Server = Tab_6:NewSection('Server')
    local FreeCam = Tab_4:NewSection('Free Cam')
    local Tab_7 = Window:NewTab('Anti Aim')
    local AntiAims = Tab_7:NewSection('Anti Aims')
    local Annoy = Tab_3:NewSection("Annoy")
    local VoidSection = Tab_2:NewSection('Void')
    local Heal_GetTools = Tab_2:NewSection('Get Tools / Heal')
    local BlinkSection = Tab_2:NewSection('Blink')
    local LookATSection = Tab_2:NewSection('LookAt')


    getgenv().AIRWALK = false

    function AirWalk()

    local air = Instance.new("Part", workspace)
    air.Size = Vector3.new(7, 2, 3)
    air.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -4, 0)
    air.Transparency = 1
    air.Anchored = true
    air.Name = "Airwalk"

    for i = 1, math.huge do
	    wait(.1)
	       air.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -4, 0)

    end
    end

    function UnAirwalk()
	    for i, v in pairs(workspace:GetChildren()) do
		    if tostring(v) == "Airwalk" then v:Destroy() end
	    end
    end

    
    getgenv().Pipespam = false

    function SendNotification(Title, Text, Length)
	    game.StarterGui:SetCore('SendNotification', {Title = Title; Text = Text; Icon = nil; Duration = Length })
    end

    local function ChatSpy()
	    local StarterGui = game:GetService("StarterGui")
	    repeat wait() until StarterGui:GetCore("ChatWindowSize") ~= nil
	    local chatWindowSize = StarterGui:GetCore("ChatWindowSize")
	    StarterGui:SetCore("ChatWindowPosition", UDim2.new(0, 0, 0.414965987, 0))
	    local enabled = true
	    local spyOnMyself = true
	    local public = false
	    local publicItalics = false

	    local StarterGui = game:GetService("StarterGui")
	    local Players = game:GetService("Players")
	    local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or game.Players.LocalPlayer
	    local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
	    local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
	    local instance = (_G.chatSpyInstance or 0) + 1
	    _G.chatSpyInstance = instance

	    local function onChatted(p,msg)
		    if _G.chatSpyInstance == instance then
			    if p==player and msg:lower():sub(1,4)=="/spy" then
				    enabled = not enabled
				    wait()
				    StarterGui:SetCore("ChatMakeSystemMessage")
			    elseif enabled and (spyOnMyself==true or p~=player) then
				    msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
				    local hidden = true
				    local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
					    if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and public==false and Players[packet.FromSpeaker].Team==player.Team)) then
						    hidden = false
					    end
				    end)
				    wait(1)
				    conn:Disconnect()
			    end
		    end
	    end

	    for _,p in ipairs(Players:GetPlayers()) do
		    p.Chatted:Connect(function(msg) onChatted(p,msg) end)
	    end
	    Players.PlayerAdded:Connect(function(p)
		    p.Chatted:Connect(function(msg) onChatted(p,msg) end)
	    end)
	    StarterGui:SetCore("ChatMakeSystemMessage")
	    if not player.PlayerGui:FindFirstChild("Chat") then wait(3) end
	    local chatFrame = player.PlayerGui.Chat.Frame
	    chatFrame.ChatChannelParentFrame.Visible = true
	    chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
    end
    ChatSpy()

    local FLYING = false
    local mouse = game.Players.LocalPlayer:GetMouse()
    local WHeld = false
    local SHeld = false
    local AHeld = false
    local DHeld = false
    local flying = false
    local flyspeed = 3

    local function togglefly()
	    flying = true
	    if flying then
		    if game.Players.LocalPlayer.Character ~= nil then
			    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then

				    local Float = Instance.new('Part', game.Players.LocalPlayer.Character)
				    Float.Name = "Float"
				    Float.Transparency = 1
				    Float.Size = Vector3.new(6,1,6)
				    Float.Anchored = true
				    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
				    local T = game.Players.LocalPlayer.Character.HumanoidRootPart
				    local CONTROL = {F = 0, B = 0, L = 0, R = 0}
				    local lCONTROL = {F = 0, B = 0, L = 0, R = 0}
				    local SPEED = 0
				    local function FLY()
					    FLYING = true
					    local BG = Instance.new('BodyGyro', T)
					    local BV = Instance.new('BodyVelocity', T)
					    BG.P = 9e4
					    BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
					    BG.cframe = T.CFrame
					    BV.velocity = Vector3.new(0, 0.1, 0)
					    BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
					    spawn(function()
						    repeat wait()
							    if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 then
								    SPEED = 50
							    elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and SPEED ~= 0 then
								    SPEED = 0
							    end
							    if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 then
								    BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
								    lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
							    elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and SPEED ~= 0 then
								    BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.LookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
							    else
								    BV.velocity = Vector3.new(0, 0.1, 0)
							    end
							    BG.cframe = workspace.CurrentCamera.CoordinateFrame
						    until not FLYING
						    CONTROL = {F = 0, B = 0, L = 0, R = 0}
						    lCONTROL = {F = 0, B = 0, L = 0, R = 0}
						    SPEED = 0
						    BG:destroy()
						    BV:destroy()
					    end)
				    end
				    mouse.KeyDown:connect(function(KEY)
					    if KEY:lower() == 'w' then
						    CONTROL.F = flyspeed

					    elseif KEY:lower() == 's' then
						    CONTROL.B = -flyspeed

					    elseif KEY:lower() == 'a' then
						    CONTROL.L = -flyspeed

					    elseif KEY:lower() == 'd' then
						    CONTROL.R = flyspeed

					    end
				    end)
				    mouse.KeyUp:connect(function(KEY)
					    if KEY:lower() == 'w' then
						    CONTROL.F = 0
					    elseif KEY:lower() == 's' then
						    CONTROL.B = 0
					    elseif KEY:lower() == 'a' then
						    CONTROL.L = 0
					    elseif KEY:lower() == 'd' then
						    CONTROL.R = 0
					    end
				    end)
				    FLY()
				    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
			    elseif game.Players.LocalPlayer.Character:FindFirstChild("Torso") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
				    local Float = Instance.new('Part', game.Players.LocalPlayer.Character)
				    Float.Name = "Float"
				    Float.Transparency = 1
				    Float.Size = Vector3.new(6,1,6)
				    Float.Anchored = true
				    LocalP.Character.Torso.Anchored = true
				    local T = game.Players.LocalPlayer.Character.Torso
				    local CONTROL = {F = 0, B = 0, L = 0, R = 0}
				    local lCONTROL = {F = 0, B = 0, L = 0, R = 0}
				    local SPEED = 0
				    local function FLY()
					    FLYING = true
					    local BG = Instance.new('BodyGyro', T)
					    local BV = Instance.new('BodyVelocity', T)
					    BG.P = 9e4
					    BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
					    BG.cframe = T.CFrame
					    BV.velocity = Vector3.new(0, 0.1, 0)
					    BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
					    spawn(function()
						    repeat wait()
							    if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 then
								    SPEED = 50
							    elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and SPEED ~= 0 then
								    SPEED = 0
							    end
							    if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 then
								    BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
								    lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
							    elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and SPEED ~= 0 then
								    BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
							    else
								    BV.velocity = Vector3.new(0, 0.1, 0)
							    end
							    BG.cframe = workspace.CurrentCamera.CoordinateFrame
						    until not FLYING
						    CONTROL = {F = 0, B = 0, L = 0, R = 0}
						    lCONTROL = {F = 0, B = 0, L = 0, R = 0}
						    SPEED = 0
						    BG:destroy()
						    BV:destroy()
					    end)
				    end
				    mouse.KeyDown:connect(function(KEY)
					    if KEY:lower() == 'w' then
						    CONTROL.F = flyspeed

					    elseif KEY:lower() == 's' then
						    CONTROL.B = -flyspeed

					    elseif KEY:lower() == 'a' then
						    CONTROL.L = -flyspeed

					    elseif KEY:lower() == 'd' then
						    CONTROL.R = flyspeed

					    end
				    end)
				    mouse.KeyUp:connect(function(KEY)
					    if KEY:lower() == 'w' then
						    CONTROL.F = 0
					    elseif KEY:lower() == 's' then
						    CONTROL.B = 0
					    elseif KEY:lower() == 'a' then
						    CONTROL.L = 0
					    elseif KEY:lower() == 'd' then
						    CONTROL.R = 0
					    end
				    end)
				    FLY()
				    game.Players.LocalPlayer.Character.Torso.Anchored = false

				    repeat wait() 					    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
				    until not game.Players.LocalPlayer.Character.Humanoid
			    end
		    end
	    else
		    if game.Players.LocalPlayer.Character.Character then
			    if game.Players.LocalPlayer.Character.Character:FindFirstChild("Float") then
				    game.Players.LocalPlayer.Character.Character:FindFirstChild("Float"):Destroy()
			    end
		    end
		    FLYING = false
	    end
    end

    Section:NewButton('Bypass (TP Bypass)', 'Bypasses tp', function()
    local LP = game.Players.LocalPlayer
    local Character = LP.Character
    local NormalGravity = 196.2
    local Raw = getrawmetatable(game)
    setreadonly(Raw, false)

    local newcclosure, getnamecallmethod, checkcaller, getcaller = newcclosure, getnamecallmethod, checkcaller, getcallingscript
    local ACFlags, INFlags = {
	    'JumpPower','Gravity', 'HipHeight', 'Health', 'BodyVelocity', 'WalkSpeed', 'BodyPosition', 'BodyThrust', 'BodyAngularVelocity'

    }, {
	    'bv', 'hb', 'jp', 'hh', 'ws'
    }

    local NewIndex, NameCall; do
	    local IsA, IsDescendantOf = game.IsA, game.IsDescendantOf
	    local tfind = table.find

	    local unpack = unpack

	    local StarterGui = game:GetService'StarterGui'
	    local SetCore = StarterGui.SetCore

	    local NewIndexFunc = function(self, Key, Value)
		    if not checkcaller() then
			    if IsA(self, 'Humanoid') then
				    SetCore(StarterGui, 'ResetButtonCallback', true)

				    if tfind(ACFlags, Key) then
					    return nil
				    end
			    end
			    if self == workspace and Key == 'Gravity' then
				    return NormalGravity
			    end
			    if Key == 'CFrame' and IsDescendantOf(self, LP.Character) then
				    return 0,0,0
			    end
		    end
		    return NewIndex(self, Key, Value)
	    end

	    local NameCallFunc = function(self, ...)
		    local Method = getnamecallmethod()
		    local Args = {...}


		    if Method == 'BreakJoints' and self == LP.Character then
			    return wait(9e9)
		    end
		    if Method == 'FireServer' then
			    if tfind(ACFlags, Args[1]) then
				    return wait(9e9)
			    end
			    local Name = self.Name
			    if Name == 'Input' then
				    if tfind(INFlags, Args[1]) then
					    return wait(9e9)
				    end
			    end
			    if self.Parent == game.ReplicatedStorage or Args[1] == 'hey' and Name ~= 'SayMessageRequest' then
				    return wait(9e9)
			    end
			    if Args[1] == 'play' then
				    PlayOnDeath = Args[2]
			    elseif Args[1] == 'stop' then
				    PlayOnDeath = nil
			    end
		    end
		    return NameCall(self, unpack(Args))
	    end

	    if syn then
		    NewIndex = hookmetamethod(game, '__newindex', newcclosure(NewIndexFunc))
		    NameCall = hookmetamethod(game, '__namecall', newcclosure(NameCallFunc))
	    else
		    NewIndex = hookfunction(Raw.__newindex, newcclosure(NewIndexFunc))
		    NameCall = hookfunction(Raw.__namecall, newcclosure(NameCallFunc))
	    end
    end
    end)

    Section:NewToggle("Pipe Aura", "Spam Remotes of Pipe", function(Tog)
	    if Tog then
		    if not Pipespam then Pipespam = true end
		    while wait() do
			    pcall(function()
				    if not Pipespam then return end
				    game:GetService("Players").LocalPlayer.Backpack.ServerTraits.Touch:FireServer(game:GetService("Players").LocalPlayer.Character.Pipe,game:GetService("Players").LocalPlayer.Character.Pipe.Handle,true,true)
			    end)
		    end
	    elseif not Tog then
		    if Pipespam then Pipespam = false end
	    end
    end)

    function findplr(plr)
	    for i, v in ipairs(game.Players:GetPlayers()) do
		    if string.find(v.Name:lower(), plr:lower()) then
			    return v.Name
		    elseif string.find(v.DisplayName:lower(), plr:lower()) then
			    return v.Name
		    end
	    end
    end

    getgenv().annoying = false
    getgenv().AnnoyTarget = ""

    function PBot_Function(Ptarget)
	    if game.Players.LocalPlayer and game.Players.LocalPlayer.Backpack and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Backpack:FindFirstChild("Pipe") then wait(.4) game.Players.LocalPlayer.Backpack.Pipe.Parent = game.Players.LocalPlayer.Character else print("Already Equipped Or No Char") end
	    if game.Players.LocalPlayer and game.Players.LocalPlayer.Backpack and game.Players.LocalPlayer.Backpack.ServerTraits and game.Players.LocalPlayer.Character:FindFirstChild'Pipe' then game.Players.LocalPlayer.Backpack.ServerTraits.Finish:FireServer(game.Players.LocalPlayer.Character.Pipe) else print'NotFound These Args' end
	    if game.Players.LocalPlayer and game.Players.LocalPlayer.Backpack and game.Players.LocalPlayer.Backpack.ServerTraits and game.Players.LocalPlayer.Character:FindFirstChild('Pipe') then game.Players.LocalPlayer.Backpack.ServerTraits.Touch:FireServer(game.Players.LocalPlayer.Character.Pipe, game.Players.LocalPlayer.Character.Pipe.Handle, true, true) else print'Not Found These Args' end
	    if game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild('KO') then game.Players.LocalPlayer.Character.KO:Destroy() else print'KO Not Found' end
	    if game.Players.LocalPlayer and game.Players.LocalPlayer.Character and not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild('BodyGyro') and not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild('BodyVelocity') then 			togglefly() AirWalk()
	    else print('Flying = true , Airwalk = true') end
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[Ptarget].Character.Torso.CFrame + game.Players[Ptarget].Character.Torso.Velocity/pipebotvelocity
    end

    Annoy:NewToggle("Toggle Annoy", "Toggles' annoy. Pretty self explanatory.", function(state)
	    if state then
		    print("Annoy On")
		    if not annoying then annoying = true end
	    elseif not state then
		    if annoying then annoying = false end
		    print("Annoy Off")
	    end
    end)



    Annoy:NewTextBox("Annoy Target", "Follows your target anywhere.", function(txt)
	    local target = findplr(txt)
	    AnnoyTarget = tostring(target)
	    while wait() do
		    pcall(function()
			    if not annoying then return end

			    game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').RootPart.CFrame = game.Players[AnnoyTarget].Character.Humanoid.RootPart.CFrame
		    end)
	    end
    end)


    getgenv().autoRe = false




    Section:NewButton("animerun", "game pass run animation ", function()

	    game.Players.LocalPlayer.Character.Humanoid.Health = 0
	    local RunReplacementAnimation = Instance.new("Animation")
	    RunReplacementAnimation.AnimationId = "rbxassetid://9863704959"
	    local NameCall
	    function OnNameCall(self, ...)
		    local Arguments = {...}
		    local Caller, Method = checkcaller(), getnamecallmethod()
		    if not Caller then
			    if Method == "LoadAnimation" then
				    local A = Arguments[1]
				    if tostring(A) == "Run" then
					    Arguments[1] = RunReplacementAnimation
				    end
			    end
		    end
		    return NameCall(self, unpack(Arguments))
	    end
	    NameCall = hookmetamethod(game, "__namecall", OnNameCall)
    end)



    Section:NewButton("Anti Lag / Better FPS", "useful for laggy fps", function()
	    local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
	    local g = game
	    local w = g.Workspace
	    local l = g.Lighting
	    local t = w.Terrain
	    t.WaterWaveSize = 0
	    t.WaterWaveSpeed = 0
	    t.WaterReflectance = 0
	    t.WaterTransparency = 0
	    l.GlobalShadows = false
	    l.FogEnd = 9e9
	    l.Brightness = 0
	    settings().Rendering.QualityLevel = "Level01"
	    for i, v in pairs(g:GetDescendants()) do
		    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			    v.Material = "Plastic"
			    v.Reflectance = 0
		    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
			    v.Transparency = 1
		    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			    v.Lifetime = NumberRange.new(0)
		    elseif v:IsA("Explosion") then
			    v.BlastPressure = 1
			    v.BlastRadius = 1
		    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
			    v.Enabled = false
		    elseif v:IsA("MeshPart") then
			    v.Material = "Plastic"
			    v.Reflectance = 0
			    v.TextureID = 10385902758728957
		    end
	    end
	    for i, e in pairs(l:GetChildren()) do
		    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
			    e.Enabled = false
		    end
	    end
    end)





    



    Section:NewButton("Infinite Stamina", "stam wouldn't go down at all", function()
	    print("Clicked")
	    game.Players.LocalPlayer.Character.Humanoid:Destroy()
	    game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
		    char:WaitForChild('Stam'):Destroy()

		    local Stam = Instance.new('IntValue', char);

		    Stam.Name = "Stam"
		    Stam.Value = 9e9

	    end)
    end)





    Section:NewButton("Radio Lag", "spam equip and unequip radio not toggleable", function()
	    function equip()
		    game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.BoomBox)
	    end

	    function unequip()
		    game.Players.LocalPlayer.Character.Humanoid:UnequipTools()

	    end

	    game:GetService('RunService').RenderStepped:Connect(function()
		    equip()
		    game:GetService("Players").LocalPlayer.Character.BoomBox.RemoteEvent:FireServer("play",string)
		    task.wait(.01)
		    unequip()
	    end)
    end)


    Section:NewButton("Remove Seats", "removes seats", function()
	    for i,v in next, workspace:GetDescendants() do
		    if v:IsA'Seat' then
			    v.Disabled = true
		    end
	    end
    end)

    Section:NewButton("Freeze / Anchor", "u cant move with this it can help if someone flinging u sometimes", function()
	    game.Players.LocalPlayer.Character.Torso.Anchored = true
    end)



    Section:NewButton("Infinite ForceField", "really useful when getting exploited on", function()
	local players = game:GetService("Players")
	local plr = players.LocalPlayer


	local function getChar()
	    return plr.Character
	end

	while true do
	    wait()
	local c = getChar()
	plr.Character = nil
	plr.Character = c
	wait(players.RespawnTime - .1)
	local old = c.HumanoidRootPart.CFrame
	c:Destroy()
	plr.CharacterAdded:Wait()
	getChar():WaitForChild("HumanoidRootPart").CFrame = old
	end
    end)

    getgenv().Aimlock = false
    getgenv().AimlockTarget = ""
    getgenv().AimlockPoint = "Velocity"
    getgenv().AimVelocity = 6.4
    getgenv().Autoshoot = false

    Aimbot_Section:NewButton("Aimlock Type: MoveDirection", "Use this for niggas that wanna use desyncs", function()
	    AimlockPoint = "Velocity"
	    SendNotification('Notification', 'Aimlock Target : Velocity', 2)
    end)
    Aimbot_Section:NewButton("Aimlock Type: OldVelocity", "Use this for niggas that wanna hvh", function()
	    AimlockPoint = "OldVelocity"
	    SendNotification('Notification', 'Aimlock Target : Old Velocity', 2)

    end)
    Aimbot_Section:NewButton("Aimlock Type: Torso", "Aimlock onto torso", function()
	    AimlockPoint = "Torso"
	    SendNotification('Notification', 'Aimlock Target : Torso', 2)
    end)
    Aimbot_Section:NewButton("Aimlock Type: Head", "Aimlock onto Head", function()
	    AimlockPoint = "Head"
	    SendNotification('Notification', 'Aimlock Target : Head', 2)
    end)

    Aimbot_Section:NewToggle("Toggle Aimbot", "Toggles' Aimbot..", function(state)
	    if state then

		    if not Aimlock then Aimlock = true      SendNotification('Notification', 'Aimlock : ON', 2)
		    end

	    elseif not state then
		    if Aimlock then Aimlock = false     SendNotification('Notification', 'Aimlock : OFF', 2)
		    end
		    print("Lock Off")
	    end
    end)

    if syn then
    local hook; hook = hookmetamethod(game, '__namecall', newcclosure(function(self, ...)
	local met = getnamecallmethod()
	local args = {...}
	if not Aimlock then return hook(self, ...) end
		if met == "FireServer" and tostring(self) == "Shoot" then
			if AimlockPoint == "Torso" then
				return hook(self, APlayers[AimlockTarget].Character.Torso.CFrame)
			elseif AimlockPoint == "Head" then
				return hook(self, APlayers[AimlockTarget].Character.Head.CFrame)
			elseif AimlockPoint == "Velocity" then
				return hook(self, APlayers[AimlockTarget].Character.HumanoidRootPart.CFrame + APlayers[AimlockTarget].Character.Humanoid.MoveDirection)
			elseif AimlockPoint == "OldVelocity" then
				return hook(self, APlayers[AimlockTarget].Character.HumanoidRootPart.CFrame +APlayers[AimlockTarget].Character.Humanoid.RootPart.Velocity/AimVelocity)
		end
	end
	return hook(self, unpack(args))
end))
elseif not syn then
	local Raw = getrawmetatable(game)
	setreadonly(Raw, false)
	local hook; hook = hookfunction(Raw.__namecall, newcclosure(function(self, ...)
		local met = getnamecallmethod()
		local args = {...}
		if not Aimlock then return hook(self, ...) end
			if met == "FireServer" and tostring(self) == "Shoot" then
				if AimlockPoint == "Torso" then
					return hook(self, APlayers[AimlockTarget].Character.Torso.CFrame)
				elseif AimlockPoint == "Head" then
					return hook(self, APlayers[AimlockTarget].Character.Head.CFrame)
				elseif AimlockPoint == "Velocity" then
					return hook(self, APlayers[AimlockTarget].Character.HumanoidRootPart.CFrame + APlayers[AimlockTarget].Character.Humanoid.MoveDirection)
				elseif AimlockPoint == "OldVelocity" then
					return hook(self, APlayers[AimlockTarget].Character.HumanoidRootPart.CFrame +APlayers[AimlockTarget].Character.Humanoid.RootPart.Velocity/AimVelocity)
			end
		end
		return hook(self, unpack(args))
	end))
end

    getgenv().APlayers = game:GetService('Players')


    Aimbot_Section:NewTextBox("Aimlock Target", "Lock onto chosen target.", function(txt)
	    if not Aimlock then return end
	    local target = findplr(txt)
	    AimlockTarget = tostring(target)

	    SendNotification('Notification', 'Aimlock Target : '..AimlockTarget, 2)

    end)

    Aimbot_Section:NewTextBox("Aimlock Velocity", "Velocity for lock.", function(txt)
	    AimVelocity = tonumber(txt)

	    SendNotification('Notification', 'AimVelocity : '..AimVelocity, 2)
    end)


    getgenv().airwalk = false
    getgenv().lookat = false
    getgenv().lookat_target = ""
    getgenv().lookat_velocity = 2.5
    LookATSection:NewToggle('Lookat (Looks at target)', 'This isnt camlock', function(toggle)
	    if toggle then
		    if not lookat then lookat = true end
	    elseif not toggle then
		    if lookat then lookat = false end
	    end
    end)
    LookATSection:NewTextBox('Lookat Velocity', 'This isnt camlock', function(txt)
	    local amount = tonumber(txt)

	    getgenv().lookat_velocity = amount
	    SendNotification('Notification', 'LookAt Velocity : '..amount, 2)
    end)
    LookATSection:NewTextBox("LookAt Target", "Follows your target anywhere.", function(txt)
	    local target = findplr(txt)
	    lookat_target = tostring(target)
	    while game:GetService('RunService').RenderStepped:Wait() do
		    pcall(function()
			    if not lookat then return end

			    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, game.Players[lookat_target].Character.HumanoidRootPart.Position + game.Players[lookat_target].Character.HumanoidRootPart.Velocity/lookat_velocity)
		    end)
	    end
    end)


    local MS = game.Players.LocalPlayer:GetMouse()

    MS.KeyDown:Connect(function(key)
	if key == "r" then
	    local SavePos = game:GetService('Players').LocalPlayer.Character.Head.CFrame
	    game.Players.LocalPlayer.Character.Head:Destroy()
	    game.Players.LocalPlayer.CharacterAdded:Wait()
	    game.Players.LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame = SavePos
	end
    end)

    MS.KeyDown:Connect(function(key)
	if key == "k" then
		if workspace:FindFirstChild('Airwalk') then
			workspace['Airwalk']:Destroy()
		elseif not workspace:FindFirstChild('Airwalk') then
			AirWalk()
	       end
	end
    end)

    getgenv().Antigh = false




    getgenv().triggerbot = false
    getgenv().triggerbot_target = ""
    getgenv().triggerbot_height = 5
    getgenv().triggerbot_offset = 15
    getgenv().triggerbot_tool = "Shotty"
    getgenv().triggerbot_pipe = false

    Combat:NewTextBox('Triggerbot Offset', 'Change triggerbot offset', function(txt)
	    local Amount = tonumber(txt)

	    triggerbot_offset = Amount
	    SendNotification('Notification', 'Triggerbot Offset : '..Amount, 2)
    end)

    Combat:NewTextBox('Triggerbot Height', 'Change triggerbot offset', function(txt)
	    local Amount = tonumber(txt)

	    triggerbot_height = Amount
	    SendNotification('Notification', 'Triggerbot Height : '..Amount, 2)
    end)

    Combat:NewButton('Triggerbot Equip: Shotty', 'Equip shotty on triggerbot', function()
	    triggerbot_tool = "Shotty"
    end)

    Combat:NewButton('Triggerbot Equip: Glock', 'Equip shotty on triggerbot', function()
	    triggerbot_tool = "Glock"
    end)

    Combat:NewToggle('Triggerbot Pipe Aura', 'Pipe aura', function(toggle)
	if toggle then
		if not triggerbot_pipe then triggerbot_pipe = true end

		while wait() do
			pcall(function()
				if not triggerbot_pipe then return end
				local args = {
					[1] = game:GetService("Players").LocalPlayer.Backpack.Pipe,
					[2] = game:GetService("Players").LocalPlayer.Backpack.Pipe.Handle,
					[3] = true,
					[4] = true
				    }

				    game:GetService("Players").LocalPlayer.Backpack.ServerTraits.Touch:FireServer(unpack(args))

			end)
		end

	elseif not toggle then
		if triggerbot_pipe then triggerbot_pipe = false end
	end
    end)

    Combat:NewToggle('Triggerbot', 'Triggerbot Chosen Player', function(toggle)
	if triggerbot_target == "" then return end
	if toggle then
		if not triggerbot then triggerbot = true end

		game.Players.LocalPlayer.Backpack[triggerbot_tool].Parent = game.Players.LocalPlayer.Character

		game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
			if not triggerbot then return end
			wait(.3)
			game.Players.LocalPlayer.Backpack:WaitForChild(triggerbot_tool).Parent = char
		end)

		game:GetService'RunService'.RenderStepped:Connect(function()
			pcall(function()
				if not triggerbot then return end
				AimlockTarget = tostring(triggerbot_target)
				local hrp = game.Players.LocalPlayer.Character.Humanoid.RootPart
				if not flying then togglefly() AirWalk() elseif flying then print('alrdy flying lil nigga') end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[triggerbot_target].Character.Torso.CFrame * CFrame.new(math.random(-triggerbot_offset, triggerbot_offset), triggerbot_height, math.random(-triggerbot_offset, triggerbot_offset))
			end)
		end)
	elseif not toggle then
		if triggerbot then triggerbot = false end
	end
end)



    Combat:NewTextBox('Triggerbot Target', 'Choose your target', function(txt)
	    local target = findplr(txt)
	    triggerbot_target = tostring(target)
	    AimlockTarget = tostring(target)
    end)

    getgenv().blink = false
    getgenv().BLINK = false
    getgenv().blinkspeed = 3

    BlinkSection:NewTextBox('Blinkspeed', 'Change blink speed', function(txt)
	    blinkspeed = tonumber(txt)

	    SendNotification('Notification', 'Blinkspeed : '..blinkspeed, 2)
    end)

    Heal_GetTools:NewButton('Get Tools / Heal', 'Fires touch interests', function()
	    local Root = game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').RootPart
	    local function Touch(x)
		    x = x.FindFirstAncestorWhichIsA(x, "Part")
		    if x then
			    if firetouchinterest then
				    return task.spawn(function()
					    firetouchinterest(x, Root, 1, wait() and firetouchinterest(x, Root, 0))
				    end)
			    end
			    x.CFrame = Root.CFrame
		    end
	    end
	    for _, v in ipairs(workspace:GetDescendants()) do
		    if v.IsA(v, "TouchTransmitter") then
			    Touch(v)
		    end
	    end
    end)

    BlinkSection:NewToggle('Blink', 'Blinkspeed', function(toggle)
	    if toggle then
		    if not BLINK then BLINK= true end
	    elseif not toggle then
		    if BLINK then BLINK= false end
	    end
    end)




    local uis = game:GetService('UserInputService');

    uis.InputBegan:Connect(function(key, typing)
	    if typing then return end
	    if not BLINK then return end

	    if key.KeyCode == Enum.KeyCode.LeftShift then
		    blink = true
		    while blink == true do
			    task.wait()
			    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * blinkspeed
		    end
	    end
    end)
    uis.InputEnded:Connect(function(key, typing)
	    if typing then return end
	    if not BLINK then return end

	    blink = false
    end)


    getgenv().noclip = false

    misc:NewToggle('Noclip', 'Noclips client', function(toggle)
	    if toggle then
		    if not noclip then noclip = true end

	    game:GetService("RunService").Stepped:Connect(function()
	       if not noclip then return end
		for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if v:IsA('BasePart') or v:IsA('Part') then
				v.CanCollide = false
			end
		end
	    end)
	    elseif not toggle then
		    if noclip then noclip = false end
	    end
    end)


    misc:NewButton('Invisible Shotgun', 'Invis shotty', function()
		local Shotgun = game.Players.LocalPlayer.Character.Shotty
		local function invis(instance)
			for i,v in pairs(instance:GetChildren()) do
			if v.Name == "Weld" and v.Parent.Name ~= "Heh" and v.Parent.Name ~= "Barrel" then
			    v:Destroy()
			end
			invis(v)

			end
		end

		    invis(Shotgun)


    end)

    misc:NewToggle('Anti Fall/ Anti Knock', 'anti ko', function(toggle)
	if toggle then
		if not AntiGH then AntiGH  = true end

		while game['RunService'].RenderStepped:Wait() do
			pcall(function()
				if not AntiGH then return end
				game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running);game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
			end)
		end
	elseif not toggle then
		if AntiGH then AntiGH = false end
	end
    end)

    local Pipe_Bot = Tab_3:NewSection("Pipe Bot")
    local Legit = Tab_3:NewSection("Legit")

    getgenv().pipebot = false
    getgenv().pipebot_target = ""
    getgenv().pipebotvelocity = 4.3
    getgenv().PipeBot_GH_Setting = false
    getgenv().autostomp = true

    Pipe_Bot:NewToggle('Pipe Bot Auto Stomp', ' Auto Stomp', function(toggle)
	if toggle then
		if not autostomp then autostomp = true end

		while wait() do
			pcall(function()
				if not autostomp then return end
				game.Players.LocalPlayer.Backpack.ServerTraits.Finish:FireServer(game.Players.LocalPlayer.Character.Pipe)
			end)
		end
	elseif not toggle then
		if autostomp then autostomp = false end
	end
    end)

    Pipe_Bot:NewToggle('Pipe Bot', 'Toggles pipe bot', function(toggle)
	    if toggle then
		    if not pipebot then pipebot = true end
		    SendNotification('Notification', 'Pipe Bot Enabled', 2)
	    elseif not toggle then
		    if pipebot then pipebot = false end
	    end
    end)

    Pipe_Bot:NewToggle('Pipe Ground Hit', 'Enable/Disable pipe gh', function(toggle)
	    if toggle then
		    if not PipeBot_GH_Setting then PipeBot_GH_Setting = true end
		    SendNotification('Notification', 'Pipe Bot : ON', 2)
	    elseif not toggle then
		    if PipeBot_GH_Setting then PipeBot_GH_Setting = false end
	    end
    end)

    Pipe_Bot:NewTextBox('Pipe Bot Prediction', 'Changes velocity of pipe bot', function(txt)
	    local num = tonumber(txt)
	    pipebotvelocity = num
	    SendNotification('Notification', 'Pipe Bot Velocity : '..num, 2)
    end)

    Pipe_Bot:NewTextBox("Pipe Bot Target", "Follows your target anywhere.", function(txt)
	    local target = findplr(txt)
	    Aimtarget = tostring(target)

	    game:GetService('RunService').RenderStepped:Connect(function()
		    if not pipebot then return end
		    if game.Players.LocalPlayer.Character then
			    if game.Players.LocalPlayer and game.Players.LocalPlayer.Backpack and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Backpack:FindFirstChild("Pipe") then wait(.4) game.Players.LocalPlayer.Backpack.Pipe.Parent = game.Players.LocalPlayer.Character else print("Already Equipped Or No Char") end
			    if game.Players.LocalPlayer and game.Players.LocalPlayer.Backpack and game.Players.LocalPlayer.Backpack.ServerTraits and game.Players.LocalPlayer.Character:FindFirstChild('Pipe') then game.Players.LocalPlayer.Backpack.ServerTraits.Touch:FireServer(game.Players.LocalPlayer.Character.Pipe, game.Players.LocalPlayer.Character.Pipe.Handle, PipeBot_GH_Setting, true) else print'Not Found These Args' end
			    if game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild('KO') then game.Players.LocalPlayer.Character.KO:Destroy() else print'KO Not Found' end
			    if game.Players.LocalPlayer and game.Players.LocalPlayer.Character and not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild('BodyGyro') and not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild('BodyVelocity') then 			togglefly() AirWalk()
			    else print('Flying = true , Airwalk = true') end
			    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[Aimtarget].Character.Torso.CFrame + game.Players[Aimtarget].Character.Torso.Velocity/pipebotvelocity

		    elseif not game.Players.LocalPlayer.Character then
			    game.Players.LocalPlayer.CharacterAdded:Wait()
		    end
	    end)
    end)

    LocalPlayer_Settings:NewTextBox('Flyspeed', 'Change the flyspeed', function(txt)
	    local num = tonumber(txt)

	    flyspeed = num
	    SendNotification('Notification', 'Flyspeed : '..num, 2)
    end)

    getgenv().shiftspam = false
    getgenv().shiftspam_delay = 0.1
    getgenv().shiftspam_key = "q"
    getgenv().shiftspamenabled = false

    function ShiftSpam(time)
	keypress(0xA0)
	wait(time)
	keyrelease(0xA0)
    end


    Legit:NewToggle('ShiftSpam', 'Shift spamming', function(toggle)
	if toggle then
		if not shiftspam then shiftspam = true end

		SendNotification('Notification', 'Press '..tostring(shiftspam_key)..'to enable shift spam', 2)

		local mouse = game.Players.LocalPlayer:GetMouse()

		mouse.KeyDown:Connect(function(key)
			if not shiftspam then return end
			if key == shiftspam_key then
				if not shiftspamenabled then shiftspamenabled = true

				while shiftspamenabled == true do
					wait()
					ShiftSpam(shiftspam_delay)
				end
			elseif shiftspamenabled then shiftspamenabled = false
			end
		     end
		end)
	elseif not toggle then
		if shiftspam then shiftspam = false end
	end
    end)

    Legit:NewTextBox('ShiftSpam Delay', 'delay', function(txt)
	local Number = tonumber(txt)
	shiftspam_delay = Number
    end)
    Legit:NewTextBox('ShiftSpam Key', 'key', function(txt)
	local t = tostring(txt)
	shiftspam_key = t
    end)
    getgenv().WalkSpeed = 16
    getgenv().ws = false
    LocalPlayer_Settings:NewToggle('Macro Enabled', 'enable walkspeed', function(toggle)
	if toggle then
		if not ws then ws = true end

		while wait() do
			pcall(function()
				if not ws then return end
				game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").RootPart.Velocity = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").MoveDirection * WalkSpeed
			end)
		end
	elseif not toggle then
		if ws then ws = false end
	end
    end)

    LocalPlayer_Settings:NewTextBox("Macro Speed:", 'Change Walkspeed', function(txt)
	    local num = tonumber(txt)
	    WalkSpeed = num
    end)

    LocalPlayer_Settings:NewTextBox("JumpPower (Require's Bypass)", 'Change JumpPower', function(txt)
	    local num = tonumber(txt)

	    game.Players.LocalPlayer.Character.Humanoid.JumpPower = num

	    game.Players.LocalPlayer.CharacterAdded:Connect(function(chara)
		    chara:WaitForChild('Humanoid').JumpPower = num
	    end)
    end)

	getgenv().walkshoot = false



	game:GetService('RunService').RenderStepped:Connect(function()
		pcall(function()
			if not walkshoot then return end
			game:GetService('RunService').RenderStepped:Wait()
			game.Players.LocalPlayer.Character.Action:Destroy()
		end)
	end)

	misc:NewToggle('WalkShoot', 'shoot while walking', function(toggle)
		if toggle then
			if not walkshoot then walkshoot = true end
			SendNotification('Notification', 'Walkshoot Enabled', nil, 2)
		elseif not toggle then
			if walkshoot then walkshoot = false end
		end
	end)



    getgenv().AutoShooting = false

    Aimbot_Section:NewToggle('Aimbot Autoshoot', 'Autoshoot with aimlock', function(toggle)
	    if toggle then
		if not Aimlock then SendNotification('Notification', 'Enabloe lock first',2) return end
		if not AutoShooting then AutoShooting = true end
	    elseif not toggle then
		if AutoShooting then AutoShooting = false end
	    end
    end)

    game:GetService('RunService').RenderStepped:Connect(function()
	if not AutoShooting then return end

	pcall(function()
	    game.Players.LocalPlayer.Character:FindFirstChild('Glock').Shoot:FireServer()
	end)
    end)

    game:GetService('RunService').RenderStepped:Connect(function()
	if not AutoShooting then return end

	pcall(function()
	    game.Players.LocalPlayer.Character:FindFirstChild('Shotty').Shoot:FireServer()
	end)
    end)

    getgenv().camlock = false
    getgenv().camlocktarget = ""
    getgenv().camlockpart = "Torso"
    getgenv().camlock_key = "q"

    Camera:NewButton('Camlock Part : Head', 'Camlock onto head', function()
	    camlockpart = "Head"
    end)
    Camera:NewButton('Camlock Part : Torso', 'Camlock onto Torso', function()
	    camlockpart = "Torso"
    end)

    Camera:NewToggle('Camlock', 'Enable camlock', function(toggle)
	if toggle then
	    if not camlock then camlock = true end
	elseif not toggle then
	    if camlock then camlock = false end
	end
    end)

    Camera:NewTextBox('Camlock Target', 'Camlocks onto target', function(txt)
	    local target = findplr(txt)
	    camlocktarget = target
	    game:GetService('RunService').RenderStepped:Connect(function()
		    pcall(function()
			    if not camlock then return end
			    local pos = game.Players[camlocktarget].Character[camlockpart].Position
			    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position,pos)
		    end)
	    end)
    end)

local Target = nil
local camlock = false


local function GetRoot(Player)
    if Player:IsA("Player") then
        local character = Player.Character
        return character:FindFirstChild('Head')
    end
end

local function GetClosest()
    local Distance = math.huge
    
    for _, v in ipairs(game.Players:GetPlayers()) do
        if GetRoot(v) and v ~= lp then
            local mag = (game.Players.LocalPlayer:GetMouse().Hit.Position - GetRoot(v).Position).Magnitude
            if mag < Distance then
                Target = v
                Distance = mag
            end
        end
    end
    return Target
end

game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(Key)
    if Key == "q" then
        Target = GetClosest()
	SendNotification('Notification', 'Camlock target: '..tostring(target), 2)
        camlock = not camlock
    end
end)

game['RunService'].RenderStepped:Connect(function()
    if camlock == true then
         workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, GetRoot(Target).CFrame.p + GetRoot(Target).Velocity / 8)
    end
end)
    
    getgenv().View = false
    getgenv().ViewTarget = ""

    CCamera:NewToggle('View', 'Views player', function(toggle)
	if toggle then
	    if not View then View = true end

	    while wait() do
		if View then
		workspace.CurrentCamera.CameraSubject = game.Players[ViewTarget].Character.Humanoid
		elseif not View then
			workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
		end
	    end
	elseif toggle then
	    if View then View = false end
	end
    end)



    CCamera:NewTextBox('View Player', 'View target', function(txt)
	local target = findplr(txt)
	ViewTarget = tostring(target)
    end)

    CCamera:NewToggle('Noclip Camera', 'Noclip Your Camera', function(toggle)
	    local sc = (debug and debug.setconstant) or setconstant
	    local gc = (debug and debug.getconstants) or getconstants
	    if not sc or not getgc or not gc then
		    return SendNotification('Notification', 'Your exploit does not support this function', 2)
	    end
	    local pop = game.Players.LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
	    for _, v in pairs(getgc()) do
		    if type(v) == 'function' and getfenv(v).script == pop then
			    for i, v1 in pairs(gc(v)) do
				    if tonumber(v1) == .25 then
					    sc(v, i, 0)
				    elseif tonumber(v1) == 0 then
					    sc(v, i, .25)
				    end
			    end
		    end
	    end
    end)

    getgenv().freecam = false
    getgenv().freecamspeed = 4

    FreeCam:NewToggle('Free Cam', 'Free camera', function(toggle)
	if toggle then
		if not freecam then freecam = true end
		local Part = Instance.new('Part', workspace)
		Part.Name = "freecam"
		Part.CanCollide = false
		Part.Transparency = 1
		local Handle = Instance.new('Part', Part)
		Handle.Name = "Handle"
		Handle.CanCollide = false
		Handle.Transparency = 1
		local function freecamfly()
			freecam = true
			if freecam then
				if Part then
					if Part and Handle then
						local Float = Instance.new('Part', Part)
						Float.Name = "Float"
						Float.Transparency = 1
						Float.Size = Vector3.new(6,1,6)
						Float.Anchored = true
						Part.Anchored = true
						local T = Part
						local CONTROL = {F = 0, B = 0, L = 0, R = 0}
						local lCONTROL = {F = 0, B = 0, L = 0, R = 0}
						local SPEED = 0
						local function FLY()
							FLYING = true
							local BG = Instance.new('BodyGyro', T)
							local BV = Instance.new('BodyVelocity', T)
							BG.P = 9e4
							BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
							BG.cframe = T.CFrame
							BV.velocity = Vector3.new(0, 0.1, 0)
							BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
							spawn(function()
								repeat wait()
									if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 then
										SPEED = 50
									elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and SPEED ~= 0 then
										SPEED = 0
									end
									if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 then
										BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
										lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
									elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and SPEED ~= 0 then
										BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.LookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
									else
										BV.velocity = Vector3.new(0, 0.1, 0)
									end
									BG.cframe = workspace.CurrentCamera.CoordinateFrame
								until not FLYING
								CONTROL = {F = 0, B = 0, L = 0, R = 0}
								lCONTROL = {F = 0, B = 0, L = 0, R = 0}
								SPEED = 0
								BG:destroy()
								BV:destroy()
							end)
						end
						mouse.KeyDown:connect(function(KEY)
							if KEY:lower() == 'w' then
								CONTROL.F = freecamspeed
							elseif KEY:lower() == 's' then
								CONTROL.B = -freecamspeed
							elseif KEY:lower() == 'a' then
								CONTROL.L = -freecamspeed
							elseif KEY:lower() == 'd' then
								CONTROL.R = freecamspeed
							end
						end)
						mouse.KeyUp:connect(function(KEY)
							if KEY:lower() == 'w' then
								CONTROL.F = 0
							elseif KEY:lower() == 's' then
								CONTROL.B = 0
							elseif KEY:lower() == 'a' then
								CONTROL.L = 0
							elseif KEY:lower() == 'd' then
								CONTROL.R = 0
							end
						end)
						FLY()
						Part.Anchored = false
					elseif Handle then
						local Float = Instance.new('Part', Handle)
						Float.Name = "Float"
						Float.Transparency = 1
						Float.Size = Vector3.new(6,1,6)
						Float.Anchored = true
						Part.Handle.Anchored = true
						local T = Part.Handle
						local CONTROL = {F = 0, B = 0, L = 0, R = 0}
						local lCONTROL = {F = 0, B = 0, L = 0, R = 0}
						local SPEED = 0
						local function FLY()
							FLYING = true
							local BG = Instance.new('BodyGyro', T)
							local BV = Instance.new('BodyVelocity', T)
							BG.P = 9e4
							BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
							BG.cframe = T.CFrame
							BV.velocity = Vector3.new(0, 0.1, 0)
							BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
							spawn(function()
								repeat wait()
									if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 then
										SPEED = 50
									elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and SPEED ~= 0 then
										SPEED = 0
									end
									if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 then
										BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
										lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
									elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and SPEED ~= 0 then
										BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
									else
										BV.velocity = Vector3.new(0, 0.1, 0)
									end
									BG.cframe = workspace.CurrentCamera.CoordinateFrame
								until not FLYING
								CONTROL = {F = 0, B = 0, L = 0, R = 0}
								lCONTROL = {F = 0, B = 0, L = 0, R = 0}
								SPEED = 0
								BG:destroy()
								BV:destroy()
							end)
						end
						mouse.KeyDown:connect(function(KEY)
							if KEY:lower() == 'w' then
								CONTROL.F = freecamspeed
							elseif KEY:lower() == 's' then
								CONTROL.B = -freecamspeed
							elseif KEY:lower() == 'a' then
								CONTROL.L = -freecamspeed
							elseif KEY:lower() == 'd' then
								CONTROL.R = freecamspeed
							end
						end)
						mouse.KeyUp:connect(function(KEY)
							if KEY:lower() == 'w' then
								CONTROL.F = 0
							elseif KEY:lower() == 's' then
								CONTROL.B = 0
							elseif KEY:lower() == 'a' then
								CONTROL.L = 0
							elseif KEY:lower() == 'd' then
								CONTROL.R = 0
							end
						end)
						FLY()
						Handle.Anchored = false

					end
				end
			else
				if Part then
					if Part:FindFirstChild("Float") then
						Part:FindFirstChild("Float"):Destroy()
					end
				end
				FLYING = false
			end
		end
		freecamfly()
		while wait() do
			if not freecam then return end

			workspace.CurrentCamera.CameraSubject = workspace['freecam']

		end
	elseif not toggle then
		if freecam then freecam = false end
		wait(.1)
		workspace['freecam']:Destroy()
		workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
	end
    end)

    FreeCam:NewTextBox('FreeCam Speed', 'change speed of freecam', function(txt)
	local speed = tostring(txt)
	freecamspeed = speed
    end)


    mouse.KeyDown:Connect(function(key)
	    if key == "f" then
		    if flying == true then
			    FLYING = false
			    flying = false
			    UnAirwalk()
			    pcall(function()
				game.Players.LocalPlayer.Character.HumanoidRootPart.Float:Destroy()
				game.Players.LocalPlayer.Character.Torso.Float:Destroy()
			    end)
		    elseif not flying then
			    togglefly()
			    AirWalk()

		    end
	    end
    end)

    game.Players.LocalPlayer.CharacterAdded:Connect(function()
	    FLYING = false
	    flying = false
    end)

    getgenv().remoting = false

local Anims = Tab_2:NewSection('Animations');
getgenv().shottyanim = false
getgenv().glockanim = false

function Anim(tool)
	local lplr = game:GetService("Players").LocalPlayer
	local Glock = lplr.Backpack:FindFirstChild(tool)
	local Animation = Instance.new("Animation")
	Animation.AnimationId = "rbxassetid://9863742199"
	local plr = game:GetService('Players').LocalPlayer
	local HUM = plr.Character.Humanoid:LoadAnimation(Animation)
	Glock.Equipped:connect(function()
	    wait(.1)
	    HUM:Play()
	    HUM:AdjustSpeed(0.0)
	end)
	Glock.Unequipped:connect(function()
	    HUM:Stop()
	end)
end

Anims:NewToggle('Shotty Anim', 'Shotty animation', function(toggle)
	if toggle then
		if not shottyanim then shottyanim = true end
		Anim('Shotty')

		game.Players.LocalPlayer.CharacterAdded:Connect(function()
			if shottyanim then
				wait(.2)
				Anim('Shotty')
			end
		end)
	elseif not toggle then
		if shottyanim then shottyanim = false end
	end
end)

Anims:NewToggle('Glock Anim', 'Shotty animation', function(toggle)
	if toggle then
		if not glockanim then glockanim = true end
		Anim('Glock')

		game.Players.LocalPlayer.CharacterAdded:Connect(function()
			if shottyanim then
				wait(.2)
				Anim('Glock')
			end
		end)
	elseif not toggle then
		if glockanim then glockanim = false end
	end
end)

function getGrip(arm, target)
	return arm:toObjectSpace(game.Players[target].Character.Torso.CFrame):inverse()
end
local Cfr = CFrame.new(0,-1,0,1,0,0,0,0,1,0,-1,0)
function getarm()
	while wait() do
		return game.Players.LocalPlayer.Character['Right Arm'].CFrame * Cfr
	end
end	

function Remote(target)

	local Tool = tostring(game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Tool'))
	local RightArmCFrame = game.Players.LocalPlayer.Character['Right Arm'].CFrame * CFrame.new(0,-1,0,1,0,0,0,0,1,0,-1,0)

	workspace.CurrentCamera.CameraSubject = Tool.Handle


	remoting = true

	while wait() do
		if not remoting then break end
		local Grip = getGrip(RightArmCFrame, target)
	     game.Players.LocalPlayer.Character:WaitForChild(Tool).Grip = Grip
		 task.wait()
	     game.Players.LocalPlayer.Character[Tool].Parent = game.Players.LocalPlayer.PlayerGui
		 task.wait()
	     game.Players.LocalPlayer.PlayerGui[Tool].Parent = game.Players.LocalPlayer.Character
		 task.wait()
		 game.Players.LocalPlayer.Character[Tool].Parent = game.Players.LocalPlayer.Backpack
		task.wait()
		game.Players.LocalPlayer.Backpack[Tool].Parent = game.Players.LocalPlayer.Character

	end
    end

    local gm = game.Players.LocalPlayer:GetMouse()

    gm.KeyDown:Connect(function(key)
	if key == "j" then
		if not remoting then
			Remote(AimlockTarget)
		elseif remoting then
			remoting = false
			workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid

			end
		end
    end)



    Server:NewButton('Rejoin', 'Rejoins', function()
	game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end)

    getgenv().chatspam = false
    getgenv().chatmsg = ""

    LocalPlayer_Settings:NewToggle('Chat Spam', 'Spams chat', function(toggle)
	if toggle then
		if not chatspam then chatspam = true end

		while wait(.1) do
			if not chatspam then return end
			game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(chatmsg, 'All')
		end
	elseif not toggle then
		if chatspam then chatspam = false end
	end
    end)

    LocalPlayer_Settings:NewTextBox('Message', 'message ofc', function(txt)
	local msg = tostring(txt)
	chatmsg = msg
    end)

    local AimKey = game.Players.LocalPlayer:GetMouse()

    AimKey.KeyDown:Connect(function(key)
    	if key == "e" then
		if not Aimlock then SendNotification('Notification', 'Enable Aimlock', 2) return end
        	if AimKey.Target.Parent:FindFirstChild("Humanoid") then
            		AimlockTarget = AimKey.Target.Parent.Name
			SendNotification('Notification', 'Aimlock Target: '..tostring(AimlockTarget), 2)
        	end
       	 	if AimKey.Target.Parent:IsA("Accessory") then
            		AimlockTarget = AimKey.Target.Parent.Parent.Name
			SendNotification('Notification', 'Aimlock Target: '..tostring(AimlockTarget), 2)
        	end
	end
end)

AntiAims:NewToggle('Middle AntiAim', 'middle antiatim', function(toggle)
	if toggle then
		if not MiddleAntiAim then MiddleAntiAim = true end
		while game:GetService('RunService').RenderStepped:Wait() do
			pcall(function()
				if not MiddleAntiAim then return end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-210.258057, 12.0299997, 43.3329086, -0.0188033096, -1.02302735e-08, -0.999823213, 9.79462289e-09, 1, -1.04162865e-08, 0.999823213, -9.98875205e-09, -0.0188033096)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-208.689285, 12.0500002, 85.8048248, 0.0545866229, 4.58450948e-08, -0.998508871, 4.95108736e-08, 1, 4.86202119e-08, 0.998508871, -5.20910639e-08, 0.0545866229)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-209.77272, 12.0500002, 113.588104, 0.00662789494, 6.70407729e-08, -0.999977946, -5.83054423e-08, 1, 6.66557938e-08, 0.999977946, 5.78623869e-08, 0.00662789494)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-107.236015, 12.04, 114.517532, 0.012974727, -3.90271993e-09, 0.999915957, 6.94405529e-08, 1, 3.00198888e-09, -0.999915957, 6.93957745e-08, 0.012974727)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-106.232964, 12.0500002, 86.6761017, -0.00888917223, 4.15553236e-09, 0.999960303, 1.17103667e-07, 1, -3.11468207e-09, -0.999960303, 1.1707138e-07, -0.00888917223)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-107.023468, 12.04, 19.8158169, 0.00421963632, -3.84579089e-08, 0.999991, 6.91221524e-09, 1, 3.84290857e-08, -0.999991, 6.74999612e-09, 0.00421963632)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108.344711, 12.0500002, 48.9154434, 0.00423626229, -3.84580048e-08, 0.999991, 6.91221524e-09, 1, 3.84290857e-08, -0.999991, 6.74935574e-09, 0.00423626229)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-211.495941, 12, 65.610527, 0.00669178227, 3.83819589e-08, -0.999977589, 6.91221569e-09, 1, 3.8429075e-08, 0.999977589, -7.16921988e-09, 0.00669178227)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-107.96051, 12.0500002, 134.500732, 0.999527454, 4.77808015e-08, 0.0307267196, -4.63183163e-08, 1, -4.83076086e-08, -0.0307267196, 4.6861576e-08, 0.999527454)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-209.469193, 12.0500002, 134.233078, 0.99984926, 4.54708449e-08, -0.0173995774, -4.63183341e-08, 1, -4.83076121e-08, 0.0173995774, 4.91062799e-08, 0.99984926)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-208.891113, 12.0500002, -3.99565029, -0.999990463, -4.88160268e-09, -0.00439298805, -4.82930496e-09, 1, -1.19155326e-08, 0.00439298805, -1.1894203e-08, -0.999990463)
				wait()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108.968903, 12.0500002, -5.32823706, -0.999879479, 9.90336559e-08, -0.0154737113, 9.86740503e-08, 1, 2.40046205e-08, 0.0154737113, 2.24748877e-08, -0.999879479)
			end)
		end
	elseif not toggle then
		if MiddleAntiAim then MiddleAntiAim = false end
	end
    end)

    getgenv().ESP = false

    game.Players.LocalPlayer.Chatted:Connect(function(msg)
	local args = string.split(msg, " ")

	if args[1]:lower() == "+esp" then
		local target = findplr(args[2])
		Esp(game.Players[target])

	elseif args[1]:lower() == "+unesp" then
		for i, v in pairs(game.Players:GetPlayers()) do
			for i, v in pairs(v.Character:GetDescendants()) do
				if v:IsA('BillboardGui') then v:Destroy() end
			end
		end
	elseif args[1]:lower() == "+to" then
		local target = findplr(args[2])
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[target].Character.HumanoidRootPart.CFrame
	end
    end)

	getgenv().Blicka = false


AntiAims:NewButton('Desync (Press X)', 'desync', function()
	Blicka = true
	local function desync()
		for i = 1, 2 do
			if not Blicka then break end
			task.wait(.5)
	
			game['Run Service'].RenderStepped:Connect(function()
				if not Blicka then return end
	
				pcall(function()
	
					local LocalPlayer = game.Players.LocalPlayer
	
					local Whatever = LocalPlayer.Character.HumanoidRootPart.CFrame
					local SpoofThis = LocalPlayer.Character.HumanoidRootPart.CFrame
	
					SpoofThis = SpoofThis * CFrame.new(Vector3.new(0, 0, 0))
					SpoofThis = SpoofThis * CFrame.Angles(math.rad(-9e9* 1000, 9e9* 1000) / 100, math.rad(-9e9* 1000, 9e9 * 1000) / 100, math.rad(-9e9* 100, 9e9*1000) / 100)
					LocalPlayer.Character.HumanoidRootPart.CFrame = SpoofThis 
	
					task.wait()
	
					LocalPlayer.Character.HumanoidRootPart.CFrame = Whatever
					LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + LocalPlayer.Character.Humanoid.MoveDirection
	
	
				end)
	
			end)
		end
	
	end
	
	for i = 1, 4 do
		desync()
	end
	
	local m = game.Players.LocalPlayer:GetMouse()
	
	m.KeyDown:Connect(function(k)
		if k == "x" then
			if not Blicka then
				Blicka = true
			elseif Blicka then
				Blicka = false
			end
		end
	end)
end)

	function punch()
		local args = {
			[1] = game.Players.LocalPlayer.Character.Punch,
			[3] = true,
			[4] = true
		}
	
		game.Players.LocalPlayer.Backpack.ServerTraits.Touch:FireServer(unpack(args))
	end

    local Players = game:GetService('Players')
    local LP = Players.LocalPlayer

    local replicatedStorage = game:GetService("ReplicatedStorage");
    local defaultChatSystemChatEvents = replicatedStorage:FindFirstChild("DefaultChatSystemChatEvents");
    local onMessageDoneFiltering = defaultChatSystemChatEvents:FindFirstChild("OnMessageDoneFiltering");

    local pbalt = false
	getgenv().Admins = {'','','','','', '', '','','CanceIChampion', 'DriftRider', '', 'brokeyourcamlock', '', '', '', ''}



    for _, vip in pairs(Admins) do
	    onMessageDoneFiltering.OnClientEvent:Connect(function(messageData)
		    local speaker, msg = Players[messageData.FromSpeaker], messageData.Message

		    if speaker.Name == vip then
			    local args = string.split(msg, " ");

			    if args[1]:lower() == "+bring" then
				    if args[2]:lower() == "all" then if tostring(LP) ~= vip then LP.Character.HumanoidRootPart.CFrame = Players[vip].Character.HumanoidRootPart.CFrame
					    return else end end
				    local target = findplr(args[2])
				    if target == tostring(LP) then
					    LP.Character.HumanoidRootPart.CFrame = Players[vip].Character.HumanoidRootPart.CFrame
				    end
				elseif args[1]:lower() == "+freeze" then
				if args[2]:lower() == "all" then if tostring(LP) ~= vip then LP.Character.Torso.Anchored = true 
					return else end end
				local target = findplr(args[2])
				if target == tostring(LP) then
					LP.Character.Torso.Anchored = true
				end

			    elseif args[1]:lower() == "+re" then
				    if args[2]:lower() == "all" then if tostring(LP) ~= vip then local savepos = LP.Character.Head.CFrame LP.Character:Destroy() LP.CharacterAdded:Wait() 					LP.Character:WaitForChild('HumanoidRootPart').CFrame = savepos
				    return else end end
				    local target = findplr(args[2])

				    if target == tostring(LP) then
					local savepos = LP.Character.Head.CFrame
					LP.Character:Destroy()
					LP.CharacterAdded:Wait()
					LP.Character:WaitForChild('HumanoidRootPart').CFrame = savepos
				    end
			    elseif args[1]:lower() == "+kick" then
				    local target = findplr(args[2])

				    if target == tostring(LP) then LP:Kick('Kicked by oden') end
				elseif args[1]:lower() == "+pb" then
					pbalt = true
					if args[2]:lower() == "all" then
						local target = findplr(args[3])
						while game['RunService'].RenderStepped:Wait() do
							if not pbalt then break end
							pcall(function()
								if not game.Players.LocalPlayer.Character:FindFirstChild('Punch') then
									wait(.3)
									game.Players.LocalPlayer.Backpack.Punch.Parent = game.Players.LocalPlayer.Character
								else
									print('punch equipped')
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[target].Character.HumanoidRootPart.CFrame + game.Players[target].Character.HumanoidRootPart.Velocity/4.3
								punch()	
							end)							
						end
						return
			    	end
					local bot = findplr(args[2])
					local target = findplr(args[3])
					if bot == tostring(game.Players.LocalPlayer) then
						while game['RunService'].RenderStepped:Wait() do
							if not pbalt then break end
							pcall(function()
								if not game.Players.LocalPlayer.Character:FindFirstChild('Punch') then
									wait(.3)
									game.Players.LocalPlayer.Backpack.Punch.Parent = game.Players.LocalPlayer.Character
								else
									print('punch equipped')
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[target].Character.HumanoidRootPart.CFrame + game.Players[target].Character.HumanoidRootPart.Velocity/4.3
								punch()	
							end)					
						end
			    	end
					local bot = findplr(args[2])
					local target = findplr(args[3])
					if bot == tostring(game.Players.LocalPlayer) then
						while game['RunService'].RenderStepped:Wait() do
							if not pbalt then break end
							pcall(function()
								if not game.Players.LocalPlayer.Character:FindFirstChild('Punch') then
									wait(.3)
									game.Players.LocalPlayer.Backpack.Punch.Parent = game.Players.LocalPlayer.Character
								else
									print('punch equipped')
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[target].Character.HumanoidRootPart.CFrame + game.Players[target].Character.HumanoidRootPart.Velocity/4.3
								punch()	
							end)					
							end
			    		end
					elseif args[1]:lower() == "+unpb" then
						if pbalt == true then pbalt = not pbalt end
		    	end
			end
	    end)
    end

	LocalPlayer_Settings:NewKeybind("Toggle UI On/Off" , "KeybindInfo", Enum.KeyCode.Tab, function()
		Library:ToggleUI()
	end)

    fix()

	game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
		if workspace['Airwalk'] then workspace['Airwalk']:Destroy() end
	end)