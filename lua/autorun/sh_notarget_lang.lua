BonnishBase = BonnishBase or {}
BonnishBase.Lang = BonnishBase.Lang or {}
BonnishBase.AddLanguage = BonnishBase.AddLanguage or function(lang, data)
    BonnishBase.Lang[lang] = BonnishBase.Lang[lang] or {}
    for k, v in pairs(data) do BonnishBase.Lang[lang][k] = v end
end

BonnishBase.AddLanguage("en", {
    ["No Target System"] = "No Target System",
    ["Allow Self No Target"] = "Allow Self No Target",
    ["Allows players with permissions to use NoTarget on themselves."] = "Allows players with permissions to use NoTarget on themselves.",
    ["Allow Target Others"] = "Allow Target Others",
    ["Allows players with permissions to set NoTarget on other players."] = "Allows players with permissions to set NoTarget on other players.",
    ["Chat Command"] = "Chat Command",
    ["The chat command used to toggle NoTarget (e.g. !notarget)."] = "The chat command used to toggle NoTarget (e.g. !notarget).",
    ["Allowed Jobs (DarkRP)"] = "Allowed Jobs (DarkRP)",
    ["DarkRP Jobs that will have NoTarget enabled by default when they spawn."] = "DarkRP Jobs that will have NoTarget enabled by default when they spawn.",
    ["notarget_enabled"] = "No Target is now ENABLED for: ",
    ["notarget_disabled"] = "No Target is now DISABLED for: ",
    ["notarget_no_perm"] = "You do not have permission to toggle No Target."
})

BonnishBase.AddLanguage("es", {
    ["No Target System"] = "Sistema No Target",
    ["Allow Self No Target"] = "Permitir Auto No Target",
    ["Allows players with permissions to use NoTarget on themselves."] = "Permite a los jugadores con permisos usar NoTarget en sí mismos.",
    ["Allow Target Others"] = "Permitir Target a Otros",
    ["Allows players with permissions to set NoTarget on other players."] = "Permite a los jugadores con permisos poner NoTarget a otros jugadores.",
    ["Chat Command"] = "Comando de Chat",
    ["The chat command used to toggle NoTarget (e.g. !notarget)."] = "El comando de chat usado para alternar NoTarget (ej. !notarget).",
    ["Allowed Jobs (DarkRP)"] = "Trabajos Permitidos (DarkRP)",
    ["DarkRP Jobs that will have NoTarget enabled by default when they spawn."] = "Trabajos de DarkRP que tendrán NoTarget activado por defecto al reaparecer.",
    ["notarget_enabled"] = "No Target ACTIVADO para: ",
    ["notarget_disabled"] = "No Target DESACTIVADO para: ",
    ["notarget_no_perm"] = "No tienes permiso para alternar No Target."
})
