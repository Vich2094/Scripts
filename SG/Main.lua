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

local Attack = false
local Animation = "Idle"

local Sine = 0
local Change = 1
local Mode = 1

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

function Caster(Pos, Dir, Max, Ignore)
	return game:service("Workspace"):FindPartOnRay(Ray.new(Pos, Dir.unit * (Max or 999.999)), Ignore) 
end 

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