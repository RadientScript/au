local a=syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function()end;if a then a([[loadstring(game:HttpGet("https://raw.githubusercontent.com/RadientScript/au/refs/heads/main/padka.lua"))()]])else warn("queue_on_teleport is not supported in this executor.")end;repeat task.wait()until game:IsLoaded()repeat task.wait()until game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Loading").Enabled==false;local b=loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()local c=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()local d=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()local e=b:CreateWindow{Title="Fluent",SubTitle="Gym Leauge | V.1.1",TabWidth=160,Size=UDim2.fromOffset(830,525),Resize=true,MinSize=Vector2.new(470,380),Acrylic=true,Theme="Dark",MinimizeKey=Enum.KeyCode.RightControl}local f={Main=e:CreateTab({Title="Main",Icon="phosphor-users-bold"}),Server=e:CreateTab({Title="Server",Icon=""}),Settings=e:CreateTab({Title="Settings",Icon="settings"})}local g=b.Options;local h=""local i={"benchpress","treadmill","frontsquat","crunch","legpress","wristcurl","hammercurl","deadlift","pushpress","tricepscurl"}f.Main:CreateToggle("AutoFarm",{Title="Auto KaiTun",Default=false})f.Main:CreateToggle("AutoFarmRandom",{Title="Auto Farm Random",Default=false})f.Main:CreateToggle("AutoYeti",{Title="Auto Yeti",Default=false})f.Main:CreateToggle("AutoFarmStamina",{Title="Auto Stamina",Default=false})f.Main:CreateToggle("AutoComp",{Title="Auto Competition",Default=false})f.Main:CreateToggle("AutoTrain",{Title="Auto Train",Default=false})f.Main:CreateToggle("AutoUse",{Title="Auto Use Boost",Default=true})f.Main:CreateToggle("AutoGear",{Title="Auto Random Gear",Default=false})f.Main:CreateToggle("OpenQueue",{Title="Advance Queue",Default=true})f.Main:CreateToggle("EnableHop",{Title="Enable Hop",Default=true})f.Main:CreateButton({Title="Change Equipment",Description="",Callback=function()h=i[math.random(#i)]print(h)end})f.Main:CreateButton({Title="See Competition",Description="",Callback=function()workspace.Podium.entrance.billboard.billboard.MaxDistance=9e9 end})local j=""local k=false;local l=false;local m=false;local n=false;local o=0;local p=game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()local q=p:WaitForChild("Humanoid")local function r(s)local t=#s;for u=t,2,-1 do local v=math.random(u)s[u],s[v]=s[v],s[u]end end;local w=game.PlaceId;local x=game.JobId;local function y(z,A)pcall(function()game:GetService("StarterGui"):SetCore("SendNotification",{Title=z,Text=A,Duration=3})end)end;local function B(w,C)local D="https://games.roblox.com/v1/games/"..w.."/servers/Public?sortOrder=Desc&limit=100"if C then D=D.."&cursor="..C end;local E,F=pcall(function()return game:GetService("HttpService"):JSONDecode(game:HttpGet(D))end)if E and F then return F else return nil end end;local function G()y("Server Hop","Searching for a new server...")local C=nil;local H=false;repeat local I=B(w,C)if I and I.data and#I.data>0 then for J,K in ipairs(I.data)do if K.playing<K.maxPlayers and K.id~=x then y("Server Hop","Found a server! Joining...")local E,L=pcall(function()game:GetService("TeleportService"):TeleportToPlaceInstance(w,K.id,game.Players.LocalPlayer)end)if E then H=true;break else warn("Failed to teleport:",L)end end end end;if I then C=I.nextPageCursor else warn("Failed to retrieve server list.")break end;task.wait(1)until not C or H;if not H then y("Server Hop","No suitable servers found.")end end;local M={"Chest","Triceps","Shoulder","Back","Forearm","Biceps","Calves","Legs","Abs"}local function N(O)for P,Q in ipairs(M)do if Q==O then return P end end;return#M+1 end;local function R()local S={}local T=game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList;local U=T.FullBody.Frame:FindFirstChild("APercentage").Text:gsub("[^%d%.]","")local V=T.Stamina.Frame:FindFirstChild("APercentage").Text:gsub("[^%d%.]","")local o=tonumber(U)for J,W in pairs(T.Stats:GetChildren())do if W:IsA("ImageButton")and W:FindFirstChild("Frame")then local X=W.Frame:FindFirstChild("APercentage")and W.Frame.APercentage.Text;local Y=X:gsub("[^%d%.]","")table.insert(S,{Name=W.Name,Percentage=tonumber(Y)})end end;table.sort(S,function(Z,_)return N(Z.Name)>N(_.Name)end)for J,a0 in ipairs(S)do if tonumber(V)<100 then j="treadmill"elseif a0.Percentage<100 then local a1={Chest="benchpress",Triceps={"triceppushdown","tricepscurl"},Shoulder={"shoulderpress","pushpress"},Back={"rowing","deadlift"},Biceps={"barcable","hammercurl"},Forearm="wristcurl",Legs="legpress",Abs="crunch",Calves="frontsquat"}local a2=a1[a0.Name]if type(a2)=="table"then for J,a3 in ipairs(a2)do if workspace.Equipments:FindFirstChild(a3)then j=a3;break end end elseif workspace.Equipments:FindFirstChild(a2)then j=a2 else j="treadmill"end elseif o>=100 then if not h or h==""then for J,a3 in ipairs(i)do if workspace.Equipments:FindFirstChild(a3)then h=a3;break end end end;j=h end end end;local function a4(a5)for a6,a7 in pairs(game:GetService("Players").LocalPlayer:GetAttributes())do if string.find(a6,"Boost")and string.find(a6,a5)then return true end end;return false end;local function a8(a9)if game.Players.LocalPlayer:GetAttribute("ragdolled")==nil or game.Players.LocalPlayer:GetAttribute("ragdolled")==false then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")==nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then if not l then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=a9 else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("MiniPodiumService"):WaitForChild("RF"):WaitForChild("Teleport"):InvokeServer()end else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end end;local function aa(ab)ab:Activate()print("Used item:",ab.Name)task.wait(1)end;local function ac(ad)if ad and ad:IsA("ProximityPrompt")then ad.Enabled=true;ad.HoldDuration=0;ad.RequiresLineOfSight=false;ad.MaxActivationDistance=math.huge;fireproximityprompt(ad)end end;local function ae(af)if af:FindFirstChild("HumanoidRootPart")then local ag=af.HumanoidRootPart;if ag:FindFirstChild("BodyPosition")then ag.BodyPosition:Destroy()end;if ag:FindFirstChild("BodyGyro")then ag.BodyGyro:Destroy()end;local ah=Instance.new("BodyPosition")ah.Position=ag.Position;ah.MaxForce=Vector3.new(1e6,1e6,1e6)ah.P=3000;ah.Parent=ag;local ai=Instance.new("BodyGyro")ai.CFrame=ag.CFrame;ai.MaxTorque=Vector3.new(1e6,1e6,1e6)ai.P=3000;ai.Parent=ag end end;local function aj(ak,al,am)if am then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")then if string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),ak)then else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end end;if not game:GetService("Players").LocalPlayer:GetAttribute("equipment")or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=al.root.CFrame;task.wait(.1)ac(al.root:FindFirstChild("ProximityPrompt"))task.wait(1)end end;local function an()for u,W in pairs(workspace.Equipments:GetChildren())do if W.Name==h then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")then if string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),h)then else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end;if W:GetAttribute("occupied")and game:GetService("Players").LocalPlayer:GetAttribute("equipment")and string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),W.Name)then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=W.root.CFrame elseif W:GetAttribute("occupied")then h=i[math.random(#i)]else if not game:GetService("Players").LocalPlayer:GetAttribute("equipment")or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=W.root.CFrame;task.wait(.1)ac(W.root:FindFirstChild("ProximityPrompt"))task.wait(1)end end end end end;local function ao()if game:GetService("Players").LocalPlayer:GetAttribute("equipment")and(game:GetService("Players").LocalPlayer:GetAttribute("equipment")~=nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")~="")then if not game:GetService("Players").LocalPlayer:GetAttribute("autoTrainEnabled")or game:GetService("Players").LocalPlayer:GetAttribute("autoTrainEnabled")==false then game:GetService("Players").LocalPlayer:SetAttribute("autoTrainEnabled",true)end end end;local function ap(aq)for J,ar in pairs(workspace.Equipments:GetChildren())do if ar.Name==aq and not ar:GetAttribute("occupied")then return ar end end;return nil end;task.spawn(function()while task.wait()do h=i[math.random(#i)]print("Random :",h)task.wait(300)end end)task.spawn(function()while task.wait()do local E,L=pcall(function()local as=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"Starts in (%d+) sec")local at=string.match(workspace.Podium.entrance.billboard.billboard.labelText.Text,">(.-)<")if at then if g.OpenQueue.Value then if as then as=tonumber(as)if as<=5 then l=true else l=false end else l=false end else if string.find(at,"Competition")then if as then as=tonumber(as)if as<=5 then l=true else l=false end else l=false end end end end;if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible then k=true else k=false end;if g.AutoTrain.Value then ao()end;if g.AutoGear.Value then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("RouletteService"):WaitForChild("RF"):WaitForChild("Roll"):InvokeServer("Basic Crate",false)task.wait(1)end;if g.AutoUse.Value then for J,ab in ipairs(game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):GetChildren())do if ab:IsA("Tool")then q:EquipTool(ab)aa(ab)end end;for J,ab in ipairs(game:GetService("Players").LocalPlayer.Character:GetChildren())do if ab:IsA("Tool")then aa(ab)end end end;if g.AutoFarmRandom.Value then an()ao()end;if g.AutoFarmStamina.Value then for u,W in pairs(workspace.Equipments:GetChildren())do ao()if tostring(W.Name)=="treadmill"and not W:GetAttribute("occupied")then task.wait()if not game:GetService("Players").LocalPlayer:GetAttribute("equipment")or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==nil then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=W.root.CFrame;task.wait()ac(W.root:FindFirstChild("ProximityPrompt"))end;task.wait(1)end end end end)if not E then warn("Error occurred: "..tostring(L))end end end)task.spawn(function()while task.wait()do local E,L=pcall(function()if g.AutoFarm.Value then R()if game:GetService("Players").LocalPlayer:GetAttribute("equipment")and game:GetService("Players").LocalPlayer:GetAttribute("equipment")~=""then game:GetService("Players").LocalPlayer:SetAttribute("autoTrainEnabled",true)end;if game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Buy.Visible then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CharacterService"):WaitForChild("RF"):WaitForChild("NextAlter"):InvokeServer()end;if game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Locked.Visible then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("WorldService"):WaitForChild("RF"):WaitForChild("unlock"):InvokeServer()end;for u,W in pairs(workspace:GetChildren())do if W.ClassName=="Model"and W:FindFirstChild("GetQuest")then if W.Name=="P3NT"then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("giveStoryQuest"):InvokeServer("P_3NT")task.wait(.1)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("complete"):InvokeServer("P_3NT")else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("giveStoryQuest"):InvokeServer(tostring(W.Name))task.wait(.1)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("complete"):InvokeServer(tostring(W.Name))end end end;if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text,"Auto Click:")then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text~="Auto Click: ON"then if game:GetService("GuiService").SelectedObject~=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick else game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)task.wait(1)end else game:GetService("GuiService").SelectedObject=nil end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.Visible then if game:GetService("GuiService").SelectedObject~=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue else game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)task.wait(1)end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.Visible then if game:GetService("GuiService").SelectedObject~=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok else game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)task.wait(1)end end;for au,av in pairs(workspace.Equipments:GetChildren())do if l then repeat task.wait()if not game:GetService("Players").LocalPlayer:GetAttribute("inPodiumQueue")then a8()end until game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or k or not g.AutoFarm.Value elseif game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or k then elseif workspace:FindFirstChild("npcSpawns")and#workspace:FindFirstChild("npcSpawns"):GetChildren()>0 then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")and(game:GetService("Players").LocalPlayer:GetAttribute("equipment")~=nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")~="")then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end;for u,W in pairs(workspace.npcSpawns:GetChildren())do if W:FindFirstChild("Humanoid")and W:FindFirstChild("HumanoidRootPart")then repeat task.wait()W:FindFirstChild("HumanoidRootPart").Anchored=true;game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=W:FindFirstChild("HumanoidRootPart").CFrame*CFrame.new(0,-1,5)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CombatService"):WaitForChild("RF"):WaitForChild("M1"):InvokeServer()until g.AutoFarm.Value==false or l or W:FindFirstChild("Humanoid").Health<=0 end end elseif o<100 then if tostring(av.Name)==j then if av:GetAttribute("occupied")and game:GetService("Players").LocalPlayer:GetAttribute("equipment")and string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),j)then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=av.root.CFrame elseif av:GetAttribute("occupied")and ap(av.Name)==nil then an()else aj(j,av,true)end end elseif o>=100 then an()end end end end)if not E then warn("Error occurred: "..tostring(L))end end end)task.spawn(function()while task.wait()do local E,L=pcall(function()if g.AutoYeti.Value then if#workspace:FindFirstChild("npcSpawns"):GetChildren()>0 then for u,W in pairs(workspace.npcSpawns:GetChildren())do if W:FindFirstChild("Humanoid")and W:FindFirstChild("HumanoidRootPart")then repeat task.wait()W:FindFirstChild("HumanoidRootPart").Anchored=true;game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=W:FindFirstChild("HumanoidRootPart").CFrame*CFrame.new(0,-1,5)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CombatService"):WaitForChild("RF"):WaitForChild("M1"):InvokeServer()until not(W:FindFirstChild("Humanoid")and W:FindFirstChild("HumanoidRootPart"))or not g.AutoYeti.Value end end else if g.EnableHop.Value then G()end end end end)if not E then warn("Error occurred: "..tostring(L))end end end)task.spawn(function()while task.wait()do local E,L=pcall(function()if g.AutoComp.Value then local as=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"Starts in (%d+) sec")local aw=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"load in (%d+) seconds")local at=string.match(workspace.Podium.entrance.billboard.billboard.labelText.Text,">(.-)<")if at and as or aw and tonumber(aw)<=50 then if as and tonumber(as)<=5 then repeat task.wait()if game:GetService("Players").LocalPlayer:GetAttribute("equipment")==nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end;if not game:GetService("Players").LocalPlayer:GetAttribute("inPodiumQueue")then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("MiniPodiumService"):WaitForChild("RF"):WaitForChild("Teleport"):InvokeServer()end until k or game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or not g.AutoComp.Value end elseif k or game:GetService("Players").LocalPlayer:GetAttribute("inPodium")then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text~="Auto Click: ON"then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)else game:GetService("GuiService").SelectedObject=nil end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.Visible then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.Visible then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)end else if g.EnableHop.Value then G()end end end end)if not E then warn("Error occurred: "..tostring(L))end end end)local ax={}for J,W in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.GymStore.PowerUps.CanvasGroup.List:GetChildren())do if W:IsA("Frame")then table.insert(ax,tostring(W.Name))end end;local ay=f.Main:CreateDropdown("BuyThing",{Title="Select To Buy",Values=ax,Multi=true,Default={}})ay:OnChanged(function(az)local aA={}for az,aB in next,az do aA[#aA+1]=az end;print("Buydropdown changed:",table.concat(aA,","))end)f.Main:CreateToggle("AutoBuy",{Title="Auto Buy",Default=false})local aC={Common=Color3.fromRGB(190,190,190),Rare=Color3.fromRGB(93,155,255),Epic=Color3.fromRGB(177,99,255),Legendary=Color3.fromRGB(255,161,53),Mythic=Color3.fromRGB(255,47,47)}task.spawn(function()while task.wait()do local E,L=pcall(function()if g.AutoBuy.Value then local aD=g.BuyThing.Value;for P,J in pairs(aD)do local a5=P:gsub(" ","")if not a4(a5)then print("Buying:",P)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PowerUpsService"):WaitForChild("RF"):WaitForChild("Buy"):InvokeServer(P,2)end;task.wait(.3)end end end)if not E then warn("Error occurred: "..tostring(L))end end end)f.Main:CreateToggle("RollPost",{Title="Auto Roll Post",Default=false})task.spawn(function()while task.wait()do local E,L=pcall(function()if g.RollPost.Value then for u,W in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Customize.Pages.Poses.Poses.altFrame.List.UnownedList:GetChildren())do if W:IsA("ImageButton")then if W.Rarity.ImageColor3==aC.Mythic then if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Customize.Pages.Poses.Poses.altFrame.List.OwnedList.Reroll.Left.Text,"Left")then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PoseService"):WaitForChild("RF"):WaitForChild("Spin"):InvokeServer()else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PoseService"):WaitForChild("RF"):WaitForChild("Buy"):InvokeServer()end;task.wait(.2)end end end end end)if not E then warn("Error occurred: "..tostring(L))end end end)f.Server:CreateButton({Title="Server Hop",Description="",Callback=function()G()end})f.Server:CreateButton({Title="Rejoin",Description="",Callback=function()game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)end})game:GetService("Players").LocalPlayer.Idled:Connect(function()game:GetService("VirtualUser"):CaptureController()game:GetService("VirtualUser"):ClickButton2(Vector2.new())end)spawn(function()while true do wait()if setscriptable then setscriptable(game.Players.LocalPlayer,"SimulationRadius",true)end;if sethiddenproperty then sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)end end end)c:SetLibrary(b)d:SetLibrary(b)c:IgnoreThemeSettings()c:SetIgnoreIndexes({})d:SetFolder("GymLeauge")c:SetFolder("GymLeauge/JayJay")d:BuildInterfaceSection(f.Settings)c:BuildConfigSection(f.Settings)e:SelectTab(1)c:LoadAutoloadConfig()
