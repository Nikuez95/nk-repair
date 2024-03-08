Shared = Shared or {}                                   -- Do not touch this

Shared.UseProgressBars = false                          -- Set to true to use progress bars
Shared.ItemUseToRepair = "garbage"                      -- Set the item name to use for repairing vehicles
Shared.MustItemRemove = true                            -- Set to true to remove the item from the player's inventory
Shared.IsWhitelisted = false                            -- Set to true to enable job whitelisting

Shared.WhitelistedJobs = {                              -- Add the jobs that are allowed to use the repair kit
    "bennys",
    "mechanic",
    -- add more jobs here
}

-- Progress Bar Function
Shared.ProgressBar = function(time, txt)
    if Shared.UseProgressBars then
        exports['progressBars']:startUI(time, txt)      -- you can change the progress bar script here
    end
end
