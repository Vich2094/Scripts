local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local Chat = game:GetService("Chat")

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local Configuration = {
	Scripts = {"LocalScript", "ModuleScript"},
	Remotes = {"RemoteEvent", "RemoteFunction", "BindableEvent", "BindableFunction"},
	
	Services = {"StarterPlayerScripts", "StarterCharacterScripts"},
	Replace = {["'"] = "&apos;", ["\""] = "&quot;", ["<"] = "&lt;", [">"] = "&gt;", ["&"] = "&amp;"},
	
	Threads = 5,
	Version = 4,

	Ignored = {RobloxReplicatedStorage, CoreGui, CorePackages, Chat},

	StringFormats = {
		Welcome = "Welcome to UniversalScriptSumper v%d!",
		DecompilingScripts = "Decompiling %d scripts...",
		DecompilingScriptsProgress = "Decompiling scripts... (%d / %d)",
		FileSave = "Scripts for %s (%d) [%d].rbxlx",
		FinalOutput = "Scripts have been saved to file %q, took %d seconds for %d scripts"
	},

	Strings = {
		Credits = "Stefanuk12",
		CollectingScripts = "Collecting scripts...",
		CreatingXMLLayout = "Creating XML Layout...",
		DecompileFail = "-- Failed to decompile script, or script is empty",
		DecompileFailTimeout = "-- Failed to decompile script (timed out)"
	}
}

local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local GameInfo = MarketplaceService:GetProductInfo(game.PlaceId)
local GameName = GameInfo.Name:gsub("[^%w%s]", "")
local Viewport = CurrentCamera.ViewportSize

local Output
local Hierarchy
local ScriptCount
local DoneScripts
local NeedsDecompile
local LoadedIds

for _, Player in ipairs(Players:GetPlayers()) do
	if (Player ~= LocalPlayer) then
		table.insert(Configuration.Ignored, Player)
		table.insert(Configuration.Ignored, Player.Character)
	end
end

local CompleteBar = Drawing.new("Square")
CompleteBar.Filled = true
CompleteBar.Size = Vector2.new(500, 25)
CompleteBar.Position = Vector2.new(Viewport.X / 2 - CompleteBar.Size.X / 2, Viewport.Y - 100)
CompleteBar.Color = Color3.new(0, 0, 0)

local ProgressBar = Drawing.new("Square")
ProgressBar.Color = Color3.new(1, 1, 1)
ProgressBar.Filled = true
ProgressBar.Position = CompleteBar.Position
ProgressBar.Size = Vector2.new(0, 25)
ProgressBar.Color = Color3.new(1, 1, 1)

local ProgressText = Drawing.new("Text")
ProgressText.Color = Color3.new(1, 1, 1)
ProgressText.Center = true
ProgressText.Size = ProgressBar.Size.Y
ProgressText.Position = ProgressBar.Position + Vector2.new(CompleteBar.Size.X / 2, 35)
ProgressText.Color = Color3.new(1, 1, 1)

local Credits = Drawing.new("Text")
Credits.Color = Color3.new(1, 1, 1)
Credits.Position = Vector2.new(Viewport.X - 100, Viewport.Y - 25)
Credits.Size = 15
Credits.Color = Color3.new(1, 1, 1)

local function IsAllowed(Item)
	for _, Object in ipairs(Configuration.Ignored) do
		if (Item == Object or Item:IsDescendantOf(Object)) then
			return false
		end
	end

	return true
end

local function GetParentTree(Object)
	local Trees = {}
	while (Object.Parent ~= nil and Object.Parent ~= game) do
		Object = Object.Parent
		table.insert(Trees, 1, Object)
	end

	return Trees
end

function GetScripts(Objects, CheckLoaded)
	for _, Object in ipairs(Objects) do
		if (typeof(Object) == "Instance" and IsAllowed(Object)) then
			local ObjectClassName = Object.ClassName

			if (table.find(Configuration.Remotes, ObjectClassName) or table.find(Configuration.Scripts, ObjectClassName)) then
				local ObjectDebugId = Object:GetDebugId()

				if (Object.Parent == nil) then
					Hierarchy["NIL"].Children[ObjectDebugId] = {Class = ObjectClassName, Ref = Object, Children = {}}
				else
					local Start = Hierarchy
					
					for _, Branch in ipairs(GetParentTree(Object)) do
						local BranchDebugId = Branch:GetDebugId()
						local BranchClassName = Branch.ClassName

						if (Start[BranchDebugId] == nil) then
							if (game:FindService(BranchClassName) or table.find(Configuration.Services, BranchClassName)) then
								Start[BranchDebugId] = {Class = BranchClassName, Ref = Branch, Children = {}}
							else
								Start[BranchDebugId] = {Class = "Folder", Ref = Branch, Children = {}}
							end
						end
						Start = Start[BranchDebugId].Children
					end

					Start[ObjectDebugId] = {Class = ObjectClassName, Ref = Object, Children = {}}
				end

				if (CheckLoaded) then
					if (table.find(Configuration.Scripts, ObjectClassName) and not table.find(LoadedIds, ObjectDebugId)) then
						Hierarchy["LOADED MODULES"].Children[ObjectDebugId] = {Class = ObjectClassName, Ref = Object, Children = {}}
					end
				else
					table.insert(LoadedIds, ObjectDebugId)
				end
			end
		end
	end

	return Hierarchy
end

local function MakeInstance(ClassName, Name, Object)
	table.insert(Output, '<Item class="' .. ClassName .. '" referent="RBX' .. #Output .. '"><Properties>')
	table.insert(Output, '<string name="Name">' .. Name:gsub("['\"<>&]", Configuration.Replace) .. '</string>')

	if (Object and table.find(Configuration.Scripts, Object.ClassName)) then
		if (Object.ClassName == "LocalScript") then
			table.insert(Output, '<bool name="Disabled">' .. tostring(Object.Disabled) .. '</bool>')
		end

		table.insert(Output, '<ProtectedString name="Source"><![CDATA[')
		table.insert(Output, "") -- // haha funny stole from moon
		table.insert(Output, ']]></ProtectedString>')
		table.insert(NeedsDecompile, {Script = Object, Index = #Output - 1})
	end

	table.insert(Output, "</Properties>")
end

local function SaveHierarchy(Tree)
	for Name, Object in pairs(Tree) do
		local ObjectRef = Object.Ref
		MakeInstance(Object.Class, ObjectName, ObjectRef)
		SaveHierarchy(Object.Children)
		table.insert(Output, "</Item>")
	end
end

local function Main(_Configuration)
	local StartTime = tick()
	Configuration = _Configuration or Configuration

	Output = {'<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.roblox.com/roblox.xsd" version="4">'}
	Hierarchy = {["NIL"] = {Class = "Folder", Children = {}}, ["LOADED MODULES"] = {Class = "Folder", Children = {}}}

	ScriptCount = 0
	DoneScripts = 0
	NeedsDecompile = {}
	LoadedIds = {}

	ProgressText.Text = Configuration.StringFormats.Welcome:format(Configuration.Version)
	Credits.Text = Configuration.Strings.Credits

	ProgressBar.Visible = true
	CompleteBar.Visible = true
	Credits.Visible = true
	
	ProgressText.Visible = true
	task.wait(1)
	ProgressText.Text = Configuration.Strings.CollectingScripts
	
	GetScripts(game:GetDescendants())
	GetScripts(getnilinstances())
	GetScripts(getloadedmodules(), true)
	
	LoadedIds = nil
	task.wait(1)

	ProgressText.Text = Configuration.Strings.CreatingXMLLayout
	SaveHierarchy(Hierarchy)
	ScriptCount = #NeedsDecompile
	table.insert(Output, "</roblox>")
	task.wait(0.5)

	ProgressText.Text = Configuration.StringFormats.DecompilingScripts:format(ScriptCount)
	local RunningCount = Configuration.Threads

	for Index = 1, Configuration.Threads do
		task.spawn(function()
			while (#NeedsDecompile > 0) do
				local Data = table.remove(NeedsDecompile)
				local DecompileStartTime = tick()
				local Result

				task.spawn(function()
					rconsoleprint("Decompiling script: " .. Data.Script:GetFullName() .. "\n")
					if (Data.Script.Name == "Modular") then writefile("Modular.lua", getscriptbytecode(Data.Script)) task.wait(15) end
					result = decompile(Data.Script, false, 30)
				end)

				repeat task.wait() until Result ~= nil or tick() - DecompileStartTime >= 30

				if (Result ~= nil) then
					Output[Data.Index] = (Result == "" and Configuration.Strings.DecompileFail or Result)
				else
					Output[Data.Index] = Configuration.Strings.DecompileFailTimeout
				end
				task.wait()

				DoneScripts = DoneScripts + 1
				ProgressBar.Size = Vector2.new(500 * DoneScripts / ScriptCount, ProgressBar.Size.Y)
				ProgressText.Text = Configuration.StringFormats.DecompilingScriptsProgress:format(DoneScripts, ScriptCount)
			end

			RunningCount = RunningCount - 1
		end)
	end

	while (RunningCount > 0) do
		task.wait(0.5)
	end
	task.wait(1)

	ProgressBar.Visible = false
	CompleteBar.Visible = false

	local SaveName = Configuration.StringFormats.FileSave:format(GameName, game.PlaceId, os.time())
	writefile(SaveName, table.concat(Output, "\n"))

	ProgressText.Text = Configuration.StringFormats.FinalOutput:format(SaveName, tick() - StartTime, ScriptCount)
	task.wait(5)

	Credits.Visible = false
	ProgressText.Visible = false
end

return Main