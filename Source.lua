-- Criando a GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyButton = Instance.new("TextButton")

local uis = game:GetService("UserInputService")

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

-- Carregar o FlyScript
local flying = false
local bodyGyro, bodyVelocity
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Função para ativar o voo
local function activateFly()
    -- Verifica se já está voando
    if flying then return end
    flying = true

    -- Criação dos BodyGyro e BodyVelocity
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
    bodyGyro.Parent = hrp

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = hrp

    -- Loop para o movimento de voo
    game:GetService("RunService").RenderStepped:Connect(function()
        if flying then
            local camCF = workspace.CurrentCamera.CFrame
            local move = Vector3.new(0, 0, 0)

            -- Movimentos baseados nas teclas pressionadas
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

            -- Atualiza a velocidade e a direção
            bodyGyro.CFrame = camCF
            bodyVelocity.Velocity = move.Unit * 100  -- A velocidade do voo
        end
    end)
end

-- Função para desativar o voo
local function deactivateFly()
    -- Verifica se não está voando
    if not flying then return end
    flying = false

    -- Limpa o BodyGyro e BodyVelocity
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVelocity then bodyVelocity:Destroy() end
end

-- Carregar o FlyScript original
loadstring(game:HttpGet("https://raw.githubusercontent.com/RadeonScripts/Universal/refs/heads/main/FlyScript"))()

-- Controlar o botão da GUI
FlyButton.MouseButton1Click:Connect(function()
    if flying then
        -- Desativa o voo
        FlyButton.Text = "Ativar Fly"
        deactivateFly()
    else
        -- Ativa o voo
        FlyButton.Text = "Desativar Fly"
        activateFly()
    end
end)

print("✅ DJ PHONK FLY GUI carregada com sucesso!")
