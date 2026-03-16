local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local token = nil

-- ключ розбитий
local k = {"PmTb","siYA","gaQJ","18Na","JU"}
local function getKey()
	return table.concat(k)
end

-- KEY GUI
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "IGORkaKey"
keyGui.ResetOnSpawn = false
keyGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,260,0,160)
frame.Position = UDim2.new(0.5,-130,0.5,-80)
frame.BackgroundColor3 = Color3.fromRGB(35,0,60)
frame.Parent = keyGui
Instance.new("UICorner",frame)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "IGORka HUB Key"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

local box = Instance.new("TextBox")
box.Size = UDim2.new(1,-20,0,35)
box.Position = UDim2.new(0,10,0,60)
box.PlaceholderText = "Enter Key..."
box.TextColor3 = Color3.new(1,1,1)
box.BackgroundColor3 = Color3.fromRGB(80,0,150)
box.Parent = frame
Instance.new("UICorner",box)

local unlock = Instance.new("TextButton")
unlock.Size = UDim2.new(1,-20,0,35)
unlock.Position = UDim2.new(0,10,0,105)
unlock.Text = "Unlock"
unlock.TextColor3 = Color3.new(1,1,1)
unlock.BackgroundColor3 = Color3.fromRGB(120,0,200)
unlock.Parent = frame
Instance.new("UICorner",unlock)

local function startHub()

if token ~= "IGORKA_OK" then
	player:Kick("Key bypass detected")
	return
end

frame:Destroy()

local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local spawnPos = hrp.Position

local insta = false
local speed = false
local espEnabled = false
local speedValue = 40

-- HUB GUI
local gui = Instance.new("ScreenGui")
gui.Name = "IGORkaHub"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0,240,0,210)
main.Position = UDim2.new(0.05,0,0.4,0)
main.BackgroundColor3 = Color3.fromRGB(35,0,60)
main.Parent = gui
Instance.new("UICorner",main)

local title2 = Instance.new("TextLabel")
title2.Size = UDim2.new(1,0,0,35)
title2.Text = "IGORka HUB"
title2.TextColor3 = Color3.new(1,1,1)
title2.Font = Enum.Font.GothamBold
title2.TextSize = 16
title2.BackgroundColor3 = Color3.fromRGB(60,0,110)
title2.Parent = main
Instance.new("UICorner",title2)

-- DRAG GUI
local dragging = false
local dragStart
local startPos

title2.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

title2.InputEnded:Connect(function()
	dragging = false
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

local function makeButton(text,y)

	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1,-20,0,35)
	b.Position = UDim2.new(0,10,0,y)
	b.BackgroundColor3 = Color3.fromRGB(85,0,150)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.Text = text
	b.Parent = main
	Instance.new("UICorner",b)

	return b

end

local instaBtn = makeButton("Insta Steal OFF",45)
local espBtn = makeButton("ESP OFF",90)
local speedBtn = makeButton("Speed OFF",135)
local desyncBtn = makeButton("Desync",180)

-- SPEED
speedBtn.MouseButton1Click:Connect(function()

	speed = not speed
	speedBtn.Text = speed and "Speed ON" or "Speed OFF"
	humanoid.WalkSpeed = speed and speedValue or 16

end)

-- DESYNC
desyncBtn.MouseButton1Click:Connect(function()

	player:LoadCharacter()

	char = player.Character or player.CharacterAdded:Wait()
	humanoid = char:WaitForChild("Humanoid")
	hrp = char:WaitForChild("HumanoidRootPart")

	spawnPos = hrp.Position

end)

-- ESP
local function createESP(plr)

	if plr == player then return end

	local function add(char)

		local root = char:WaitForChild("HumanoidRootPart",5)
		local head = char:WaitForChild("Head",5)

		if not root or not head then return end

		local box = Instance.new("BoxHandleAdornment")
		box.Size = Vector3.new(4,6,2)
		box.Adornee = root
		box.AlwaysOnTop = true
		box.Transparency = 0.3
		box.Color3 = Color3.fromRGB(180,0,255)
		box.Parent = root

		local bill = Instance.new("BillboardGui")
		bill.Size = UDim2.new(0,120,0,20)
		bill.StudsOffset = Vector3.new(0,3,0)
		bill.AlwaysOnTop = true
		bill.Parent = head

		local name = Instance.new("TextLabel")
		name.Size = UDim2.new(1,0,1,0)
		name.BackgroundTransparency = 1
		name.Text = plr.Name
		name.TextColor3 = Color3.fromRGB(200,120,255)
		name.Font = Enum.Font.GothamBold
		name.TextScaled = true
		name.Parent = bill

	end

	if plr.Character then
		add(plr.Character)
	end

	plr.CharacterAdded:Connect(add)

end

local function enableESP()
	for _,p in pairs(Players:GetPlayers()) do
		createESP(p)
	end
end

espBtn.MouseButton1Click:Connect(function()

	espEnabled = not espEnabled
	espBtn.Text = espEnabled and "ESP ON" or "ESP OFF"

	if espEnabled then
		enableESP()
	end

end)

-- INSTA STEAL
instaBtn.MouseButton1Click:Connect(function()

	insta = not insta
	instaBtn.Text = insta and "Insta Steal ON" or "Insta Steal OFF"

	if insta then

		task.delay(2.3,function()
			player:Kick("EZZZ STEAL WITH IGORKA HUB")
		end)

	end

end)

-- плавний рух
RunService.RenderStepped:Connect(function()

	if insta and hrp then

		local dir = spawnPos - hrp.Position
		local dist = dir.Magnitude

		if dist < 3 then
			insta = false
			instaBtn.Text = "Insta Steal OFF"
			return
		end

		local target = CFrame.new(spawnPos)
		hrp.CFrame = hrp.CFrame:Lerp(target,0.08)

	end

end)

end

unlock.MouseButton1Click:Connect(function()

	if box.Text == getKey() then

		token = "IGORKA_OK"
		startHub()

	else

		box.Text = "Wrong Key"

	end

end)
