--[[
    MM2 Script - Main Loader
    Murder Mystery 2 Roblox Script
]]

local Script = {
    Name = "MM2 Script",
    Version = "1.0",
    Author = "Custom",
    GUI = nil,
    Config = {
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
        MenuKey = Enum.KeyCode.RightShift,
        ShowMenu = true
    }
}

-- Загрузка модулей
local services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    UserInputService = game:GetService("UserInputService"),
    Workspace = game:GetService("Workspace"),
    TextService = game:GetService("TextService"),
    CoreGui = game:GetService("CoreGui")
}

Script.Services = services
Script.LocalPlayer = services.Players.LocalPlayer
Script.Camera = services.Workspace.CurrentCamera

-- Подключение модулей
local GUI = require(script.Parent.GUI)
local Aimbot = require(script.Parent.Aimbot)
local ESP = require(script.Parent.ESP)
local Utils = require(script.Parent.Utils)

function Script:Init()
    -- Создание GUI
    self.GUI = GUI.new(self.Name, UDim2.new(0, 450, 0, 350))
    
    -- Создание вкладок
    local aimbotTab = self.GUI:CreateTab("Aimbot")
    local visualsTab = self.GUI:CreateTab("Visuals")
    local settingsTab = self.GUI:CreateTab("Settings")
    
    -- Aimbot настройки
    self.GUI:CreateToggle(aimbotTab, "Enable Aimbot", function(v)
        self.Config.AimbotEnabled = v
        if not v then Aimbot:Stop() end
    end)
    
    self.GUI:CreateToggle(aimbotTab, "Silent Aim", function(v)
        self.Config.SilentAim = v
    end)
    
    self.GUI:CreateSlider(aimbotTab, "FOV", 50, 300, function(v)
        self.Config.AimbotFOV = v
    end)
    
    self.GUI:CreateSlider(aimbotTab, "Smooth", 1, 20, function(v)
        self.Config.AimbotSmooth = v
    end)
    
    -- Visuals настройки
    self.GUI:CreateToggle(visualsTab, "ESP Box", function(v)
        self.Config.BoxEnabled = v
    end)
    
    self.GUI:CreateToggle(visualsTab, "Tracers", function(v)
        self.Config.TracersEnabled = v
    end)
    
    self.GUI:CreateToggle(visualsTab, "Name Tags", function(v)
        self.Config.NameTags = v
    end)
    
    self.GUI:CreateSlider(visualsTab, "Max Distance", 100, 2000, function(v)
        self.Config.Distance = v
    end)
    
    -- Settings
    self.GUI:CreateToggle(settingsTab, "Team Check", function(v)
        self.Config.TeamCheck = v
    end)
    
    self.GUI:CreateButton(settingsTab, "Unload Script", function()
        self:Unload()
    end)
    
    -- Инициализация модулей
    Aimbot:Init(self)
    ESP:Init(self)
    
    -- Главный цикл
    services.RunService.RenderStepped:Connect(function(delta)
        if self.Config.AimbotEnabled then
            Aimbot:Run()
        end
        
        if self.Config.ESPEnabled or self.Config.TracersEnabled or self.Config.BoxEnabled or self.Config.NameTags then
            ESP:Run()
        end
    end)
    
    -- Обработка меню
    services.UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == self.Config.MenuKey then
            self.GUI:Toggle()
        end
    end)
    
    print(self.Name .. " v" .. self.Version .. " Loaded")
end

function Script:Unload()
    Aimbot:Stop()
    ESP:Stop()
    if self.GUI and self.GUI.Window then
        self.GUI.Window:Destroy()
    end
    print(self.Name .. " Unloaded")
end

-- Запуск
Script:Init()

return Script