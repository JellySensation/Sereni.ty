local logger = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local logs = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local name = Instance.new("TextLabel")
local exit = Instance.new("TextButton")

local function MakeDraggable(topbarobject, object)
  local Dragging = nil
  local DragInput = nil
  local DragStart = nil
  local StartPosition = nil

  local function Update(input)
      local Delta = input.Position - DragStart
      local pos =
          UDim2.new(
          StartPosition.X.Scale,
          StartPosition.X.Offset + Delta.X,
          StartPosition.Y.Scale,
          StartPosition.Y.Offset + Delta.Y
      )
      local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
      Tween:Play()
  end

  topbarobject.InputBegan:Connect(
      function(input)
          if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
              Dragging = true
              DragStart = input.Position
              StartPosition = object.Position

              input.Changed:Connect(
                  function()
                      if input.UserInputState == Enum.UserInputState.End then
                          Dragging = false
                      end
                  end
              )
          end
      end
  )

  topbarobject.InputChanged:Connect(
      function(input)
          if
              input.UserInputType == Enum.UserInputType.MouseMovement or
                  input.UserInputType == Enum.UserInputType.Touch
           then
              DragInput = input
          end
      end
  )

  UserInputService.InputChanged:Connect(
      function(input)
          if input == DragInput and Dragging then
              Update(input)
          end
      end
  )
end

local function numberWithZero(num)
	return (num < 10 and "0" or "") .. num
end

local function convertTimeStamp(timeStamp)
	local localTime = math.floor(timeStamp - os.time() + tick())
	local dayTime = localTime % 86400

	local hour = math.floor(dayTime / 3600)

	dayTime = dayTime - (hour * 3600)
	local minute = math.floor(dayTime / 60)

	dayTime = dayTime - (minute * 60)

	local h = numberWithZero(hour)
	local m = numberWithZero(minute)
	local s = numberWithZero(dayTime)

	return string.format("%s:%s:%s", h, m, s)
end

function init()
  logger.Name = "logger"
  logger.Parent = game.CoreGui
  logger.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  logger.DisplayOrder = 9999999
  logger.ResetOnSpawn = false
	logger.Enabled = false

  main.Name = "main"
  main.Parent = logger
  main.AnchorPoint = Vector2.new(0.5, 0.5)
  main.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
  main.BackgroundTransparency = 0.750
  main.BorderSizePixel = 0
  main.ClipsDescendants = true
  main.Position = UDim2.new(0.513911903, 0, 0.564691663, 0)
  main.Size = UDim2.new(0, 424, 0, 255)

  UICorner.CornerRadius = UDim.new(0, 12)
  UICorner.Parent = main

  logs.Name = "logs"
  logs.Parent = main
  logs.Active = true
  logs.AnchorPoint = Vector2.new(0.5, 0.5)
  logs.BackgroundColor3 = Color3.fromRGB(163, 163, 163)
  logs.BackgroundTransparency = 0.900
  logs.BorderSizePixel = 0
  logs.Position = UDim2.new(0.5, 0, 0.544588208, 0)
  logs.Size = UDim2.new(0, 424, 0, 232)
  logs.ScrollBarThickness = 4

  UIListLayout.Parent = logs
  UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
  UIListLayout.Padding = UDim.new(0, 2)

  name.Name = "name"
  name.Parent = main
  name.AnchorPoint = Vector2.new(0.5, 0.5)
  name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  name.BackgroundTransparency = 1.000
  name.BorderSizePixel = 0
  name.Position = UDim2.new(0.154669851, 0, 0.0439803787, 0)
  name.Size = UDim2.new(0, 91, 0, 23)
  name.Font = Enum.Font.SourceSans
  name.Text = "Sereni.ty Logger"
  name.TextColor3 = Color3.fromRGB(255, 255, 255)
  name.TextSize = 14.000
  name.TextWrapped = true

  exit.Name = "exit"
  exit.Parent = main
  exit.AnchorPoint = Vector2.new(0.5, 0.5)
  exit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  exit.BackgroundTransparency = 1.000
  exit.BorderSizePixel = 0
  exit.Position = UDim2.new(0.950660229, 0, 0.0439803787, 0)
  exit.Size = UDim2.new(0, 23, 0, 23)
  exit.Font = Enum.Font.Nunito
  exit.LineHeight = 0.930
  exit.Text = "X"
  exit.TextColor3 = Color3.fromRGB(255, 255, 255)
  exit.TextSize = 14.000
  exit.MouseButton1Down:Connect(function()
    logger.Enabled = not logger.Enabled
  end)

  MakeDraggable(main,main)

  local m = {}

  function m.print(msg:string,rich:boolean?)
    local log = Instance.new("TextLabel")
    log.Name = "log"
    log.Parent = logs
    log.AnchorPoint = Vector2.new(0.5, 0.5)
    log.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    log.BackgroundTransparency = 1.000
    log.BorderSizePixel = 0
    log.Position = UDim2.new(0.5, 0, 0.0409482755, 0)
    log.Size = UDim2.new(0, 424, 0, 19)
    log.Font = Enum.Font.SourceSans
    log.TextColor3 = Color3.fromRGB(255, 255, 255)
    log.TextSize = 14.000
    log.TextXAlignment = Enum.TextXAlignment.Left
    log.Text = convertTimeStamp(os.time())..' - [LOG] '..msg
    log.RichText = rich or false
  end

  function m.warn(msg:string,rich:boolean?)
    local log = Instance.new("TextLabel")
    log.Name = "warn"
    log.Parent = logs
    log.AnchorPoint = Vector2.new(0.5, 0.5)
    log.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    log.BackgroundTransparency = 1.000
    log.BorderSizePixel = 0
    log.Position = UDim2.new(0.5, 0, 0.0409482755, 0)
    log.Size = UDim2.new(0, 424, 0, 19)
    log.Font = Enum.Font.SourceSans
    log.TextColor3 = Color3.fromRGB(255, 151, 47)
    log.TextSize = 14.000
    log.TextXAlignment = Enum.TextXAlignment.Left
    log.Text = convertTimeStamp(os.time())..' - [WARN] '..msg
    log.RichText = rich or false
  end

  function m.error(msg:string,rich:boolean?)
    local log = Instance.new("TextLabel")
    log.Name = "warn"
    log.Parent = logs
    log.AnchorPoint = Vector2.new(0.5, 0.5)
    log.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    log.BackgroundTransparency = 1.000
    log.BorderSizePixel = 0
    log.Position = UDim2.new(0.5, 0, 0.0409482755, 0)
    log.Size = UDim2.new(0, 424, 0, 19)
    log.Font = Enum.Font.SourceSans
    log.TextColor3 = Color3.fromRGB(140, 0, 0)
    log.TextSize = 14.000
    log.TextXAlignment = Enum.TextXAlignment.Left
    log.Text = convertTimeStamp(os.time())..' - [ERR] '..msg
    log.RichText = rich or false
  end

	function m:Enable()
		logger.Enabled = not logger.Enabled
	end
	
  return m
end

local mo = {}

function mo:Init()
  return init()
end

return mo
