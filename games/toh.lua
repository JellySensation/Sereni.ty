return function(win)
    local tower = workspace.tower
    local sections = tower.sections

    local teleports = {
        finish = sections.finish['FinishGlow'].CFrame,
        floor = sections.start.floor['floor'].CFrame
    }

    local http = game:GetService("HttpService")
    local tp = game:GetService("TeleportService")



    function ServerHop()
        function RandomServer()
            local ts = {}
            local stt = http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            for i,v in pairs(stt.data) do
                if v.playing ~= v.maxPlayers then
                    table.insert(ts,v)
                end
            end
            return ts[math.random(1,#ts)]
        end
        tp:TeleportToPlaceInstance(game.PlaceId, RandomServer().id)
    end

    local im = win:Tab('AutoFarm')

    local autofarm = im:Button('AutoFarm',function ()
        print('starting')
        for i,v in pairs(sections:GetChildren()) do
            if v.start ~= nil then 
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.start.CFrame
                wait(2)
            else
                print[[skipping]]
            end
        end

        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = teleports.finish
                
        syn.queue_on_teleport(loadstring(game:HttpGetAsync('https://pastebin.com/raw/2JWbxTQp',true))())
        ServerHop()
    end)
end