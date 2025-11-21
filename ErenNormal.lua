local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Directly open the main GUI (no login bullshit anymore)
local function OpenMainGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ErensGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 380, 0, 260)
    Frame.Position = UDim2.new(0.5, -190, 0.5, -130)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Frame.Active = true
    Frame.Draggable = true
    Frame.Parent = ScreenGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 15)
    Corner.Parent = Frame

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(0, 255, 100)
    Stroke.Thickness = 3
    Stroke.Parent = Frame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 60)
    Title.BackgroundTransparency = 1
    Title.Text = "EREN’s GUI"
    Title.TextColor3 = Color3.fromRGB(0, 255, 100)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 40
    Title.Parent = Frame

    local Sub = Instance.new("TextLabel")
    Sub.Size = UDim2.new(1, 0, 0, 35)
    Sub.Position = UDim2.new(0, 0, 0, 55)
    Sub.BackgroundTransparency = Color3.new(1, 1, 1)
    Sub.BackgroundTransparency = 1
    Sub.Text = "Eren Premium Money Script"
    Sub.TextColor3 = Color3.fromRGB(200, 200, 200)
    Sub.Font = Enum.Font.GothamBold
    Sub.TextSize = 20
    Sub.Parent = Frame

    -- 2.5UUU MONEY BUTTON
    local NormalButton = Instance.new("TextButton")
    NormalButton.Size = UDim2.new(0.8, 0, 0, 70)
    NormalButton.AnchorPoint = Vector2.new(0.5, 0.5)
    NormalButton.Position = UDim2.new(0.5, 0, 0.58, 0)
    NormalButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    NormalButton.Text = "2.5UUU MONEY"
    NormalButton.TextColor3 = Color3.new(1, 1, 1)
    NormalButton.Font = Enum.Font.GothamBold
    NormalButton.TextSize = 30
    NormalButton.Parent = Frame

    local NormCorner = Instance.new("UICorner")
    NormCorner.CornerRadius = UDim.new(0, 14)
    NormCorner.Parent = NormalButton

    -- Close Button
    local Close = Instance.new("TextButton")
    Close.Size = UDim2.new(0, 40, 0, 40)
    Close.Position = UDim2.new(1, -50, 0, 10)
    Close.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Close.Text = "X"
    Close.TextColor3 = Color3.new(1, 1, 1)
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 30
    Close.Parent = Frame

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = Close
    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- 2.5UUU MONEY FUNCTION (instant fire)
    NormalButton.MouseButton1Click:Connect(function()
        NormalButton.Text = "GIVING 2.5UUU..."
        NormalButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
        
        local args = {7000065, -2000}
        game:GetService("ReplicatedStorage"):WaitForChild("Tool"):WaitForChild("DrawUp"):WaitForChild("Msg"):WaitForChild("DrawHero"):InvokeServer(unpack(args))
        
        wait(1.2)
        NormalButton.Text = "2.5UUU DONE ✓"
        NormalButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        wait(1.5)
        NormalButton.Text = "2.5UUU MONEY"
        NormalButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    end)
end

-- Execute instantly, no key, no waiting, straight to the money
OpenMainGUI()

print("EREN’s GUI LOADED – NO LOGIN, INSTANT 2.5UUU MONEY EXPLOIT 😈")
