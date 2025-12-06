-- ☣️ EREN HUB – FINAL VERSION (ICON FIRST TIME ALWAYS CENTER, THEN REMEMBERS YOUR DRAG POSITION)

local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage.Tool.DrawUp.Msg.DrawHero

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,410,0,280)
Main.Position = UDim2.new(0.5,-205,0.5,-140)
Main.BackgroundColor3 = Color3.fromRGB(18,18,26)
Main.Draggable = true
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(55,55,80)
Instance.new("UIStroke", Main).Thickness = 1.5

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,34)
Title.BackgroundTransparency = 1
Title.Text = "☣️ EREN’s HUB 🔥"
Title.TextColor3 = Color3.fromRGB(100,255,100)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18

local Minimize = Instance.new("TextButton", Main)
Minimize.Size = UDim2.new(0,32,0,32)
Minimize.Position = UDim2.new(1,-38,0,2)
Minimize.BackgroundTransparency = 1
Minimize.Text = "–"
Minimize.TextColor3 = Color3.fromRGB(150,255,150)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 26

local MiniIcon = Instance.new("TextButton", ScreenGui)
MiniIcon.Size = UDim2.new(0,48,0,48)
MiniIcon.BackgroundColor3 = Color3.fromRGB(28,28,42)
MiniIcon.Text = "EY"
MiniIcon.TextColor3 = Color3.fromRGB(100,255,100)
MiniIcon.Font = Enum.Font.GothamBlack
MiniIcon.TextSize = 26
MiniIcon.Visible = false
MiniIcon.Draggable = true
Instance.new("UICorner", MiniIcon).CornerRadius = UDim.new(0,10)
Instance.new("UIGradient", MiniIcon).Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(170,255,170)),ColorSequenceKeypoint.new(1,Color3.fromRGB(60,255,60))}
Instance.new("UIStroke", MiniIcon).Thickness = 2.5

local Left = Instance.new("Frame", Main)
Left.Size = UDim2.new(0,138,1,-40)
Left.Position = UDim2.new(0,0,0,40)
Left.BackgroundColor3 = Color3.fromRGB(24,24,36)
Instance.new("UICorner", Left).CornerRadius = UDim.new(0,10)
Instance.new("UIListLayout", Left).Padding = UDim.new(0,8)

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1,-146,1,-40)
Content.Position = UDim2.new(0,142,0,40)
Content.BackgroundTransparency = 1

local Worlds = {["World 1"]={["Egg 1"]=7000001,["Egg 2"]=7000002,["Egg 3"]=7000003},["World 2"]={["Egg 1"]=7000004,["Egg 2"]=7000005,["Egg 3"]=7000006},["World 3"]={["Egg 1"]=5000007,["Egg 2"]=7000008},["World 4"]={["Egg 1"]=7000009,["Egg 2"]=7000010},["World 5"]={["Egg 1"]=7000011,["Egg 2"]=7000012},["World 6"]={["Egg 1"]=7000013,["Egg 2"]=7000014},["World 7"]={["Egg 1"]=7000015,["Egg 2"]=7000016,["Egg 3"]=7000017},["World 8"]={["Egg 1"]=7000018,["Egg 2"]=7000019,["Egg 3"]=7000020},["World 9"]={["Egg 1"]=7000021,["Egg 2"]=7000022,["Egg 3"]=7000023},["World 10"]={["Egg 1"]=7000026,["Egg 2"]=7000027,["Egg 3"]=7000028},["World 11"]={["Egg 1"]=7000029,["Egg 2"]=7000030},["World 12"]={["Egg 1"]=7000031,["Egg 2"]=7000032,["Egg 3"]=7000033},["World 13"]={["Egg 1"]=7000036,["Egg 2"]=7000037,["Egg 3"]=7000038},["World 14"]={["Egg 1"]=7000039,["Egg 2"]=7000040,["Egg 3"]=7000041},["World 15"]={["Egg 1"]=7000046,["Egg 2"]=7000047,["Egg 3"]=7000048},["World 16"]={["Egg 1"]=7000049,["Egg 2"]=7000050,["Egg 3"]=7000051},["World 17"]={["Egg 1"]=7000053,["Egg 2"]=7000054,["Egg 3"]=7000055},["World 18"]={["Egg 1"]=7000059,["Egg 2"]=7000060,["Egg 3"]=7000061},["World 19"]={["Egg 1"]=7000063,["Egg 2"]=7000064,["Egg 3"]=7000065},["World 20"]={["Egg 1"]=7000069,["Egg 2"]=7000070,["Egg 3"]=7000071},
["World 21"]={["Egg 1"]=7000074,["Egg 2"]=7000075,["Egg 3"]=7000076}} -- ← FIXED WITH 70000 PREFIX

local selWorld, selEgg, selID, selAmt = nil,nil,nil,1
local running = false
local lastTab = "Show GUIs"

-- ICON POSITION LOGIC (FIRST TIME CENTER, AFTER THAT REMEMBERS WHERE YOU DRAGGED IT)
local FirstMinimize = true

local function Menu(name,icon,func)
    local b = Instance.new("TextButton",Left)
    b.Size = UDim2.new(1,-16,0,48)
    b.BackgroundColor3 = Color3.fromRGB(35,35,55)
    b.Text = icon.." "..name
    b.TextColor3 = Color3.fromRGB(180,255,180)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,9)
    b.MouseButton1Click:Connect(function()
        for _,v in Left:GetChildren() do if v:IsA("TextButton") then v.BackgroundColor3 = Color3.fromRGB(35,35,55) end end
        b.BackgroundColor3 = Color3.fromRGB(60,255,60)
        lastTab = name
        Content:ClearAllChildren()
        func()
    end)
end

local function ShowGUIs()
    local s = Instance.new("ScrollingFrame",Content)
    s.Size = UDim2.new(1,0,1,0)
    s.BackgroundTransparency = 1
    s.ScrollBarThickness = 4
    s.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Instance.new("UIListLayout",s).Padding = UDim.new(0,8)

    local list = {{"🦅 Wings Shop","WingShop"},{"🔥 Fuse Pet","FusePet"},{"✨ Enchant Pet","MagicPet"},{"🌟 Wing Enchant","WingEnchantment"},{"🤖 Titan Machine","Titan Pet"}}
    for _,v in list do
        local b = Instance.new("TextButton",s)
        b.Size = UDim2.new(1,-10,0,48)
        b.BackgroundColor3 = Color3.fromRGB(30,30,48)
        b.Text = v[1]
        b.TextColor3 = Color3.fromRGB(220,255,220)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 17
        Instance.new("UICorner",b).CornerRadius = UDim.new(0,9)
        b.MouseButton1Click:Connect(function() firesignal(ReplicatedStorage.LocalMsg.showLocalUI.Event,v[2]) end)
    end
end

local status, startbtn
local function Hatcher()
    status = Instance.new("TextLabel",Content)
    status.Size = UDim2.new(1,-14,0,32)
    status.Position = UDim2.new(0,7,0,202)
    status.BackgroundTransparency = 1
    status.Text = "Choose world & egg"
    status.TextColor3 = Color3.new(1,1,1)
    status.Font = Enum.Font.Gotham
    status.TextSize = 15

    local wbtn = Instance.new("TextButton",Content)
    wbtn.Size = UDim2.new(1,-14,0,42)
    wbtn.Position = UDim2.new(0,7,0,6)
    wbtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
    wbtn.Text = selWorld and "  🌍 "..selWorld or "  🌍 Select World"
    wbtn.TextColor3 = Color3.new(1,1,1)
    wbtn.Font = Enum.Font.GothamBold
    wbtn.TextSize = 16
    wbtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner",wbtn).CornerRadius = UDim.new(0,9)

    local ebtn = Instance.new("TextButton",Content)
    ebtn.Size = UDim2.new(1,-14,0,42)
    ebtn.Position = UDim2.new(0,7,0,54)
    ebtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
    ebtn.Text = selEgg and "  🥚 "..selEgg or "  🥚 Select Egg"
    ebtn.TextColor3 = Color3.new(1,1,1)
    ebtn.Font = Enum.Font.GothamBold
    ebtn.TextSize = 16
    ebtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner",ebtn).CornerRadius = UDim.new(0,9)

    for i,v in ipairs({1,3,10}) do
        local b = Instance.new("TextButton",Content)
        b.Size = UDim2.new(0,72,0,38)
        b.Position = UDim2.new(0,14+(i-1)*78,0,104)
        b.BackgroundColor3 = selAmt==v and Color3.fromRGB(255,60,60) or Color3.fromRGB(60,30,30)
        b.Text = v.."x"
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.GothamBlack
        b.TextSize = 18
        Instance.new("UICorner",b).CornerRadius = UDim.new(0,9)
        b.MouseButton1Click:Connect(function()
            selAmt = v
            for _,x in Content:GetChildren() do if x:IsA("TextButton") and x.Text:match("x$") then x.BackgroundColor3 = Color3.fromRGB(60,30,30) end end
            b.BackgroundColor3 = Color3.fromRGB(255,60,60)
        end)
    end

    startbtn = Instance.new("TextButton",Content)
    startbtn.Size = UDim2.new(1,-14,0,46)
    startbtn.Position = UDim2.new(0,7,0,150)
    startbtn.BackgroundColor3 = running and Color3.fromRGB(60,255,60) or Color3.fromRGB(200,40,40)
    startbtn.Text = running and "■ STOP" or "▶️ START"
    startbtn.TextColor3 = Color3.new(1,1,1)
    startbtn.Font = Enum.Font.GothamBlack
    startbtn.TextSize = 18
    Instance.new("UICorner",startbtn).CornerRadius = UDim.new(0,10)

    local open = nil
    local function Drop(btn,items,cb)
        local d = Instance.new("ScrollingFrame",Content)
        d.Size = UDim2.new(1,-14,0,140)
        d.Position = btn.Position + UDim2.new(0,0,0,46)
        d.BackgroundColor3 = Color3.fromRGB(30,30,50)
        d.Visible = false
        d.ScrollBarThickness = 5
        d.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Instance.new("UICorner",d).CornerRadius = UDim.new(0,9)
        Instance.new("UIListLayout",d).Padding = UDim.new(0,4)

        btn.MouseButton1Click:Connect(function()
            if open and open ~= d then open.Visible = false end
            d.Visible = not d.Visible
            open = d.Visible and d or nil
        end)

        for _,it in ipairs(items) do
            local o = Instance.new("TextButton",d)
            o.Size = UDim2.new(1,-8,0,38)
            o.BackgroundColor3 = Color3.fromRGB(50,50,70)
            o.Text = "  "..it
            o.TextColor3 = Color3.new(1,1,1)
            o.Font = Enum.Font.GothamBold
            o.TextSize = 16
            Instance.new("UICorner",o).CornerRadius = UDim.new(0,8)
            o.MouseButton1Click:Connect(function()
                cb(it)
                d.Visible = false
                open = nil
            end)
        end
    end

    local wlist = {}
    for i=1,21 do wlist[i] = "World "..i end
    Drop(wbtn, wlist, function(w)
        selWorld = w
        wbtn.Text = "  🌍 "..w
        local eggs = {}
        for e in pairs(Worlds[w]) do table.insert(eggs,e) end
        table.sort(eggs)
        Drop(ebtn, eggs, function(e)
            selEgg = e
            selID = Worlds[w][e]
            ebtn.Text = "  🥚 "..e
            status.Text = selWorld.." → "..selEgg.." ("..selAmt.."x)"
            status.TextColor3 = Color3.fromRGB(100,255,100)
        end)
    end)

    startbtn.MouseButton1Click:Connect(function()
        if not selID then status.Text = "Select world & egg first!" status.TextColor3 = Color3.fromRGB(255,100,100) return end
        running = not running
        startbtn.Text = running and "■ STOP" or "▶️ START"
        startbtn.BackgroundColor3 = running and Color3.fromRGB(60,255,60) or Color3.fromRGB(200,40,40)
        status.Text = running and "HATCHING "..selAmt.."x 🔥" or selWorld.." → "..selEgg.." ("..selAmt.."x)"
        status.TextColor3 = running and Color3.fromRGB(100,255,100) or Color3.new(1,1,1)
        if running then
            task.spawn(function()
                while running do
                    pcall(function() Remote:InvokeServer(selID, selAmt) end)
                    task.wait(0.06)
                end
            end)
        end
    end)
end

Menu("Show GUIs","🦅",ShowGUIs)
Menu("Auto Hatcher","⚡",Hatcher)

-- MINIMIZE / REOPEN LOGIC (FIRST TIME CENTER, AFTER THAT REMEMBERS YOUR DRAG POSITION)
Minimize.MouseButton1Click:Connect(function()
    if FirstMinimize then
        MiniIcon.Position = UDim2.new(0.5, -24, 0.5, -24)
        FirstMinimize = false
    else
        MiniIcon.Position = MiniIcon.Position
    end
    Main.Visible = false
    MiniIcon.Visible = true
end)

MiniIcon.MouseButton1Click:Connect(function()
    Main.Visible = true
    MiniIcon.Visible = false
    Content:ClearAllChildren()
    if lastTab == "Show GUIs" then ShowGUIs() else Hatcher() end
end)

ShowGUIs()
print("☣️ EREN HUB LOADED – FIRST MINIMIZE = CENTER, THEN REMEMBERS POSITION")
