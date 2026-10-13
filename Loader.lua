-- MM2 Script Loader (Short Version)
-- Работает на Real, Xeno, любом инжекторе

local URL = "https://raw.githubusercontent.com/pukolka46-ui/scriptmm2/main/Script_Universal.lua"

if readfile and writefile then
    -- Method 1: Using filesystem (Krnl, Synapse X)
    loadstring(readfile("Script_Universal.lua"))()
elseif syn and syn.request then
    -- Method 2: Synapse X
    loadstring(syn.request({Url = URL}).Body)()
elseif http_request then
    -- Method 3: KRNL
    loadstring(http_request({Url = URL}).Body)()
elseif request then
    -- Method 4: Generic request
    loadstring(request({Url = URL}).Body)()
else
    -- Method 5: Manual load (Real injector)
    print("==========================================")
    print("Автозагрузка не поддерживается!")
    print("Открой Script_Universal.lua и скопируй код")
    print("==========================================")
    
    -- Простой тест для проверки
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 100)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -50)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.Parent = ScreenGui
    
    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(1, 0, 1, 0)
    Text.Text = "Открой Script_Universal.lua\nи скопируй весь код!"
    Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text.TextScaled = true
    Text.BackgroundTransparency = 1
    Text.Parent = Frame
end
