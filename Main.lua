local appName = "|CWES:|r ";
local CWESFrame = CreateFrame("FRAME") CWESFrame:Hide()

local playerGUID = UnitGUID("player");

local soundsToMute = {
	-- WARRRIOR
	-- slam
	1258146,
	1258147,
	1258148,
	1258149,
	-- whirlwind
	1093788,
	1093789,
	1093790,
	1093791,
	1093792,
	-- mortal strike
	1267929,
	1267930,
	1267931,
	1267932,
	1267933,
	-- ms impact
	1093783,
	1093784,
	1093785,
	1093786,
	1093787,
	-- overpower
	1337829,
	1337830,
	1337831,
	1337832,
};

local _debug = true -- Enable to Display debug messages.
function errTxt(msg)
	if ( _debug == false ) then
		print(appName.. " _DEBUG : "..msg);
	end
end

function MuteSounds()
	for i, id in ipairs(soundsToMute) do
		MuteSoundFile(id);
	end
end

function CWESFrame:ADDON_LOADED(arg1)
	if arg1 ~= "CWES" then
                return
	end
	self:UnregisterEvent("ADDON_LOADED")
	print(appName.. "Loaded");
	MuteSounds();
end

local PlagueStrikeSounds = {
	"Interface\\Addons\\CWES\\Sounds\\PlagueStrike1.ogg",
	"Interface\\Addons\\CWES\\Sounds\\PlagueStrike2.ogg",
	"Interface\\Addons\\CWES\\Sounds\\PlagueStrike3.ogg"
};

local SwingSounds = {
	"Interface\\Addons\\CWES\\Sounds\\Swing1.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Swing2.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Swing3.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Swing4.ogg"
};

local DSSounds = {
	"Interface\\Addons\\CWES\\Sounds\\DS1.ogg",
	"Interface\\Addons\\CWES\\Sounds\\DS2.ogg",
	"Interface\\Addons\\CWES\\Sounds\\DS3.ogg",
};

local Swords2HSwings = {
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Swords_2H\\Hit1.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Swords_2H\\Hit2.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Swords_2H\\Hit3.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Swords_2H\\Hit4.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Swords_2H\\Hit5.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Swords_2H\\Hit6.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Swords_2H\\Hit7.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Swords_2H\\Hit8.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Swords_2H\\Hit9.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Swords_2H\\Hit10.ogg",
};

local Maces2HSwings = {
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Maces_2H\\Hit1.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Maces_2H\\Hit2.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Maces_2H\\Hit3.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Maces_2H\\Hit4.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Maces_2H\\Hit5.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Maces_2H\\Hit6.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Maces_2H\\Hit7.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Maces_2H\\Hit8.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Maces_2H\\Hit9.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Maces_2H\\Hit10.ogg",
};

local Axes2HSwings = {
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Axes_2H\\Hit1.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Axes_2H\\Hit2.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Axes_2H\\Hit3.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Axes_2H\\Hit4.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Axes_2H\\Hit5.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Axes_2H\\Hit6.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Axes_2H\\Hit7.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Axes_2H\\Hit8.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Axes_2H\\Hit9.ogg",
	"Interface\\Addons\\CWES\\Sounds\\Weapons\\Axes_2H\\Hit10.ogg",
};

-- contains IDs of spells that should play a Rend sound on crit
local CritEffect = {
	[7384] = true,
	-- [12294] = true,
};

local TransmogLocationMixin={}
local transmogLocation = CreateFromMixins(TransmogLocationMixin)
transmogLocation.slotID=16
transmogLocation.type=0
transmogLocation.modification=0

function PlaySwingSound()
	local itemType = DetectWeaponType();
	if itemType == "2H Mace" then
		PlaySoundFile(Maces2HSwings[math.random(#Maces2HSwings)], "SFX");
	elseif itemType == "2H Sword" then
		PlaySoundFile(Swords2HSwings[math.random(#Swords2HSwings)], "SFX");
	elseif itemType == "2H Axe" then
		PlaySoundFile(Axes2HSwings[math.random(#Axes2HSwings)], "SFX");
	end;
end

function DetectWeaponType()
	local baseSourceID, baseVisualID, appliedSourceID, appliedVisualID, appliedCategoryID, pendingSourceID, pendingVisualID, pendingCategoryID, hasUndo, isHideVisual, itemSubclass = C_Transmog.GetSlotVisualInfo(transmogLocation);
	if itemSubclass == 5 then
		return "2H Mace";
	elseif itemSubclass == 8 then
		return "2H Sword";
	elseif itemSubclass == 1 then
		return "2H Axe";
	else
		return;
	end;
end

function BladestormRend()
	local found = select(1, AuraUtil.FindAuraByName("Bladestorm", "player"));
	if found ~= nil then
		PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\Rend.ogg", "SFX");
		C_Timer.After(1, BladestormRend);
	end
end

-- Not Used. Was an attempt to play crit related sounds but without Rend sounds
-- on retail it sounds bad. To much ambient noise on retail comparing to Classic
function CWESFrame:COMBAT_LOG_EVENT_UNFILTERED()
	HandleCombatLog(CombatLogGetCurrentEventInfo());
end

function HandleCombatLog(...)
	local ts, subevent, _, sourceGUID = ...;
	if sourceGUID ~= playerGUID then
		return;
	end

	if subevent == "SPELL_DAMAGE" then
		local spellId, _, _, _, _, _, _, _, _, critical = select(12, ...);
		if CritEffect[spellId] and critical then
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\Rend.ogg", "SFX");
		end
	end
end
--
function CWESFrame:UNIT_SPELLCAST_SUCCEEDED(unitID, lineID, spellID)
	if unitID == "player" then
		errTxt("Spell cast Succeeded by ".. unitID);

		-- Begin Scourge Strike
		if spellID == 55090 then
			PlaySoundFile(SwingSounds[math.random(#SwingSounds)], "SFX");
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\Decisive.ogg", "SFX");
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\HellRot.ogg", "SFX");
			PlaySwingSound();
		end

		-- Begin Festering Strike
		if spellID == 85948 then
			PlaySoundFile(PlagueStrikeSounds[math.random(#PlagueStrikeSounds)], "SFX");
		end

		-- D&D 43265
		if spellID == 43265 then
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\DnD.ogg", "SFX");
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\DnD2.ogg", "SFX");
		end

		-- Death Strike
		if spellID == 49998 then
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\Rend.ogg", "SFX");
			PlaySoundFile(DSSounds[math.random(#DSSounds)], "SFX");
			PlaySwingSound();
		end

		-- Outbreak
		if spellID == 77575 then
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\ShadowCast.ogg", "SFX");
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\HellRot.ogg", "SFX");
		end

		-- Death Coil
		if spellID == 47541 then
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\ShadowCast.ogg", "SFX");
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\DeathCoil.ogg", "SFX");
		end


		-- warrior
		-- Slam
		if spellID == 1464 then
			PlaySoundFile(SwingSounds[math.random(#SwingSounds)], "SFX");
			PlaySwingSound();
		end
		-- Whirlwind
		if spellID == 1680 then
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\Decisive.ogg", "SFX");
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\Whirlwind.ogg", "SFX");
		end

		-- Mortal Strike
		if spellID == 12294 then
			PlaySwingSound();
			PlaySoundFile(SwingSounds[math.random(#SwingSounds)], "SFX");
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\Decisive.ogg", "SFX");
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\Rend.ogg", "SFX");
		end

		-- Execute
		if spellID == 163201 then
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\FireShield.ogg", "SFX");
		end

		-- overpower
		if spellID == 7384 then
			PlaySoundFile(SwingSounds[math.random(#SwingSounds)], "SFX");
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\Decisive.ogg", "SFX");
			-- PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\Rend.ogg", "SFX");
		end

		-- rend
		if spellID == 772 then
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\Rend.ogg", "SFX");
		end

		if spellID == 227847 then
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\BladestormStart.ogg", "SFX");
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\BladestormChannel.ogg", "SFX");
			BladestormRend();
		end

		-- Avatar
		if spellID == 107574 then
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\FireCast.ogg", "SFX");
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\RecklessnessCast.ogg", "SFX");
		end

		-- revenge
		if spellID == 6572 then
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\Revenge.ogg", "SFX");
		end

		-- thunder clap
		if spellID == 6343 then
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\ThunderClap.ogg", "SFX");
			PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\Lightning.ogg", "SFX");
		end
	end

end
CWESFrame:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)
CWESFrame:RegisterEvent("ADDON_LOADED")
CWESFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
CWESFrame:RegisterEvent("PLAYER_DEAD")
CWESFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
