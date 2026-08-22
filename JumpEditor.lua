local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local RunService=game:GetService("RunService")
local Lighting=game:GetService("Lighting")

local Player=Players.LocalPlayer
local PlayerGui=Player:WaitForChild("PlayerGui")

local OUTSIDE_IMAGE="rbxthumb://type=Asset&id=103326817624079&w=420&h=420"
local MENU_IMAGE="rbxthumb://type=Asset&id=83617168855641&w=420&h=420"

local Old=PlayerGui:FindFirstChild("MyMenu")
if Old then Old:Destroy() end

local Gui=Instance.new("ScreenGui")
Gui.Name="MyMenu"
Gui.ResetOnSpawn=false
Gui.IgnoreGuiInset=true
Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
Gui.DisplayOrder=100
Gui.Parent=PlayerGui

local function Corner(o,r)
	local c=Instance.new("UICorner")
	c.CornerRadius=UDim.new(0,r)
	c.Parent=o
end

local function Stroke(o,color,thickness,transparency)
	local s=Instance.new("UIStroke")
	s.Color=color
	s.Thickness=thickness
	s.Transparency=transparency or 0
	s.Parent=o
end

local function Button(parent,text,x,y,w,h)
	local b=Instance.new("TextButton")
	b.Size=UDim2.fromOffset(w,h)
	b.Position=UDim2.fromOffset(x,y)
	b.Text=text
	b.TextSize=14
	b.Font=Enum.Font.GothamBold
	b.TextColor3=Color3.new(1,1,1)
	b.BackgroundColor3=Color3.fromRGB(42,42,54)
	b.BorderSizePixel=0
	b.AutoButtonColor=false
	b.Active=true
	b.ZIndex=50
	b.Parent=parent
	Corner(b,10)
	return b
end

local Open=Instance.new("ImageButton")
Open.Name="OpenButton"
Open.Size=UDim2.fromOffset(60,60)
Open.Position=UDim2.new(.5,-30,.5,-30)
Open.Image=OUTSIDE_IMAGE
Open.BackgroundColor3=Color3.fromRGB(30,30,40)
Open.BorderSizePixel=0
Open.AutoButtonColor=false
Open.Active=true
Open.ZIndex=500
Open.Parent=Gui
Corner(Open,30)
Stroke(Open,Color3.fromRGB(150,90,220),2,.15)

local Menu=Instance.new("Frame")
Menu.Name="MainMenu"
Menu.Size=UDim2.fromOffset(500,370)
Menu.Position=UDim2.new(.5,-250,.5,-185)
Menu.BackgroundColor3=Color3.fromRGB(20,20,28)
Menu.BorderSizePixel=0
Menu.Visible=false
Menu.Active=true
Menu.ZIndex=10
Menu.Parent=Gui
Corner(Menu,18)
Stroke(Menu,Color3.fromRGB(120,70,170),1,.25)

local Background=Instance.new("ImageLabel")
Background.Size=UDim2.fromScale(1,1)
Background.BackgroundTransparency=1
Background.Image=MENU_IMAGE
Background.ImageTransparency=.5
Background.ScaleType=Enum.ScaleType.Crop
Background.ZIndex=11
Background.Parent=Menu
Corner(Background,18)

local Overlay=Instance.new("Frame")
Overlay.Size=UDim2.fromScale(1,1)
Overlay.BackgroundColor3=Color3.new(0,0,0)
Overlay.BackgroundTransparency=.52
Overlay.BorderSizePixel=0
Overlay.ZIndex=12
Overlay.Parent=Menu
Corner(Overlay,18)

local Drag=Instance.new("TextButton")
Drag.Size=UDim2.new(1,-125,0,42)
Drag.Position=UDim2.fromOffset(125,0)
Drag.BackgroundTransparency=1
Drag.Text=""
Drag.Active=true
Drag.ZIndex=100
Drag.Parent=Menu

local Title=Instance.new("TextLabel")
Title.Size=UDim2.new(1,-145,0,42)
Title.Position=UDim2.fromOffset(140,0)
Title.BackgroundTransparency=1
Title.Text="My Menu"
Title.TextSize=16
Title.Font=Enum.Font.GothamBold
Title.TextColor3=Color3.new(1,1,1)
Title.TextXAlignment=Enum.TextXAlignment.Left
Title.ZIndex=101
Title.Parent=Menu

local Side=Instance.new("Frame")
Side.Size=UDim2.fromOffset(125,370)
Side.BackgroundColor3=Color3.fromRGB(10,10,15)
Side.BackgroundTransparency=.1
Side.BorderSizePixel=0
Side.ZIndex=20
Side.Parent=Menu
Corner(Side,18)

local Content=Instance.new("Frame")
Content.Size=UDim2.new(1,-135,1,-50)
Content.Position=UDim2.fromOffset(130,45)
Content.BackgroundTransparency=1
Content.ZIndex=20
Content.Parent=Menu

local JumpTab=Button(Side,"Jump",8,25,109,42)
local TargetTab=Button(Side,"Target",8,75,109,42)
local VisualTab=Button(Side,"Visual",8,125,109,42)

local JumpPage=Instance.new("Frame")
JumpPage.Size=UDim2.fromScale(1,1)
JumpPage.BackgroundTransparency=1
JumpPage.Parent=Content

local TargetPage=Instance.new("Frame")
TargetPage.Size=UDim2.fromScale(1,1)
TargetPage.BackgroundTransparency=1
TargetPage.Visible=false
TargetPage.Parent=Content

local VisualPage=Instance.new("ScrollingFrame")
VisualPage.Size=UDim2.fromScale(1,1)
VisualPage.BackgroundTransparency=1
VisualPage.BorderSizePixel=0
VisualPage.ScrollBarThickness=3
VisualPage.CanvasSize=UDim2.fromOffset(0,540)
VisualPage.Visible=false
VisualPage.Parent=Content

local Up=Button(JumpPage,"↑",120,45,65,42)
local Left=Button(JumpPage,"←",48,92,65,42)
local Reset=Button(JumpPage,"⟳",120,92,65,42)
local Right=Button(JumpPage,"→",192,92,65,42)
local Down=Button(JumpPage,"↓",120,139,65,42)
local Plus=Button(JumpPage,"+",192,45,65,42)
local Minus=Button(JumpPage,"−",48,139,65,42)

local OriginalPosition
local OriginalSize
local SavedPosition
local SavedSize

local function GetTouchGui()
	return PlayerGui:FindFirstChild("TouchGui")
end

local function GetJump()
	local TouchGui=GetTouchGui()
	if not TouchGui then return end

	local Control=TouchGui:FindFirstChild("TouchControlFrame")
	if not Control then return end

	return Control:FindFirstChild("JumpButton",true)
end

local function WaitJump()
	for i=1,20 do
		local j=GetJump()
		if j then return j end
		task.wait(.25)
	end
end

local function ChangeJumpImage()
	local j=WaitJump()
	if not j then return end

	task.wait(.2)

	pcall(function()
		if j:IsA("ImageButton") or j:IsA("ImageLabel") then
			j.Image=OUTSIDE_IMAGE
			j.ImageTransparency=0.8
			j.ScaleType=Enum.ScaleType.Fit
		end
	end)
end

local function SaveOriginal()
	local j=GetJump()
	if not j then return end

	if not OriginalPosition then
		OriginalPosition=j.Position
		OriginalSize=j.Size
		SavedPosition=j.Position
		SavedSize=j.Size
	end
end

local function MoveJump(x,y)
	local j=GetJump()
	if not j then return end
	SaveOriginal()

	local p=j.Position
	j.Position=UDim2.new(
		p.X.Scale,p.X.Offset+x,
		p.Y.Scale,p.Y.Offset+y
	)
	SavedPosition=j.Position
end

local function ResizeJump(amount)
	local j=GetJump()
	if not j then return end
	SaveOriginal()

	local s=j.Size
	local x=math.max(40,s.X.Offset+amount)
	local y=math.max(40,s.Y.Offset+amount)

	j.Size=UDim2.fromOffset(x,y)
	SavedSize=j.Size
end

Up.Activated:Connect(function() MoveJump(0,-15) end)
Down.Activated:Connect(function() MoveJump(0,15) end)
Left.Activated:Connect(function() MoveJump(-15,0) end)
Right.Activated:Connect(function() MoveJump(15,0) end)
Plus.Activated:Connect(function() ResizeJump(15) end)
Minus.Activated:Connect(function() ResizeJump(-15) end)

Reset.Activated:Connect(function()
	local j=GetJump()
	if not j then return end

	if OriginalPosition then
		j.Position=OriginalPosition
		SavedPosition=OriginalPosition
	end

	if OriginalSize then
		j.Size=OriginalSize
		SavedSize=OriginalSize
	end
end)

local EditButtonOn=false
local EditButton=Button(JumpPage,"Edit Button: OFF",48,190,209,40)

local DraggingButton
local DragStart
local ButtonStartPosition

local function IsGuiButton(o)
	return o:IsA("TextButton") or o:IsA("ImageButton")
end

EditButton.Activated:Connect(function()
	EditButtonOn=not EditButtonOn
	EditButton.Text=EditButtonOn and "Edit Button: ON" or "Edit Button: OFF"
	DraggingButton=nil
end)

UIS.InputBegan:Connect(function(input)
	if not EditButtonOn then return end

	if input.UserInputType~=Enum.UserInputType.Touch
		and input.UserInputType~=Enum.UserInputType.MouseButton1 then
		return
	end

	local pos=input.Position

	for _,obj in ipairs(PlayerGui:GetDescendants()) do
		if obj:IsDescendantOf(Gui) then
			continue
		end

		if IsGuiButton(obj) and obj.Visible then
			local p=obj.AbsolutePosition
			local s=obj.AbsoluteSize

			if pos.X>=p.X and pos.X<=p.X+s.X
				and pos.Y>=p.Y and pos.Y<=p.Y+s.Y then

				DraggingButton=obj
				DragStart=pos
				ButtonStartPosition=obj.Position
				break
			end
		end
	end
end)

UIS.InputChanged:Connect(function(input)
	if not EditButtonOn or not DraggingButton then return end

	if input.UserInputType~=Enum.UserInputType.Touch
		and input.UserInputType~=Enum.UserInputType.MouseMovement then
		return
	end

	if not DraggingButton.Parent then
		DraggingButton=nil
		return
	end

	local delta=input.Position-DragStart

	DraggingButton.Position=UDim2.new(
		ButtonStartPosition.X.Scale,
		ButtonStartPosition.X.Offset+delta.X,
		ButtonStartPosition.Y.Scale,
		ButtonStartPosition.Y.Offset+delta.Y
	)

	if DraggingButton==GetJump() then
		SavedPosition=DraggingButton.Position
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.Touch
		or input.UserInputType==Enum.UserInputType.MouseButton1 then
		DraggingButton=nil
	end
end)

local SelectedPlayer
local TargetOn=false
local ViewOn=false

local List=Instance.new("ScrollingFrame")
List.Size=UDim2.new(1,-20,0,130)
List.Position=UDim2.fromOffset(10,5)
List.BackgroundColor3=Color3.fromRGB(15,15,20)
List.BackgroundTransparency=.15
List.BorderSizePixel=0
List.ScrollBarThickness=4
List.Parent=TargetPage
Corner(List,10)

local ListLayout=Instance.new("UIListLayout")
ListLayout.Padding=UDim.new(0,4)
ListLayout.Parent=List

local SelectedLabel=Instance.new("TextLabel")
SelectedLabel.Size=UDim2.new(1,-20,0,30)
SelectedLabel.Position=UDim2.fromOffset(10,142)
SelectedLabel.BackgroundTransparency=1
SelectedLabel.Text="Target: None"
SelectedLabel.TextSize=14
SelectedLabel.Font=Enum.Font.GothamBold
SelectedLabel.TextColor3=Color3.new(1,1,1)
SelectedLabel.TextXAlignment=Enum.TextXAlignment.Left
SelectedLabel.Parent=TargetPage

local TargetButton=Button(TargetPage,"Target: OFF",10,178,135,42)
local ViewButton=Button(TargetPage,"View: OFF",155,178,135,42)
local RefreshButton=Button(TargetPage,"Refresh",10,228,135,42)

local function ResetCamera()
	local cam=workspace.CurrentCamera
	local char=Player.Character
	local hum=char and char:FindFirstChildOfClass("Humanoid")

	if hum then
		cam.CameraType=Enum.CameraType.Custom
		cam.CameraSubject=hum
	end
end

local function SetCamera(target)
	local char=target and target.Character
	local hum=char and char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	local cam=workspace.CurrentCamera
	cam.CameraType=Enum.CameraType.Custom
	cam.CameraSubject=hum
end

local function RefreshPlayers()
	for _,v in ipairs(List:GetChildren()) do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end

	for _,p in ipairs(Players:GetPlayers()) do
		if p~=Player then
			local b=Button(List,p.DisplayName.." @"..p.Name,0,0,100,32)
			b.Size=UDim2.new(1,-8,0,32)
			b.TextSize=12

			b.Activated:Connect(function()
				SelectedPlayer=p
				SelectedLabel.Text="Target: "..p.DisplayName
				if ViewOn then SetCamera(p) end
			end)
		end
	end

	task.wait()

	List.CanvasSize=UDim2.fromOffset(
		0,ListLayout.AbsoluteContentSize.Y+5
	)
end

RefreshButton.Activated:Connect(RefreshPlayers)

TargetButton.Activated:Connect(function()
	if not SelectedPlayer then return end

	TargetOn=not TargetOn
	TargetButton.Text=TargetOn and "Target: ON" or "Target: OFF"
end)

ViewButton.Activated:Connect(function()
	if not SelectedPlayer then return end

	ViewOn=not ViewOn
	ViewButton.Text=ViewOn and "View: ON" or "View: OFF"

	if ViewOn then
		SetCamera(SelectedPlayer)
	else
		ResetCamera()
	end
end)

Players.PlayerAdded:Connect(function()
	task.defer(RefreshPlayers)
end)

Players.PlayerRemoving:Connect(function(p)
	if p==SelectedPlayer then
		SelectedPlayer=nil
		TargetOn=false
		ViewOn=false
		TargetButton.Text="Target: OFF"
		ViewButton.Text="View: OFF"
		SelectedLabel.Text="Target: None"
		ResetCamera()
	end

	task.defer(RefreshPlayers)
end)local InfJumpOn=false
local FullBrightOn=false
local NoFogOn=false
local CircleESPOn=false
local NameESPOn=false
local DistanceESPOn=false
local RainbowOn=false

local InfJumpButton=Button(VisualPage,"Inf Jump: OFF",15,15,210,40)
local FullBrightButton=Button(VisualPage,"Loop FB: OFF",15,62,210,40)
local NoFogButton=Button(VisualPage,"No Fog: OFF",15,109,210,40)
local CircleButton=Button(VisualPage,"Circle: OFF",15,156,210,40)
local NameButton=Button(VisualPage,"Name: OFF",15,203,210,40)
local DistanceButton=Button(VisualPage,"Distance: OFF",15,250,210,40)
local RainbowButton=Button(VisualPage,"Rainbow: OFF",15,297,210,40)

local ColorLabel=Instance.new("TextLabel")
ColorLabel.Size=UDim2.fromOffset(160,26)
ColorLabel.Position=UDim2.fromOffset(245,15)
ColorLabel.BackgroundTransparency=1
ColorLabel.Text="Color"
ColorLabel.TextSize=14
ColorLabel.Font=Enum.Font.GothamBold
ColorLabel.TextColor3=Color3.new(1,1,1)
ColorLabel.Parent=VisualPage

local CurrentColor=Color3.fromRGB(170,80,255)

local Preview=Instance.new("Frame")
Preview.Size=UDim2.fromOffset(42,42)
Preview.Position=UDim2.fromOffset(245,42)
Preview.BackgroundColor3=CurrentColor
Preview.BorderSizePixel=0
Preview.Parent=VisualPage
Corner(Preview,21)

local Presets={
	{"R",Color3.fromRGB(255,60,60)},
	{"O",Color3.fromRGB(255,140,40)},
	{"Y",Color3.fromRGB(255,230,40)},
	{"G",Color3.fromRGB(60,255,100)},
	{"C",Color3.fromRGB(40,220,255)},
	{"B",Color3.fromRGB(60,100,255)},
	{"P",Color3.fromRGB(180,70,255)},
	{"W",Color3.fromRGB(255,255,255)}
}

for i,data in ipairs(Presets) do
	local x=245+((i-1)%4)*47
	local y=92+math.floor((i-1)/4)*47

	local b=Button(VisualPage,data[1],x,y,40,40)
	b.BackgroundColor3=data[2]

	b.Activated:Connect(function()
		CurrentColor=data[2]
		Preview.BackgroundColor3=CurrentColor
	end)
end

local ESP={}

local function RemoveESP(p)
	local data=ESP[p]
	if not data then return end

	if data.Circle then data.Circle:Destroy() end
	if data.CircleStroke then data.CircleStroke:Destroy() end
	if data.Name then data.Name:Destroy() end
	if data.Distance then data.Distance:Destroy() end

	ESP[p]=nil
end

local function CreateESP(p)
	if p==Player then return end

	RemoveESP(p)

	local Circle=Instance.new("Frame")
	Circle.Name="PlayerCircle"
	Circle.Size=UDim2.fromOffset(56,56)
	Circle.AnchorPoint=Vector2.new(.5,.5)
	Circle.BackgroundTransparency=1
	Circle.BorderSizePixel=0
	Circle.Visible=false
	Circle.ZIndex=1000
	Circle.Parent=Gui
	Corner(Circle,30)

	local CircleStroke=Instance.new("UIStroke")
	CircleStroke.Thickness=3
	CircleStroke.Color=CurrentColor
	CircleStroke.Parent=Circle

	local Name=Instance.new("TextLabel")
	Name.Name="PlayerName"
	Name.Size=UDim2.fromOffset(180,24)
	Name.AnchorPoint=Vector2.new(.5,.5)
	Name.BackgroundTransparency=1
	Name.Text=p.DisplayName
	Name.TextSize=14
	Name.Font=Enum.Font.GothamBold
	Name.TextColor3=CurrentColor
	Name.TextStrokeTransparency=.2
	Name.Visible=false
	Name.ZIndex=1001
	Name.Parent=Gui

	local Distance=Instance.new("TextLabel")
	Distance.Name="PlayerDistance"
	Distance.Size=UDim2.fromOffset(180,24)
	Distance.AnchorPoint=Vector2.new(.5,.5)
	Distance.BackgroundTransparency=1
	Distance.Text="0m"
	Distance.TextSize=13
	Distance.Font=Enum.Font.GothamBold
	Distance.TextColor3=CurrentColor
	Distance.TextStrokeTransparency=.2
	Distance.Visible=false
	Distance.ZIndex=1001
	Distance.Parent=Gui

	ESP[p]={
		Circle=Circle,
		CircleStroke=CircleStroke,
		Name=Name,
		Distance=Distance
	}
end

local function GetTorso(p)
	local char=p.Character
	if not char then return end

	return char:FindFirstChild("HumanoidRootPart")
		or char:FindFirstChild("UpperTorso")
		or char:FindFirstChild("Torso")
end

for _,p in ipairs(Players:GetPlayers()) do
	if p~=Player then
		CreateESP(p)
	end
end

Players.PlayerAdded:Connect(function(p)
	task.defer(function()
		CreateESP(p)
	end)
end)

Players.PlayerRemoving:Connect(RemoveESP)

CircleButton.Activated:Connect(function()
	CircleESPOn=not CircleESPOn
	CircleButton.Text=CircleESPOn and "Circle: ON" or "Circle: OFF"
end)

NameButton.Activated:Connect(function()
	NameESPOn=not NameESPOn
	NameButton.Text=NameESPOn and "Name: ON" or "Name: OFF"
end)

DistanceButton.Activated:Connect(function()
	DistanceESPOn=not DistanceESPOn
	DistanceButton.Text=DistanceESPOn and "Distance: ON" or "Distance: OFF"
end)

RainbowButton.Activated:Connect(function()
	RainbowOn=not RainbowOn
	RainbowButton.Text=RainbowOn and "Rainbow: ON" or "Rainbow: OFF"
end)

InfJumpButton.Activated:Connect(function()
	InfJumpOn=not InfJumpOn
	InfJumpButton.Text=InfJumpOn and "Inf Jump: ON" or "Inf Jump: OFF"
end)

FullBrightButton.Activated:Connect(function()
	FullBrightOn=not FullBrightOn
	FullBrightButton.Text=FullBrightOn and "Loop FB: ON" or "Loop FB: OFF"
end)

NoFogButton.Activated:Connect(function()
	NoFogOn=not NoFogOn
	NoFogButton.Text=NoFogOn and "No Fog: ON" or "No Fog: OFF"

	if not NoFogOn then
		Lighting.FogEnd=10000
	end
end)

UIS.JumpRequest:Connect(function()
	if not InfJumpOn then return end

	local char=Player.Character
	local hum=char and char:FindFirstChildOfClass("Humanoid")

	if hum then
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

RunService.RenderStepped:Connect(function()
	if FullBrightOn then
		Lighting.Brightness=2
		Lighting.ClockTime=14
		Lighting.GlobalShadows=false
		Lighting.OutdoorAmbient=Color3.fromRGB(255,255,255)
	end

	if NoFogOn then
		Lighting.FogEnd=1000000
	end

	if TargetOn and SelectedPlayer then
		local myChar=Player.Character
		local targetChar=SelectedPlayer.Character

		local myRoot=myChar and myChar:FindFirstChild("HumanoidRootPart")
		local targetRoot=targetChar and targetChar:FindFirstChild("HumanoidRootPart")

		if myRoot and targetRoot then
			local a=myRoot.Position
			local b=targetRoot.Position

			myRoot.CFrame=CFrame.lookAt(
				a,
				Vector3.new(b.X,a.Y,b.Z)
			)
		end
	end

	local camera=workspace.CurrentCamera
	if not camera then return end

	local myChar=Player.Character
	local myRoot=myChar and myChar:FindFirstChild("HumanoidRootPart")

	local color=CurrentColor

	if RainbowOn then
		color=Color3.fromHSV(
			(os.clock()*.3)%1,
			1,
			1
		)
	end

	for p,data in pairs(ESP) do
		local torso=GetTorso(p)
		local char=p.Character
		local hum=char and char:FindFirstChildOfClass("Humanoid")

		if not torso or not hum or hum.Health<=0 then
			data.Circle.Visible=false
			data.Name.Visible=false
			data.Distance.Visible=false
			continue
		end

		local screen,onScreen=camera:WorldToViewportPoint(torso.Position)

		if not onScreen or screen.Z<=0 then
			data.Circle.Visible=false
			data.Name.Visible=false
			data.Distance.Visible=false
			continue
		end

		local x=screen.X
		local y=screen.Y

		data.Circle.Position=UDim2.fromOffset(x,y)
		data.Circle.Visible=CircleESPOn

		data.Name.Position=UDim2.fromOffset(x,y-45)
		data.Name.Text=p.DisplayName
		data.Name.TextColor3=color
		data.Name.Visible=NameESPOn

		data.Distance.Position=UDim2.fromOffset(x,y+45)
		data.Distance.TextColor3=color
		data.Distance.Visible=DistanceESPOn

		if myRoot then
			data.Distance.Text=
				math.floor((myRoot.Position-torso.Position).Magnitude).."m"
		end

		data.CircleStroke.Color=color
	end
end)

local function ShowPage(page)
	JumpPage.Visible=false
	TargetPage.Visible=false
	VisualPage.Visible=false
	page.Visible=true
end

JumpTab.Activated:Connect(function()
	ShowPage(JumpPage)
end)

TargetTab.Activated:Connect(function()
	ShowPage(TargetPage)
	RefreshPlayers()
end)

VisualTab.Activated:Connect(function()
	ShowPage(VisualPage)
end)

local function MakeDraggable(handle,object)
	local dragging=false
	local startInput
	local startPosition

	handle.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1
			or input.UserInputType==Enum.UserInputType.Touch then

			dragging=true
			startInput=input.Position
			startPosition=object.Position
		end
	end)

	handle.InputChanged:Connect(function(input)
		if not dragging then return end

		if input.UserInputType==Enum.UserInputType.MouseMovement
			or input.UserInputType==Enum.UserInputType.Touch then

			local delta=input.Position-startInput

			object.Position=UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset+delta.X,
				startPosition.Y.Scale,
				startPosition.Y.Offset+delta.Y
			)
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1
			or input.UserInputType==Enum.UserInputType.Touch then

			dragging=false
		end
	end)
end

MakeDraggable(Open,Open)
MakeDraggable(Drag,Menu)

Open.Activated:Connect(function()
	Menu.Visible=not Menu.Visible
end)

Player.CharacterAdded:Connect(function()
	task.wait(.7)

	local j=WaitJump()

	if j then
		if SavedPosition then
			j.Position=SavedPosition
		end

		if SavedSize then
			j.Size=SavedSize
		end

		ChangeJumpImage()
	end
end)

task.defer(ChangeJumpImage)
RefreshPlayers()
