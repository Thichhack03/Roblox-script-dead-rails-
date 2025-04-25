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
