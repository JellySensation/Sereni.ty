repeat wait() until game['IsLoaded']()

local lib = loadstring(game['HttpGet']('https://raw.githubusercontent.com/freegamerskids/Sereni.ty/main/Library.lua',true))()

_G.VERSION = 'v0.0.1'

local games = {
    [703124385] = 'toh' -- Tower Of Hell
}

local pg = games[game['GameId']]

local win = lib['Window']('Sereni.ty', Color3.new(1, 0, 0))

if pg == nil then return game.Players.LocalPlayer:Kick('not coolio') else
    loadstring(game:HttpGet('https://raw.githubusercontent.com/freegamerskids/Sereni.ty/main/games/'..pg..'.lua', true))()(win)
end