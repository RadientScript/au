repeat task.wait()until game:IsLoaded()repeat task.wait()until game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Loading").Enabled==false;local a="1.0.0"local b=loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()local c=b:CreateWindow({Title="Gym Leauge",Icon="door-open",Author="Beta Script | version "..a,Folder="JayHub",Size=UDim2.fromOffset(580,460),Transparent=true,Theme="Dark",SideBarWidth=200,ToggleKey=Enum.KeyCode.LeftControl,HasOutline=false})local d={Main=c:Tab({Title="Main",Icon="",Desc=""}),Competition=c:Tab({Title="Competition",Icon="",Desc=""}),Gear=c:Tab({Title="Gear",Icon="",Desc=""}),Boost=c:Tab({Title="Boost",Icon="",Desc=""}),Misc=c:Tab({Title="Misc",Icon="",Desc=""}),Server=c:Tab({Title="Server",Icon="",Desc=""})}c:SelectTab(1)getgenv().SaveConfig=getgenv().SaveConfig or{}local e="GymLeague"local f=e.."/"..game:GetService("Players").LocalPlayer.Name.."_config.json"if not isfolder(e)then makefolder(e)end;local g={AutoFarm=false,AutoFarmTicket=false,WaitRandom=5,AutoEquipGearSlot=false,OpenQueue=true,HideText=false,SpinTicket=false,MoneyGear="",FarmGear="",AutoComp=false,EnableHop=false,AutoActiveBoost=false,BuyThing={},RollPost=false}local function h()local i,j=pcall(function()writefile(f,game:GetService("HttpService"):JSONEncode(getgenv().SaveConfig))end)if not i then warn("Failed to save config:",j)end end;local function k()if isfile(f)then local i,l=pcall(function()return game:GetService("HttpService"):JSONDecode(readfile(f))end)if i and type(l)=="table"then for m,n in pairs(g)do getgenv().SaveConfig[m]=l[m]or n end;print("[LoadMainData] Loaded existing config.")else warn("[LoadMainData] Failed to load config, using defaults.")getgenv().SaveConfig=g;h()end else print("[LoadMainData] Config file not found, creating new one.")getgenv().SaveConfig=g;h()end end;local function o(p,q)getgenv().SaveConfig[p]=q;h()end;k()d.Main:Toggle({Title="Auto Farm",Value=getgenv().SaveConfig.AutoFarm,Callback=function(r)o("AutoFarm",r)end})d.Main:Toggle({Title="Auto Farm Ticket",Value=getgenv().SaveConfig.AutoFarmTicket,Callback=function(r)o("AutoFarmTicket",r)end})d.Main:Slider({Title="Wait Random",Desc="Wait For Random Next Machine! (minute)",Value={Min=1,Max=60,Default=getgenv().SaveConfig.WaitRandom},Callback=function(r)o("WaitRandom",r)end})d.Competition:Toggle({Title="Auto Competition",Value=getgenv().SaveConfig.AutoComp,Callback=function(r)o("AutoComp",r)end})d.Competition:Toggle({Title="Advance Competiton",Value=getgenv().SaveConfig.OpenQueue,Callback=function(r)o("OpenQueue",r)end})d.Competition:Toggle({Title="Enable Hop",Value=getgenv().SaveConfig.EnableHop,Callback=function(r)o("EnableHop",r)end})d.Competition:Button({Title="See Competition",Callback=function()workspace.Podium.entrance.billboard.billboard.MaxDistance=9e9 end})local s=game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()local t=s:FindFirstChildOfClass("Humanoid")local u=s:WaitForChild("HumanoidRootPart")local v=game.PlaceId;local w=game.JobId;local function x(y,z)pcall(function()game:GetService("StarterGui"):SetCore("SendNotification",{Title=y,Text=z,Duration=3})end)end;local function A(v,B)local C="https://games.roblox.com/v1/games/"..v.."/servers/Public?sortOrder=Desc&limit=100"if B then C=C.."&cursor="..B end;local i,D=pcall(function()return game:GetService("HttpService"):JSONDecode(game:HttpGet(C))end)if i and D then return D else return nil end end;local function E()x("Server Hop","Searching for a new server...")local B=nil;local F=false;repeat local G=A(v,B)if G and G.data and#G.data>0 then for H,I in ipairs(G.data)do if I.playing<I.maxPlayers and I.id~=w then x("Server Hop","Found a server! Joining...")local i,j=pcall(function()game:GetService("TeleportService"):TeleportToPlaceInstance(v,I.id,game.Players.LocalPlayer)end)if i then F=true;break else warn("Failed to teleport:",j)end end end end;if G then B=G.nextPageCursor else warn("Failed to retrieve server list.")break end;task.wait(1)until not B or F;if not F then x("Server Hop","No suitable servers found.")end end;local J={"Chest","Triceps","Shoulder","Back","Forearm","Biceps","Abs","Legs","Calves"}local function K(L)for M,N in ipairs(J)do if N==L then return M end end;return#J+1 end;local function O()local P={}if workspace:FindFirstChild("Equipments")then for Q,n in ipairs(workspace.Equipments:GetChildren())do table.insert(P,n.Name)end else for H,R in ipairs(workspace:GetChildren())do if R:IsA("Model")and R:FindFirstChild("Equipments")then for H,n in ipairs(R.Equipments:GetChildren())do if n.Name~="treadmill"and not n:GetAttribute("occupied")then table.insert(P,n.Name)end end end end end;if#P>0 then local S=math.random(1,#P)local T=P[S]print("Selected random equipment:",T)return T else print("No available equipment to select.")return nil end end;task.spawn(function()while task.wait()do O()task.wait(getgenv().SaveConfig.WaitRandom*60)end end)local function U()local V={}if workspace:FindFirstChild("Equipments")then for H,n in ipairs(workspace.Equipments:GetChildren())do table.insert(V,n)end else for H,R in ipairs(workspace:GetChildren())do if R:IsA("Model")and R:FindFirstChild("Equipments")then for H,n in ipairs(R.Equipments:GetChildren())do table.insert(V,n)end end end end;return V end;local W={}local X={}local function Y()local Z=game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.Stamina.Frame:FindFirstChild("APercentage")if not Z then return end;local _=Z.Text:gsub("[^%d%.]","")table.clear(W)table.clear(X)for H,n in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.Stats:GetChildren())do if n:IsA("ImageButton")and n:FindFirstChild("Frame")then local a0=n.Frame:FindFirstChild("APercentage")and n.Frame.APercentage.Text;local a1=a0:gsub("[^%d%.]","")table.insert(W,{Name=n.Name,Percentage=tonumber(a1)})end end;if workspace:FindFirstChild("Equipments")then for Q,n in ipairs(workspace.Equipments:GetChildren())do table.insert(X,n.Name)end else for H,R in ipairs(workspace:GetChildren())do if R:IsA("Model")and R:FindFirstChild("Equipments")then for H,a2 in ipairs(R.Equipments:GetChildren())do table.insert(X,string.lower(a2.Name))end end end end;table.sort(W,function(a3,a4)return K(a3.Name)<K(a4.Name)end)for H,a5 in ipairs(W)do if tonumber(_)<100 then return"treadmill"else if a5.Percentage<100 then local a6={Chest="benchpress",Triceps={"triceppushdown","tricepscurl"},Shoulder={"shoulderpress","pushpress"},Back={"rowing","deadlift"},Biceps={"barcable","hammercurl"},Forearm="wristcurl",Legs="legpress",Abs="crunch",Calves={"calveraise","frontsquat"}}local a7=a6[a5.Name]if type(a7)=="table"then for H,a8 in ipairs(a7)do if table.find(X,string.lower(a8))then return a8 end end elseif table.find(X,string.lower(a7))then return a7 end end end end end;local function a9()local aa=nil;local ab=math.huge;for H,ac in pairs(workspace:WaitForChild("Folder"):GetChildren())do if ac:IsA("BasePart")then local ad=(ac.Position-u.Position).Magnitude;if ad<ab then ab=ad;aa=ac end end end;return aa end;local function ae(af)if not af or not af:IsA("BasePart")then return end;if not t or not u then return end;local ag=(af.Position-u.Position).Magnitude;if ag<2 then return end;t.WalkSpeed=ag>50 and 40 or 30;local ah=game:GetService("PathfindingService"):CreatePath({AgentRadius=2,AgentHeight=5,AgentCanJump=true,AgentJumpHeight=10,AgentCanClimb=true})ah:ComputeAsync(u.Position,af.Position)if ah.Status==Enum.PathStatus.Success then for H,ai in ipairs(ah:GetWaypoints())do if ai.Action==Enum.PathWaypointAction.Jump then t:ChangeState(Enum.HumanoidStateType.Jumping)end;t:MoveTo(ai.Position)local aj=t.MoveToFinished:Wait(2)if not aj then break end end end end;local function ak(al)for am,an in pairs(game:GetService("Players").LocalPlayer:GetAttributes())do if string.find(am,"Boost")and string.find(am,al)then return true end end;return false end;local function ao()local ap={}for am,an in pairs(game:GetService("Players").LocalPlayer:GetAttributes())do if string.match(am,"^Gear%d+$")then ap[am]=an end end;return ap end;local function aq(ar)for Q,n in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.GearsLoadout.Pages.InfoFrame.List:GetChildren())do if n:IsA("Frame")and n.Name=="Template"and n.Title.Text==ar then local as=true;for at,au in pairs(n.Container1:GetChildren())do if au:IsA("ImageButton")then local av=false;for H,an in pairs(ao())do if string.find(an,au.Name)then av=true;break end end;if not av then as=false;break end end end;if not as then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GearService"):WaitForChild("RF"):WaitForChild("EquipLoadout"):InvokeServer(tostring(ar))end end end end;local function aw()local ax=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"Starts in (%d+) sec")local ay=string.match(workspace.Podium.entrance.billboard.billboard.labelText.Text,">(.-)<")if ay then if getgenv().SaveConfig.OpenQueue then if ax then ax=tonumber(ax)if ax<=10 then return true end end else if string.find(ay,"Competition")then if ax then ax=tonumber(ax)if ax<=10 then return true end end end end;return false end end;local function az()if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible then return true end;return false end;local function aA(aB)if game.Players.LocalPlayer:GetAttribute("ragdolled")==nil or game.Players.LocalPlayer:GetAttribute("ragdolled")==false then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")==nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then if not aw()then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=aB else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("MiniPodiumService"):WaitForChild("RF"):WaitForChild("Teleport"):InvokeServer()end else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end end;local function aC(aD)if aD and aD:IsA("ProximityPrompt")then aD.Enabled=true;aD.HoldDuration=0;aD.RequiresLineOfSight=false;aD.MaxActivationDistance=math.huge;fireproximityprompt(aD)end end;local function aE(aF,aG,aH)if aH then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")then if string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),aF)then else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end end;if not game:GetService("Players").LocalPlayer:GetAttribute("equipment")or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=aG.root.CFrame;task.wait(.1)aC(aG.root:FindFirstChild("ProximityPrompt"))task.wait(1)end end;local function aI()local aJ=O()local V={}if workspace:FindFirstChild("Equipments")then V=workspace.Equipments:GetChildren()else for H,R in ipairs(workspace:GetChildren())do if R:IsA("Model")and R:FindFirstChild("Equipments")then for H,n in ipairs(R.Equipments:GetChildren())do table.insert(V,n.Name)end end end end;for H,n in ipairs(V)do if n.Name==aJ then if game.Players.LocalPlayer:GetAttribute("equipment")then if not string.find(game.Players.LocalPlayer:GetAttribute("equipment"),aJ)then game:GetService("ReplicatedStorage").common.packages["_Index"]["sleitnick_knit@1.5.1"].knit.Services.EquipmentService.RF.Leave:InvokeServer()end end;if game.Players.LocalPlayer:GetAttribute("equipment")and string.find(game.Players.LocalPlayer:GetAttribute("equipment"),n.Name)then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=n.root.CFrame else if not game.Players.LocalPlayer:GetAttribute("equipment")or game.Players.LocalPlayer:GetAttribute("equipment")==""then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=n.root.CFrame;task.wait(.1)aC(n.root:FindFirstChild("ProximityPrompt"))task.wait(1)end end end end end;local function aK(aL)if workspace:FindFirstChild("Equipments")then for H,a2 in ipairs(workspace.Equipments:GetChildren())do if a2.Name==aL and not a2:GetAttribute("occupied")then return a2 end end else for H,R in ipairs(workspace:GetChildren())do if R:IsA("Model")and R:FindFirstChild("Equipments")then for H,a2 in ipairs(R.Equipments:GetChildren())do if a2.Name==aL and not a2:GetAttribute("occupied")then return a2 end end end end end;return nil end;task.spawn(function()while task.wait()do local i,j=pcall(function()if getgenv().SaveConfig.AutoFarm then local aM=game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Frame:FindFirstChild("APercentage").Text:gsub("[^%d%.]","")local aN=tonumber(aM)if game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Buy.Visible then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CharacterService"):WaitForChild("RF"):WaitForChild("NextAlter"):InvokeServer()end;if game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Locked.Visible then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("WorldService"):WaitForChild("RF"):WaitForChild("unlock"):InvokeServer()end;for Q,n in pairs(workspace:GetChildren())do if n.ClassName=="Model"and n:FindFirstChild("GetQuest")then if n.Name=="P3NT"then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("giveStoryQuest"):InvokeServer("P_3NT")task.wait(.1)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("complete"):InvokeServer("P_3NT")else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("giveStoryQuest"):InvokeServer(tostring(n.Name))task.wait(.1)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("complete"):InvokeServer(tostring(n.Name))end end end;if aw()then repeat task.wait()if not game:GetService("Players").LocalPlayer:GetAttribute("inPodiumQueue")then aA()end;if getgenv().SaveConfig.AutoEquipGearSlot and(getgenv().SaveConfig.MoneyGear~=nil or getgenv().SaveConfig.MoneyGear~="")then aq(getgenv().SaveConfig.MoneyGear)end until game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or az()or not getgenv().SaveConfig.AutoFarm elseif game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or az()then else if getgenv().SaveConfig.AutoEquipGearSlot and(getgenv().SaveConfig.FarmGear~=nil or getgenv().SaveConfig.FarmGear~="")then aq(getgenv().SaveConfig.FarmGear)end;if aN and aN>=100 then task.spawn(aI)else for H,aO in ipairs(U())do if string.lower(aO.Name)==Y()then if game.Players.LocalPlayer:GetAttribute("equipment")and string.find(game.Players.LocalPlayer:GetAttribute("equipment"),Y())then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=aO.root.CFrame elseif aO:GetAttribute("occupied")and aK(string.lower(aO.Name))==nil then task.spawn(aI)else aE(Y(),aO,true)end end end end end end end)if not i then warn("Error occurred: "..tostring(j))end end end)task.spawn(function()while task.wait()do local i,j=pcall(function()if getgenv().SaveConfig.AutoFarmTicket then if#workspace:WaitForChild("Folder"):GetChildren()>0 then ae(a9())a9():Destroy()else if getgenv().SaveConfig.EnableHop then E()end end end end)if not i then warn("Error occurred: "..tostring(j))end end end)task.spawn(function()while task.wait()do local i,j=pcall(function()if getgenv().SaveConfig.AutoComp then local ax=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"Starts in (%d+) sec")local aP=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"load in (%d+) seconds")local ay=string.match(workspace.Podium.entrance.billboard.billboard.labelText.Text,">(.-)<")if ay and ax or aP and tonumber(aP)<=50 then if ax and tonumber(ax)<=10 then repeat task.wait()if game:GetService("Players").LocalPlayer:GetAttribute("equipment")==nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end;if not game:GetService("Players").LocalPlayer:GetAttribute("inPodiumQueue")then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("MiniPodiumService"):WaitForChild("RF"):WaitForChild("Teleport"):InvokeServer()end until az()or game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or not getgenv().SaveConfig.AutoComp end elseif az()or game:GetService("Players").LocalPlayer:GetAttribute("inPodium")then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text~="Auto Click: ON"then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)else game:GetService("GuiService").SelectedObject=nil end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.Visible then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.Visible then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)end else if getgenv().SaveConfig.EnableHop then E()end end end end)if not i then warn("Error occurred: "..tostring(j))end end end)local aQ={}for H,n in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.GymStore.PowerUps.CanvasGroup.List:GetChildren())do if n:IsA("Frame")then table.insert(aQ,tostring(n.Name))end end;d.Boost:Dropdown({Title="Select Boost",Values=aQ,Value=getgenv().SaveConfig.BuyThing,Multi=true,Callback=function(r)o("BuyThing",r)end})d.Boost:Toggle({Title="Auto Active Boost",Value=getgenv().SaveConfig.AutoActiveBoost,Callback=function(r)o("AutoActiveBoost",r)end})task.spawn(function()while task.wait()do local i,j=pcall(function()if getgenv().SaveConfig.AutoActiveBoost then for H,aR in pairs(game.Players.LocalPlayer:FindFirstChild("Backpack"):GetChildren())do if aR:IsA("Tool")then for H,aR in ipairs(game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):GetChildren())do if aR:IsA("Tool")then t:EquipTool(aR)aR:Activate()end end;for H,aR in ipairs(game:GetService("Players").LocalPlayer.Character:GetChildren())do if aR:IsA("Tool")then aR:Activate()end end end end end end)if not i then warn("Error occurred: "..tostring(j))end end end)task.spawn(function()while task.wait()do local i,j=pcall(function()if getgenv().SaveConfig.AutoActiveBoost then local aS=getgenv().SaveConfig.BuyThing;for H,n in pairs(aS)do local al=tostring(n):gsub(" ","")if not ak(al)then print("Buying:",n)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PowerUpsService"):WaitForChild("RF"):WaitForChild("Buy"):InvokeServer(n,1)end;task.wait(.3)end end end)if not i then warn("Error occurred: "..tostring(j))end end end)local aT={Common=Color3.fromRGB(190,190,190),Rare=Color3.fromRGB(93,155,255),Epic=Color3.fromRGB(177,99,255),Legendary=Color3.fromRGB(255,161,53),Mythic=Color3.fromRGB(255,47,47)}task.spawn(function()while task.wait()do local i,j=pcall(function()if getgenv().SaveConfig.RollPost then for Q,n in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Customize.Pages.Poses.Poses.altFrame.List.UnownedList:GetChildren())do if n:IsA("ImageButton")then if n.Rarity.ImageColor3==aT.Mythic then if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Customize.Pages.Poses.Poses.altFrame.List.OwnedList.Reroll.Left.Text,"Left")then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PoseService"):WaitForChild("RF"):WaitForChild("Spin"):InvokeServer()else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PoseService"):WaitForChild("RF"):WaitForChild("Buy"):InvokeServer()end;task.wait(.2)end end end end end)if not i then warn("Error occurred: "..tostring(j))end end end)local function aU()local aV={}for Q,n in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.GearsLoadout.Pages.InfoFrame.List:GetChildren())do if n:IsA("Frame")and n.Name=="Template"and n.Title.Text~="N/A"then table.insert(aV,n.Title.Text)end end;return aV end;local aW=d.Gear:Dropdown({Title="Select Muscle Gear",Values=aU(),Value=getgenv().SaveConfig.FarmGear,Callback=function(r)o("FarmGear",r)end})local aX=d.Gear:Dropdown({Title="Select Money Gear",Values=aU(),Value=getgenv().SaveConfig.MoneyGear,Callback=function(r)o("MoneyGear",r)end})d.Gear:Button({Title="Refresh Gear",Callback=function()aW:Refresh(aU())aX:Refresh(aU())end})d.Gear:Toggle({Title="Auto Equip Gear",Value=getgenv().SaveConfig.AutoEquipGearSlot,Callback=function(r)o("AutoEquipGearSlot",r)end})d.Misc:Toggle({Title="Auto Roll Post",Value=getgenv().SaveConfig.RollPost,Callback=function(r)o("RollPost",r)end})d.Misc:Toggle({Title="Hide Text",Value=getgenv().SaveConfig.HideText,Callback=function(r)o("HideText",r)end})d.Misc:Paragraph({Title="Risk!!",Desc="Use at ur own risk",Image="triangle-alert",Color="Red"})d.Misc:Toggle({Title="Inf Spin Ticket",Value=getgenv().SaveConfig.SpinTicket,Callback=function(r)o("SpinTicket",r)end})d.Server:Button({Title="Rejoin",Callback=function()game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)end})d.Server:Button({Title="Server Hop",Callback=function()E()end})task.spawn(function()game:GetService("Players").LocalPlayer.PlayerGui.Main.Popup.ChildAdded:Connect(function(aY)if aY:IsA("Frame")then if getgenv().SaveConfig.HideText then aY.Visible=false end end end)end)task.spawn(function()while task.wait()do if getgenv().SaveConfig.SpinTicket then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("LimitedTimeEventService"):WaitForChild("RF"):WaitForChild("Spin"):InvokeServer()task.wait(1)end end end)task.spawn(function()while task.wait()do if game:GetService("Players").LocalPlayer:GetAttribute("equipment")and game:GetService("Players").LocalPlayer:GetAttribute("equipment")~=""then if not game:GetService("Players").LocalPlayer:GetAttribute("autoTrainEnabled")then game:GetService("Players").LocalPlayer:SetAttribute("autoTrainEnabled",true)end end;if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text,"Auto Click:")then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text~="Auto Click: ON"then if game:GetService("GuiService").SelectedObject~=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick else game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)task.wait(1)end else game:GetService("GuiService").SelectedObject=nil end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.Visible then if game:GetService("GuiService").SelectedObject~=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue else game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)task.wait(1)end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.Visible then if game:GetService("GuiService").SelectedObject~=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok else game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)task.wait(1)end end end end)game:GetService("Players").LocalPlayer.Idled:Connect(function()game:GetService("VirtualUser"):CaptureController()game:GetService("VirtualUser"):ClickButton2(Vector2.new())end)
