-- Script Modificado

local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local uis = game:GetService("UserInputService")
local screenGui = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local onof = Instance.new("TextButton")
local plus = Instance.new("TextButton")
local mine = Instance.new("TextButton")
local closebutton = Instance.new("TextButton")
local mini = Instance.new("TextButton")
local mini2 = Instance.new("TextButton")

screenGui.Parent = game.CoreGui
screenGui.Name = "DJ Phonk GUI"  -- Mudando o nome do ScreenGui

main.Parent = screenGui
main.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
main.Position = UDim2.new(0.5, -200, 0.5, -150)
main.Size = UDim2.new(0, 400, 0, 300)

TextLabel.Parent = main
TextLabel.Size = UDim2.new(0, 400, 0, 50)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.Text = "DJ Phonk"  -- Alterando o texto
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 30
TextLabel.BackgroundTransparency = 1

up.Parent = main
up.Size = UDim2.new(0, 100, 0, 50)
up.Position = UDim2.new(0, 10, 0, 70)
up.Text = "Up"
up.BackgroundColor3 = Color3.fromRGB(139, 0, 0)  -- Alterando a cor do botão
up.TextColor3 = Color3.fromRGB(255, 255, 255)

down.Parent = main
down.Size = UDim2.new(0, 100, 0, 50)
down.Position = UDim2.new(0, 10, 0, 130)
down.Text = "Down"
down.BackgroundColor3 = Color3.fromRGB(139, 0, 0)  -- Alterando a cor do botão
down.TextColor3 = Color3.fromRGB(255, 255, 255)

onof.Parent = main
onof.Size = UDim2.new(0, 100, 0, 50)
onof.Position = UDim2.new(0, 10, 0, 190)
onof.Text = "On/Off"
onof.BackgroundColor3 = Color3.fromRGB(139, 0, 0)  -- Alterando a cor do botão
onof.TextColor3 = Color3.fromRGB(255, 255, 255)

plus.Parent = main
plus.Size = UDim2.new(0, 100, 0, 50)
plus.Position = UDim2.new(0, 120, 0, 70)
plus.Text = "+"
plus.BackgroundColor3 = Color3.fromRGB(139, 0, 0)  -- Alterando a cor do botão
plus.TextColor3 = Color3.fromRGB(255, 255, 255)

mine.Parent = main
mine.Size = UDim2.new(0, 100, 0, 50)
mine.Position = UDim2.new(0, 120, 0, 130)
mine.Text = "-"
mine.BackgroundColor3 = Color3.fromRGB(139, 0, 0)  -- Alterando a cor do botão
mine.TextColor3 = Color3.fromRGB(255, 255, 255)

closebutton.Parent = main
closebutton.Size = UDim2.new(0, 100, 0, 50)
closebutton.Position = UDim2.new(0, 230, 0, 70)
closebutton.Text = "Close"
closebutton.BackgroundColor3 = Color3.fromRGB(139, 0, 0)  -- Alterando a cor do botão
closebutton.TextColor3 = Color3.fromRGB(255, 255, 255)

mini.Parent = main
mini.Size = UDim2.new(0, 100, 0, 50)
mini.Position = UDim2.new(0, 230, 0, 130)
mini.Text = "Minimize"
mini.BackgroundColor3 = Color3.fromRGB(139, 0, 0)  -- Alterando a cor do botão
mini.TextColor3 = Color3.fromRGB(255, 255, 255)

mini2.Parent = main
mini2.Size = UDim2.new(0, 100, 0, 50)
mini2.Position = UDim2.new(0, 230, 0, 190)
mini2.Text = "Minimize 2"
mini2.BackgroundColor3 = Color3.fromRGB(139, 0, 0)  -- Alterando a cor do botão
mini2.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Funcionalidade dos botões (não alterada)
up.MouseButton1Click:Connect(function()
    print("Up clicked")
end)

down.MouseButton1Click:Connect(function()
    print("Down clicked")
end)

onof.MouseButton1Click:Connect(function()
    print("On/Off clicked")
end)

plus.MouseButton1Click:Connect(function()
    print("Plus clicked")
end)

mine.MouseButton1Click:Connect(function()
    print("Mine clicked")
end)

closebutton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

mini.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

mini2.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)
