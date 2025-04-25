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
swastika.Text = "🇻🇳"
swastika.TextScaled = true
swastika.TextColor3 = Color3.fromRGB(255, 255, 255)
swastika.BackgroundTransparency = 1

-- God mode --
local godBtn = Instance.new("TextButton", menu)
godBtn.Size = UDim2.new(1, 0, 0, 15)
godBtn.Position = UDim2.new(0, 0, 1, 25)
godBtn.Text = "BT: OFF"
godBtn.TextScaled = true
godBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
local godOn = false

godBtn.MouseButton1Click:Connect(function()
    godOn = not godOn
    godBtn.Text = "BT: " .. (godOn and "ON" or "OFF")
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

-- Noclip --
local noclipBtn = Instance.new("TextButton", menu)
noclipBtn.Size = UDim2.new(1, 0, 0, 15)
noclipBtn.Position = UDim2.new(0, 0, 1, 60)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.TextScaled = true
noclipBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
local noclipOn = false

noclipBtn.MouseButton1Click:Connect(function()
    noclipOn = not noclipOn
    noclipBtn.Text = "Noclip: " .. (noclipOn and "ON" or "OFF")
end)

game:GetService("RunService").Stepped:Connect(function()
    if noclipOn and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide == true then
                part.CanCollide = false
            end
        end
    end
end)
