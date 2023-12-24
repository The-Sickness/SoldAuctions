local f = CreateFrame("Frame")

f:RegisterEvent("AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION")

f:SetScript("OnEvent", function(self, event, arg1, arg2, arg3)
    if event == "AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION" then
        local itemType, itemName, timestamp = arg1, arg2, arg3
        if itemType == 4 then  -- Assuming 4 indicates a sold auction, adjust this condition as needed
            PlaySoundFile("Interface\\AddOns\\SoldAuction\\alert.mp3")
            
            -- Create a frame for the message
            local msgFrame = CreateFrame("Frame", nil, UIParent)
            msgFrame:SetSize(500, 100)  -- Adjust the size as needed
            msgFrame:SetPoint("CENTER", UIParent, "CENTER")

            -- Create a font string for the text
            local text = msgFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
            text:SetPoint("CENTER", msgFrame, "CENTER")
            text:SetText("Your auction of " .. itemName .. " has sold!")
            
            -- Automatically hide the message after 5 seconds
            C_Timer.After(5, function() msgFrame:Hide() end)
        end
    end
end)






