-- ULTRA COMPACT + TAP ANYWHERE TO CLOSE DROPDOWN
-- MINIMIZE (50x50 DRAGGABLE SQUARE ICON) ADDED — EXIT REMOVED
-- ICON APPEARS WHERE MINIMIZE BUTTON IS FIRST TIME (locked), then becomes draggable and saves last pos

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "TinyHatcher"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local Remote = ReplicatedStorage:WaitForChild("Tool"):WaitForChild("DrawUp"):WaitForChild("Msg"):WaitForChild("DrawHero")

local enabled = false
local loopThread = nil
local selectedEggID = nil
local selectedAmount = 1
local currentDropdown = nil

-- WORLDS DATA (unchanged)
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

---------------------------------------------------------------------
-- MAIN FRAME
---------------------------------------------------------------------
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 310)
frame.Position = UDim2.new(0.5, -150, 0.5, -155)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
frame.BorderSizePixel = 0
frame.Active = true -- allow input
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

-- DRAGGING FRAME (mouse + touch)
local draggingFrame = false
local dragStartPos, frameStartPos
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingFrame = true
        dragStartPos = input.Position
        frameStartPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then draggingFrame = false end
        end)
    end
end)
frame.InputChanged:Connect(function(input)
    if draggingFrame and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartPos
        frame.Position = UDim2.new(frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X,
                                   frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y)
    end
end)

---------------------------------------------------------------------
-- TITLE + MINIMIZE BUTTON
---------------------------------------------------------------------
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -50, 0, 36)
title.Position = UDim2.new(0, 12, 0, 6)
title.BackgroundTransparency = 1
title.Text = "EGG HATCHER"
title.TextColor3 = Color3.fromRGB(100, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22

local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Size = UDim2.new(0, 32, 0, 32)
minimizeBtn.Position = UDim2.new(1, -84, 0, 6)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 255)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 30
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 16)

---------------------------------------------------------------------
-- WORLD / EGG UI (unchanged content)
---------------------------------------------------------------------
local worldBtn = Instance.new("TextButton", frame)
worldBtn.Size = UDim2.new(0.88, 0, 0, 38)
worldBtn.Position = UDim2.new(0.06, 0, 0, 48)
worldBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
worldBtn.Text = "Select World"
worldBtn.TextColor3 = Color3.new(1,1,1)
worldBtn.Font = Enum.Font.Gotham
worldBtn.TextSize = 17
Instance.new("UICorner", worldBtn).CornerRadius = UDim.new(0, 10)

local eggBtn = Instance.new("TextButton", frame)
eggBtn.Size = UDim2.new(0.88, 0, 0, 38)
eggBtn.Position = UDim2.new(0.06, 0, 0, 88)
eggBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
eggBtn.Text = "Select Egg"
eggBtn.TextColor3 = Color3.fromRGB(180,180,180)
eggBtn.Font = Enum.Font.Gotham
eggBtn.TextSize = 17
Instance.new("UICorner", eggBtn).CornerRadius = UDim.new(0, 10)

---------------------------------------------------------------------
-- AMOUNT BUTTONS (keeps status update)
---------------------------------------------------------------------
local amtFrame = Instance.new("Frame", frame)
amtFrame.Size = UDim2.new(0.88, 0, 0, 38)
amtFrame.Position = UDim2.new(0.06, 0, 0, 128)
amtFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
Instance.new("UICorner", amtFrame).CornerRadius = UDim.new(0, 10)

for i, amt in ipairs({1,3,10}) do
    local b = Instance.new("TextButton", amtFrame)
    b.Size = UDim2.new(0.3, -4, 1, -6)
    b.Position = UDim2.new((i-1)*0.33 + 0.02, 0, 0, 3)
    b.BackgroundColor3 = (amt==1) and Color3.fromRGB(40,180,40) or Color3.fromRGB(70,70,90)
    b.Text = amt.."x"
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 18
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

    b.MouseButton1Click:Connect(function()
        selectedAmount = amt
        for _,c in ipairs(amtFrame:GetChildren()) do
            if c:IsA("TextButton") then
                c.BackgroundColor3 = Color3.fromRGB(70,70,90)
            end
        end
        b.BackgroundColor3 = Color3.fromRGB(40,180,40)
        -- update status text if egg selected
        if selectedEggID then
            status.Text = (status.Text or ""):gsub("%d+x$","") .. selectedAmount.."x"
        end
    end)
end

---------------------------------------------------------------------
-- START BUTTON + STATUS (unchanged text behavior)
---------------------------------------------------------------------
local startBtn = Instance.new("TextButton", frame)
startBtn.Size = UDim2.new(0.88, 0, 0, 50)
startBtn.Position = UDim2.new(0.06, 0, 0, 168)
startBtn.BackgroundColor3 = Color3.fromRGB(200,40,40)
startBtn.Text = "START"
startBtn.TextColor3 = Color3.new(1,1,1)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 26
Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 12)

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(0.88, 0, 0, 26)
status.Position = UDim2.new(0.06, 0, 0, 222)
status.BackgroundTransparency = 1
status.Text = "Choose world & egg"
status.TextColor3 = Color3.fromRGB(200,200,200)
status.Font = Enum.Font.Gotham
status.TextSize = 15

---------------------------------------------------------------------
-- DROPDOWN SYSTEM (unchanged but now updates status on selection)
---------------------------------------------------------------------
local function createPersistentDropdown(btn)
    local d = Instance.new("ScrollingFrame")
    d.Size = UDim2.new(btn.Size.X.Scale,0,0,160)
    d.Position = UDim2.new(btn.Position.X.Scale,0,btn.Position.Y.Scale+btn.Size.Y.Scale+0.008,0)
    d.BackgroundColor3 = Color3.fromRGB(40,40,60)
    d.BorderSizePixel = 0
    d.ScrollBarThickness = 6
    d.Visible = false
    d.CanvasSize = UDim2.new(0,0,0,0)
    d.Parent = frame
    Instance.new("UICorner", d).CornerRadius = UDim.new(0,10)

    btn.MouseButton1Click:Connect(function()
        if currentDropdown and currentDropdown ~= d then
            currentDropdown.Visible = false
        end
        d.Visible = not d.Visible
        currentDropdown = d.Visible and d or nil
    end)

    local function setItems(items, callback)
        for _,v in ipairs(d:GetChildren()) do
            if v:IsA("TextButton") then v:Destroy() end
        end

        d.CanvasSize = UDim2.new(0,0,0,#items * 38)
        for i, name in ipairs(items) do
            local o = Instance.new("TextButton", d)
            o.Size = UDim2.new(1,-10,0,38)
            o.Position = UDim2.new(0,5,0,(i-1)*38)
            o.BackgroundColor3 = Color3.fromRGB(55,55,75)
            o.Text = "  "..name
            o.TextColor3 = Color3.new(1,1,1)
            o.TextXAlignment = "Left"
            o.Font = Enum.Font.Gotham
            o.TextSize = 17
            Instance.new("UICorner", o).CornerRadius = UDim.new(0,8)

            o.MouseButton1Click:Connect(function()
                callback(name)
                d.Visible = false
                currentDropdown = nil
                btn.Text = name
                btn.TextColor3 = Color3.new(1,1,1)
            end)
        end
    end

    return { frame = d, setItems = setItems }
end

local worldDropdown = createPersistentDropdown(worldBtn)
local eggDropdownObj = createPersistentDropdown(eggBtn)

local worldList = {}
for i=1,20 do table.insert(worldList, "World "..i) end

worldDropdown.setItems(worldList, function(w)
    -- build egg list
    local eggs = {}
    for n in pairs(Worlds[w] or {}) do table.insert(eggs, n) end
    table.sort(eggs)

    eggBtn.Text = "Select Egg"
    eggBtn.TextColor3 = Color3.fromRGB(180,180,180)
    selectedEggID = nil
    status.Text = "Choose egg → "..selectedAmount.."x"
    status.TextColor3 = Color3.fromRGB(200,200,200)

    eggDropdownObj.setItems(eggs, function(e)
        selectedEggID = Worlds[w][e]
        status.Text = w.." → "..e.." → "..selectedAmount.."x"
        status.TextColor3 = Color3.fromRGB(100,255,100)
    end)
end)

-- close dropdown on tap outside (mouse + touch)
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local target = input.Target
        if currentDropdown and (not target or (not currentDropdown:IsAncestorOf(target) and not worldBtn:IsAncestorOf(target) and not eggBtn:IsAncestorOf(target))) then
            currentDropdown.Visible = false
            currentDropdown = nil
        end
    end
end)

---------------------------------------------------------------------
-- AUTOhatching (unchanged)
---------------------------------------------------------------------
local function hatch()
    if selectedEggID then
        pcall(function()
            Remote:InvokeServer(selectedEggID, selectedAmount)
        end)
    end
end

startBtn.MouseButton1Click:Connect(function()
    if not selectedEggID then
        status.Text = "Select world + egg!"
        status.TextColor3 = Color3.fromRGB(255,100,100)
        return
    end
    enabled = not enabled
    if enabled then
        startBtn.Text = "STOP"
        startBtn.BackgroundColor3 = Color3.fromRGB(40,180,40)
        status.Text = "HATCHING "..selectedAmount.."x"
        status.TextColor3 = Color3.fromRGB(100,255,150)
        loopThread = task.spawn(function()
            while enabled do hatch() task.wait(0.08) end
        end)
    else
        startBtn.Text = "START"
        startBtn.BackgroundColor3 = Color3.fromRGB(200,40,40)
        status.Text = "Stopped"
        status.TextColor3 = Color3.fromRGB(220,80,80)
        if loopThread then task.cancel(loopThread) end
    end
end)

---------------------------------------------------------------------
-- MINIMIZE SYSTEM (50x50 icon), icon appears at minimize button position
-- Behavior: first time locked at minimize button; after first restore becomes draggable;
-- dragging saves lastPos which is used on subsequent minimizes.
---------------------------------------------------------------------
local icon = Instance.new("TextButton", gui)
icon.Size = UDim2.new(0, 50, 0, 50) -- BIGGER ICON
icon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
icon.Text = "≡"
icon.Font = Enum.Font.GothamBold
icon.TextSize = 28
icon.TextColor3 = Color3.fromRGB(0,255,120)
icon.Visible = false
Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 12)

-- state for icon behavior
local iconLocked = true        -- true initially (first minimize locked)
local savedIconPosition = nil  -- UDim2 of last dragged position (if any)

-- ICON DRAGGING (mouse + touch) - respects iconLocked
local draggingIcon = false
local iconDragStart, iconStartPos

icon.InputBegan:Connect(function(input)
    if iconLocked then return end -- ignore drag when locked
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingIcon = true
        iconDragStart = input.Position
        iconStartPos = icon.Position
        -- when input ends, stop dragging and save position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingIcon = false
                -- save last position so future minimizes use it
                savedIconPosition = icon.Position
            end
        end)
    end
end)

icon.InputChanged:Connect(function(input)
    if iconLocked then return end
    if draggingIcon and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - iconDragStart
        icon.Position = UDim2.new(iconStartPos.X.Scale, iconStartPos.X.Offset + delta.X,
                                  iconStartPos.Y.Scale, iconStartPos.Y.Offset + delta.Y)
    end
end)

-- On minimize: place icon exactly at minimize button absolute position if there's no saved pos.
-- If saved pos exists, use it and keep icon unlocked (so user can drag it further).
minimizeBtn.MouseButton1Click:Connect(function()
    if currentDropdown then
        currentDropdown.Visible = false
        currentDropdown = nil
    end

    if savedIconPosition then
        -- use saved position (user previously dragged)
        icon.Position = savedIconPosition
        iconLocked = false
    else
        -- center over minimize button and lock icon for first-time
        local absPos = minimizeBtn.AbsolutePosition
        local absSize = minimizeBtn.AbsoluteSize
        local iconX = absPos.X + (absSize.X/2) - (50/2)
        local iconY = absPos.Y + (absSize.Y/2) - (50/2)
        icon.Position = UDim2.new(0, math.max(0, iconX), 0, math.max(0, iconY))
        iconLocked = true
    end

    TweenService:Create(frame, TweenInfo.new(0.18), {Size = UDim2.new(0,0,0,0)}):Play()
    task.delay(0.18, function()
        frame.Visible = false
        icon.Visible = true
    end)
end)

-- Restore: un-lock icon so user can drag after first restore.
icon.MouseButton1Click:Connect(function()
    icon.Visible = false
    frame.Visible = true
    frame.Size = UDim2.new(0,0,0,0)
    TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Back), {Size = UDim2.new(0,300,0,310)}):Play()
    -- after user restores once, allow icon to be draggable (future drags save position)
    iconLocked = false
    -- also if there was no saved pos, set one to current icon position (so subsequent minimizes use it)
    if not savedIconPosition then
        savedIconPosition = icon.Position
    end
end)

---------------------------------------------------------------------
-- OPEN ANIMATION
---------------------------------------------------------------------
frame.Size = UDim2.new(0,0,0,0)
TweenService:Create(frame,TweenInfo.new(0.35,Enum.EasingStyle.Back),{Size=UDim2.new(0,300,0,310)}):Play()

print("FINAL VERSION LOADED – status restored, frame & icon draggable with locked-first behavior.")
