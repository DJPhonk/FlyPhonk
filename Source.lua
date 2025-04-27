-- Criar a GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyButton = Instance.new("TextButton")
local SpeedLabel = Instance.new("TextLabel")
local IncreaseSpeed = Instance.new("TextButton")
local DecreaseSpeed = Instance.new("TextButton")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "FlyGUI"

Frame.Size = UDim2.new(0, 220, 0, 200)
Frame.Position = UDim2.new(0, 20, 0, 20)
Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Fundo vermelho
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

Title.Size = UDim2.new(0, 200, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Text = "🚀 DJ PHONK 🚀"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = Frame

FlyButton.Size = UDim2.new(0, 200, 0, 40)
FlyButton.Position = UDim2.new(0, 10, 0, 40)
FlyButton.Text = "Ativar Fly"
FlyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
FlyButton.TextColor3 = Color3.fromRGB(255,255,255)
FlyButton.Font = Enum.Font.GothamBold
FlyButton.TextScaled = true
FlyButton.Parent = Frame

SpeedLabel.Size = UDim2.new(0, 200, 0, 30)
SpeedLabel.Position = UDim2.new(0, 10, 0, 90)
SpeedLabel.Text = "Velocidade: 50"
SpeedLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedLabel.TextColor3 = Color3.fromRGB(255,255,255)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextScaled = true
SpeedLabel.Parent = Frame

IncreaseSpeed.Size = UDim2.new(0, 95, 0, 30)
IncreaseSpeed.Position = UDim2.new(0, 10, 0, 140)
IncreaseSpeed.Text = "+"
IncreaseSpeed.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
IncreaseSpeed.TextColor3 = Color3.fromRGB(0, 0, 0)
IncreaseSpeed.Font = Enum.Font.GothamBold
IncreaseSpeed.TextScaled = true
IncreaseSpeed.Parent = Frame

DecreaseSpeed.Size = UDim2.new(0, 95, 0, 30)
DecreaseSpeed.Position = UDim2.new(0, 115, 0, 140)
DecreaseSpeed.Text = "-"
DecreaseSpeed.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
DecreaseSpeed.TextColor3 = Color3.fromRGB(0, 0, 0)
DecreaseSpeed.Font = Enum.Font.GothamBold
DecreaseSpeed.TextScaled = true
DecreaseSpeed.Parent = Frame

-- Fly Variables
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Flying = false
local Speed = 50
local BodyGyro
local BodyVelocity

local function StartFlying()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

    BodyGyro = Instance.new("BodyGyro")
    BodyGyro.P = 9e4
    BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    BodyGyro.CFrame = HumanoidRootPart.CFrame
    BodyGyro.Parent = HumanoidRootPart

    BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.velocity = Vector3.new(0,0,0)
    BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
    BodyVelocity.Parent = HumanoidRootPart

    RunService.Stepped:Connect(function()
        if Flying then
            BodyGyro.CFrame = workspace.CurrentCamera.CFrame
            BodyVelocity.velocity = workspace.CurrentCamera.CFrame.LookVector * Speed
        end
    end)
end

local function StopFlying()
    if BodyGyro then BodyGyro:Destroy() end
    if BodyVelocity then BodyVelocity:Destroy() end
end

FlyButton.MouseButton1Click:Connect(function()
    Flying = not Flying
    if Flying then
        FlyButton.Text = "Desativar Fly"
        StartFlying()
    else
        FlyButton.Text = "Ativar Fly"
        StopFlying()
    end
end)

IncreaseSpeed.MouseButton1Click:Connect(function()
    Speed = Speed + 10
    SpeedLabel.Text = "Velocidade: "..Speed
end)

DecreaseSpeed.MouseButton1Click:Connect(function()
    Speed = math.max(10, Speed - 10)
    SpeedLabel.Text = "Velocidade: "..Speed
end)

print("✅ DJ PHONK GUI carregado com sucesso!")
