import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "moebius92.Handlers";

-- GetInstance() is a static method — use dot syntax, not colon.
local player = Turbine.Gameplay.LocalPlayer.GetInstance();
local skills  = nil;
local names   = {};
local handles = {};

-- Build (or rebuild) the per-skill ResetTimeChanged handlers.
-- Called at load and again via /st whenever you swap traits or level up.
local function buildHandlers()
    -- Detach any existing handlers before re-registering.
    for i = 1, #handles do
        moebius92.Handlers.RemoveEventHandler(
            skills:GetItem(i), "ResetTimeChanged", handles[i]);
    end
    handles = {};
    names   = {};

    skills = player:GetTrainedSkills();

    for i = 1, skills:GetCount() do
        local sk = skills:GetItem(i);
        names[i] = sk:GetSkillInfo():GetName();

        -- Capture index for the closure.
        local idx = i;
        handles[i] = moebius92.Handlers.AddEventHandler(
            sk, "ResetTimeChanged", function()
                local rt = skills:GetItem(idx):GetResetTime();

                -- rt == -1 means the skill just came OFF cooldown; nothing to show.
                if rt < 0 then return end;

                -- rt is an absolute game timestamp; subtract now for remaining seconds.
                local remaining = rt - Turbine.Engine.GetGameTime();
                if remaining > 0 then
                    Turbine.Shell.WriteLine(
                        "[SkillTimer] " .. names[idx]
                        .. ": " .. string.format("%.1fs", remaining));
                end
            end);
    end
end

buildHandlers();

-- /st — refresh the skill list after a trait swap or level-up.
SkillTimerCommand = class(Turbine.ShellCommand);

function SkillTimerCommand:Execute(_command, _arguments)
    buildHandlers();
    Turbine.Shell.WriteLine(
        "[SkillTimer] Refreshed — tracking " .. skills:GetCount() .. " skills.");
end

function SkillTimerCommand:GetShortHelp()
    return "Refresh the SkillTimer skill list after a trait swap or level-up.";
end

plugin.command = SkillTimerCommand();
Turbine.Shell.AddCommand("st", plugin.command);
