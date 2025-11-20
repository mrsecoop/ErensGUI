-- EREN’s GUI – Protected with Key "Eren is God"
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local CorrectKey = "Eren is God"  -- exact key (case-insensitive)

-- === KEY LOGIN GUI ===
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "ErenKeyLogin"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = PlayerGui

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 400, 0, 250)
KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 16)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(0, 255, 100)
KeyStroke.Thickness = 4
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 70)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "EREN’s GUI"
KeyTitle.TextColor3 = Color3.fromRGB(0, 255, 100)
KeyTitle.Font = Enum.Font.GothamBlack
KeyTitle.TextSize = 50
KeyTitle.Parent = KeyFrame

local KeySubtitle = Instance.new("TextLabel")
KeySubtitle.Size = UDim2.new(1, 0, 0, 40)
KeySubtitle.Position = UDim2.new(0, 0, 0, 70)
KeySubtitle.BackgroundTransparency = 1
KeySubtitle.Text = "Enter Key to Unlock"
KeySubtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
KeySubtitle.Font = Enum.Font.Gotham
KeySubtitle.TextSize = 22
KeySubtitle.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8, 0, 0, 50)
KeyBox.Position = UDim2.new(0.1, 0, 0.5, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
KeyBox.PlaceholderText = "Type key here..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.new(1, 1, 1)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 20
KeyBox.Parent = KeyFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 10)
BoxCorner.Parent = KeyBox

local LoginBtn = Instance.new("TextButton")
LoginBtn.Size = UDim2.new(0.8, 0, 0, 50)
LoginBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
LoginBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
LoginBtn.Text = "LOGIN"
LoginBtn.TextColor3 = Color3.new(1, 1, 1)
LoginBtn.Font = Enum.Font.GothamBold
LoginBtn.TextSize = 26
LoginBtn.Parent = KeyFrame

local LoginCorner = Instance.new("UICorner")
LoginCorner.CornerRadius = UDim.new(0, 10)
LoginCorner.Parent = LoginBtn

-- === MAIN GUI FUNCTION ===
local function OpenMainGUI()
    KeyGui:Destroy()

    -- Same GUI from before (Eren Premium Money Script)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ErensGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 380, 0, 280)
    Frame.Position = UDim2.new(0.5, -190, 0.5, -140)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Frame.Active = true
    Frame.Draggable = true
    Frame.Parent = ScreenGui

    -- (rest of the GUI exactly like previous version - title, subtitle, 2 buttons, close button)
    -- ... [same code as last message, just copied here for completeness]

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
    Sub.BackgroundTransparency = 1
    Sub.Text = "Eren Premium Money Script"
    Sub.TextColor3 = Color3.fromRGB(200, 200, 200)
    Sub.Font = Enum.Font.GothamBold
    Sub.TextSize = 20
    Sub.Parent = Frame

    -- INFINITE MONEY BUTTON
    local InfButton = Instance.new("TextButton")
    InfButton.Size = UDim2.new(0.8, 0, 0, 60)
    InfButton.Position = UDim2.new(0.1, 0, 0.38, 0)
    InfButton.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
    InfButton.Text = "INFINITE MONEY"
    InfButton.TextColor3 = Color3.new(1, 1, 1)
    InfButton.Font = Enum.Font.GothamBold
    InfButton.TextSize = 26
    InfButton.Parent = Frame
    Instance.new("UICorner", InfButton).CornerRadius = UDim.new(0, 12)

    -- 2.5uuu MONEY BUTTON
    local NormalButton = Instance.new("TextButton")
    NormalButton.Size = UDim2.new(0.8, 0, 0, 60)
    NormalButton.Position = UDim2.new(0.1, 0, 0.65, 0)
    NormalButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    NormalButton.Text = "2.5uuu MONEY"
    NormalButton.TextColor3 = Color3.new(1, 1, 1)
    NormalButton.Font = Enum.Font.GothamBold
    NormalButton.TextSize = 26
    NormalButton.Parent = Frame
    Instance.new("UICorner", NormalButton).CornerRadius = UDim.new(0, 12)

    -- CLOSE BUTTON
    local Close = Instance.new("TextButton")
    Close.Size = UDim2.new(0, 40, 0, 40)
    Close.Position = UDim2.new(1, -50, 0, 10)
    Close.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Close.Text = "X"
    Close.TextColor3 = Color3.new(1, 1, 1)
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 30
    Close.Parent = Frame
    Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 10)
    Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- BUTTON FUNCTIONS
    InfButton.MouseButton1Click:Connect(function()
        InfButton.Text = "GIVING INFINITE..."
        InfButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
        local args = {7000001, -math.huge}
        game:GetService("ReplicatedStorage"):WaitForChild("Tool"):WaitForChild("DrawUp"):WaitForChild("Msg"):WaitForChild("DrawHero"):InvokeServer(unpack(args))
        wait(1.2); InfButton.Text = "INFINITE DONE ✓"; InfButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        wait(1.5); InfButton.Text = "INFINITE MONEY"; InfButton.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
    end)

    NormalButton.MouseButton1Click:Connect(function()
        NormalButton.Text = "GIVING 2.5uuu..."
        NormalButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
        local args = {7000065, -2000}
        game:GetService("ReplicatedStorage"):WaitForChild("Tool"):WaitForChild("DrawUp"):WaitForChild("Msg"):WaitForChild("DrawHero"):InvokeServer(unpack(args))
        wait(1.2); NormalButton.Text = "2.5uuu DONE ✓"; NormalButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        wait(1.5); NormalButton.Text = "2.5uuu MONEY"; NormalButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    end)
end

-- === KEY CHECK ===
LoginBtn.MouseButton1Click:Connect(function()
    if string.lower(KeyBox.Text) == string.lower(CorrectKey) then
        KeyBox.Text = "ACCESS GRANTED!"
        wait(1)
        OpenMainGUI()
    else
        KeyBox.Text = "WRONG KEY!"
        KeyBox.TextColor3 = Color3.fromRGB(255, 0, 0)
        wait(2)
        KeyBox.Text = ""
        KeyBox.TextColor3 = Color3.new(1, 1, 1)
    end
end)

print("EREN’s GUI – Type the key 'Eren is God' to unlock")
