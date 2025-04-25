local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0, 30, 0, 30)
menu.Position = UDim2.new(0, 100, 0, 100)
menu.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
menu.BorderSizePixel = 1
menu.Active = true
menu.Draggable = true

local swastika = Instance.new("TextLabel", menu)
swastika.Size = UDim2.new(1, 0, 1, 0)
swastika.Text = "+"
swastika.TextScaled = true
swastika.TextColor3 = Color3.fromRGB(255, 255, 255)
swastika.BackgroundTransparency = 1

-- Speed hack --
local speedBtn = Instance.new("TextButton", menu)
speedBtn.Size = UDim2.new(1, 0, 0, 15)
speedBtn.Position = UDim2.new(0, 0, 1, 5)
speedBtn.Text = "Speed: OFF"
speedBtn.TextScaled = true
speedBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
local speedOn = false

speedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    speedBtn.Text = "Speed: " .. (speedOn and "ON" or "OFF")
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speedOn and 48 or 16
    end
end)

-- God mode --
local godBtn = Instance.new("TextButton", menu)
godBtn.Size = UDim2.new(1, 0, 0, 15)
godBtn.Position = UDim2.new(0, 0, 1, 25)
godBtn.Text = "God: OFF"
godBtn.TextScaled = true
godBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
local godOn = false

godBtn.MouseButton1Click:Connect(function()
    godOn = not godOn
    godBtn.Text = "God: " .. (godOn and "ON" or "OFF")
end)

task.spawn(function()
    while true do
        task.wait(0.2)
        if godOn then
            local h = player.Character and player.Character:FindFirstChild("Humanoid")
            if h then h.Health = h.MaxHealth end
        end
    end
end)

-- ESP --
local function createESP(target, color)
    local box = Instance.new("BoxHandleAdornment")
    box.Adornee = target
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Size = target.Size + Vector3.new(0.1, 0.1, 0.1)
    box.Color3 = color
    box.Transparency = 0.5
    box.Parent = target
end

for _, plr in pairs(game.Players:GetPlayers()) do
    if plr ~= player and plr.Character then
        local torso = plr.Character:FindFirstChild("HumanoidRootPart")
        if torso then
            local color = (plr.Team ~= player.Team) and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 170, 255)
            createESP(torso, color)
        end
    end
end

game.Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        task.wait(1)
        local torso = char:WaitForChild("HumanoidRootPart")
        local color = (plr.Team ~= player.Team) and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 170, 255)
        createESP(torso, color)
    end)
end)
