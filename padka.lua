repeat task.wait()until game:IsLoaded()repeat task.wait()until game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Loading").Enabled==false;local a=loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()local b=a:CreateWindow({Title="Gym Leauge",Icon="door-open",Author="Beta Script",Folder="JayHub",Size=UDim2.fromOffset(580,460),Transparent=true,Theme="Dark",SideBarWidth=200,ToggleKey=Enum.KeyCode.LeftControl,HasOutline=false})local c={Main=b:Tab({Title="Main",Icon="",Desc=""}),Competition=b:Tab({Title="Competition",Icon="",Desc=""}),Gear=b:Tab({Title="Gear",Icon="",Desc=""}),Boost=b:Tab({Title="Boost",Icon="",Desc=""}),Misc=b:Tab({Title="Misc",Icon="",Desc=""}),Server=b:Tab({Title="Server",Icon="",Desc=""})}b:SelectTab(1)getgenv().SaveConfig=getgenv().SaveConfig or{}local d="GymLeague"local e=d.."/"..game:GetService("Players").LocalPlayer.Name.."_config.json"if not isfolder(d)then makefolder(d)end;local f={AutoFarm=false,WaitRandom=5,AutoEquipGearSlot=false,OpenQueue=true,AutoFarmRandom=false,HideText=false,MoneyGear="",FarmGear="",AutoComp=false,EnableHop=false,AutoActiveBoost=false,BuyThing={},RollPost=false}local function g()local h,i=pcall(function()writefile(e,game:GetService("HttpService"):JSONEncode(getgenv().SaveConfig))end)if not h then warn("Failed to save config:",i)end end;local function j()if isfile(e)then local h,k=pcall(function()return game:GetService("HttpService"):JSONDecode(readfile(e))end)if h and type(k)=="table"then for l,m in pairs(f)do getgenv().SaveConfig[l]=k[l]or m end;print("[LoadMainData] Loaded existing config.")else warn("[LoadMainData] Failed to load config, using defaults.")getgenv().SaveConfig=f;g()end else print("[LoadMainData] Config file not found, creating new one.")getgenv().SaveConfig=f;g()end end;local function n(o,p)getgenv().SaveConfig[o]=p;g()end;j()c.Main:Toggle({Title="Auto Farm",Value=getgenv().SaveConfig.AutoFarm,Callback=function(q)n("AutoFarm",q)end})c.Main:Toggle({Title="Auto Farm (Random Mode)",Value=getgenv().SaveConfig.AutoFarmRandom,Callback=function(q)n("AutoFarmRandom",q)end})c.Main:Slider({Title="Wait Random",Desc="Wait For Random Next Machine! (minute)",Value={Min=1,Max=60,Default=getgenv().SaveConfig.WaitRandom},Callback=function(q)n("WaitRandom",q)end})c.Competition:Toggle({Title="Auto Competition",Value=getgenv().SaveConfig.AutoComp,Callback=function(q)n("AutoComp",q)end})c.Competition:Toggle({Title="Advance Competiton",Value=getgenv().SaveConfig.OpenQueue,Callback=function(q)n("OpenQueue",q)end})c.Competition:Toggle({Title="Enable Hop",Value=getgenv().SaveConfig.EnableHop,Callback=function(q)n("EnableHop",q)end})c.Competition:Button({Title="See Competition",Callback=function()workspace.Podium.entrance.billboard.billboard.MaxDistance=9e9 end})local r=""local s=false;local t=false;local u=false;local v=false;local w=0;local x=game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()local y=x:FindFirstChildOfClass("Humanoid")local z=game.PlaceId;local A=game.JobId;local function B(C,D)pcall(function()game:GetService("StarterGui"):SetCore("SendNotification",{Title=C,Text=D,Duration=3})end)end;local function E(z,F)local G="https://games.roblox.com/v1/games/"..z.."/servers/Public?sortOrder=Desc&limit=100"if F then G=G.."&cursor="..F end;local h,H=pcall(function()return game:GetService("HttpService"):JSONDecode(game:HttpGet(G))end)if h and H then return H else return nil end end;local function I()B("Server Hop","Searching for a new server...")local F=nil;local J=false;repeat local K=E(z,F)if K and K.data and#K.data>0 then for L,M in ipairs(K.data)do if M.playing<M.maxPlayers and M.id~=A then B("Server Hop","Found a server! Joining...")local h,i=pcall(function()game:GetService("TeleportService"):TeleportToPlaceInstance(z,M.id,game.Players.LocalPlayer)end)if h then J=true;break else warn("Failed to teleport:",i)end end end end;if K then F=K.nextPageCursor else warn("Failed to retrieve server list.")break end;task.wait(1)until not F or J;if not J then B("Server Hop","No suitable servers found.")end end;local N={"Chest","Triceps","Shoulder","Back","Forearm","Biceps","Abs","Legs","Calves"}local function O(P)for Q,R in ipairs(N)do if R==P then return Q end end;return#N+1 end;local S=""local function T()local U={}for L,m in pairs(workspace.Equipments:GetChildren())do if m.Name~="treadmill"and not m:GetAttribute("occupied")then table.insert(U,m.Name)end end;if#U>0 then local V=math.random(1,#U)local W=U[V]print("Selected random equipment:",W)return W else print("No available equipment to select.")return nil end end;task.spawn(function()while task.wait()do S=T()task.wait(getgenv().SaveConfig.WaitRandom*60)end end)local X={}local function Y()local Z=game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.Stamina.Frame:FindFirstChild("APercentage")if not Z then return end;local _=Z.Text:gsub("[^%d%.]","")table.clear(X)for L,m in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.Stats:GetChildren())do if m:IsA("ImageButton")and m:FindFirstChild("Frame")then local a0=m.Frame:FindFirstChild("APercentage")and m.Frame.APercentage.Text;local a1=a0:gsub("[^%d%.]","")table.insert(X,{Name=m.Name,Percentage=tonumber(a1)})end end;table.sort(X,function(a2,a3)return O(a2.Name)>O(a3.Name)end)for L,a4 in ipairs(X)do if tonumber(_)<100 then r="treadmill"else if a4.Percentage<100 then local a5={Chest="benchpress",Triceps={"triceppushdown","tricepscurl"},Shoulder={"shoulderpress","pushpress"},Back={"rowing","deadlift"},Biceps={"barcable","hammercurl"},Forearm="wristcurl",Legs="legpress",Abs="crunch",Calves={"calveraise","frontsquat"}}local a6=a5[a4.Name]if type(a6)=="table"then for L,a7 in ipairs(a6)do if workspace.Equipments:FindFirstChild(a7)then r=a7;break end end elseif workspace.Equipments:FindFirstChild(a6)then r=a6 end end end end end;local function a8(a9)for aa,ab in pairs(game:GetService("Players").LocalPlayer:GetAttributes())do if string.find(aa,"Boost")and string.find(aa,a9)then return true end end;return false end;local function ac()local ad={}for aa,ab in pairs(game:GetService("Players").LocalPlayer:GetAttributes())do if string.match(aa,"^Gear%d+$")then ad[aa]=ab end end;return ad end;local function ae(af)for ag,m in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.GearsLoadout.Pages.InfoFrame.List:GetChildren())do if m:IsA("Frame")and m.Name=="Template"and m.Title.Text==af then local ah=true;for ai,aj in pairs(m.Container1:GetChildren())do if aj:IsA("ImageButton")then local ak=false;for L,ab in pairs(ac())do if string.find(ab,aj.Name)then ak=true;break end end;if not ak then ah=false;break end end end;if not ah then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GearService"):WaitForChild("RF"):WaitForChild("EquipLoadout"):InvokeServer(tostring(af))end end end end;local function al(am)if game.Players.LocalPlayer:GetAttribute("ragdolled")==nil or game.Players.LocalPlayer:GetAttribute("ragdolled")==false then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")==nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then if not t then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=am else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("MiniPodiumService"):WaitForChild("RF"):WaitForChild("Teleport"):InvokeServer()end else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end end;local function an(ao)if ao and ao:IsA("ProximityPrompt")then ao.Enabled=true;ao.HoldDuration=0;ao.RequiresLineOfSight=false;ao.MaxActivationDistance=math.huge;fireproximityprompt(ao)end end;local function ap(aq,ar,as)if as then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")then if string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),aq)then else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end end;if not game:GetService("Players").LocalPlayer:GetAttribute("equipment")or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=ar.root.CFrame;task.wait(.1)an(ar.root:FindFirstChild("ProximityPrompt"))task.wait(1)end end;local function at()for ag,m in pairs(workspace.Equipments:GetChildren())do if m.Name==S then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")then if string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),S)then else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end;if game:GetService("Players").LocalPlayer:GetAttribute("equipment")and string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),m.Name)then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=m.root.CFrame else if not game:GetService("Players").LocalPlayer:GetAttribute("equipment")or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=m.root.CFrame;task.wait(.1)an(m.root:FindFirstChild("ProximityPrompt"))task.wait(1)end end end end end;local function au(av)for L,aw in pairs(workspace.Equipments:GetChildren())do if aw.Name==av and not aw:GetAttribute("occupied")then return aw end end;return nil end;task.spawn(function()while task.wait()do local h,i=pcall(function()local ax=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"Starts in (%d+) sec")local ay=string.match(workspace.Podium.entrance.billboard.billboard.labelText.Text,">(.-)<")if ay then if getgenv().SaveConfig.OpenQueue then if ax then ax=tonumber(ax)if ax<=10 then t=true else t=false end else t=false end else if string.find(ay,"Competition")then if ax then ax=tonumber(ax)if ax<=10 then t=true else t=false end else t=false end end end end;if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible then s=true else s=false end;if getgenv().SaveConfig.AutoActiveBoost then for L,az in pairs(game.Players.LocalPlayer:FindFirstChild("Backpack"):GetChildren())do if az:IsA("Tool")then for L,az in ipairs(game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):GetChildren())do if az:IsA("Tool")then y:EquipTool(az)az:Activate()end end;for L,az in ipairs(game:GetService("Players").LocalPlayer.Character:GetChildren())do if az:IsA("Tool")then az:Activate()end end end end end;if getgenv().SaveConfig.AutoFarmRandom then task.spawn(at)end end)if not h then warn("Error occurred: "..tostring(i))end end end)task.spawn(function()game:GetService("Players").LocalPlayer.PlayerGui.Main.Popup.ChildAdded:Connect(function(aA)if aA:IsA("Frame")then if getgenv().SaveConfig.HideText then aA.Visible=false end end end)end)task.spawn(function()while task.wait()do local h,i=pcall(function()if getgenv().SaveConfig.AutoFarm then local aB=game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Frame:FindFirstChild("APercentage").Text:gsub("[^%d%.]","")local w=tonumber(aB)task.spawn(Y)if game:GetService("Players").LocalPlayer:GetAttribute("equipment")and game:GetService("Players").LocalPlayer:GetAttribute("equipment")~=""then game:GetService("Players").LocalPlayer:SetAttribute("autoTrainEnabled",true)end;if game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Buy.Visible then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CharacterService"):WaitForChild("RF"):WaitForChild("NextAlter"):InvokeServer()end;if game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Locked.Visible then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("WorldService"):WaitForChild("RF"):WaitForChild("unlock"):InvokeServer()end;for ag,m in pairs(workspace:GetChildren())do if m.ClassName=="Model"and m:FindFirstChild("GetQuest")then if m.Name=="P3NT"then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("giveStoryQuest"):InvokeServer("P_3NT")task.wait(.1)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("complete"):InvokeServer("P_3NT")else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("giveStoryQuest"):InvokeServer(tostring(m.Name))task.wait(.1)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("complete"):InvokeServer(tostring(m.Name))end end end;if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text,"Auto Click:")then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text~="Auto Click: ON"then if game:GetService("GuiService").SelectedObject~=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick else game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)task.wait(1)end else game:GetService("GuiService").SelectedObject=nil end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.Visible then if game:GetService("GuiService").SelectedObject~=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue else game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)task.wait(1)end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.Visible then if game:GetService("GuiService").SelectedObject~=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok else game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)task.wait(1)end end;if t then repeat task.wait()if not game:GetService("Players").LocalPlayer:GetAttribute("inPodiumQueue")then al()end;if getgenv().SaveConfig.AutoEquipGearSlot and(getgenv().SaveConfig.MoneyGear~=nil or getgenv().SaveConfig.MoneyGear~="")then ae(getgenv().SaveConfig.MoneyGear)end until game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or s or not getgenv().SaveConfig.AutoFarm elseif game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or s then else if getgenv().SaveConfig.AutoEquipGearSlot and(getgenv().SaveConfig.FarmGear~=nil or getgenv().SaveConfig.FarmGear~="")then ae(getgenv().SaveConfig.FarmGear)end;if w and w>=100 then task.spawn(at)else for L,aC in pairs(workspace.Equipments:GetChildren())do if tostring(aC.Name)==r then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")and string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),r)then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=aC.root.CFrame elseif aC:GetAttribute("occupied")and au(aC.Name)==nil then task.spawn(at)else ap(r,aC.Name,true)end end end end end end end)if not h then warn("Error occurred: "..tostring(i))end end end)task.spawn(function()while task.wait()do local h,i=pcall(function()if getgenv().SaveConfig.AutoComp then local ax=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"Starts in (%d+) sec")local aD=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"load in (%d+) seconds")local ay=string.match(workspace.Podium.entrance.billboard.billboard.labelText.Text,">(.-)<")if ay and ax or aD and tonumber(aD)<=50 then if ax and tonumber(ax)<=10 then repeat task.wait()if game:GetService("Players").LocalPlayer:GetAttribute("equipment")==nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end;if not game:GetService("Players").LocalPlayer:GetAttribute("inPodiumQueue")then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("MiniPodiumService"):WaitForChild("RF"):WaitForChild("Teleport"):InvokeServer()end until s or game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or not getgenv().SaveConfig.AutoComp end elseif s or game:GetService("Players").LocalPlayer:GetAttribute("inPodium")then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text~="Auto Click: ON"then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)else game:GetService("GuiService").SelectedObject=nil end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.Visible then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.Visible then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)end else if getgenv().SaveConfig.EnableHop then I()end end end end)if not h then warn("Error occurred: "..tostring(i))end end end)local aE={}for L,m in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.GymStore.PowerUps.CanvasGroup.List:GetChildren())do if m:IsA("Frame")then table.insert(aE,tostring(m.Name))end end;c.Boost:Dropdown({Title="Select Boost",Values=aE,Value=getgenv().SaveConfig.BuyThing,Multi=true,Callback=function(q)n("BuyThing",q)end})c.Boost:Toggle({Title="Auto Active Boost",Value=getgenv().SaveConfig.AutoActiveBoost,Callback=function(q)n("AutoActiveBoost",q)end})local aF={Common=Color3.fromRGB(190,190,190),Rare=Color3.fromRGB(93,155,255),Epic=Color3.fromRGB(177,99,255),Legendary=Color3.fromRGB(255,161,53),Mythic=Color3.fromRGB(255,47,47)}task.spawn(function()while task.wait()do local h,i=pcall(function()if getgenv().SaveConfig.AutoActiveBoost then local aG=getgenv().SaveConfig.BuyThing;for L,m in pairs(aG)do local a9=tostring(m):gsub(" ","")if not a8(a9)then print("Buying:",m)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PowerUpsService"):WaitForChild("RF"):WaitForChild("Buy"):InvokeServer(m,1)end;task.wait(.3)end end end)if not h then warn("Error occurred: "..tostring(i))end end end)task.spawn(function()while task.wait()do local h,i=pcall(function()if getgenv().SaveConfig.RollPost then for ag,m in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Customize.Pages.Poses.Poses.altFrame.List.UnownedList:GetChildren())do if m:IsA("ImageButton")then if m.Rarity.ImageColor3==aF.Mythic then if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Customize.Pages.Poses.Poses.altFrame.List.OwnedList.Reroll.Left.Text,"Left")then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PoseService"):WaitForChild("RF"):WaitForChild("Spin"):InvokeServer()else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PoseService"):WaitForChild("RF"):WaitForChild("Buy"):InvokeServer()end;task.wait(.2)end end end end end)if not h then warn("Error occurred: "..tostring(i))end end end)local function aH()local aI={}for ag,m in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.GearsLoadout.Pages.InfoFrame.List:GetChildren())do if m:IsA("Frame")and m.Name=="Template"and m.Title.Text~="N/A"then table.insert(aI,m.Title.Text)end end;return aI end;local aJ=c.Gear:Dropdown({Title="Select Muscle Gear",Values=aH(),Value=getgenv().SaveConfig.FarmGear,Callback=function(q)n("FarmGear",q)end})local aK=c.Gear:Dropdown({Title="Select Money Gear",Values=aH(),Value=getgenv().SaveConfig.MoneyGear,Callback=function(q)n("MoneyGear",q)end})c.Gear:Button({Title="Refresh Gear",Callback=function()aJ:Refresh(aH())aK:Refresh(aH())end})c.Gear:Toggle({Title="Auto Equip Gear",Value=getgenv().SaveConfig.AutoEquipGearSlot,Callback=function(q)n("AutoEquipGearSlot",q)end})c.Misc:Toggle({Title="Auto Roll Post",Value=getgenv().SaveConfig.RollPost,Callback=function(q)n("RollPost",q)end})c.Misc:Toggle({Title="Hide Text",Value=getgenv().SaveConfig.HideText,Callback=function(q)n("HideText",q)end})c.Server:Button({Title="Rejoin",Callback=function()game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)end})c.Server:Button({Title="Server Hop",Callback=function()I()end})game:GetService("Players").LocalPlayer.Idled:Connect(function()game:GetService("VirtualUser"):CaptureController()game:GetService("VirtualUser"):ClickButton2(Vector2.new())end)
