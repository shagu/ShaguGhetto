local name, text, worldname
local player = UnitName("player")
local f = CreateFrame("Frame", "ShaguGhetto", GameTooltip)
local enabled = nil
local ignores = {
  "what", "why", "wtf", "the", "bot", "addon", "macro", "test", "is"
}

SLASH_GHETTO1 = "/ghetto"
function SlashCmdList.GHETTO(msg, editbox)
  DEFAULT_CHAT_FRAME:AddMessage("|cff33ffccShagu|cffffffffGhetto: " .. (enabled and "|cffffaaaaDisabled" or "|cffaaffaaEnabled"))
  enabled = not enabled
end

GHETTO = true

f:SetScript("OnShow", function()
  local name = UnitName("mouseover")
  if name and ShaguGhetto_config[name] then
    GameTooltip:AddLine("|cff33ffccShagu|cffffffffGhetto:|cffaaaaaa " .. ShaguGhetto_config[name])
    GameTooltip:Show()
  end
end)

f.SendInvite = function(self, name)
  if not name then return end

  -- make sure to leave party if theres no more space left
  if GetNumPartyMembers() > 3 then
    SendChatMessage("There are too many people in this group. Cu :)", "PARTY")
    LeaveParty()
  end

  -- invite player
  InviteUnit(name)

  -- announce name! (max every 5 seconds)
  if not self.lastcall or GetTime() - self.lastcall > 5 then
    local channel = event == "CHAT_MSG_CHANNEL" and "CHANNEL"
    channel = channel or event == "CHAT_MSG_GUILD" and "GUILD"
    channel = channel or event == "CHAT_MSG_YELL" and "YELL"
    channel = channel or "SAY"

    if player == "Ghettomann" then SendChatMessage(player .. "!", channel, nil, GetChannelName("World")) end
    self.lastcall = GetTime()
  end

  ShaguGhetto_config = ShaguGhetto_config or {}
  ShaguGhetto_config[name] = ShaguGhetto_config[name] or 0
  ShaguGhetto_config[name] = ShaguGhetto_config[name] + 1

  local count = 0
  for i, data in pairs(ShaguGhetto_config) do
    count = count + data
  end

  DEFAULT_CHAT_FRAME:AddMessage(name .. ": |cff33ffcc" .. ShaguGhetto_config[name] .. " / " .. count)
end

f:RegisterEvent("CHAT_MSG_SAY") -- enable guild ghetto
f:RegisterEvent("CHAT_MSG_WHISPER") -- enable guild ghetto
f:RegisterEvent("CHAT_MSG_YELL") -- enable guild ghetto
f:RegisterEvent("CHAT_MSG_GUILD") -- enable guild ghetto
f:RegisterEvent("CHAT_MSG_CHANNEL") -- world channels
f:RegisterEvent("PARTY_INVITE_REQUEST") -- decline invitations
f:RegisterEvent("CHAT_MSG_SYSTEM")
f:SetScript("OnEvent", function()
  -- skip events while not being party lead
  if not UnitIsPartyLeader("player") and
    ( GetNumPartyMembers() > 0  or UnitInRaid("player") )
  then
    return
  end

  if not enabled then return end

  text = arg1
  name = arg2

  -- handle bugged out groups
  if event == "CHAT_MSG_SYSTEM" then
    local _, _, name = string.find(arg1, string.gsub(ERR_ALREADY_IN_GROUP_S, "%%s", "(%%S+)"))
    if name then
      SendChatMessage("It says: \"You're already in a group\". Please leave or relog (if bugged) and whisper \"ghetto\" when ready.", "WHISPER", nil, name)
    end
    return
  end

  -- decline invitation and throw invite back
  if event == "PARTY_INVITE_REQUEST" then
    DeclineGroup()
    StaticPopup_Hide("PARTY_INVITE")
    f:SendInvite(arg1)
    return
  end

  -- remove ghettomann false-positives
  text = string.gsub(string.lower(text), "ghettoman", "")
  text = string.gsub(string.lower(text), "ghetto man", "")

  -- skip messages with certain keywords
  for _, keyword in pairs(ignores) do
    if string.find(string.lower(text), keyword) then return end
  end

  -- ignore too long sentences
  if string.len(text) >= 20 then return end

  -- avoid to invite spammers
  if event == "CHAT_MSG_CHANNEL" and worldname == name then
    return
  end

  worldname = name

  -- invite people when ghetto is found
  if text and name and name ~= player and string.find(string.lower(text), "ghetto") then
    f:SendInvite(name)
  end
end)
