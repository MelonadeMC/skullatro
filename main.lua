print("[SKULLATRO] Initializing lua scripts...")

local mod_path = "" .. SMODS.current_mod.path

local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
	print("[SKULLATRO] Loading file " .. file)
    assert(SMODS.load_file("items/" .. file))()
end



print("[SKULLATRO] Mod successfully loaded.")