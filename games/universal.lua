local ops = game:GetService("Players") -- Other plays
local p = game:GetService("Players").LocalPlayer -- Player
local char = p.Character -- Character
local hum = char:WaitForChild("Humanoid") -- Humanoid
local hrp = char:WaitForChild("HumanoidRootPart") -- HumanoidRootPart
local uis = game:GetService("UserInputService") -- UserInputService
local rep = game:GetService("ReplicatedStorage") -- ReplicatedStorage --
local ts = game:GetService("TweenService") -- Tweenservice
local rs = game:GetService("RunService") -- Runservice
local core = game:GetService("CoreGui") -- Coregui
local mouse = p:GetMouse() -- local players mouse
local cc = workspace.CurrentCamera -- players camera
local http = game:GetService("HttpService")
local tp = game:GetService("TeleportService")

local m = {}

local function makeesp(set)
    set:Toggle(
        "Esp Toggle",
        function(thing)
            esptoggle = thing
        end
    )
    set:Toggle(
        "FFA",
        function(thing)
            ffatoggle = thing
        end
    )
    set:Dropdown(
        "Esp Color",
        {"Green", "Blue", "Red", "Yellow"},
        function(thing)
            espcolor = thing
        end
    )
    local function esp(hook, name, namecheck)
        repeat
            wait()
        until hook.PrimaryPart ~= nil
        for i, v in pairs(hook:GetChildren()) do
            if v.ClassName == "Part" or v.ClassName == "MeshPart" then
                if v:FindFirstChild(name) then
                    v[name]:Destroy()
                end
                local espset = Instance.new("BoxHandleAdornment", v)
                espset.Name = name
                espset.Size = v.Size
                espset.Transparency = 0.8
                espset.AlwaysOnTop = true
                espset.Adornee = v
                espset.ZIndex = true
                spawn(
                    function()
                        while wait() do
                            if esptoggle then
                                local var = ops:FindFirstChild(namecheck)
                                if ffatoggle == false then
                                    if var.TeamColor ~= p.TeamColor then
                                        espset.Visible = true
                                    else
                                        espset.Visible = false
                                    end
                                elseif ffatoggle then
                                    espset.Visible = true
                                end
                            else
                                espset.Visible = false
                            end
                            if espcolor == "Green" then
                                espset.Color = BrickColor.new("Bright green")
                            elseif espcolor == "Blue" then
                                espset.Color = BrickColor.new("Bright blue")
                            elseif espcolor == "Red" then
                                espset.Color = BrickColor.new("Bright red")
                            elseif espcolor == "Yellow" then
                                espset.Color = BrickColor.new("Bright yellow")
                            end
                        end
                    end
                )
            end
        end
    end
    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer then
            if v.Character then
                esp(v.Character, "goneisbad", v.Name)
                print("Made ESP for" .. v.Name)
            end
            v.CharacterAdded:Connect(
                function(vcharacter)
                    esp(vcharacter, "goneisbad", v.Name)
                end
            )
        end
    end
    game.Players.PlayerAdded:Connect(
        function(player)
            player.CharacterAdded:Connect(
                function(vcharacter)
                    esp(vcharacter, "goneisbad", player.Name)
                end
            )
        end
    )
end
local function aimbot(set)
    set:Dropdown(
        "Aim Part",
        {"Head", "HumanoidRootPart"},
        function(thing)
            part = thing
        end
    )
    set:Toggle(
        "Aimbot",
        function(thing)
            aimtoggle = thing
        end
    )
    set:Toggle(
        "Smooth",
        function(thing)
            smooth = thing
        end
    )
    set:Toggle(
        "FFA",
        function(thing)
            freeforall = thing
        end
    )
    local FOV = Drawing.new("Circle")
    FOV.Position = Vector2.new(cc.ViewportSize.X / 2, cc.ViewportSize.Y / 2)
    FOV.Radius = 100
    FOV.Filled = false
    FOV.Color = Color3.fromRGB(255, 255, 255)
    FOV.Visible = false
    FOV.Transparency = 0.7
    FOV.NumSides = 64
    FOV.Thickness = 0
    set:Toggle(
        "FOV",
        function(thing)
            FOV.Visible = thing
        end
    )
    set:Slider(
        "FOV Size",
        20,
        255,
        100,
        function(thing)
            FOV.Radius = thing
        end
    )
    set:Dropdown(
        "FOV Color",
        {"Black", "White", "Green", "Blue", "Red", "Yellow"},
        function(thing)
            if espcolor == "Black" then
                FOV.Color = Color3.fromRGB(0, 0, 0)        
            elseif espcolor == "White" then
                FOV.Color = Color3.fromRGB(255, 255, 255)          
            elseif espcolor == "Green" then
                FOV.Color = Color3.fromRGB(0, 255, 0)
            elseif espcolor == "Blue" then
                FOV.Color = Color3.fromRGB(0, 0, 255)
            elseif espcolor == "Red" then
                FOV.Color = Color3.fromRGB(255, 0, 0)
            elseif espcolor == "Yellow" then
                FOV.Color = Color3.fromRGB(225, 255, 0)
            end
        end
    )
    local function GetClosest(trackpart)
        local Distance = math.huge
        local T
        for i, v in pairs(ops:GetPlayers()) do
            if v ~= p and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                if freeforall == true then
                    local TPerson = cc.WorldToViewportPoint(cc, v.Character[trackpart].Position)
                    local mag = (Vector2.new(TPerson.X, TPerson.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
                    local sp = cc:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                    local vd =
                        (Vector2.new(uis:GetMouseLocation().X, uis:GetMouseLocation().Y) - Vector2.new(sp.X, sp.Y)).Magnitude
                    if mag < Distance and vd < FOV.Radius then
                        Distance = mag
                        T = v
                    end
                elseif freeforall == false or freeforall == nil and v.TeamColor ~= p.TeamColor then
                    local TPerson = cc.WorldToViewportPoint(cc, v.Character[trackpart].Position)
                    local mag = (Vector2.new(TPerson.X, TPerson.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
                    local sp = cc:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                    local vd =
                        (Vector2.new(uis:GetMouseLocation().X, uis:GetMouseLocation().Y) - Vector2.new(sp.X, sp.Y)).Magnitude
                    if mag < Distance and vd < FOV.Radius then
                        Distance = mag
                        T = v
                    end
                end
            end
        end
        return T
    end
    uis.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                click = true
            end
        end
    )
    uis.InputEnded:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                click = false
            end
        end
    )
    rs.RenderStepped:Connect(
        function(...)
            if aimtoggle then
                local pplayer = GetClosest(part)
                if pplayer ~= nil and pplayer.Character:FindFirstChild(part) then
                    if click and smooth then
                        local TI = TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                        local tweenthing =
                            ts:Create(
                            cc,
                            TI,
                            {
                                CFrame = CFrame.new(cc.CFrame.Position, pplayer.Character[part].CFrame.Position)
                            }
                        )
                        tweenthing:Play()
                    elseif click then
                        cc.CFrame = CFrame.new(cc.CFrame.Position, pplayer.Character[part].CFrame.Position)
                    end
                end
            end
        end
    )
end

local function nameprotect(tab)
    local enabled = false
    local name = "NameProtected"
    tab:Toggle(
        "Enable",
        function(t)
            enabled = t
        end
    )

    game.ChildAdded:Connect(
        function(c)
            if c:IsA("TextLabel") or c:IsA("TextBox") then
                c.Text = c.Text:gsub(p.Name, name)
            end
        end
    )
end

function m:Init(win)
    local Library1 = win:Tab("Aimbot")
    local Library2 = win:Tab("Esp")
    local NP = win:Tab("Name Protector")
    makeesp(Library2)
    aimbot(Library1)
    nameprotect(NP)
end

return m
