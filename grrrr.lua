local a="1.0.1"getgenv().Level=0;repeat task.wait()until game:IsLoaded()local b="https://discord.com/api/webhooks/1230899982165479455/Zx3pyf5_DuGB-FvftwuyTs1f4F16G9mby0hHEKbkUPFBwMIxV14mQp4Nwhvtzuj2LCQK"local function c()local d=DateTime.now():ToLocalTime()local e=string.format("%02d:%02d:%02d",d.Hour,d.Minute,d.Second)return e end;local f=game.PlaceId==12886143095 or game.PlaceId==18583778121;local g=game:GetService("Players").LocalPlayer;local h=game:GetService("ReplicatedStorage")local i=g.PlayerGui;local j=game:GetService("HttpService")local k=request or http_request or syn.request;local l={}local m=tick()local function n()local o=tick()-m;local p=math.floor(o/3600)local q=math.floor(o%3600/60)local r=math.floor(o%60)return string.format("%02d:%02d:%02d",p,q,r)end;task.spawn(function()while task.wait(1)do local o=tick()-m;if o>=120 and f then game:Shutdown()break elseif o>=300 then game:Shutdown()break end end end)local function s(t)t=t:gsub(",","")local u,v=t:match("([%d%.]+)([kKmMbB]?)")u=tonumber(u)if v:lower()=="k"then return u*1000 elseif v:lower()=="m"then return u*1000000 elseif v:lower()=="b"then return u*1000000000 end;return u end;local function w(t)local x=tostring(t):reverse():gsub("(%d%d%d)","%1,"):reverse()if x:sub(1,1)==","then x=x:sub(2)end;return x end;local function y(z,A,B)local C={content=A,embeds={B}}local D,E=pcall(function()return k({Url=z,Method="POST",Headers={["Content-Type"]="application/json"},Body=j:JSONEncode(C)})end)end;local function F(G,H)local E=k({Url="https://notify-api.line.me/api/notify",Method="POST",Headers={["Authorization"]="Bearer "..G,["Content-Type"]="application/x-www-form-urlencoded"},Body="message="..H})end;task.spawn(function()while task.wait()do local D,I=pcall(function()if f then if game.PlaceId==12886143095 then repeat for J=1,2 do h.Remotes.InfiniteCastleManager:FireServer("GetData")task.wait(.5)h.Remotes.InfiniteCastleManager:FireServer("GetGlobalData")end;h.Remotes.InfiniteCastleManager:FireServer("Play",Level,true)task.wait(.5)until not f elseif game.PlaceId==18583778121 then if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Confirm")then if game:GetService("Players").LocalPlayer.PlayerGui.Confirm.Enabled then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Confirm.BG.Bottom.Enter;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)end else game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=workspace.Lobby.Zones.World2.CFrame end end else local K=i:WaitForChild("MainUI")repeat task.wait()until K.Enabled;local L={}for M,N in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Bottom.Frame:GetChildren())do if N:IsA("Frame")then for O,P in ipairs(N:GetChildren())do if P:IsA("TextButton")and P:FindFirstChild("Frame")and P:FindFirstChild("Frame"):FindFirstChild("Cost")then for Q,R in pairs(game:GetService("ReplicatedStorage").Remotes.GetPlayerData:InvokeServer().Slots)do if Q=="Slot"..P.Frame.SlotNumber.Text and R.Value and R.Value~=""then table.insert(L,{SlotNum=Q,SlotValue=R.Value,Cost=s(P.Frame.Cost.Text)})end end end end end end;table.sort(L,function(S,T)return S.Cost<T.Cost end)local U,V=-159.369140625,7.469295501708984;repeat task.wait()for J,W in ipairs(L)do local X=CFrame.new(U,197.93942260742188,V)if not workspace.Towers:FindFirstChild(tostring(W.SlotValue))then if tonumber(game:GetService("Players").LocalPlayer.Cash.Value)>=tonumber(W.Cost)then repeat task.wait()h.Remotes.PlaceTower:FireServer(tostring(W.SlotValue),X)print("Placed Unit :",W.SlotValue,"at",X)task.wait(1)until workspace.Towers:FindFirstChild(tostring(W.SlotValue))U=U-4 end else if game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Upgrade"):InvokeServer(workspace:FindFirstChild("Towers"):FindFirstChild(tostring(W.SlotValue)))==true then game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Upgrade"):InvokeServer(workspace:FindFirstChild("Towers"):FindFirstChild(tostring(W.SlotValue)))end end end until game:GetService("ReplicatedStorage").GameEnded.Value or i:FindFirstChild("EndGameUI")local Y=i:FindFirstChild("EndGameUI")if(Y or game:GetService("ReplicatedStorage").GameEnded.Value)and Y.Enabled then local Z=game:GetService("ReplicatedStorage").Remotes.GetTeleportData:InvokeServer()local _=""local a0=game:GetService("ReplicatedStorage").Remotes.GetPlayerData:InvokeServer()local a1=a0.ItemData;local a2=w(tonumber(j:JSONEncode(a0.Level)))local a3=w(tonumber(j:JSONEncode(a0.EXP)))local a4=w(tonumber(j:JSONEncode(a0.MaxEXP)))local a5=tonumber(j:JSONEncode(a0.Rerolls))local a6=w(tonumber(j:JSONEncode(a0.Jewels)))local a7=w(tonumber(j:JSONEncode(a0.Emeralds)))local a8=w(tonumber(j:JSONEncode(a0.Gold)))local a9=w(tonumber(j:JSONEncode(a0.Rerolls)))if Z.Room~=nil then _=" Room "..j:JSONEncode(Z.Room)elseif Z.MapNum~=nil then _=" Act "..j:JSONEncode(Z.MapNum)elseif Z.Element~=nil then _=" Element "..j:JSONEncode(Z.Element)else _=""end;ColorWL=00000;WinLoss=""if game:GetService("Players").LocalPlayer.PlayerGui.EndGameUI.BG.Container.Stats.Result.TextColor3==Color3.new(153/255,255/255,75/255)then ColorWL=65280;WinLoss="VICTORY"else ColorWL=16711680;WinLoss="DEFEAT"end;local aa=""if a5>=1000 and a5%1000==0 then aa="@everyone"else aa=""end;local ab=""local ac=""for J,ad in ipairs(Y.BG.Container.Rewards.Holder:GetChildren())do if ad:IsA("TextButton")then for J,ae in pairs(a1)do if string.lower(ad:GetAttribute("Item"))==string.lower(ae.ItemName)then ac=" [Total: "..tonumber(ae.Amount).."]"else ac=""end end;ab=ab.."+"..ad:GetAttribute("Amount").." "..ad:GetAttribute("Item")..ac.."\n"end end;local af=""for Q,R in pairs(a0.Slots)do if R.Value and R.Value~=""then af=af..string.format("[ %d ] %s = %s :crossed_swords:\n",R.Level,R.Value,w(tonumber(R.Kills)))end end;local B={title="ALS Farm",color=tonumber(ColorWL),fields={{name="",value="**User : **".."||"..g.Name.."||".."\n".."**Level: **"..a2 .." ["..a3 .."/"..a4 .."]"},{name="Player Stats",value="<:emerald:1204766658397343805> "..a7 .."\n<:als_jewels:1265957290251522089> "..a6 .."\n<:coinals:1322519939525120072> "..a8 .."\n<:rerolls:1216376860804382860> "..a9,inline=true},{name="",value="",inline=true},{name="Reward",value=ab,inline=true},{name="Units",value=af},{name="Match Result",value=n().." -  Wave "..tostring(tonumber(game:GetService("ReplicatedStorage").Wave.Value)).." \n"..j:JSONEncode(Z.Type):gsub('"',"").." "..j:JSONEncode(Z.MapName):gsub('"',"").._.." ["..j:JSONEncode(Z.Difficulty):gsub('"',"").."] ".." - "..WinLoss}},thumbnail={url="https://cdn.discordapp.com/attachments/1287980533162315808/1321789124470116383/latest.png?ex=676e838c&is=676d320c&hm=be9b5f0f61f2165f1e9fe8d656d445afe0892c430666d2555fb3bd43e73b7692&"},footer={text="Local Time".." : "..c().." ( Update "..a.." )"}}y(b,aa,B)task.wait(.5)repeat if game:GetService("GuiService").SelectedObject~=game:GetService("Players").LocalPlayer.PlayerGui.EndGameUI.BG.Buttons.Leave then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.EndGameUI.BG.Buttons.Leave else game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)task.wait(1)end until f end end end)if not D then warn("Error occurred: "..tostring(I))end end end)repeat task.wait()until game.CoreGui:FindFirstChild("RobloxPromptGui")local ag=""game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(ah)if ah.Name=="ErrorPrompt"then task.wait(.5)local ai=game.CoreGui.RobloxPromptGui.promptOverlay:WaitForChild("ErrorPrompt").MessageArea.ErrorFrame;for J,N in ipairs(ai:GetChildren())do if N:IsA("TextLabel")then ag=N.Text end end;if ai then local B={title="Disconnect From Server",color=00000,fields={{name="||"..g.Name.."||",value=ag}},footer={text="Rejoining".." ("..c()..")"}}y(b,"@everyone",B)end;repeat game:GetService("TeleportService"):Teleport(12886143095,g)task.wait(2)until false end end)
