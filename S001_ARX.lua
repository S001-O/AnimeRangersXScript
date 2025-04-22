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
	  Enabled = false,
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
	  Note = "Who's a good boy?",
	  FileName = "Key",
	  SaveKey = true,
	  GrabKeyFromSite = false,
	  Key = {"me"}
	}
})

-- Local variables
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlaceId = game.PlaceId
local JobId = game.JobId

-- Player
local player = Players.LocalPlayer
local PlayerGui = player.PlayerGui
local UserId = player.UserId
local LocalPlayer = Players:GetPlayerByUserId(UserId)
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

local MenuFrameVisibility = LocalPlayer.PlayerGui.HUD:WaitForChild("MenuFrame").Visible

-- Replicated Storage
local Player_Data = ReplicatedStorage:WaitForChild("Player_Data"):GetChildren()

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

local Toggle = Tab:CreateToggle({
    Name = "Auto Join Easter Egg Event",
    CurrentValue = false,
    Flag = "AutoJoinEasterEggEvent",
    Callback = function(AutoJoinEasterEggEventEnabled)
        AutoJoinEasterEggEventOn = AutoJoinEasterEggEventEnabled
    while AutoJoinEasterEggEventOn and MenuFrameVisibility do
        wait(1)
        -- Auto Join Easter Event
            local args = {
            [1] = "Easter-Event"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
        -- Start
            local args = {
            [1] = "Start"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
        end
    end,
})

local Toggle = Tab:CreateToggle({
    Name = "Auto Join Ranger Stage",
    ChangeValue = false,
    Flag = "AutoJoinRangerStage",
    Callback = function(AutoJoinRangerStageEnabled)
        AutoJoinRangerStageOn = AutoJoinRangerStageEnabled

        if AutoJoinRangerStageOn and MenuFrameVisibility then
            -- Open PlayRoom
            PlayRoom.Enabled = true

            for world, rangerStage in pairs(AllWorlds) do
                print(world)
                -- Create PlayRoom
                local args = {
                    [1] = "Create"
                }

                game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
                -- Change Mode
                local args = {
                    [1] = "Change-Mode",
                    [2] = {
                        ["Mode"] = "Ranger Stage"
                    }
                }

                game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))

                -- ChangeWorld
                    local args = {
                        [1] = "Change-World",
                        [2] = {
                            ["World"] = world
                        }
                    }
                    
                    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
                    -- Change Chapter
                    for rangerStage_pos,rangerStage_value in ipairs(rangerStage) do
                        wait(0.5)
                        local args = {
                            [1] = "Change-Chapter",
                            [2] = {
                                ["Chapter"] = rangerStage_value
                            }
                        }
                        
                        game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
                
                    -- Change FriendOnly
                    local args = {
                        [1] = "Change-FriendOnly"
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))

                    local args = {
                        [1] = "Submit"
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
                    
                    
                    -- Start
                    local args = {
                    [1] = "Start"
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(unpack(args))
                end
            end
            Rayfield:Notify({
            Title = "Ranger Stage on Cooldown",
            Content = "Rangers in cooldown.",
            Duration = 15,
            Image = "anchor",
            })
        end
        PlayRoom.Enabled = false
	end, 
})

-- Auto
local Section = Tab:CreateSection("Automation")

-- Auto Vote
local Toggle = Tab:CreateToggle({
    Name = "Auto Vote",
    CurrentValue = false,
    Flag = "AutoVote",
    Callback = function(AutoVoteEnabled)
        AutoVoteOn = AutoVoteEnabled
        while AutoVoteOn and not MenuFrameVisibility do
            wait(1)
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("OnGame"):WaitForChild("Voting"):WaitForChild("VotePlaying"):FireServer()
        end
    end,
})

-- Auto Next
local Toggle = Tab:CreateToggle({
    Name = "Auto Next",
    CurrentValue = false,
    Flag = "AutoNext",
    Callback = function(AutoNextEnabled)
        AutoNextOn = AutoNextEnabled
        while AutoNextOn and not MenuFrameVisibility do
            wait(1)
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("OnGame"):WaitForChild("Voting"):WaitForChild("VoteNext"):FireServer()
        end
    end,
})

-- Auto Retry
local Toggle = Tab:CreateToggle({
	Name = "Auto Retry",
	CurrentValue = false,
	Flag = "AutoRetry",
	Callback = function(AutoRetryEnabled)
    
        AutoRetryOn = AutoRetryEnabled

        while AutoRetryOn and not MenuFrameVisibility do
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("OnGame"):WaitForChild("Voting"):WaitForChild("VoteRetry"):FireServer()
            wait(1)
        end
    end,
})

-- Collect Quests
local Toggle = Tab:CreateToggle({
	Name = "Auto Collect Quests",
	CurrentValue = false,
	Flag = "CollectQuest",
	Callback = function(CollectQuestEnabled)
		CollectQuestOn = CollectQuestEnabled
		
		for i,player_Name in pairs(Player_Data) do
			print("for_start")
			print(player_Name)

			if player_Name.Name == player.Name then

				local DailyQuest = player_Name:WaitForChild("DailyQuest")
				local WeeklyQuest = player_Name:WaitForChild("WeeklyQuest")

				print(player_Name:GetChildren())
				for _,player_QuestType in pairs(player_Name:GetChildren()) do
					for _,quests_BoolValue in pairs(player_QuestType:GetDescendants()) do
						if quests_BoolValue.Name == "claimed" and not quests_BoolValue.Value then
							local args = {
                            [1] = "ClaimAll",
                            [2] = game:GetService("ReplicatedStorage"):WaitForChild("Player_Data"):WaitForChild("DemonHorus"):WaitForChild("DailyQuest"):WaitForChild("Ranger Mode II")
                        }

                        game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("Gameplay"):WaitForChild("QuestEvent"):FireServer(unpack(args))
                        wait(1)
						end
					end
				end
			else
				break
			end
			print("for_end")
			wait(1)
		end
		print("while_end")
		wait(1)		
	end,
})

-- UI
local Tab = Window:CreateTab("Open UI", "anchor")
local Section = Tab:CreateSection("UI")

-- Summon
local Button = Tab:CreateButton({
	Name = "Open Summon Banner",
	Callback = function()
        local LocalPlayer = Players:GetPlayerByUserId(UserId)
        LocalPlayer.PlayerGui.UnitsGacha.Enabled = true
    end,
})
-- Quests
local Button = Tab:CreateButton({
	Name = "Open Quests",
	Callback = function()
        local LocalPlayer = Players:GetPlayerByUserId(UserId)
        LocalPlayer.PlayerGui.Quest.Enabled = true
    end,
})
-- Merchant
local Button = Tab:CreateButton({
	Name = "Open Merchant",
	Callback = function()
        local LocalPlayer = Players:GetPlayerByUserId(UserId)
        LocalPlayer.PlayerGui.Merchant.Enabled = true
    end,
})

-- Level Rewards
local Button = Tab:CreateButton({
	Name = "Open Level Rewards",
	Callback = function()
        local LocalPlayer = Players:GetPlayerByUserId(UserId)
        LocalPlayer.PlayerGui.LevelMilestone.Enabled = true
    end,
})

local Divider = Tab:CreateDivider()
-- Trait reroll
local Button = Tab:CreateButton({
	Name = "Open Trait Reroll",
	Callback = function()
        local LocalPlayer = Players:GetPlayerByUserId(UserId)
        LocalPlayer.PlayerGui.Traits.Enabled = true
    end,
})
-- Stats reroll
local Button = Tab:CreateButton({
	Name = "Open Stats Reroll",
	Callback = function()
        local LocalPlayer = Players:GetPlayerByUserId(UserId)
        LocalPlayer.PlayerGui.StatsPotential.Enabled = true
    end,
})
-- Curse reroll
local Button = Tab:CreateButton({
	Name = "Open Curse Reroll",
	Callback = function()
        local LocalPlayer = Players:GetPlayerByUserId(UserId)
        LocalPlayer.PlayerGui.ApplyCurse.Enabled = true
    end,
})

local Divider = Tab:CreateDivider()
-- Evolve units
local Button = Tab:CreateButton({
	Name = "Open Evolve Units",
	Callback = function()
        local LocalPlayer = Players:GetPlayerByUserId(UserId)
        LocalPlayer.PlayerGui.UnitsEvolve.Enabled = true
    end,
})
-- Feed units
local Button = Tab:CreateButton({
	Name = "Open Feed Units",
	Callback = function()
        local LocalPlayer = Players:GetPlayerByUserId(UserId)
        LocalPlayer.PlayerGui.FeedEXP.Enabled = true
    end,
})

local Divider = Tab:CreateDivider()
-- Crafting
local Button = Tab:CreateButton({
	Name = "Open Crafting",
	Callback = function()
        local LocalPlayer = Players:GetPlayerByUserId(UserId)
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

Rayfield:LoadConfiguration()