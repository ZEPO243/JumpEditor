local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--------------------------------------------------
-- ẢNH RBXTHUMB
--------------------------------------------------

local OUTSIDE_IMAGE =
	"rbxthumb://type=Asset&id=103326817624079&w=420&h=420"

local MENU_IMAGE =
	"rbxthumb://type=Asset&id=83617168855641&w=420&h=420"

--------------------------------------------------
-- GUI
--------------------------------------------------

local Gui = Instance.new("ScreenGui")
Gui.Name = "MyMenu"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

--------------------------------------------------
-- MENU NGOÀI
--------------------------------------------------

local Open = Instance.new("ImageButton")
Open.Name = "OpenButton"
Open.Size = UDim2.fromOffset(65,65)
Open.Position = UDim2.new(0.5,-32,0.5,-32)
Open.Image = OUTSIDE_IMAGE
Open.BackgroundColor3 = Color3.fromRGB(30,30,40)
Open.BorderSizePixel = 0
Open.AutoButtonColor = false
Open.Active = true
Open.ZIndex = 100
Open.Parent = Gui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1,0)
OpenCorner.Parent = Open

--------------------------------------------------
-- MENU TRONG
--------------------------------------------------

local Menu = Instance.new("Frame")
Menu.Name = "MainMenu"
Menu.Size = UDim2.fromOffset(520,340)
Menu.Position = UDim2.new(0.5,-260,0.5,-170)
Menu.BackgroundColor3 = Color3.fromRGB(20,20,28)
Menu.BackgroundTransparency = 0.05
Menu.BorderSizePixel = 0
Menu.Visible = false
Menu.Active = true
Menu.ZIndex = 10
Menu.Parent = Gui

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0,20)
MenuCorner.Parent = Menu

--------------------------------------------------
-- ẢNH MENU
--------------------------------------------------

local Background = Instance.new("ImageLabel")
Background.Size = UDim2.fromScale(1,1)
Background.BackgroundTransparency = 1
Background.Image = MENU_IMAGE
Background.ImageTransparency = 0.45
Background.ScaleType = Enum.ScaleType.Crop
Background.ZIndex = 11
Background.Parent = Menu

local BackgroundCorner = Instance.new("UICorner")
BackgroundCorner.CornerRadius = UDim.new(0,20)
BackgroundCorner.Parent = Background

--------------------------------------------------
-- LỚP TỐI
--------------------------------------------------

local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.fromScale(1,1)
Overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
Overlay.BackgroundTransparency = 0.55
Overlay.BorderSizePixel = 0
Overlay.Active = false
Overlay.ZIndex = 12
Overlay.Parent = Menu

local OverlayCorner = Instance.new("UICorner")
OverlayCorner.CornerRadius = UDim.new(0,20)
OverlayCorner.Parent = Overlay

--------------------------------------------------
-- THANH KÉO MENU
--------------------------------------------------

local Drag = Instance.new("TextButton")
Drag.Name = "DragBar"
Drag.Size = UDim2.new(1,-140,0,45)
Drag.Position = UDim2.fromOffset(140,0)
Drag.Text = ""
Drag.BackgroundTransparency = 1
Drag.BorderSizePixel = 0
Drag.AutoButtonColor = false
Drag.Active = true
Drag.ZIndex = 100
Drag.Parent = Menu

--------------------------------------------------
-- SIDEBAR
--------------------------------------------------

local Side = Instance.new("Frame")
Side.Size = UDim2.new(0,130,1,0)
Side.BackgroundColor3 = Color3.fromRGB(10,10,15)
Side.BackgroundTransparency = 0.15
Side.BorderSizePixel = 0
Side.ZIndex = 20
Side.Parent = Menu

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0,20)
SideCorner.Parent = Side

--------------------------------------------------
-- CONTENT
--------------------------------------------------

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-145,1,-20)
Content.Position = UDim2.fromOffset(140,10)
Content.BackgroundTransparency = 1
Content.ZIndex = 20
Content.Parent = Menu

--------------------------------------------------
-- TAB
--------------------------------------------------

local function TabButton(Text,Y)

	local B = Instance.new("TextButton")
	B.Size = UDim2.new(1,-16,0,45)
	B.Position = UDim2.fromOffset(8,Y)
	B.Text = Text
	B.TextSize = 14
	B.Font = Enum.Font.GothamBold
	B.TextColor3 = Color3.fromRGB(255,255,255)
	B.BackgroundColor3 = Color3.fromRGB(42,42,52)
	B.BorderSizePixel = 0
	B.AutoButtonColor = false
	B.Active = true
	B.ZIndex = 30
	B.Parent = Side

	local C = Instance.new("UICorner")
	C.CornerRadius = UDim.new(0,12)
	C.Parent = B

	return B
end

local JumpTab = TabButton("Jump",25)
local TargetTab = TabButton("Target",78)
local VisualTab = TabButton("Visual",131)

--------------------------------------------------
-- PAGES
--------------------------------------------------

local JumpPage = Instance.new("Frame")
JumpPage.Name = "JumpPage"
JumpPage.Size = UDim2.fromScale(1,1)
JumpPage.BackgroundTransparency = 1
JumpPage.Visible = true
JumpPage.ZIndex = 21
JumpPage.Parent = Content

local TargetPage = Instance.new("Frame")
TargetPage.Name = "TargetPage"
TargetPage.Size = UDim2.fromScale(1,1)
TargetPage.BackgroundTransparency = 1
TargetPage.Visible = false
TargetPage.ZIndex = 21
TargetPage.Parent = Content

local VisualPage = Instance.new("Frame")
VisualPage.Name = "VisualPage"
VisualPage.Size = UDim2.fromScale(1,1)
VisualPage.BackgroundTransparency = 1
VisualPage.Visible = false
VisualPage.ZIndex = 21
VisualPage.Parent = Content

--------------------------------------------------
-- BUTTON
--------------------------------------------------

local function Button(Parent,Text,X,Y,W,H)

	local B = Instance.new("TextButton")
	B.Size = UDim2.fromOffset(W or 70,H or 45)
	B.Position = UDim2.fromOffset(X,Y)
	B.Text = Text
	B.TextSize = 18
	B.Font = Enum.Font.GothamBold
	B.TextColor3 = Color3.fromRGB(255,255,255)
	B.BackgroundColor3 = Color3.fromRGB(40,40,52)
	B.BorderSizePixel = 0
	B.AutoButtonColor = false
	B.Active = true
	B.ZIndex = 40
	B.Parent = Parent

	local C = Instance.new("UICorner")
	C.CornerRadius = UDim.new(0,12)
	C.Parent = B

	return B
end

--------------------------------------------------
-- TAB 1: JUMP EDITOR
--------------------------------------------------

local Up = Button(JumpPage,"↑",130,55)
local Left = Button(JumpPage,"←",55,110)
local Reset = Button(JumpPage,"⟳",130,110)
local Right = Button(JumpPage,"→",205,110)
local Down = Button(JumpPage,"↓",130,165)
local Plus = Button(JumpPage,"+",205,55)
local Minus = Button(JumpPage,"−",55,165)

local SavedPosition
local SavedSize
local OriginalPosition
local OriginalSize

local function GetJump()

	local TouchGui = PlayerGui:FindFirstChild("TouchGui")
	if not TouchGui then return nil end

	local Control = TouchGui:FindFirstChild("TouchControlFrame")
	if not Control then return nil end

	return Control:FindFirstChild("JumpButton",true)
end

local function SaveOriginal()

	local J = GetJump()
	if not J then return end

	if not OriginalPosition then
		OriginalPosition = J.Position
		OriginalSize = J.Size
		SavedPosition = J.Position
		SavedSize = J.Size
	end
end

local function ApplyJump()

	local J = GetJump()
	if not J then return end

	SaveOriginal()

	if SavedPosition then
		J.Position = SavedPosition
	end

	if SavedSize then
		J.Size = SavedSize
	end
end

local function MoveJump(X,Y)

	local J = GetJump()
	if not J then return end

	SaveOriginal()

	local P = J.Position

	SavedPosition = UDim2.new(
		P.X.Scale,
		P.X.Offset + X,
		P.Y.Scale,
		P.Y.Offset + Y
	)

	J.Position = SavedPosition
end

local function ResizeJump(A)

	local J = GetJump()
	if not J then return end

	SaveOriginal()

	local S = J.Size

	SavedSize = UDim2.new(
		S.X.Scale,
		math.max(40,S.X.Offset + A),
		S.Y.Scale,
		math.max(40,S.Y.Offset + A)
	)

	J.Size = SavedSize
end

Up.Activated:Connect(function() MoveJump(0,-15) end)
Down.Activated:Connect(function() MoveJump(0,15) end)
Left.Activated:Connect(function() MoveJump(-15,0) end)
Right.Activated:Connect(function() MoveJump(15,0) end)
Plus.Activated:Connect(function() ResizeJump(15) end)
Minus.Activated:Connect(function() ResizeJump(-15) end)

Reset.Activated:Connect(function()

	local J = GetJump()
	if not J then return end

	if OriginalPosition then
		J.Position = OriginalPosition
		SavedPosition = OriginalPosition
	end

	if OriginalSize then
		J.Size = OriginalSize
		SavedSize = OriginalSize
	end
end)

Player.CharacterAdded:Connect(function()

	task.wait(0.5)

	for i = 1,50 do
		ApplyJump()
		task.wait(0.05)
	end
end)

--------------------------------------------------
-- TAB 2: TARGET
--------------------------------------------------

local SelectedPlayer = nil
local TargetOn = false
local ViewOn = false

local List = Instance.new("ScrollingFrame")
List.Size = UDim2.new(1,-20,0,145)
List.Position = UDim2.fromOffset(10,10)
List.BackgroundColor3 = Color3.fromRGB(15,15,20)
List.BackgroundTransparency = 0.2
List.BorderSizePixel = 0
List.ScrollBarThickness = 4
List.Active = true
List.ZIndex = 30
List.Parent = TargetPage

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0,5)
Layout.Parent = List

local Selected = Instance.new("TextLabel")
Selected.Size = UDim2.new(1,-20,0,35)
Selected.Position = UDim2.fromOffset(10,165)
Selected.BackgroundTransparency = 1
Selected.Text = "Target: None"
Selected.TextSize = 15
Selected.Font = Enum.Font.GothamBold
Selected.TextColor3 = Color3.fromRGB(255,255,255)
Selected.TextXAlignment = Enum.TextXAlignment.Left
Selected.ZIndex = 30
Selected.Parent = TargetPage

local TargetButton =
	Button(TargetPage,"Target: OFF",10,205,145,45)

local ViewButton =
	Button(TargetPage,"View: OFF",165,205,145,45)

local Refresh =
	Button(TargetPage,"Refresh",10,255,145,40)

local function RefreshPlayers()

	for _,v in ipairs(List:GetChildren()) do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end

	for _,P in ipairs(Players:GetPlayers()) do

		if P ~= Player then

			local B = Button(
				List,
				P.DisplayName.."  @"..P.Name,
				0,0,0,34
			)

			B.Size = UDim2.new(1,-10,0,34)

			B.Activated:Connect(function()

				SelectedPlayer = P
				Selected.Text =
					"Target: "..P.DisplayName

				if ViewOn then

					local H =
						P.Character and
						P.Character:FindFirstChildOfClass("Humanoid")

					if H then
						workspace.CurrentCamera.CameraType =
							Enum.CameraType.Custom

						workspace.CurrentCamera.CameraSubject = H
					end
				end
			end)
		end
	end

	task.wait()

	List.CanvasSize =
		UDim2.fromOffset(
			0,
			Layout.AbsoluteContentSize.Y + 10
		)
end

Refresh.Activated:Connect(RefreshPlayers)
Players.PlayerAdded:Connect(RefreshPlayers)

Players.PlayerRemoving:Connect(function(P)

	if P == SelectedPlayer then

		SelectedPlayer = nil
		TargetOn = false
		ViewOn = false

		TargetButton.Text = "Target: OFF"
		ViewButton.Text = "View: OFF"
		Selected.Text = "Target: None"

		local H =
			Player.Character and
			Player.Character:FindFirstChildOfClass("Humanoid")

		if H then
			workspace.CurrentCamera.CameraSubject = H
		end
	end

	task.defer(RefreshPlayers)
end)

RefreshPlayers()

TargetButton.Activated:Connect(function()

	if not SelectedPlayer then return end

	TargetOn = not TargetOn

	TargetButton.Text =
		TargetOn and
		"Target: ON" or
		"Target: OFF"
end)

ViewButton.Activated:Connect(function()

	if not SelectedPlayer then return end

	ViewOn = not ViewOn

	ViewButton.Text =
		ViewOn and
		"View: ON" or
		"View: OFF"

	if ViewOn then

		local H =
			SelectedPlayer.Character and
			SelectedPlayer.Character:FindFirstChildOfClass("Humanoid")

		if H then
			workspace.CurrentCamera.CameraSubject = H
		end

	else

		local H =
			Player.Character and
			Player.Character:FindFirstChildOfClass("Humanoid")

		if H then
			workspace.CurrentCamera.CameraSubject = H
		end
	end
end)

RunService.RenderStepped:Connect(function()

	if not TargetOn or not SelectedPlayer then return end

	local MyChar = Player.Character
	local TargetChar = SelectedPlayer.Character

	if not MyChar or not TargetChar then return end

	local MyRoot =
		MyChar:FindFirstChild("HumanoidRootPart")

	local TargetRoot =
		TargetChar:FindFirstChild("HumanoidRootPart")

	if not MyRoot or not TargetRoot then return end

	local A = MyRoot.Position
	local B = TargetRoot.Position

	MyRoot.CFrame = CFrame.lookAt(
		A,
		Vector3.new(B.X,A.Y,B.Z)
	)
end)

--------------------------------------------------
-- TAB 3: VISUAL (INF JUMP, LOOP FB & NO FOG)
--------------------------------------------------

local InfJumpOn = false
local LoopFBOn = false
local NoFogOn = false

local InfJumpButton =
	Button(
		VisualPage,
		"Inf Jump: OFF",
		20,20,220,40
	)

local LoopFBButton =
	Button(
		VisualPage,
		"Loop FB: OFF",
		20,70,220,40
	)

local NoFogButton =
	Button(
		VisualPage,
		"No Fog: OFF",
		20,120,220,40
	)

-- Logic Inf Jump
UserInputService.JumpRequest:Connect(function()
	if InfJumpOn then
		local Character = Player.Character
		if Character then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			if Humanoid then
				Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end
	end
end)

InfJumpButton.Activated:Connect(function()
	InfJumpOn = not InfJumpOn
	InfJumpButton.Text = InfJumpOn and "Inf Jump: ON" or "Inf Jump: OFF"
end)

-- Logic Loop Fullbright (Loop FB)
RunService.RenderStepped:Connect(function()
	if LoopFBOn then
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.GlobalShadows = false
		Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
	end
	
	if NoFogOn then
		Lighting.FogEnd = 1000000
	end
end)

LoopFBButton.Activated:Connect(function()
	LoopFBOn = not LoopFBOn
	LoopFBButton.Text = LoopFBOn and "Loop FB: ON" or "Loop FB: OFF"
end)

-- Logic No Fog
NoFogButton.Activated:Connect(function()
	NoFogOn = not NoFogOn
	NoFogButton.Text = NoFogOn and "No Fog: ON" or "No Fog: OFF"
	
	if not NoFogOn then
		Lighting.FogEnd = 10000
	end
end)

--------------------------------------------------
-- ĐỔI TAB
--------------------------------------------------

local function ShowPage(Page)

	JumpPage.Visible = false
	TargetPage.Visible = false
	VisualPage.Visible = false

	Page.Visible = true
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

--------------------------------------------------
-- HÀM KÉO CHUNG
--------------------------------------------------

local function MakeDraggable(Handle,Object)

	local Dragging = false
	local DragStart
	local StartPosition

	Handle.Active = true

	Handle.InputBegan:Connect(function(Input)

		if Input.UserInputType == Enum.UserInputType.MouseButton1
			or Input.UserInputType == Enum.UserInputType.Touch then

			Dragging = true
			DragStart = Input.Position
			StartPosition = Object.Position
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)

		if not Dragging then return end

		if Input.UserInputType == Enum.UserInputType.MouseMovement
			or Input.UserInputType == Enum.UserInputType.Touch then

			local Delta =
				Input.Position - DragStart

			Object.Position = UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,

				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		end
	end)

	UserInputService.InputEnded:Connect(function(Input)

		if Input.UserInputType == Enum.UserInputType.MouseButton1
			or Input.UserInputType == Enum.UserInputType.Touch then

			Dragging = false
		end
	end)
end

--------------------------------------------------
-- KÉO MENU
--------------------------------------------------

MakeDraggable(Open,Open)
MakeDraggable(Drag,Menu)

--------------------------------------------------
-- MỞ / ĐÓNG MENU
--------------------------------------------------

local Busy = false

Open.Activated:Connect(function()

	if Busy then return end

	Busy = true

	if Menu.Visible then

		Menu.Visible = false

	else

		Menu.Visible = true
		Menu.Size = UDim2.fromOffset(520,340)

	end

	Busy = false
end)
