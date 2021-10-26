repeat wait() until game:IsLoaded()

local lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/freegamerskids/Sereni.ty/main/Library.lua',true))()

_G.VERSION = 'v0.0.1'

local games = {
    [703124385] = 'https://raw.githubusercontent.com/freegamerskids/Sereni.ty/main/games/toh.lua', -- Tower Of Hell
    [2316994223] = 'https://raw.githubusercontent.com/freegamerskids/Sereni.ty/main/games/petsimx.lua', -- Pet Simulator X
    [2533050278] = 'https://raw.githubusercontent.com/freegamerskids/Sereni.ty/main/games/testPlace.lua' -- im testing my shit
}

local pg = games[game['GameId']]

local win = lib:Window('Sereni.ty', Color3.new(1, 0, 0))

if pg == nil then return game.Players.LocalPlayer:Kick('not coolio') else
    loadstring(game:HttpGetAsync(pg, true))(win)
end