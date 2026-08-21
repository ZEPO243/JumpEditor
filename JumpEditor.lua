local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local RunService=game:GetService("RunService")
local Lighting=game:GetService("Lighting")

local Player=Players.LocalPlayer
local PlayerGui=Player:WaitForChild("PlayerGui")

local OUTSIDE_IMAGE="rbxthumb://type=Asset&id=103326817624079&w=420&h=420"
local MENU_IMAGE="rbxthumb://type=Asset&id=83617168855641&w=420&h=420"

local Old=PlayerGui:FindFirstChild("MyMenu")
if Old then
	Old:Destroy()
end

local Gui=Instance.new("ScreenGui")
Gui.Name="MyMenu"
Gui.ResetOnSpawn=false
Gui.IgnoreGuiInset=true
Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
Gui.DisplayOrder=100
Gui.Parent=PlayerGui

local function Corner(Object,Radius)
	local C=Instance.new("UICorner")
	C.CornerRadius=UDim.new(0,Radius)
	C.Parent=Object
	return C
end

local function Stroke(Object,Color,Thickness,Transparency)
	local S=Instance.new("UIStroke")
	S.Color=Color
	S.Thickness=Thickness
	S.Transparency=Transparency or 0
	S.Parent=Object
	return S
end

local function MakeButton(Parent,Text,X,Y,W,H)
	local B=Instance.new("TextButton")
	B.Size=UDim2.fromOffset(W,H)
	B.Position=UDim2.fromOffset(X,Y)
	B.Text=Text
	B.TextSize=14
	B.Font=Enum.Font.GothamBold
	B.TextColor3=Color3.fromRGB(255,255,255)
	B.BackgroundColor3=Color3.fromRGB(42,42,54)
	B.BorderSizePixel=0
	B.AutoButtonColor=false
	B.Active=true
	B.ZIndex=50
	B.Parent=Parent
	Corner(B,10)
	return B
end

local Open=Instance.new("ImageButton")
Open.Name="OpenButton"
Open.Size=UDim2.fromOffset(60,60)
Open.Position=UDim2.new(0.5,-30,0.5,-30)
Open.Image=OUTSIDE_IMAGE
Open.BackgroundColor3=Color3.fromRGB(30,30,40)
Open.BorderSizePixel=0
Open.AutoButtonColor=false
Open.Active=true
Open.ZIndex=500
Open.Parent=Gui
Corner(Open,30)

local OpenStroke=Stroke(
	Open,
	Color3.fromRGB(150,90,220),
	2,
	0.15
)

local Menu=Instance.new("Frame")
Menu.Name="MainMenu"
Menu.Size=UDim2.fromOffset(500,370)
Menu.Position=UDim2.new(0.5,-250,0.5,-185)
Menu.BackgroundColor3=Color3.fromRGB(20,20,28)
Menu.BackgroundTransparency=0.03
Menu.BorderSizePixel=0
Menu.Visible=false
Menu.Active=true
Menu.ZIndex=10
Menu.Parent=Gui
Corner(Menu,18)
Stroke(Menu,Color3.fromRGB(120,70,170),1,0.25)

local Background=Instance.new("ImageLabel")
Background.Size=UDim2.fromScale(1,1)
Background.BackgroundTransparency=1
Background.Image=MENU_IMAGE
Background.ImageTransparency=0.5
Background.ScaleType=Enum.ScaleType.Crop
Background.ZIndex=11
Background.Parent=Menu
Corner(Background,18)

local Overlay=Instance.new("Frame")
Overlay.Size=UDim2.fromScale(1,1)
Overlay.BackgroundColor3=Color3.fromRGB(0,0,0)
Overlay.BackgroundTransparency=0.52
Overlay.BorderSizePixel=0
Overlay.Active=false
Overlay.ZIndex=12
Overlay.Parent=Menu
Corner(Overlay,18)

local Drag=Instance.new("TextButton")
Drag.Name="DragBar"
Drag.Size=UDim2.new(1,-125,0,42)
Drag.Position=UDim2.fromOffset(125,0)
Drag.Text=""
Drag.BackgroundTransparency=1
Drag.BorderSizePixel=0
Drag.AutoButtonColor=false
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
Title.TextColor3=Color3.fromRGB(255,255,255)
Title.TextXAlignment=Enum.TextXAlignment.Left
Title.ZIndex=101
Title.Parent=Menu

local Side=Instance.new("Frame")
Side.Size=UDim2.fromOffset(125,370)
Side.BackgroundColor3=Color3.fromRGB(10,10,15)
Side.BackgroundTransparency=0.1
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

local JumpTab=MakeButton(Side,"Jump",8,25,109,42)
local TargetTab=MakeButton(Side,"Target",8,75,109,42)
local VisualTab=MakeButton(Side,"Visual",8,125,109,42)

local JumpPage=Instance.new("Frame")
JumpPage.Size=UDim2.fromScale(1,1)
JumpPage.BackgroundTransparency=1
JumpPage.Visible=true
JumpPage.ZIndex=21
JumpPage.Parent=Content

local TargetPage=Instance.new("Frame")
TargetPage.Size=UDim2.fromScale(1,1)
TargetPage.BackgroundTransparency=1
TargetPage.Visible=false
TargetPage.ZIndex=21
TargetPage.Parent=Content

local VisualPage=Instance.new("ScrollingFrame")
VisualPage.Size=UDim2.fromScale(1,1)
VisualPage.BackgroundTransparency=1
VisualPage.BorderSizePixel=0
VisualPage.ScrollBarThickness=3
VisualPage.CanvasSize=UDim2.fromOffset(0,540)
VisualPage.Visible=false
VisualPage.ZIndex=21
VisualPage.Parent=Content

local Up=MakeButton(JumpPage,"↑",120,45,65,42)
local Left=MakeButton(JumpPage,"←",48,92,65,42)
local Reset=MakeButton(JumpPage,"⟳",120,92,65,42)
local Right=MakeButton(JumpPage,"→",192,92,65,42)
local Down=MakeButton(JumpPage,"↓",120,139,65,42)
local Plus=MakeButton(JumpPage,"+",192,45,65,42)
local Minus=MakeButton(JumpPage,"−",48,139,65,42)

local OriginalPosition=nil
local OriginalSize=nil
local SavedPosition=nil
local SavedSize=nil

local function GetJump()
	local TouchGui=PlayerGui:FindFirstChild("TouchGui")
	if not TouchGui then
		return nil
	end

	local Control=TouchGui:FindFirstChild("TouchControlFrame")
	if not Control then
		return nil
	end

	return Control:FindFirstChild("JumpButton",true)
end

local function SaveOriginal()
	local J=GetJump()
	if not J then
		return
	end

	if not OriginalPosition then
		OriginalPosition=J.Position
		OriginalSize=J.Size
		SavedPosition=J.Position
		SavedSize=J.Size
	end
end

local function MoveJump(X,Y)
	local J=GetJump()
	if not J then
		return
	end

	SaveOriginal()

	local P=J.Position

	J.Position=UDim2.new(
		P.X.Scale,
		P.X.Offset+X,
		P.Y.Scale,
		P.Y.Offset+Y
	)

	SavedPosition=J.Position
end

local function ResizeJump(Amount)
	local J=GetJump()
	if not J then
		return
	end

	SaveOriginal()

	local S=J.Size

	SavedSize=UDim2.new(
		S.X.Scale,
		math.max(40,S.X.Offset+Amount),
		S.Y.Scale,
		math.max(40,S.Y.Offset+Amount)
	)

	J.Size=SavedSize
end

Up.Activated:Connect(function()
	MoveJump(0,-15)
end)

Down.Activated:Connect(function()
	MoveJump(0,15)
end)

Left.Activated:Connect(function()
	MoveJump(-15,0)
end)

Right.Activated:Connect(function()
	MoveJump(15,0)
end)

Plus.Activated:Connect(function()
	ResizeJump(15)
end)

Minus.Activated:Connect(function()
	ResizeJump(-15)
end)

Reset.Activated:Connect(function()
	local J=GetJump()
	if not J then
		return
	end

	if OriginalPosition then
		J.Position=OriginalPosition
		SavedPosition=OriginalPosition
	end

	if OriginalSize then
		J.Size=OriginalSize
		SavedSize=OriginalSize
	end
end)

local SelectedPlayer=nil
local TargetOn=false
local ViewOn=false

local List=Instance.new("ScrollingFrame")
List.Size=UDim2.new(1,-20,0,130)
List.Position=UDim2.fromOffset(10,5)
List.BackgroundColor3=Color3.fromRGB(15,15,20)
List.BackgroundTransparency=0.15
List.BorderSizePixel=0
List.ScrollBarThickness=4
List.ZIndex=35
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
SelectedLabel.TextColor3=Color3.fromRGB(255,255,255)
SelectedLabel.TextXAlignment=Enum.TextXAlignment.Left
SelectedLabel.ZIndex=35
SelectedLabel.Parent=TargetPage

local TargetButton=MakeButton(TargetPage,"Target: OFF",10,178,135,42)
local ViewButton=MakeButton(TargetPage,"View: OFF",155,178,135,42)
local RefreshButton=MakeButton(TargetPage,"Refresh",10,228,135,42)

local function SetCameraToPlayer(Target)
	if not Target then
		return
	end

	local Character=Target.Character
	if not Character then
		return
	end

	local Humanoid=Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then
		return
	end

	local Camera=workspace.CurrentCamera
	Camera.CameraType=Enum.CameraType.Custom
	Camera.CameraSubject=Humanoid
end

local function RefreshPlayers()
	for _,V in ipairs(List:GetChildren()) do
		if V:IsA("TextButton") then
			V:Destroy()
		end
	end

	for _,P in ipairs(Players:GetPlayers()) do
		if P~=Player then
			local B=MakeButton(
				List,
				P.DisplayName.." @"..P.Name,
				0,
				0,
				100,
				32
			)

			B.Size=UDim2.new(1,-8,0,32)
			B.TextSize=12
			B.Parent=List

			B.Activated:Connect(function()
				SelectedPlayer=P
				SelectedLabel.Text="Target: "..P.DisplayName

				if ViewOn then
					SetCameraToPlayer(P)
				end
			end)
		end
	end

	task.wait()

	List.CanvasSize=UDim2.fromOffset(
		0,
		ListLayout.AbsoluteContentSize.Y+5
	)
end

RefreshButton.Activated:Connect(RefreshPlayers)

Players.PlayerAdded:Connect(function()
	task.defer(RefreshPlayers)
end)

Players.PlayerRemoving:Connect(function(P)
	if P==SelectedPlayer then
		SelectedPlayer=nil
		TargetOn=false
		ViewOn=false

		TargetButton.Text="Target: OFF"
		ViewButton.Text="View: OFF"
		SelectedLabel.Text="Target: None"

		local Camera=workspace.CurrentCamera
		local Character=Player.Character
		local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")

		if Humanoid then
			Camera.CameraSubject=Humanoid
		end
	end

	task.defer(RefreshPlayers)
end)

TargetButton.Activated:Connect(function()
	if not SelectedPlayer then
		return
	end

	TargetOn=not TargetOn
	TargetButton.Text=TargetOn and "Target: ON" or "Target: OFF"
end)

ViewButton.Activated:Connect(function()
	if not SelectedPlayer then
		return
	end

	ViewOn=not ViewOn
	ViewButton.Text=ViewOn and "View: ON" or "View: OFF"

	if ViewOn then
		SetCameraToPlayer(SelectedPlayer)
	else
		local Camera=workspace.CurrentCamera
		local Character=Player.Character
		local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")

		if Humanoid then
			Camera.CameraType=Enum.CameraType.Custom
			Camera.CameraSubject=Humanoid
		end
	end
end)

local InfJumpOn=false
local FullBrightOn=false
local NoFogOn=false
local CircleESPOn=false
local NameESPOn=false
local DistanceESPOn=false
local RainbowOn=false

local InfJumpButton=MakeButton(VisualPage,"Inf Jump: OFF",15,15,210,40)
local FullBrightButton=MakeButton(VisualPage,"Loop FB: OFF",15,62,210,40)
local NoFogButton=MakeButton(VisualPage,"No Fog: OFF",15,109,210,40)
local CircleButton=MakeButton(VisualPage,"Circle: OFF",15,156,210,40)
local NameButton=MakeButton(VisualPage,"Name: OFF",15,203,210,40)
local DistanceButton=MakeButton(VisualPage,"Distance: OFF",15,250,210,40)
local RainbowButton=MakeButton(VisualPage,"Rainbow: OFF",15,297,210,40)

local ColorLabel=Instance.new("TextLabel")
ColorLabel.Size=UDim2.fromOffset(160,26)
ColorLabel.Position=UDim2.fromOffset(245,15)
ColorLabel.BackgroundTransparency=1
ColorLabel.Text="Color"
ColorLabel.TextSize=14
ColorLabel.Font=Enum.Font.GothamBold
ColorLabel.TextColor3=Color3.fromRGB(255,255,255)
ColorLabel.TextXAlignment=Enum.TextXAlignment.Left
ColorLabel.ZIndex=50
ColorLabel.Parent=VisualPage

local CurrentColor=Color3.fromRGB(170,80,255)

local Preview=Instance.new("Frame")
Preview.Size=UDim2.fromOffset(42,42)
Preview.Position=UDim2.fromOffset(245,42)
Preview.BackgroundColor3=CurrentColor
Preview.BorderSizePixel=0
Preview.ZIndex=50
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

for I,Data in ipairs(Presets) do
	local X=245+((I-1)%4)*47
	local Y=92+math.floor((I-1)/4)*47

	local B=MakeButton(
		VisualPage,
		Data[1],
		X,
		Y,
		40,
		40
	)

	B.BackgroundColor3=Data[2]

	B.Activated:Connect(function()
		CurrentColor=Data[2]
		Preview.BackgroundColor3=CurrentColor
	end)
end

local ESP={}

local function RemoveESP(P)
	local Data=ESP[P]

	if not Data then
		return
	end

	if Data.Circle then
		Data.Circle:Destroy()
	end

	if Data.CircleStroke then
		Data.CircleStroke:Destroy()
	end

	if Data.Name then
		Data.Name:Destroy()
	end

	if Data.Distance then
		Data.Distance:Destroy()
	end

	ESP[P]=nil
end

local function CreateESP(P)
	if P==Player then
		return
	end

	RemoveESP(P)

	local Circle=Instance.new("Frame")
	Circle.Name="PlayerCircle"
	Circle.Size=UDim2.fromOffset(56,56)
	Circle.AnchorPoint=Vector2.new(0.5,0.5)
	Circle.BackgroundTransparency=1
	Circle.BorderSizePixel=0
	Circle.Visible=false
	Circle.ZIndex=1000
	Circle.Parent=Gui

	local CircleCorner=Instance.new("UICorner")
	CircleCorner.CornerRadius=UDim.new(1,0)
	CircleCorner.Parent=Circle

	local CircleStroke=Instance.new("UIStroke")
	CircleStroke.Thickness=3
	CircleStroke.Color=CurrentColor
	CircleStroke.Transparency=0
	CircleStroke.Parent=Circle

	local Name=Instance.new("TextLabel")
	Name.Name="PlayerName"
	Name.Size=UDim2.fromOffset(180,24)
	Name.AnchorPoint=Vector2.new(0.5,0.5)
	Name.BackgroundTransparency=1
	Name.Text=P.DisplayName
	Name.TextSize=14
	Name.Font=Enum.Font.GothamBold
	Name.TextColor3=CurrentColor
	Name.TextStrokeTransparency=0.2
	Name.Visible=false
	Name.ZIndex=1001
	Name.Parent=Gui

	local Distance=Instance.new("TextLabel")
	Distance.Name="PlayerDistance"
	Distance.Size=UDim2.fromOffset(180,24)
	Distance.AnchorPoint=Vector2.new(0.5,0.5)
	Distance.BackgroundTransparency=1
	Distance.Text="0m"
	Distance.TextSize=13
	Distance.Font=Enum.Font.GothamBold
	Distance.TextColor3=CurrentColor
	Distance.TextStrokeTransparency=0.2
	Distance.Visible=false
	Distance.ZIndex=1001
	Distance.Parent=Gui

	ESP[P]={
		Circle=Circle,
		CircleStroke=CircleStroke,
		Name=Name,
		Distance=Distance
	}
end

local function CreateAllESP()
	for _,P in ipairs(Players:GetPlayers()) do
		if P~=Player then
			CreateESP(P)
		end
	end
end

local function HideESP()
	for _,Data in pairs(ESP) do
		if Data.Circle then
			Data.Circle.Visible=false
		end

		if Data.Name then
			Data.Name.Visible=false
		end

		if Data.Distance then
			Data.Distance.Visible=false
		end
	end
end

CreateAllESP()

Players.PlayerAdded:Connect(function(P)
	CreateESP(P)
end)

Players.PlayerRemoving:Connect(function(P)
	RemoveESP(P)
end)

local function GetTorso(P)
	local Character=P.Character

	if not Character then
		return nil
	end

	return Character:FindFirstChild("UpperTorso")
		or Character:FindFirstChild("Torso")
		or Character:FindFirstChild("HumanoidRootPart")
end

CircleButton.Activated:Connect(function()
	CircleESPOn=not CircleESPOn
	CircleButton.Text=CircleESPOn and "Circle: ON" or "Circle: OFF"

	if CircleESPOn then
		CreateAllESP()
	end
end)

NameButton.Activated:Connect(function()
	NameESPOn=not NameESPOn
	NameButton.Text=NameESPOn and "Name: ON" or "Name: OFF"

	if NameESPOn then
		CreateAllESP()
	end
end)

DistanceButton.Activated:Connect(function()
	DistanceESPOn=not DistanceESPOn
	DistanceButton.Text=DistanceESPOn and "Distance: ON" or "Distance: OFF"

	if DistanceESPOn then
		CreateAllESP()
	end
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
	if not InfJumpOn then
		return
	end

	local Character=Player.Character
	local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")

	if Humanoid then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
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
		local MyCharacter=Player.Character
		local TargetCharacter=SelectedPlayer.Character

		local MyRoot=MyCharacter and MyCharacter:FindFirstChild("HumanoidRootPart")
		local TargetRoot=TargetCharacter and TargetCharacter:FindFirstChild("HumanoidRootPart")

		if MyRoot and TargetRoot then
			local A=MyRoot.Position
			local B=TargetRoot.Position

			MyRoot.CFrame=CFrame.lookAt(
				A,
				Vector3.new(B.X,A.Y,B.Z)
			)
		end
	end

	local Camera=workspace.CurrentCamera

	if not Camera then
		return
	end

	local MyCharacter=Player.Character
	local MyRoot=MyCharacter and MyCharacter:FindFirstChild("HumanoidRootPart")

	local Color=CurrentColor

	if RainbowOn then
		Color=Color3.fromHSV(
			(os.clock()*0.3)%1,
			1,
			1
		)
	end

	for P,Data in pairs(ESP) do
		local Torso=GetTorso(P)
		local Character=P.Character
		local Humanoid=Character and Character:FindFirstChildOfClass("Humanoid")

		if not Torso or not Humanoid or Humanoid.Health<=0 then
			Data.Circle.Visible=false
			Data.Name.Visible=false
			Data.Distance.Visible=false
			continue
		end

		local ScreenPosition,OnScreen=
			Camera:WorldToViewportPoint(Torso.Position)

		if not OnScreen or ScreenPosition.Z<=0 then
			Data.Circle.Visible=false
			Data.Name.Visible=false
			Data.Distance.Visible=false
			continue
		end

		local X=ScreenPosition.X
		local Y=ScreenPosition.Y

		Data.Circle.Size=UDim2.fromOffset(56,56)
		Data.Circle.Position=UDim2.fromOffset(X,Y)
		Data.Circle.Visible=CircleESPOn

		Data.Name.Position=UDim2.fromOffset(X,Y-45)
		Data.Name.Text=P.DisplayName
		Data.Name.TextColor3=Color
		Data.Name.Visible=NameESPOn

		Data.Distance.Position=UDim2.fromOffset(X,Y+45)
		Data.Distance.TextColor3=Color
		Data.Distance.Visible=DistanceESPOn

		if MyRoot then
			local Distance=(MyRoot.Position-Torso.Position).Magnitude
			Data.Distance.Text=math.floor(Distance).."m"
		end

		Data.CircleStroke.Color=Color
	end
end)

local function ShowPage(Page)
	JumpPage.Visible=false
	TargetPage.Visible=false
	VisualPage.Visible=false
	Page.Visible=true
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

local function MakeDraggable(Handle,Object)
	local Dragging=false
	local StartInput=nil
	local StartPosition=nil

	Handle.InputBegan:Connect(function(Input)
		if Input.UserInputType==Enum.UserInputType.MouseButton1
			or Input.UserInputType==Enum.UserInputType.Touch then

			Dragging=true
			StartInput=Input.Position
			StartPosition=Object.Position
		end
	end)

	UIS.InputChanged:Connect(function(Input)
		if not Dragging then
			return
		end

		if Input.UserInputType==Enum.UserInputType.MouseMovement
			or Input.UserInputType==Enum.UserInputType.Touch then

			local Delta=Input.Position-StartInput

			Object.Position=UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset+Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset+Delta.Y
			)
		end
	end)

	UIS.InputEnded:Connect(function(Input)
		if Input.UserInputType==Enum.UserInputType.MouseButton1
			or Input.UserInputType==Enum.UserInputType.Touch then

			Dragging=false
		end
	end)
end

MakeDraggable(Open,Open)
MakeDraggable(Drag,Menu)

Open.Activated:Connect(function()
	Menu.Visible=not Menu.Visible
end)

Player.CharacterAdded:Connect(function()
	task.wait(0.5)

	local J=GetJump()

	if J and SavedPosition then
		J.Position=SavedPosition
	end

	if J and SavedSize then
		J.Size=SavedSize
	end
end)

RefreshPlayers()
