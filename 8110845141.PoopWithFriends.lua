repeat wait() until game:IsLoaded();

-- Configuration
getrenv().AutoCollect = false;
getrenv().AutoTime = false;
getrenv().AutoTime500 = false;
getrenv().AutoArtillery = false;
getrenv().AutoTool = false;
getrenv().SecretFarm = false;
getrenv().AutoCrucible = false;

-- [[ Main UI ]] --

-- UI Lib
local Luminosity = loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/UILibs/LuminosityV1.lua"))();

-- Window Creation
local Window = Luminosity.new("Poop With Friends", "By Canario#3681", 1392380138);
local AutoFarmTab = Window.Tab("Auto Farm");
local TeleportTab = Window.Tab("Teleports");
local MiscTab = Window.Tab("Misc");

local TeleportsWeaponsFolder = TeleportTab.Folder("Weapons", "")
local TeleportsLocationsFolder = TeleportTab.Folder("Locations", "")
local MiscFolder = MiscTab.Folder("Misc", "")

function KillAllPlayers()
    print("KillAllPlayers() is disabled because it was glitchy");
end

function TeleportToPosAndFireProximity(pos, proximityPrompt)
    if game:GetService("Players").LocalPlayer.Character.Humanoid.Health <= 0 then
        --return;
    end
    
    if proximityPrompt:IsA("ProximityPrompt") then
        pcall(function()
            local distance = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - pos.Position).Magnitude;
            if distance >= 4 then
                --print("[TeleportToPosAndFireProximity] distance is " .. distance);
                if not tween then
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = pos;
                    wait(0.5);
                end
            end
        end)
        fireproximityprompt(proximityPrompt);
        wait(0.01);
    end
end

function TeleportToAndFireProximity(proximityPrompt)
    if game:GetService("Players").LocalPlayer.Character.Humanoid.Health <= 0 then
        return;
    end
    
    if proximityPrompt:IsA("ProximityPrompt") then
        pcall(function()
            if(proximityPrompt.Parent.CFrame ~= nil) then
                local distance = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - proximityPrompt.Parent.Position).Magnitude;
                if distance >= 4 then
                    --print("[TeleportToAndFireProximity] distance is " .. distance);
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = proximityPrompt.Parent.CFrame;
                    wait(0.6);
                end
            end
        end)
        fireproximityprompt(proximityPrompt);
        wait(0.015);
    end
end

-- Gives the disruptor and taser weapons
function GiveGuns()
    local gun1 = game:GetService("Workspace")["locked parts [do not select]"].Parte.ProximityPrompt
    local gun2 = game:GetService("Workspace")["locked parts [do not select]"].Parte2.ProximityPrompt
    
    local oldFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame;
    TeleportToAndFireProximity(gun1);
    TeleportToAndFireProximity(gun2);
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = oldFrame;
end

function RemoveProximityTimers()
    for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            v.HoldDuration = 0;
        end
    end 
end

function RemoveLazers()
    for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v.Name == "deathlaser" or v.Name == "lazer" and v:IsA("Part") and v.TouchInterest then
            v:Destroy();
        end
    end 
end

-- Menu Closing Function
game:GetService("UserInputService").InputBegan:Connect(function(Input, gameProcessedEvent)
    if Input.KeyCode == Enum.KeyCode.RightControl then
        Window:Toggle();
    end
    
    if gameProcessedEvent then return end
end)

-- [[ Auto Farm Tab ]] --

local Auto_Collect = AutoFarmTab.Cheat("Auto Collect", "Auto collect all time cubes.", function(boolean)
    AutoCollect = boolean;
end)


local Auto_Time = AutoFarmTab.Cheat("Auto Fertilize", "Auto spawns time cubes if a fertilizer exists in the world.", function(boolean)
    AutoTime = boolean;
end)

local Auto_500 = AutoFarmTab.Cheat("Auto 500t", "Farms the 500 time cube in the lazer obby", function(boolean)
    AutoTime500 = boolean;
end)

local Auto_Tool = AutoFarmTab.Cheat("Auto Tool", "Spams your currently equipped tool.", function(boolean)
    AutoTool = boolean;
end)

local Auto_Artillery = AutoFarmTab.Cheat("Auto Artillery", "Spam fires artillery.", function(boolean)
    AutoArtillery = boolean;
end)

local Auto_Secret = AutoFarmTab.Cheat("Unlock secret poop (WARNING..)", "Obtains the secret poop. Make sure your storage is empty and click the storage board to obtain it afterwards. (WARNING: this will kill you)", function(boolean)
    SecretFarm = boolean;
end)

local Auto_CrucibleKill = AutoFarmTab.Cheat("Auto Anti-Crucible", "Kill people who wield a crucible", function(boolean)
    AutoCrucible = boolean;
end)

-- Get Weapons
local Get_Weapons = TeleportsWeaponsFolder.Button("", "Get Weapons", function()
    GiveGuns();
end)

-- Teleport: Spawn Point
local Tele_Spawn = TeleportsLocationsFolder.Button("", "Spawn Point", function()
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-0.0979134515, 3.99999928, -0.187652856, 0.999600291, -3.98961575e-08, -0.0282716509, 3.79097109e-08, 1, -7.07989258e-08, 0.0282716509, 6.96988565e-08, 0.999600291)
end)

-- Teleport: Safety
local Tele_SafePlace = TeleportsLocationsFolder.Button("", "Safety", function()
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-337.144958, -79.2003632, -346.828522, -0.00322300964, 4.58476244e-08, 0.999994814, -9.84764004e-09, 1, -4.58796023e-08, -0.999994814, -9.99545868e-09, -0.00322300964);
end)

-- Click Storage 
local Click_Storage = MiscFolder.Button("", "Click Storage", function()
    firesignal(game:GetService("Players").LocalPlayer.PlayerGui.StorageUi.MainFrame.Slot1.MouseButton1Click)
end)

-- Killplayers
local Kill_Players = MiscFolder.Button("", "Kill Players", function()
    KillAllPlayers();
end)

-- Remove Lazers
local Remove_Lazers = MiscFolder.Button("", "No Lazers", function()
    RemoveLazers();
end)

-- Remove Proximity Timers
local Remove_Timers = MiscFolder.Button("", "Fast Timers", function()
    RemoveProximityTimers();
end)

-- Rejoin
local Rejoin_Server = MiscFolder.Button("", "Rejoin Server", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
end)

-- Hop
local Rejoin_Server = MiscFolder.Button("", "Hop Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)


-- [[ Cheat Logic ]] --

function GetCurrentTool()
    local player = game:GetService("Players").LocalPlayer;
    local currentTool = player.Character:FindFirstChildOfClass("Tool");  
    return currentTool;
end

function GetPlayerTool(player)
    if player.Character == nil then
        return nil;
    end
   return player.Character:FindFirstChildOfClass("Tool");
end

function HasTool(name)
    for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v.Name == name then
            v.Parent = game:GetService("Players").LocalPlayer.Character;
            return true;
        end
    end
    return false;
end

function SetTool(name)
    local player = game:GetService("Players").LocalPlayer;
    local currentTool = GetCurrentTool();
    
    if currentTool and currentTool.Name == name then
        print("[EquippedTool]: " .. currentTool.Name);
        return true;
    end
    
    for i,v in pairs(player.Backpack:GetChildren()) do
        if v.Name == name then
            v.Parent = game:GetService("Players").LocalPlayer.Character;
            return true;
        end
    end
    
    return false;
end

function UseTool()
    local tool = GetCurrentTool();
    if tool then tool:Activate(); end
end

function IsObjectToCollect(name)
    if name == "ferti" or name == "ferti6ver" or name == "goldferti" or name == "donet" or name == "golddonet" or name == "purpldonet" or name == "stolenmoney" or name == "moey" then
        return true;
    end
    return false;
end

function GetFertilizer()
    local cars = {};
    local tools = {};
   
    local result = nil;
                
    pcall(function()
        for _,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Part") and v.Name == "fertilizer" and v.Parent then
                if v.Parent:IsA("Model") then
                    table.insert(cars, v);
                elseif v.Parent:IsA("Tool") then
                    table.insert(tools, v);
                end
            end
        end
    end)

    if #cars >= 1 then
        result = cars[math.random(#cars)];
    elseif #tools >= 1 then
        result = tools[math.random(#tools)];
    end
    
    --print("[GetFertilizer] cars=" .. #cars .. ", tools=" .. #tools);
    
    return result;
end

function GetFertilizers()
    local cars = {};
    local tools = {};
   
    local result = nil;
                
    pcall(function()
        for _,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Part") and v.Name == "fertilizer" and v.Parent then
                if v.Parent:IsA("Model") then
                    table.insert(cars, v);
                elseif v.Parent:IsA("Tool") then
                    table.insert(tools, v);
                end
            end
        end
    end)

    if #cars >= 1 then
        result = cars;
    elseif #tools >= 1 then
        result = tools;
    end
    
    --print("[GetFertilizer] cars=" .. #cars .. ", tools=" .. #tools);
    
    return result;
end

function RandomizeTable(tbl)
	local returntbl={}
	if tbl[1]~=nil then
		for i=1,#tbl do
			table.insert(returntbl,math.random(1,#returntbl+1),tbl[i])
		end
	end
	return returntbl
end


function GetPoops()
    local result = nil;
    local poops = {};
    
    for _,v in pairs(game:GetService("Workspace").poopholder:GetChildren()) do
        if v.ClassName == "MeshPart" then
            table.insert(poops, v);
        end
    end
    
    if #poops >= 1 then
        result = RandomizeTable(poops);
    end
    
    return result;
end

function GetTimeCube()
    pcall(function()
        local hrp = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart;
        for _,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v.ClassName == "TouchTransmitter" then
                pcall(function()
                    if v.Parent and v.Parent.ClassName == "Part" and IsObjectToCollect(v.Parent.Name) then
                        firetouchinterest(hrp, v.Parent, 0)
                        wait(0.01);
                        firetouchinterest(hrp, v.Parent, 1)
                        return;
                    end
                end)
            end
        end
    end) 
end

function GetTimeCubes()
    local result = nil;
    local cubes = {};
    
    for _,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v.ClassName == "TouchTransmitter" then
            pcall(function()
                if v.Parent and v.Parent.ClassName == "Part" and IsObjectToCollect(v.Parent.Name) then
                    table.insert(cubes, v.Parent);
                end
            end)
        end
    end
    
    if #cubes >= 1 then
        result = RandomizeTable(cubes);
    end
    
    return result;  
end

-- THREAD: Collect
spawn(function()
    while wait(0.01) do
        if AutoCollect then
            GetTimeCube();
        end
    end
end)

spawn(function()
    while wait(1) do
        if AutoTime == true then
            pcall(function()
                local fertilizers = GetFertilizers();
                if fertilizers ~= nil and #fertilizers >= 1 then
                    local poops = GetPoops();
                    if poops ~= nil and #poops >= 1 then
                        print("[Auto-Fertilize]: " .. #fertilizers .. " (fertilizers) " .. #poops .. " (poops)");
                        pcall(function()
                            for _,v in pairs(fertilizers) do
                                if AutoTime == false then break; end
                                pcall(function()
                                    local poop = poops[math.random(#poops)];
                                    firetouchinterest(poop, v, 0)
                                    wait(0.1)
                                    firetouchinterest(poop, v, 1)
                                    wait(0.1);
                                end)
                            end
                            wait(0.5);
                        end)
                    else
                        print("[Auto-Fertilize] No poops found!");
                    end
                else
                    print("[Auto-Fertilize] No fertilizers found!");
                end
            end)
        end
    end
end)

-- Secret poopholder
spawn(function()
    local tissuePos = CFrame.new(-10.0531, 3.06, -2.47893);
    while wait(0.01) do
        pcall(function()
            if SecretFarm == true then
                for _,v in pairs(game:GetService("Workspace")["locked parts [do not select]"]:GetChildren()) do
                    if v.ClassName == "UnionOperation" and v.Name == "Tissue" and v.ProximityPrompt then
                        if SecretFarm then
                            if not HasTool("Poop [SECRET]") then
                                TeleportToPosAndFireProximity(tissuePos, v.ProximityPrompt);
                                wait(0.01);
                            else
                                SetTool("Poop [SECRET]");
                                wait(0.5);
                                firesignal(game:GetService("Players").LocalPlayer.PlayerGui.StorageUi.MainFrame.Slot1.MouseButton1Click)
                                SecretFarm = false;
                                print("[Auto-Secret] Attempted to save secret poop in storage!");
                            end
                        end
                    end
                end
            end
        end)
    end
end)

--Time500
spawn(function()
    -- 
    while wait(1) do
        pcall(function()
            if AutoTime500 then
                local robby = game:GetService("Workspace")["locked parts [do not select]"].robby;
                
                if robby and robby.ProximityPrompt and robby.gear and robby.gear.Playing == false then
                    RemoveLazers();
                    TeleportToAndFireProximity(robby.ProximityPrompt);
                    robby.gear.Volume = 0.05; -- it's an annoying sound :>
                end
            end
        end)
    end
end)

-- Artillery
spawn(function()
    local artPos = CFrame.new(-15.284, 3.404, -130.710);
    while wait(0.01) do
        -- Spam Artillery
        pcall(function()
            if AutoArtillery then
                local art1 = game:GetService("Workspace")["locked parts [do not select]"].yesd.Buttons.Head;
                local art2 = game:GetService("Workspace")["locked parts [do not select]"].yesd.Buttons.Head2;
                
                if art1 and art1.ProximityPrompt then
                    TeleportToPosAndFireProximity(artPos, art1.ProximityPrompt);
                end
                
                if art2 and art2.ProximityPrompt then
                    TeleportToPosAndFireProximity(artPos, art2.ProximityPrompt);
                end
                
                wait(0.01);
            else
                wait(1);
            end
        end)
    end
end)

-- Auto Tool
spawn(function()
    while wait(0.5) do
        pcall(function()
            if AutoTool and GetCurrentTool() then
                UseTool();
            end
        end)
    end
end)


-- [[ Anti AFK ]] --

wait(3);
local VirtualUser=game:service'VirtualUser';
game:service('Players').LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController();
    VirtualUser:ClickButton2(Vector2.new());
end)