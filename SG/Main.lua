--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==
-- || Compatibility || --
--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==

if game:GetService("RunService"):IsClient() then error("Script must be server-side in order to work; use h/ and not hl/") end
local Player,game,owner = owner,game
local RealPlayer = Player
do
	print("FE Compatibility code V2 by Mokiros")
	local RealPlayer = RealPlayer
	script.Parent = RealPlayer.Character

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

    local FakeMouse = {Hit=CFrame.new(),KeyUp=fakeEvent(),KeyDown=fakeEvent(),Button1Up=fakeEvent(),Button1Down=fakeEvent(),Button2Up=fakeEvent(),Button2Down=fakeEvent()}
    FakeMouse.keyUp = FakeMouse.KeyUp
    FakeMouse.keyDown = FakeMouse.KeyDown
	local UIS = {InputBegan=fakeEvent(),InputEnded=fakeEvent()}
	local CAS = {Actions={},BindAction=function(self,name,fun,touch,...)
		CAS.Actions[name] = fun and {Name=name,Function=fun,Keys={...}} or nil
	end}

	CAS.UnbindAction = CAS.BindAction

	local function TriggerEvent(self,ev,...)
		for _,f in pairs(self[ev].Functions) do
			f(...)
		end
	end
	FakeMouse.TriggerEvent = TriggerEvent
	UIS.TriggerEvent = TriggerEvent

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

	local RealGame = game

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

	game,owner = FakeGame,FakeGame.Players.LocalPlayer
end

--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==
-- || Heartbeat || --
--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==

function Swait(Duration)
	if (Duration == 0 or typeof(Duration) ~= "number") then
		game:GetService("RunService").PreAnimation:Wait()
	else
		for Index = 1, Duration * 30 do
			game:GetService("RunService").PreAnimation:Wait()
		end
	end
end

--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==
-- || Variables || --
--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==

local Attack = false
local Animation = "Idle"

local Sine = 0
local Change = 1
local Mode = 1

--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==
-- || Related || --
--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==

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

--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==
-- || Functions || --
--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==

function QuaternionFromCFrame(cf) 
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components() 
	local trace = m00 + m11 + m22 
	if trace > 0 then 
		local s = math.sqrt(1 + trace) 
		local recip = 0.5/s 
		return (m21-m12)*recip, (m02-m20)*recip, (m10-m01)*recip, s*0.5 
	else 
		local i = 0 
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then 
			i = 2 
		end 
		if i == 0 then 
			local s = math.sqrt(m00-m11-m22+1) 
			local recip = 0.5/s 
			return 0.5*s, (m10+m01)*recip, (m20+m02)*recip, (m21-m12)*recip 
		elseif i == 1 then 
			local s = math.sqrt(m11-m22-m00+1) 
			local recip = 0.5/s 
			return (m01+m10)*recip, 0.5*s, (m21+m12)*recip, (m02-m20)*recip 
		elseif i == 2 then 
			local s = math.sqrt(m22-m00-m11+1) 
			local recip = 0.5/s return (m02+m20)*recip, (m12+m21)*recip, 0.5*s, (m10-m01)*recip 
		end 
	end 
end

function QuaternionToCFrame(px, py, pz, x, y, z, w) 
	local xs, ys, zs = x + x, y + y, z + z 
	local wx, wy, wz = w*xs, w*ys, w*zs 
	local xx = x*xs 
	local xy = x*ys 
	local xz = x*zs 
	local yy = y*ys 
	local yz = y*zs 
	local zz = z*zs 
	return CFrame.new(px, py, pz,1-(yy+zz), xy - wz, xz + wy,xy + wz, 1-(xx+zz), yz - wx, xz - wy, yz + wx, 1-(xx+yy)) 
end

function QuaternionSlerp(a, b, t) 
	local cosTheta = a[1]*b[1] + a[2]*b[2] + a[3]*b[3] + a[4]*b[4] 
	local startInterp, finishInterp; 
	if cosTheta >= 0.0001 then 
		if (1 - cosTheta) > 0.0001 then 
			local theta = math.acos(cosTheta) 
			local invSinTheta = 1/math.sin(theta) 
			startInterp = math.sin((1-t)*theta)*invSinTheta 
			finishInterp = math.sin(t*theta)*invSinTheta  
		else 
			startInterp = 1-t 
			finishInterp = t 
		end 
	else 
		if (1+cosTheta) > 0.0001 then 
			local theta = math.acos(-cosTheta) 
			local invSinTheta = 1/math.sin(theta) 
			startInterp = math.sin((t-1)*theta)*invSinTheta 
			finishInterp = math.sin(t*theta)*invSinTheta 
		else 
			startInterp = t-1 
			finishInterp = t 
		end 
	end 
	return a[1]*startInterp + b[1]*finishInterp, a[2]*startInterp + b[2]*finishInterp, a[3]*startInterp + b[3]*finishInterp, a[4]*startInterp + b[4]*finishInterp 
end

function Clerp(a,b,t) 
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)} 
	local ax, ay, az = a.x, a.y, a.z 
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1-t
	return QuaternionToCFrame(_t*ax + t*bx, _t*ay + t*by, _t*az + t*bz,QuaternionSlerp(qa, qb, t)) 
end 

--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==
-- || Caster || --
--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==

function Caster(Pos, Dir, Max, Ignore)
	return game:service("Workspace"):FindPartOnRay(Ray.new(Pos, Dir.unit * (Max or 999.999)), Ignore) 
end 

--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==
-- || Creations || --
--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==

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

--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==
-- || Modles || --
--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==

local HaloColor = BrickColor.new("Really red")
local TempColor = BrickColor.new("Really red")
local Holder = Instance.new("Model",Character)
local Wings = Instance.new("Model",Character)
local Halo = Instance.new("Model",Character)

local TempExraWings = Instance.new("Model",Character)
local TempExraWings2 = Instance.new("Model",Character)

local Handle = CreatePart(Holder,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0.5,0.5,0.5)
local HandleWeld = CreateWeld(Handle,Torso,Handle,0,-1.5,-1.05,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local Parts = CreatePart(Holder,1,1,"SmoothPlastic",BrickColor.random())
CreateWeld(Parts,RightArm,Parts,0,1,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local Parts2 = CreatePart(Holder,1,1,"SmoothPlastic",BrickColor.random())
CreateWeld(Parts2,LeftArm,Parts2,0,1,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local Handle2 = CreatePart(Halo,1,1,"Neon",TempColor)
CreateMesh(Handle,"Brick",0,0,0)
local Handle2Weld = CreateWeld(Handle2,Torso,Handle2,0,-1.5,-1.05,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local Values = 10
for Index = 0, 49 do
	Values = Values + 10
	Things = CreatePart(Halo,0,0,"Neon",HaloColor)
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

Welds = CreatePart(Halo,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,RightWing1,Welds,0,0,0.25,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25,0.25)

Welds = CreatePart(Halo,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,RightWing1,Welds,0,0,0.25,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,3)
CreateWeld(Welds,RightWing1,Welds,0,-0.25,1.75,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo,0,0,"Neon",HaloColor)
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

Welds = CreatePart(Halo,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,RightWing2,Welds,0,0,0.25,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25,0.25)

Welds = CreatePart(Halo,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,RightWing2,Welds,0,0,0.25,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,3)
CreateWeld(Welds,RightWing2,Welds,0,-0.25,1.75,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo,0,0,"Neon",HaloColor)
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

Welds = CreatePart(Halo,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,RightWing3,Welds,0,0,0.25,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local A0 = Instance.new('Attachment',Welds)
A0.Position = Vector3.new(0,0.25,0.25)

Welds = CreatePart(Halo,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,0.5)
CreateWeld(Welds,RightWing3,Welds,0,0,0.25,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo,0,0,"Neon",HaloColor)
CreateMesh(Welds,"Wedge",0.05,0.5,3)
CreateWeld(Welds,RightWing3,Welds,0,-0.25,1.75,math.rad(0),math.rad(90),math.rad(90),0,0,0,math.rad(0),math.rad(0),math.rad(0))

Welds = CreatePart(Halo,0,0,"Neon",HaloColor)
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

--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==
-- || Checks || --
--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==

for Index, Value in pairs(Wings:GetChildren()) do
	if Value:IsA("Part") then
		Value.BrickColor = BrickColor.new("Really red")
		Value.Material = "Neon"
	end
end

for Index, Value in pairs(Halo:GetChildren()) do
	if Value:IsA("Part") then
		Value.BrickColor = BrickColor.new("TempExtraWings")
		Value.Material = "Neon"
	end
end

for Index, Value in pairs(Wings:GetChildren()) do
	if Value:IsA("Part") then
		Value.BrickColor = BrickColor.new("Really red")
		Value.Material = "Neon"
	end
end

for Index, Value in pairs(TempExraWings:GetChildren()) do
	if Value:IsA("Part") then
		Value.Transparency = 1
		Value.BrickColor = BrickColor.new("Really red")
		Value.Material = "Neon"
	end
end

for Index, Value in pairs(TempExraWings2:GetChildren()) do
	if Value:IsA("Part") then
		Value.Transparency = 1
		Value.BrickColor = BrickColor.new("Really red")
		Value.Material = "Neon"
	end
end

--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==
-- || Animations || --
--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==

local Animations = game:GetService("RunService").Heartbeat:Connect(function()
	Swait()
	Sine = Sine + Change
	
	LeftWing1Weld.C1 = Clerp(LeftWing1Weld.C1,CFrame.new(2,0,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))*CFrame.Angles(math.rad(5 + 10 * math.cos(Sine / 32)),math.rad(0),math.rad(12.5 + 5 * math.cos(Sine / 32))),.3)
	LeftWing2Weld.C1 = Clerp(LeftWing2Weld.C1,CFrame.new(3,1,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))*CFrame.Angles(math.rad(10 + 15 * math.cos(Sine / 32)),math.rad(0),math.rad(25 + 7.5 * math.cos(Sine / 32))),.3)
	LeftWing3Weld.C1 = Clerp(LeftWing3Weld.C1,CFrame.new(3.75,2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))*CFrame.Angles(math.rad(15 + 20 * math.cos(Sine / 32)),math.rad(0),math.rad(37.5 + 10 * math.cos(Sine / 32))),.3)
	LeftWing4Weld.C1 = Clerp(LeftWing4Weld.C1,CFrame.new(4.75,3,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))*CFrame.Angles(math.rad(20 + 25 * math.cos(Sine / 32)),math.rad(0),math.rad(50 + 12.5 * math.cos(Sine / 32))),.3)
	LeftWing5Weld.C1 = Clerp(LeftWing5Weld.C1,CFrame.new(5.75,4,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))*CFrame.Angles(math.rad(25 + 30 * math.cos(Sine / 32)),math.rad(0),math.rad(62.5 + 15 * math.cos(Sine / 32))),.3)
	LeftWing6Weld.C1 = Clerp(LeftWing6Weld.C1,CFrame.new(6.75,5,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))*CFrame.Angles(math.rad(30 + 35 * math.cos(Sine / 32)),math.rad(0),math.rad(75 + 17.5 * math.cos(Sine / 32))),.3)
	
	RightWing1Weld.C1 = Clerp(RightWing1Weld.C1,CFrame.new(-2,0,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))*CFrame.Angles(math.rad(5 + 10 * math.cos(Sine / 32)),math.rad(0),math.rad(-12.5 - 5 * math.cos(Sine / 32))),.3)
	RightWing2Weld.C1 = Clerp(RightWing2Weld.C1,CFrame.new(-3,1,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))*CFrame.Angles(math.rad(10 + 15 * math.cos(Sine / 32)),math.rad(0),math.rad(-25 - 7.5 * math.cos(Sine / 32))),.3)
	RightWing3Weld.C1 = Clerp(RightWing3Weld.C1,CFrame.new(-3.75,2,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))*CFrame.Angles(math.rad(15 + 20 * math.cos(Sine / 32)),math.rad(0),math.rad(-37.5 - 10 * math.cos(Sine / 32))),.3)
	RightWing4Weld.C1 = Clerp(RightWing4Weld.C1,CFrame.new(-4.75,3,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))*CFrame.Angles(math.rad(20 + 25 * math.cos(Sine / 32)),math.rad(0),math.rad(-50 - 12.5 * math.cos(Sine / 32))),.3)
	RightWing5Weld.C1 = Clerp(RightWing5Weld.C1,CFrame.new(-5.75,4,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))*CFrame.Angles(math.rad(25 + 30 * math.cos(Sine / 32)),math.rad(0),math.rad(-62.5 - 15 * math.cos(Sine / 32))),.3)
	RightWing6Weld.C1 = Clerp(RightWing6Weld.C1,CFrame.new(-6.75,5,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))*CFrame.Angles(math.rad(30 + 35 * math.cos(Sine / 32)),math.rad(0),math.rad(-75 - 17.5 * math.cos(Sine / 32))),.3)
	
	Animate.Parent = nil
	for _, Value in next, Humanoid:GetPlayingAnimationTracks() do
		Value:Stop();
	end

	local Velocity = (HumanoidRootPart.Velocity*Vector3.new(1,0,1)).Magnitude 
	local Hit,Pos = Caster(HumanoidRootPart.Position,(CFrame.new(HumanoidRootPart.Position,HumanoidRootPart.Position - Vector3.new(0,1,0))).LookVector, 4, Character)

	if HumanoidRootPart.Velocity.y > 1 and Hit==nil then 
		Animation = "Jump"
		if Attack == false then
			RightHip.C0=Clerp(RightHip.C0,CFrame.new(1,-0.35 - 0.05 * math.cos(Sine / 25),-0.75)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))*CFrame.Angles(math.rad(-5),math.rad(0),math.rad(-20)),.1)
			LeftHip.C0=Clerp(LeftHip.C0,CFrame.new(-1,-1 - 0.05 * math.cos(Sine / 25),0)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))*CFrame.Angles(math.rad(-5),math.rad(0),math.rad(20)),.1)
			RootJoint.C0=Clerp(RootJoint.C0,CFrame.fromEulerAnglesXYZ(-1.57,0,3.14)*CFrame.new(0,0,0 + 0.05 * math.cos(Sine / 25))*CFrame.Angles(math.rad(-10),math.rad(0),math.rad(0)),.1)
			Torso.Neck.C0=Clerp(Torso.Neck.C0,CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)*CFrame.Angles(math.rad(-2.5),math.rad(0),math.rad(0)),.1)
			RightShoulder.C0=Clerp(RightShoulder.C0,CFrame.new(1.45,0.5 + 0.1 * math.cos(Sine / 25),0)*CFrame.Angles(math.rad(-5),math.rad(0),math.rad(25)),.1)
			LeftShoulder.C0=Clerp(LeftShoulder.C0,CFrame.new(-1.45,0.5 + 0.1 * math.cos(Sine / 25),0)*CFrame.Angles(math.rad(-5),math.rad(0),math.rad(-25)),.1)
		end
	elseif HumanoidRootPart.Velocity.y < -1 and Hit==nil then 
		Animation = "Fall"
		if Attack == false then
			RightHip.C0=Clerp(RightHip.C0,CFrame.new(1,-0.35 - 0.05 * math.cos(Sine / 25),-0.75)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))*CFrame.Angles(math.rad(-5),math.rad(0),math.rad(-20)),.1)
			LeftHip.C0=Clerp(LeftHip.C0,CFrame.new(-1,-1 - 0.05 * math.cos(Sine / 25),0)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))*CFrame.Angles(math.rad(-5),math.rad(0),math.rad(20)),.1)
			RootJoint.C0=Clerp(RootJoint.C0,CFrame.fromEulerAnglesXYZ(-1.57,0,3.14)*CFrame.new(0,0,0 + 0.05 * math.cos(Sine / 25))*CFrame.Angles(math.rad(10),math.rad(0),math.rad(0)),.1)
			Torso.Neck.C0=Clerp(Torso.Neck.C0,CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)*CFrame.Angles(math.rad(2.5),math.rad(0),math.rad(0)),.1)
			RightShoulder.C0=Clerp(RightShoulder.C0,CFrame.new(1.45,0.5 + 0.1 * math.cos(Sine / 25),0)*CFrame.Angles(math.rad(-15),math.rad(0),math.rad(55)),.1)
			LeftShoulder.C0=Clerp(LeftShoulder.C0,CFrame.new(-1.45,0.5 + 0.1 * math.cos(Sine / 25),0)*CFrame.Angles(math.rad(-15),math.rad(0),math.rad(-55)),.1)
		end
	elseif Velocity < 1 and Hit ~= nil then
		Animation = "Idle"
		if Attack == false then
			RightHip.C0=Clerp(RightHip.C0,CFrame.new(1,-1 - 0.1 * math.cos(Sine / 32),0)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))*CFrame.Angles(math.rad(-5),math.rad(-20 - 2 * math.cos(Sine / 56)),math.rad(10 - 3 * math.cos(Sine / 32))),.1)
			LeftHip.C0=Clerp(LeftHip.C0,CFrame.new(-1,-1 - 0.1 * math.cos(Sine / 32),0)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))*CFrame.Angles(math.rad(0),math.rad(0 - 2 * math.cos(Sine / 56)),math.rad(-10 + 3 * math.cos(Sine / 32))),.1)
			RootJoint.C0=Clerp(RootJoint.C0,CFrame.fromEulerAnglesXYZ(-1.57,0,3.14)*CFrame.new(0,0 + 0.03 * math.cos(Sine / 32),0 + 0.1 * math.cos(Sine / 32))*CFrame.Angles(math.rad(10 - 3 * math.cos(Sine / 32)),math.rad(0),math.rad(20 + 2 * math.cos(Sine / 56))),.1)
			Torso.Neck.C0=Clerp(Torso.Neck.C0,CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)*CFrame.Angles(math.rad(17 - 6 * math.cos(Sine / 37)),math.rad(0 + 5 * math.cos(Sine / 43) - 5 * math.cos(Sine / 0.25)),math.rad(-20 - 2 * math.cos(Sine / 56))),.1)
			RightShoulder.C0=Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0)*CFrame.Angles(math.rad(5 + 3 * math.cos(Sine / 43)),math.rad(-16 - 5 * math.cos(Sine / 52)),math.rad(23 + 4 * math.cos(Sine / 37))),.1)
			LeftShoulder.C0=Clerp(LeftShoulder.C0,CFrame.new(-1.5,0.5,0)*CFrame.Angles(math.rad(160),math.rad(0),math.rad(25)),.1)
		end
	elseif Velocity > 2 and Velocity < 22 and Hit ~= nil then
		Animation="Walk"
		if Attack==false then
			if Mode == 1 then
				RightHip.C0=Clerp(RightHip.C0,CFrame.new(1,-1 + 0.05 * math.cos(Sine / 4),0)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))*CFrame.Angles(math.rad(0),math.rad(0 + 5 * math.cos(Sine / 8)),math.rad(0 + 35 * math.cos(Sine / 8))),.1)
				LeftHip.C0=Clerp(LeftHip.C0,CFrame.new(-1,-1 + 0.05 * math.cos(Sine / 4),0)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0))*CFrame.Angles(math.rad(0),math.rad(0 + 5 * math.cos(Sine / 8)),math.rad(0 + 35 * math.cos(Sine / 8))),.1)
				RootJoint.C0=Clerp(RootJoint.C0,CFrame.fromEulerAnglesXYZ(-1.57,0,3.14)*CFrame.new(0,-0.05,-0.05 - 0.05 * math.cos(Sine / 4))*CFrame.Angles(math.rad(5 + 3 * math.cos(Sine / 4)),math.rad(0),math.rad(0 - HumanoidRootPart.RotVelocity.Y - 5 * math.cos(Sine / 8))),.1)
				Torso.Neck.C0=Clerp(Torso.Neck.C0,CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)*CFrame.Angles(math.rad(20 - 3 * math.cos(Sine / 4)),math.rad(0),math.rad(0 - Head.RotVelocity.Y*2.5 + 5 * math.cos(Sine / 8))),.1)
				RightShoulder.C0=Clerp(RightShoulder.C0,CFrame.new(1.5,0.5,0 + 0.25 * math.cos(Sine / 8))*CFrame.Angles(math.rad(0 - 50 * math.cos(Sine / 8)),math.rad(0),math.rad(5 - 10 * math.cos(Sine / 4))),.1)
				LeftShoulder.C0=Clerp(LeftShoulder.C0,CFrame.new(-1.5,0.5,0)*CFrame.Angles(math.rad(160),math.rad(0),math.rad(25)),.1)
			end
		end
	end

	Humanoid.Sit = false
	Humanoid.DisplayName = "?"
	Humanoid.PlatformStand = false
	Humanoid.UseJumpPower = true
	Humanoid.JumpPower = 50
	Humanoid.BreakJointsOnDeath = false
	Humanoid.DisplayDistanceType = "Viewer"

	Humanoid.Name = ""
	Humanoid.RigType = "R6"
	Humanoid.WalkSpeed = 16
	Humanoid.AutoRotate = true

	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead,false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)

	Humanoid.MaxHealth = 100
	Humanoid.Health = 100

	Humanoid.MaxHealth = 9e9
	if Humanoid.Health < 9e9 then
		Humanoid.Health = Humanoid.Health + 9e9
	elseif Humanoid.Health > 9e9 then
		Humanoid.Health = 9e9
	end
end)

--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==
-- || End || --
--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==--**==