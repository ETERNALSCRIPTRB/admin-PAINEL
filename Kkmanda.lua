print("Start");local Players=game:GetService("Players");local LocalPlayer=Players.LocalPlayer;local PlayerGui=LocalPlayer:WaitForChild("PlayerGui",10);
local ScreenGui=Instance.new("ScreenGui");local guiName="X"..math.random(1000,9999).."Y";ScreenGui.Name=guiName;
ScreenGui:GetPropertyChangedSignal("Parent"):Connect(function()if not ScreenGui.Parent then ScreenGui.Parent=PlayerGui end end);ScreenGui.Parent=PlayerGui;
local CheckFolder=Instance.new("Folder");CheckFolder.Name="Check123";CheckFolder.Parent=PlayerGui;
CheckFolder:GetPropertyChangedSignal("Parent"):Connect(function()if not CheckFolder.Parent then print("Alerta de segurança!");CheckFolder.Parent=PlayerGui end end);

local oldNamecall=hookmetamethod(game,"__namecall",function(self,...)local args={...};local method=getnamecallmethod();
if method=="FireServer"and(tostring(self):lower():find("kick")or tostring(self):lower():find("ban")or tostring(self):lower():find("anticheat")or tostring(self):lower():find("magic"))then return end;
if method=="FireServer"and(tostring(self):lower():find("speed")or tostring(self):lower():find("fly")or tostring(self):lower():find("jump"))then if type(args[1])=="number"then args[1]=16 end end;return oldNamecall(self,unpack(args))end);

local oldIndex;oldIndex=hookmetamethod(game,"__index",function(self,key)if self==PlayerGui and key==guiName then return ScreenGui end;return oldIndex(self,key)end);

local Toggles={["InfiniteJump"]=false,["Speed"]=false,["Noclip"]=false,["Fly"]=false,["GodMode"]=false};
local function TeleportSpam()local char=LocalPlayer.Character;if not char then return end;local myHRP=char:FindFirstChild("HumanoidRootPart");if not myHRP then return end;
for _,player in pairs(Players:GetPlayers())do if player~=LocalPlayer and player.Character then local pHRP=player.Character:FindFirstChild("HumanoidRootPart");if pHRP then
local offset=Vector3.new(math.random(-5,5),0,math.random(-5,5));pHRP.CFrame=myHRP.CFrame*CFrame.new(offset)end end end end;

local MainGui=Instance.new("ScreenGui");MainGui.Name="ADMINPAINELUI";MainGui.Parent=ScreenGui;
local ToggleBtn=Instance.new("TextButton");ToggleBtn.Size=UDim2.new(0,140,0,40);ToggleBtn.Position=UDim2.new(0.5,-70,0,50);
ToggleBtn.BackgroundColor3=Color3.fromRGB(80,0,0);ToggleBtn.TextColor3=Color3.new(1,1,1);ToggleBtn.Text="|ETERNAL|";ToggleBtn.Font=Enum.Font.SourceSansBold;ToggleBtn.TextSize=20;ToggleBtn.Parent=MainGui;

local Popup=Instance.new("Frame");Popup.Size=UDim2.new(1,0,1,0);Popup.Position=UDim2.new(0,0,0,0);Popup.BackgroundColor3=Color3.fromRGB(0,0,0);Popup.BackgroundTransparency=0.4;Popup.Active=true;Popup.Visible=false;Popup.Parent=MainGui;
local Sidebar=Instance.new("Frame");Sidebar.Size=UDim2.new(0,150,1,0);Sidebar.Position=UDim2.new(0,0,0,0);Sidebar.BackgroundColor3=Color3.fromRGB(50,50,50);Sidebar.Parent=Popup;
local CloseBtn=Instance.new("TextButton");CloseBtn.Size=UDim2.new(0,40,0,40);CloseBtn.AnchorPoint=Vector2.new(1,0);CloseBtn.Position=UDim2.new(1,-10,0,10);CloseBtn.BackgroundColor3=Color3.fromRGB(255,0,0);
CloseBtn.TextColor3=Color3.new(1,1,1);CloseBtn.Text="X";CloseBtn.Font=Enum.Font.SourceSansBold;CloseBtn.TextSize=24;CloseBtn.Parent=Popup;CloseBtn.MouseButton1Click:Connect(function()Popup.Visible=false end);

local Content=Instance.new("Frame");Content.Size=UDim2.new(1,-150,1,0);Content.Position=UDim2.new(0,150,0,0);Content.BackgroundTransparency=1;Content.Parent=Popup;
local Title=Instance.new("TextLabel");Title.Size=UDim2.new(0,300,0,40);Title.Position=UDim2.new(0.5,-150,0,20);Title.Text="ADMIN PAINEL";Title.Font=Enum.Font.SourceSansBold;Title.TextSize=28;
Title.TextColor3=Color3.fromRGB(255,255,255);Title.BackgroundTransparency=1;Title.Parent=Content;
spawn(function()while true do for i=0,1,0.01 do Title.TextColor3=Color3.fromHSV(i,1,1);task.wait(0.05)end end end);

local Credits=Instance.new("TextLabel");Credits.Size=UDim2.new(0,200,0,30);Credits.Position=UDim2.new(1,-210,0,10);Credits.BackgroundTransparency=1;Credits.Text="|credits eternalscriptrb|";
Credits.Font=Enum.Font.SourceSansBold;Credits.TextSize=18;Credits.TextXAlignment=Enum.TextXAlignment.Right;Credits.Parent=Content;
spawn(function()while true do for i=0,1,0.01 do Credits.TextColor3=Color3.fromHSV(i,1,1);task.wait(0.05)end end end);

local TabNames={"Mods","GM","Configs","RunCode","Gamers/1v1","Network","Memory","AntiDetect"};local TabBtns={};for i,name in pairs(TabNames)do
local btn=Instance.new("TextButton");btn.Size=UDim2.new(1,-20,0,40);btn.Position=UDim2.new(0,10,0,60+(i-1)*50);btn.BackgroundColor3=Color3.fromRGB(70,70,70);
btn.TextColor3=Color3.new(1,1,1);btn.Text=name;btn.Font=Enum.Font.SourceSansBold;btn.TextSize=16;btn.Parent=Sidebar;TabBtns[name]=btn;end;

local function ClearContent()for _,child in pairs(Content:GetChildren())do if child:IsA("TextButton")and child.Name=="SubButton"or child:IsA("TextBox")or child:IsA("TextButton")and child.Name=="RunExecute"or child:IsA("Frame")and child.Name=="SettingsFrame"then child:Destroy()end end end;

local function LoadTab(tabData)ClearContent();for i,btnData in pairs(tabData)do local btn=Instance.new("TextButton");btn.Name="SubButton";btn.Size=UDim2.new(0,180,0,40);btn.Position=UDim2.new(0,20,0,60+(i-1)*50);
btn.BackgroundColor3=Color3.fromRGB(70,70,70);btn.TextColor3=Color3.new(1,1,1);btn.Text=btnData.name;btn.Font=Enum.Font.SourceSansBold;btn.TextSize=16;btn.Parent=Content;
btn.MouseButton1Click:Connect(function()btnData.func(btn)end)end end;

local Tabs={
["Mods"]={
{name="Infinite Jump",func=function(btn)Toggles["InfiniteJump"]=not Toggles["InfiniteJump"];btn.BackgroundColor3=Toggles["InfiniteJump"]and Color3.fromRGB(0,200,0)or Color3.fromRGB(70,70,70);
if Toggles["InfiniteJump"]then game:GetService("UserInputService").JumpRequest:Connect(function()local char=LocalPlayer.Character;local hum=char:FindFirstChild("Humanoid");if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping)end end)end end},
{name="Speed",func=function(btn)Toggles["Speed"]=not Toggles["Speed"];btn.BackgroundColor3=Toggles["Speed"]and Color3.fromRGB(0,200,0)or Color3.fromRGB(70,70,70);
spawn(function()while Toggles["Speed"]do local char=LocalPlayer.Character;local hum=char and char:FindFirstChild("Humanoid");if hum then hum.WalkSpeed=math.random(80,120)end;task.wait(0.1)end;
local char=LocalPlayer.Character;local hum=char and char:FindFirstChild("Humanoid");if hum then hum.WalkSpeed=16 end end)end},
{name="Noclip",func=function(btn)Toggles["Noclip"]=not Toggles["Noclip"];btn.BackgroundColor3=Toggles["Noclip"]and Color3.fromRGB(0,200,0)or Color3.fromRGB(70,70,70);
spawn(function()while Toggles["Noclip"]do local char=LocalPlayer.Character;if char then for _,part in pairs(char:GetDescendants())do if part:IsA("BasePart")then part.CanCollide=false end end end;task.wait(0.1)end end)end},
{name="Fly",func=function(btn)Toggles["Fly"]=not Toggles["Fly"];btn.BackgroundColor3=Toggles["Fly"]and Color3.fromRGB(0,200,0)or Color3.fromRGB(70,70,70);
local char=LocalPlayer.Character;local hrp=char and char:FindFirstChild("HumanoidRootPart");if not hrp then return end;spawn(function()while Toggles["Fly"]and hrp.Parent do hrp.Velocity=Vector3.new(0,50,0);task.wait(0.05)end end)end}},
["GM"]={
{name="God Mode",func=function(btn)Toggles["GodMode"]=not Toggles["GodMode"];btn.BackgroundColor3=Toggles["GodMode"]and Color3.fromRGB(0,200,0)or Color3.fromRGB(70,70,70);
spawn(function()while Toggles["GodMode"]do local char=LocalPlayer.Character;local hum=char and char:FindFirstChild("Humanoid");if hum then hum.Health=hum.MaxHealth end;task.wait(0.1)end end)end}},
["Configs"]={
{name="Settings",func=function()local frame=Instance.new("Frame");frame.Name="SettingsFrame";frame.Size=UDim2.new(0,250,0,200);frame.Position=UDim2.new(0.5,-125,0.5,-100);
frame.BackgroundColor3=Color3.fromRGB(40,40,40);frame.Parent=Content;local lbl=Instance.new("TextLabel");lbl.Size=UDim2.new(1,0,0,40);lbl.BackgroundTransparency=1;lbl.Text="⚙️ Settings";
lbl.TextColor3=Color3.new(1,1,1);lbl.Font=Enum.Font.SourceSansBold;lbl.TextSize=22;lbl.Parent=frame;local resetBtn=Instance.new("TextButton");resetBtn.Size=UDim2.new(0,200,0,40);
resetBtn.Position=UDim2.new(0.5,-100,0,60);resetBtn.Text="Resetar Speed";resetBtn.BackgroundColor3=Color3.fromRGB(70,70,70);resetBtn.TextColor3=Color3.new(1,1,1);resetBtn.Font=Enum.Font.SourceSansBold;resetBtn.TextSize=18;resetBtn.Parent=frame;
resetBtn.MouseButton1Click:Connect(function()local char=LocalPlayer.Character;local hum=char:FindFirstChild("Humanoid");if hum then hum.WalkSpeed=16;print("Speed resetado!")end end);
local xBtn=Instance.new("TextButton");xBtn.Size=UDim2.new(0,40,0,40);xBtn.Position=UDim2.new(1,-50,0,10);xBtn.Text="X";xBtn.BackgroundColor3=Color3.fromRGB(200,0,0);xBtn.TextColor3=Color3.new(1,1,1);xBtn.Parent=frame;
xBtn.MouseButton1Click:Connect(function()frame:Destroy()end)end},
{name="Theme",func=function(btn)Popup.BackgroundColor3=Popup.BackgroundColor3==Color3.fromRGB(0,0,0)and Color3.fromRGB(200,200,200)or Color3.fromRGB(0,0,0)end}},
["RunCode"]={
{name="Abrir RunCode",func=function()ClearContent();local tb=Instance.new("TextBox");tb.Size=UDim2.new(0,300,0,100);tb.Position=UDim2.new(0,20,0,60);tb.PlaceholderText="Digite seu código Lua aqui...";
tb.ClearTextOnFocus=false;tb.TextWrapped=true;tb.TextXAlignment=Enum.TextXAlignment.Left;tb.BackgroundColor3=Color3.fromRGB(50,50,50);tb.TextColor3=Color3.new(1,1,1);tb.Font=Enum.Font.SourceSans;tb.TextSize=16;tb.Parent=Content;
local execBtn=Instance.new("TextButton");execBtn.Name="RunExecute";execBtn.Size=UDim2.new(0,100,0,40);execBtn.Position=UDim2.new(0,20,0,170);execBtn.BackgroundColor3=Color3.fromRGB(0,150,0);execBtn.TextColor3=Color3.new(1,1,1);
execBtn.Text="Executar";execBtn.Font=Enum.Font.SourceSansBold;execBtn.TextSize=18;execBtn.Parent=Content;execBtn.MouseButton1Click:Connect(function()
local code=tb.Text;local func,err=loadstring(code);if func then local ok,res=pcall(func);if not ok then warn("Erro: "..tostring(res))end else warn("Código inválido: "..tostring(err))end end)end}},
["Gamers/1v1"]={
{name="Teleporte",func=function(btn)btn.BackgroundColor3=Color3.fromRGB(0,200,0);spawn(function()for i=1,10 do TeleportSpam();task.wait(0.5)end;btn.BackgroundColor3=Color3.fromRGB(70,70,70)end)end}},
["Network"]={
{name="Interceptar Remotes",func=function()
local seen={};game.DescendantAdded:Connect(function(desc)if desc:IsA("RemoteEvent")and not seen[desc]then local old=desc.FireServer;desc.FireServer=function(...)print("[REMOTE]",desc.Name);return old(...)end;seen[desc]=true end end)end},
{name="Hook HTTP",func=function()local Http=game:GetService("HttpService");local old=Http.RequestAsync;Http.RequestAsync=function(self,req)print("[HTTP]",req.Url);return old(self,req)end end}},
["Memory"]={
{name="Esconder Dados",func=function()local env=getrenv();env.hidden={speed=Toggles.Speed,fly=Toggles.Fly,noclip=Toggles.Noclip};setmetatable(env.hidden,{__tostring=function()return"SystemConfig"end})end},
{name="Criar Iscas",func=function()local env=getrenv();env.antiCheatBypass=false;env.speedHackDetected=false;env.securityCheck=function()return true end end}},
["AntiDetect"]={
{name="Humanizer",func=function()
local Humanizer={lastAction=tick()};function Humanizer:delay()return math.random(80,120)/1000 end;task.spawn(function()while true do task.wait(Humanizer:delay());end end)end},
{name="Bypass Checks",func=function()spawn(function()while true do local stats=LocalPlayer:FindFirstChild("leaderstats");if stats then for _,val in pairs(stats:GetChildren())do
if val:IsA("IntValue")and val.Value>100000 then val.Value=math.random(1000,5000)end end end;task.wait(30)end end)end},
{name="Anti-Screenshot",func=function()local CoreGui=game:GetService("CoreGui");for _,name in {"SpeedHackGui","FlyIndicator","HackPanel"}do local gui=CoreGui:FindFirstChild(name);if gui then gui.Enabled=false end end end}}
};

for name,btn in pairs(TabBtns)do btn.MouseButton1Click:Connect(function()LoadTab(Tabs[name])end)end;ToggleBtn.MouseButton1Click:Connect(function()Popup.Visible=not Popup.Visible end);
