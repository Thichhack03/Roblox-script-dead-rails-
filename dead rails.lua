local Player = game.Players.LocalPlayer
local Bonds = workspace:GetDescendants()
local collected = 0

for _, bond in ipairs(Bonds) do
    if bond:IsA("Part") and bond.Name:lower():find("bond") then
        if bond:FindFirstChild("TouchInterest") then
            Player.Character:PivotTo(bond.CFrame + Vector3.new(0, 3, 0))
            wait(0.2)
            collected += 1
        end
    end
end

warn("Đã thu thập xong: " .. collected .. " bonds.")
-- UI hiển thị số Bonds đã nhặt và còn lại
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "BondCounter"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 70)
Frame.Position = UDim2.new(0, 10, 0, 10)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Draggable = true
Frame.Active = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0.4, 0)
Title.BackgroundTransparency = 1
Title.Text = "Bond Counter"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true

local CountLabel = Instance.new("TextLabel", Frame)
CountLabel.Position = UDim2.new(0, 0, 0.4, 0)
CountLabel.Size = UDim2.new(1, 0, 0.6, 0)
CountLabel.BackgroundTransparency = 1
CountLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
CountLabel.Font = Enum.Font.SourceSans
CountLabel.TextScaled = true
CountLabel.Text = "Đang quét..."
-- Đếm và cập nhật liên tục
local total = 0
local collected = 0
local found = {}

for _, bond in ipairs(workspace:GetDescendants()) do
    if bond:IsA("Part") and bond.Name:lower():find("bond") then
        total += 1
        table.insert(found, bond)
    end
end

collected = 0

local function updateCounter()
    CountLabel.Text = "Đã nhặt: " .. collected .. "/" .. total
end

task.spawn(function()
    for _, bond in ipairs(found) do
        if bond and bond.Parent and bond:IsDescendantOf(workspace) then
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = bond.CFrame + Vector3.new(0, 3, 0)
                wait(0.2)
                collected += 1
                updateCounter()
            end
        end
    end
end)

updateCounter()
