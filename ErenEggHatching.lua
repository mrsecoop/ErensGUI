-- ☣️ EREN’s EGG HATCHER – Poison RED Icon + Green "EY" Text • FINAL PERFECT VERSION ✅

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ERENsEggHatcher"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local Remote = ReplicatedStorage:WaitForChild("Tool"):WaitForChild("DrawUp"):WaitForChild("Msg"):WaitForChild("DrawHero")

local enabled = false
local loopThread = nil
local selectedEggID = nil
local selectedAmount = 1
local currentDropdown = nil

local Worlds = {
    ["World 1"]  = {["Egg 1"] = 7000001, ["Egg 2"] = 7000002, ["Egg 3"] = 7000003},
    ["World 2"]  = {["Egg 1"] = 7000004, ["Egg 2"] = 7000005, ["Egg 3"] = 7000006},
    ["World 3"]  = {["Egg 1"] = 7000007, ["Egg 2"] = 7000008},
    ["World 4"]  = {["Egg 1"] = 7000009, ["Egg 2"] = 7000010},
    ["World 5"]  = {["Egg 1"] = 7000011, ["Egg 2"] = 7000012},
    ["World 6"]  = {["Egg 1"] = 7000013, ["Egg 2"] = 7000014},
    ["World 7"]  = {["Egg 1"] = 7000015, ["Egg 2"] = 7000016, ["Egg 3"] = 7000017},
    ["World 8"]  = {["Egg 1"] = 7000018, ["Egg 2"] = 7000019, ["Egg 3"] = 7000020},
    ["World 9"]  = {["Egg 1"] = 7000021, ["Egg 2"] = 7000022, ["Egg 3"] = 7000023},
    ["World 10"] = {["Egg 1"] = 7000026, ["Egg 2"] = 7000027, ["Egg 3"] = 7000028},
    ["World 11"] = {["Egg 1"] = 7000029, ["Egg 2"] = 7000030},
    ["World 12"] = {["Egg 1"] = 7000031, ["Egg 2"] = 7000032, ["Egg 3"] = 7000033},
    ["World 13"] = {["Egg 1"] = 7000036, ["Egg 2"] = 7000037, ["Egg 3"] = 7000038},
    ["World 14"] = {["Egg 1"] = 7000039, ["Egg 2"] = 7000040, ["Egg 3"] = 7000041},
    ["World 15"] = {["Egg 1"] = 7000046, ["Egg 2"] = 7000047, ["Egg 3"] = 7000048},
    ["World 16"] = {["Egg 1"] = 7000049, ["Egg 2"] = 7000050, ["Egg 3"] = 7000051},
    ["World 17"] = {["Egg 1"] = 7000053, ["Egg 2"] = 7000054, ["Egg 3"] = 7000055},
    ["World 18"] = {["Egg 1"] = 7000059, ["Egg 2"] = 7000060, ["Egg 3"] = 7000061},
    ["World 19"] = {["Egg 1"] = 7000063, ["Egg 2"] = 7000064, ["Egg 3"] = 7000065},
    ["World 20"] = {["Egg 1"] = 7000069, ["Egg 2"] = 7000070, ["Egg 3"] = 7000071},
}

-- Main Frame
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 330)
Frame.Position = UDim2.new(0.5, -150, 0.5, -165)
Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
Frame.Active = true
Frame.Draggable = true

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", Frame)
stroke.Thickness = 1
stroke.Color = Color3.fromRGB(55, 55, 80)
stroke.Transparency = 0.75

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "☣️ EREN’s EGG HATCHER 🔥"
Title.TextColor3 = Color3.fromRGB(255, 100, 100)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 19

-- Minimize Button
local Minimize = Instance.new("TextButton", Frame)
Minimize.Size = UDim2.new(0,34,0,34)
Minimize.Position = UDim2.new(1,-42,0,4)
Minimize.BackgroundTransparency = 1
Minimize.Text = "–"
Minimize.TextColor3 = Color3.fromRGB(255, 100, 100)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 28

-- POISON RED ICON + GREEN TEXT
local MiniIcon = Instance.new("TextButton", ScreenGui)
MiniIcon.Size = UDim2.new(0,48,0,48)
MiniIcon.BackgroundColor3 = Color3.fromRGB(42,18,18)
MiniIcon.Text = "EY"
MiniIcon.Font = Enum.Font.GothamBlack
MiniIcon.TextSize = 24
MiniIcon.TextColor3 = Color3.fromRGB(100, 255, 100)  -- GREEN TEXT
MiniIcon.Visible = false
MiniIcon.Active = true
MiniIcon.Draggable = true

Instance.new("UICorner", MiniIcon).CornerRadius = UDim.new(0,8)

-- Poison Red Gradient (kept full red glow)
local PoisonGradient = Instance.new("UIGradient", MiniIcon)
PoisonGradient.Rotation = 90
PoisonGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 120)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 40, 40))
}

local TextStroke = Instance.new("UIStroke", MiniIcon)
TextStroke.Thickness = 2.5
TextStroke.Color = Color3.new(0,0,0)

-- Scrolling Area
local Scroll = Instance.new("ScrollingFrame", Frame)
Scroll.Size = UDim2.new(1,-14,1,-50)
Scroll.Position = UDim2.new(0,7,0,40)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = Color3.fromRGB(120,40,40)

local List = Instance.new("UIListLayout", Scroll)
List.Padding = UDim.new(0,9)

local function AddButton(text, callback)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(1,-8,0,44)
    btn.BackgroundColor3 = Color3.fromRGB(28,28,42)
    btn.Text = "  "..text
    btn.TextColor3 = Color3.fromRGB(220,220,255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 16
    btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    if callback then btn.MouseButton1Click:Connect(callback) end
    return btn
end

local worldBtn = AddButton("🌍 Select World")
local eggBtn = AddButton("🥚 Select Egg")
eggBtn.TextColor3 = Color3.fromRGB(180,180,180)

-- Amount Buttons
local amtFrame = Instance.new("Frame", Scroll)
amtFrame.Size = UDim2.new(1,-8,0,44)
amtFrame.BackgroundColor3 = Color3.fromRGB(28,28,42)
Instance.new("UICorner", amtFrame).CornerRadius = UDim.new(0,8)

for i, amt in ipairs({1,3,10}) do
    local b = Instance.new("TextButton", amtFrame)
    b.Size = UDim2.new(0.3,-6,1,-10)
    b.Position = UDim2.new((i-1)*0.333,0,0,5)
    b.BackgroundColor3 = (amt==1) and Color3.fromRGB(255,60,60) or Color3.fromRGB(50,30,30)
    b.Text = amt.."x"
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 19
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    b.MouseButton1Click:Connect(function()
        selectedAmount = amt
        for _,c in amtFrame:GetChildren() do if c:IsA("TextButton") then c.BackgroundColor3 = Color3.fromRGB(50,30,30) end end
        b.BackgroundColor3 = Color3.fromRGB(255,60,60)
    end)
end

-- Start Button (centered)
local startBtn = AddButton("▶️ START")
startBtn.BackgroundColor3 = Color3.fromRGB(200,40,40)
startBtn.TextColor3 = Color3.new(1,1,1)
startBtn.TextSize = 24
startBtn.TextXAlignment = Enum.TextXAlignment.Center

-- Status
local status = Instance.new("TextLabel", Scroll)
status.Size = UDim2.new(1,-8,0,30)
status.BackgroundTransparency = 1
status.Text = "Choose world & egg"
status.TextColor3 = Color3.fromRGB(200,200,200)
status.Font = Enum.Font.Gotham
status.TextSize = 15

-- Dropdown System (fully working)
local function createDropdown(btn)
    local drop = Instance.new("ScrollingFrame")
    drop.Size = UDim2.new(1,-16,0,160)
    drop.Position = UDim2.new(0,8,0,btn.AbsolutePosition.Y - Frame.AbsolutePosition.Y + 44)
    drop.BackgroundColor3 = Color3.fromRGB(28,28,42)
    drop.Visible = false
    drop.ScrollBarThickness = 4
    drop.Parent = Frame
    Instance.new("UICorner", drop).CornerRadius = UDim.new(0,10)

    btn.MouseButton1Click:Connect(function()
        if currentDropdown and currentDropdown ~= drop then currentDropdown.Visible = false end
        drop.Visible = not drop.Visible
        currentDropdown = drop.Visible and drop or nil
    end)

    local function setItems(items, callback)
        for _,v in drop:GetChildren() do if v:IsA("TextButton") then v:Destroy() end end
        drop.CanvasSize = UDim2.new(0,0,0,#items*38)
        for i, name in ipairs(items) do
            local o = Instance.new("TextButton", drop)
            o.Size = UDim2.new(1,-10,0,38)
            o.Position = UDim2.new(0,5,0,(i-1)*38)
            o.BackgroundColor3 = Color3.fromRGB(45,30,30)
            o.Text = "  "..name
            o.TextColor3 = Color3.new(1,1,1)
            o.TextXAlignment = "Left"
            o.Font = Enum.Font.Gotham
            o.TextSize = 16
            Instance.new("UICorner", o).CornerRadius = UDim.new(0,8)
            o.MouseButton1Click:Connect(function()
                callback(name)
                drop.Visible = false
                currentDropdown = nil
                btn.Text = "  "..name
                btn.TextColor3 = Color3.fromRGB(220,220,255)
            end)
        end
    end
    return {setItems = setItems}
end

local worldDropdown = createDropdown(worldBtn)
local eggDropdown = createDropdown(eggBtn)

local worldList = {}
for i=1,20 do table.insert(worldList, "World "..i) end

worldDropdown.setItems(worldList, function(w)
    local eggs = {}
    for e in pairs(Worlds[w] or {}) do table.insert(eggs, e) end
    table.sort(eggs)
    eggBtn.Text = "  Select Egg"
    eggBtn.TextColor3 = Color3.fromRGB(180,180,180)
    selectedEggID = nil
    status.Text = "Choose egg → "..selectedAmount.."x"
    eggDropdown.setItems(eggs, function(e)
        selectedEggID = Worlds[w][e]
        status.Text = w.." → "..e.." → "..selectedAmount.."x"
        status.TextColor3 = Color3.fromRGB(100,255,100)
    end)
end)

UserInputService.InputBegan:Connect(function(inp)
    if (inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch) and currentDropdown then
        if not currentDropdown:IsAncestorOf(inp.Target) and not worldBtn:IsAncestorOf(inp.Target) and not eggBtn:IsAncestorOf(inp.Target) then
            currentDropdown.Visible = false
            currentDropdown = nil
        end
    end
end)

-- Hatching Logic
local function hatch()
    if selectedEggID then
        pcall(function() Remote:InvokeServer(selectedEggID, selectedAmount) end)
    end
end

startBtn.MouseButton1Click:Connect(function()
    if not selectedEggID then
        status.Text = "Select world + egg first!"
        status.TextColor3 = Color3.fromRGB(255,100,100)
        return
    end
    enabled = not enabled
    if enabled then
        startBtn.Text = "■ STOP"
        startBtn.BackgroundColor3 = Color3.fromRGB(60,255,60)
        status.Text = "HATCHING "..selectedAmount.."x"
        status.TextColor3 = Color3.fromRGB(100,255,150)
        loopThread = task.spawn(function() while enabled do hatch() task.wait(0.08) end end)
    else
        startBtn.Text = "▶️ START"
        startBtn.BackgroundColor3 = Color3.fromRGB(200,40,40)
        status.Text = "Stopped"
        status.TextColor3 = Color3.fromRGB(220,80,80)
        if loopThread then task.cancel(loopThread) end
    end
end)

-- Minimize Logic (center only first time)
local firstMinimize = true
Minimize.MouseButton1Click:Connect(function()
    if currentDropdown then currentDropdown.Visible = false end
    Frame.Visible = false
    if firstMinimize then
        MiniIcon.Position = UDim2.new(0.5, -24, 0.5, -24)
        firstMinimize = false
    end
    MiniIcon.Visible = true
end)

MiniIcon.MouseButton1Click:Connect(function()
    Frame.Visible = true
    MiniIcon.Visible = false
end)

-- Open Animation
Frame.Size = UDim2.new(0,0,0,0)
TweenService:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Back), {Size = UDim2.new(0,300,0,330)}):Play()

List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0,0,0, List.AbsoluteContentSize.Y + 25)
end)

print("☣️ EREN’s EGG HATCHER • Poison RED Icon + Green EY Text • 100% Working • Enjoy 🔥")
