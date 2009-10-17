-- LootSpy Localisation
-- By: Tehl of Defias Brotherhood (Thanks to: Ooso)
-- Language: deDE
-- Updated: 21/11/06

if ( GetLocale() == "deDE" ) then

-- Slash Command Feedback
LS_FADEWRONG	=	"|cFFFF0000Error|r: Fade value should be 0 or a time in seconds.";

-- Frame Text
LS_NEED		=	"Bedarf";
LS_GREED	=	"Gier";
LS_PASSED	=	"Passt";
LS_NEEDERS	=	"Bedarf:";

-- Config Frame
LS_DESCTEXT	=	"These options allow you to customize how LootSpy behaves.";
LS_BENABLED	=	"LootSpy enabled";
LS_BLOCKED	=	"Lock LootSpy frame";
LS_BHIDESPAM	=	"Hide need/greed spam from the chat frame";
LS_BCOMPACT	=	"Enable compact mode";

-- Chat String Identification
LS_NEEDSTRING	=	" /'Bedarf/' ausgewählt";
LS_GREEDSTRING	=	" /'Gier/' ausgewählt";
LS_PASSEDSTRING	=	" passt für ";
LS_ALLPASSED	=	"Jeder passt für ";
LS_ITEMWON1	=	" gewinnt:";
LS_ITEMWON2	=	"UNUSED_IN_THIS_LOCALE";

LootSpy_GetLootData = function(arg) 
		arg = string.gsub(arg," hat für ",":");
		arg = string.gsub(arg," habt für ",":");
		arg = string.gsub(arg," passt für ",":");
		arg = string.gsub(arg,"' ausgewählt","");
		arg = string.gsub(arg,"/'","|");
		arg = string.gsub(arg,"Ihr",UnitName("player"));
		local playerName = string.sub(arg,1,strfind(arg,":")-1);
		local itemName = string.sub(arg,strfind(arg,":")+1,strfind(arg,"|")-1);
		local rollType = string.sub(arg,strfind(arg,"|")+1,string.len(arg));
		return itemName,playerName,rollType;
end

end
