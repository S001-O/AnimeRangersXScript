local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
	Name = "S000 - AnimeRangersX",
	Icon = 0,
	LoadingTitle = "Loading...",
	LoadingSubtitle = "by S001",
	Theme = "DarkBlue", -- Check https://docs.sirius.menu/rayfield/configuration/themes

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false,

	ConfigurationSaving = {
	  Enabled = true,
	  FolderName = "AnimeRangersX",
	  FileName = "AnimeRangersX_Save"
	},

	Discord = {
	  Enabled = false,
	  Invite = "noinvitelink",
	  RememberJoins = true
	},

	KeySystem = false,
	KeySettings = {
	  Title = "S001 Key",
	  Subtitle = "S001 Key System",
	  Note = "",
	  FileName = "Key",
	  SaveKey = true,
	  GrabKeyFromSite = false,
	  Key = {""}
	}
})

-- Local variables
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = cloneref(game:GetService("VirtualUser"))

-- Game Variables
local PlaceId = 72829404259339
local JobId = game.JobId

-- Player
local player = Players.LocalPlayer
local PlayerGui = player.PlayerGui
local playerUserId = player.UserId
local LocalPlayer = Players:GetPlayerByUserId(playerUserId)
local LocalPlayerGui = LocalPlayer.PlayerGui
local playerName = player.Character

local PlayRoom = LocalPlayerGui.PlayRoom

-- Toggles
local GachaUIOn = false
local JoinZCityOn = false
local CollectQuestOn = false
local AutoJoinChallengeOn = false
local AutoRetryOn = false
local AutoClickOn = false
local AutoVoteOn = false
local AutoNextOn = false
local AutoJoinEasterEggEventOn = false
local AutoRejoinOn = false
local AutoJoinFriendsOn = false
local AutoRedeemCodesOn = false

-- Upgrades
local AutoUpgradeSlot1On = false
local AutoUpgradeSlot2On = false
local AutoUpgradeSlot3On = false
local AutoUpgradeSlot4On = false
local AutoUpgradeSlot5On = false

-- Replicated Storage
local Player_Data = ReplicatedStorage:WaitForChild("Player_Data"):GetChildren()
local Values = ReplicatedStorage:WaitForChild("Values")
local Values_VotePlaying = Values:WaitForChild("Game"):WaitForChild("VotePlaying")
local Values_VoteNext = Values:WaitForChild("Game"):WaitForChild("VoteNext")
local Values_VoteRetry = Values:FindFirstChild("Game"):FindFirstChild("VoteRetry")
local Values_Game = Values:WaitForChild("Game"):WaitForChild("GameRunning")
local Values_Gamemode = Values:WaitForChild("Game"):WaitForChild("Gamemode")

-- UI variables
local RewardsUI = LocalPlayerGui:FindFirstChild("RewardsUI")
local MenuFrameVisibility = LocalPlayer.PlayerGui.HUD:WaitForChild("MenuFrame").Visible
local LoadingDataUI = LocalPlayerGui:FindFirstChild("LoadingDataUI")

-- Ranger Stage Variables
local AutoJoinChallengeOn = false
local AutoJoinRangerStage = false

local OnePiece_RangerStage = {"OnePiece_RangerStage1", "OnePiece_RangerStage2", "OnePiece_RangerStage3"}
local DragonBall_RangerStage = {"DragonBall_RangerStage1", "DragonBall_RangerStage2", "DragonBall_RangerStage3"}
local DemonSlayer_RangerStage = {"DemonSlayer_RangerStage1","DemonSlayer_RangerStage2","DemonSlayer_RangerStage3"}
local Naruto_RangerStage = {"Naruto_RangerStage1","Naruto_RangerStage2","Naruto_RangerStage3"}
local OPM_RangerStage = {"OPM_RangerStage1","OPM_RangerStage2","OPM_RangerStage3"}

local AllWorlds = {
	["OnePiece"] = OnePiece_RangerStage, 
	["DragonBall"] = DragonBall_RangerStage, 
	["DemonSlayer"] = DemonSlayer_RangerStage, 
	["Naruto"] = Naruto_RangerStage, 
	["OPM"] = OPM_RangerStage,
}
--

-- Maps
local Tab = Window:CreateTab("Main", "anchor")
local Section = Tab:CreateSection("Maps")

local function startMap()
    local args = {
        [1] = "Start"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
end

local function createEasterEventLobby()
    local args = {
		[1] = "Easter-Event"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
end

local function joinEasterEvent()
    createEasterEventLobby()
	wait(3)
	startMap()
end

local function createChallengeLobby()
    local args = {
		[1] = "Create",
		[2] = {
			["CreateChallengeRoom"] = true
		}
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
end

local function joinChallenge()
    createChallengeLobby()
	startMap()
end

local Toggle = Tab:CreateToggle({
    Name = "Auto Join Easter Egg Event",
    CurrentValue = false,
    Flag = "AutoJoinEasterEggEvent_Toggle",
    Callback = function(AutoJoinEasterEggEventEnabled)
	
        AutoJoinEasterEggEventOn = AutoJoinEasterEggEventEnabled
		
		while AutoJoinEasterEggEventOn do
            if Values_Gamemode.Value == "" then
                if AutoJoinChallengeOn and AutoJoinRangerStageOn then
                    wait(25)
                    joinEasterEvent()
                elseif AutoJoinChallengeOn and not AutoJoinRangerStageOn then
                    wait(10)
                    joinEasterEvent()
                elseif AutoJoinRangerStageOn and not AutoJoinChallengeOn then
                    wait(15)
                    joinEasterEvent()
                else
                    wait(1)
                    joinEasterEvent()
                end
            end
			wait()
        end
        -- EasterEvent, Challenge, RangerStage
            -- priority = RangerStage, Challenge, EasterEvent, BossEvent, Story
                -- Table that goes through one option first and waits for it to end before it starts the next
                    -- RangerStage then check challenge then easter event
                        -- problem: it wont reach anything after challenge
    end,
})
-- Auto Join Challenge
local Toggle = Tab:CreateToggle({
    Name = "Auto Join Challenge",
    ChangeValue = false,
    Flag = "AutoJoinChallenge_Toggle",
    Callback = function(AutoJoinChallengeEnabled)
	
        AutoJoinChallengeOn = AutoJoinChallengeEnabled
		
        while AutoJoinChallengeOn do
            if Values_Gamemode.Value == "" then
                if AutoJoinRangerStageOn then
                    wait(10)
                    joinChallenge()
                else
                    wait(3)
                    joinChallenge()
                end
            end
			wait()
        end
    end,
})

local function createLobby()
    local args = {
        [1] = "Create"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
end

local function changeMode()
    local args = {
        [1] = "Change-Mode",
        [2] = {
            ["Mode"] = "Ranger Stage"
        }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
end

local function changeWorld(world)
    local args = {
        [1] = "Change-World",
        [2] = {
            ["World"] = world
        }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
end

local function changeStage(rangerStage_value)
    local args = {
        [1] = "Change-Chapter",
        [2] = {
            ["Chapter"] = rangerStage_value
        }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
end

local function changeFriendsOnly()
    local args = {
        [1] = "Change-FriendOnly"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
end

local function submitChanges()
    local args = {
        [1] = "Submit"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
end

local Toggle = Tab:CreateToggle({
    Name = "Auto Join Ranger Stage",
    ChangeValue = false,
    Flag = "AutoJoinRangerStage_Toggle",
    Callback = function(AutoJoinRangerStageEnabled)
    
        AutoJoinRangerStageOn = AutoJoinRangerStageEnabled
        
		while AutoJoinRangerStageOn do
			if Values_Gamemode.Value == "" then
				for world, rangerStage in pairs(AllWorlds) do
					wait(0.5)
					createLobby()
					changeMode()
					changeWorld(world)
					for rangerStage_pos,rangerStage_value in ipairs(rangerStage) do
						wait(0.5)
						changeStage(rangerStage_value)
						changeFriendsOnly()
						submitChanges()
						startMap()
					end
				end
			end
			wait()
		end
	end,
})

local Divider = Tab:CreateDivider()

local lastRejoinTime = 0 -- Prevents spamming

local Toggle = Tab:CreateToggle({
    Name = "Auto Rejoin",
    CurrentValue = false,
    Flag = "AutoRejoin_Toggle",
    Callback = function(AutoRejoinEnabled)
        AutoRejoinOn = AutoRejoinEnabled

		while AutoRejoinOn do
			local dt = DateTime.now()
			local localTime = dt:ToLocalTime()
			local currentMinute = localTime.Minute
			local currentSecond = localTime.Second

			if currentMinute == 30 or currentMinute == 00 then
				lastRejoinTime = 60 - currentSecond
                wait(lastRejoinTime)
				TeleportService:Teleport(PlaceId, player)
            end
			lastRejoinTime = 0
			task.wait(10)
		end

    end,
})

local function JoinRoom(friend)
    local args = {
        "Join-Room",
        {
            Room = game:GetService("ReplicatedStorage"):WaitForChild("PlayRoom"):WaitForChild(friend)
        }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
end

local Toggle = Tab:CreateToggle({
    Name = "Auto Join Friends",
    CurrentValue = false,
    Flag = "AutoJoinFriends_Toggle",
    Callback = function(AutoJoinFriendsEnabled)
		AutoJoinFriendsOn = AutoJoinFriendsEnabled
		while AutoJoinFriendsOn do
            if Values_Gamemode.Value == "" then
                for _,playersPlayer in ipairs(Players:GetChildren()) do
                    if player:isFriendsWith(playersPlayer.UserId) and not LocalPlayerGui.PlayRoom.Main.Game_Submit.Visible then
                        JoinRoom(playersPlayer.Name)
                        LocalPlayerGui.PlayRoom.Enabled = true
                        task.wait(1)
                    end
                end
            end
            task.wait()
        end
	end,
})

local Button = Tab:CreateButton({
 	Name = "Rejoin Server",
 	Callback = function()
    
         if #Players:GetPlayers() <= 1 then
             player:Kick("\nRejoining...")
             wait(1)
             TeleportService:Teleport(PlaceId, player)
         else
             TeleportService:TeleportToPlaceInstance(PlaceId, JobId, player)
         end
		 
     end,
 })
 
-- Auto
local Section = Tab:CreateSection("Automation")

local function fireAutoVote()
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("OnGame"):WaitForChild("Voting"):WaitForChild("VotePlaying"):FireServer()
end

-- Auto Vote
local Toggle = Tab:CreateToggle({
    Name = "Auto Vote",
    CurrentValue = false,
    Flag = "AutoVote_Toggle",
    Callback = function(AutoVoteEnabled)
        AutoVoteOn = AutoVoteEnabled
        while AutoVoteOn do
            if not Values_VotePlaying.VoteEnded.Value then
                if Values_VotePlaying.VoteEnabled.Value then
                    wait(3)
                    fireAutoVote()
                end
            end
            wait(1)
		end
    end,
})

local function fireAutoNext()
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("OnGame"):WaitForChild("Voting"):WaitForChild("VoteNext"):FireServer()
end

-- Auto Next
local Toggle = Tab:CreateToggle({
    Name = "Auto Next",
    CurrentValue = false,
    Flag = "AutoNext_Toggle",
    Callback = function(AutoNextEnabled)
        AutoNextOn = AutoNextEnabled
        while AutoNextOn do
			if Values_VoteNext.VoteEnabled.Value then
				wait(1)
				fireAutoNext()
			end
            wait(1)
		end
    end,
})

local function toggleRewardsUI()
	if Values_VoteRetry.VoteEnabled.Value and not LoadingDataUI.Enabled then
		RewardsUI.Enabled = true
        wait(1)
		RewardsUI.Enabled = false	
	end
	if RewardsUI.Enabled then
		RewardsUI.Enabled = false	
	end
end

local function antiAfk()
    player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

local function fireVoteRetryEvent()
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("OnGame"):WaitForChild("Voting"):WaitForChild("VoteRetry"):FireServer()
end

local function voteRetry()
	toggleRewardsUI()
	fireVoteRetryEvent()
end

local function removeSaveToTeleport()
    local SavedToTeleport = player:FindFirstChild("SavedToTeleport")
    if SavedToTeleport then
        SavedToTeleport:Destroy()
    end
end

-- Auto Retry
local Toggle = Tab:CreateToggle({
	Name = "Auto Retry",
	CurrentValue = false,
	Flag = "AutoRetry_Toggle",
	Callback = function(AutoRetryEnabled)
    
        AutoRetryOn = AutoRetryEnabled

        while AutoRetryOn do
			local dt = DateTime.now()
			local localTime = dt:ToLocalTime()
			local currentHour = localTime.Hour
			local currentMinute = localTime.Minute
			local currentSecond = localTime.Second
			antiAfk()
			if Values_VoteRetry.VoteEnabled.Value and not LoadingDataUI.Enabled then
				if (currentMinute == 59 and currentSecond >= 50) then
					wait(15)
					voteRetry()
				elseif (currentMinute == 00 and currentSecond <= 05) then
					wait(5)
					voteRetry()
				else
					wait(1)
					voteRetry()
				end
			end
			toggleRewardsUI()
            removeSaveToTeleport()
			wait(1)
        end
    end,
})

local Divider = Tab:CreateDivider()

local function claimAllQuests(player_Name, quests_BoolValue_Name)
    local args = {
        [1] = "ClaimAll",
        [2] = game:GetService("ReplicatedStorage"):FindFirstChild("Player_Data"):FindFirstChild(player_Name):FindFirstChild("DailyQuest"):FindFirstChild(quests_BoolValue_Name)
    }
    game:GetService("ReplicatedStorage"):FindFirstChild("Remote"):FindFirstChild("Server"):FindFirstChild("Gameplay"):FindFirstChild("QuestEvent"):FireServer(unpack(args))
end

--  Auto Collect Quests
local Toggle = Tab:CreateToggle({
	Name = "Auto Collect Quests",
	CurrentValue = false,
	Flag = "CollectQuest_Toggle",
	Callback = function(CollectQuestEnabled)
		CollectQuestOn = CollectQuestEnabled
		
        while CollectQuestOn and Values_Gamemode.Value == "" do
            for _,player_Name in pairs(Player_Data) do
                if player_Name.Name == player.Name then
                    for _,player_QuestType in pairs(player_Name:GetChildren()) do
                        for _,quests_BoolValue in pairs(player_QuestType:GetDescendants()) do
                            if quests_BoolValue.Name == "claimed" and not quests_BoolValue.Value then
								claimAllQuests(player.Name, quests_BoolValue.Parent.Name)
                            end
                        end
                    end
                else
                    break
                end
                wait(1)
            end
            wait(1)
        end
	end,
})

local Tab = Window:CreateTab("Upgrades", "anchor")
local Section = Tab:CreateSection("Upgrade")

-- Auto Upgrade Slot 1 ------------------------------------------------------------------------------------------------------------------------------------
local function upgradeSlotNumber(unit)
    local args = {
        [1] = player.UnitsFolder:WaitForChild(unit)
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("Units"):WaitForChild("Upgrade"):FireServer(unpack(args))
end

local function getUnitLoadout(player_Name, UnitLoadout)
    local Data = player_Name:FindFirstChild("Data")
    local UnitLoadoutTable = {
        ["UnitLoadout1"] = Data.UnitLoadout1.Value,
        ["UnitLoadout2"] = Data.UnitLoadout2.Value,
        ["UnitLoadout3"] = Data.UnitLoadout3.Value,
        ["UnitLoadout4"] = Data.UnitLoadout4.Value,
        ["UnitLoadout5"] = Data.UnitLoadout5.Value,
        ["UnitLoadout6"] = Data.UnitLoadout6.Value,
    }
    for UnitLoadoutNumber, UnitLoadoutValue in pairs(UnitLoadoutTable) do
        if UnitLoadout == UnitLoadoutNumber then
            return UnitLoadoutValue
        end
    end
end

local function getUnitByTag(player_Name, UnitLoadout)
    local Collection = player_Name:FindFirstChild("Collection"):GetDescendants()
    for _, unit_name in pairs (Collection) do
        if unit_name.Name == "Tag" and unit_name.Value == getUnitLoadout(player_Name, UnitLoadout) then
            local Unit = unit_name.Parent.Name
            upgradeSlotNumber(Unit)
        end
    end
end

local function upgradeSlot(UnitLoadout)
    for _, player_Name in pairs(Player_Data) do
        if player_Name.Name == player.Name then
            getUnitByTag(player_Name, UnitLoadout)
        end
        wait(0.5)
    end
end

-- Auto Upgrade Slot 1
local Toggle = Tab:CreateToggle({
	Name = "Auto Upgrade Slot 1",
	CurrentValue = false,
	Flag = "AutoUpgradeSlot1_Toggle",
	Callback = function(AutoUpgradeSlot1Enabled)
        AutoUpgradeSlot1On = AutoUpgradeSlot1Enabled

        while AutoUpgradeSlot1On do
			wait(0.5)
            if Values_Game.Value then
            local UnitLoadout = "UnitLoadout1"
            upgradeSlot(UnitLoadout)
            end
		end

    end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Upgrade Slot 2",
	CurrentValue = false,
	Flag = "AutoUpgradeSlot2_Toggle",
	Callback = function(AutoUpgradeSlot2Enabled)
        AutoUpgradeSlot2On = AutoUpgradeSlot2Enabled

        while AutoUpgradeSlot2On do
			wait(0.5)
            if Values_Game.Value then
            local UnitLoadout = "UnitLoadout2"
            upgradeSlot(UnitLoadout)
            end
		end

    end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Upgrade Slot 3",
	CurrentValue = false,
	Flag = "AutoUpgradeSlot3_Toggle",
	Callback = function(AutoUpgradeSlot3Enabled)
        AutoUpgradeSlot3On = AutoUpgradeSlot3Enabled

        while AutoUpgradeSlot3On do
			wait(0.5)
            if Values_Game.Value then
            local UnitLoadout = "UnitLoadout3"
            upgradeSlot(UnitLoadout)
            end
		end

    end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Upgrade Slot 4",
	CurrentValue = false,
	Flag = "AutoUpgradeSlot4_Toggle",
	Callback = function(AutoUpgradeSlot4Enabled)
        AutoUpgradeSlot4On = AutoUpgradeSlot4Enabled

        while AutoUpgradeSlot4On do
			wait(0.5)
            if Values_Game.Value then
            local UnitLoadout = "UnitLoadout4"
            upgradeSlot(UnitLoadout)
            end
		end

    end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Upgrade Slot 5",
	CurrentValue = false,
	Flag = "AutoUpgradeSlot5_Toggle",
	Callback = function(AutoUpgradeSlot5Enabled)
        AutoUpgradeSlot5On = AutoUpgradeSlot5Enabled

        while AutoUpgradeSlot5On do
			wait(0.5)
            if Values_Game.Value then
            local UnitLoadout = "UnitLoadout5"
            upgradeSlot(UnitLoadout)
            end
		end

    end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Upgrade Slot 6",
	CurrentValue = false,
	Flag = "AutoUpgradeSlot6_Toggle",
	Callback = function(AutoUpgradeSlot6Enabled)
        AutoUpgradeSlot6On = AutoUpgradeSlot6Enabled

        while AutoUpgradeSlot6On do
			wait(0.5)
            if Values_Game.Value then
            local UnitLoadout = "UnitLoadout6"
            upgradeSlot(UnitLoadout)
            end
		end

    end,
})

-- UI
local Tab = Window:CreateTab("Open UI", "anchor")
local Section = Tab:CreateSection("UI")

-- Summon
local Button = Tab:CreateButton({
	Name = "Open Summon Banner",
	Callback = function()
        LocalPlayer.PlayerGui.UnitsGacha.Enabled = true
    end,
})
-- Quests
local Button = Tab:CreateButton({
	Name = "Open Quests",
	Callback = function()
        LocalPlayer.PlayerGui.Quest.Enabled = true
    end,
})
-- Merchant
local Button = Tab:CreateButton({
	Name = "Open Merchant",
	Callback = function()
        LocalPlayer.PlayerGui.Merchant.Enabled = true
    end,
})

local Divider = Tab:CreateDivider()
-- Open Redeem Codes
local Button = Tab:CreateButton({
	Name = "Open Redeem Codes",
	Callback = function()
        LocalPlayer.PlayerGui.Code.Enabled = true
    end,
})
-- Level Rewards
local Button = Tab:CreateButton({
	Name = "Open Level Rewards",
	Callback = function()
        LocalPlayer.PlayerGui.LevelMilestone.Enabled = true
    end,
})

local Divider = Tab:CreateDivider()
-- Trait reroll
local Button = Tab:CreateButton({
	Name = "Open Trait Reroll",
	Callback = function()
        LocalPlayer.PlayerGui.Traits.Enabled = true
    end,
})
-- Stats reroll
local Button = Tab:CreateButton({
	Name = "Open Stats Reroll",
	Callback = function()
        LocalPlayer.PlayerGui.StatsPotential.Enabled = true
    end,
})
-- Curse reroll
local Button = Tab:CreateButton({
	Name = "Open Curse Reroll",
	Callback = function()
        LocalPlayer.PlayerGui.ApplyCurse.Enabled = true
    end,
})

local Divider = Tab:CreateDivider()
-- Evolve units
local Button = Tab:CreateButton({
	Name = "Open Evolve Units",
	Callback = function()
        LocalPlayer.PlayerGui.UnitsEvolve.Enabled = true
    end,
})
-- Feed units
local Button = Tab:CreateButton({
	Name = "Open Feed Units",
	Callback = function()
        LocalPlayer.PlayerGui.FeedEXP.Enabled = true
    end,
})

local Divider = Tab:CreateDivider()
-- Crafting
local Button = Tab:CreateButton({
	Name = "Open Crafting",
	Callback = function()
        LocalPlayer.PlayerGui.Crafting.Enabled = true
    end,
})

local Divider = Tab:CreateDivider()

-- Others
local Tab = Window:CreateTab("Others", "anchor")
local Section = Tab:CreateSection("Scripts")

local Button = Tab:CreateButton({
	Name = "InfiniteYield Script",
	Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source'))()
    end
})

local Button = Tab:CreateButton({
	Name = "Save Config",
	Callback = function()
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "AnimeRangersX",
            FileName = "AnimeRangersX_Save"
          }
    end
})

local Button = Tab:CreateButton({
	Name = "Load Config",
	Callback = function()
        Rayfield:LoadConfiguration()
    end
})

Rayfield:LoadConfiguration()