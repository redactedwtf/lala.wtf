local got, games = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/REPO/main/list.lua"))()
end)

if got then
    local url = games[game.PlaceId]
    if url then
        loadstring(game:HttpGet(url))()
    end
end
