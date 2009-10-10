-- LootSpy Localisation
-- By: Tehl of Defias Brotherhood (Thanks to: mymycracra)
-- Language: frFR
-- Updated: 28/11/06

if ( GetLocale() == "frFR" ) then

-- Slash Command Feedback
LS_FADEWRONG	=	"|cFFFF0000Error|r: Fade value should be 0 or a time in seconds.";

-- Frame Text
LS_NEED		=	"Besoin";
LS_GREED	=	"Cupidité";
LS_PASSED	=	"Passé";
LS_NEEDERS	=	"Besoin:";

-- Chat String Identification
LS_NEEDSTRING	=	"choisi Besoin pour";
LS_GREEDSTRING	=	"choisi Cupidité pour";
LS_PASSEDSTRING	=	"a passé pour";
LS_ALLPASSED	=	"Tout le monde a passé pour: ";
LS_ITEMWON1	=	"Vous avez gagné: ";
LS_ITEMWON2	=	" a gagné: ";

LootSpy_GetLootData = function(arg) 
		arg = string.gsub(arg," a choisi ",":");
		arg = string.gsub(arg," avez choisi ",":");
		arg = string.gsub(arg," a ",":");
		arg = string.gsub(arg," avez ",":");
		arg = string.gsub(arg," pour: ","|");
		arg = string.gsub(arg," a gagné: ",":|");
		arg = string.gsub(arg," avez gagné: ",":|");
		arg = string.gsub(arg,"Vous",UnitName("player"));
		local playerName = string.sub(arg,1,strfind(arg,":")-1);
		local itemName = string.sub(arg,strfind(arg,"|")+1,string.len(arg));
		local rollType = string.sub(arg,strfind(arg,":")+1,strfind(arg,"|")-1);
		return itemName,playerName,rollType;
end

end
