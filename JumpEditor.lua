local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--------------------------------------------------
-- GUI
--------------------------------------------------

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JumpEditor"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

--------------------------------------------------
-- NÚT 😇 BÊN NGOÀI
--------------------------------------------------

local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.fromOffset(55, 55)
openButton.Position = UDim2.new(0.75, 0, 0.15, 0)
openButton.Text = "😇"
openButton.TextScaled = true
openButton.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = openButton

--------------------------------------------------
-- MENU
--------------------------------------------------

local menu = Instance.new("Frame")
menu.Name = "Menu"
menu.Size = UDim2.fromOffset(230, 230)
menu.Position = UDim2.new(0.5, -115, 0.5, 30)
menu.Visible = false
menu.Parent = screenGui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 18)
menuCorner.Parent = menu

--------------------------------------------------
-- THANH KÉO MENU
--------------------------------------------------

local dragBar = Instance.new("TextButton")
dragBar.Name = "DragBar"
dragBar.Size = UDim2.new(1, 0, 0, 45)
dragBar.Position = UDim2.fromOffset(0, 0)
dragBar.Text = "😇"
dragBar.TextScaled = true
dragBar.AutoButtonColor = false
dragBar.Parent = menu

local dragCorner = Instance.new("UICorner")
dragCorner.CornerRadius = UDim.new(0, 18)
dragCorner.Parent = dragBar

--------------------------------------------------
-- KÉO ĐỐI TƯỢNG
--------------------------------------------------

local function makeDraggable(handle, target)

	local dragging = false
	local dragStart = nil
	local targetStart = nil

	handle.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseButton1 then

			dragging = true
			dragStart = input.Position
			targetStart = target.Position

		end

	end)

	UserInputService.InputChanged:Connect(function(input)

		if not dragging then
			return
		end

		if input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseMovement then

			local delta = input.Position - dragStart

			target.Position = UDim2.new(
				targetStart.X.Scale,
				targetStart.X.Offset + delta.X,

				targetStart.Y.Scale,
				targetStart.Y.Offset + delta.Y
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
-- KÉO RIÊNG
--------------------------------------------------

-- 😇 bên ngoài chỉ kéo chính nó
makeDraggable(openButton, openButton)

-- 😇 trong menu kéo toàn bộ menu
makeDraggable(dragBar, menu)

--------------------------------------------------
-- MỞ / ĐÓNG MENU
--------------------------------------------------

openButton.Activated:Connect(function()

	menu.Visible = not menu.Visible

end)

--------------------------------------------------
-- TẠO NÚT
--------------------------------------------------

local function createButton(name, text, x, y)

	local button = Instance.new("TextButton")

	button.Name = name
	button.Size = UDim2.fromOffset(52, 42)
	button.Position = UDim2.fromOffset(x, y)

	button.Text = text
	button.TextScaled = true

	button.Parent = menu

	return button

end

--------------------------------------------------
-- ĐIỀU KHIỂN JUMP
--------------------------------------------------

local upButton =
	createButton("Up", "↑", 89, 55)

local leftButton =
	createButton("Left", "←", 25, 103)

local resetButton =
	createButton("Reset", "⟳", 89, 103)

local rightButton =
	createButton("Right", "→", 153, 103)

local downButton =
	createButton("Down", "↓", 89, 151)

--------------------------------------------------
-- TĂNG / GIẢM KÍCH THƯỚC
--------------------------------------------------

local increaseButton =
	createButton("Increase", "+", 153, 55)

local decreaseButton =
	createButton("Decrease", "−", 25, 151)

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
		touchGui:FindFirstChild("TouchControlFrame")

	if not touchControlFrame then
		return nil
	end

	return touchControlFrame:FindFirstChild(
		"JumpButton",
		true
	)

end

--------------------------------------------------
-- LƯU TRẠNG THÁI BAN ĐẦU
--------------------------------------------------

task.wait(1)

local jumpButton = getJumpButton()

local originalPosition = nil
local originalSize = nil

if jumpButton then

	originalPosition = jumpButton.Position
	originalSize = jumpButton.Size

end

--------------------------------------------------
-- DI CHUYỂN JUMP
--------------------------------------------------

local function moveJump(x, y)

	local jump = getJumpButton()

	if not jump then
		return
	end

	local position =
		jump.Position

	jump.Position = UDim2.new(

		position.X.Scale,
		position.X.Offset + x,

		position.Y.Scale,
		position.Y.Offset + y

	)

end

--------------------------------------------------
-- ĐỔI KÍCH THƯỚC JUMP
--------------------------------------------------

local function resizeJump(amount)

	local jump = getJumpButton()

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

	jump.Size = UDim2.new(

		size.X.Scale,
		width,

		size.Y.Scale,
		height

	)

end

--------------------------------------------------
-- CÁC NÚT
--------------------------------------------------

upButton.Activated:Connect(function()
	moveJump(0, -15)
end)

downButton.Activated:Connect(function()
	moveJump(0, 15)
end)

leftButton.Activated:Connect(function()
	moveJump(-15, 0)
end)

rightButton.Activated:Connect(function()
	moveJump(15, 0)
end)

increaseButton.Activated:Connect(function()
	resizeJump(15)
end)

decreaseButton.Activated:Connect(function()
	resizeJump(-15)
end)

--------------------------------------------------
-- RESET
--------------------------------------------------

resetButton.Activated:Connect(function()

	local jump = getJumpButton()

	if not jump then
		return
	end

	if originalPosition then
		jump.Position = originalPosition
	end

	if originalSize then
		jump.Size = originalSize
	end

end)
