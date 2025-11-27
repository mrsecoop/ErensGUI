-- ☣️ EREN’s GUI HUB (No Delete Button + Proper Minimize Alignment)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local showLocalUI = ReplicatedStorage.LocalMsg.showLocalUI
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ERENsGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Hub Frame (opens normally on execution ✅)
local Frame = Instance.new("Frame")
Frame.Name = "MainHub"
Frame.Size = UDim2.new(0, 240, 0, 300)
Frame.Position = UDim2.new(0.5, -120, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Visible = true
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = Frame

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 1
Stroke.Color = Color3.fromRGB(55, 55, 80)
Stroke.Transparency = 0.75
Stroke.Parent = Frame

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "HubTitle"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "EREN’s GUI"
Title.TextColor3 = Color3.fromRGB(200, 200, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.Parent = Frame

-- ❌ DELETE (Close ×) BUTTON REMOVED ❌
-- ✅ Minimize button aligned properly now
local Minimize = Instance.new("TextButton")
Minimize.Name = "MinimizeBtn"
Minimize.Size = UDim2.new(0, 34, 0, 34) -- slightly bigger tap area ✅
Minimize.Position = UDim2.new(1, -42, 0, 4) -- properly adjusted ✅
Minimize.BackgroundTransparency = 1
Minimize.Text = "–"
Minimize.TextColor3 = Color3.fromRGB(150,150,255)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 26
Minimize.Parent = Frame

-- Minimized Icon (EY) — appears only after minimize ✅
local MiniIcon = Instance.new("TextButton")
MiniIcon.Name = "MiniIcon"
MiniIcon.Size = UDim2.new(0, 50, 0, 50) -- square & large ✅
MiniIcon.Position = Minimize.Position -- same position as minimize ✅
MiniIcon.BackgroundColor3 = Color3.fromRGB(28,28,42)
MiniIcon.Text = "EY"
MiniIcon.Font = Enum.Font.GothamBlack
MiniIcon.TextSize = 24
MiniIcon.BorderSizePixel = 0
MiniIcon.Visible = false -- ❗hidden on execute
MiniIcon.Active = true
MiniIcon.Draggable = true
MiniIcon.Parent = ScreenGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 8)
MiniCorner.Parent = MiniIcon

-- ☢️ Ultra bright poison green gradient ✅
local PoisonGradient = Instance.new("UIGradient")
PoisonGradient.Rotation = 90
PoisonGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(190,255,190)), -- super bright glow ✅
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,255,0))     -- pure toxic neon ✅
}
PoisonGradient.Parent = MiniIcon

-- Black outline so text never mixes into dark icon ✅
local TextStroke = Instance.new("UIStroke")
TextStroke.Thickness = 2.5
TextStroke.Color = Color3.fromRGB(0,0,0)
TextStroke.Parent = MiniIcon

-- ✅ Minimize & Restore logic
Minimize.MouseButton1Click:Connect(function()
    Frame.Visible = false
    MiniIcon.Visible = true -- show icon ✅
end)

MiniIcon.MouseButton1Click:Connect(function()
    Frame.Visible = true
    MiniIcon.Visible = false -- hide icon ✅
end)

-- Scrolling Section
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -14, 1, -50)
Scroll.Position = UDim2.new(0, 7, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = Color3.fromRGB(80,80,120)
Scroll.CanvasSize = UDim2.new(0,0,0,500)
Scroll.Parent = Frame

local List = Instance.new("UIListLayout")
List.Padding = UDim.new(0,8)
List.Parent = Scroll

local function AddButton(name, text)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -8, 0, 42)
    Btn.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
    Btn.Text = " " .. text
    Btn.TextColor3 = Color3.fromRGB(220,220,255)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 16
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Parent = Scroll

    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0,8)
    BCorner.Parent = Btn

    local BStroke = Instance.new("UIStroke")
    BStroke.Thickness = 1
    BStroke.Color = Color3.fromRGB(70,70,110)
    BStroke.Transparency = 0.8
    BStroke.Parent = Btn

    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(45,45,75)}):Play()
    end)

    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(28,28,42)}):Play()
    end)

    Btn.MouseButton1Click:Connect(function()
        firesignal(showLocalUI.Event, name)
    end)
end

-- Buttons
AddButton("WingShop",        "🛡️ Wings Shop")
AddButton("FusePet",         "🔗 Fuse Pet")
AddButton("MagicPet",        "✨ Enchant Pet")
AddButton("WingEnchantment", "🔥 Wing Enchant")
AddButton("Titan Pet",       "🤖 Titan Machine")

-- ✅ Auto adjust scroll size
List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0,0,0, List.AbsoluteContentSize.Y + 15)
end)

print("☣️ EREN’s GUI Loaded • Delete Button Removed • Minimize Aligned ✅")
