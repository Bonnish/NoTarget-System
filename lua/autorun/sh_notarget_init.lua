if BonnishBase and BonnishBase.RegisterAddon then
    BonnishBase.RegisterAddon({
        id = "no_target",
        name = "No Target System",
        version = "1.0",
        workshop = "https://github.com/Bonnish/NoTarget-System",
        settings = {
            { type = "job_list", id = "allowed_jobs", name = "Jobs con No Target (Solo DarkRP)", requireGamemode = "darkrp" },
            { type = "boolean", id = "allow_self", name = "Permitir ponerse No Target a sí mismo", default = true },
            { type = "boolean", id = "allow_others", name = "Permitir dar No Target a otros", default = false },
            { type = "string", id = "command", name = "Comando de chat", default = "!notarget" }
        }
    })
end

if SERVER then
    include("server/sv_notarget_logic.lua")
end
