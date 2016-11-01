local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("PLAYER_LOGIN")
local playerClass, englishClass = UnitClass("player");
EventFrame:SetScript("OnEvent", function(self,event,...)
	ChatFrame1:AddMessage('Giered is running for '..UnitName("Player") ..' '.. englishClass)
end)