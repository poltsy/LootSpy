-- Originally by Tehl of Defias Brotherhood(EU)

local LootSpySession = {}

local LOOTSPY_VERSION = "3.3.4"

local LS_ALL_PASSED = string.gsub(LOOT_ROLL_ALL_PASSED, "(%%s)", "(.+)")
local LS_GREED = string.gsub(LOOT_ROLL_GREED, "(%%s)", "(.+)")
local LS_GREED_SELF = string.gsub(LOOT_ROLL_GREED_SELF, "(%%s)", "(.+)")
local LS_NEED = string.gsub(LOOT_ROLL_NEED, "(%%s)", "(.+)")
local LS_NEED_SELF = string.gsub(LOOT_ROLL_NEED_SELF, "(%%s)", "(.+)")
local LS_PASSED = string.gsub(LOOT_ROLL_PASSED, "(%%s)", "(.+)")
local LS_PASSED_AUTO = string.gsub(LOOT_ROLL_PASSED_AUTO, "(%%s)", "(.+)")
local LS_PASSED_AUTO_FEMALE = string.gsub(LOOT_ROLL_PASSED_AUTO_FEMALE, "(%%s)", "(.+)")
local LS_PASSED_SELF = string.gsub(LOOT_ROLL_PASSED_SELF, "(%%s)", "(.+)")
local LS_PASSED_SELF_AUTO = string.gsub(LOOT_ROLL_PASSED_SELF_AUTO, "(%%s)", "(.+)")
local LS_DISENCHANT = string.gsub(LOOT_ROLL_DISENCHANT, "(%%s)", "(.+)")
local LS_DISENCHANT_SELF = string.gsub(LOOT_ROLL_DISENCHANT_SELF, "(%%s)", "(.+)")
local LS_YOU_WON = string.gsub(LOOT_ROLL_YOU_WON, "(%%s)", "(.+)")
local LS_WON = string.gsub(LOOT_ROLL_WON, "(%%s)", "(.+)")

function LootSpyConfigFrame_OnEscapePressed(self)
	if not (LootSpy_Saved) then return end

	self:SetText( LootSpy_Saved["fade"] );
end

function LootSpyConfigFrame_OnEnterPressed(self)
	if not (LootSpy_Saved) then return end

	local fadeTime = self:GetNumber()
	if ( fadeTime >= 0 ) then
		LootSpy_Saved["fade"] = fadeTime;
	end
end

function LootSpyConfigFrame_OnClick(self)
	if not (LootSpy_Saved) then return end

	-- I'm lazy so I'll just reuse the already existing slash function
	if ( self:GetName() == (this:GetParent():GetName().."CheckButtonToggle") ) then
		setting = "toggle"
	elseif ( self:GetName() == (this:GetParent():GetName().."CheckButtonLocked") ) then
		setting = "locked"
	elseif ( self:GetName() == (this:GetParent():GetName().."CheckButtonSpam") ) then
		setting = "spam"
	elseif ( self:GetName() == (this:GetParent():GetName().."CheckButtonCompact") ) then
		setting = "compact"
	end
	LootSpy_Slash(setting);
end

function LootSpyConfigFrame_OnLoad(panel)
	panel.name = "LootSpy"
	panel.default = LootSpy_SetDefaults;
	InterfaceOptions_AddCategory(panel);
end

function LootSpy_SetDefaults()
	-- check each setting and toggle switch if not default
	if not (LootSpy_Saved) then return end

	if (LootSpy_Saved["on"] == false) then
		LootSpy_Slash("toggle");
	end
	if (LootSpy_Saved["locked"] == true) then
		LootSpy_Slash("locked");
	end
	if (LootSpy_Saved["hideSpam"] == false) then
		LootSpy_Slash("spam");
	end
	if (LootSpy_Saved["compact"] == true) then
		LootSpy_Slash("compact");
	end

	-- reset back to the center of the screen
	LootSpy_LootButton1:ClearAllPoints();
	LootSpy_LootButton1:SetPoint("TOPLEFT","UIParent","CENTER");
	LootSpy_CompactLootButton1:ClearAllPoints();
	LootSpy_CompactLootButton1:SetPoint("TOPLEFT","UIParent","CENTER");

	LootSpy_Saved["fade"] = 5;
	LootSpy_Saved["coordX"] = LootSpy_LootButton1:GetLeft();
	LootSpy_Saved["coordY"] = LootSpy_LootButton1:GetTop();
	LootSpy_LootButton1:ClearAllPoints();
	LootSpy_LootButton1:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",LootSpy_Saved["coordX"],LootSpy_Saved["coordY"]);
	LootSpy_CompactLootButton1:ClearAllPoints();
	LootSpy_CompactLootButton1:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",LootSpy_Saved["coordX"],LootSpy_Saved["coordY"]);

	-- update the settings frame to reflect any changes made to config
	LootSpyConfigFrame_SetSettings();
end

function LootSpyConfigFrame_SetSettings()
	LootSpyConfigFrameCheckButtonToggle:SetChecked( LootSpy_Saved["on"] );
	LootSpyConfigFrameCheckButtonLocked:SetChecked( LootSpy_Saved["locked"] );
	LootSpyConfigFrameCheckButtonSpam:SetChecked( LootSpy_Saved["hideSpam"] );
	LootSpyConfigFrameCheckButtonCompact:SetChecked( LootSpy_Saved["compact"] );
	LootSpyConfigFrameEditBoxFade:SetText( LootSpy_Saved["fade"] );
end

function LootSpyConfigFrame_OnShow()
	if not (LootSpy_Saved) then return end

	LootSpyConfigFrame_SetSettings();
	getglobal(this:GetName().."TitleFontString"):SetFont("Fonts\\FRIZQT__.TTF", 16);
	getglobal(this:GetName().."TitleFontString"):SetText("LootSpy");
	getglobal(this:GetName().."DescFontString"):SetFont("Fonts\\FRIZQT__.TTF", 10);
	getglobal(this:GetName().."DescFontString"):SetText("|cFFFFFFFF"..LS_DESCTEXT.."|r");
	getglobal(this:GetName().."VersionFontString"):SetText("LootSpy "..LOOTSPY_VERSION);
end

function LootSpy_Init(self)
	for i = 1,10 do
		getglobal("LootSpy_LootButton"..i):Hide();
		getglobal("LootSpy_CompactLootButton"..i):Hide();
	end

	if not (LootSpy_Saved) then
		LootSpy_Saved = {
			["on"] = true,
			["locked"] = false,
			["hideSpam"] = true,
			["coordX"] = LootSpy_LootButton1:GetLeft(),
			["coordY"] = LootSpy_LootButton1:GetTop(),
		};
	end

	if not (LootSpy_Saved["fade"]) then
		LootSpy_Saved["fade"] = 5;
	end
	
	if not (LootSpy_Saved["compact"]) then
		LootSpy_Saved["compact"] = 0;
	end

	LootSpy_LootButton1:ClearAllPoints();
	LootSpy_LootButton1:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",LootSpy_Saved["coordX"],LootSpy_Saved["coordY"]);
	LootSpy_CompactLootButton1:ClearAllPoints();
	LootSpy_CompactLootButton1:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",LootSpy_Saved["coordX"],LootSpy_Saved["coordY"]);

	if (LootSpy_Saved["locked"] == false) and (LootSpy_Saved["on"] == true) then
		for i = 1,10 do
			local buttonName = "nil";
			if (LootSpy_Saved["compact"] == true) then
				buttonName = "LootSpy_CompactLootButton";
			else
				buttonName = "LootSpy_LootButton";
			end
			getglobal(buttonName..i):Show();
		end
	end

	if (LootSpy_Saved["on"] == true) then -- don't listen if we don't care
		self:RegisterEvent("START_LOOT_ROLL")
		self:RegisterEvent("CHAT_MSG_LOOT")
	end

	if (LootSpy_Saved["on"] == true) and (LootSpy_Saved["hideSpam"] == true) then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", LootSpy_ChatFilter)
	end

	SLASH_LOOTSPY1 = "/lootspy";
	SLASH_LOOTSPY2 = "/ls";
	SlashCmdList["LOOTSPY"] = LootSpy_Slash;
end

function LootSpy_Slash(arg)
	if (arg == "toggle") then
		if (LootSpy_Saved["on"] == true) then
			LootSpy_Saved["on"] = false;
			for i = 1,10 do
				local buttonName = "nil";
				if (LootSpy_Saved["compact"] == true) then
					buttonName = "LootSpy_CompactLootButton";
				else
					buttonName = "LootSpy_LootButton";
				end
				getglobal(buttonName..i):Hide();
			end
			this:UnregisterEvent("START_LOOT_ROLL")
			this:UnregisterEvent("CHAT_MSG_LOOT")
		else
			LootSpy_Saved["on"] = true;
			LootSpy_UpdateTable();
			if (LootSpy_Saved["locked"] == false) and (LootSpy_Saved["on"] == true) then
				for i = 1,10 do
					local buttonName = "nil";
					if (LootSpy_Saved["compact"] == true) then
						buttonName = "LootSpy_CompactLootButton";
					else
						buttonName = "LootSpy_LootButton";
					end
					getglobal(buttonName..i):Show();
				end
			this:RegisterEvent("START_LOOT_ROLL")
			this:RegisterEvent("CHAT_MSG_LOOT")
			end
		end
	elseif (arg == "locked") then
		if (LootSpy_Saved["locked"] == true) then
			LootSpy_Saved["locked"] = false;
			if (LootSpy_Saved["on"] == true) then
				for i = 1,10 do
					local buttonName = "nil";
					if (LootSpy_Saved["compact"] == true) then
						buttonName = "LootSpy_CompactLootButton";
					else
						buttonName = "LootSpy_LootButton";
					end
					getglobal(buttonName..i):Show();
				end
			end
		else
			LootSpy_Saved["locked"] = true;
			LootSpy_UpdateTable();
		end
	elseif (arg == "spam") then
		if (LootSpy_Saved["hideSpam"] == true) then
			LootSpy_Saved["hideSpam"] = false;
			ChatFrame_RemoveMessageEventFilter("CHAT_MSG_LOOT", LootSpy_ChatFilter)
		else
			LootSpy_Saved["hideSpam"] = true;
			ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", LootSpy_ChatFilter)
		end
	elseif (arg == "compact") then
		if (LootSpy_Saved["compact"] == true) then
			LootSpy_Saved["compact"] = false;
			LootSpy_UpdateTable();
			if (LootSpy_Saved["locked"] == false) and (LootSpy_Saved["on"] == true) then
				for i = 1,10 do
					getglobal("LootSpy_LootButton"..i):Show();
				end
			end
		else
			LootSpy_Saved["compact"] = true;
			LootSpy_UpdateTable();
			if (LootSpy_Saved["locked"] == false) and (LootSpy_Saved["on"] == true) then
				for i = 1,10 do
					getglobal("LootSpy_CompactLootButton"..i):Show();
				end
			end
		end
	elseif (string.sub(arg,1,4) == "fade") then
		local fadeTime = tonumber(string.sub(arg,5));
		if (fadeTime >= 0) then
			LootSpy_Saved["fade"] = fadeTime;
		else
			DEFAULT_CHAT_FRAME:AddMessage(LS_FADEWRONG);
		end
	else
	        if InterfaceOptionsFrame:IsVisible() then
			InterfaceOptionsFrame:Hide();
		else
			InterfaceOptionsFrame_OpenToCategory("LootSpy");
		end
	end
end

function LootSpy_OnEvent(self, event, ...)
	local addon = ... or "n/a"

	if event == "ADDON_LOADED" then
	  if addon ~= "LootSpy" then return end -- this is not the addon you're looking for
	  self:UnregisterEvent("ADDON_LOADED")
	  LootSpy_Init(self)
	elseif event == "START_LOOT_ROLL" then
	  LootSpy_START_LOOT_ROLL(...)
	elseif event == "CHAT_MSG_LOOT" then
	  LootSpy_CHAT_MSG_LOOT(...)
	end
end

function LootSpy_OnUpdate()
	local i = 1;
	for item in pairs(LootSpySession) do
		if (LootSpySession[item]["timeWon"] > 0) and (LootSpy_Saved["fade"] > 0) then
			local alpha = 1 - (GetTime() - LootSpySession[item]["timeWon"] - LootSpy_Saved["fade"] + 1);
			if (alpha > 0) then
				local buttonName = "nil";
				if (LootSpy_Saved["compact"] == true) then
					buttonName = "LootSpy_CompactLootButton";
				else
					buttonName = "LootSpy_LootButton";
				end
				getglobal(buttonName..i):SetAlpha(alpha);
			else
				LootSpy_Remove(i);
			end
		end
		i = i + 1;
		if (i > 10) then
			return;
		end
	end
end

function LootSpy_UpdateTable()
	for i = 1,10 do
		getglobal("LootSpy_LootButton"..i):SetAlpha(1);
		getglobal("LootSpy_LootButton"..i):Hide();
		getglobal("LootSpy_CompactLootButton"..i):SetAlpha(1);
		getglobal("LootSpy_CompactLootButton"..i):Hide();
	end
	local i = 1;
	for item in pairs(LootSpySession) do
		local buttonName = "nil";
		if (LootSpy_Saved["compact"] == true) then
			buttonName = "LootSpy_CompactLootButton";
		else
			buttonName = "LootSpy_LootButton";
		end
		getglobal(buttonName..i):Show();
		if (LootSpy_Saved["compact"] == true) then
			getglobal(buttonName..i.."Text"):SetText("|cFFFF0000"..LootSpySession[item]["need"].."|cFF00FF00 "..LootSpySession[item]["greed"].."|r "..LootSpySession[item]["passed"]);
		else
			getglobal(buttonName..i.."NeedText"):SetText("|cFFFF0000"..LootSpySession[item]["need"].."|r");
			getglobal(buttonName..i.."GreedText"):SetText("|cFF00FF00"..LootSpySession[item]["greed"].."|r");
			getglobal(buttonName..i.."PassedText"):SetText(LootSpySession[item]["passed"]);
		end
		getglobal(buttonName..i.."ItemIcon"):SetTexture(LootSpySession[item]["icon"]);
		i = i + 1;
		if (i > 10) then
			return;
		end
	end
end

function LootSpy_Tooltip(id)
	GameTooltip:SetOwner(this,"ANCHOR_CURSOR");
	local name = "nil";
	for item in pairs(LootSpySession) do
		id = id - 1;
		if (id == 0) then
			name = item;
		end
	end
	GameTooltip:SetText(LootSpySession[name]["name"]);
	for player in pairs(LootSpySession[name]["needNames"]) do
		GameTooltip:AddLine(LootSpySession[name]["needNames"][player],1)
	end
	for player in pairs(LootSpySession[name]["greedNames"]) do
		GameTooltip:AddLine(LootSpySession[name]["greedNames"][player],0,1)
	end
	for player in pairs(LootSpySession[name]["passNames"]) do
		GameTooltip:AddLine(LootSpySession[name]["passNames"][player])
	end
	GameTooltip:Show();
end

function LootSpy_ItemTooltip(id)
	GameTooltip:SetOwner(this,"ANCHOR_CURSOR");
	local itemLink = "nil";
	for item in pairs(LootSpySession) do
		id = id - 1;
		if (id == 0) then
			itemLink = LootSpySession[item]["link"];
		end
	end
	GameTooltip:ClearLines();
	GameTooltip:SetHyperlink(itemLink);
	GameTooltip:Show();
end

function LootSpy_Remove(id)
	local name = "nil";
	for item in pairs(LootSpySession) do
		id = id - 1;
		if (id == 0) then
			name = item;
		end
	end
	if (LootSpySession[name]) then
	  LootSpySession[name] = nil;
	end 
	LootSpy_UpdateTable();
end

function LootSpy_UpdatePosition()
	local buttonName = "nil";
	if (LootSpy_Saved["compact"] == true) then
		buttonName = "LootSpy_CompactLootButton";
	else
		buttonName = "LootSpy_LootButton";
	end
	LootSpy_Saved["coordX"] = getglobal(buttonName.."1"):GetLeft();
	LootSpy_Saved["coordY"] = getglobal(buttonName.."1"):GetTop();
	LootSpy_LootButton1:ClearAllPoints();
	LootSpy_LootButton1:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",LootSpy_Saved["coordX"],LootSpy_Saved["coordY"]);
	LootSpy_CompactLootButton1:ClearAllPoints();
	LootSpy_CompactLootButton1:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",LootSpy_Saved["coordX"],LootSpy_Saved["coordY"]);
end

function LootSpy_unformat(fmt, msg) -- pattern matching and mangling magic lifted from RollWatcher
	local _, _, a1, a2 = string.find(msg, fmt)
	return a1, a2
end

function LootSpy_START_LOOT_ROLL(rollid)
	local pm = GetNumPartyMembers()
	local rm = GetNumRaidMembers()

	if (pm < 1) and (rm < 1) then return end

	if not (LootSpy_Saved) then return end

	if (LootSpy_Saved["on"] == true) then
	  local texture, itemName = GetLootRollItemInfo(rollid)
	  local itemLink = GetLootRollItemLink(rollid)
	  LootSpySession[rollid] = {
	  	["name"] = itemName,
	  	["icon"] = texture,
	  	["link"] = itemLink,
	  	["need"] = 0,
	  	["needNames"] = {},
	  	["greedNames"] = {}, -- adding these to see who is holding up the roll
	  	["passNames"] = {},
	  	["greed"] = 0,
	  	["passed"] = 0,
	  	["timeWon"] = 0
	  };
	end
	LootSpy_UpdateTable()
end

function LootSpy_SaveRoll(itemLink, rollType, playerName)
	for rollid in pairs(LootSpySession) do
	  if LootSpySession[rollid]["link"] == itemLink then
		if (rollType == "end") then
		  LootSpySession[rollid]["timeWon"] = GetTime()
		elseif (rollType == "need") then
		  local i = 1
		  while (LootSpySession[rollid]["needNames"][i]) do
			i = i + 1
		  end
		  if (i < 10) then LootSpySession[rollid]["needNames"][i] = playerName end -- hueg tooltip is too big, maybe make it configurable per type
		  LootSpySession[rollid]["need"] = LootSpySession[rollid]["need"] + 1
		elseif (rollType == "greed") then
		  local i = 1
		  while (LootSpySession[rollid]["greedNames"][i]) do
		  	i = i + 1
		  end
		  if (i < 10) then LootSpySession[rollid]["greedNames"][i] = playerName end
		  LootSpySession[rollid]["greed"] = LootSpySession[rollid]["greed"] + 1
		elseif (rollType == "pass") then
		  local i = 1
		  while (LootSpySession[rollid]["passNames"][i]) do
		  	i = i + 1
		  end
		  if (i < 10) then LootSpySession[rollid]["passNames"][i] = playerName end
		  LootSpySession[rollid]["passed"] = LootSpySession[rollid]["passed"] + 1
		end
	  end
	end
	LootSpy_UpdateTable()
end

function LootSpy_CHAT_MSG_LOOT(msg)
	if not (LootSpy_Saved) then return end
	if not (LootSpy_Saved["on"] == true) then return end -- if not enabled return

	local pm = GetNumPartyMembers()
	local rm = GetNumRaidMembers()

	if (pm < 1) and (rm < 1) then return end
	
	local item, name
	local i = UnitName("player")

	item = LootSpy_unformat(LS_YOU_WON, msg)
	if item then LootSpy_SaveRoll(item, "end", i) return end

	name, item = LootSpy_unformat(LS_WON, msg)
	if name then LootSpy_SaveRoll(item, "end", name) return end

	item = LootSpy_unformat(LS_ALL_PASSED, msg)
	if item then LootSpy_SaveRoll(item, "end") return end

	item = LootSpy_unformat(LS_DISENCHANT_SELF, msg)
	if item then LootSpy_SaveRoll(item, "greed", i) return end

	name, item = LootSpy_unformat(LS_DISENCHANT, msg)
	if name then LootSpy_SaveRoll(item, "greed", name) return end

	item = LootSpy_unformat(LS_GREED_SELF, msg)
	if item then LootSpy_SaveRoll(item, "greed", i) return end

	name, item = LootSpy_unformat(LS_GREED, msg)
	if name then LootSpy_SaveRoll(item, "greed", name) return end

	item = LootSpy_unformat(LS_PASSED_SELF, msg)
	if item then LootSpy_SaveRoll(item, "pass", i) return end

	item = LootSpy_unformat(LS_PASSED_SELF_AUTO, msg)
	if item then LootSpy_SaveRoll(item, "pass", i) return end

	name, item = LootSpy_unformat(LS_PASSED, msg)
	if name then LootSpy_SaveRoll(item, "pass", name) return end

	name, item = LootSpy_unformat(LS_PASSED_AUTO, msg)
	if name then LootSpy_SaveRoll(item, "pass", name) return end

	name, item = LootSpy_unformat(LS_PASSED_AUTO_FEMALE, msg)
	if name then LootSpy_SaveRoll(item, "pass", name) return end

	item = LootSpy_unformat(LS_NEED_SELF, msg)
	if item then LootSpy_SaveRoll(item, "need", i) return end

	name, item = LootSpy_unformat(LS_NEED, msg)
	if name then LootSpy_SaveRoll(item, "need", name) return end
end

function LootSpy_ChatFilter(self, event, msg)
	local pm = GetNumPartyMembers()
	local rm = GetNumRaidMembers()

	if (pm < 1) and (rm < 1) then return end

	if msg:match(LS_DISENCHANT) or msg:match(LS_GREED) or msg:match(LS_PASSED) or msg:match(LS_NEED)
	    or msg:match(LS_PASSED_AUTO) or msg:match(LS_PASSED_AUTO_FEMALE) or msg:match(LS_DISENCHANT_SELF)
	    or msg:match(LS_GREED_SELF) or msg:match(LS_NEED_SELF) or msg:match(LS_PASSED_SELF_AUTO)
	    and not msg:match(LS_ALL_PASSED)
	  then return true
	end
end
