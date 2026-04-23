if SERVER then
    print("Bonnish Utilities - No Target System Initialized")
end

hook.Add("Initialize", "bonnish_no_target_register", function()
    if BonnishBase then
        BonnishBase.RegisterAddon({
            name    = "No Target System",
            id      = "no_target",
            version = "1.0"
        })
    end
end)