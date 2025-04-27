-- Criar a GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyButton = Instance.new("TextButton")
local SpeedLabel = Instance.new("TextLabel")
local IncreaseSpeed = Instance.new("TextButton")
local DecreaseSpeed = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "FlyGUI"

Frame.Size = UDim2.new(0, 200, 0, 180)
Frame.Position = UDim2.new(0, 10, 0, 10)
Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Fundo vermelho
Frame.Parent = ScreenGui

Title.Size = UDim2.new(0, 180, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Text = "DJ PHONK"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = Frame

FlyButton.Size = UDim2.new(0, 180, 0, 40)
FlyButton.Position = UDim2.new(0, 10, 0, 40)
FlyButton.Text = "Ativar Fly"
FlyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
FlyButton.Parent = Frame

SpeedLabel.Size = UDim2.new(0, 180, 0, 30)
SpeedLabel.Position = UDim2.new(0, 10, 0, 90)
SpeedLabel.Text = "Velocidade: 50"
SpeedLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedLabel.TextColor3 = Color3.fromRGB(255,255,255)
SpeedLabel.Parent = Frame

IncreaseSpeed.Size = UDim2.new(0, 85, 0, 30)
IncreaseSpeed.Position = UDim2.new(0, 10, 0, 130)
IncreaseSpeed.Text = "+"
IncreaseSpeed.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
IncreaseSpeed.Parent = Frame

DecreaseSpeed.Size = UDim2.new(0, 85, 0, 30)
DecreaseSpeed.Position = UDim2.new(0, 105, 0, 130)
DecreaseSpeed.Text = "-"
DecreaseSpeed.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
DecreaseSpeed.Parent = Frame

-- Fly Variables
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Flying = false
local Speed = 50

local function Fly()
    local Character = Player.Character
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    local BodyGyro = Instance.new("BodyGyro", HumanoidRootPart)
    local BodyVelocity = Instance.new("BodyVelocity", HumanoidRootPart)
    BodyGyro.P = 9e4
    BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    BodyGyro.cframe = HumanoidRootPart.CFrame
    BodyVelocity.velocity = Vector3.new(0,0,0)
    BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
    
    while Flying and Character.Parent do
        game.RunService.Stepped:Wait()
        BodyGyro.cframe = workspace.CurrentCamera.CFrame
        BodyVelocity.velocity = workspace.CurrentCamera.CFrame.LookVector * Speed
    end
    
    BodyGyro:Destroy()
    BodyVelocity:Destroy()
end

FlyButton.MouseButton1Click:Connect(function()
    Flying = not Flying
    if Flying then
        FlyButton.Text = "Desativar Fly"
        Fly()
    else
        FlyButton.Text = "Ativar Fly"
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

print("✅ GUI DJ Phonk carregada com fundo vermelho!")
