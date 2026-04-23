TOOL.Category = "Bonnish Utilities"
TOOL.Name     = "NPC No Target"

if CLIENT then
    language.Add("tool.notarget_tools.name", "No Target")
    language.Add("tool.notarget_tools.desc", "Toggle NoTarget on players")
    language.Add("tool.notarget_tools.left", "Toggle NoTarget on targeted player")
    language.Add("tool.notarget_tools.right", "Toggle NoTarget on yourself")
end

local function ToggleNoTarget(ent)
    if not IsValid(ent) or not ent:IsPlayer() then return end

    local estaActivado = ent:IsFlagSet(FL_NOTARGET)
    
    local nuevoEstado = not estaActivado
    ent:SetNoTarget(nuevoEstado)

    local modo = nuevoEstado and "ACTIVATED" or "DEACTIVATED"
    ent:ChatPrint("No Target is now " .. modo .. " for " .. ent:Nick())
end

function TOOL:LeftClick(trace)
    if CLIENT then return true end

    local ent = trace.Entity
    if IsValid(ent) and ent:IsPlayer() then
        ToggleNoTarget(ent)
        return true 
    end
end

function TOOL:RightClick(trace)
    if CLIENT then return true end

    local ply = self:GetOwner()
    ToggleNoTarget(ply)
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