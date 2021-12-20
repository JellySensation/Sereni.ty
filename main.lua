repeat wait() until game:IsLoaded()

local uis = game:GetService'UserInputService'
local lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/serenity-hub/Sereni.ty/main/Library.lua',true))()
local log = loadstring(game:HttpGet('https://raw.githubusercontent.com/serenity-hub/Sereni.ty/main/util/Logger.lua',true))():Init()
local print, warn, error = log.print, log.warn, log.error

_G.VERSION = 'v0.0.1'

uis.InputBegan:Connect(function(k)
	local kc = k.KeyCode
	if kc == Enum.KeyCode.RightControl then
		log:Enable()
	end
end)

function r(sName)
    return 'https://raw.githubusercontent.com/serenity-hub/Sereni.ty/main/games/'..sName..'.lua'
end

local games = {
    [703124385] = r('toh'), -- Tower Of Hell
    [2316994223] = r('petsimx'), -- Pet Simulator X
    [2533050278] = r('testPlace') -- im testing my shit
}

local pg = games[game['GameId']]

local win = lib:Window('Sereni.ty', Color3.new(1, 0, 0))

print'Executing scripts'
if pg ~= nil then loadstring(game:HttpGetAsync(pg, true))():Init(win) end
loadstring(game:HttpGetAsync(r('universal'), true))():Init(win)
