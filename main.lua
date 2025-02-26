print("[SKULLATRO] Initializing lua scripts...")

local mod_path = "" .. SMODS.current_mod.path

print("[SKULLATRO] Loading item files...")
local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
	print("[SKULLATRO] Loading file " .. file)
    assert(SMODS.load_file("items/" .. file))()
end

print("[SKULLATRO] Loading misc files...")
local files = NFS.getDirectoryItems(mod_path .. "misc")
for _, file in ipairs(files) do
	print("[SKULLATRO] Loading file " .. file)
    assert(SMODS.load_file("misc/" .. file))()
end

print("[SKULLATRO] Mod successfully loaded.")