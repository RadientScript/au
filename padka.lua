local a=syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function()end;if a then a([[loadstring(game:HttpGet("https://raw.githubusercontent.com/RadientScript/au/refs/heads/main/padka.lua"))()]])else warn("queue_on_teleport is not supported in this executor.")end;repeat task.wait()until game:IsLoaded()repeat task.wait()until game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Loading").Enabled==false;local b=loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()local c=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()local d=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()local e=b:CreateWindow{Title="Fluent",SubTitle="Gym Leauge",TabWidth=160,Size=UDim2.fromOffset(830,525),Resize=true,MinSize=Vector2.new(470,380),Acrylic=true,Theme="Dark",MinimizeKey=Enum.KeyCode.RightControl}local f={Main=e:CreateTab({Title="Main",Icon="phosphor-users-bold"}),Server=e:CreateTab({Title="Server",Icon=""}),Settings=e:CreateTab({Title="Settings",Icon="settings"})}local g=b.Options;local h=""local i={"benchpress","treadmill","frontsquat","crunch","legpress","wristcurl","hammercurl","deadlift","pushpress","tricepscurl"}f.Main:CreateToggle("AutoFarm",{Title="Auto KaiTun",Default=false})f.Main:CreateToggle("AutoFarmRandom",{Title="Auto Farm Random",Default=false})f.Main:CreateToggle("AutoYeti",{Title="Auto Yeti",Default=false})f.Main:CreateToggle("AutoFarmStamina",{Title="Auto Stamina",Default=false})f.Main:CreateToggle("AutoComp",{Title="Auto Competition",Default=false})f.Main:CreateToggle("AutoTrain",{Title="Auto Train",Default=false})f.Main:CreateToggle("AutoUse",{Title="Auto Use Boost",Default=true})f.Main:CreateToggle("AutoGear",{Title="Auto Random Gear",Default=false})f.Main:CreateToggle("OpenQueue",{Title="Advance Queue",Default=true})f.Main:CreateToggle("EnableHop",{Title="Enable Hop",Default=false})f.Main:CreateButton({Title="Change Equipment",Description="",Callback=function()h=i[math.random(#i)]print(h)end})f.Main:CreateButton({Title="See Competition",Description="",Callback=function()workspace.Podium.entrance.billboard.billboard.MaxDistance=9e9 end})local j=""local k=false;local l=false;local m=false;local n=false;local o=0;local p=game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()local q=p:WaitForChild("Humanoid")local function r(s)local t=#s;for u=t,2,-1 do local v=math.random(u)s[u],s[v]=s[v],s[u]end end;local w=game.PlaceId;local x=game.JobId;local function y(z,A)pcall(function()game:GetService("StarterGui"):SetCore("SendNotification",{Title=z,Text=A,Duration=3})end)end;local function B(w,C)local D="https://games.roblox.com/v1/games/"..w.."/servers/Public?sortOrder=Desc&limit=100"if C then D=D.."&cursor="..C end;local E,F=pcall(function()return game:GetService("HttpService"):JSONDecode(game:HttpGet(D))end)if E and F then return F else return nil end end;local function G()y("Server Hop","Searching for a new server...")local C=nil;local H=false;repeat local I=B(w,C)if I and I.data and#I.data>0 then for J,K in ipairs(I.data)do if K.playing<K.maxPlayers and K.id~=x then y("Server Hop","Found a server! Joining...")local E,L=pcall(function()game:GetService("TeleportService"):TeleportToPlaceInstance(w,K.id,game.Players.LocalPlayer)end)if E then H=true;break else warn("Failed to teleport:",L)end end end end;if I then C=I.nextPageCursor else warn("Failed to retrieve server list.")break end;task.wait(1)until not C or H;if not H then y("Server Hop","No suitable servers found.")end end;local function M()for J,N in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.Stats:GetChildren())do if N:IsA("ImageButton")then if N:FindFirstChild("Frame")and N.Frame:FindFirstChild("APercentage")then local O=N.Frame.APercentage.Text:gsub("[^%d%.]","")local P=tonumber(O)local Q=game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Frame:FindFirstChild("APercentage").Text:gsub("[^%d%.]","")local o=tonumber(Q)local R=game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.Stamina.Frame:FindFirstChild("APercentage").Text:gsub("[^%d%.]","")local S=tonumber(R)if S<100 then j="treadmill"elseif P<100 then local T={Chest="benchpress",Triceps={"triceppushdown","tricepscurl"},Shoulder={"shoulderpress","pushpress"},Back={"deadlift","rowing"},Biceps={"barcable","hammercurl"},Forearm="wristcurl",Legs="legpress",Abs="crunch",Calves="frontsquat"}local U=T[N.Name]if type(U)=="table"then for J,V in ipairs(U)do if workspace.Equipments:FindFirstChild(V)then j=V;break end end elseif type(U)=="string"and workspace.Equipments:FindFirstChild(U)then j=U else j="treadmill"end elseif o>=100 then if h==""or h==nil then for J,V in ipairs(i)do if workspace.Equipments:FindFirstChild(V)then h=V;break end end end;j=h end end end end end;local function W(X)if game.Players.LocalPlayer:GetAttribute("ragdolled")==nil or game.Players.LocalPlayer:GetAttribute("ragdolled")==false then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")==nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then if not l then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=X else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("MiniPodiumService"):WaitForChild("RF"):WaitForChild("Teleport"):InvokeServer()end else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end end;local function Y(Z)Z:Activate()print("Used item:",Z.Name)task.wait(1)end;local function _(a0)if a0 and a0:IsA("ProximityPrompt")then a0.Enabled=true;a0.HoldDuration=0;a0.RequiresLineOfSight=false;a0.MaxActivationDistance=math.huge;fireproximityprompt(a0)end end;local function a1(a2,a3,a4)if a4 then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")then if string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),a2)then else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end end;if not game:GetService("Players").LocalPlayer:GetAttribute("equipment")or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=a3.root.CFrame;task.wait(.1)_(a3.root:FindFirstChild("ProximityPrompt"))task.wait(1)end end;local function a5()for u,N in pairs(workspace.Equipments:GetChildren())do if N.Name==h then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")then if string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),h)then else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end end;if N:GetAttribute("occupied")and game:GetService("Players").LocalPlayer:GetAttribute("equipment")and string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),N.Name)then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=N.root.CFrame elseif N:GetAttribute("occupied")then h=i[math.random(#i)]else if not game:GetService("Players").LocalPlayer:GetAttribute("equipment")or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=N.root.CFrame;task.wait(.1)_(N.root:FindFirstChild("ProximityPrompt"))task.wait(1)end end end end end;local function a6()if game:GetService("Players").LocalPlayer:GetAttribute("equipment")and(game:GetService("Players").LocalPlayer:GetAttribute("equipment")~=nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")~="")then if not game:GetService("Players").LocalPlayer:GetAttribute("autoTrainEnabled")or game:GetService("Players").LocalPlayer:GetAttribute("autoTrainEnabled")==false then game:GetService("Players").LocalPlayer:SetAttribute("autoTrainEnabled",true)end end end;local function a7(a8)for J,a9 in pairs(workspace.Equipments:GetChildren())do if a9.Name==a8 and not a9:GetAttribute("occupied")then return a9 end end;return nil end;task.spawn(function()while task.wait()do h=i[math.random(#i)]print("Random :",h)task.wait(300)end end)task.spawn(function()while task.wait()do local E,L=pcall(function()local aa=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"Starts in (%d+) sec")local ab=string.match(workspace.Podium.entrance.billboard.billboard.labelText.Text,">(.-)<")if ab then if g.OpenQueue.Value then if aa then aa=tonumber(aa)if aa<=5 then l=true else l=false end else l=false end else if string.find(ab,"Competition")then if aa then aa=tonumber(aa)if aa<=5 then l=true else l=false end else l=false end end end end;if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible then k=true else k=false end;if g.AutoTrain.Value then a6()end;if g.AutoGear.Value then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("RouletteService"):WaitForChild("RF"):WaitForChild("Roll"):InvokeServer("Basic Crate",false)task.wait(1)end;if g.AutoUse.Value then for J,Z in ipairs(game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):GetChildren())do if Z:IsA("Tool")then q:EquipTool(Z)Y(Z)end end;for J,Z in ipairs(game:GetService("Players").LocalPlayer.Character:GetChildren())do if Z:IsA("Tool")then Y(Z)end end end;if g.AutoFarmRandom.Value then a5()a6()end;if g.AutoFarmStamina.Value then for u,N in pairs(workspace.Equipments:GetChildren())do a6()if tostring(N.Name)=="treadmill"and not N:GetAttribute("occupied")then task.wait()if not game:GetService("Players").LocalPlayer:GetAttribute("equipment")or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==nil then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=N.root.CFrame;task.wait()_(N.root:FindFirstChild("ProximityPrompt"))end;task.wait(1)end end end end)if not E then warn("Error occurred: "..tostring(L))end end end)task.spawn(function()while task.wait()do local E,L=pcall(function()if g.AutoFarm.Value then M()if game:GetService("Players").LocalPlayer:GetAttribute("equipment")and game:GetService("Players").LocalPlayer:GetAttribute("equipment")~=""then game:GetService("Players").LocalPlayer:SetAttribute("autoTrainEnabled",true)end;if game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Buy.Visible then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CharacterService"):WaitForChild("RF"):WaitForChild("NextAlter"):InvokeServer()end;if game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Locked.Visible then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("WorldService"):WaitForChild("RF"):WaitForChild("unlock"):InvokeServer()end;for u,N in pairs(workspace:GetChildren())do if N.ClassName=="Model"and N:FindFirstChild("GetQuest")then if N.Name=="P3NT"then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("giveStoryQuest"):InvokeServer("P_3NT")task.wait(.1)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("complete"):InvokeServer("P_3NT")else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("giveStoryQuest"):InvokeServer(tostring(N.Name))task.wait(.1)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("complete"):InvokeServer(tostring(N.Name))end end end;if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text,"Auto Click:")then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text~="Auto Click: ON"then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)else game:GetService("GuiService").SelectedObject=nil end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.Visible then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.Visible then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)end;for ac,ad in pairs(workspace.Equipments:GetChildren())do if l then repeat task.wait()if not game:GetService("Players").LocalPlayer:GetAttribute("inPodiumQueue")then W()end until game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or k or not g.AutoFarm.Value elseif game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or k then elseif workspace:FindFirstChild("npcSpawns")and#workspace:FindFirstChild("npcSpawns"):GetChildren()>0 then if game:GetService("Players").LocalPlayer:GetAttribute("equipment")and(game:GetService("Players").LocalPlayer:GetAttribute("equipment")~=nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")~="")then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end;for u,N in pairs(workspace.npcSpawns:GetChildren())do if N:FindFirstChild("Humanoid")and N:FindFirstChild("HumanoidRootPart")then repeat task.wait()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=N:FindFirstChild("HumanoidRootPart").CFrame*CFrame.new(0,0,5)task.wait()game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CombatService"):WaitForChild("RF"):WaitForChild("M1"):InvokeServer()until not g.AutoFarm.Value or l or not N:FindFirstChild("Humanoid")or N:FindFirstChild("Humanoid").Health<=0 end end elseif o<100 then if tostring(ad.Name)==j then if ad:GetAttribute("occupied")and game:GetService("Players").LocalPlayer:GetAttribute("equipment")and string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),j)then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=ad.root.CFrame elseif ad:GetAttribute("occupied")and a7(ad.Name)==nil then a5()else a1(j,ad,true)end end elseif o>=100 then a5()end end end end)if not E then warn("Error occurred: "..tostring(L))end end end)task.spawn(function()while task.wait()do local E,L=pcall(function()if g.AutoYeti.Value then if#workspace:FindFirstChild("npcSpawns"):GetChildren()>0 then for u,N in pairs(workspace.npcSpawns:GetChildren())do if N:FindFirstChild("Humanoid")and N:FindFirstChild("HumanoidRootPart")then repeat task.wait()if game:GetService("Players").LocalPlayer:GetAttribute("combat")then for J,ae in ipairs(workspace.weaponSpawns:GetChildren())do for J,ad in ipairs(ae:GetChildren())do if ad:FindFirstChild("ProximityPrompt")then ad.CFrame=game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame;_(ad:FindFirstChild("ProximityPrompt"))end end end end;game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=N:FindFirstChild("HumanoidRootPart").CFrame*CFrame.new(0,0,5)task.wait()game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CombatService"):WaitForChild("RF"):WaitForChild("M1"):InvokeServer()until not(N:FindFirstChild("Humanoid")and N:FindFirstChild("HumanoidRootPart"))or not g.AutoYeti.Value end end else if g.EnableHop.Value then G()end end end end)if not E then warn("Error occurred: "..tostring(L))end end end)task.spawn(function()while task.wait()do local E,L=pcall(function()if g.AutoComp.Value then local aa=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"Starts in (%d+) sec")local af=string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text,"load in (%d+) seconds")local ab=string.match(workspace.Podium.entrance.billboard.billboard.labelText.Text,">(.-)<")if ab and aa or af and tonumber(af)<=50 then if aa and tonumber(aa)<=5 then repeat task.wait()if game:GetService("Players").LocalPlayer:GetAttribute("equipment")==nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment")==""then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()end;if not game:GetService("Players").LocalPlayer:GetAttribute("inPodiumQueue")then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("MiniPodiumService"):WaitForChild("RF"):WaitForChild("Teleport"):InvokeServer()end until k or game:GetService("Players").LocalPlayer:GetAttribute("inPodium")or not g.AutoComp.Value end elseif k or game:GetService("Players").LocalPlayer:GetAttribute("inPodium")then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.Visible then if game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick.TextLabel.Text~="Auto Click: ON"then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames.AutoClick;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)else game:GetService("GuiService").SelectedObject=nil end end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.Visible then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)end;if game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.Visible then game:GetService("GuiService").SelectedObject=game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok;game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Return,false,game)task.wait(.1)game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Return,false,game)end else if g.EnableHop.Value then G()end end end end)if not E then warn("Error occurred: "..tostring(L))end end end)local ag={}for J,N in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.GymStore.PowerUps.CanvasGroup.List:GetChildren())do if N.ClassName=="Frame"then table.insert(ag,tostring(N.Name))end end;f.Main:CreateDropdown("BuyThing",{Title="Select To Buy",Values=ag,Multi=false,Default=nil})f.Main:CreateToggle("AutoBuy",{Title="Auto Buy",Default=false})local ah={Common=Color3.fromRGB(190,190,190),Rare=Color3.fromRGB(93,155,255),Epic=Color3.fromRGB(177,99,255),Legendary=Color3.fromRGB(255,161,53),Mythic=Color3.fromRGB(255,47,47)}f.Main:CreateToggle("RollPost",{Title="Auto Roll Post",Default=false})local ai=false;task.spawn(function()while task.wait()do local E,L=pcall(function()if g.AutoBuy.Value then local aj=g.BuyThing.Value:gsub(" ","")for ak,al in pairs(game:GetService("Players").LocalPlayer:GetAttributes())do if string.find(ak,"Boost")and string.find(ak,aj)then ai=true;break else ai=false end end;if not ai then print("Buying Boost:",g.BuyThing.Value)game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PowerUpsService"):WaitForChild("RF"):WaitForChild("Buy"):InvokeServer(tostring(g.BuyThing.Value),1)end;task.wait(1)end end)if not E then warn("Error occurred: "..tostring(L))end end end)task.spawn(function()while task.wait()do local E,L=pcall(function()if g.RollPost.Value then for u,N in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Customize.Pages.Poses.Poses.altFrame.List.UnownedList:GetChildren())do if N:IsA("ImageButton")then if N.Rarity.ImageColor3==ah.Mythic then if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Customize.Pages.Poses.Poses.altFrame.List.OwnedList.Reroll.Left.Text,"Left")then game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PoseService"):WaitForChild("RF"):WaitForChild("Spin"):InvokeServer()else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PoseService"):WaitForChild("RF"):WaitForChild("Buy"):InvokeServer()end;task.wait(.2)end end end end end)if not E then warn("Error occurred: "..tostring(L))end end end)f.Server:CreateButton({Title="Server Hop",Description="",Callback=function()G()end})f.Server:CreateButton({Title="Rejoin",Description="",Callback=function()game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)end})game:GetService("Players").LocalPlayer.Idled:Connect(function()game:GetService("VirtualUser"):CaptureController()game:GetService("VirtualUser"):ClickButton2(Vector2.new())end)spawn(function()while true do wait()if setscriptable then setscriptable(game.Players.LocalPlayer,"SimulationRadius",true)end;if sethiddenproperty then sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)end end end)c:SetLibrary(b)d:SetLibrary(b)c:IgnoreThemeSettings()c:SetIgnoreIndexes({})d:SetFolder("GymLeauge")c:SetFolder("GymLeauge/JayJay")d:BuildInterfaceSection(f.Settings)c:BuildConfigSection(f.Settings)e:SelectTab(1)c:LoadAutoloadConfig()
