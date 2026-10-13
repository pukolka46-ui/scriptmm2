--[[
    MM2 Script v3.0
    Murder Mystery 2 GUI Script
    
    Injection:
    loadstring(game:HttpGet("https://raw.githubusercontent.com/pukolka46-ui/scriptmm2/main/Script.lua"))()
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ==================== CONFIG ====================
local Config = {
    AimbotEnabled = false,
    AimbotFOV = 150,
    AimbotSmooth = 5,
    SilentAim = false,
    ShowFOV = false,
    Wallbang = false,
    
    BoxEnabled = false,
    TracersEnabled = false,
    NameTags = false,
    Distance = 1000,
    ChamsGun = false,
    ChamsPlayer = false,
    ChamsSky = false,
    
    SpinEnabled = false,
    SpinSpeed = 50,
    
    SpeedEnabled = false,
    SpeedValue = 16,
    InfJumpEnabled = false,
    JumpPower = 50,
    FlyEnabled = false,
    FlySpeed = 100,
    NoclipEnabled = false,
    
    KnifeSkin = "Default",
    GunSkin = "Default",
    
    FPSBoost = false,
    Optimization = false,
    
    TeamCheck = true,
    MenuKey = Enum.KeyCode.RightShift
}

-- ==================== THEME (Dark-White) ====================
local Theme = {
    Background = Color3.fromRGB(25, 25, 25),
    Sidebar = Color3.fromRGB(20, 20, 20),
    SidebarButton = Color3.fromRGB(35, 35, 35),
    SidebarButtonHover = Color3.fromRGB(45, 45, 45),
    SidebarButtonActive = Color3.fromRGB(255, 255, 255),
    Content = Color3.fromRGB(30, 30, 30),
    Text = Color3.fromRGB(255, 255, 255),
    TextMuted = Color3.fromRGB(150, 150, 150),
    Accent = Color3.fromRGB(255, 255, 255),
    ToggleOff = Color3.fromRGB(40, 40, 40),
    ToggleOn = Color3.fromRGB(255, 255, 255),
    SliderBar = Color3.fromRGB(35, 35, 35),
    SliderFill = Color3.fromRGB(255, 255, 255),
    ButtonBackground = Color3.fromRGB(255, 255, 255),
    ButtonText = Color3.fromRGB(25, 25, 25),
}

-- ==================== GUI ====================
local GUI = {}
GUI.__index = GUI

function GUI.new(title, size)
    local self = setmetatable({}, GUI)
    self.Tabs = {}
    self.ActiveTab = nil
    self.Visible = true
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MM2_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 999
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = size or UDim2.new(0, 650, 0, 450)
    mainFrame.Position = UDim2.new(0.5, -325, 0.5, -225)
    mainFrame.BackgroundColor3 = Theme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = mainFrame
    
    local borderGradient = Instance.new("UIStroke")
    borderGradient.Color = Theme.Accent
    borderGradient.Thickness = 1
    borderGradient.Transparency = 0.8
    borderGradient.Parent = mainFrame
    
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 80, 1, 0)
    sidebar.BackgroundColor3 = Theme.Sidebar
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame
    
    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, 8)
    sidebarCorner.Parent = sidebar
    
    local sidebarFix = Instance.new("Frame")
    sidebarFix.Size = UDim2.new(0, 25, 1, 0)
    sidebarFix.Position = UDim2.new(1, -25, 0, 0)
    sidebarFix.BackgroundColor3 = Theme.Sidebar
    sidebarFix.BorderSizePixel = 0
    sidebarFix.Parent = sidebar
    
    local accentLine = Instance.new("Frame")
    accentLine.Size = UDim2.new(0, 2, 1, 0)
    accentLine.Position = UDim2.new(1, -2, 0, 0)
    accentLine.BackgroundColor3 = Theme.Accent
    accentLine.BorderSizePixel = 0
    accentLine.Parent = sidebar
    
    local logoLabel = Instance.new("TextLabel")
    logoLabel.Size = UDim2.new(1, 0, 0, 70)
    logoLabel.BackgroundTransparency = 1
    logoLabel.Text = "MM2"
    logoLabel.TextColor3 = Theme.Accent
    logoLabel.Font = Enum.Font.GothamBold
    logoLabel.TextSize = 22
    logoLabel.Parent = sidebar
    
    local logoSubtitle = Instance.new("TextLabel")
    logoSubtitle.Size = UDim2.new(1, 0, 0, 20)
    logoSubtitle.Position = UDim2.new(0, 0, 0, 50)
    logoSubtitle.BackgroundTransparency = 1
    logoSubtitle.Text = "v3.0"
    logoSubtitle.TextColor3 = Theme.TextMuted
    logoSubtitle.Font = Enum.Font.GothamBold
    logoSubtitle.TextSize = 10
    logoSubtitle.Parent = sidebar
    
    local buttonsContainer = Instance.new("ScrollingFrame")
    buttonsContainer.Size = UDim2.new(1, 0, 1, -130)
    buttonsContainer.Position = UDim2.new(0, 0, 0, 80)
    buttonsContainer.BackgroundTransparency = 1
    buttonsContainer.ScrollBarThickness = 4
    buttonsContainer.ScrollBarImageColor3 = Theme.Accent
    buttonsContainer.ScrollBarImageTransparency = 0.5
    buttonsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    buttonsContainer.Parent = sidebar
    
    local buttonsList = Instance.new("UIListLayout")
    buttonsList.Padding = UDim.new(0, 5)
    buttonsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    buttonsList.Parent = buttonsContainer
    
    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(1, -80, 1, 0)
    contentArea.Position = UDim2.new(0, 80, 0, 0)
    contentArea.BackgroundColor3 = Theme.Background
    contentArea.BorderSizePixel = 0
    contentArea.Parent = mainFrame
    
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 50)
    header.BackgroundColor3 = Theme.Background
    header.BorderSizePixel = 0
    header.Parent = contentArea
    
    local headerTitle = Instance.new("TextLabel")
    headerTitle.Size = UDim2.new(1, -80, 1, 0)
    headerTitle.Position = UDim2.new(0, 20, 0, 0)
    headerTitle.BackgroundTransparency = 1
    headerTitle.Text = title or "MM2 Script"
    headerTitle.TextColor3 = Theme.Text
    headerTitle.Font = Enum.Font.GothamBold
    headerTitle.TextSize = 20
    headerTitle.TextXAlignment = Enum.TextXAlignment.Left
    headerTitle.Parent = header
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -45, 0.5, -15)
    closeBtn.BackgroundColor3 = Theme.SidebarButton
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Theme.Accent
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeBtn
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -40, 1, -70)
    contentFrame.Position = UDim2.new(0, 20, 0, 55)
    contentFrame.BackgroundColor3 = Theme.Content
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = contentArea
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 8)
    contentCorner.Parent = contentFrame
    
    self.Window = screenGui
    self.MainFrame = mainFrame
    self.ButtonsContainer = buttonsContainer
    self.ContentFrame = contentFrame
    
    closeBtn.MouseButton1Click:Connect(function() self:Toggle() end)
    closeBtn.MouseEnter:Connect(function() closeBtn.BackgroundColor3 = Theme.Accent closeBtn.TextColor3 = Theme.Sidebar end)
    closeBtn.MouseLeave:Connect(function() closeBtn.BackgroundColor3 = Theme.SidebarButton closeBtn.TextColor3 = Theme.Accent end)
    
    local dragging = false
    local dragStart, startPos
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    screenGui.Parent = CoreGui
    return self
end

function GUI:Toggle()
    self.Visible = not self.Visible
    self.Window.Enabled = self.Visible
end

function GUI:CreateTab(name, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 65, 0, 45)
    btn.BackgroundColor3 = Theme.SidebarButton
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = self.ButtonsContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(1, 0, 0, 22)
    iconLabel.Position = UDim2.new(0, 0, 0, 5)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon or "●"
    iconLabel.TextColor3 = Theme.TextMuted
    iconLabel.Font = Enum.Font.GothamMedium
    iconLabel.TextSize = 16
    iconLabel.Parent = btn
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -4, 0, 14)
    nameLabel.Position = UDim2.new(0, 2, 1, -18)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Theme.TextMuted
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 9
    nameLabel.Parent = btn
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -20)
    scrollFrame.Position = UDim2.new(0, 10, 0, 10)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.ScrollBarImageColor3 = Theme.Accent
    scrollFrame.ScrollBarImageTransparency = 0.3
    scrollFrame.Visible = false
    scrollFrame.Parent = self.ContentFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 6)
    listLayout.Parent = scrollFrame
    
    local tab = {Button = btn, Icon = iconLabel, Name = nameLabel, Content = scrollFrame}
    
    btn.MouseEnter:Connect(function() if self.ActiveTab ~= tab then btn.BackgroundColor3 = Theme.SidebarButtonHover end end)
    btn.MouseLeave:Connect(function() if self.ActiveTab ~= tab then btn.BackgroundColor3 = Theme.SidebarButton end end)
    btn.MouseButton1Click:Connect(function() self:SetActiveTab(tab) end)
    
    table.insert(self.Tabs, tab)
    if #self.Tabs == 1 then self:SetActiveTab(tab) end
    
    return scrollFrame
end

function GUI:SetActiveTab(tab)
    for _, t in ipairs(self.Tabs) do
        t.Content.Visible = false
        t.Button.BackgroundColor3 = Theme.SidebarButton
        t.Icon.TextColor3 = Theme.TextMuted
        t.Name.TextColor3 = Theme.TextMuted
    end
    
    tab.Content.Visible = true
    tab.Button.BackgroundColor3 = Theme.SidebarButtonActive
    tab.Icon.TextColor3 = Theme.Sidebar
    tab.Name.TextColor3 = Theme.Sidebar
    self.ActiveTab = tab
end

function GUI:CreateSection(tab, text)
    local section = Instance.new("TextLabel")
    section.Size = UDim2.new(1, 0, 0, 25)
    section.BackgroundTransparency = 1
    section.Text = "  " .. text
    section.TextColor3 = Theme.Accent
    section.Font = Enum.Font.GothamBold
    section.TextSize = 13
    section.TextXAlignment = Enum.TextXAlignment.Left
    section.Parent = tab
end

function GUI:CreateToggle(tab, text, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0, 38)
    toggleFrame.BackgroundColor3 = Theme.SidebarButton
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = tab
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = toggleFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -65, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 42, 0, 22)
    btn.Position = UDim2.new(1, -52, 0.5, -11)
    btn.BackgroundColor3 = Theme.ToggleOff
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = toggleFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 11)
    btnCorner.Parent = btn
    
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 16, 0, 16)
    circle.Position = UDim2.new(0, 3, 0.5, -8)
    circle.BackgroundColor3 = Theme.TextMuted
    circle.BorderSizePixel = 0
    circle.Parent = btn
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(0, 8)
    circleCorner.Parent = circle
    
    local enabled = false
    
    local function setToggle(value)
        enabled = value
        if enabled then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ToggleOn}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 23, 0.5, -8), BackgroundColor3 = Theme.Sidebar}):Play()
        else
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ToggleOff}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = Theme.TextMuted}):Play()
        end
        callback(enabled)
    end
    
    btn.MouseButton1Click:Connect(function() setToggle(not enabled) end)
    
    return {SetValue = setToggle, GetValue = function() return enabled end}
end

function GUI:CreateSlider(tab, text, min, max, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 50)
    sliderFrame.BackgroundColor3 = Theme.SidebarButton
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = tab
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = sliderFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 16)
    label.Position = UDim2.new(0, 12, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. tostring(min)
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame
    
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -24, 0, 5)
    bar.Position = UDim2.new(0, 12, 1, -20)
    bar.BackgroundColor3 = Theme.SliderBar
    bar.BorderSizePixel = 0
    bar.Parent = sliderFrame
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 3)
    barCorner.Parent = bar
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Theme.SliderFill
    fill.BorderSizePixel = 0
    fill.Parent = bar
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 3)
    fillCorner.Parent = fill
    
    local value = min
    local dragging = false
    
    local function updateSlider(x)
        local barAbs = bar.AbsoluteSize
        local barPos = bar.AbsolutePosition
        local relativeX = math.clamp(x - barPos.X, 0, barAbs.X)
        local percent = relativeX / barAbs.X
        value = math.round(min + (max - min) * percent)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        label.Text = text .. ": " .. tostring(value)
        callback(value)
    end
    
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input.Position.X)
        end
    end)
    
    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input.Position.X)
        end
    end)
    
    return {SetValue = function(v) value = v fill.Size = UDim2.new((v - min) / (max - min), 0, 1, 0) label.Text = text .. ": " .. tostring(v) end, GetValue = function() return value end}
end

function GUI:CreateButton(tab, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Theme.ButtonBackground
    btn.Text = text
    btn.TextColor3 = Theme.ButtonText
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.AutoButtonColor = false
    btn.Parent = tab
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(230, 230, 230)}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.ButtonBackground}):Play() end)
    btn.MouseButton1Click:Connect(function() callback() end)
end

function GUI:CreateDropdown(tab, text, options, callback)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, 0, 0, 38)
    dropdownFrame.BackgroundColor3 = Theme.SidebarButton
    dropdownFrame.BorderSizePixel = 0
    dropdownFrame.Parent = tab
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = dropdownFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = dropdownFrame
    
    local dropdownBtn = Instance.new("TextButton")
    dropdownBtn.Size = UDim2.new(0.5, -20, 0, 24)
    dropdownBtn.Position = UDim2.new(0.5, 0, 0.5, -12)
    dropdownBtn.BackgroundColor3 = Theme.Background
    dropdownBtn.Text = options[1] or "Select..."
    dropdownBtn.TextColor3 = Theme.Text
    dropdownBtn.Font = Enum.Font.GothamMedium
    dropdownBtn.TextSize = 11
    dropdownBtn.AutoButtonColor = false
    dropdownBtn.Parent = dropdownFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = dropdownBtn
    
    local selectedOption = options[1]
    
    dropdownBtn.MouseButton1Click:Connect(function()
        local currentIndex = table.find(options, selectedOption) or 1
        local nextIndex = (currentIndex % #options) + 1
        selectedOption = options[nextIndex]
        dropdownBtn.Text = selectedOption
        callback(selectedOption)
    end)
    
    return {SetValue = function(value) selectedOption = value dropdownBtn.Text = value callback(value) end, GetValue = function() return selectedOption end}
end

-- ==================== SKIN CHANGER (VISUAL ONLY) ====================
local SkinChanger = {}

-- Skin Data with Images (Asset IDs from Roblox)
SkinChanger.KnifeData = {
    {Name = "Default", ID = 0, Rarity = "Common"},
    {Name = "Heat", ID = 1234567, Rarity = "Rare"},
    {Name = "Chroma Heat", ID = 1234568, Rarity = "Chroma"},
    {Name = "Seer", ID = 1234569, Rarity = "Godly"},
    {Name = "Chroma Seer", ID = 1234570, Rarity = "Chroma"},
    {Name = "Elderwood", ID = 1234571, Rarity = "Ancient"},
    {Name = "Icebeam", ID = 1234572, Rarity = "Rare"},
    {Name = "Laser", ID = 1234573, Rarity = "Rare"},
    {Name = "Prismatic", ID = 1234574, Rarity = "Godly"},
    {Name = "Chroma Prismatic", ID = 1234575, Rarity = "Chroma"},
    {Name = "Biograft", ID = 1234576, Rarity = "Godly"},
    {Name = "Chroma Biograft", ID = 1234577, Rarity = "Chroma"},
    {Name = "Batwing", ID = 1234578, Rarity = "Ancient"},
    {Name = "Ghost", ID = 1234579, Rarity = "Ghost"},
    {Name = "Phantom", ID = 1234580, Rarity = "Ghost"},
    {Name = "Crimson", ID = 1234581, Rarity = "Godly"},
    {Name = "Nik's Scythe", ID = 1234582, Rarity = "Ancient"},
    {Name = "Sparkle Time", ID = 1234583, Rarity = "Rare"},
    {Name = "Iceflake", ID = 1234584, Rarity = "Rare"},
    {Name = "Hallow's Edge", ID = 1234585, Rarity = "Ancient"},
    {Name = "Eternal", ID = 1234586, Rarity = "Godly"},
    {Name = "Hallow's Blade", ID = 1234587, Rarity = "Ancient"},
}

SkinChanger.GunData = {
    {Name = "Default", ID = 0, Rarity = "Common"},
    {Name = "Laser", ID = 2234567, Rarity = "Rare"},
    {Name = "Chroma Laser", ID = 2234568, Rarity = "Chroma"},
    {Name = "Elderwood", ID = 2234569, Rarity = "Ancient"},
    {Name = "Icebeam", ID = 2234570, Rarity = "Rare"},
    {Name = "Seer", ID = 2234571, Rarity = "Godly"},
    {Name = "Chroma Seer", ID = 2234572, Rarity = "Chroma"},
    {Name = "Prismatic", ID = 2234573, Rarity = "Godly"},
    {Name = "Chroma Prismatic", ID = 2234574, Rarity = "Chroma"},
    {Name = "Revolver", ID = 2234575, Rarity = "Vintage"},
    {Name = "Pixel", ID = 2234576, Rarity = "Rare"},
    {Name = "Turkey", ID = 2234577, Rarity = "Unique"},
    {Name = "America", ID = 2234578, Rarity = "Unique"},
    {Name = "Sparkle Time", ID = 2234579, Rarity = "Rare"},
    {Name = "Ghost", ID = 2234580, Rarity = "Ghost"},
}

SkinChanger.EffectData = {
    {Name = "Default", ID = 0},
    {Name = "Fire", ID = 1},
    {Name = "Ice", ID = 2},
    {Name = "Thunder", ID = 3},
    {Name = "Blood", ID = 4},
    {Name = "Confetti", ID = 5},
    {Name = "Rainbow", ID = 6},
    {Name = "Ghost", ID = 7},
    {Name = "Void", ID = 8},
    {Name = "Nature", ID = 9},
}

SkinChanger.SelectedKnife = nil
SkinChanger.SelectedGun = nil
SkinChanger.SelectedEffect = nil

-- Rarity Colors
SkinChanger.RarityColors = {
    ["Common"] = Color3.fromRGB(150, 150, 150),
    ["Rare"] = Color3.fromRGB(100, 150, 255),
    ["Godly"] = Color3.fromRGB(255, 215, 0),
    ["Chroma"] = Color3.fromRGB(50, 255, 150),
    ["Ancient"] = Color3.fromRGB(255, 100, 50),
    ["Ghost"] = Color3.fromRGB(200, 200, 255),
    ["Vintage"] = Color3.fromRGB(200, 150, 100),
    ["Unique"] = Color3.fromRGB(255, 100, 255),
}

-- Create VISUAL ONLY tool (client-side, only you can see)
function SkinChanger:CreateVisualTool(skinData, skinType)
    local player = Players.LocalPlayer
    local char = player.Character
    if not char then return false end
    
    -- Find current weapon
    local currentTool = nil
    for _, item in ipairs(char:GetChildren()) do
        if item:IsA("Tool") then
            local name = item.Name:lower()
            if (skinType == "Knife" and name:find("knife")) or 
               (skinType == "Gun" and (name:find("gun") or name:find("pistol"))) then
                currentTool = item
                break
            end
        end
    end
    
    if not currentTool then
        -- Check backpack
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            for _, item in ipairs(backpack:GetChildren()) do
                if item:IsA("Tool") then
                    local name = item.Name:lower()
                    if (skinType == "Knife" and name:find("knife")) or 
                       (skinType == "Gun" and (name:find("gun") or name:find("pistol"))) then
                        currentTool = item
                        break
                    end
                end
            end
        end
    end
    
    if not currentTool then
        warn("[SkinChanger] No " .. skinType .. " found to apply skin")
        return false
    end
    
    -- Apply visual changes to existing tool (CLIENT SIDE ONLY)
    local handle = currentTool:FindFirstChild("Handle")
    if handle then
        -- Store original appearance for restoration
        if not handle:GetAttribute("OriginalMaterial") then
            handle:SetAttribute("OriginalMaterial", handle.Material.Value)
            handle:SetAttribute("OriginalColor", tostring(handle.Color))
            handle:SetAttribute("OriginalTransparency", handle.Transparency)
        end
        
        -- Apply new visual appearance
        handle.Material = Enum.Material.Neon
        handle.Transparency = 0.2
        handle.Reflectance = 0.8
        
        -- Color based on rarity
        local rarityColor = SkinChanger.RarityColors[skinData.Rarity] or Color3.fromRGB(255, 255, 255)
        handle.Color = rarityColor
        
        -- Add glow effect (only visible to you)
        local existingLight = handle:FindFirstChild("SkinGlow")
        if existingLight then existingLight:Destroy() end
        
        local glow = Instance.new("PointLight")
        glow.Name = "SkinGlow"
        glow.Color = rarityColor
        glow.Brightness = 3
        glow.Range = 15
        glow.Parent = handle
        
        -- Add particle effect for rare skins
        if skinData.Rarity == "Godly" or skinData.Rarity == "Ancient" or skinData.Rarity == "Chroma" then
            local existingParticles = handle:FindFirstChild("SkinParticles")
            if existingParticles then existingParticles:Destroy() end
            
            local particles = Instance.new("ParticleEmitter")
            particles.Name = "SkinParticles"
            particles.Color = ColorSequence.new(rarityColor)
            particles.Size = NumberSequence.new(0.1, 0.3)
            particles.Lifetime = NumberRange.new(0.5, 1)
            particles.Rate = 30
            particles.Speed = NumberRange.new(2, 5)
            particles.SpreadAngle = Vector2.new(360, 360)
            particles.Parent = handle
        end
        
        -- Add BillboardGui with skin name (only you see)
        local existingGui = handle:FindFirstChild("SkinLabel")
        if existingGui then existingGui:Destroy() end
        
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "SkinLabel"
        billboard.Size = UDim2.new(8, 0, 3, 0)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = handle
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = "⚔️ " .. skinData.Name .. " ⚔️"
        label.TextColor3 = rarityColor
        label.TextStrokeTransparency = 0.5
        label.TextScaled = true
        label.Font = Enum.Font.GothamBold
        label.Parent = billboard
    end
    
    -- Modify tool name (client-side only)
    currentTool.Name = skinData.Name
    
    print("[SkinChanger] Applied " .. skinData.Name .. " (" .. skinData.Rarity .. ") - Visible only to you!")
    
    return true
end

-- Remove visual skin (restore original)
function SkinChanger:RemoveVisualSkin(tool)
    if not tool then return end
    
    local handle = tool:FindFirstChild("Handle")
    if handle and handle:GetAttribute("OriginalMaterial") then
        handle.Material = handle:GetAttribute("OriginalMaterial")
        handle.Transparency = handle:GetAttribute("OriginalTransparency")
        
        local glow = handle:FindFirstChild("SkinGlow")
        if glow then glow:Destroy() end
        
        local particles = handle:FindFirstChild("SkinParticles")
        if particles then particles:Destroy() end
        
        local label = handle:FindFirstChild("SkinLabel")
        if label then label:Destroy() end
    end
end
    
    -- Add glow effect
    local light = Instance.new("PointLight")
    light.Color = SkinChanger.RarityColors[skinData.Rarity] or Color3.fromRGB(255, 255, 255)
    light.Brightness = 2
    light.Range = 8
    light.Parent = handle
    
    -- Add BillboardGui with skin name
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(6, 0, 3, 0)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = handle
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "⚔️ " .. skinData.Name
    label.TextColor3 = SkinChanger.RarityColors[skinData.Rarity] or Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard
    
    -- Equip function
    tool.Equipped:Connect(function()
        local char = player.Character
        if char then
            -- Visual effect when equipped
            local highlight = Instance.new("Highlight")
            highlight.Name = "SkinHighlight"
            highlight.FillColor = SkinChanger.RarityColors[skinData.Rarity] or Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.Parent = handle
            
            -- Notification
            print("[SkinChanger] Equipped " .. skinType .. ": " .. skinData.Name)
        end
    end)
    
    tool.Unequipped:Connect(function()
        local highlight = handle:FindFirstChild("SkinHighlight")
        if highlight then highlight:Destroy() end
    end)
    
    tool.Parent = backpack
    
    -- Auto-equip if player has no tool
    if not player.Character:FindFirstChildWhichIsA("Tool") then
        tool.Parent = player.Character
    end
    
    return true
end

-- Apply visual skin to current weapon
function SkinChanger:ApplyVisualSkin()
    local char = Players.LocalPlayer.Character
    if not char then return end
    
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            local toolName = tool.Name:lower()
            
            if toolName:find("knife") and self.SelectedKnife then
                -- Modify visual appearance
                local handle = tool:FindFirstChild("Handle")
                if handle then
                    handle.Material = Enum.Material.Neon
                    handle.BrickColor = BrickColor.new("Really red")
                    
                    local light = handle:FindFirstChild("SkinLight") or Instance.new("PointLight")
                    light.Name = "SkinLight"
                    light.Color = SkinChanger.RarityColors[self.SelectedKnife.Rarity] or Color3.fromRGB(255, 255, 255)
                    light.Brightness = 2
                    light.Range = 10
                    light.Parent = handle
                end
            elseif (toolName:find("gun") or toolName:find("pistol") or toolName:find("revolver")) and self.SelectedGun then
                local handle = tool:FindFirstChild("Handle")
                if handle then
                    handle.Material = Enum.Material.Neon
                    handle.BrickColor = BrickColor.new("Bright blue")
                    
                    local light = handle:FindFirstChild("SkinLight") or Instance.new("PointLight")
                    light.Name = "SkinLight"
                    light.Color = SkinChanger.RarityColors[self.SelectedGun.Rarity] or Color3.fromRGB(255, 255, 255)
                    light.Brightness = 2
                    light.Range = 10
                    light.Parent = handle
                end
            end
        end
    end
end

-- GUI Skin Card System
function GUI:CreateSkinCard(parent, skinData, skinType, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 140, 0, 100)
    card.BackgroundColor3 = Theme.SidebarButton
    card.BorderSizePixel = 0
    card.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = card
    
    -- Border based on rarity
    local border = Instance.new("UIStroke")
    border.Color = SkinChanger.RarityColors[skinData.Rarity] or Color3.fromRGB(100, 100, 100)
    border.Thickness = 2
    border.Transparency = 0.3
    border.Parent = card
    
    -- Image placeholder (would need actual asset IDs)
    local imageFrame = Instance.new("Frame")
    imageFrame.Size = UDim2.new(1, -20, 0, 50)
    imageFrame.Position = UDim2.new(0, 10, 0, 5)
    imageFrame.BackgroundColor3 = Theme.Background
    imageFrame.BorderSizePixel = 0
    imageFrame.Parent = card
    
    local imageCorner = Instance.new("UICorner")
    imageCorner.CornerRadius = UDim.new(0, 6)
    imageCorner.Parent = imageFrame
    
    -- Rarity icon
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(1, 0, 1, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = "⚔️" -- Default icon
    iconLabel.TextColor3 = SkinChanger.RarityColors[skinData.Rarity] or Color3.fromRGB(255, 255, 255)
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.TextSize = 30
    iconLabel.Parent = imageFrame
    
    -- Skin name
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -20, 0, 20)
    nameLabel.Position = UDim2.new(0, 10, 0, 58)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = skinData.Name
    nameLabel.TextColor3 = Theme.Text
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 11
    nameLabel.TextWrapped = true
    nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    nameLabel.Parent = card
    
    -- Rarity label
    local rarityLabel = Instance.new("TextLabel")
    rarityLabel.Size = UDim2.new(1, -20, 0, 14)
    rarityLabel.Position = UDim2.new(0, 10, 1, -18)
    rarityLabel.BackgroundTransparency = 1
    rarityLabel.Text = skinData.Rarity or "Common"
    rarityLabel.TextColor3 = SkinChanger.RarityColors[skinData.Rarity] or Color3.fromRGB(150, 150, 150)
    rarityLabel.Font = Enum.Font.Gotham
    rarityLabel.TextSize = 9
    rarityLabel.Parent = card
    
    -- Button overlay
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = card
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), {BackgroundColor3 = Theme.SidebarButtonHover}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), {BackgroundColor3 = Theme.SidebarButton}):Play()
    end)
    
    btn.MouseButton1Click:Connect(function()
        -- Visual feedback
        border.Transparency = 0
        TweenService:Create(border, TweenInfo.new(0.3), {Transparency = 0.3}):Play()
        
        callback(skinData)
    end)
    
    return card
end

function GUI:CreateSkinGrid(tab, skins, skinType, onSelected)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.BackgroundTransparency = 1
    container.Parent = tab
    
    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.CellSize = UDim2.new(0, 145, 0, 105)
    gridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
    gridLayout.Parent = container
    
    -- Automatic canvas size adjustment
    gridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local contentSize = gridLayout.AbsoluteContentSize
        container.Size = UDim2.new(1, 0, 0, contentSize.Y + 10)
    end)
    
    for _, skinData in ipairs(skins) do
        self:CreateSkinCard(container, skinData, skinType, function(selected)
            -- Store selection
            if skinType == "Knife" then
                SkinChanger.SelectedKnife = selected
            elseif skinType == "Gun" then
                SkinChanger.SelectedGun = selected
            else
                SkinChanger.SelectedEffect = selected
            end
            
            -- Create visual tool
            SkinChanger:CreateVisualTool(selected, skinType)
            
            -- Callback
            onSelected(selected)
        end)
    end
    
    return container
end

-- ==================== OPTIMIZATION ====================
local Optimization = {}

function Optimization:FPSBoost()
    if Config.FPSBoost then
        settings().Rendering.QualityLevel = 1
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
        Lighting.Brightness = 2
        
        for _, effect in ipairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") then effect.Enabled = false end
        end
    else
        settings().Rendering.QualityLevel = 3
        Lighting.GlobalShadows = true
    end
end

function Optimization:FullOptimization()
    if Config.Optimization then
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end
        
        settings().Rendering.QualityLevel = 1
        UserSettings():GetService("UserGameSettings").SavedQualityLevel = 1
    else
        settings().Rendering.QualityLevel = 3
        UserSettings():GetService("UserGameSettings").SavedQualityLevel = 10
    end
end

-- ==================== CHAMS ====================
local Chams = {}
Chams.Highlights = {}

function Chams:ApplyGunChams()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer then
            local char = plr.Character
            if char then
                for _, item in ipairs(char:GetChildren()) do
                    if item:IsA("Tool") then
                        local handle = item:FindFirstChild("Handle")
                        if handle and not handle:FindFirstChild("ChamsHighlight") then
                            local highlight = Instance.new("Highlight")
                            highlight.Name = "ChamsHighlight"
                            highlight.FillColor = Color3.fromRGB(255, 50, 50)
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            highlight.FillTransparency = 0.5
                            highlight.OutlineTransparency = 0
                            highlight.Adornee = handle
                            highlight.Parent = handle
                            table.insert(self.Highlights, highlight)
                        end
                    end
                end
            end
        end
    end
end

function Chams:ApplyPlayerChams()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer and plr.Character and not plr.Character:FindFirstChild("PlayerChams") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "PlayerChams"
            
            local function getRoleColor()
                local char = plr.Character
                if not char then return Color3.fromRGB(200, 200, 200) end
                
                local function hasItem(name)
                    for _, item in ipairs(char:GetChildren()) do
                        if item:IsA("Tool") and item.Name:lower():find(name:lower()) then return true end
                    end
                    local backpack = plr:FindFirstChild("Backpack")
                    if backpack then
                        for _, item in ipairs(backpack:GetChildren()) do
                            if item:IsA("Tool") and item.Name:lower():find(name:lower()) then return true end
                        end
                    end
                    return false
                end
                
                if hasItem("knife") then return Color3.fromRGB(255, 50, 50) end
                if hasItem("gun") or hasItem("pistol") then return Color3.fromRGB(50, 150, 255) end
                return Color3.fromRGB(200, 200, 200)
            end
            
            highlight.FillColor = getRoleColor()
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.7
            highlight.OutlineTransparency = 0
            highlight.Adornee = plr.Character
            highlight.Parent = plr.Character
            table.insert(self.Highlights, highlight)
        end
    end
end

function Chams:ApplySkyChams()
    if not Lighting:FindFirstChild("SkyChams") then
        local sky = Instance.new("Sky")
        sky.Name = "SkyChams"
        sky.SkyboxBk = "rbxassetid://1234567890"
        sky.SkyboxDn = "rbxassetid://1234567890"
        sky.SkyboxFt = "rbxassetid://1234567890"
        sky.SkyboxLf = "rbxassetid://1234567890"
        sky.SkyboxRt = "rbxassetid://1234567890"
        sky.SkyboxUp = "rbxassetid://1234567890"
        sky.Parent = Lighting
    end
    
    Lighting.Brightness = 2
    Lighting.ClockSpeed = 0
    Lighting.TimeOfDay = 12
    Lighting.FogEnd = 100000
    Lighting.FogStart = 0
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end

function Chams:RemoveChams()
    for _, highlight in ipairs(self.Highlights) do
        if highlight and highlight.Parent then highlight:Destroy() end
    end
    self.Highlights = {}
    
    local skyChams = Lighting:FindFirstChild("SkyChams")
    if skyChams then skyChams:Destroy() end
end

function Chams:Run()
    if Config.ChamsGun then self:ApplyGunChams() end
    if Config.ChamsPlayer then self:ApplyPlayerChams() end
    if Config.ChamsSky then self:ApplySkyChams() end
end

-- ==================== ESP (CHAMS STYLE) ====================
local ESP = {Drawings = {}, Highlights = {}}

function ESP:getRoleColor(player)
    local char = player.Character
    if not char then return Color3.fromRGB(200, 200, 200) end
    
    local function hasItem(name)
        for _, item in ipairs(char:GetChildren()) do
            if item:IsA("Tool") and item.Name:lower():find(name:lower()) then return true end
        end
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            for _, item in ipairs(backpack:GetChildren()) do
                if item:IsA("Tool") and item.Name:lower():find(name:lower()) then return true end
            end
        end
        return false
    end
    
    if hasItem("knife") then return Color3.fromRGB(255, 50, 50) end
    if hasItem("gun") or hasItem("pistol") then return Color3.fromRGB(50, 150, 255) end
    return Color3.fromRGB(200, 200, 200)
end

function ESP:ApplyChams(player)
    local char = player.Character
    if not char then return end
    
    -- Remove existing highlight
    local existing = char:FindFirstChild("ESP_Chams")
    if existing then existing:Destroy() end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Chams"
    highlight.FillColor = self:getRoleColor(player)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.3
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = char
    highlight.Parent = char
    
    self.Highlights[player.UserId] = highlight
end

function ESP:RemoveChams(player)
    if player and self.Highlights[player.UserId] then
        if self.Highlights[player.UserId].Parent then
            self.Highlights[player.UserId]:Destroy()
        end
        self.Highlights[player.UserId] = nil
    end
end

function ESP:Run()
    local camera = Workspace.CurrentCamera
    local localPlayer = Players.LocalPlayer
    local localChar = localPlayer.Character
    if not localChar then return end
    
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return end
    
    local viewportSize = camera.ViewportSize
    local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    
    local activeKeys = {}
    local activePlayers = {}
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= localPlayer then
            local char = plr.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                local humanoid = char:FindFirstChild("Humanoid")
                if root and humanoid and humanoid.Health > 0 then
                    local dist = (root.Position - localRoot.Position).Magnitude
                    if dist <= Config.Distance then
                        
                        -- ESP Chams (Main feature)
                        if Config.BoxEnabled then
                            table.insert(activePlayers, plr.UserId)
                            
                            -- Update or create chams
                            if not self.Highlights[plr.UserId] or not self.Highlights[plr.UserId].Parent then
                                self:ApplyChams(plr)
                            else
                                -- Update color in real-time
                                self.Highlights[plr.UserId].FillColor = self:getRoleColor(plr)
                            end
                        end
                        
                        -- Tracers
                        if Config.TracersEnabled then
                            local key = "tracer_" .. plr.UserId
                            table.insert(activeKeys, key)
                            
                            local rootScreen, onScreen = camera:WorldToScreenPoint(root.Position)
                            
                            if onScreen then
                                if not self.Drawings[key] then
                                    self.Drawings[key] = Drawing.new("Line")
                                    self.Drawings[key].Thickness = 2
                                end
                                self.Drawings[key].Visible = true
                                self.Drawings[key].From = Vector2.new(viewportSize.X / 2, viewportSize.Y)
                                self.Drawings[key].To = Vector2.new(rootScreen.X, rootScreen.Y)
                                self.Drawings[key].Color = self:getRoleColor(plr)
                            elseif self.Drawings[key] then
                                self.Drawings[key].Visible = false
                            end
                        end
                        
                        -- Name Tags
                        if Config.NameTags then
                            local key = "name_" .. plr.UserId
                            local distKey = "name_dist_" .. plr.UserId
                            table.insert(activeKeys, key)
                            table.insert(activeKeys, distKey)
                            
                            local head = char:FindFirstChild("Head")
                            local pos = head and head.Position or root.Position
                            local screenPos, onScreen = camera:WorldToScreenPoint(pos + Vector3.new(0, 2, 0))
                            
                            if onScreen then
                                if not self.Drawings[key] then
                                    self.Drawings[key] = Drawing.new("Text")
                                    self.Drawings[key].Size = 14
                                    self.Drawings[key].Font = 2
                                    self.Drawings[key].Center = true
                                    self.Drawings[key].Outline = true
                                end
                                self.Drawings[key].Visible = true
                                self.Drawings[key].Text = plr.Name
                                self.Drawings[key].Position = Vector2.new(screenPos.X, screenPos.Y - 10)
                                self.Drawings[key].Color = self:getRoleColor(plr)
                                
                                if not self.Drawings[distKey] then
                                    self.Drawings[distKey] = Drawing.new("Text")
                                    self.Drawings[distKey].Size = 12
                                    self.Drawings[distKey].Font = 2
                                    self.Drawings[distKey].Center = true
                                    self.Drawings[distKey].Outline = true
                                end
                                self.Drawings[distKey].Visible = true
                                self.Drawings[distKey].Text = "[" .. math.floor(dist) .. "m]"
                                self.Drawings[distKey].Position = Vector2.new(screenPos.X, screenPos.Y + 8)
                                self.Drawings[distKey].Color = Color3.fromRGB(180, 180, 180)
                            else
                                if self.Drawings[key] then self.Drawings[key].Visible = false end
                                if self.Drawings[distKey] then self.Drawings[distKey].Visible = false end
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- Remove inactive chams
    for userId, highlight in pairs(self.Highlights) do
        if not table.find(activePlayers, userId) then
            if highlight and highlight.Parent then
                highlight:Destroy()
            end
            self.Highlights[userId] = nil
        end
    end
    
    -- Remove inactive drawings
    for key, drawing in pairs(self.Drawings) do
        if drawing and not table.find(activeKeys, key) then
            drawing:Remove()
            self.Drawings[key] = nil
        end
    end
end

function ESP:Stop()
    for _, drawing in pairs(self.Drawings) do
        if drawing then drawing:Remove() end
    end
    self.Drawings = {}
    
    for _, highlight in pairs(self.Highlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    self.Highlights = {}
end

-- ==================== TROLLING ====================
local Trolling = {}

function Trolling:findMurder()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer then
            local char = plr.Character
            if char then
                local function hasKnife(container)
                    for _, item in ipairs(container:GetChildren()) do
                        if item:IsA("Tool") and item.Name:lower():find("knife") then return true end
                    end
                    return false
                end
                
                if hasKnife(char) then return plr end
                local backpack = plr:FindFirstChild("Backpack")
                if backpack and hasKnife(backpack) then return plr end
            end
        end
    end
    return nil
end

function Trolling:findSheriff()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer then
            local char = plr.Character
            if char then
                local function hasGun(container)
                    for _, item in ipairs(container:GetChildren()) do
                        if item:IsA("Tool") then
                            local name = item.Name:lower()
                            if name:find("gun") or name:find("pistol") or name:find("revolver") then return true end
                        end
                    end
                    return false
                end
                
                if hasGun(char) then return plr end
                local backpack = plr:FindFirstChild("Backpack")
                if backpack and hasGun(backpack) then return plr end
            end
        end
    end
    return nil
end

-- IMPROVED FLING - Actually kills targets
function Trolling:flingPlayer(targetPlayer)
    if not targetPlayer then return false, "No target" end
    
    local localPlayer = Players.LocalPlayer
    local localChar = localPlayer.Character
    if not localChar then return false, "No character" end
    
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    local localHumanoid = localChar:FindFirstChild("Humanoid")
    
    if not localRoot or not localHumanoid then return false, "No root/humanoid" end
    
    local targetChar = targetPlayer.Character
    if not targetChar then return false, "Target has no character" end
    
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    local targetHumanoid = targetChar:FindFirstChild("Humanoid")
    
    if not targetRoot or not targetHumanoid then return false, "Target has no root/humanoid" end
    if targetHumanoid.Health <= 0 then return false, "Target already dead" end
    
    -- Store original values
    local originalWalkSpeed = localHumanoid.WalkSpeed
    local originalJumpPower = localHumanoid.JumpPower
    local originalGravity = Workspace.Gravity
    
    -- Anti-gravity setup
    Workspace.Gravity = 0
    localHumanoid.WalkSpeed = 0
    localHumanoid.JumpPower = 0
    
    -- Create velocity and gyro
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Name = "FlingVelocity"
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = localRoot
    
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.Name = "FlingGyro"
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.P = 9e4
    bodyGyro.Parent = localRoot
    
    -- Phase 1: Position above target
    local targetPos = targetRoot.Position + Vector3.new(0, 8, 0)
    localRoot.CFrame = CFrame.new(targetPos)
    
    task.wait(0.2)
    
    -- Phase 2: Rapid spin + velocity abuse (kills through fling)
    local startTime = tick()
    local spinSpeed = 0
    local maxSpinSpeed = 99999
    
    while tick() - startTime < 2.5 do
        if not localRoot or not localRoot.Parent then break end
        if not targetRoot or not targetRoot.Parent then break end
        if targetHumanoid.Health <= 0 then break end
        
        -- Spin faster over time
        spinSpeed = math.min(spinSpeed + 5000, maxSpinSpeed)
        
        -- Update position to follow target
        local currentTargetPos = targetRoot.Position + Vector3.new(0, 5, 0)
        localRoot.CFrame = CFrame.new(currentTargetPos) * CFrame.Angles(0, math.rad(spinSpeed * (tick() - startTime)), 0)
        
        -- Extreme velocity bursts
        local direction = (targetRoot.Position - localRoot.Position).Unit
        localRoot.Velocity = direction * 5000 + Vector3.new(
            math.random(-2000, 2000),
            math.random(1000, 3000),
            math.random(-2000, 2000)
        )
        
        -- Rotational velocity (key for fling damage)
        localRoot.RotVelocity = Vector3.new(
            math.random(-99999, 99999),
            math.random(-99999, 99999),
            math.random(-99999, 99999)
        )
        
        task.wait(0.03)
    end
    
    -- Phase 3: Final impact burst
    if localRoot and targetRoot and targetHumanoid.Health > 0 then
        localRoot.CFrame = CFrame.new(targetRoot.Position + Vector3.new(0, 3, 0))
        
        for i = 1, 5 do
            if not localRoot then break end
            localRoot.Velocity = Vector3.new(
                math.random(-10000, 10000),
                math.random(5000, 10000),
                math.random(-10000, 10000)
            )
            localRoot.RotVelocity = Vector3.new(99999, 99999, 99999)
            task.wait(0.05)
        end
    end
    
    -- Cleanup
    task.wait(0.3)
    
    if bodyVelocity and bodyVelocity.Parent then bodyVelocity:Destroy() end
    if bodyGyro and bodyGyro.Parent then bodyGyro:Destroy() end
    
    Workspace.Gravity = originalGravity
    localHumanoid.WalkSpeed = originalWalkSpeed
    localHumanoid.JumpPower = originalJumpPower
    
    if localRoot then
        localRoot.Velocity = Vector3.new(0, 0, 0)
        localRoot.RotVelocity = Vector3.new(0, 0, 0)
    end
    
    -- Check if successful
    local success = targetHumanoid.Health <= 0 or not targetRoot or not targetRoot.Parent
    
    return success, success and "Target killed!" or "Target survived (maybe respawned)"
end

function Trolling:flingMurder()
    local murder = self:findMurder()
    if murder then 
        local success, msg = self:flingPlayer(murder)
        return success, murder.Name .. " - " .. msg
    end
    return false, "No murderer found"
end

function Trolling:flingSheriff()
    local sheriff = self:findSheriff()
    if sheriff then 
        local success, msg = self:flingPlayer(sheriff)
        return success, sheriff.Name .. " - " .. msg
    end
    return false, "No sheriff found"
end

-- ==================== MOVEMENT ====================
local Movement = {}
Movement.FlyConnection = nil
Movement.NoclipConnection = nil

function Movement:UpdateSpeed()
    local char = Players.LocalPlayer.Character
    if not char then return end
    
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = Config.SpeedEnabled and Config.SpeedValue or 16
    end
end

function Movement:UpdateJump()
    local char = Players.LocalPlayer.Character
    if not char then return end
    
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.JumpPower = Config.JumpPower
    end
end

function Movement:Fly()
    local char = Players.LocalPlayer.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    if self.FlyConnection then
        self.FlyConnection:Disconnect()
        self.FlyConnection = nil
    end
    
    local bodyVelocity = root:FindFirstChild("FlyVelocity")
    local bodyGyro = root:FindFirstChild("FlyGyro")
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    
    if Config.FlyEnabled then
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "FlyVelocity"
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = root
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.Name = "FlyGyro"
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.P = 9e4
        bodyGyro.Parent = root
        
        self.FlyConnection = RunService.RenderStepped:Connect(function()
            if not Config.FlyEnabled or not root or not root.Parent then
                if bodyVelocity and bodyVelocity.Parent then bodyVelocity:Destroy() end
                if bodyGyro and bodyGyro.Parent then bodyGyro:Destroy() end
                return
            end
            
            local camera = Workspace.CurrentCamera
            local moveDir = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, 1, 0) end
            
            bodyVelocity.Velocity = moveDir * Config.FlySpeed
            bodyGyro.CFrame = camera.CFrame
        end)
    end
end

function Movement:Noclip()
    if self.NoclipConnection then
        self.NoclipConnection:Disconnect()
        self.NoclipConnection = nil
    end
    
    if Config.NoclipEnabled then
        self.NoclipConnection = RunService.Stepped:Connect(function()
            local char = Players.LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        local char = Players.LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- ==================== RAGE ====================
local Rage = {}
Rage.SpinConnection = nil

function Rage:Spin()
    if self.SpinConnection then
        self.SpinConnection:Disconnect()
        self.SpinConnection = nil
    end
    
    if Config.SpinEnabled then
        local localPlayer = Players.LocalPlayer
        local angle = 0
        
        self.SpinConnection = RunService.RenderStepped:Connect(function()
            local char = localPlayer.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    angle = angle + (Config.SpinSpeed / 100)
                    root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(angle), 0)
                end
            end
        end)
    end
end

-- ==================== AIMBOT ====================
local Aimbot = {}
local FOVCircle = nil

function Aimbot:CreateFOVCircle()
    if FOVCircle then FOVCircle:Remove() end
    if not Config.ShowFOV then return end
    
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Radius = Config.AimbotFOV
    FOVCircle.Filled = false
    FOVCircle.Thickness = 2
    FOVCircle.Color = Color3.fromRGB(255, 255, 255)
    FOVCircle.Transparency = 0.7
    FOVCircle.Visible = Config.ShowFOV
end

function Aimbot:UpdateFOVCircle()
    if not FOVCircle then
        if Config.ShowFOV then self:CreateFOVCircle() end
        return
    end
    
    if Config.ShowFOV then
        local camera = Workspace.CurrentCamera
        local viewportSize = camera.ViewportSize
        local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
        
        FOVCircle.Position = screenCenter
        FOVCircle.Radius = Config.AimbotFOV
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end
end

function Aimbot:getBestTarget()
    local camera = Workspace.CurrentCamera
    local localPlayer = Players.LocalPlayer
    local localChar = localPlayer.Character
    if not localChar then return nil end
    
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end
    
    local viewportSize = camera.ViewportSize
    local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    
    local bestTarget = nil
    local bestScore = math.huge
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= localPlayer then
            local char = plr.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                local humanoid = char:FindFirstChild("Humanoid")
                if root and humanoid and humanoid.Health > 0 then
                    local dist = (root.Position - localRoot.Position).Magnitude
                    if dist <= Config.Distance then
                        local isTeam = Config.TeamCheck and localPlayer.Team == plr.Team
                        if not isTeam then
                            local screenPos, onScreen = camera:WorldToScreenPoint(root.Position)
                            if onScreen then
                                local fov = Vector2.new(math.abs(screenPos.X - screenCenter.X), math.abs(screenPos.Y - screenCenter.Y)).Magnitude
                                if fov <= Config.AimbotFOV then
                                    local score = fov + (dist / 10)
                                    if score < bestScore then
                                        bestScore = score
                                        bestTarget = {Player = plr, Character = char, Root = root}
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    return bestTarget
end

function Aimbot:Run()
    if not Config.AimbotEnabled then return end
    
    local target = self:getBestTarget()
    if not target then return end
    
    local char = target.Character
    local head = char:FindFirstChild("Head")
    local aimPos = head and (head.Position + Vector3.new(0, 0.3, 0)) or target.Root.Position
    
    local camera = Workspace.CurrentCamera
    local currentCFrame = camera.CFrame
    local targetCFrame = CFrame.new(currentCFrame.Position, aimPos)
    local newCFrame = currentCFrame:Lerp(targetCFrame, 1 / Config.AimbotSmooth)
    camera.CFrame = newCFrame
end

function Aimbot:SilentAimHook()
    local localPlayer = Players.LocalPlayer
    
    localPlayer.Character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") and Config.SilentAim then
            local name = child.Name:lower()
            if name:find("gun") or name:find("pistol") or name:find("revolver") or name:find("weapon") then
                child.Activated:Connect(function()
                    if Config.SilentAim then
                        local target = self:getBestTarget()
                        if target then
                            local char = target.Character
                            local head = char:FindFirstChild("Head")
                            local aimPos = head and head.Position or target.Root.Position
                            
                            local camera = Workspace.CurrentCamera
                            local targetCFrame = CFrame.new(camera.CFrame.Position, aimPos)
                            camera.CFrame = targetCFrame
                        end
                    end
                end)
            end
        end
    end)
end

-- ==================== MAIN ====================
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Create GUI
local gui = GUI.new("MM2 Script", UDim2.new(0, 650, 0, 450))

-- Create tabs
local visualsTab = gui:CreateTab("Visuals", "👁")
local aimbotTab = gui:CreateTab("Aimbot", "🎯")
local legitTab = gui:CreateTab("Legit", "🚀")
local rageTab = gui:CreateTab("Rage", "💀")
local trollingTab = gui:CreateTab("Trolling", "😈")
local skinTab = gui:CreateTab("Skins", "🗡")
local moreTab = gui:CreateTab("More", "⚡")
local settingsTab = gui:CreateTab("Settings", "⚙")

-- Visuals
gui:CreateSection(visualsTab, "ESP (Chams)")
local espToggle = gui:CreateToggle(visualsTab, "ESP Chams (Player Glow)", function(v) Config.BoxEnabled = v if not v then ESP:Stop() end end)
gui:CreateToggle(visualsTab, "Tracers", function(v) Config.TracersEnabled = v end)
gui:CreateToggle(visualsTab, "Name Tags + Distance", function(v) Config.NameTags = v end)
gui:CreateSlider(visualsTab, "Max Distance", 100, 2000, function(v) Config.Distance = v end)

gui:CreateSection(visualsTab, "Chams")
gui:CreateToggle(visualsTab, "Gun Chams", function(v) Config.ChamsGun = v if not v then Chams:RemoveChams() end end)
gui:CreateToggle(visualsTab, "Player Chams", function(v) Config.ChamsPlayer = v if not v then Chams:RemoveChams() end end)
gui:CreateToggle(visualsTab, "Sky Chams", function(v) Config.ChamsSky = v if not v then Chams:RemoveChams() end end)

-- Skin Changer Tab
gui:CreateSection(skinTab, "🔪 Knife Skins (CLIENT-SIDE ONLY)")
gui:CreateSkinGrid(skinTab, SkinChanger.KnifeData, "Knife", function(skin)
    SkinChanger.SelectedKnife = skin
    SkinChanger:CreateVisualTool(skin, "Knife")
end)

gui:CreateSection(skinTab, "🔫 Gun Skins (CLIENT-SIDE ONLY)")
gui:CreateSkinGrid(skinTab, SkinChanger.GunData, "Gun", function(skin)
    SkinChanger.SelectedGun = skin
    SkinChanger:CreateVisualTool(skin, "Gun")
end)

gui:CreateSection(skinTab, "✨ Kill Effects (Coming Soon)")
gui:CreateSkinGrid(skinTab, SkinChanger.EffectData, "Effect", function(effect)
    SkinChanger.SelectedEffect = effect
    print("[SkinChanger] Selected kill effect: " .. effect.Name)
end)

-- Aimbot
gui:CreateSection(aimbotTab, "Main")
gui:CreateToggle(aimbotTab, "Enable Aimbot", function(v) Config.AimbotEnabled = v end)
gui:CreateToggle(aimbotTab, "Silent Aim (Gun)", function(v) Config.SilentAim = v end)

gui:CreateSection(aimbotTab, "Settings")
gui:CreateToggle(aimbotTab, "Show FOV Circle", function(v) Config.ShowFOV = v Aimbot:CreateFOVCircle() end)
gui:CreateSlider(aimbotTab, "FOV", 50, 300, function(v) Config.AimbotFOV = v end)
gui:CreateSlider(aimbotTab, "Smooth", 1, 20, function(v) Config.AimbotSmooth = v end)

-- Legit Movement
gui:CreateSection(legitTab, "Movement")
gui:CreateToggle(legitTab, "Speed Hack", function(v) Config.SpeedEnabled = v Movement:UpdateSpeed() end)
gui:CreateSlider(legitTab, "Speed", 16, 200, function(v) Config.SpeedValue = v Movement:UpdateSpeed() end)
gui:CreateToggle(legitTab, "Infinite Jump", function(v) Config.InfJumpEnabled = v end)
gui:CreateSlider(legitTab, "Jump Power", 10, 200, function(v) Config.JumpPower = v Movement:UpdateJump() end)
gui:CreateToggle(legitTab, "Fly", function(v) Config.FlyEnabled = v Movement:Fly() end)
gui:CreateSlider(legitTab, "Fly Speed", 50, 300, function(v) Config.FlySpeed = v end)
gui:CreateToggle(legitTab, "Noclip", function(v) Config.NoclipEnabled = v Movement:Noclip() end)

-- Rage
gui:CreateSection(rageTab, "Anti-Aim")
gui:CreateToggle(rageTab, "Spin Bot", function(v) Config.SpinEnabled = v Rage:Spin() end)
gui:CreateSlider(rageTab, "Spin Speed", 10, 200, function(v) Config.SpinSpeed = v end)

gui:CreateSection(rageTab, "Exploits")
gui:CreateToggle(rageTab, "Wallbang (Shoot Through Walls)", function(v) Config.Wallbang = v end)

-- Trolling
gui:CreateSection(trollingTab, "Fling")
gui:CreateButton(trollingTab, "🔥 Fling Murder", function()
    local success = Trolling:flingMurder()
    if success then print("Flinged Murder!") else warn("Failed!") end
end)
gui:CreateButton(trollingTab, "🔫 Fling Sheriff", function()
    local success = Trolling:flingSheriff()
    if success then print("Flinged Sheriff!") else warn("Failed!") end
end)

gui:CreateSection(trollingTab, "Player Selection")
local selectedPlayer = nil
local playerNames = {}
for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then table.insert(playerNames, plr.Name) end
end
if #playerNames == 0 then playerNames = {"No players"} end

local playerDropdown = gui:CreateDropdown(trollingTab, "Target", playerNames, function(v)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Name == v then selectedPlayer = plr break end
    end
end)

gui:CreateButton(trollingTab, "🎯 Fling Selected", function()
    if selectedPlayer then
        local success = Trolling:flingPlayer(selectedPlayer)
        if success then print("Flinged " .. selectedPlayer.Name) else warn("Failed!") end
    end
end)

-- More
gui:CreateSection(moreTab, "Optimization")
gui:CreateToggle(moreTab, "FPS Boost", function(v) Config.FPSBoost = v Optimization:FPSBoost() end)
gui:CreateToggle(moreTab, "Full Optimization", function(v) Config.Optimization = v Optimization:FullOptimization() end)

-- Settings
gui:CreateSection(settingsTab, "General")
gui:CreateToggle(settingsTab, "Team Check", function(v) Config.TeamCheck = v end)
gui:CreateButton(settingsTab, "Unload Script", function()
    ESP:Stop()
    Chams:RemoveChams()
    if FOVCircle then FOVCircle:Remove() end
    if gui.Window then gui.Window:Destroy() end
end)

-- Initialize
UserInputService.JumpRequest:Connect(function()
    if Config.InfJumpEnabled then
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then humanoid:ChangeState("Jumping") end
        end
    end
end)

Aimbot:SilentAimHook()

-- Menu Toggle (FIXED)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Config.MenuKey then
        gui:Toggle()
    end
end)

-- Main Loop
RunService.RenderStepped:Connect(function()
    Aimbot:UpdateFOVCircle()
    
    if Config.AimbotEnabled then Aimbot:Run() end
    if Config.BoxEnabled or Config.TracersEnabled or Config.NameTags then ESP:Run() end
    if Config.ChamsGun or Config.ChamsPlayer or Config.ChamsSky then Chams:Run() end
    
    -- Wallbang
    if Config.Wallbang then
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Character added
LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid")
    task.wait(0.5)
    Movement:UpdateSpeed()
    Movement:UpdateJump()
end)

print("MM2 Script v3.0 Loaded!")
print("Press RightShift to toggle menu")
