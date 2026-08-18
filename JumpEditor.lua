local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--------------------------------------------------
-- ID ẢNH
--------------------------------------------------

local OUTSIDE_IMAGE_ID = "rbxassetid://108349790024749"
local MENU_IMAGE_ID = "rbxassetid://123931593435275"

--------------------------------------------------
-- GUI
--------------------------------------------------

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JumpEditor"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

--------------------------------------------------
-- NÚT MENU BÊN NGOÀI
--------------------------------------------------

local openButton = Instance.new("ImageButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.fromOffset(58, 58)
openButton.Position = UDim2.new(0.5, -29, 0.5, -29)
openButton.Image = OUTSIDE_IMAGE_ID
openButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
openButton.BorderSizePixel = 0
openButton.AutoButtonColor = false
openButton.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = openButton

local openStroke = Instance.new("UIStroke")
openStroke.Thickness = 2
openStroke.Transparency = 0.2
openStroke.Parent = openButton

--------------------------------------------------
-- 🔥 FIRE ANIMATION
--------------------------------------------------

local firePart = Instance.new("Part")
firePart.Name = "MenuFireEffect"
firePart.Size = Vector3.new(0.1, 0.1, 0.1)
firePart.Transparency = 1
firePart.Anchored = true
firePart.CanCollide = false
firePart.CanTouch = false
firePart.CanQuery = false
firePart.Parent = workspace

local fire = Instance.new("Fire")
fire.Name = "RealFire"
fire.Color = Color3.fromRGB(255, 100, 15)
fire.SecondaryColor = Color3.fromRGB(255, 220, 70)
fire.Heat = 0
fire.Size = 0
fire.Enabled = false
fire.Parent = firePart

--------------------------------------------------
-- CẬP NHẬT VỊ TRÍ LỬA
--------------------------------------------------

local function updateFirePosition()

	local camera = workspace.CurrentCamera

	if not camera then
		return
	end

	local buttonPosition = openButton.AbsolutePosition
	local buttonSize = openButton.AbsoluteSize

	local centerX =
		buttonPosition.X + buttonSize.X / 2

	local centerY =
		buttonPosition.Y + buttonSize.Y / 2

	local ray =
		camera:ViewportPointToRay(
			centerX,
			centerY
		)

	firePart.CFrame =
		CFrame.new(
			ray.Origin + ray.Direction * 3
		)

end

--------------------------------------------------
-- 🔥 HIỆU ỨNG BÙNG LỬA
--------------------------------------------------

local firePlaying = false

local function playFireEffect()

	if firePlaying then
		return
	end

	firePlaying = true

	updateFirePosition()

	fire.Size = 0
	fire.Heat = 0
	fire.Enabled = true

	-- BÙNG LÊN
	local flameUp = TweenService:Create(
		fire,
		TweenInfo.new(
			0.12,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		),
		{
			Size = 6,
			Heat = 12
		}
	)

	flameUp:Play()

	task.wait(0.3)

	-- CHÁY NHỎ DẦN
	local flameDown = TweenService:Create(
		fire,
		TweenInfo.new(
			0.4,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		),
		{
			Size = 2,
			Heat = 3
		}
	)

	flameDown:Play()

	task.wait(0.4)

	fire.Enabled = false
	firePlaying = false

end

--------------------------------------------------
-- MENU
--------------------------------------------------

local menu = Instance.new("Frame")
menu.Name = "Menu"
menu.Size = UDim2.fromOffset(250, 270)
menu.Position = UDim2.new(0.5, -125, 0.5, 40)
menu.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
menu.BorderSizePixel = 0
menu.Visible = false
menu.Parent = screenGui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 20)
menuCorner.Parent = menu

local menuStroke = Instance.new("UIStroke")
menuStroke.Thickness = 2
menuStroke.Transparency = 0.25
menuStroke.Parent = menu

--------------------------------------------------
-- 🖼️ ẢNH TRONG MENU
--------------------------------------------------

local menuImage = Instance.new("ImageLabel")
menuImage.Name = "MenuImage"
menuImage.Size = UDim2.fromOffset(40, 40)
menuImage.Position = UDim2.new(1, -50, 0, 14)
menuImage.BackgroundTransparency = 1
menuImage.Image = MENU_IMAGE_ID
menuImage.ScaleType = Enum.ScaleType.Fit
menuImage.Parent = menu

--------------------------------------------------
-- THANH KÉO MENU
--------------------------------------------------

local dragBar = Instance.new("TextButton")
dragBar.Name = "DragBar"
dragBar.Size = UDim2.new(1, -70, 0, 48)
dragBar.Position = UDim2.fromOffset(10, 10)
dragBar.Text = "ID  •  Jump Editor"
dragBar.TextSize = 18
dragBar.Font = Enum.Font.GothamBold
dragBar.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
dragBar.TextColor3 = Color3.fromRGB(255, 255, 255)
dragBar.BorderSizePixel = 0
dragBar.AutoButtonColor = false
dragBar.Parent = menu

local dragCorner = Instance.new("UICorner")
dragCorner.CornerRadius = UDim.new(0, 14)
dragCorner.Parent = dragBar

--------------------------------------------------
-- HÀM KÉO
--------------------------------------------------

local function makeDraggable(handle, target)

	local dragging = false
	local dragStart
	local startPosition

	handle.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseButton1 then

			dragging = true
			dragStart = input.Position
			startPosition = target.Position

		end

	end)

	UserInputService.InputChanged:Connect(function(input)

		if not dragging then
			return
		end

		if input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseMovement then

			local delta =
				input.Position - dragStart

			target.Position = UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset + delta.X,

				startPosition.Y.Scale,
				startPosition.Y.Offset + delta.Y
			)

		end

	end)

	UserInputService.InputEnded:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseButton1 then

			dragging = false

		end

	end)

end

--------------------------------------------------
-- KÉO ĐỘC LẬP
--------------------------------------------------

makeDraggable(openButton, openButton)
makeDraggable(dragBar, menu)

--------------------------------------------------
-- MỞ / ĐÓNG MENU
--------------------------------------------------

openButton.Activated:Connect(function()

	--------------------------------------------------
	-- 🔥 BÙNG LỬA
	--------------------------------------------------

	task.spawn(playFireEffect)

	--------------------------------------------------
	-- ✨ NÚT PHÓNG NHẸ
	--------------------------------------------------

	local originalSize =
		UDim2.fromOffset(58, 58)

	local biggerSize =
		UDim2.fromOffset(70, 70)

	TweenService:Create(
		openButton,
		TweenInfo.new(
			0.1,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		),
		{
			Size = biggerSize
		}
	):Play()

	task.delay(0.1, function()

		TweenService:Create(
			openButton,
			TweenInfo.new(
				0.18,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.Out
			),
			{
				Size = originalSize
			}
		):Play()

	end)

	--------------------------------------------------
	-- MENU
	--------------------------------------------------

	if menu.Visible then

		local closeTween = TweenService:Create(
			menu,
			TweenInfo.new(
				0.15,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			),
			{
				Size = UDim2.fromOffset(230, 250)
			}
		)

		closeTween:Play()

		task.wait(0.15)

		menu.Visible = false

	else

		menu.Visible = true

		menu.Size =
			UDim2.fromOffset(230, 250)

		local openTween = TweenService:Create(
			menu,
			TweenInfo.new(
				0.2,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.Out
			),
			{
				Size = UDim2.fromOffset(250, 270)
			}
		)

		openTween:Play()

	end

end)

--------------------------------------------------
-- TẠO NÚT
--------------------------------------------------

local function createButton(name, text, x, y)

	local button =
		Instance.new("TextButton")

	button.Name = name
	button.Size =
		UDim2.fromOffset(52, 42)

	button.Position =
		UDim2.fromOffset(x, y)

	button.Text = text
	button.TextSize = 22
	button.Font = Enum.Font.GothamBold

	button.BackgroundColor3 =
		Color3.fromRGB(42, 42, 55)

	button.TextColor3 =
		Color3.fromRGB(255, 255, 255)

	button.BorderSizePixel = 0
	button.AutoButtonColor = false

	button.Parent = menu

	local corner =
		Instance.new("UICorner")

	corner.CornerRadius =
		UDim.new(0, 12)

	corner.Parent = button

	local stroke =
		Instance.new("UIStroke")

	stroke.Thickness = 1
	stroke.Transparency = 0.45
	stroke.Parent = button

	--------------------------------------------------
	-- HOVER
	--------------------------------------------------

	button.MouseEnter:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.1),
			{
				BackgroundColor3 =
					Color3.fromRGB(60, 60, 75)
			}
		):Play()

	end)

	button.MouseLeave:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.1),
			{
				BackgroundColor3 =
					Color3.fromRGB(42, 42, 55)
			}
		):Play()

	end)

	return button

end

--------------------------------------------------
-- NÚT DI CHUYỂN
--------------------------------------------------

local upButton =
	createButton("Up", "↑", 99, 70)

local leftButton =
	createButton("Left", "←", 38, 117)

local resetButton =
	createButton("Reset", "⟳", 99, 117)

local rightButton =
	createButton("Right", "→", 160, 117)

local downButton =
	createButton("Down", "↓", 99, 164)

--------------------------------------------------
-- NÚT KÍCH THƯỚC
--------------------------------------------------

local increaseButton =
	createButton("Increase", "+", 160, 70)

local decreaseButton =
	createButton("Decrease", "−", 38, 164)

--------------------------------------------------
-- NHÃN
--------------------------------------------------

local sizeLabel =
	Instance.new("TextLabel")

sizeLabel.Size =
	UDim2.fromOffset(200, 28)

sizeLabel.Position =
	UDim2.fromOffset(25, 220)

sizeLabel.Text =
	"JUMP POSITION  •  SIZE"

sizeLabel.TextSize = 13
sizeLabel.Font =
	Enum.Font.GothamMedium

sizeLabel.TextColor3 =
	Color3.fromRGB(170, 170, 185)

sizeLabel.BackgroundTransparency = 1
sizeLabel.Parent = menu

--------------------------------------------------
-- TÌM NÚT JUMP
--------------------------------------------------

local function getJumpButton()

	local touchGui =
		playerGui:FindFirstChild("TouchGui")

	if not touchGui then
		return nil
	end

	local touchControlFrame =
		touchGui:FindFirstChild(
			"TouchControlFrame"
		)

	if not touchControlFrame then
		return nil
	end

	return touchControlFrame:FindFirstChild(
		"JumpButton",
		true
	)

end

--------------------------------------------------
-- LƯU VỊ TRÍ BAN ĐẦU
--------------------------------------------------

task.wait(1)

local jumpButton =
	getJumpButton()

local originalPosition = nil
local originalSize = nil

if jumpButton then

	originalPosition =
		jumpButton.Position

	originalSize =
		jumpButton.Size

end

--------------------------------------------------
-- DI CHUYỂN JUMP
--------------------------------------------------

local function moveJump(x, y)

	local jump =
		getJumpButton()

	if not jump then
		return
	end

	local position =
		jump.Position

	jump.Position =
		UDim2.new(
			position.X.Scale,
			position.X.Offset + x,

			position.Y.Scale,
			position.Y.Offset + y
		)

end

--------------------------------------------------
-- ĐỔI KÍCH THƯỚC
--------------------------------------------------

local function resizeJump(amount)

	local jump =
		getJumpButton()

	if not jump then
		return
	end

	local size =
		jump.Size

	local width =
		math.max(
			40,
			size.X.Offset + amount
		)

	local height =
		math.max(
			40,
			size.Y.Offset + amount
		)

	jump.Size =
		UDim2.new(
			size.X.Scale,
			width,

			size.Y.Scale,
			height
		)

end

--------------------------------------------------
-- NÚT ↑
--------------------------------------------------

upButton.Activated:Connect(function()
	moveJump(0, -15)
end)

--------------------------------------------------
-- NÚT ↓
--------------------------------------------------

downButton.Activated:Connect(function()
	moveJump(0, 15)
end)

--------------------------------------------------
-- NÚT ←
--------------------------------------------------

leftButton.Activated:Connect(function()
	moveJump(-15, 0)
end)

--------------------------------------------------
-- NÚT →
--------------------------------------------------

rightButton.Activated:Connect(function()
	moveJump(15, 0)
end)

--------------------------------------------------
-- NÚT +
--------------------------------------------------

increaseButton.Activated:Connect(function()
	resizeJump(15)
end)

--------------------------------------------------
-- NÚT −
--------------------------------------------------

decreaseButton.Activated:Connect(function()
	resizeJump(-15)
end)

--------------------------------------------------
-- RESET
--------------------------------------------------

resetButton.Activated:Connect(function()

	local jump =
		getJumpButton()

	if not jump then
		return
	end

	if originalPosition then
		jump.Position =
			originalPosition
	end

	if originalSize then
		jump.Size =
			originalSize
	end

end)
