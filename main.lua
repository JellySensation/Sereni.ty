repeat wait() until game:IsLoaded()

local lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/freegamerskids/Sereni.ty/main/Library.lua',true))()

_G.VERSION = 'v0.0.1'

function r(sName)
    return 'https://raw.githubusercontent.com/freegamerskids/Sereni.ty/main/games/'..sName..'.lua'
end

local games = {
    [703124385] = r('toh'), -- Tower Of Hell
    [2316994223] = r('petsimx'), -- Pet Simulator X
    [2533050278] = r('testPlace') -- im testing my shit
}

local pg = games[game['GameId']]

local win = lib:Window('Sereni.ty', Color3.new(1, 0, 0))

if pg == nil then 
    loadstring(game:HttpGetAsync(r('universal'), true))():Init(win)
else
    loadstring(game:HttpGetAsync(pg, true))():Init(win)
    loadstring(game:HttpGetAsync(r('universal'), true))():Init(win)
end
