game.Players.LocalPlayer.UserId = 342592764
game:GetService("Players").LocalPlayer.Name = "RETR0SYN"
_G.SAEnabled = true
-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local accomidationfactor = 0.15537

-- // Silent Aim Module
local SilentAim = loadstring(game:HttpGet("https://raw.githubusercontent.com/GlobalReturns/tesster/main/tesster.txt"))()
SilentAim.TeamCheck = false

-- // Metatable vars
local mt = getrawmetatable(game)
local backupindex = mt.__index
setreadonly(mt, false)

-- // Check if player is down
SilentAim.checkSilentAim = function()
    local checkA = (SilentAim.SilentAimEnabled == true and SilentAim.Selected ~= LocalPlayer)
    local playerCharacter = SilentAim.Selected.Character
    local daHood = (playerCharacter.BodyEffects["K.O"].Value == false or playerCharacter:FindFirstChild("GRABBING_CONSTRAINT") ~= nil)

    return (checkA and daHood)
end
local UserInputService = game:GetService("UserInputService")

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        local keyPressed = input.KeyCode
        if keyPressed.Name == 'RightBracket' then
            SilentAim.FOV = SilentAim.FOV + 1
        end
        if keyPressed.Name == 'LeftBracket' then
            SilentAim.FOV = SilentAim.FOV - 1
        end
    end
end)
-- // Hook
mt.__index = newcclosure(function(t, k)
    if (t:IsA("Mouse") and (k == "Hit")) then
        
        local CPlayer = SilentAim.Selected
        if (SilentAim.checkSilentAim()) and _G.SAEnabled then
            if (CPlayer.Character:FindFirstChild("UpperTorso")) then
                return {p=(CPlayer.Character.UpperTorso.CFrame.p+(CPlayer.Character.UpperTorso.Velocity*accomidationfactor))}
            end
        end
    end
    return backupindex(t, k)
end)

-- // Revert
setreadonly(mt, true)
-- // Mains
game:GetService("UserInputService").InputBegan:connect(function(input)
if input.KeyCode == Enum.KeyCode.V then
_G.SAEnabled = true
end
end)
--
game:GetService("UserInputService").InputBegan:connect(function(input)
if input.KeyCode == Enum.KeyCode.C then
_G.SAEnabled = false
end
end)
-- // Fov
game:GetService("UserInputService").InputBegan:connect(function(input)
if input.KeyCode == Enum.KeyCode.Minus then
SilentAim.ShowFOV = SilentAim.ShowFOV == true
end
end)
--
game:GetService("UserInputService").InputBegan:connect(function(input)
if input.KeyCode == Enum.KeyCode.Equals then
SilentAim.ShowFOV = SilentAim.ShowFOV == false
end
end)