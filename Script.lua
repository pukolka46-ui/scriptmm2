--[[
    MM2 Script v1.2
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

-- ==================== CONFIG ====================
local Config = {
    -- Aimbot
    AimbotEnabled = false,
    AimbotFOV = 150,
    AimbotSmooth = 5,
    SilentAim = false,
    ShowFOV = true,
    
    -- Visuals
    ESPEnabled = false,
    TracersEnabled = false,
    BoxEnabled = false,
    NameTags = false,
    Distance = 1000,
    
    -- Settings
    TeamCheck = true,
    MenuKey = Enum.KeyCode.RightShift
}

-- ==================== THEME (NEW DESIGN) ====================
local Theme = {
    Background = Color3.fromRGB(18, 18, 18),
    Sidebar = Color3.fromRGB(25, 25, 25),
    SidebarButton = Color3.fromRGB(35, 35, 35),
    SidebarButtonHover = Color3.fromRGB(45, 45, 45),
    SidebarButtonActive = Color3.fromRGB(255, 65, 65),
    Content = Color3.fromRGB(30, 30, 30),
    Text = Color3.fromRGB(255, 255, 255),
    TextMuted = Color3.fromRGB(140, 140, 140),
    Accent = Color3.fromRGB(255, 65, 65),
    ToggleOff = Color3.fromRGB(50, 50, 50),
    ToggleOn = Color3.fromRGB(255, 65, 65),
    SliderBar = Color3.fromRGB(40, 40, 40),
    SliderFill = Color3.fromRGB(255, 65, 65),
    ButtonBackground = Color3.fromRGB(255, 65, 65),
    GradientStart = Color3.fromRGB(255, 65, 65),
    GradientEnd = Color3.fromRGB(255, 150, 65),
}

-- ==================== GUI ====================
local GUI = {}
GUI.__index = GUI

function GUI.new(title, size)
    local self = setmetatable({}, GUI)
    self.Tabs = {}
    self.ActiveTab = nil
    
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
    mainCorner.CornerRadius = UDim.new(0, 16)
    mainCorner.Parent = mainFrame
    
    -- Gradient border effect
    local borderGradient = Instance.new("UIStroke")
    borderGradient.Color = Theme.Accent
    borderGradient.Thickness = 2
    borderGradient.Transparency = 0.5
    borderGradient.Parent = mainFrame
    
    -- Sidebar with gradient
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 80, 1, 0)
    sidebar.BackgroundColor3 = Theme.Sidebar
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame
    
    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, 16)
    sidebarCorner.Parent = sidebar
    
    local sidebarFix = Instance.new("Frame")
    sidebarFix.Size = UDim2.new(0, 25, 1, 0)
    sidebarFix.Position = UDim2.new(1, -25, 0, 0)
    sidebarFix.BackgroundColor3 = Theme.Sidebar
    sidebarFix.BorderSizePixel = 0
    sidebarFix.Parent = sidebar
    
    -- Accent line on sidebar
    local accentLine = Instance.new("Frame")
    accentLine.Size = UDim2.new(0, 3, 1, 0)
    accentLine.Position = UDim2.new(1, -3, 0, 0)
    accentLine.BackgroundColor3 = Theme.Accent
    accentLine.BorderSizePixel = 0
    accentLine.Parent = sidebar
    
    -- Logo with gradient effect
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
    logoSubtitle.Text = "SCRIPT"
    logoSubtitle.TextColor3 = Theme.TextMuted
    logoSubtitle.Font = Enum.Font.GothamBold
    logoSubtitle.TextSize = 10
    logoSubtitle.Parent = sidebar
    
    -- Buttons container
    local buttonsContainer = Instance.new("Frame")
    buttonsContainer.Size = UDim2.new(1, 0, 1, -130)
    buttonsContainer.Position = UDim2.new(0, 0, 0, 80)
    buttonsContainer.BackgroundTransparency = 1
    buttonsContainer.Parent = sidebar
    
    local buttonsList = Instance.new("UIListLayout")
    buttonsList.Padding = UDim.new(0, 6)
    buttonsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    buttonsList.Parent = buttonsContainer
    
    -- Content area
    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(1, -80, 1, 0)
    contentArea.Position = UDim2.new(0, 80, 0, 0)
    contentArea.BackgroundColor3 = Theme.Background
    contentArea.BorderSizePixel = 0
    contentArea.Parent = mainFrame
    
    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 55)
    header.BackgroundColor3 = Theme.Background
    header.BorderSizePixel = 0
    header.Parent = contentArea
    
    local headerTitle = Instance.new("TextLabel")
    headerTitle.Size = UDim2.new(1, -80, 1, 0)
    headerTitle.Position = UDim2.new(0, 25, 0, 0)
    headerTitle.BackgroundTransparency = 1
    headerTitle.Text = title or "MM2 Script"
    headerTitle.TextColor3 = Theme.Text
    headerTitle.Font = Enum.Font.GothamBold
    headerTitle.TextSize = 22
    headerTitle.TextXAlignment = Enum.TextXAlignment.Left
    headerTitle.Parent = header
    
    local headerSubtitle = Instance.new("TextLabel")
    headerSubtitle.Size = UDim2.new(1, -80, 0, 20)
    headerSubtitle.Position = UDim2.new(0, 25, 0, 30)
    headerSubtitle.BackgroundTransparency = 1
    headerSubtitle.Text = "v1.2 | Made with ❤"
    headerSubtitle.TextColor3 = Theme.TextMuted
    headerSubtitle.Font = Enum.Font.Gotham
    headerSubtitle.TextSize = 11
    headerSubtitle.TextXAlignment = Enum.TextXAlignment.Left
    headerSubtitle.Parent = header
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.Position = UDim2.new(1, -50, 0.5, -17)
    closeBtn.BackgroundColor3 = Theme.SidebarButton
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Theme.Accent
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 18
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = closeBtn
    
    -- Content frame
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -50, 1, -80)
    contentFrame.Position = UDim2.new(0, 25, 0, 60)
    contentFrame.BackgroundColor3 = Theme.Content
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = contentArea
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 12)
    contentCorner.Parent = contentFrame
    
    self.Window = screenGui
    self.MainFrame = mainFrame
    self.ButtonsContainer = buttonsContainer
    self.ContentFrame = contentFrame
    self.Visible = true
    
    -- Close functionality
    closeBtn.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    closeBtn.MouseEnter:Connect(function()
        closeBtn.BackgroundColor3 = Theme.Accent
        closeBtn.TextColor3 = Theme.Text
    end)
    
    closeBtn.MouseLeave:Connect(function()
        closeBtn.BackgroundColor3 = Theme.SidebarButton
        closeBtn.TextColor3 = Theme.Accent
    end)
    
    -- Dragging
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
            mainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
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
    local iconText = icon or "●"
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 65, 0, 50)
    btn.BackgroundColor3 = Theme.SidebarButton
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = self.ButtonsContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(1, 0, 0, 24)
    iconLabel.Position = UDim2.new(0, 0, 0, 6)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = iconText
    iconLabel.TextColor3 = Theme.TextMuted
    iconLabel.Font = Enum.Font.GothamMedium
    iconLabel.TextSize = 18
    iconLabel.Parent = btn
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -4, 0, 16)
    nameLabel.Position = UDim2.new(0, 2, 1, -20)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Theme.TextMuted
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 9
    nameLabel.Parent = btn
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -24, 1, -24)
    scrollFrame.Position = UDim2.new(0, 12, 0, 12)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.ScrollBarImageColor3 = Theme.Accent
    scrollFrame.ScrollBarImageTransparency = 0.3
    scrollFrame.Visible = false
    scrollFrame.Parent = self.ContentFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 8)
    listLayout.Parent = scrollFrame
    
    local padding = Instance.new("UIPadding")
    padding.PaddingBottom = UDim.new(0, 10)
    padding.Parent = scrollFrame
    
    local tab = {
        Button = btn,
        Icon = iconLabel,
        Name = nameLabel,
        Content = scrollFrame
    }
    
    btn.MouseEnter:Connect(function()
        if self.ActiveTab ~= tab then
            btn.BackgroundColor3 = Theme.SidebarButtonHover
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if self.ActiveTab ~= tab then
            btn.BackgroundColor3 = Theme.SidebarButton
        end
    end)
    
    btn.MouseButton1Click:Connect(function()
        self:SetActiveTab(tab)
    end)
    
    table.insert(self.Tabs, tab)
    
    if #self.Tabs == 1 then
        self:SetActiveTab(tab)
    end
    
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
    tab.Icon.TextColor3 = Theme.Text
    tab.Name.TextColor3 = Theme.Text
    self.ActiveTab = tab
end

function GUI:CreateSection(tab, text)
    local section = Instance.new("TextLabel")
    section.Size = UDim2.new(1, 0, 0, 30)
    section.BackgroundTransparency = 1
    section.Text = "  " .. text
    section.TextColor3 = Theme.Accent
    section.Font = Enum.Font.GothamBold
    section.TextSize = 14
    section.TextXAlignment = Enum.TextXAlignment.Left
    section.Parent = tab
end

function GUI:CreateToggle(tab, text, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0, 42)
    toggleFrame.BackgroundColor3 = Theme.SidebarButton
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = tab
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = toggleFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 45, 0, 24)
    btn.Position = UDim2.new(1, -57, 0.5, -12)
    btn.BackgroundColor3 = Theme.ToggleOff
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = toggleFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btn
    
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.Position = UDim2.new(0, 3, 0.5, -9)
    circle.BackgroundColor3 = Theme.TextMuted
    circle.BorderSizePixel = 0
    circle.Parent = btn
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(0, 9)
    circleCorner.Parent = circle
    
    local enabled = false
    
    local function setToggle(value)
        enabled = value
        if enabled then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ToggleOn}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 24, 0.5, -9), BackgroundColor3 = Theme.Text}):Play()
        else
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ToggleOff}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -9), BackgroundColor3 = Theme.TextMuted}):Play()
        end
        callback(enabled)
    end
    
    btn.MouseButton1Click:Connect(function()
        setToggle(not enabled)
    end)
    
    return {
        SetValue = setToggle,
        GetValue = function() return enabled end
    }
end

function GUI:CreateSlider(tab, text, min, max, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 55)
    sliderFrame.BackgroundColor3 = Theme.SidebarButton
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = tab
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = sliderFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 18)
    label.Position = UDim2.new(0, 15, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. tostring(min)
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame
    
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -30, 0, 6)
    bar.Position = UDim2.new(0, 15, 1, -22)
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
    
    return {
        SetValue = function(v)
            value = v
            local percent = (v - min) / (max - min)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            label.Text = text .. ": " .. tostring(v)
        end,
        GetValue = function() return value end
    }
end

function GUI:CreateButton(tab, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Theme.ButtonBackground
    btn.Text = text
    btn.TextColor3 = Theme.Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.AutoButtonColor = false
    btn.Parent = tab
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(255, 85, 85)}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.ButtonBackground}):Play()
    end)
    
    btn.MouseButton1Click:Connect(function()
        callback()
    end)
end

function GUI:CreateDropdown(tab, text, options, callback)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, 0, 0, 42)
    dropdownFrame.BackgroundColor3 = Theme.SidebarButton
    dropdownFrame.BorderSizePixel = 0
    dropdownFrame.Parent = tab
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = dropdownFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = dropdownFrame
    
    local dropdownBtn = Instance.new("TextButton")
    dropdownBtn.Size = UDim2.new(0.5, -20, 0, 26)
    dropdownBtn.Position = UDim2.new(0.5, 0, 0.5, -13)
    dropdownBtn.BackgroundColor3 = Theme.Background
    dropdownBtn.Text = options[1] or "Select..."
    dropdownBtn.TextColor3 = Theme.Text
    dropdownBtn.Font = Enum.Font.GothamMedium
    dropdownBtn.TextSize = 12
    dropdownBtn.AutoButtonColor = false
    dropdownBtn.Parent = dropdownFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = dropdownBtn
    
    local selectedOption = options[1]
    
    dropdownBtn.MouseButton1Click:Connect(function()
        -- Simple cycle through options
        local currentIndex = table.find(options, selectedOption) or 1
        local nextIndex = (currentIndex % #options) + 1
        selectedOption = options[nextIndex]
        dropdownBtn.Text = selectedOption
        callback(selectedOption)
    end)
    
    return {
        SetValue = function(value)
            selectedOption = value
            dropdownBtn.Text = value
            callback(value)
        end,
        GetValue = function() return selectedOption end
    }
end

-- ==================== ESP MODULE ====================
local ESP = {Drawings = {}}

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

function ESP:Run()
    local camera = Workspace.CurrentCamera
    local localPlayer = Players.LocalPlayer
    local localChar = localPlayer.Character
    if not localChar then return end
    
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return end
    
    -- Get screen center for tracers
    local viewportSize = camera.ViewportSize
    local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    
    local activeKeys = {}
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= localPlayer then
            local char = plr.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                local humanoid = char:FindFirstChild("Humanoid")
                if root and humanoid and humanoid.Health > 0 then
                    local dist = (root.Position - localRoot.Position).Magnitude
                    if dist <= Config.Distance then
                        -- Box - FIXED: Properly aligned to hitbox
                        if Config.BoxEnabled then
                            local key = "box_" .. plr.UserId
                            table.insert(activeKeys, key)
                            
                            local head = char:FindFirstChild("Head")
                            local leftLeg = char:FindFirstChild("Left Leg") or char:FindFirstChild("LeftLowerLeg")
                            local rightLeg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLowerLeg")
                            
                            local minY = root.Position.Y - 3
                            local maxY = root.Position.Y + 3
                            
                            if head then
                                maxY = head.Position.Y + 0.5
                            end
                            if leftLeg or rightLeg then
                                local leg = leftLeg or rightLeg
                                minY = leg.Position.Y - 0.5
                            end
                            
                            local topPos = Vector3.new(root.Position.X, maxY, root.Position.Z)
                            local bottomPos = Vector3.new(root.Position.X, minY, root.Position.Z)
                            
                            local topScreen, topOnScreen = camera:WorldToScreenPoint(topPos)
                            local bottomScreen, bottomOnScreen = camera:WorldToScreenPoint(bottomPos)
                            
                            if topOnScreen and bottomOnScreen then
                                local height = math.abs(bottomScreen.Y - topScreen.Y)
                                local width = height * 0.5
                                
                                if not self.Drawings[key] then
                                    self.Drawings[key] = Drawing.new("Square")
                                    self.Drawings[key].Thickness = 2
                                    self.Drawings[key].Filled = false
                                end
                                
                                self.Drawings[key].Visible = true
                                self.Drawings[key].Size = Vector2.new(width, height)
                                self.Drawings[key].Position = Vector2.new(topScreen.X - width / 2, topScreen.Y)
                                self.Drawings[key].Color = self:getRoleColor(plr)
                            elseif self.Drawings[key] then
                                self.Drawings[key].Visible = false
                            end
                        end
                        
                        -- Tracers - FIXED: From screen center, not cursor
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
                                self.Drawings[key].From = screenCenter -- Changed from mouse to screen center
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
                            local screenPos, onScreen = camera:WorldToScreenPoint(pos + Vector3.new(0, 3, 0))
                            
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
    
    -- Clean up
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
end

-- ==================== TROLLING MODULE ====================
local Trolling = {}

function Trolling:findMurder()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer then
            local char = plr.Character
            if char then
                local function hasKnife(container)
                    for _, item in ipairs(container:GetChildren()) do
                        if item:IsA("Tool") and item.Name:lower():find("knife") then
                            return true
                        end
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
                            if name:find("gun") or name:find("pistol") or name:find("revolver") then
                                return true
                            end
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

function Trolling:flingPlayer(targetPlayer)
    if not targetPlayer then 
        warn("No target player!")
        return false 
    end
    
    local localPlayer = Players.LocalPlayer
    local localChar = localPlayer.Character
    if not localChar then 
        warn("No local character!")
        return false 
    end
    
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    local localHumanoid = localChar:FindFirstChild("Humanoid")
    
    if not localRoot or not localHumanoid then 
        warn("No root or humanoid!")
        return false 
    end
    
    local targetChar = targetPlayer.Character
    if not targetChar then 
        warn("No target character!")
        return false 
    end
    
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    local targetHumanoid = targetChar:FindFirstChild("Humanoid")
    
    if not targetRoot or not targetHumanoid then 
        warn("No target root or humanoid!")
        return false 
    end
    
    if targetHumanoid.Health <= 0 then 
        warn("Target is dead!")
        return false 
    end
    
    -- Store original values
    local originalWalkSpeed = localHumanoid.WalkSpeed
    local originalJumpPower = localHumanoid.JumpPower
    local originalGravity = Workspace.Gravity
    
    -- Disable physics constraints
    Workspace.Gravity = 0
    localHumanoid.WalkSpeed = 0
    localHumanoid.JumpPower = 0
    
    -- Teleport to target and create extreme velocity
    local flingPos = targetRoot.Position + Vector3.new(0, 5, 0)
    localRoot.CFrame = CFrame.new(flingPos)
    
    task.wait(0.1)
    
    -- Apply extreme angular velocity for fling effect
    for i = 1, 10 do
        if localRoot and targetRoot then
            localRoot.Velocity = Vector3.new(math.random(-500, 500), math.random(500, 1000), math.random(-500, 500))
            localRoot.RotVelocity = Vector3.new(math.random(-9999, 9999), math.random(-9999, 9999), math.random(-9999, 9999))
            task.wait(0.05)
        end
    end
    
    -- Wait for impact
    task.wait(0.5)
    
    -- Reset everything
    Workspace.Gravity = originalGravity
    localHumanoid.WalkSpeed = originalWalkSpeed
    localHumanoid.JumpPower = originalJumpPower
    
    if localRoot then
        localRoot.Velocity = Vector3.new(0, 0, 0)
        localRoot.RotVelocity = Vector3.new(0, 0, 0)
    end
    
    return true
end

function Trolling:flingMurder()
    local murder = self:findMurder()
    if murder then
        return self:flingPlayer(murder)
    end
    warn("Could not find Murder!")
    return false
end

function Trolling:flingSheriff()
    local sheriff = self:findSheriff()
    if sheriff then
        return self:flingPlayer(sheriff)
    end
    warn("Could not find Sheriff!")
    return false
end

-- ==================== AIMBOT MODULE ====================
local Aimbot = {}
local FOVCircle = nil

function Aimbot:CreateFOVCircle()
    if FOVCircle then FOVCircle:Remove() end
    
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Radius = Config.AimbotFOV
    FOVCircle.Filled = false
    FOVCircle.Thickness = 2
    FOVCircle.Color = Color3.fromRGB(255, 65, 65)
    FOVCircle.Transparency = 0.7
    FOVCircle.Visible = Config.ShowFOV
end

function Aimbot:UpdateFOVCircle()
    if not FOVCircle then return end
    
    if Config.ShowFOV then
        -- FIXED: Center of screen, not cursor
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
    
    -- Use screen center for FOV calculation
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
                                -- Distance from screen center
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

-- ==================== MAIN ====================
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Create GUI
local gui = GUI.new("MM2 Script", UDim2.new(0, 650, 0, 450))

-- Create tabs
local visualsTab = gui:CreateTab("Visuals", "👁")
local aimbotTab = gui:CreateTab("Aimbot", "🎯")
local legitTab = gui:CreateTab("Legit", "🚀")
local trollingTab = gui:CreateTab("Trolling", "😈")
local settingsTab = gui:CreateTab("Settings", "⚙")

-- Visuals
gui:CreateSection(visualsTab, "ESP")
gui:CreateToggle(visualsTab, "ESP Box", function(v) Config.BoxEnabled = v end)
gui:CreateToggle(visualsTab, "Tracers", function(v) Config.TracersEnabled = v end)
gui:CreateToggle(visualsTab, "Name Tags", function(v) Config.NameTags = v end)
gui:CreateSlider(visualsTab, "Max Distance", 100, 2000, function(v) Config.Distance = v end)

-- Aimbot
gui:CreateSection(aimbotTab, "Main")
gui:CreateToggle(aimbotTab, "Enable Aimbot", function(v) Config.AimbotEnabled = v end)
gui:CreateToggle(aimbotTab, "Silent Aim", function(v) Config.SilentAim = v end)

gui:CreateSection(aimbotTab, "Settings")
gui:CreateToggle(aimbotTab, "Show FOV Circle", function(v) 
    Config.ShowFOV = v
    Aimbot:CreateFOVCircle()
end)
gui:CreateSlider(aimbotTab, "FOV", 50, 300, function(v) 
    Config.AimbotFOV = v
end)
gui:CreateSlider(aimbotTab, "Smooth", 1, 20, function(v) Config.AimbotSmooth = v end)

-- Legit Movement
gui:CreateSection(legitTab, "Movement")
gui:CreateToggle(legitTab, "Coming Soon", function(v) end)

-- Trolling
gui:CreateSection(trollingTab, "Fling")
gui:CreateButton(trollingTab, "🔥 Fling Murder", function()
    local success = Trolling:flingMurder()
    if success then
        print("Successfully flung Murder!")
    else
        warn("Failed to fling Murder!")
    end
end)

gui:CreateButton(trollingTab, "🔫 Fling Sheriff", function()
    local success = Trolling:flingSheriff()
    if success then
        print("Successfully flung Sheriff!")
    else
        warn("Failed to fling Sheriff!")
    end
end)

gui:CreateSection(trollingTab, "Player Selection")
local selectedPlayer = nil
local playerNames = {}
for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
        table.insert(playerNames, plr.Name)
    end
end
if #playerNames == 0 then playerNames = {"No players"} end

local playerDropdown = gui:CreateDropdown(trollingTab, "Target", playerNames, function(v)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Name == v then
            selectedPlayer = plr
            break
        end
    end
end)

gui:CreateButton(trollingTab, "🎯 Fling Selected", function()
    if selectedPlayer then
        local success = Trolling:flingPlayer(selectedPlayer)
        if success then
            print("Successfully flung " .. selectedPlayer.Name .. "!")
        else
            warn("Failed to fling " .. selectedPlayer.Name .. "!")
        end
    else
        warn("No player selected!")
    end
end)

-- Settings
gui:CreateSection(settingsTab, "General")
gui:CreateToggle(settingsTab, "Team Check", function(v) Config.TeamCheck = v end)
gui:CreateButton(settingsTab, "Unload Script", function()
    ESP:Stop()
    if FOVCircle then FOVCircle:Remove() end
    if gui.Window then gui.Window:Destroy() end
end)

-- Initialize FOV Circle
Aimbot:CreateFOVCircle()

-- Main Loop
RunService.RenderStepped:Connect(function()
    -- Update FOV Circle
    Aimbot:UpdateFOVCircle()
    
    if Config.AimbotEnabled then
        Aimbot:Run()
    end
    
    if Config.BoxEnabled or Config.TracersEnabled or Config.NameTags then
        ESP:Run()
    end
end)

-- Menu Toggle
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Config.MenuKey then
        gui:Toggle()
    end
end)

print("MM2 Script v1.2 Loaded!")
print("Press RightShift to toggle menu")
