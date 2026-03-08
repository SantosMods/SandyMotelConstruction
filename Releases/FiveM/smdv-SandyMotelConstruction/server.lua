local _0xA=GetCurrentResourceName
local _0xB=GetResourceMetadata
local _0xC=PerformHttpRequest
local _0xD=Citizen
local _0xE=print

local _0x1=_0xA()
local _0x2="https://update-api.santosmods.dev/SandyMotelConstruction/latest-version"

local function _0x3()
    return _0xB(_0x1,"version",0) or "unknown"
end

local function _0x4(a)
    return
        a:match("Version:%s*(.-)\n"),
        a:match("Update Note:%s*(.-)\n"),
        a:match("Urgent:%s*(.-)\n"),
        a:match("Store:%s*(.-)\n"),
        a:match("LSPDFR:%s*(.-)$")
end

local function _0x5(a,b)
    local function c(d)
        local e={}
        for f in tostring(d):gmatch("[^%.]+") do
            e[#e+1]=tonumber(f) or 0
        end
        return e
    end
    local g,h=c(a),c(b)
    for i=1,math.max(#g,#h) do
        if (g[i] or 0)>(h[i] or 0) then return 1 end
        if (g[i] or 0)<(h[i] or 0) then return -1 end
    end
    return 0
end

local function _0x6()
    local v=_0x3()

    _0xC(_0x2,function(s,r)
        _0xE("^1====================================================^7")
        _0xE("^1[SANDY MOTEL CONSTRUCTION] VERSION VERIFICATION^7")
        _0xE("^1====================================================^7")

        if s~=200 or not r then
            _0xE("^1UPDATE CHECK FAILED — SERVER UNREACHABLE^7")
            _0xE("^3Installed Version:^7 "..v)
            _0xE("^1====================================================^7")
            return
        end

        local lv,n,u,st,ls=_0x4(r)
        if not lv then
            _0xE("^1INVALID UPDATE DATA RECEIVED^7")
            _0xE("^1====================================================^7")
            return
        end

        _0xE("^3Installed Version:^7 "..v)
        _0xE("^3Official Version:^7 "..lv)
        _0xE("^1----------------------------------------------------^7")

        local c=_0x5(v,lv)

        if c<0 then
            if u=="Yes" then
                for i=1,3 do
                    _0xE("^1!!! URGENT UPDATE REQUIRED !!!^7")
                end
            else
                _0xE("^6UPDATE AVAILABLE^7")
            end

            _0xE("^7"..(n or ""))

            if st then _0xE("^5Store:^7 "..st) end
            if ls then _0xE("^5LSPDFR:^7 "..ls) end

        elseif c>0 then
            for i=1,4 do
                _0xE("^1!!! UNOFFICIAL VERSION DETECTED !!!^7")
            end
            _0xE("^1This may not be the official version of the asset.^7")

            if st then _0xE("^5Official Store:^7 "..st) end
            if ls then _0xE("^5Official LSPDFR:^7 "..ls) end

        else
            _0xE("^2RESOURCE IS UP TO DATE AND VERIFIED.^7")
        end

        _0xE("^1====================================================^7")
    end,"GET")
end

AddEventHandler("onResourceStart",function(r)
    if r~=_0x1 then return end
    _0xD.CreateThread(function()
        _0xD.Wait(15000)
        _0x6()
    end)
end)

RegisterCommand("sandycheck",function(s)
    if s~=0 then return end
    _0x6()
end,true)
