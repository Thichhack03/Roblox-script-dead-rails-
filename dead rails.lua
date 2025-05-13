local collected = 0
local total = 0

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 60)
Frame.Position = UDim2.new(0, 20, 0, 20)
Frame.BackgroundTransparency = 0.3
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

local Label = Instance.new("TextLabel", Frame)
Label.Size = UDim2.new(1, 0, 1, 0)
Label.BackgroundTransparency = 1
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.TextScaled = true
Label.Text = "Collecting Bonds..."

-- Function to update UI
local function updateUI()
    Label.Text = "Bonds: " .. collected .. "/" .. total
end

-- Collect all bonds
local function collectBonds()
    for _, bond in pairs(workspace:GetDescendants()) do
        if bond:IsA("Part") and bond.Name == "Bond" then
            total = total + 1
            pcall(function()
                bond.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                collected = collected + 1
                updateUI()
            end)
        end
    end
end

collectBonds()
