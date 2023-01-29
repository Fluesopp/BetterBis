BBIS = {}
BBIS['db'] = {}
BBIS['class'] = ""
BBIS['spec'] = ""
local key = 1
local bisrank = 2

function BBISgetClass()
	return UnitClass("Player")
end

function BBISgetSpec()
	local numTabs = GetNumTalentTabs()
	local spec = ""
	local highPoints = 0

	for i=1, numTabs do
		local name, description, pointsSpent, background, previewPointsSpent, isUnlocked = GetTalentTabInfo(i)
		if pointsSpent > highPoints then 
			spec = name
			highPoints = pointsSpent
		end
	end
	return spec
end

function BbisBothAreWeapons(itemA, itemB)
	local weapon = {"INVTYPE_2HWEAPON","INVTYPE_WEAPONMAINHAND"}
	local itemAisWeapon = false
	local itemBisWeapon = false
	for i=1, #weapon do
		if(itemA == weapon[i]) then
			itemAisWeapon = true
		end
		if(itemB == weapon[i]) then
			itemBisWeapon = true
		end
	end
	if(itemAisWeapon and itemBisWeapon)then
		return true
	end
	return false
end

function BbisSetClass(class, spec)
	BBIS['class'] = class
	BBIS['spec'] = spec
end

function BbisRegItem(id, who, location)
	local classID = 
	local class = BBIS['class']
	local spec = BBIS['spec']
	
	if not BBIS['db'][class] then
		BBIS['db'][class] = {}
	end
	if not BBIS['db'][class][spec] then
		BBIS['db'][class][spec] = {}
	end

	BBIS['db'][class][spec]['class'] = BBIS['class']
	BBIS['db'][class][spec]['spec'] = BBIS['spec']

	if not BBIS['db'][class][spec]['items'] then
		BBIS['db'][class][spec]['items'] = {}
		key = 1
	end
	--print('registerd '..classID..' items '..id)
	BBIS['db'][class][spec]['items'][key] = {}
	BBIS['db'][class][spec]['items'][key]['id'] = id
	BBIS['db'][class][spec]['items'][key]['who'] = who
	BBIS['db'][class][spec]['items'][key]['location'] = location
	key = key + 1
end
local rank = 1
function BbisGetRank(new)
	local ranktxt = ""
	if new then rank = new end
	if rank == 1 then
		ranktxt = "BIS"
	elseif rank == 2 then
		ranktxt = rank.."nd"
	elseif rank == 3 then
		ranktxt = rank.."rd"
	else
		ranktxt = rank.."th"
	end
	rank = rank + 1
	return ranktxt
end

function BBISColor(str, color)
    local c = '';

    if color == 'DeathKnight' then c='|cFFC41F3B';
    elseif color == 'Druid' then c='|cFFFF7D0A';
    elseif color == 'Hunter' then c='|cFFABD473';
    elseif color == 'Mage' then c='|cFF69CCF0';
    elseif color == 'Monk' then c='|cFF00FF96';
    elseif color == 'Paladin' then c='|cFFF58CBA';
    elseif color == 'Priest' then c='|cFFFFFFFF';
    elseif color == 'Rogue' then c='|cFFFFF569';
    elseif color == 'Shaman' then c='|cFF0070DE';
    elseif color == 'Warlock' then c='|cFF9482C9';
    elseif color == 'Warrior' then c='|cFFC79C6E';
    elseif color == 'red' then c = '|cFFff0000';
    elseif color == 'gray' then c = '|cFFa6a6a6';
    elseif color == 'purple' then c = '|cFFB900FF';
    elseif color == 'purple' then c = '|cFFB900FF';    
    elseif color == 'blue' then c = '|cFF8080ff';
    elseif color == 'lightBlue' then c = '|cB900FFFF';
    elseif color == 'reputationBlue' then c = '|cFF8080ff';
    elseif color == 'yellow' then c = '|cFFffff00';
    elseif color == 'orange' then c = '|cFFFF6F22';
    elseif color == 'green' then c = '|cFF00ff00';
    elseif color == 'Hunter' then c = '|cFFABD473';    
    elseif color == "white" then c = '|cFFffffff';
    elseif color == "gold" then c = "|cFFffd100" -- this is the default game font
    else c = '|cFFffffff';
    end

    return c .. str .. "|r"
end

function BBISClassColor(class)
	return color
end