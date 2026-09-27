--[[
    MM2 Script v1.0
    Murder Mystery 2 GUI Script
    
    Injection:
    loadstring(game:HttpGet("https://raw.githubusercontent.com/pukolka46-ui/scriptmm2/main/Script.lua"))()
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- ==================== CONFIG ====================
local Config = {
    -- Aimbot
    AimbotEnabled = false,
    AimbotFOV = 150,
    AimbotSmooth = 5,
    SilentAim = false,
    
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

-- ==================== THEME ====================
local Theme = {
    Background = Color3.fromRGB(15, 15, 20),
    Sidebar = Color3.fromRGB(20, 20, 28),
    SidebarButton = Color3.fromRGB(30, 30, 40),
    SidebarButtonHover = Color3.fromRGB(40, 40, 55),
    SidebarButtonActive = Color3.fromRGB(88, 101, 242),
    Content = Color3.fromRGB(25, 25, 32),
    Text = Color3.fromRGB(240, 240, 245),
    TextMuted = Color3.fromRGB(150, 150, 160),
    Accent = Color3.fromRGB(88, 101, 242),
    ToggleOff = Color3.fromRGB(60, 60, 70),
    ToggleOn = Color3.fromRGB(87, 242, 135),
    SliderBar = Color3.fromRGB(45, 45, 55),
    SliderFill = Color3.fromRGB(88, 101, 242),
    ButtonBackground = Color3.fromRGB(88, 101, 242),
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
    mainFrame.Size = size or UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Theme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame
    
    -- Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 70, 1, 0)
    sidebar.BackgroundColor3 = Theme.Sidebar
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame
    
    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, 12)
    sidebarCorner.Parent = sidebar
    
    local sidebarFix = Instance.new("Frame")
    sidebarFix.Size = UDim2.new(0, 20, 1, 0)
    sidebarFix.Position = UDim2.new(1, -20, 0, 0)
    sidebarFix.BackgroundColor3 = Theme.Sidebar
    sidebarFix.BorderSizePixel = 0
    sidebarFix.Parent = sidebar
    
    -- Logo
    local logoLabel = Instance.new("TextLabel")
    logoLabel.Size = UDim2.new(1, 0, 0, 60)
    logoLabel.BackgroundTransparency = 1
    logoLabel.Text = "MM2"
    logoLabel.TextColor3 = Theme.Accent
    logoLabel.Font = Enum.Font.GothamBold
    logoLabel.TextSize = 18
    logoLabel.Parent = sidebar
    
    -- Buttons container
    local buttonsContainer = Instance.new("Frame")
    buttonsContainer.Size = UDim2.new(1, 0, 1, -130)
    buttonsContainer.Position = UDim2.new(0, 0, 0, 70)
    buttonsContainer.BackgroundTransparency = 1
    buttonsContainer.Parent = sidebar
    
    local buttonsList = Instance.new("UIListLayout")
    buttonsList.Padding = UDim.new(0, 8)
    buttonsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    buttonsList.Parent = buttonsContainer
    
    -- Content area
    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(1, -70, 1, 0)
    contentArea.Position = UDim2.new(0, 70, 0, 0)
    contentArea.BackgroundColor3 = Theme.Background
    contentArea.BorderSizePixel = 0
    contentArea.Parent = mainFrame
    
    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 50)
    header.BackgroundColor3 = Theme.Background
    header.BorderSizePixel = 0
    header.Parent = contentArea
    
    local headerTitle = Instance.new("TextLabel")
    headerTitle.Size = UDim2.new(1, -60, 1, 0)
    headerTitle.Position = UDim2.new(0, 20, 0, 0)
    headerTitle.BackgroundTransparency = 1
    headerTitle.Text = title or "MM2 Script"
    headerTitle.TextColor3 = Theme.Text
    headerTitle.Font = Enum.Font.GothamBold
    headerTitle.TextSize = 20
    headerTitle.TextXAlignment = Enum.TextXAlignment.Left
    headerTitle.Parent = header
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -45, 0.5, -16)
    closeBtn.BackgroundColor3 = Theme.SidebarButton
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 16
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeBtn
    
    -- Content frame
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -40, 1, -70)
    contentFrame.Position = UDim2.new(0, 20, 0, 55)
    contentFrame.BackgroundColor3 = Theme.Content
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = contentArea
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 10)
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
        closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    end)
    
    closeBtn.MouseLeave:Connect(function()
        closeBtn.BackgroundColor3 = Theme.SidebarButton
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
    btn.Size = UDim2.new(0, 54, 0, 54)
    btn.BackgroundColor3 = Theme.SidebarButton
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = self.ButtonsContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(1, 0, 0, 28)
    iconLabel.Position = UDim2.new(0, 0, 0, 8)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = iconText
    iconLabel.TextColor3 = Theme.TextMuted
    iconLabel.Font = Enum.Font.GothamMedium
    iconLabel.TextSize = 20
    iconLabel.Parent = btn
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -4, 0, 16)
    nameLabel.Position = UDim2.new(0, 2, 1, -20)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Theme.TextMuted
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 10
    nameLabel.Parent = btn
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -24, 1, -24)
    scrollFrame.Position = UDim2.new(0, 12, 0, 12)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.ScrollBarImageColor3 = Theme.Accent
    scrollFrame.ScrollBarImageTransparency = 0.5
    scrollFrame.Visible = false
    scrollFrame.Parent = self.ContentFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 10)
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
    section.Size = UDim2.new(1, 0, 0, 35)
    section.BackgroundTransparency = 1
    section.Text = "  " .. text
    section.TextColor3 = Theme.Accent
    section.Font = Enum.Font.GothamBold
    section.TextSize = 15
    section.TextXAlignment = Enum.TextXAlignment.Left
    section.Parent = tab
end

function GUI:CreateToggle(tab, text, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0, 45)
    toggleFrame.BackgroundColor3 = Theme.SidebarButton
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = tab
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = toggleFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50, 0, 26)
    btn.Position = UDim2.new(1, -62, 0.5, -13)
    btn.BackgroundColor3 = Theme.ToggleOff
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = toggleFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 13)
    btnCorner.Parent = btn
    
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = UDim2.new(0, 3, 0.5, -10)
    circle.BackgroundColor3 = Theme.Text
    circle.BorderSizePixel = 0
    circle.Parent = btn
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(0, 10)
    circleCorner.Parent = circle
    
    local enabled = false
    
    local function setToggle(value)
        enabled = value
        if enabled then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ToggleOn}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 27, 0.5, -10)}):Play()
        else
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ToggleOff}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -10)}):Play()
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
    sliderFrame.Size = UDim2.new(1, 0, 0, 60)
    sliderFrame.BackgroundColor3 = Theme.SidebarButton
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = tab
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = sliderFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 15, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. tostring(min)
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame
    
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -30, 0, 8)
    bar.Position = UDim2.new(0, 15, 1, -25)
    bar.BackgroundColor3 = Theme.SliderBar
    bar.BorderSizePixel = 0
    bar.Parent = sliderFrame
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 4)
    barCorner.Parent = bar
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Theme.SliderFill
    fill.BorderSizePixel = 0
    fill.Parent = bar
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
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
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = Theme.ButtonBackground
    btn.Text = text
    btn.TextColor3 = Theme.Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.AutoButtonColor = false
    btn.Parent = tab
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(108, 121, 255)}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.ButtonBackground}):Play()
    end)
    
    btn.MouseButton1Click:Connect(function()
        callback()
    end)
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
    local camera = game.Workspace.CurrentCamera
    local localPlayer = Players.LocalPlayer
    local localChar = localPlayer.Character
    if not localChar then return end
    
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return end
    
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
                        -- Box
                        if Config.BoxEnabled then
                            local key = "box_" .. plr.UserId
                            table.insert(activeKeys, key)
                            
                            local size = Vector3.new(4, 6, 2)
                            local topPos = root.Position + Vector3.new(0, size.Y / 2, 0)
                            local bottomPos = root.Position - Vector3.new(0, size.Y / 2, 0)
                            
                            local topScreen, topOnScreen = camera:WorldToScreenPoint(topPos)
                            local bottomScreen, bottomOnScreen = camera:WorldToScreenPoint(bottomPos)
                            
                            if topOnScreen and bottomOnScreen then
                                local height = math.abs(bottomScreen.Y - topScreen.Y)
                                local width = height * 0.6
                                
                                if not self.Drawings[key] then
                                    self.Drawings[key] = Drawing.new("Square")
                                    self.Drawings[key].Thickness = 1
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
                        
                        -- Tracers
                        if Config.TracersEnabled then
                            local key = "tracer_" .. plr.UserId
                            table.insert(activeKeys, key)
                            
                            local rootScreen, onScreen = camera:WorldToScreenPoint(root.Position)
                            local mouse = UserInputService:GetMouseLocation()
                            
                            if onScreen then
                                if not self.Drawings[key] then
                                    self.Drawings[key] = Drawing.new("Line")
                                    self.Drawings[key].Thickness = 1
                                end
                                self.Drawings[key].Visible = true
                                self.Drawings[key].From = Vector2.new(mouse.X, mouse.Y)
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

-- ==================== AIMBOT MODULE ====================
local Aimbot = {}

function Aimbot:getBestTarget()
    local camera = game.Workspace.CurrentCamera
    local localPlayer = Players.LocalPlayer
    local localChar = localPlayer.Character
    if not localChar then return nil end
    
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end
    
    local mouse = UserInputService:GetMouseLocation()
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
                                local fov = Vector2.new(math.abs(screenPos.X - mouse.X), math.abs(screenPos.Y - mouse.Y)).Magnitude
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
    
    local camera = game.Workspace.CurrentCamera
    local currentCFrame = camera.CFrame
    local targetCFrame = CFrame.new(currentCFrame.Position, aimPos)
    local newCFrame = currentCFrame:Lerp(targetCFrame, 1 / Config.AimbotSmooth)
    camera.CFrame = newCFrame
end

-- ==================== MAIN ====================
local LocalPlayer = Players.LocalPlayer
local Camera = game.Workspace.CurrentCamera

-- Create GUI
local gui = GUI.new("MM2 Script v1.0", UDim2.new(0, 600, 0, 400))

-- Create tabs
local visualsTab = gui:CreateTab("Visuals", "👁")
local aimbotTab = gui:CreateTab("Aimbot", "🎯")
local legitTab = gui:CreateTab("Legit", "🚀")
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
gui:CreateSlider(aimbotTab, "FOV", 50, 300, function(v) Config.AimbotFOV = v end)
gui:CreateSlider(aimbotTab, "Smooth", 1, 20, function(v) Config.AimbotSmooth = v end)

-- Legit Movement
gui:CreateSection(legitTab, "Movement")
gui:CreateToggle(legitTab, "Coming Soon", function(v) end)

-- Settings
gui:CreateSection(settingsTab, "General")
gui:CreateToggle(settingsTab, "Team Check", function(v) Config.TeamCheck = v end)
gui:CreateButton(settingsTab, "Unload Script", function()
    ESP:Stop()
    if gui.Window then gui.Window:Destroy() end
end)

-- Main Loop
RunService.RenderStepped:Connect(function()
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

print("MM2 Script v1.0 Loaded!")
print("Press RightShift to toggle menu")
