local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

local remote = ReplicatedStorage:FindFirstChild("FruitAbilityEvent")
if not remote then
	remote = Instance.new("RemoteEvent")
	remote.Name = "FruitAbilityEvent"
	remote.Parent = ReplicatedStorage
end

local cooldownSeconds = 4
local damage = 35
local projectileSpeed = 120
local projectileRadius = 3
local maxRange = 180
local lastUsed = {}

local function getCharacterRoot(player)
	local character = player.Character
	if not character then
		return nil
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")
	if not humanoid or humanoid.Health <= 0 or not root then
		return nil
	end

	return character, root
end

local function damageTargets(player, position)
	local character = player.Character
	for _, target in ipairs(workspace:GetPartBoundsInRadius(position, projectileRadius)) do
		local targetModel = target:FindFirstAncestorOfClass("Model")
		local humanoid = targetModel and targetModel:FindFirstChildOfClass("Humanoid")
		if humanoid and targetModel ~= character and humanoid.Health > 0 then
			humanoid:TakeDamage(damage)
		end
	end
end

local function createProjectile(player, origin, direction)
	local projectile = Instance.new("Part")
	projectile.Name = "FlameProjectile"
	projectile.Shape = Enum.PartType.Ball
	projectile.Size = Vector3.new(projectileRadius * 2, projectileRadius * 2, projectileRadius * 2)
	projectile.Material = Enum.Material.Neon
	projectile.Color = Color3.fromRGB(255, 106, 0)
	projectile.CanCollide = false
	projectile.CanTouch = false
	projectile.CanQuery = false
	projectile.CFrame = CFrame.new(origin)
	projectile.Parent = workspace

	local light = Instance.new("PointLight")
	light.Color = Color3.fromRGB(255, 128, 0)
	light.Brightness = 5
	light.Range = 16
	light.Parent = projectile

	local distance = maxRange
	local travelTime = distance / projectileSpeed
	local destination = origin + direction * distance
	local tween = TweenService:Create(projectile, TweenInfo.new(travelTime, Enum.EasingStyle.Linear), {Position = destination})
	local connection
	connection = projectile:GetPropertyChangedSignal("Position"):Connect(function()
		damageTargets(player, projectile.Position)
	end)

	tween.Completed:Once(function()
		if connection then
			connection:Disconnect()
		end
		projectile:Destroy()
	end)

	Debris:AddItem(projectile, travelTime + 1)
	tween:Play()
end

remote.OnServerEvent:Connect(function(player, targetPosition)
	if typeof(targetPosition) ~= "Vector3" then
		return
	end

	local now = os.clock()
	if now - (lastUsed[player] or 0) < cooldownSeconds then
		return
	end

	local character, root = getCharacterRoot(player)
	if not character then
		return
	end

	local tool = character:FindFirstChild("FlameFruit")
	if not tool or not tool:IsA("Tool") then
		return
	end

	local directionVector = targetPosition - root.Position
	if directionVector.Magnitude < 1 then
		return
	end

	lastUsed[player] = now
	local direction = directionVector.Unit
	local origin = root.Position + direction * 5 + Vector3.new(0, 1.5, 0)
	createProjectile(player, origin, direction)
end)

Players.PlayerRemoving:Connect(function(player)
	lastUsed[player] = nil
end)
