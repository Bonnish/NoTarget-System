TOOL.Category = "Bonnish Utilities"
TOOL.Name     = "NPC No Target"

if CLIENT then
    language.Add("tool.notarget_tools.name", "No Target")
    language.Add("tool.notarget_tools.desc", "Toggle NoTarget on players")
    language.Add("tool.notarget_tools.left", "Toggle NoTarget on targeted player")
    language.Add("tool.notarget_tools.right", "Toggle NoTarget on yourself")
end

local function Notify(ply, msg, msgType)
    if DarkRP and DarkRP.notify then
        DarkRP.notify(ply, msgType or 0, 4, msg)
    else
        ply:ChatPrint("[No Target] " .. msg)
    end
end

local function ToggleNoTarget(ent, activator)
    if not IsValid(ent) or not ent:IsPlayer() then return end

    local estaActivado = ent:IsFlagSet(FL_NOTARGET)
    local nuevoEstado = not estaActivado
    ent:SetNoTarget(nuevoEstado)
    ent:SetNWBool("Bonnish_NoTarget", nuevoEstado)

    local msg
    if nuevoEstado then
        msg = (BonnishBase and BonnishBase.GetLang and BonnishBase.GetLang("notarget_enabled") or "No Target is now: ENABLED for: ") .. ent:Nick()
        Notify(ent, msg, 0)
        if activator and activator ~= ent then Notify(activator, msg, 0) end
    else
        msg = (BonnishBase and BonnishBase.GetLang and BonnishBase.GetLang("notarget_disabled") or "No Target is now: DISABLED for: ") .. ent:Nick()
        Notify(ent, msg, 1)
        if activator and activator ~= ent then Notify(activator, msg, 1) end
    end
end

local function GetConfig()
    if not BonnishBase or not BonnishBase.GetConfig then
        return { allow_self = true, allow_others = false }
    end
    local cfg = BonnishBase.GetConfig("no_target") or {}
    if cfg.allow_self == nil then cfg.allow_self = true end
    if cfg.allow_others == nil then cfg.allow_others = false end
    return cfg
end

function TOOL:LeftClick(trace)
    if CLIENT then return true end

    local ply = self:GetOwner()
    local config = GetConfig()
    if not config.allow_others and not BonnishBase.HasPermission(ply) then
        local err = BonnishBase and BonnishBase.GetLang and BonnishBase.GetLang("notarget_no_perm") or "You do not have permission to toggle No Target."
        Notify(ply, err, 1)
        return false
    end

    local ent = trace.Entity
    if IsValid(ent) and ent:IsPlayer() then
        ToggleNoTarget(ent, ply)
        return true 
    end
end

function TOOL:RightClick(trace)
    if CLIENT then return true end

    local ply = self:GetOwner()
    local config = GetConfig()
    if not config.allow_self and not BonnishBase.HasPermission(ply) then
        local err = BonnishBase and BonnishBase.GetLang and BonnishBase.GetLang("notarget_no_perm") or "You do not have permission to toggle No Target."
        Notify(ply, err, 1)
        return false
    end

    ToggleNoTarget(ply, ply)
    return true 
end

function TOOL.BuildCPanel(panel)
    panel:AddControl("Header", { Description = "Bonnish's NoTarget System" })

    panel:AddControl("Label", { Text = "___________________________________________" })
    panel:ControlHelp("\n")

    local help = panel:Help("How to use:")
    help:SetFont("DermaDefaultBold")

    panel:ControlHelp("• LEFT CLICK: Toggle NoTarget on the player you're looking at.")
    panel:ControlHelp("• RIGHT CLICK: Toggle NoTarget on yourself.")
    
    panel:ControlHelp("\n")
    panel:AddControl("Label", { Text = "___________________________________________" })
    panel:ControlHelp("\n")

    local creditsTitle = panel:Help("Developed by Bonnish")
    creditsTitle:SetContentAlignment(5)
    
    local version = panel:ControlHelp("Version 1.0")
    version:SetContentAlignment(5)

    panel:ControlHelp("\n")
    local btn = panel:Button("Visit Workshop Page", "")
    btn:SetImage("icon16/world.png")
    
    btn.DoClick = function()
        gui.OpenURL("asd")
    end
end

if CLIENT then
    hook.Add("PreDrawHalos", "Bonnish_NoTarget_Halos", function()
        local ply = LocalPlayer()
        if not IsValid(ply) then return end

        local wep = ply:GetActiveWeapon()
        if not IsValid(wep) or wep:GetClass() ~= "gmod_tool" then return end

        local tool = ply:GetTool()
        if not tool or tool.Mode ~= "notarget_tools" then return end

        local targets = {}
        for _, p in ipairs(player.GetAll()) do
            if p:GetNWBool("Bonnish_NoTarget", false) then
                table.insert(targets, p)
            end
        end

        if #targets > 0 then
            halo.Add(targets, Color(147, 51, 234), 2, 2, 2, true, true)
        end
    end)
end