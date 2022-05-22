function AreWeaponProficienciesModified()
	-- check for being dead (HP <= 0), which normally only disables the level-up button
	if characters[currentID].HP.current <= 0 then
		return false;
	end
	local f = {};
	f[143] = true; -- check for the Maze icon (since the Maze icon is in the default "STATES.BAM", we need to check index, not BAM. Values 0 – 190 are drawn directly from "STATES.BAM" from sequences 65 – 255, so: 65 + 78 = 143)
	f["SPPR750D"] = true; -- check for the Ether Gate (Shaman Maze) icon
	f["WEAPPROF"] = true; -- custom portrait icon for Weapon Proficiencies Modification
	for k, v in pairs(characters[currentID].statusEffects) do
		if f[v.bam] == true then
			return false
		elseif f[v.current] == true then
			return false
		end
	end
	return true;
end
