--// UI + Hack cho Dead Rails by Thichhack03

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local noclip = false
local espOn = false

-- Xoá UI cũ nếu có
if CoreGui:FindFirstChild("VNMenu") then
    CoreGui:FindFirstChild("VNMenu"):Destroy()
end

-- UI setup
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "VNMenu"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 100, 0, 100) -- hình vuông 3mm ~ 100x100px
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0

-- Cờ VN
local Flag = Instance.new("TextLabel", Frame)
Flag.Size = UDim2.new(1, 0, 0, 30)
Flag.Text = "🇻🇳"
Flag.TextScaled = true
Flag.BackgroundTransparency = 1
Flag.TextColor3 = Color3.new(1,1,1)

-- Nút Noclip
local NoclipBtn = Instance.new("TextButton", Frame)
NoclipBtn.Position = UDim2.new(0, 5, 0, 35)
NoclipBtn.Size = UDim2.new(1, -10, 0, 20)
NoclipBtn.Text = "Noclip: OFF"

-- Nút ESP
local ESPBtn = Instance.new("TextButton", Frame)
ESPBtn.Position = UDim2.new(0, 5, 0, 60)
ESPBtn.Size = UDim2.new(1, -10, 0, 20)
ESPBtn.Text = "ESP: OFF"

frame.Size = UDim2.new(0, 100, 0, 130)
local flyBtn = Instance.new("TextButton", frame)
flyBtn.Position = UDim2.new(0, 5, 0, 110)
flyBtn.Size = UDim2.new(1, -10, 0, 20)
flyBtn.Text = "Fly: OFF"
local flying = false
local flyVelocity = nil

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    flyBtn.Text = "Fly: " .. (flying and "ON" or "OFF")

    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    if flying then
        flyVelocity = Instance.new("BodyVelocity")
        flyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        flyVelocity.Velocity = Vector3.zero
        flyVelocity.Parent = char.HumanoidRootPart

        RunService.RenderStepped:Connect(function()
            if flying and flyVelocity and player.Character then
                local camDir = workspace.CurrentCamera.CFrame.LookVector
                flyVelocity.Velocity = camDir * 50 -- Tốc độ bay
            end
        end)
    else
        if flyVelocity then
            flyVelocity:Destroy()
            flyVelocity = nil
        end
    end
end)

-- Noclip Toggle
RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

NoclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    NoclipBtn.Text = "Noclip: " .. (noclip and "ON" or "OFF")
end)

-- ESP Function
local function highlightTarget(target, color)
    if target:FindFirstChild("Highlight") then return end
    local hl = Instance.new("Highlight", target)
    hl.FillColor = color
    hl.OutlineColor = Color3.new(1,1,1)
    hl.FillTransparency = 0.2
end

local function removeHighlights()
    for _, plr in pairs(game:GetService("Workspace"):GetDescendants()) do
        if plr:IsA("Model") and plr:FindFirstChild("Highlight") then
            plr.Highlight:Destroy()
        end
    end
end

ESPBtn.MouseButton1Click:Connect(function()
    espOn = not espOn
    ESPBtn.Text = "ESP: " .. (espOn and "ON" or "OFF")
    if not espOn then
        removeHighlights()
    end
end)
-- ESP loop
RunService.RenderStepped:Connect(function()
    if not espOn then return end

    for _, model in pairs(workspace:GetDescendants()) do
        if model:IsA("Model") and model:FindFirstChild("Humanoid") then
            local name = model.Name:lower()
            local color = nil
            if name:find("zombie") then color = Color3.fromRGB(0,255,0)
            elseif name:find("ma sói") or name:find("werewolf") then color = Color3.fromRGB(255, 0, 127)
            elseif name:find("ma cà rồng") or name:find("vampire") then color = Color3.fromRGB(128,0,255)
            elseif name:find("cướp") or name:find("robber") then color = Color3.fromRGB(255, 255, 0)
            elseif name:find("sói") then color = Color3.fromRGB(255, 0, 0)
            elseif Players:FindFirstChild(model.Name) and model ~= LocalPlayer.Character then
                color = Color3.fromRGB(0, 170, 255)
            end
            if color then highlightTarget(model, color) end
        end
    end
end)

-- Teleport cuối map (thay đổi vị trí nếu cần)
TPBtn.MouseButton1Click:Connect(function()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        -- Vị trí cuối tùy map, đây chỉ là ví dụ
        root.CFrame = CFrame.new(9999, 100, 0)
    end
end)
