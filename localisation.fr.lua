-- LootSpy Localisation
-- By: Tehl of Defias Brotherhood (Thanks to: mymycracra)
-- Language: frFR
-- Updated: 28/11/06

if ( GetLocale() == "frFR" ) then

-- Slash Command Feedback
LS_FADEWRONG	=	"|cFFFF0000Error|r: Fade value should be 0 or a time in seconds.";

-- Frame Text
LS_NEED		=	"Besoin";
LS_GREED	=	"Cupidit�";
LS_PASSED	=	"Pass�";
LS_NEEDERS	=	"Besoin:";

-- Chat String Identification
LS_NEEDSTRING	=	"choisi Besoin pour";
LS_GREEDSTRING	=	"choisi Cupidit� pour";
LS_PASSEDSTRING	=	"a pass� pour";
LS_ALLPASSED	=	"Tout le monde a pass� pour: ";
LS_ITEMWON1	=	"Vous avez gagn�: ";
LS_ITEMWON2	=	" a gagn�: ";

LootSpy_GetLootData = function(arg) 
		arg = string.gsub(arg," a choisi ",":");
		arg = string.gsub(arg," avez choisi ",":");
		arg = string.gsub(arg," a ",":");
		arg = string.gsub(arg," avez ",":");
		arg = string.gsub(arg," pour: ","|");
		arg = string.gsub(arg," a gagn�: ",":|");
		arg = string.gsub(arg," avez gagn�: ",":|");
		arg = string.gsub(arg,"Vous",UnitName("player"));
		local playerName = string.sub(arg,1,strfind(arg,":")-1);
		local itemName = string.sub(arg,strfind(arg,"|")+1,string.len(arg));
		local rollType = string.sub(arg,strfind(arg,":")+1,strfind(arg,"|")-1);
		return itemName,playerName,rollType;
end

end
