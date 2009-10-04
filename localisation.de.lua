-- LootSpy Localisation
-- By: Tehl of Defias Brotherhood (Thanks to: Ooso)
-- Language: deDE
-- Updated: 21/11/06

if ( GetLocale() == "deDE" ) then

-- Slash Command Feedback
LS_ENABLED	=	"LootSpy |cFF00FF00enabled|r.";
LS_DISABLED	=	"LootSpy |cFFFF0000disabled|r.";
LS_LOCKED	=	"LootSpy |cFFFF0000locked|r.";
LS_UNLOCKED	=	"LootSpy |cFF00FF00unlocked|r.";
LS_SPAMOFF	=	"LootSpy need/greed spam |cFFFF0000disabled|r.";
LS_SPAMON	=	"LootSpy need/greed spam |cFF00FF00enabled|r.";
LS_NEWFADE	=	"LootSpy frame fade set to |cFFFFFF00";
LS_FADEWRONG	=	"|cFFFF0000Error|r: Fade value should be 0 or a time in seconds.";
LS_COMPACTON	=	"LootSpy compact mode |cFF00FF00enabled|r.";
LS_COMPACTOFF	=	"LootSpy compact mode |cFFFF0000disabled|r.";
LS_SECONDS	=	" |rseconds."

-- Frame Text
LS_NEED		=	"Bedarf";
LS_GREED	=	"Gier";
LS_PASSED	=	"Passt";
LS_NEEDERS	=	"Bedarf:";

-- Chat String Identification
LS_NEEDSTRING	=	" /'Bedarf/' ausgew�hlt";
LS_GREEDSTRING	=	" /'Gier/' ausgew�hlt";
LS_PASSEDSTRING	=	" passt f�r ";
LS_ALLPASSED	=	"Jeder passt f�r ";
LS_ITEMWON1	=	" gewinnt:";
LS_ITEMWON2	=	"UNUSED_IN_THIS_LOCALE";

LootSpy_GetLootData = function(arg) 
		arg = string.gsub(arg," hat f�r ",":");
		arg = string.gsub(arg," habt f�r ",":");
		arg = string.gsub(arg," passt f�r ",":");
		arg = string.gsub(arg,"' ausgew�hlt","");
		arg = string.gsub(arg,"/'","|");
		arg = string.gsub(arg,"Ihr",UnitName("player"));
		local playerName = string.sub(arg,1,strfind(arg,":")-1);
		local itemName = string.sub(arg,strfind(arg,":")+1,strfind(arg,"|")-1);
		local rollType = string.sub(arg,strfind(arg,"|")+1,string.len(arg));
		return itemName,playerName,rollType;
end

end
