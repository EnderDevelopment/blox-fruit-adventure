local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local tool = script.Parent
local remote = ReplicatedStorage:WaitForChild("FruitAbilityEvent")
local mouse
local debounce = false
local localCooldown = 4

local function getMouse()
	if not mouse then
		mouse = player:GetMouse()
	end
	return mouse
end

tool.Activated:Connect(function()
	if debounce then
		return
	end

	local currentMouse = getMouse()
	if not currentMouse or not currentMouse.Hit then
		return
	end

	debounce = true
	remote:FireServer(currentMouse.Hit.Position)
	task.delay(localCooldown, function()
		debounce = false
	end)
end)
