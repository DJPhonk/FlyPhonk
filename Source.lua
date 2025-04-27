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
local player = game.Players.LocalPlayer

local flying = false
local speed = 100
local bodyGyro, bodyVelocity

-- Função para criar GUI
local function createGUI()
    -- Cria a GUI
    ScreenGui = Instance.new("ScreenGui")
    Frame = Instance.new("Frame")
    Title = Instance.new("TextLabel")
    FlyButton = Instance.new("TextButton")
    SpeedLabel = Instance.new("TextLabel")
    IncreaseSpeed = Instance.new("TextButton")
    DecreaseSpeed = Instance.new("TextButton")

    -- Configurações do GUI
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
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
end

-- Fly System Melhorado
local function fly()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    -- Criar BodyGyro para controle de orientação
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 10000  -- Ajuste para evitar movimento excessivo
    bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
    bodyGyro.Parent = hrp

    -- Criar BodyVelocity para controle de movimento
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
    bodyVelocity.Parent = hrp

    rs.RenderStepped:Connect(function()
        if flying then
            local camCF = workspace.CurrentCamera.CFrame
            local move = Vector3.new(0, 0, 0)

            -- Movimentação no plano horizontal
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

            -- Controle de altura (movimento no eixo Y)
            if uis:IsKeyDown(Enum.KeyCode.Space) then
                move = move + Vector3.new(0, 1, 0)  -- Subir
            end
            if uis:IsKeyDown(Enum.KeyCode.LeftControl) then
                move = move - Vector3.new(0, 1, 0)  -- Descer
            end

            -- Garantir que a velocidade no eixo Y não vá para valores negativos excessivos (evitar afundamento)
            move = Vector3.new(move.X, math.clamp(move.Y, -1, 1), move.Z) -- Limita o eixo Y para não ultrapassar limites

            -- Atualizar o BodyGyro e BodyVelocity
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

-- Garantir que o GUI seja recriado após a morte
player.CharacterAdded:Connect(function()
    -- Recriar o GUI e garantir que o fly também seja ativado se necessário
    if ScreenGui then
        ScreenGui:Destroy()
    end
    createGUI()
end)

createGUI() -- Cria a GUI pela primeira vez

print("✅ DJ PHONK FLY GUI - Melhorado com Fundo Escuro!")
