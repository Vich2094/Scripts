--https://github.com/Mokiros/roblox-FE-compatibility
if game:GetService("RunService"):IsClient() then error("Script must be server-side in order to work; use h/ and not hl/") end
local Player,game,owner = owner,game
local RealPlayer = Player
do
	print("FE Compatibility code V2 by Mokiros")
	local RealPlayer = RealPlayer
	script.Parent = RealPlayer.Character

	--Fake event to make stuff like Mouse.KeyDown work
	local Disconnect_Function = function(this)
		this[1].Functions[this[2]] = nil
	end
	local Disconnect_Metatable = {__index={disconnect=Disconnect_Function,Disconnect=Disconnect_Function}}
	local FakeEvent_Metatable = {__index={
		Connect = function(this,f)
			local i = tostring(math.random(0,10000))
			while this.Functions[i] do
				i = tostring(math.random(0,10000))
			end
			this.Functions[i] = f
			return setmetatable({this,i},Disconnect_Metatable)
		end
	}}
	FakeEvent_Metatable.__index.connect = FakeEvent_Metatable.__index.Connect
	local function fakeEvent()
		return setmetatable({Functions={}},FakeEvent_Metatable)
	end

	--Creating fake input objects with fake variables
    local FakeMouse = {Hit=CFrame.new(),KeyUp=fakeEvent(),KeyDown=fakeEvent(),Button1Up=fakeEvent(),Button1Down=fakeEvent(),Button2Up=fakeEvent(),Button2Down=fakeEvent()}
    FakeMouse.keyUp = FakeMouse.KeyUp
    FakeMouse.keyDown = FakeMouse.KeyDown
	local UIS = {InputBegan=fakeEvent(),InputEnded=fakeEvent()}
	local CAS = {Actions={},BindAction=function(self,name,fun,touch,...)
		CAS.Actions[name] = fun and {Name=name,Function=fun,Keys={...}} or nil
	end}
	--Merged 2 functions into one by checking amount of arguments
	CAS.UnbindAction = CAS.BindAction

	--This function will trigger the events that have been :Connect()'ed
	local function TriggerEvent(self,ev,...)
		for _,f in pairs(self[ev].Functions) do
			f(...)
		end
	end
	FakeMouse.TriggerEvent = TriggerEvent
	UIS.TriggerEvent = TriggerEvent

	--Client communication
	local Event = Instance.new("RemoteEvent")
	Event.Name = "UserInput_Event"
	Event.OnServerEvent:Connect(function(plr,io)
	    if plr~=RealPlayer then return end
		FakeMouse.Target = io.Target
		FakeMouse.Hit = io.Hit
		if not io.isMouse then
			local b = io.UserInputState == Enum.UserInputState.Begin
			if io.UserInputType == Enum.UserInputType.MouseButton1 then
				return FakeMouse:TriggerEvent(b and "Button1Down" or "Button1Up")
			end
			if io.UserInputType == Enum.UserInputType.MouseButton2 then
				return FakeMouse:TriggerEvent(b and "Button2Down" or "Button2Up")
			end
			for _,t in pairs(CAS.Actions) do
				for _,k in pairs(t.Keys) do
					if k==io.KeyCode then
						t.Function(t.Name,io.UserInputState,io)
					end
				end
			end
			FakeMouse:TriggerEvent(b and "KeyDown" or "KeyUp",io.KeyCode.Name:lower())
			UIS:TriggerEvent(b and "InputBegan" or "InputEnded",io,false)
	    end
	end)
	Event.Parent = NLS([==[local Event = script:WaitForChild("UserInput_Event")
	local Mouse = owner:GetMouse()
	local UIS = game:GetService("UserInputService")
	local input = function(io,RobloxHandled)
		if RobloxHandled then return end
		--Since InputObject is a client-side instance, we create and pass table instead
		Event:FireServer({KeyCode=io.KeyCode,UserInputType=io.UserInputType,UserInputState=io.UserInputState,Hit=Mouse.Hit,Target=Mouse.Target})
	end
	UIS.InputBegan:Connect(input)
	UIS.InputEnded:Connect(input)

	local h,t
	--Give the server mouse data every second frame, but only if the values changed
	--If player is not moving their mouse, client won't fire events
	local HB = game:GetService("RunService").Heartbeat
	while true do
		if h~=Mouse.Hit or t~=Mouse.Target then
			h,t=Mouse.Hit,Mouse.Target
			Event:FireServer({isMouse=true,Target=t,Hit=h})
		end
		--Wait 2 frames
		for i=1,2 do
			HB:Wait()
		end
	end]==],script)

	----Sandboxed game object that allows the usage of client-side methods and services
	--Real game object
	local RealGame = game

	--Metatable for fake service
	local FakeService_Metatable = {
		__index = function(self,k)
			local s = rawget(self,"_RealService")
			if s then
				return typeof(s[k])=="function"
				and function(_,...)return s[k](s,...)end or s[k]
			end
		end,
		__newindex = function(self,k,v)
			local s = rawget(self,"_RealService")
			if s then s[k]=v end
		end
	}
	local function FakeService(t,RealService)
		t._RealService = typeof(RealService)=="string" and RealGame:GetService(RealService) or RealService
		return setmetatable(t,FakeService_Metatable)
	end

	--Fake game object
	local FakeGame = {
		GetService = function(self,s)
			return rawget(self,s) or RealGame:GetService(s)
		end,
		Players = FakeService({
			LocalPlayer = FakeService({GetMouse=function(self)return FakeMouse end},Player)
		},"Players"),
		UserInputService = FakeService(UIS,"UserInputService"),
		ContextActionService = FakeService(CAS,"ContextActionService"),
		RunService = FakeService({
			_btrs = {},
			RenderStepped = RealGame:GetService("RunService").Heartbeat,
			BindToRenderStep = function(self,name,_,fun)
				self._btrs[name] = self.Heartbeat:Connect(fun)
			end,
			UnbindFromRenderStep = function(self,name)
				self._btrs[name]:Disconnect()
			end,
		},"RunService")
	}
	rawset(FakeGame.Players,"localPlayer",FakeGame.Players.LocalPlayer)
	FakeGame.service = FakeGame.GetService
	FakeService(FakeGame,game)
	--Changing owner to fake player object to support owner:GetMouse()
	game,owner = FakeGame,FakeGame.Players.LocalPlayer
end

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character
local Animate = Character:FindFirstChild("Animate")

local Humanoid = Character.Humanoid
local HumanoidRootPart = Character["HumanoidRootPart"]
local RootJoint = HumanoidRootPart.RootJoint

local Head = Character["Head"]
local Torso = Character["Torso"]
local RightArm = Character["Right Arm"]
local LeftArm = Character["Left Arm"]
local RightLeg = Character["Right Leg"]
local LeftLeg = Character["Left Leg"]

local Neck = Torso["Neck"]
local LeftShoulder = Torso["Left Shoulder"] 
local RightShoulder = Torso["Right Shoulder"] 
local LeftHip = Torso["Left Hip"] 
local RightHip = Torso["Right Hip"] 

function CreatePart(Parent,Transparency,Reflectance,Material,Color)
	local Part = Instance.new("Part")
	Part.TopSurface = 0
	Part.BottomSurface = 0
	Part.Parent = Parent
	Part.Size = Vector3.new(0.1,0.1,0.1)
	Part.Transparency = Transparency
	Part.Reflectance = Reflectance
	Part.CanCollide = false
	Part.Locked = true
	Part.BrickColor = Color
	Part.Material = Material
	return Part
end

function CreateMesh(Parent,Type,X,Y,Z)
	local Mesh = Instance.new("SpecialMesh",Parent)
	Mesh.MeshType = Type
	Mesh.Scale = Vector3.new(X*10,Y*10,Z*10)
	return Mesh
end

function CreateSpecialMesh(Parent,Asset,X,Y,Z)
	local Mesh = Instance.new("SpecialMesh",Parent)
	Mesh.MeshType = "FileMesh"
	Mesh.MeshId = Asset
	Mesh.Scale = Vector3.new(X,Y,Z)
	return Mesh
end

function CreateSpecialGlowMesh(Parent,Asset,X,Y,Z)
	local Mesh = Instance.new("SpecialMesh",Parent)
	Mesh.MeshType = "FileMesh"
	Mesh.MeshId = Asset
	Mesh.TextureId = "http://www.roblox.com/asset/?id=269748808"
	Mesh.Scale = Vector3.new(X,Y,Z)
	Mesh.VertexColor = Vector3.new(Parent.BrickColor.r, Parent.BrickColor.g, Parent.BrickColor.b)
	return Mesh
end

function CreateWeld(Parent,Part0,Part1,C1X,C1Y,C1Z,C1Xa,C1Ya,C1Za,C0X,C0Y,C0Z,C0Xa,C0Ya,C0Za)
	local Weld = Instance.new("Weld")
	Weld.Parent = Parent
	Weld.Part0 = Part0
	Weld.Part1 = Part1
	Weld.C1 = CFrame.new(C1X,C1Y,C1Z)*CFrame.Angles(C1Xa,C1Ya,C1Za)
	Weld.C0 = CFrame.new(C0X,C0Y,C0Z)*CFrame.Angles(C0Xa,C0Ya,C0Za)
	return Weld
end

local HaloColor = BrickColor.new("Really black")
local TempColor = BrickColor.new("Really black")
local Holder = Instance.new("Model",Character)
local Wings = Instance.new("Model",Character)
local Halo2 = Instance.new("Model",Character)

local TempExraWings = Instance.new("Model",Character)
local TempExraWings2 = Instance.new("Model",Character)

local Handle = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local HandleWeld = CreateWeld(Handle,Torso,Handle,0,-1.5,-1.05,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local Parts = CreatePart(Holder,1,1,"SmoothPlastic",BrickColor.random())
CreateWeld(Parts,RightArm,Parts,0,1,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local Parts2 = CreatePart(Holder,1,1,"SmoothPlastic",BrickColor.random())
CreateWeld(Parts2,LeftArm,Parts2,0,1,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local Handle2 = CreatePart(Halo2,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0,0,0)
local Handle2Weld = CreateWeld(Handle2,Torso,Handle2,0,-1.5,-1.05,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local Values = 10
for Index = 0, 49 do
	Values = Values + 10
	Things = CreatePart(Halo2,0,0,"Neon",HaloColor)
	CreateMesh(Things,"Brick",0.25,0.1,0.1)
	CreateWeld(Things,Handle2,Things,0,1,0,math.rad(0),math.rad(0),math.rad(Values),0,0,0,math.rad(0),math.rad(0),math.rad(0))
end

local Reflection = Instance.new("ParticleEmitter",Handle2)
Reflection.Texture = "rbxassetid://249270319"
Reflection.LightEmission = 0.95
Reflection.Color = ColorSequence.new(BrickColor.new("Really red").Color)
Reflection.Rate = 50
Reflection.Lifetime = NumberRange.new(0.5)
Reflection.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.5,0),NumberSequenceKeypoint.new(0.5,0.75,0),NumberSequenceKeypoint.new(1,0.1,0)})
Reflection.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(0.5,0.25,0),NumberSequenceKeypoint.new(1,1,0)})
Reflection.Speed = NumberRange.new(0,2)
Reflection.Drag = 5
Reflection.LockedToPart = true
Reflection.Rotation = NumberRange.new(-500,500)
Reflection.VelocitySpread = 9000
Reflection.RotSpeed = NumberRange.new(-500,500)

local LeftWing1 = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local LeftWing1Weld = CreateWeld(LeftWing1,Handle,LeftWing1,3,0,0,math.rad(5),math.rad(0),math.rad(12.5),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Wings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,LeftWing1,Welds,0,0,0.25,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Wings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,LeftWing1,Welds,0,0,0.25,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25,0.25)

Welds = CreatePart(Wings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,3)
CreateWeld(Welds,LeftWing1,Welds,0,-0.25,1.75,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A1 = Instance.new('Attachment',Welds)
A1.Position = Vector3.new(0,-0.25,-2)

Welds = CreatePart(Wings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,3,0.5)
CreateWeld(Welds,LeftWing1,Welds,0,-1.75,0.25,math.rad(90),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

TL1 = Instance.new('Trail',Welds)
TL1.Attachment0 = A1
TL1.Attachment1 = A0
TL1.Texture = "rbxassetid://2108945559"
TL1.LightEmission = 1
TL1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
TL1.Color = ColorSequence.new(BrickColor.new('Really red').Color)
TL1.Lifetime = 0.6

local LeftWing2 = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local LeftWing2Weld = CreateWeld(LeftWing2,Handle,LeftWing2,4,1,0,math.rad(10),math.rad(0),math.rad(25),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Wings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,LeftWing2,Welds,0,0,0.25,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Wings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,LeftWing2,Welds,0,0,0.25,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25,0.25)

Welds = CreatePart(Wings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,3)
CreateWeld(Welds,LeftWing2,Welds,0,-0.25,1.75,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A1 = Instance.new('Attachment',Welds)
A1.Position = Vector3.new(0,-0.25,-2)

Welds = CreatePart(Wings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,3,0.5)
CreateWeld(Welds,LeftWing2,Welds,0,-1.75,0.25,math.rad(90),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

TL2 = Instance.new('Trail',Welds)
TL2.Attachment0 = A1
TL2.Attachment1 = A0
TL2.Texture = "rbxassetid://2108945559"
TL2.LightEmission = 1
TL2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
TL2.Color = ColorSequence.new(BrickColor.new('Really red').Color)
TL2.Lifetime = 0.6

local LeftWing3 = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local LeftWing3Weld = CreateWeld(LeftWing3,Handle,LeftWing3,4.75,2,0,math.rad(15),math.rad(0),math.rad(37.5),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Wings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,LeftWing3,Welds,0,0,0.25,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Wings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,LeftWing3,Welds,0,0,0.25,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))
A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25,0.25)

Welds = CreatePart(Wings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,3)
CreateWeld(Welds,LeftWing3,Welds,0,-0.25,1.75,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A1 = Instance.new('Attachment',Welds)
A1.Position = Vector3.new(0,-0.25,-2)

Welds = CreatePart(Wings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,3,0.5)
CreateWeld(Welds,LeftWing3,Welds,0,-1.75,0.25,math.rad(90),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

TL3 = Instance.new('Trail',Welds)
TL3.Attachment0 = A1
TL3.Attachment1 = A0
TL3.Texture = "rbxassetid://2108945559"
TL3.LightEmission = 1
TL3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
TL3.Color = ColorSequence.new(BrickColor.new('Really red').Color)
TL3.Lifetime = 0.6

local LeftWing4 = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local LeftWing4Weld = CreateWeld(LeftWing4,Handle,LeftWing4,5.75,3,0,math.rad(20),math.rad(0),math.rad(50),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,0.5*2)
CreateWeld(Welds,LeftWing4,Welds,0,0,0.25*2,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,0.5*2)
CreateWeld(Welds,LeftWing4,Welds,0,0,0.25*2,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))
A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25*2,0.25*2)

Welds = CreatePart(TempExraWings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,3*2)
CreateWeld(Welds,LeftWing4,Welds,0,-0.25*2,1.75*2,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A1 = Instance.new('Attachment',Welds)
A1.Position = Vector3.new(0,-0.25*2,-2*2)

Welds = CreatePart(TempExraWings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.0*25,3*2,0.5*2)
CreateWeld(Welds,LeftWing4,Welds,0,-1.75*2,0.25*2,math.rad(90),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

TL4 = Instance.new('Trail',Welds)
TL4.Attachment0 = A1
TL4.Attachment1 = A0
TL4.Texture = "rbxassetid://2108945559"
TL4.LightEmission = 1
TL4.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
TL4.Color = ColorSequence.new(BrickColor.new('Really red').Color)
TL4.Lifetime = 0.6

local LeftWing5 = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local LeftWing5Weld = CreateWeld(LeftWing5,Handle,LeftWing5,6.75,4,0,math.rad(25),math.rad(0),math.rad(62.5),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,0.5*2)
CreateWeld(Welds,LeftWing5,Welds,0,0,0.25*2,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,0.5*2)
CreateWeld(Welds,LeftWing5,Welds,0,0,0.25*2,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25*2,0.25*2)

Welds = CreatePart(TempExraWings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,3*2)
CreateWeld(Welds,LeftWing5,Welds,0,-0.25*2,1.75*2,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A1 = Instance.new('Attachment',Welds)
A1.Position = Vector3.new(0,-0.25*2,-2*2)

Welds = CreatePart(TempExraWings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,3*2,0.5*2)
CreateWeld(Welds,LeftWing5,Welds,0,-1.75*2,0.25*2,math.rad(90),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

TL5 = Instance.new('Trail',Welds)
TL5.Attachment0 = A1
TL5.Attachment1 = A0
TL5.Texture = "rbxassetid://2108945559"
TL5.LightEmission = 1
TL5.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
TL5.Color = ColorSequence.new(BrickColor.new('Really red').Color)
TL5.Lifetime = 0.6

local LeftWing6 = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local LeftWing6Weld = CreateWeld(LeftWing6,Handle,LeftWing6,7.75,5,0,math.rad(30),math.rad(0),math.rad(75),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,0.5*2)
CreateWeld(Welds,LeftWing6,Welds,0,0,0.25*2,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,0.5*2)
CreateWeld(Welds,LeftWing6,Welds,0,0,0.25*2,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25*2,0.25*2)
Welds = CreatePart(TempExraWings,0,0,"Neon",HaloColor)

CreateMesh(Welds,"Wedge",0.05*2,0.5*2,3*2)
CreateWeld(Welds,LeftWing6,Welds,0,-0.25*2,1.75*2,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A1 = Instance.new('Attachment',Welds)
A1.Position = Vector3.new(0,-0.25*2,-2*2)

Welds = CreatePart(TempExraWings,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,3*2,0.5*2)
CreateWeld(Welds,LeftWing6,Welds,0,-1.75*2,0.25*2,math.rad(90),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local TL6 = Instance.new('Trail',Welds)
TL6.Attachment0 = A1
TL6.Attachment1 = A0
TL6.Texture = "rbxassetid://2108945559"
TL6.LightEmission = 1
TL6.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
TL6.Color = ColorSequence.new(BrickColor.new('Really red').Color)
TL6.Lifetime = 0.6

TL1.Enabled = false
TL2.Enabled = false
TL3.Enabled = false
TL4.Enabled = false
TL5.Enabled = false
TL6.Enabled = false

local RightWing1 = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local RightWing1Weld = CreateWeld(RightWing1,Handle,RightWing1,-3,0,0,math.rad(5),math.rad(0),math.rad(-12.5),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,RightWing1,Welds,0,0,0.25,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25,0.25)

Welds = CreatePart(Halo2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,RightWing1,Welds,0,0,0.25,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,3)
CreateWeld(Welds,RightWing1,Welds,0,-0.25,1.75,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,3,0.5)
CreateWeld(Welds,RightWing1,Welds,0,-1.75,0.25,math.rad(90),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A1 = Instance.new('Attachment',Welds)
A1.Position = Vector3.new(0,2,0.25)

TR1 = Instance.new('Trail',Welds)
TR1.Attachment0 = A1
TR1.Attachment1 = A0
TR1.Texture = "rbxassetid://2108945559"
TR1.LightEmission = 1
TR1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
TR1.Color = ColorSequence.new(BrickColor.new('Really red').Color)
TR1.Lifetime = 0.6

local RightWing2 = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local RightWing2Weld = CreateWeld(RightWing2,Handle,RightWing2,-4,1,0,math.rad(10),math.rad(0),math.rad(-25),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,RightWing2,Welds,0,0,0.25,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25,0.25)

Welds = CreatePart(Halo2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,RightWing2,Welds,0,0,0.25,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,3)
CreateWeld(Welds,RightWing2,Welds,0,-0.25,1.75,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,3,0.5)
CreateWeld(Welds,RightWing2,Welds,0,-1.75,0.25,math.rad(90),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

A1 = Instance.new('Attachment',Welds)
A1.Position = Vector3.new(0,2,0.25)

TR2 = Instance.new('Trail',Welds)
TR2.Attachment0 = A1
TR2.Attachment1 = A0
TR2.Texture = "rbxassetid://2108945559"
TR2.LightEmission = 1
TR2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
TR2.Color = ColorSequence.new(BrickColor.new('Really red').Color)
TR2.Lifetime = 0.6

local RightWing3 = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local RightWing3Weld = CreateWeld(RightWing3,Handle,RightWing3,-4.75,2,0,math.rad(15),math.rad(0),math.rad(-37.5),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,RightWing3,Welds,0,0,0.25,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25,0.25)

Welds = CreatePart(Halo2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,RightWing3,Welds,0,0,0.25,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,3)
CreateWeld(Welds,RightWing3,Welds,0,-0.25,1.75,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,3,0.5)
CreateWeld(Welds,RightWing3,Welds,0,-1.75,0.25,math.rad(90),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

A1 = Instance.new('Attachment',Welds)
A1.Position = Vector3.new(0,2,0.25)

TR3 = Instance.new('Trail',Welds)
TR3.Attachment0 = A1
TR3.Attachment1 = A0
TR3.Texture = "rbxassetid://2108945559"
TR3.LightEmission = 1
TR3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
TR3.Color = ColorSequence.new(BrickColor.new('Really red').Color)
TR3.Lifetime = 0.6

local RightWing4 = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local RightWing4Weld = CreateWeld(RightWing4,Handle,RightWing4,-5.75,3,0,math.rad(20),math.rad(0),math.rad(-50),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,0.5*2)
CreateWeld(Welds,RightWing4,Welds,0,0,0.25*2,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25*2,0.25*2)

Welds = CreatePart(TempExraWings2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,0.5*2)
CreateWeld(Welds,RightWing4,Welds,0,0,0.25*2,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,3*2)
CreateWeld(Welds,RightWing4,Welds,0,-0.25*2,1.75*2,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,3*2,0.5*2)
CreateWeld(Welds,RightWing4,Welds,0,-1.75*2,0.25*2,math.rad(90),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A1 = Instance.new('Attachment',Welds)
A1.Position = Vector3.new(0,2,0.25)

TR4 = Instance.new('Trail',Welds)
TR4.Attachment0 = A1
TR4.Attachment1 = A0
TR4.Texture = "rbxassetid://2108945559"
TR4.LightEmission = 1
TR4.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
TR4.Color = ColorSequence.new(BrickColor.new('Really red').Color)
TR4.Lifetime = 0.6

local RightWing5 = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local RightWing5Weld = CreateWeld(RightWing5,Handle,RightWing5,-6.75,4,0,math.rad(25),math.rad(0),math.rad(-62.5),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,0.5*2)
CreateWeld(Welds,RightWing5,Welds,0,0,0.25*2,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25*2,0.25*2)

Welds = CreatePart(TempExraWings2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,0.5*2)
CreateWeld(Welds,RightWing5,Welds,0,0,0.25*2,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,3*2)
CreateWeld(Welds,RightWing5,Welds,0,-0.25*2,1.75*2,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,3*2,0.5*2)
CreateWeld(Welds,RightWing5,Welds,0,-1.75*2,0.25*2,math.rad(90),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

A1 = Instance.new('Attachment',Welds)
A1.Position = Vector3.new(0,2,0.25)

TR5 = Instance.new('Trail',Welds)
TR5.Attachment0 = A1
TR5.Attachment1 = A0
TR5.Texture = "rbxassetid://2108945559"
TR5.LightEmission = 1
TR5.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
TR5.Color = ColorSequence.new(BrickColor.new('Really red').Color)
TR5.Lifetime = 0.6

local RightWing6 = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local RightWing6Weld = CreateWeld(RightWing6,Handle,RightWing6,-7.75,3,0,math.rad(30),math.rad(0),math.rad(-75),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,0.5*2)
CreateWeld(Welds,RightWing6,Welds,0,0,0.25*2,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25*2,0.25*2)

Welds = CreatePart(TempExraWings2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,0.5*2)
CreateWeld(Welds,RightWing6,Welds,0,0,0.25*2,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,0.5*2,3*2)
CreateWeld(Welds,RightWing6,Welds,0,-0.25*2,1.75*2,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(TempExraWings2,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05*2,3*2,0.5*2)
CreateWeld(Welds,RightWing6,Welds,0,-1.75*2,0.25*2,math.rad(90),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A1 = Instance.new('Attachment',Welds)
A1.Position = Vector3.new(0,2,0.25)

local TR6 = Instance.new('Trail',Welds)
TR6.Attachment0 = A1
TR6.Attachment1 = A0
TR6.Texture = "rbxassetid://2108945559"
TR6.LightEmission = 1
TR6.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
TR6.Color = ColorSequence.new(BrickColor.new('Really red').Color)
TR6.Lifetime = 0.6

TR4.Enabled = false
TR5.Enabled = false
TR6.Enabled = false
