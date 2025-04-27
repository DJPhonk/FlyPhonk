-- GUI Melhorada e Fly Otimizado (DJ Phonk Style)

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

Frame.Size = UDim2.new(0, 220, 0, 200)
Frame.Position = UDim2.new(0, 20, 0, 20)
Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

Title.Size = UDim2.new(0, 200, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Text = "🚀 DJ PHONK FLY 🚀"
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
SpeedLabel.Text = "Velocidade: 100"
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

-- Fly System
local flying = false
local speed = 100

local function fly()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    rs.RenderStepped:Connect(function()
        if flying then
            hrp.Velocity = Vector3.new(0,0,0)
            if uis:IsKeyDown(Enum.KeyCode.W) then
                hrp.CFrame = hrp.CFrame + (workspace.CurrentCamera.CFrame.LookVector * (speed / 100))
            end
            if uis:IsKeyDown(Enum.KeyCode.S) then
                hrp.CFrame = hrp.CFrame - (workspace.CurrentCamera.CFrame.LookVector * (speed / 100))
            end
            if uis:IsKeyDown(Enum.KeyCode.A) then
                hrp.CFrame = hrp.CFrame * CFrame.new(-(speed / 100), 0, 0)
            end
            if uis:IsKeyDown(Enum.KeyCode.D) then
                hrp.CFrame = hrp.CFrame * CFrame.new((speed / 100), 0, 0)
            end
            if uis:IsKeyDown(Enum.KeyCode.Space) then
                hrp.CFrame = hrp.CFrame * CFrame.new(0, (speed / 100), 0)
            end
            if uis:IsKeyDown(Enum.KeyCode.LeftControl) then
                hrp.CFrame = hrp.CFrame * CFrame.new(0, -(speed / 100), 0)
            end
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

print("✅ DJ PHONK FLY GUI Seguro e Funcionando!")
