--- STEAMODDED HEADER
--- MOD_NAME: Skullatro
--- MOD_ID: skullatro
--- MOD_AUTHOR: [EverSoNitro, Ice, melonade]
--- MOD_DESCRIPTION: guys guess what chicken butt

----------------------------------------------
------------MOD CODE -------------------------

print("[SKULLATRO] Initializing lua scripts...")

local mod_path = "" .. SMODS.current_mod.path

local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
	print("[SKULLATRO] Loading file " .. file)
    assert(SMODS.load_file("items/" .. file))()
end



print("[SKULLATRO] Mod successfully loaded.")

----------------------------------------------
------------MOD CODE END----------------------