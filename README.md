-- Tabela de cheats
local cheats = {
InfiniteJump = false,
Speed = false,
Noclip = false,
Fly = false,
GodMode = false
}

local gui = Instance.new("ScreenGui")
gui.Name = "AdminPainelUI"
gui.Parent = player.PlayerGui

local mainBtn = Instance.new("TextButton")
mainBtn.Size = UDim2.new(0, 140, 0, 40)
mainBtn.Position = UDim2.new(0.5, -70, 0, 50)
mainBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
mainBtn.TextColor3 = Color3.new(1, 1, 1)
mainBtn.Text = "|ETERNAL|"
mainBtn.Font = Enum.Font.Arcade
mainBtn.TextSize = 20
mainBtn.Parent = gui

local panelTitle = Instance.new("TextLabel")
panelTitle.Size = UDim2.new(0, 200, 0, 30)
panelTitle.Position = UDim2.new(0.5, -100, 0, 100)
panelTitle.Text = "ADMIN PAINEL"
panelTitle.Font = Enum.Font.Arcade
panelTitle.TextSize = 24
panelTitle.BackgroundTransparency = 1
panelTitle.Parent = gui

spawn(function()
while true do
for hue = 0, 1, 0.01 do
panelTitle.TextColor3 = Color3.fromHSV(hue, 1, 1)
wait(0.05)
end
end
end)

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0.8, 0, 0.7, 0)
panel.Position = UDim2.new(0.1, 0, 0.2, 0)
panel.BackgroundColor3 = Color3.fromRGB(0,0,0)
panel.BackgroundTransparency = 0.4
panel.Visible = false
panel.Active = true
panel.Draggable = true
panel.Parent = gui

-- Créditos arco-íris
local credits = Instance.new("TextLabel")
credits.Size = UDim2.new(0, 200, 0, 30)
credits.Position = UDim2.new(1, -210, 0, 10)
credits.BackgroundTransparency = 1
credits.Text = "|credits eternalscriptrb|"
credits.Font = Enum.Font.Arcade
credits.TextSize = 18
credits.TextXAlignment = Enum.TextXAlignment.Right
credits.Parent = panel

-- Loop arco-íris para créditos
spawn(function()
while true do
for hue = 0, 1, 0.01 do
credits.TextColor3 = Color3.fromHSV(hue, 1, 1)
wait(0.05)
end
end
end)

-- Botão fechar X
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0, 20)
closeBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.ArialBold
closeBtn.TextSize = 24
closeBtn.Parent = panel
closeBtn.MouseButton1Click:Connect(function()
panel.Visible = false
end)

-- Painel lateral de categorias
local categories = {"Mods","Data","GM","Configs","RunCode"}
local categoryButtons = {}
for i, name in ipairs(categories) do
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 100, 0, 40)
btn.Position = UDim2.new(0, 10, 0, 60 + (i-1)*50)
btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
btn.TextColor3 = Color3.new(1,1,1)
btn.Text = name
btn.Font = Enum.Font.Arcade
btn.TextSize = 16
btn.Parent = panel
categoryButtons[name] = btn
end

-- Função para criar sub-botões
local function createSubButtons(buttons)
for _, child in pairs(panel:GetChildren()) do
if child:IsA("TextButton") and child.Name == "SubButton" then
child:Destroy()
elseif child:IsA("TextBox") or (child:IsA("TextButton") and child.Name=="RunExecute") then
child:Destroy()
end
end
for i, data in ipairs(buttons) do
local btn = Instance.new("TextButton")
btn.Name = "SubButton"
btn.Size = UDim2.new(0, 180, 0, 40)
btn.Position = UDim2.new(0, 120, 0, 60 + (i-1)*50)
btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
btn.TextColor3 = Color3.new(1,1,1)
btn.Text = data.name
btn.Font = Enum.Font.Arcade
btn.TextSize = 16
btn.Parent = panel
btn.MouseButton1Click:Connect(function()
data.func(btn)
end)
end
end

-- Função RunCode
local function showRunCode()
for _, child in pairs(panel:GetChildren()) do
if child:IsA("TextButton") and child.Name == "SubButton" then
child:Destroy()
elseif child:IsA("TextBox") or (child:IsA("TextButton") and child.Name=="RunExecute") then
child:Destroy()
end
end
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0, 300, 0, 100)
inputBox.Position = UDim2.new(0, 120, 0, 60)
inputBox.PlaceholderText = "Digite seu código Lua aqui..."
inputBox.ClearTextOnFocus = false
inputBox.TextWrapped = true
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
inputBox.TextColor3 = Color3.new(1,1,1)
inputBox.Font = Enum.Font.Arial
inputBox.TextSize = 16
inputBox.Parent = panel

local execBtn = Instance.new("TextButton")  
execBtn.Name = "RunExecute"  
execBtn.Size = UDim2.new(0, 100, 0, 40)  
execBtn.Position = UDim2.new(0, 120, 0, 170)  
execBtn.BackgroundColor3 = Color3.fromRGB(0,150,0)  
execBtn.TextColor3 = Color3.new(1,1,1)  
execBtn.Text = "Executar"  
execBtn.Font = Enum.Font.ArialBold  
execBtn.TextSize = 18  
execBtn.Parent = panel  

execBtn.MouseButton1Click:Connect(function()  
    local code = inputBox.Text  
    local func, err = loadstring(code)  
    if func then  
        local success, result = pcall(func)  
        if not success then  
            warn("Erro ao executar: "..tostring(result))  
        end  
    else  
        warn("Código inválido: "..tostring(err))  
    end  
end)

end

-- Sub-botões
local subButtons = {
Mods = {
{name="Infinite Jump", func=function(btn)
cheats.InfiniteJump = not cheats.InfiniteJump
btn.BackgroundColor3 = cheats.InfiniteJump and Color3.fromRGB(0,200,0) or Color3.fromRGB(70,70,70)
local uis = game:GetService("UserInputService")
local function enableJump(character)
local humanoid = character:FindFirstChild("Humanoid")
if humanoid then
uis.JumpRequest:Connect(function()
if cheats.InfiniteJump then
humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end
end)
end
end
enableJump(player.Character)
player.CharacterAdded:Connect(enableJump)
end},
{name="Speed", func=function(btn)
cheats.Speed = not cheats.Speed
btn.BackgroundColor3 = cheats.Speed and Color3.fromRGB(0,200,0) or Color3.fromRGB(70,70,70)
local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
if humanoid then
spawn(function()
while cheats.Speed and humanoid.Parent do
humanoid.WalkSpeed = 100
wait(0.2)
end
humanoid.WalkSpeed = 16
end)
end
end},
{name="Noclip", func=function(btn)
cheats.Noclip = not cheats.Noclip
btn.BackgroundColor3 = cheats.Noclip and Color3.fromRGB(0,200,0) or Color3.fromRGB(70,70,70)
spawn(function()
while cheats.Noclip do
local character = player.Character
if character then
for _, part in pairs(character:GetDescendants()) do
if part:IsA("BasePart") then
part.CanCollide = false
end
end
end
wait(0.1)
end
end)
end},
{name="Fly", func=function(btn)
cheats.Fly = not cheats.Fly
btn.BackgroundColor3 = cheats.Fly and Color3.fromRGB(0,200,0) or Color3.fromRGB(70,70,70)
local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
if not root then return end
spawn(function()
while cheats.Fly and root.Parent do
root.Velocity = Vector3.new(0,50,0)
wait(0.05)
end
end)
end}
},
GM = {
{name="God Mode", func=function(btn)
cheats.GodMode = not cheats.GodMode
btn.BackgroundColor3 = cheats.GodMode and Color3.fromRGB(0,200,0) or Color3.fromRGB(70,70,70)
local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
if humanoid then
spawn(function()
while cheats.GodMode and humanoid.Parent do
humanoid.Health = humanoid.MaxHealth
wait(0.1)
end
end)
end
end}
},
Configs = {
{name="Settings", func=function(btn)
local settingsFrame = Instance.new("Frame")
settingsFrame.Size = UDim2.new(0, 250, 0, 200)
settingsFrame.Position = UDim2.new(0.5, -125, 0.5, -100)
settingsFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
settingsFrame.Parent = panel
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "⚙️ Settings"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.Arcade
title.TextSize = 22
title.Parent = settingsFrame
local resetSpeedBtn = Instance.new("TextButton")
resetSpeedBtn.Size = UDim2.new(0, 200, 0, 40)
resetSpeedBtn.Position = UDim2.new(0.5, -100, 0, 60)
resetSpeedBtn.Text = "Resetar Speed"
resetSpeedBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
resetSpeedBtn.TextColor3 = Color3.new(1,1,1)
resetSpeedBtn.Font = Enum.Font.Arcade
resetSpeedBtn.TextSize = 18
resetSpeedBtn.Parent = settingsFrame
resetSpeedBtn.MouseButton1Click:Connect(function()
local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
if humanoid then
humanoid.WalkSpeed = 16
print("Speed resetado!")
end
end)
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 40, 0, 40)
close.Position = UDim2.new(1, -50, 0, 10)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200,0,0)
close.TextColor3 = Color3.new(1,1,1)
close.Parent = settingsFrame
close.MouseButton1Click:Connect(function()
settingsFrame:Destroy()
end)
end},
{name="Theme", func=function(btn)
if panel.BackgroundColor3 == Color3.fromRGB(0,0,0) then
panel.BackgroundColor3 = Color3.fromRGB(200,200,200)
else
panel.BackgroundColor3 = Color3.fromRGB(0,0,0)
end
end}
},
RunCode = {
{name="Abrir RunCode", func=showRunCode}
}
}

for name, btn in pairs(categoryButtons) do
btn.MouseButton1Click:Connect(function()
createSubButtons(subButtons[name])
end)
end

mainBtn.MouseButton1Click:Connect(function()
panel.Visible = true
end)
feito para Roblox
