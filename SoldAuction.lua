local addonName = "SoldAuction"

SoldAuction = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local f = CreateFrame("Frame")

f:RegisterEvent("AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION")

local soundList = {
    "Interface\\AddOns\\SoldAuction\\Sounds\\Sheldon.mp3",
    "Interface\\AddOns\\SoldAuction\\Sounds\\ReadyCheck.mp3",
    "Interface\\AddOns\\SoldAuction\\Sounds\\alarmclock1.ogg",
    "Interface\\AddOns\\SoldAuction\\Sounds\\alarmclock2.ogg",
    "Interface\\AddOns\\SoldAuction\\Sounds\\dogprimal_alert.ogg",
    "Interface\\AddOns\\SoldAuction\\Sounds\\forthealliance.ogg",
    "Interface\\AddOns\\SoldAuction\\Sounds\\taurenmale_forhorde.ogg",
    "Interface\\AddOns\\SoldAuction\\Sounds\\pvpwarninghorde.ogg",
    "Interface\\AddOns\\SoldAuction\\Sounds\\mechanicalhandpet.ogg",
    "Interface\\AddOns\\SoldAuction\\Sounds\\go_lightforged.ogg",
}

-- Function to show auction sold notification
local function ShowAuctionSoldNotification(itemName)
    local msgFrame = CreateFrame("Frame", nil, UIParent)
    msgFrame:SetSize(500, 100)  -- Adjust the size as needed
    msgFrame:SetPoint("CENTER", UIParent, "CENTER")

    -- Create a font string for the text
    local text = msgFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    text:SetPoint("CENTER", msgFrame, "CENTER")
    text:SetText("Your auction of " .. itemName .. " has sold!")

    C_Timer.After(5, function() msgFrame:Hide() end)
end

-- Event handler for auction notifications
f:SetScript("OnEvent", function(self, event, arg1, arg2, arg3)
    if event == "AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION" then
        local itemType, itemName, timestamp = arg1, arg2, arg3
        if itemType == 4 then  -- Assuming 4 indicates a sold auction
            PlaySoundFile(soundList[SoldAuction.db.char.selectedSound], "Master")

            ShowAuctionSoldNotification(itemName)
        end
    end
end)

-- AceConfig setup for options
local options = {
    name = addonName,
    type = 'group',
    args = {
        soundSelect = {
            type = 'select',
            name = 'Select Auction Sold Sound',
            values = {
                [1] = "Sheldon",
                [2] = "Ready Check",
                [3] = "Alarm Clock1",
                [4] = "Alarm Clock2",
                [5] = "Primal Dog",
                [6] = "4 The Alliance",
                [7] = "4 The Horde",
                [8] = "PvP warning",
                [9] = "Mechanical Pet",
                [10] = "LightForged",
            },
            get = function(info) return SoldAuction.db.char.selectedSound end,
            set = function(info, value)
                SoldAuction.db.char.selectedSound = value
                PlaySoundFile(soundList[value], "Master")
            end,
            order = 2,
        },
    },
}

-- Register options in the Addon Interface
function SoldAuction:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("SoldAuctionDB", { char = { selectedSound = 1 } }, true)
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, addonName)
end
