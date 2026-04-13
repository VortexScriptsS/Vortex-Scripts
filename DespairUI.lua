-- Despair - A Rayfield-style UI library
-- Based on the design from Coded.lua

local Despair = {}
Despair.__index = Despair

-- Lucide Icons from GitHub
local Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/Icons.lua"))()

-- Services
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Library state
local WindowInstance = nil

-- Create Window
function Despair:CreateWindow(config)
	config = config or {}
	local Name = config.Name or "Despair"
	local Size = config.Size or UDim2.new(0, 520, 0, 320)
	local Position = config.Position or UDim2.new(0.5, -260, 0.5, -160)

	-- Check if GUI already exists and delete it
	local player = Players.LocalPlayer
	if player:WaitForChild("PlayerGui"):FindFirstChild(Name) then
		player.PlayerGui[Name]:Destroy()
	end

	-- Create ScreenGui
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = Name
	ScreenGui.Parent = player:WaitForChild("PlayerGui")
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false

	-- Create Main Frame
	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Parent = ScreenGui
	Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Main.BorderSizePixel = 0
	Main.Position = Position
	Main.Size = Size
	Main.ZIndex = 2

	-- Shadow
	local Shadow = Instance.new("Frame")
	Shadow.Name = "Shadow"
	Shadow.Parent = Main
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.BackgroundTransparency = 1.000
	Shadow.Position = UDim2.new(0.497115374, 0, 0.478125006, 6)
	Shadow.Size = UDim2.new(1.14807689, 24, 1.14374995, 24)

	local ShadowImage = Instance.new("ImageLabel")
	ShadowImage.Parent = Shadow
	ShadowImage.AnchorPoint = Vector2.new(0.5, 0.5)
	ShadowImage.BackgroundTransparency = 1.000
	ShadowImage.Position = UDim2.new(0.501610279, 0, 0.502564132, 0)
	ShadowImage.Size = UDim2.new(1.60000002, 0, 1.39999998, 0)
	ShadowImage.Image = "rbxassetid://5587865193"
	ShadowImage.ImageColor3 = Color3.fromRGB(0, 0, 0)
	ShadowImage.ImageTransparency = 0.700

	-- Header
	local Header = Instance.new("Frame")
	Header.Name = "Header"
	Header.Parent = Main
	Header.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	Header.BorderSizePixel = 0
	Header.Size = UDim2.new(1, 0, 0, 36)
	Header.ZIndex = 3
	Header.Active = true

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Parent = Header
	TitleLabel.BackgroundTransparency = 1.000
	TitleLabel.Size = UDim2.new(0.30769226, -20, 1, 0)
	TitleLabel.ZIndex = 4
	TitleLabel.Font = Enum.Font.Gotham
	TitleLabel.Text = Name
	TitleLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
	TitleLabel.TextSize = 15.000

	-- Buttons Container
	local ButtonsContainer = Instance.new("Frame")
	ButtonsContainer.Name = "ButtonsContainer"
	ButtonsContainer.Parent = Header
	ButtonsContainer.BackgroundTransparency = 1.000
	ButtonsContainer.Position = UDim2.new(1, -110, 0, 0)
	ButtonsContainer.Size = UDim2.new(0, 100, 1, 0)
	ButtonsContainer.ZIndex = 4

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = ButtonsContainer
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 8)

	local UIPadding = Instance.new("UIPadding")
	UIPadding.Parent = ButtonsContainer
	UIPadding.PaddingRight = UDim.new(0, 10)

	-- Minimize Button
	local MinimizeButton = Instance.new("ImageButton")
	MinimizeButton.Name = "MinimizeButton"
	MinimizeButton.Parent = ButtonsContainer
	MinimizeButton.BackgroundTransparency = 1.000
	MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
	MinimizeButton.ZIndex = 5
	MinimizeButton.Image = "rbxassetid://121304296213645"
	MinimizeButton.ImageColor3 = Color3.fromRGB(235, 235, 235)
	MinimizeButton.ScaleType = Enum.ScaleType.Fit

	-- Expand Button
	local ExpandButton = Instance.new("ImageButton")
	ExpandButton.Name = "ExpandButton"
	ExpandButton.Parent = ButtonsContainer
	ExpandButton.BackgroundTransparency = 1.000
	ExpandButton.Size = UDim2.new(0, 20, 0, 20)
	ExpandButton.ZIndex = 5
	ExpandButton.Image = "rbxassetid://76045941763188"
	ExpandButton.ImageColor3 = Color3.fromRGB(235, 235, 235)
	ExpandButton.ScaleType = Enum.ScaleType.Fit
	ExpandButton.Visible = false

	-- Close Button
	local CloseButton = Instance.new("ImageButton")
	CloseButton.Name = "CloseButton"
	CloseButton.Parent = ButtonsContainer
	CloseButton.BackgroundTransparency = 1.000
	CloseButton.Size = UDim2.new(0, 20, 0, 20)
	CloseButton.ZIndex = 5
	CloseButton.Image = "rbxassetid://110786993356448"
	CloseButton.ImageColor3 = Color3.fromRGB(235, 235, 235)
	CloseButton.ScaleType = Enum.ScaleType.Fit

	-- Header Line
	local HeaderLine = Instance.new("Frame")
	HeaderLine.Name = "HeaderLine"
	HeaderLine.Parent = Main
	HeaderLine.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	HeaderLine.BorderSizePixel = 0
	HeaderLine.Position = UDim2.new(0, 0, 0, 36)
	HeaderLine.Size = UDim2.new(1, 0, 0, 1)
	HeaderLine.ZIndex = 3

	-- Sidebar Divider
	local SidebarDivider = Instance.new("Frame")
	SidebarDivider.Name = "SidebarDivider"
	SidebarDivider.Parent = Main
	SidebarDivider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	SidebarDivider.BorderSizePixel = 0
	SidebarDivider.Position = UDim2.new(0, 140, 0, 0)
	SidebarDivider.Size = UDim2.new(0, 1, 0, 320)
	SidebarDivider.ZIndex = 3

	-- Tabs ScrollingFrame
	local TabsScroll = Instance.new("ScrollingFrame")
	TabsScroll.Name = "Tabs"
	TabsScroll.Parent = Main
	TabsScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabsScroll.BackgroundTransparency = 1.000
	TabsScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabsScroll.BorderSizePixel = 0
	TabsScroll.Position = UDim2.new(0, 0, 0.115625001, 0)
	TabsScroll.Size = UDim2.new(0, 140, 0, 283)
	TabsScroll.ScrollBarThickness = 0
	TabsScroll.ScrollBarImageTransparency = 1
	TabsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

	local TabsLayout = Instance.new("UIListLayout")
	TabsLayout.Parent = TabsScroll
	TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabsLayout.Padding = UDim.new(0, 0)

	local TabsPadding = Instance.new("UIPadding")
	TabsPadding.Parent = TabsScroll
	TabsPadding.PaddingTop = UDim.new(0, 5)
	TabsPadding.PaddingBottom = UDim.new(0, 5)

	-- TabContent ScrollingFrame
	local TabContentScroll = Instance.new("ScrollingFrame")
	TabContentScroll.Name = "TabContent"
	TabContentScroll.Parent = Main
	TabContentScroll.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
	TabContentScroll.BorderSizePixel = 0
	TabContentScroll.Position = UDim2.new(0, 140, 0, 37)
	TabContentScroll.Size = UDim2.new(1, -140, 0.996874988, -36)
	TabContentScroll.ZIndex = 3
	TabContentScroll.ScrollBarThickness = 4
	TabContentScroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
	TabContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

	local ContentLayout = Instance.new("UIListLayout")
	ContentLayout.Parent = TabContentScroll
	ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ContentLayout.Padding = UDim.new(0, 5)

	local ContentPadding = Instance.new("UIPadding")
	ContentPadding.Parent = TabContentScroll
	ContentPadding.PaddingTop = UDim.new(0, 10)
	ContentPadding.PaddingLeft = UDim.new(0, 8)
	ContentPadding.PaddingRight = UDim.new(0, 8)
	ContentPadding.PaddingBottom = UDim.new(0, 10)

	-- Window object
	local Window = {
		ScreenGui = ScreenGui,
		Main = Main,
		Header = Header,
		TabsScroll = TabsScroll,
		TabContentScroll = TabContentScroll,
		ContentLayout = ContentLayout,
		TabsLayout = TabsLayout,
		Tabs = {},
		CurrentTab = nil,
		isMinimized = false,
	}

	-- Dragging functionality
	local isDragging = false
	local dragOffset = Vector2.new()
	local targetPosition = Vector2.new(Main.Position.X.Offset, Main.Position.Y.Offset)

	local function startDrag(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			isDragging = true
			dragOffset = Vector2.new(input.Position.X, input.Position.Y) - Vector2.new(Main.Position.X.Offset, Main.Position.Y.Offset)
		end
	end

	local function updateDrag(input)
		if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			targetPosition = Vector2.new(input.Position.X, input.Position.Y) - dragOffset
		end
	end

	local function endDrag()
		isDragging = false
	end

	Header.InputBegan:Connect(startDrag)
	UserInputService.InputChanged:Connect(updateDrag)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			endDrag()
		end
	end)

	-- Smooth drag update loop
	game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
		if isDragging then
			local currentPosition = Vector2.new(Main.Position.X.Offset, Main.Position.Y.Offset)
			local smoothedPosition = currentPosition:Lerp(targetPosition, math.min(1, deltaTime * 20))
			Main.Position = UDim2.new(Main.Position.X.Scale, smoothedPosition.X, Main.Position.Y.Scale, smoothedPosition.Y)
		end
	end)

	-- Window controls
	MinimizeButton.MouseButton1Click:Connect(function()
		if not Window.isMinimized then
			Window.isMinimized = true
			TweenService:Create(Main, TweenInfo.new(0.3), {Size = UDim2.new(0, 520, 0, 36)}):Play()
			TweenService:Create(SidebarDivider, TweenInfo.new(0.3), {Size = UDim2.new(0, 1, 0, 36)}):Play()
			TabContentScroll.Visible = false
			TabsScroll.Visible = false
			ExpandButton.Visible = true
			MinimizeButton.Visible = false
		end
	end)

	ExpandButton.MouseButton1Click:Connect(function()
		if Window.isMinimized then
			Window.isMinimized = false
			TweenService:Create(Main, TweenInfo.new(0.3), {Size = Size}):Play()
			TweenService:Create(SidebarDivider, TweenInfo.new(0.3), {Size = UDim2.new(0, 1, 0, 320)}):Play()
			TabContentScroll.Visible = true
			TabsScroll.Visible = true
			ExpandButton.Visible = false
			MinimizeButton.Visible = true
		end
	end)

	CloseButton.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)

	WindowInstance = Window

	-- CreateTab method
	function Window:CreateTab(name, icon)
		local tabName = name or "Tab"
		local tabIcon = icon or nil

		-- Create tab button
		local TabButton = Instance.new("TextButton")
		TabButton.Name = tabName
		TabButton.Parent = TabsScroll
		TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.BackgroundTransparency = 1.000
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.Size = UDim2.new(0, 140, 0, 36)
		TabButton.Font = Enum.Font.Gotham
		TabButton.Text = tabName
		TabButton.TextColor3 = Color3.fromRGB(235, 235, 235)
		TabButton.TextSize = 15.000
		TabButton.AutoButtonColor = false

		-- Create tab content container
		local TabContent = Instance.new("Frame")
		TabContent.Name = tabName .. "Content"
		TabContent.Parent = TabContentScroll
		TabContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabContent.BackgroundTransparency = 1.000
		TabContent.Size = UDim2.new(1, 0, 0, 0)
		TabContent.Visible = false
		TabContent.LayoutOrder = #Window.Tabs + 1

		local TabLayout = Instance.new("UIListLayout")
		TabLayout.Parent = TabContent
		TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
		TabLayout.Padding = UDim.new(0, 5)

		-- Tab object
		local Tab = {
			Name = tabName,
			Button = TabButton,
			Content = TabContent,
			Layout = TabLayout,
			Window = Window,
			Elements = {},
		}

		-- Tab switching
		TabButton.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				Window:SwitchTab(Tab)
			end
		end)

		-- Store tab
		table.insert(Window.Tabs, Tab)

		-- Switch to this tab if it's the first one
		if #Window.Tabs == 1 then
			Window:SwitchTab(Tab)
		end

		-- Element creation methods
		function Tab:CreateButton(config)
			config = config or {}
			local Name = config.Name or "Button"
			local Callback = config.Callback or function() end
			local Icon = config.Icon or nil

			local Button = Instance.new("Frame")
			Button.Name = Name
			Button.Parent = TabContent
			Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Button.BorderSizePixel = 0
			Button.Size = UDim2.new(1, 0, 0, 30)
			Button.LayoutOrder = #Tab.Elements + 1

			local ButtonLabel = Instance.new("TextLabel")
			ButtonLabel.Parent = Button
			ButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonLabel.BackgroundTransparency = 1.000
			ButtonLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ButtonLabel.BorderSizePixel = 0
			ButtonLabel.Position = UDim2.new(0, 0, 0, 0)
			ButtonLabel.Size = UDim2.new(1, 0, 1, 0)
			ButtonLabel.Font = Enum.Font.Gotham
			ButtonLabel.Text = Name
			ButtonLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
			ButtonLabel.TextSize = 14.000
			ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
			ButtonLabel.Padding = {
				Left = 10,
				Right = 10,
			}

			if Icon then
				local IconImage = Instance.new("ImageLabel")
				IconImage.Parent = Button
				IconImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				IconImage.BackgroundTransparency = 1.000
				IconImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
				IconImage.BorderSizePixel = 0
				IconImage.Position = UDim2.new(1, -30, 0, 0)
				IconImage.Size = UDim2.new(0, 30, 0, 30)
				IconImage.Image = Icons[Icon] or Icon
				IconImage.ImageColor3 = Color3.fromRGB(235, 235, 235)
			end

			Button.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
					task.wait(0.1)
					TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
					Callback()
				end
			end)

			table.insert(Tab.Elements, {Type = "Button", Instance = Button})
			return Button
		end

		function Tab:CreateToggle(config)
			config = config or {}
			local Name = config.Name or "Toggle"
			local CurrentValue = config.CurrentValue or false
			local Callback = config.Callback or function(value) end
			local Flag = config.Flag or nil

			local Toggle = Instance.new("Frame")
			Toggle.Name = Name
			Toggle.Parent = TabContent
			Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.BorderSizePixel = 0
			Toggle.Size = UDim2.new(1, 0, 0, 30)
			Toggle.LayoutOrder = #Tab.Elements + 1

			local ToggleLabel = Instance.new("TextLabel")
			ToggleLabel.Parent = Toggle
			ToggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleLabel.BackgroundTransparency = 1.000
			ToggleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleLabel.BorderSizePixel = 0
			ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
			ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
			ToggleLabel.Font = Enum.Font.Gotham
			ToggleLabel.Text = Name
			ToggleLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
			ToggleLabel.TextSize = 14.000
			ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
			ToggleLabel.Padding = {
				Left = 10,
				Right = 10,
			}

			local Switch = Instance.new("Frame")
			Switch.Name = "Switch"
			Switch.Parent = Toggle
			Switch.AnchorPoint = Vector2.new(1, 0.5)
			Switch.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
			Switch.BorderSizePixel = 0
			Switch.Position = UDim2.new(1, -10, 0.5, 0)
			Switch.Size = UDim2.new(0, 48, 0, 24)
			Switch.ZIndex = 5

			local SwitchCorner = Instance.new("UICorner")
			SwitchCorner.CornerRadius = UDim.new(1, 0)
			SwitchCorner.Parent = Switch

			local Indicator = Instance.new("Frame")
			Indicator.Name = "Indicator"
			Indicator.Parent = Switch
			Indicator.AnchorPoint = Vector2.new(0, 0.5)
			Indicator.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
			Indicator.BorderSizePixel = 0
			Indicator.Position = UDim2.new(0, 2, 0.5, 0)
			Indicator.Size = UDim2.new(0, 20, 0, 20)
			Indicator.ZIndex = 6

			local IndicatorCorner = Instance.new("UICorner")
			IndicatorCorner.CornerRadius = UDim.new(1, 0)
			IndicatorCorner.Parent = Indicator

			local toggleState = CurrentValue

			local function updateToggle()
				if toggleState then
					TweenService:Create(Indicator, TweenInfo.new(0.2), {Position = UDim2.new(0.583, 0, 0.5, 0)}):Play()
					TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(218, 218, 254)}):Play()
				else
					TweenService:Create(Indicator, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, 0)}):Play()
					TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
				end
			end

			-- Initialize state
			updateToggle()

			Toggle.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					toggleState = not toggleState
					updateToggle()
					Callback(toggleState)
				end
			end)

			local ToggleObj = {
				Instance = Toggle,
				Set = function(value)
					toggleState = value
					updateToggle()
					Callback(toggleState)
				end
			}

			table.insert(Tab.Elements, {Type = "Toggle", Instance = Toggle, Object = ToggleObj})
			return ToggleObj
		end

		function Tab:CreateSlider(config)
			config = config or {}
			local Name = config.Name or "Slider"
			local Range = config.Range or {0, 100}
			local Increment = config.Increment or 1
			local CurrentValue = config.CurrentValue or Range[1]
			local Callback = config.Callback or function(value) end
			local Flag = config.Flag or nil
			local Suffix = config.Suffix or ""

			local Slider = Instance.new("Frame")
			Slider.Name = Name
			Slider.Parent = TabContent
			Slider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Slider.BorderSizePixel = 0
			Slider.Size = UDim2.new(1, 0, 0, 49)
			Slider.LayoutOrder = #Tab.Elements + 1

			local SliderLabel = Instance.new("TextLabel")
			SliderLabel.Parent = Slider
			SliderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderLabel.BackgroundTransparency = 1.000
			SliderLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderLabel.BorderSizePixel = 0
			SliderLabel.Position = UDim2.new(0, 0, 0, 0)
			SliderLabel.Size = UDim2.new(1, 0, 0, 30)
			SliderLabel.Font = Enum.Font.Gotham
			SliderLabel.Text = Name
			SliderLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
			SliderLabel.TextSize = 14.000
			SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
			SliderLabel.Padding = {
				Left = 10,
				Right = 10,
			}

			local SliderFill = Instance.new("Frame")
			SliderFill.Name = "SliderFill"
			SliderFill.Parent = Slider
			SliderFill.BackgroundColor3 = Color3.fromRGB(218, 218, 254)
			SliderFill.BackgroundTransparency = 0.500
			SliderFill.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderFill.BorderSizePixel = 0
			SliderFill.Position = UDim2.new(0.0245231614, 0, 0.706122577, 0)
			SliderFill.Size = UDim2.new(0, 0, 0, 5)

			local FillCorner = Instance.new("UICorner")
			FillCorner.CornerRadius = UDim.new(1, 0)
			FillCorner.Parent = SliderFill

			local SliderTrack = Instance.new("Frame")
			SliderTrack.Name = "Slider"
			SliderTrack.Parent = Slider
			SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
			SliderTrack.BackgroundTransparency = 0.500
			SliderTrack.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderTrack.BorderSizePixel = 0
			SliderTrack.Position = UDim2.new(0.0245231614, 0, 0.706122577, 0)
			SliderTrack.Size = UDim2.new(0.95, 0, 0, 5)

			local TrackCorner = Instance.new("UICorner")
			TrackCorner.CornerRadius = UDim.new(1, 0)
			TrackCorner.Parent = SliderTrack

			local SliderHandle = Instance.new("Frame")
			SliderHandle.Parent = SliderTrack
			SliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderHandle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderHandle.BorderSizePixel = 0
			SliderHandle.Position = UDim2.new(0, -5.5, -0.8, 0)
			SliderHandle.Size = UDim2.new(0, 11, 0, 12)
			SliderHandle.ZIndex = 2

			local HandleCorner = Instance.new("UICorner")
			HandleCorner.CornerRadius = UDim.new(10, 8)
			HandleCorner.Parent = SliderHandle

			local SliderValue = Instance.new("TextBox")
			SliderValue.Name = "SliderValue"
			SliderValue.Parent = Slider
			SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderValue.BackgroundTransparency = 1.000
			SliderValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderValue.BorderSizePixel = 0
			SliderValue.Position = UDim2.new(0.5, 0, -7, 0)
			SliderValue.Size = UDim2.new(0, 100, 0, 30)
			SliderValue.AnchorPoint = Vector2.new(0.5, 0)
			SliderValue.Font = Enum.Font.Gotham
			SliderValue.Text = tostring(CurrentValue) .. Suffix
			SliderValue.TextColor3 = Color3.fromRGB(235, 235, 235)
			SliderValue.TextSize = 14.000
			SliderValue.ClearTextOnFocus = false

			local sliderValue = CurrentValue
			local isSliderDragging = false

			local function updateSlider(value)
				sliderValue = math.clamp(value, Range[1], Range[2])
				sliderValue = math.floor(sliderValue / Increment) * Increment
				local trackWidth = SliderTrack.AbsoluteSize.X
				local percentage = (sliderValue - Range[1]) / (Range[2] - Range[1])
				local fillWidth = percentage * trackWidth
				SliderFill.Size = UDim2.new(0, fillWidth, 0, 5)
				SliderHandle.Position = UDim2.new(percentage, -5.5, -0.8, 0)
				SliderValue.Text = tostring(sliderValue) .. Suffix
				Callback(sliderValue)
			end

			SliderTrack.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					isSliderDragging = true
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					isSliderDragging = false
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if isSliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					local relativeX = input.Position.X - SliderTrack.AbsolutePosition.X
					local percentage = math.clamp(relativeX / SliderTrack.AbsoluteSize.X, 0, 1)
					updateSlider(Range[1] + percentage * (Range[2] - Range[1]))
				end
			end)

			SliderValue.FocusLost:Connect(function(enterPressed)
				if enterPressed then
					local inputValue = tonumber(SliderValue.Text)
					if inputValue then
						updateSlider(inputValue)
					else
						SliderValue.Text = tostring(sliderValue) .. Suffix
					end
				else
					SliderValue.Text = tostring(sliderValue) .. Suffix
				end
			end)

			-- Initialize
			updateSlider(CurrentValue)

			local SliderObj = {
				Instance = Slider,
				Set = function(value)
					updateSlider(value)
				end
			}

			table.insert(Tab.Elements, {Type = "Slider", Instance = Slider, Object = SliderObj})
			return SliderObj
		end

		function Tab:CreateDropdown(config)
			config = config or {}
			local Name = config.Name or "Dropdown"
			local Options = config.Options or {}
			local CurrentOption = config.CurrentOption or (Options[1] or "")
			local Callback = config.Callback or function(option) end
			local Flag = config.Flag or nil

			local Dropdown = Instance.new("Frame")
			Dropdown.Name = Name
			Dropdown.Parent = TabContent
			Dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.BorderSizePixel = 0
			Dropdown.Size = UDim2.new(1, 0, 0, 30)
			Dropdown.LayoutOrder = #Tab.Elements + 1
			Dropdown.AutomaticSize = Enum.AutomaticSize.Y

			local DropdownLabel = Instance.new("TextLabel")
			DropdownLabel.Parent = Dropdown
			DropdownLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropdownLabel.BackgroundTransparency = 1.000
			DropdownLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropdownLabel.BorderSizePixel = 0
			DropdownLabel.Position = UDim2.new(0, 0, 0, 0)
			DropdownLabel.Size = UDim2.new(0.5, 0, 1, 0)
			DropdownLabel.Font = Enum.Font.Gotham
			DropdownLabel.Text = Name
			DropdownLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
			DropdownLabel.TextSize = 14.000
			DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
			DropdownLabel.Padding = {
				Left = 10,
				Right = 10,
			}

			local DropdownButton = Instance.new("TextButton")
			DropdownButton.Parent = Dropdown
			DropdownButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropdownButton.BackgroundTransparency = 1.000
			DropdownButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropdownButton.BorderSizePixel = 0
			DropdownButton.Position = UDim2.new(0.5, 0, 0, 0)
			DropdownButton.Size = UDim2.new(0.5, 0, 1, 0)
			DropdownButton.Font = Enum.Font.Gotham
			DropdownButton.Text = CurrentOption
			DropdownButton.TextColor3 = Color3.fromRGB(235, 235, 235)
			DropdownButton.TextSize = 14.000
			DropdownButton.TextXAlignment = Enum.TextXAlignment.Right
			DropdownButton.AutoButtonColor = false

			local isDropdownOpen = false
			local optionButtons = {}

			local function toggleDropdown(open)
				isDropdownOpen = open
				local targetHeight = open and (#Options + 1) * 30 or 30
				TweenService:Create(Dropdown, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()

				for i, btn in ipairs(optionButtons) do
					btn.Visible = open
				end
			end

			local function createOptionButtons()
				for _, btn in pairs(optionButtons) do
					if btn then
						btn:Destroy()
					end
				end
				optionButtons = {}

				for i, option in ipairs(Options) do
					local optionBtn = Instance.new("TextButton")
					optionBtn.Name = "Option" .. i
					optionBtn.Parent = Dropdown
					optionBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
					optionBtn.BackgroundTransparency = 0.5
					optionBtn.BorderSizePixel = 0
					optionBtn.Position = UDim2.new(0, 0, 0, i * 30)
					optionBtn.Size = UDim2.new(1, 0, 0, 30)
					optionBtn.Font = Enum.Font.Gotham
					optionBtn.Text = option
					optionBtn.TextColor3 = Color3.fromRGB(235, 235, 235)
					optionBtn.TextSize = 14
					optionBtn.Visible = false
					optionBtn.ZIndex = 11
					optionBtn.AutoButtonColor = false

					optionBtn.MouseButton1Click:Connect(function()
						DropdownButton.Text = option
						toggleDropdown(false)
						Callback(option)
					end)

					optionBtn.MouseEnter:Connect(function()
						optionBtn.BackgroundTransparency = 0
					end)

					optionBtn.MouseLeave:Connect(function()
						optionBtn.BackgroundTransparency = 0.5
					end)

					table.insert(optionButtons, optionBtn)
				end
			end

			createOptionButtons()

			DropdownButton.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					toggleDropdown(not isDropdownOpen)
				end
			end)

			local DropdownObj = {
				Instance = Dropdown,
				Refresh = function(newOptions)
					Options = newOptions or Options
					createOptionButtons()
				end,
				Set = function(option)
					DropdownButton.Text = option
					Callback(option)
				end
			}

			table.insert(Tab.Elements, {Type = "Dropdown", Instance = Dropdown, Object = DropdownObj})
			return DropdownObj
		end

		function Tab:CreateLabel(config)
			config = config or {}
			local Name = config.Name or "Label"

			local Label = Instance.new("Frame")
			Label.Name = Name
			Label.Parent = TabContent
			Label.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Label.BorderSizePixel = 0
			Label.Size = UDim2.new(1, 0, 0, 30)
			Label.LayoutOrder = #Tab.Elements + 1

			local LabelText = Instance.new("TextLabel")
			LabelText.Parent = Label
			LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			LabelText.BackgroundTransparency = 1.000
			LabelText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LabelText.BorderSizePixel = 0
			LabelText.Position = UDim2.new(0, 0, 0, 0)
			LabelText.Size = UDim2.new(1, 0, 1, 0)
			LabelText.Font = Enum.Font.Gotham
			LabelText.Text = Name
			LabelText.TextColor3 = Color3.fromRGB(235, 235, 235)
			LabelText.TextSize = 14.000
			LabelText.TextXAlignment = Enum.TextXAlignment.Left
			LabelText.Padding = {
				Left = 10,
				Right = 10,
			}

			table.insert(Tab.Elements, {Type = "Label", Instance = Label})
			return Label
		end

		function Tab:CreateSection(name)
			local Section = Instance.new("Frame")
			Section.Name = name or "Section"
			Section.Parent = TabContent
			Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Section.BackgroundTransparency = 1.000
			Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Section.BorderSizePixel = 0
			Section.Size = UDim2.new(1, 0, 0, 25)
			Section.LayoutOrder = #Tab.Elements + 1

			local SectionText = Instance.new("TextLabel")
			SectionText.Parent = Section
			SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionText.BackgroundTransparency = 1.000
			SectionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionText.BorderSizePixel = 0
			SectionText.Position = UDim2.new(0.5, 0, 0, 0)
			SectionText.Size = UDim2.new(0, 200, 0, 15)
			SectionText.AnchorPoint = Vector2.new(0.5, 0)
			SectionText.Font = Enum.Font.Gotham
			SectionText.Text = name or "Section"
			SectionText.TextColor3 = Color3.fromRGB(235, 235, 235)
			SectionText.TextSize = 14.000
			SectionText.BackgroundTransparency = 1.000

			table.insert(Tab.Elements, {Type = "Section", Instance = Section})
			return Section
		end

		function Tab:CreateDivider()
			local Divider = Instance.new("Frame")
			Divider.Name = "Divider"
			Divider.Parent = TabContent
			Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Divider.BackgroundTransparency = 0.500
			Divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Divider.BorderSizePixel = 0
			Divider.Size = UDim2.new(1, 0, 0, 2)
			Divider.LayoutOrder = #Tab.Elements + 1

			local DividerCorner = Instance.new("UICorner")
			DividerCorner.CornerRadius = UDim.new(1, 0)
			DividerCorner.Parent = Divider

			table.insert(Tab.Elements, {Type = "Divider", Instance = Divider})
			return Divider
		end

		return Tab
	end

	-- SwitchTab method
	function Window:SwitchTab(tab)
		if Window.CurrentTab then
			Window.CurrentTab.Button.TextColor3 = Color3.fromRGB(235, 235, 235)
			Window.CurrentTab.Content.Visible = false
		end

		tab.Button.TextColor3 = Color3.fromRGB(218, 218, 254)
		tab.Content.Visible = true
		Window.CurrentTab = tab
	end

	return Window
end

return Despair
