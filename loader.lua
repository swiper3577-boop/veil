-------------------------------------------------------------------------------
--! json library 
--! cryptography library 
local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end; 
local lEncode, lDecode, lDigest = a3, aw, Z; 
------------------------------------------------------------------------------- 
 
------------------------------------------------------------------------------- 
--! platoboost library 
 
--! configuration 
local service = 11551;
local secret = "f82a5131-68cc-4978-9c3f-791ad940dd98";
local useNonce = true;
 
--! callbacks 
local onMessage = function(message) end; 
 
--! wait for game to load 
repeat task.wait(1) until game:IsLoaded(); 
 
--! functions 
local requestSending = false; 
local fSetClipboard, fRequest, fStringChar, fToString, fStringSub, fOsTime, fMathRandom, fMathFloor, fGetHwid = setclipboard or toclipboard, request or http_request or syn_request, string.char, tostring, string.sub, os.time, math.random, math.floor, gethwid or function() return game:GetService("Players").LocalPlayer.UserId end 
local cachedLink, cachedTime = "", 0; 
 
--! pick host 
local host = "https://api.platoboost.app"; 
local hostResponse = fRequest({ 
    Url = host .. "/public/connectivity", 
    Method = "GET" 
}); 
if hostResponse.StatusCode ~= 200 or hostResponse.StatusCode ~= 429 then 
    host = "https://api.platoboost.net"; 
end 
 
--!optimize 2 
function cacheLink() 
    if cachedTime + (10*60) < fOsTime() then 
        local response = fRequest({ 
            Url = host .. "/public/start", 
            Method = "POST", 
            Body = lEncode({ 
                service = service, 
                identifier = lDigest(fGetHwid()) 
            }), 
            Headers = { 
                ["Content-Type"] = "application/json" 
            } 
        }); 
 
        if response.StatusCode == 200 then 
            local decoded = lDecode(response.Body); 
 
            if decoded.success == true then 
                cachedLink = decoded.data.url; 
                cachedTime = fOsTime(); 
                return true, cachedLink; 
            else 
                onMessage(decoded.message); 
                return false, decoded.message; 
            end 
        elseif response.StatusCode == 429 then 
            local msg = "you are being rate limited, please wait 20 seconds and try again."; 
            onMessage(msg); 
            return false, msg; 
        end 
 
        local msg = "Failed to cache link."; 
        onMessage(msg); 
        return false, msg; 
    else 
        return true, cachedLink; 
    end 
end 
 
cacheLink(); 
 
--!optimize 2 
local generateNonce = function() 
    local str = "" 
    for _ = 1, 16 do 
        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97) 
    end 
    return str 
end 
 
--!optimize 1 
for _ = 1, 5 do 
    local oNonce = generateNonce(); 
    task.wait(0.2) 
    if generateNonce() == oNonce then 
        local msg = "platoboost nonce error."; 
        onMessage(msg); 
        error(msg); 
    end 
end 
 
--!optimize 2 
local copyLink = function() 
    local success, link = cacheLink(); 
     
    if success then 
        fSetClipboard(link); 
    end 
end 
 
--!optimize 2 
local redeemKey = function(key) 
    local nonce = generateNonce(); 
    local endpoint = host .. "/public/redeem/" .. fToString(service); 
 
    local body = { 
        identifier = lDigest(fGetHwid()), 
        key = key 
    } 
 
    if useNonce then 
        body.nonce = nonce; 
    end 
 
    local response = fRequest({ 
        Url = endpoint, 
        Method = "POST", 
        Body = lEncode(body), 
        Headers = { 
            ["Content-Type"] = "application/json" 
        } 
    }); 
 
    if response.StatusCode == 200 then 
        local decoded = lDecode(response.Body); 
 
        if decoded.success == true then 
            if decoded.data.valid == true then 
                if useNonce then 
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then 
                        return true; 
                    else 
                        onMessage("failed to verify integrity."); 
                        return false; 
                    end     
                else 
                    return true; 
                end 
            else 
                onMessage("key is invalid."); 
                return false; 
            end 
        else 
            if fStringSub(decoded.message, 1, 27) == "unique constraint violation" then 
                onMessage("you already have an active key, please wait for it to expire before redeeming it."); 
                return false; 
            else 
                onMessage(decoded.message); 
                return false; 
            end 
        end 
    elseif response.StatusCode == 429 then 
        onMessage("you are being rate limited, please wait 20 seconds and try again."); 
        return false; 
    else 
        onMessage("server returned an invalid status code, please try again later."); 
        return false;  
    end 
end 
 
--!optimize 2 
local verifyKey = function(key) 
    if requestSending == true then 
        onMessage("a request is already being sent, please slow down."); 
        return false; 
    else 
        requestSending = true; 
    end 
 
    local nonce = generateNonce(); 
    local endpoint = host .. "/public/whitelist/" .. fToString(service) .. "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key; 
 
    if useNonce then 
        endpoint = endpoint .. "&nonce=" .. nonce; 
    end 
 
    local response = fRequest({ 
        Url = endpoint, 
        Method = "GET", 
    }); 
 
    requestSending = false; 
 
    if response.StatusCode == 200 then 
        local decoded = lDecode(response.Body); 
 
        if decoded.success == true then 
            if decoded.data.valid == true then 
                if useNonce then 
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then 
                        return true; 
                    else 
                        onMessage("failed to verify integrity."); 
                        return false; 
                    end 
                else 
                    return true; 
                end 
            else 
                if fStringSub(key, 1, 4) == "KEY_" then 
                    return redeemKey(key); 
                else 
                    onMessage("key is invalid."); 
                    return false; 
                end 
            end 
        else 
            onMessage(decoded.message); 
            return false; 
        end 
    elseif response.StatusCode == 429 then 
        onMessage("you are being rate limited, please wait 20 seconds and try again."); 
        return false; 
    else 
        onMessage("server returned an invalid status code, please try again later."); 
        return false; 
    end 
end 
 
--!optimize 2 
local getFlag = function(name) 
    local nonce = generateNonce(); 
    local endpoint = host .. "/public/flag/" .. fToString(service) .. "?name=" .. name; 
 
    if useNonce then 
        endpoint = endpoint .. "&nonce=" .. nonce; 
    end 
 
    local response = fRequest({ 
        Url = endpoint, 
        Method = "GET", 
    }); 
 
    if response.StatusCode == 200 then 
        local decoded = lDecode(response.Body); 
 
        if decoded.success == true then 
            if useNonce then 
                if decoded.data.hash == lDigest(fToString(decoded.data.value) .. "-" .. nonce .. "-" .. secret) then 
                    return decoded.data.value; 
                else 
                    onMessage("failed to verify integrity."); 
                    return nil; 
                end 
            else 
                return decoded.data.value; 
            end 
        else 
            onMessage(decoded.message); 
            return nil; 
        end 
    else 
        return nil; 
    end 
end 
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--! Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--! Configuration
local keyVerified = false

--! Platoboost Callback - Using StarterGui instead to avoid Rayfield errors
onMessage = function(message)
    Rayfield:Notify({
        Title = "Key System",
        Content = message,
        Duration = 5,
        Image = 0
    })
end

--! Create Key System Window
local KeyWindow = Rayfield:CreateWindow({
    Name = "Key System - Your Script",
    Icon = 0,
    LoadingTitle = "Loading Key System",
    LoadingSubtitle = "by Platoboost",
    Theme = "Default",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

local KeyTab = KeyWindow:CreateTab("Key System", 4483362458)
local KeySection = KeyTab:CreateSection("Authentication Required")

KeyTab:CreateParagraph({
    Title = "How to Get a Key",
    Content = "1. Click 'Get Key' button below\n2. Complete tasks in your browser\n3. Copy the key you receive\n4. Paste it below and click Verify"
})

--! Key Input
local KeyInput = KeyTab:CreateInput({
    Name = "Enter Key",
    PlaceholderText = "Paste your key here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        -- Key is stored in the input box
    end
})

--! Copy Link Button
KeyTab:CreateButton({
    Name = "Get Key (Copy Link)",
    Callback = function()
        copyLink()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Link Copied!",
            Text = "Paste in browser to get your key!",
            Duration = 6
        })
    end
})

--! Verify Key Button
KeyTab:CreateButton({
    Name = "Verify Key",
    Callback = function()
        local key = KeyInput.CurrentValue or ""
        
        if key == "" then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Error",
                Text = "Please enter a key first!",
                Duration = 3
            })
            return
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Verifying",
            Text = "Please wait while we verify your key...",
            Duration = 3
        })
        
        task.spawn(function()
            local success = verifyKey(key)
            
            if success then
                keyVerified = true
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Success!",
                    Text = "Key verified! Loading script...",
                    Duration = 2
                })
                
                task.wait(1)
                Rayfield:Destroy()
                task.wait(0.5)
                loadMainScript()
            else
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Failed",
                    Text = "Invalid key. Please try again.",
                    Duration = 5
                })
            end
        end)
    end
})

KeyTab:CreateSection("Information")

KeyTab:CreateParagraph({
    Title = "Need Help?",
    Content = "If you're having issues:\n• Make sure you completed all tasks\n• Try getting a new key\n• Check your internet connection\n• Wait 20s if rate limited"
})

--! Main Script Function (Loads after successful verification)
function loadMainScript()
    local MainWindow = Rayfield:CreateWindow({
        Name = "Your Script Hub",
        Icon = 0,
        LoadingTitle = "Script Loaded Successfully",
        LoadingSubtitle = "Welcome!",
        Theme = "Default",
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false,
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "YourScriptHub",
            FileName = "Config"
        },
        Discord = {
            Enabled = false
        },
        KeySystem = false
    })
    
    --! Main Tab
    local MainTab = MainWindow:CreateTab("Home", 4483362458)
    local MainSection = MainTab:CreateSection("Main Features")
    
    MainTab:CreateButton({
        Name = "Feature 1",
        Callback = function()
            Rayfield:Notify({
                Title = "Feature 1",
                Content = "Feature 1 activated!",
                Duration = 3,
                Image = 0
            })
            -- Add your feature 1 code here
        end
    })
    
    MainTab:CreateButton({
        Name = "Feature 2",
        Callback = function()
            Rayfield:Notify({
                Title = "Feature 2",
                Content = "Feature 2 activated!",
                Duration = 3,
                Image = 0
            })
            -- Add your feature 2 code here
        end
    })
    
    MainTab:CreateToggle({
        Name = "Auto Farm",
        CurrentValue = false,
        Flag = "AutoFarm",
        Callback = function(value)
            if value then
                Rayfield:Notify({
                    Title = "Auto Farm",
                    Content = "Auto Farm enabled!",
                    Duration = 3,
                    Image = 0
                })
                -- Start auto farm
            else
                Rayfield:Notify({
                    Title = "Auto Farm",
                    Content = "Auto Farm disabled!",
                    Duration = 3,
                    Image = 0
                })
                -- Stop auto farm
            end
        end
    })
    
    MainTab:CreateSlider({
        Name = "Walk Speed",
        Range = {16, 200},
        Increment = 1,
        CurrentValue = 16,
        Flag = "WalkSpeed",
        Callback = function(value)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    })
    
    --! Player Tab
    local PlayerTab = MainWindow:CreateTab("Player", 4483362458)
    local PlayerSection = PlayerTab:CreateSection("Player Modifications")
    
    PlayerTab:CreateSlider({
        Name = "Jump Power",
        Range = {50, 300},
        Increment = 10,
        CurrentValue = 50,
        Flag = "JumpPower",
        Callback = function(value)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
        end
    })
    
    PlayerTab:CreateToggle({
        Name = "Infinite Jump",
        CurrentValue = false,
        Flag = "InfiniteJump",
        Callback = function(value)
            local InfiniteJumpEnabled = value
            game:GetService("UserInputService").JumpRequest:Connect(function()
                if InfiniteJumpEnabled then
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                end
            end)
        end
    })
    
    PlayerTab:CreateButton({
        Name = "Reset Character",
        Callback = function()
            game.Players.LocalPlayer.Character.Humanoid.Health = 0
            Rayfield:Notify({
                Title = "Reset",
                Content = "Character reset!",
                Duration = 2,
                Image = 0
            })
        end
    })
    
    --! ESP/Visual Tab
    local VisualTab = MainWindow:CreateTab("Visuals", 4483362458)
    local VisualSection = VisualTab:CreateSection("ESP & Visual Features")
    
    VisualTab:CreateToggle({
        Name = "Player ESP",
        CurrentValue = false,
        Flag = "PlayerESP",
        Callback = function(value)
            -- Add your ESP code here
            if value then
                Rayfield:Notify({
                    Title = "ESP",
                    Content = "Player ESP enabled!",
                    Duration = 3,
                    Image = 0
                })
            else
                Rayfield:Notify({
                    Title = "ESP",
                    Content = "Player ESP disabled!",
                    Duration = 3,
                    Image = 0
                })
            end
        end
    })
    
    VisualTab:CreateToggle({
        Name = "Fullbright",
        CurrentValue = false,
        Flag = "Fullbright",
        Callback = function(value)
            if value then
                game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
                game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
                game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
            else
                game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
                game:GetService("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
                game:GetService("Lighting").ColorShift_Top = Color3.new(0, 0, 0)
            end
        end
    })
    
    VisualTab:CreateSlider({
        Name = "FOV",
        Range = {70, 120},
        Increment = 1,
        CurrentValue = 70,
        Flag = "FOV",
        Callback = function(value)
            game:GetService("Workspace").CurrentCamera.FieldOfView = value
        end
    })
    
    --! Teleport Tab
    local TeleportTab = MainWindow:CreateTab("Teleport", 4483362458)
    local TeleportSection = TeleportTab:CreateSection("Teleportation")
    
    TeleportTab:CreateButton({
        Name = "Teleport to Spawn",
        Callback = function()
            local spawnLocation = game:GetService("Workspace"):FindFirstChild("SpawnLocation")
            if spawnLocation then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawnLocation.CFrame
                Rayfield:Notify({
                    Title = "Teleported",
                    Content = "Teleported to spawn!",
                    Duration = 2,
                    Image = 0
                })
            end
        end
    })
    
    TeleportTab:CreateInput({
        Name = "Teleport to Player",
        PlaceholderText = "Enter player name...",
        RemoveTextAfterFocusLost = true,
        Callback = function(text)
            local targetPlayer = game.Players:FindFirstChild(text)
            if targetPlayer and targetPlayer.Character then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                Rayfield:Notify({
                    Title = "Teleported",
                    Content = "Teleported to " .. text,
                    Duration = 2,
                    Image = 0
                })
            else
                Rayfield:Notify({
                    Title = "Error",
                    Content = "Player not found!",
                    Duration = 3,
                    Image = 0
                })
            end
        end
    })
    
    --! Misc Tab
    local MiscTab = MainWindow:CreateTab("Misc", 4483362458)
    local MiscSection = MiscTab:CreateSection("Miscellaneous Features")
    
    MiscTab:CreateToggle({
        Name = "Anti-AFK",
        CurrentValue = false,
        Flag = "AntiAFK",
        Callback = function(value)
            if value then
                local VirtualUser = game:GetService("VirtualUser")
                game:GetService("Players").LocalPlayer.Idled:Connect(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
                Rayfield:Notify({
                    Title = "Anti-AFK",
                    Content = "Anti-AFK enabled!",
                    Duration = 3,
                    Image = 0
                })
            end
        end
    })
    
    MiscTab:CreateButton({
        Name = "Rejoin Server",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        end
    })
    
    MiscTab:CreateButton({
        Name = "Server Hop",
        Callback = function()
            local PlaceId = game.PlaceId
            local AllIDs = {}
            local foundAnything = ""
            local actualHour = os.date("!*t").hour
            local Deleted = false
            
            local function TPReturner()
                local Site
                if foundAnything == "" then
                    Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))
                else
                    Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceId .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
                end
                
                for i,v in pairs(Site.data) do
                    if v.id ~= game.JobId then
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceId, v.id, game.Players.LocalPlayer)
                        break
                    end
                end
            end
            
            TPReturner()
        end
    })
    
    MiscTab:CreateSection("Credits")
    
    MiscTab:CreateParagraph({
        Title = "Script Info",
        Content = "Script Hub with Platoboost Key System\nMade with Rayfield UI Library"
    })
    
    --! Settings Tab
    local SettingsTab = MainWindow:CreateTab("Settings", 4483362458)
    local SettingsSection = SettingsTab:CreateSection("UI Settings")
    
    SettingsTab:CreateKeybind({
        Name = "Toggle UI",
        CurrentKeybind = "RightShift",
        HoldToInteract = false,
        Flag = "UIToggle",
        Callback = function(key)
            -- Keybind handled automatically by Rayfield
        end
    })
    
    SettingsTab:CreateButton({
        Name = "Destroy UI",
        Callback = function()
            Rayfield:Destroy()
        end
    })
    
    -- Final notification
    Rayfield:Notify({
        Title = "Loaded Successfully!",
        Content = "All features are now available. Enjoy!",
        Duration = 5,
        Image = 0
    })
end

-- Script will wait at key system until verified
Rayfield:LoadConfiguration()
