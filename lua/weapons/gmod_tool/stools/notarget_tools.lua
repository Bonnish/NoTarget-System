TOOL.Category = "Bonnish Utilities"
TOOL.Name     = "NPC No Target"

if CLIENT then
    language.Add("tool.notarget_tools.name", "No Target")
    language.Add("tool.notarget_tools.desc", "Toggle NoTarget on players")
    language.Add("tool.notarget_tools.0", "Primary: Toggle on targeted player | Secondary: Toggle on yourself")
    language.Add("tool.notarget_tools.left", "Toggle NoTarget on targeted player")
    language.Add("tool.notarget_tools.right", "Toggle NoTarget on yourself")
end

TOOL.Information = {
    { name = "left" },
    { name = "right" }
}

local function Notify(ply, msg, msgType)
    if DarkRP and DarkRP.notify then
        DarkRP.notify(ply, msgType or 0, 4, msg)
    end
    ply:ChatPrint("[No Target] " .. msg)
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

if CLIENT then
    surface.CreateFont("BonnishFont_SToolTitle", { font = "Outfit", size = 26, weight = 600, antialias = true })
    surface.CreateFont("BonnishFont_SToolSub", { font = "Outfit", size = 16, weight = 500, antialias = true })
    surface.CreateFont("BonnishFont_SToolText", { font = "Outfit", size = 15, weight = 400, antialias = true })
end

function TOOL.BuildCPanel(panel)
    panel:ClearControls()

    local header = vgui.Create("DPanel")
    header:SetTall(70)
    header.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(147, 51, 234))
        draw.SimpleText("NoTarget System", "BonnishFont_SToolTitle", w/2, h/2 - 12, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Bonnish Utilities", "BonnishFont_SToolSub", w/2, h/2 + 12, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    panel:AddItem(header)

    local helpPanel = vgui.Create("DPanel")
    helpPanel:SetTall(110)
    helpPanel.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(30, 41, 59))
        draw.RoundedBoxEx(6, 0, 0, w, 28, Color(15, 23, 42), true, true, false, false)
        
        draw.SimpleText("INSTRUCTIONS", "BonnishFont_SToolSub", w/2, 14, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Left Click:", "BonnishFont_SToolSub", 15, 45, Color(168, 85, 247), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Toggle on the player you look at.", "BonnishFont_SToolText", 15, 60, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        draw.SimpleText("Right Click:", "BonnishFont_SToolSub", 15, 80, Color(168, 85, 247), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Toggle NoTarget on yourself.", "BonnishFont_SToolText", 15, 95, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
    panel:AddItem(helpPanel)

    local noteLabel = vgui.Create("DLabel")
    noteLabel:SetText("Note: You can configure permissions\nand settings via the Context Menu.")
    noteLabel:SetFont("BonnishFont_SToolText")
    noteLabel:SetTextColor(Color(100, 116, 139))
    noteLabel:SetWrap(true)
    noteLabel:SetAutoStretchVertical(true)
    noteLabel:SetContentAlignment(5)
    panel:AddItem(noteLabel)

    local btn = vgui.Create("DButton")
    btn:SetText("Visit Workshop Page")
    btn:SetFont("BonnishFont_SToolSub")
    btn:SetTall(35)
    btn.Paint = function(self, w, h)
        if self:IsHovered() then
            draw.RoundedBox(4, 0, 0, w, h, Color(168, 85, 247))
        else
            draw.RoundedBox(4, 0, 0, w, h, Color(147, 51, 234))
        end
    end
    btn:SetTextColor(color_white)
    btn.DoClick = function()
        gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=3740098135")
    end
    panel:AddItem(btn)
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