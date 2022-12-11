local function GameTooltip_OnTooltipSetItem(tooltip)
	local tooltipName, link = tooltip:GetItem()
	if not link then return; end
	local itemString = string.match(link, "item[%-?%d:]+")
	local _, itemId = strsplit(":", itemString)
	local id = tonumber(itemId)
	local _,_,_,_,_,_,_,_,mainItemEquipLoc = GetItemInfo(id)

	tooltip:AddLine(' ')
	tooltip:AddLine(BBISColor("Better BIS:", "gold"))
	local thereIsOne = false
	for key,value in pairs(BBIS['db']) do
		local classid = key
		local class = BBIS['db'][classid]['class']
		local spec = BBIS['db'][classid]['spec']
		local rank = BbisGetRank(0)
		for key,value in pairs(BBIS['db'][classid]['items']) do
			local thisItemId = BBIS['db'][classid]['items'][key]['id']
			local _,_,_,_,_,_,_,_,thisItemEquipLoc = GetItemInfo(thisItemId)
			if (mainItemEquipLoc == thisItemEquipLoc or BbisBothAreWeapons(mainItemEquipLoc, thisItemEquipLoc)) then
				rank = BbisGetRank()
			end
			if(thisItemId == id) then
				tooltip:AddDoubleLine(BBISColor(spec, class), BBISColor(rank, class))
				thereIsOne = true
			end
		end
	end
	if not thereIsOne then
		tooltip:AddLine(BBISColor("This item is not on any lists", "white"))
	end


	if not IsAltKeyDown() then
		return
	end
	tooltip:AddLine(' ')
	tooltip:AddLine(BBISColor("BIS list:", "gold"))
	local class = UnitClass("Player")
	local spec = BBISgetSpec()
	local classid = class..spec
	BbisGetRank(0)
	if(BBIS['db'][classid]) then
		for key,value in pairs(BBIS['db'][classid]['items']) do
			local thisItemId = BBIS['db'][classid]['items'][key]['id']
			local who = BBIS['db'][classid]['items'][key]['who']
			local loc = BBIS['db'][classid]['items'][key]['location']
			local _,link,_,_,_,_,_,_,itemEquipLoc = GetItemInfo(thisItemId)
			if(itemEquipLoc == mainItemEquipLoc or BbisBothAreWeapons(mainItemEquipLoc, itemEquipLoc)) then
				rank = BbisGetRank()
				color = "white"
				if(id == thisItemId) then
					color = "gold"
				end
				tooltip:AddDoubleLine(BBISColor(rank..' '..link, color), BBISColor(who..' - '..loc, color))
				
				-- This "if" is for stopping the rest of the list.
				if(id == thisItemId) then
					break
				end
				
			end
		end
	end
end

GameTooltip:HookScript("OnTooltipSetItem", GameTooltip_OnTooltipSetItem)
ItemRefTooltip:HookScript("OnTooltipSetItem", GameTooltip_OnTooltipSetItem)