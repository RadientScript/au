repeat task.wait()until game:IsLoaded()repeat task.wait()until game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Loading").Enabled==false;local a="1.0.0"local b=loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()local c=b:CreateWindow({Title="Gym Leauge",Icon="door-open",Author="Beta Script | version "..a,Folder="JayHub",Size=UDim2.fromOffset(580,460),Transparent=true,Theme="Dark",SideBarWidth=200,ToggleKey=Enum.KeyCode.LeftControl,HasOutline=false})local d={Main=c:Tab({Title="Main",Icon="",Desc=""}),Competition=c:Tab({Title="Competition",Icon="",Desc=""}),Gear=c:Tab({Title="Gear",Icon="",Desc=""}),Boost=c:Tab({Title="Boost",Icon="",Desc=""}),Misc=c:Tab({Title="Misc",Icon="",Desc=""}),Server=c:Tab({Title="Server",Icon="",Desc=""})}c:SelectTab(1)getgenv().SaveConfig=getgenv().SaveConfig or{}local e="GymLeague"local f=e.."/"..game:GetService("Players").LocalPlayer.Name.."_config.json"if not isfolder(e)then makefolder(e)end;local g={AutoFarm=false,WaitRandom=5,AutoEquipGearSlot=false,OpenQueue=true,HideText=false,MoneyGear="",FarmGear="",AutoComp=false,EnableHop=false,AutoActiveBoost=false,BuyThing={},RollPost=false}local function h()local i,j=pcall(function()writefile(f,game:GetService("HttpService"):JSONEncode(getgenv().SaveConfig))end)if not i then warn("Failed to save config:",j)end end;local function k()if isfile(f)then local i,l=pcall(function()return game:GetService("HttpService"):JSONDecode(readfile(f))end)if i and type(l)=="table"then for m,n in pairs(g)do getgenv().SaveConfig[m]=l[m]or n end;print("[LoadMainData] Loaded existing config.")else warn("[LoadMainData] Failed to load config, using defaults.")getgenv().SaveConfig=g;h()end else print("[LoadMainData] Config file not found, creating new one.")getgenv().SaveConfig=g;h()end end;local function o(p,q)getgenv().SaveConfig[p]=q;h()end;k()d.Main:Toggle({Title="Auto Farm",Value=getgenv().SaveConfig.AutoFarm,Callback=function(r)o("AutoFarm",r)end})d.Main:Slider({Title="Wait Random",Desc="Wait For Random Next Machine! (minute)",Value={Min=1,Max=60,Default=getgenv().SaveConfig.WaitRandom},Callback=function(r)o("WaitRandom",r)end})d.Competition:Toggle({Title="Auto Competition",Value=getgenv().SaveConfig.AutoComp,Callback=function(r)o("AutoComp",r)end})d.Competition:Toggle({Title="Advance Competiton",Value=getgenv().SaveConfig.OpenQueue,Callback=function(r)o("OpenQueue",r)end})d.Competition:Toggle({Title="Enable Hop",Value=getgenv().SaveConfig.EnableHop,Callback=function(r)o("EnableHop",r)end})d.Competition:Button({Title="See Competition",Callback=function()workspace.Podium.entrance.billboard.billboard.MaxDistance=9e9 end})local s=""local t=game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()local u=t:FindFirstChildOfClass("Humanoid")local v=game.PlaceId;local w=game.JobId;local function x(y,z)pcall(function()game:GetService("StarterGui"):SetCore("SendNotification",{Title=y,Text=z,Duration=3})end)end;local function A(v,B)local C="https://games.roblox.com/v1/games/"..v.."/servers/Public?sortOrder=Desc&limit=100"if B then C=C.."&cursor="..B end;local i,D=pcall(function()return game:GetService("HttpService"):JSONDecode(game:HttpGet(C))end)if i and D then return D else return nil end end;local function E()x("Server Hop","Searching for a new server...")local B=nil;local F=false;repeat local G=A(v,B)if G and G.data and#G.data>0 then for H,I in ipairs(G.data)do if I.playing<I.maxPlayers and I.id~=w then x("Server Hop","Found a server! Joining...")local i,j=pcall(function()game:GetService("TeleportService"):TeleportToPlaceInstance(v,I.id,game.Players.LocalPlayer)end)if i then F=true;break else warn("Failed to teleport:",j)end end end end;if G then B=G.nextPageCursor else warn("Failed to retrieve server list.")break end;task.wait(1)until not B or F;if not F then x("Server Hop","No suitable servers found.")end end;local J={"Chest","Triceps","Shoulder","Back","Forearm","Biceps","Abs","Legs","Calves"}local function K(L)for M,N in ipairs(J)do if N==L then return M end end;return#J+1 end;local O=""local function P()local Q={}for H,n in pairs(workspace.Equipments:GetChildren())do if n.Name~="treadmill"and not n:GetAttribute("occupied")then table.insert(Q,n.Name)end end;if#Q>0 then local R=math.random(1,#Q)local S=Q[R]print("Selected random equipment:",S)return S else print("No available equipment to select.")return nil end end;task.spawn(function()while task.wait()do O=P()task.wait(getgenv().SaveConfig.WaitRandom*60)end end)local T={}local function U()local V=game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.Stamina.Frame:FindFirstChild("APercentage")if not V then return end;local W=V.Text:gsub("[^%d%.]","")table.clear(T)for H,n in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.Stats:GetChildren())do if n:IsA("ImageButton")and n:FindFirstChild("Frame")then local X=n.Frame:FindFirstChild("APercentage")and n.Frame.APercentage.Text;local Y=X:gsub("[^%d%.]","")table.insert(T,{Name=n.Name,Percentage=tonumber(Y)})end end;table.sort(T,function(Z,_)return K(Z.Name)>K(_.Name)end)for H,a0 in ipairs(T)do if tonumber(W)<100 then s="treadmill"else if a0.Percentage<100 then local a1={Chest="benchpress",Triceps={"triceppushdown","tricepscurl"},Shoulder={"shoulderpress","pushpress"},Back={"rowing","deadlift"},Biceps={"barcable","hammercurl"},Forearm="wristcurl",Legs="legpress",Abs="crunch",Calves={"calveraise","frontsquat"}}local a2=a1[a0.Name]if type(a2)=="table"then for H,a3 in ipairs(a2)do if workspace.Equipments:FindFirstChild(a3)then s=a3;break end end elseif workspace.Equipments:FindFirstChild(a2)then s=a2 end end end end end;local function a4(a5)for a6,a7 in pairs(game:GetService("Players").LocalPlayer:GetAttributes())do if string.find(a6,"Boost")and string.find(a6,a5)then return true end end;return false end;local function a8()local a9={}for a6,a7 in pairs(game:GetService("Players").LocalPlayer:GetAttributes())do if string.match(a6,"^Gear%d+$")then a9[a6]=a7 end end;return a9 end;local function aa(ab)for ac,n in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.GearsLoadout.Pages.InfoFrame.List:GetChildren())do if n:IsA("Frame")and n.Name=="Template"and n.Title.Text==ab then local ad=true;for ae,af in pairs(n.Container1:GetChildren())do if af:IsA("ImageButton")then local ag=false;for H,a7 in pairs(a8())do if string.find(a7,af.Name)then ag=true;break end end;if not ag then ad=false;break end end end;if not ad then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GearService"):WaitForChild("RF"):WaitForChild("EquipLoadout"):InvokeServer(tostring(ab))end end end end;local function ah()local ai=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"Starts in (%d+) sec")local aj=string.match(workspace.Podium.entrance.billboard.billboard.labelText.Text,">(.-)<")if aj then if getgenv().SaveConfig.OpenQueue then if ai then ai=tonumber(ai)if ai<=10 then return true end end else if string.find(aj,"Competition")then if ai then ai=tonumber(ai)if ai<=10 then return true end end end end;return false end end;local function ak()if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible then return true end;return false end;local function al(am)if game.Players.LocalPlayer:GetAttribute("ragdolled")==nil or game.Players.LocalPlayer:GetAttribute("ragdolled")==false then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")==nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then if not ah()then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=am else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("MiniPodiumService"):WaitForChild("RF"):WaitForChild("Teleport"):InvokeServer()end else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end end;local function an(ao)if ao and ao:IsA("ProximityPrompt")then ao.Enabled=true;ao.HoldDuration=0;ao.RequiresLineOfSight=false;ao.MaxActivationDistance=math.huge;fireproximityprompt(ao)end end;local function ap(aq,ar,as)if as then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")then if string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),aq)then else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end end;if not game:GetService("Players").LocalPlayer:GetAttribute("equipment")or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=ar.root.CFrame;task.wait(.1)an(ar.root:FindFirstChild("ProximityPrompt"))task.wait(1)end end;local function at()for ac,n in pairs(workspace.Equipments:GetChildren())do if n.Name==O then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")then if string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),O)then else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end;if game:GetService("Players").LocalPlayer:GetAttribute("equipment")and string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),n.Name)then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=n.root.CFrame else if not game:GetService("Players").LocalPlayer:GetAttribute("equipment")or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=n.root.CFrame;task.wait(.1)an(n.root:FindFirstChild("ProximityPrompt"))task.wait(1)end end end end end;local function au(av)for H,aw in pairs(workspace.Equipments:GetChildren())do if aw.Name==av and not aw:GetAttribute("occupied")then return aw end end;return nil end;task.spawn(function()while task.wait()do local i,j=pcall(function()if getgenv().SaveConfig.AutoFarm then local ax=game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Frame:FindFirstChild("APercentage").Text:gsub("[^%d%.]","")local ay=tonumber(ax)task.spawn(U)if game:GetService("Players").LocalPlayer:GetAttribute("equipment")and game:GetService("Players").LocalPlayer:GetAttribute("equipment")~=""then game:GetService("Players").LocalPlayer:SetAttribute("autoTrainEnabled",true)end;if game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Buy.Visible then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CharacterService"):WaitForChild("RF"):WaitForChild("NextAlter"):InvokeServer()end;if game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Locked.Visible then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("WorldService"):WaitForChild("RF"):WaitForChild("unlock"):InvokeServer()end;for ac,n in pairs(workspace:GetChildren())do if n.ClassName=="Model"and n:FindFirstChild("GetQuest")then if n.Name=="P3NT"then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("giveStoryQuest"):InvokeServer("P_3NT")task.wait(.1)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("complete"):InvokeServer("P_3NT")else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("giveStoryQuest"):InvokeServer(tostring(n.Name))task.wait(.1)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("complete"):InvokeServer(tostring(n.Name))end end end;if ah()then repeat task.wait()if not game:GetService("Players").LocalPlayer:GetAttribute("inPodiumQueue")then al()end;if getgenv().SaveConfig.AutoEquipGearSlot and(getgenv().SaveConfig.MoneyGear~=nil or getgenv().SaveConfig.MoneyGear~="")then aa(getgenv().SaveConfig.MoneyGear)end until game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or ak()or not getgenv().SaveConfig.AutoFarm elseif game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or ak()then else if getgenv().SaveConfig.AutoEquipGearSlot and(getgenv().SaveConfig.FarmGear~=nil or getgenv().SaveConfig.FarmGear~="")then aa(getgenv().SaveConfig.FarmGear)end;if ay and ay>=100 then task.spawn(at)else for H,az in pairs(workspace.Equipments:GetChildren())do if tostring(az.Name)==s then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")and string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),s)then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=az.root.CFrame elseif az:GetAttribute("occupied")and au(az.Name)==nil then task.spawn(at)else ap(s,az.Name,true)end end end end end end end)if not i then warn("Error occurred: "..tostring(j))end end end)task.spawn(function()while task.wait()do local i,j=pcall(function()if getgenv().SaveConfig.AutoComp then local ai=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"Starts in (%d+) sec")local aA=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"load in (%d+) seconds")local aj=string.match(workspace.Podium.entrance.billboard.billboard.labelText.Text,">(.-)<")if aj and ai or aA and tonumber(aA)<=50 then if ai and tonumber(ai)<=10 then repeat task.wait()if game:GetService("Players").LocalPlayer:GetAttribute("equipment")==nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end;if not game:GetService("Players").LocalPlayer:GetAttribute("inPodiumQueue")then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("MiniPodiumService"):WaitForChild("RF"):WaitForChild("Teleport"):InvokeServer()end until ak()or game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or not getgenv().SaveConfig.AutoComp end elseif ak()or game:GetService("Players").LocalPlayer:GetAttribute("inPodium")then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text~="Auto Click: ON"then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)else game:GetService("GuiService").SelectedObject=nil end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.Visible then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.Visible then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)end else if getgenv().SaveConfig.EnableHop then E()end end end end)if not i then warn("Error occurred: "..tostring(j))end end end)local aB={}for H,n in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.GymStore.PowerUps.CanvasGroup.List:GetChildren())do if n:IsA("Frame")then table.insert(aB,tostring(n.Name))end end;d.Boost:Dropdown({Title="Select Boost",Values=aB,Value=getgenv().SaveConfig.BuyThing,Multi=true,Callback=function(r)o("BuyThing",r)end})d.Boost:Toggle({Title="Auto Active Boost",Value=getgenv().SaveConfig.AutoActiveBoost,Callback=function(r)o("AutoActiveBoost",r)end})task.spawn(function()while task.wait()do local i,j=pcall(function()if getgenv().SaveConfig.AutoActiveBoost then for H,aC in pairs(game.Players.LocalPlayer:FindFirstChild("Backpack"):GetChildren())do if aC:IsA("Tool")then for H,aC in ipairs(game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):GetChildren())do if aC:IsA("Tool")then u:EquipTool(aC)aC:Activate()end end;for H,aC in ipairs(game:GetService("Players").LocalPlayer.Character:GetChildren())do if aC:IsA("Tool")then aC:Activate()end end end end end end)if not i then warn("Error occurred: "..tostring(j))end end end)task.spawn(function()while task.wait()do local i,j=pcall(function()if getgenv().SaveConfig.AutoActiveBoost then local aD=getgenv().SaveConfig.BuyThing;for H,n in pairs(aD)do local a5=tostring(n):gsub(" ","")if not a4(a5)then print("Buying:",n)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PowerUpsService"):WaitForChild("RF"):WaitForChild("Buy"):InvokeServer(n,1)end;task.wait(.3)end end end)if not i then warn("Error occurred: "..tostring(j))end end end)local aE={Common=Color3.fromRGB(190,190,190),Rare=Color3.fromRGB(93,155,255),Epic=Color3.fromRGB(177,99,255),Legendary=Color3.fromRGB(255,161,53),Mythic=Color3.fromRGB(255,47,47)}task.spawn(function()while task.wait()do local i,j=pcall(function()if getgenv().SaveConfig.RollPost then for ac,n in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Customize.Pages.Poses.Poses.altFrame.List.UnownedList:GetChildren())do if n:IsA("ImageButton")then if n.Rarity.ImageColor3==aE.Mythic then if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Customize.Pages.Poses.Poses.altFrame.List.OwnedList.Reroll.Left.Text,"Left")then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PoseService"):WaitForChild("RF"):WaitForChild("Spin"):InvokeServer()else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PoseService"):WaitForChild("RF"):WaitForChild("Buy"):InvokeServer()end;task.wait(.2)end end end end end)if not i then warn("Error occurred: "..tostring(j))end end end)local function aF()local aG={}for ac,n in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.GearsLoadout.Pages.InfoFrame.List:GetChildren())do if n:IsA("Frame")and n.Name=="Template"and n.Title.Text~="N/A"then table.insert(aG,n.Title.Text)end end;return aG end;local aH=d.Gear:Dropdown({Title="Select Muscle Gear",Values=aF(),Value=getgenv().SaveConfig.FarmGear,Callback=function(r)o("FarmGear",r)end})local aI=d.Gear:Dropdown({Title="Select Money Gear",Values=aF(),Value=getgenv().SaveConfig.MoneyGear,Callback=function(r)o("MoneyGear",r)end})d.Gear:Button({Title="Refresh Gear",Callback=function()aH:Refresh(aF())aI:Refresh(aF())end})d.Gear:Toggle({Title="Auto Equip Gear",Value=getgenv().SaveConfig.AutoEquipGearSlot,Callback=function(r)o("AutoEquipGearSlot",r)end})d.Misc:Toggle({Title="Auto Roll Post",Value=getgenv().SaveConfig.RollPost,Callback=function(r)o("RollPost",r)end})d.Misc:Toggle({Title="Hide Text",Value=getgenv().SaveConfig.HideText,Callback=function(r)o("HideText",r)end})d.Server:Button({Title="Rejoin",Callback=function()game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)end})d.Server:Button({Title="Server Hop",Callback=function()E()end})task.spawn(function()game:GetService("Players").LocalPlayer.PlayerGui.Main.Popup.ChildAdded:Connect(function(aJ)if aJ:IsA("Frame")then if getgenv().SaveConfig.HideText then aJ.Visible=false end end end)end)task.spawn(function()while task.wait()do if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text,"Auto Click:")then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text~="Auto Click: ON"then if game:GetService("GuiService").SelectedObject~=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick else game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)task.wait(1)end else game:GetService("GuiService").SelectedObject=nil end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.Visible then if game:GetService("GuiService").SelectedObject~=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue else game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)task.wait(1)end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.Visible then if game:GetService("GuiService").SelectedObject~=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok else game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)task.wait(1)end end end end)game:GetService("Players").LocalPlayer.Idled:Connect(function()game:GetService("VirtualUser"):CaptureController()game:GetService("VirtualUser"):ClickButton2(Vector2.new())end)
