local list = loadstring(game:HttpGet("https://raw.githubusercontent.com/redactedwtf/lala.wtf/refs/heads/main/list.lua"))()
local url = list[game.PlaceId]

if url then
    loadstring(game:HttpGet(url))()
end
