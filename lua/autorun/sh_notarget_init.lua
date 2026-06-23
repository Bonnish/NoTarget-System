AddCSLuaFile("sh_notarget_lang.lua")
include("sh_notarget_lang.lua")

if BonnishBase and BonnishBase.RegisterAddon then
    BonnishBase.RegisterAddon({
        id = "no_target",
        name = "No Target System",
        version = "1.2",
        workshop = "https://github.com/Bonnish/NoTarget-System",
        settings = {
            { type = "boolean", id = "allow_self", name = "Allow Self No Target", desc = "Allows players with permissions to use NoTarget on themselves.", default = true },
            { type = "boolean", id = "allow_others", name = "Allow Target Others", desc = "Allows players with permissions to set NoTarget on other players.", default = false },
            { type = "string", id = "command", name = "Chat Command", desc = "The chat command used to toggle NoTarget (e.g. !notarget).", default = "!notarget" },
            { type = "job_list", id = "allowed_jobs", name = "Allowed Jobs (DarkRP)", desc = "DarkRP Jobs that will have NoTarget enabled by default when they spawn.", requireGamemode = "darkrp" }
        }
    })
end

if SERVER then
    include("server/sv_notarget_logic.lua")
end
