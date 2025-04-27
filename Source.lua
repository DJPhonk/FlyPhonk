-- GUI Melhorada 2.0 + Fly Suave by DJ Phonk

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyButton = Instance.new("TextButton")
local SpeedLabel = Instance.new("TextLabel")
local IncreaseSpeed = Instance.new("TextButton")
local DecreaseSpeed = Instance.new("TextButton")

local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "DJPhonkFlyGUI"

-- Fundo escuro
Frame.Size = UDim2.new(0, 220, 0, 200)
Frame.Position = UDim2.new(0, 20, 0, 20)
Frame.BackgroundColor3 = Color3.fromRGB(120, 0, 0) -- Vermelho escuro
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- Título
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Text = "🚀 DJ PHONK FLY 🚀"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = Frame

-- Botão de Ativar Fly
FlyButton.Size = UDim2.new(0, 200, 0, 40)
FlyButton.Position = UDim2.new(0, 10, 0, 40)
FlyButton.Text = "Ativar Fly"
FlyButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0) -- Combina melhor
FlyButton.TextColor3 = Color3.fromRGB(255,255,255)
FlyButton.Font = Enum.Font.GothamBold
FlyButton.TextScaled = true
FlyButton.Parent = Frame

-- Label de Velocidade
SpeedLabel.Size = UDim2.new(0, 200, 0, 30)
SpeedLabel.Position = UDim2.new(0, 10, 0, 90)
SpeedLabel.Text = "Velocidade: 100"
SpeedLabel.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
SpeedLabel.TextColor3 = Color3.fromRGB(255,255,255)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextScaled = true
SpeedLabel.Parent = Frame

-- Botão de Aumentar Velocidade
IncreaseSpeed.Size = UDim2.new(0, 95, 0, 30)
IncreaseSpeed.Position = UDim2.new(0, 10, 0, 140)
IncreaseSpeed.Text = "+"
IncreaseSpeed.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
IncreaseSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
IncreaseSpeed.Font = Enum.Font.GothamBold
IncreaseSpeed.TextScaled = true
IncreaseSpeed.Parent = Frame

-- Botão de Diminuir Velocidade
DecreaseSpeed.Size = UDim2.new(0, 95, 0, 30)
DecreaseSpeed.Position = UDim2.new(0, 115, 0, 140)
DecreaseSpeed.Text = "-"
DecreaseSpeed.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
DecreaseSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
DecreaseSpeed.Font = Enum.Font.GothamBold
DecreaseSpeed.TextScaled = true
DecreaseSpeed.Parent = Frame

-- Fly System Melhorado
local flying = false
local speed = 100
local bodyGyro, bodyVelocity

local function fly()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.Parent = hrp
    bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0,0,0)
    bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
    bodyVelocity.Parent = hrp

    rs.RenderStepped:Connect(function()
        if flying then
            local camCF = workspace.CurrentCamera.CFrame
            local move = Vector3.new(0, 0, 0)
            if uis:IsKeyDown(Enum.KeyCode.W) then
                move = move + (camCF.LookVector)
            end
            if uis:IsKeyDown(Enum.KeyCode.S) then
                move = move - (camCF.LookVector)
            end
            if uis:IsKeyDown(Enum.KeyCode.A) then
                move = move - (camCF.RightVector)
            end
            if uis:IsKeyDown(Enum.KeyCode.D) then
                move = move + (camCF.RightVector)
            end
            if uis:IsKeyDown(Enum.KeyCode.Space) then
                move = move + Vector3.new(0, 1, 0)
            end
            if uis:IsKeyDown(Enum.KeyCode.LeftControl) then
                move = move - Vector3.new(0, 1, 0)
            end

            bodyGyro.CFrame = camCF
            bodyVelocity.Velocity = move.Unit * speed
        end
    end)
end

FlyButton.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        FlyButton.Text = "Desativar Fly"
        fly()
    else
        FlyButton.Text = "Ativar Fly"
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
    end
end)

IncreaseSpeed.MouseButton1Click:Connect(function()
    speed = speed + 10
    SpeedLabel.Text = "Velocidade: "..speed
end)

DecreaseSpeed.MouseButton1Click:Connect(function()
    speed = math.max(10, speed - 10)
    SpeedLabel.Text = "Velocidade: "..speed
end)

print("✅ DJ PHONK FLY GUI - Melhorado com Fundo Escuro!")
