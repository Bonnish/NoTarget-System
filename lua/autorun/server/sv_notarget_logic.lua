local function GetConfig()
    if not BonnishBase or not BonnishBase.GetConfig then
        return { allow_self = true, allow_others = false, command = "!notarget", allowed_jobs = {} }
    end
    local cfg = BonnishBase.GetConfig("no_target") or {}
    if cfg.allow_self == nil then cfg.allow_self = true end
    if cfg.allow_others == nil then cfg.allow_others = false end
    if cfg.command == nil then cfg.command = "!notarget" end
    if cfg.allowed_jobs == nil then cfg.allowed_jobs = {} end
    return cfg
end

local function ToggleNoTarget(ent)
    if not IsValid(ent) or not ent:IsPlayer() then return end

    local estaActivado = ent:IsFlagSet(FL_NOTARGET)
    local nuevoEstado = not estaActivado
    ent:SetNoTarget(nuevoEstado)

    local modo = nuevoEstado and "ACTIVADO" or "DESACTIVADO"
    ent:ChatPrint("No Target is now: " .. modo .. " for: " .. ent:Nick())
end

hook.Add("PlayerSay", "Bonnish_NoTarget_Command", function(ply, text)
    local config = GetConfig()
    local cmd = config.command or "!notarget"

    if string.lower(text) == string.lower(cmd) then
        if config.allow_self or ply:IsSuperAdmin() then
            ToggleNoTarget(ply)
        else
            ply:ChatPrint("No tienes permiso para ponerte No Target.")
        end
        return ""
    end
end)

local function CheckJobNoTarget(ply, jobTeam)
    if not RPExtraTeams then return end

    local config = GetConfig()
    local allowedJobs = config.allowed_jobs or {}

    local plyJob = RPExtraTeams[jobTeam]
    local plyJobName = team.GetName(jobTeam)
    local plyCatName = plyJob and plyJob.category or ""

    local shouldHaveNoTarget = false
    for _, job in ipairs(allowedJobs) do
        local j_clean = string.lower(string.Trim(job))
        local target_job = string.lower(string.Trim(plyJobName))
        local target_cat = string.lower(string.Trim("[CAT] " .. plyCatName))
        
        if j_clean == target_job then
            shouldHaveNoTarget = true
            break
        elseif j_clean == target_cat then
            shouldHaveNoTarget = true
            break
        end
    end

    if shouldHaveNoTarget then
        ply:SetNoTarget(true)
    else
        ply:SetNoTarget(false)
    end
end

hook.Add("PlayerSpawn", "Bonnish_NoTarget_Spawn", function(ply)
    CheckJobNoTarget(ply, ply:Team())
end)

hook.Add("OnPlayerChangedTeam", "Bonnish_NoTarget_TeamChange", function(ply, oldTeam, newTeam)
    CheckJobNoTarget(ply, newTeam)
end)
