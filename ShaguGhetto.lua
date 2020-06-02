local name, text
local player = UnitName("player")
local f = CreateFrame("Frame", "ShaguGhetto", UIParent)
f:RegisterEvent("CHAT_MSG_SAY") -- enable guild ghetto
f:RegisterEvent("CHAT_MSG_WHISPER") -- enable guild ghetto
f:RegisterEvent("CHAT_MSG_YELL") -- enable guild ghetto
f:RegisterEvent("CHAT_MSG_GUILD") -- enable guild ghetto
f:RegisterEvent("CHAT_MSG_CHANNEL") -- world channels
f:RegisterEvent("PARTY_INVITE_REQUEST") -- decline invitations
f:RegisterEvent("CHAT_MSG_SYSTEM")
f:SetScript("OnEvent", function()
  text = arg1
  name = arg2

  -- handle bugged out groups
  if event == "CHAT_MSG_SYSTEM" then
    local _, _, name = string.find(arg1, string.gsub(ERR_ALREADY_IN_GROUP_S, "%%s", "(%%S+)"))
    if name then
      SendChatMessage("You're already in a group. Please relog and try again.", "WHISPER", nil, name)
    end
    return
  end

  -- decline invitations
  if event == "PARTY_INVITE_REQUEST" then
    DeclineGroup()
    StaticPopup_Hide("PARTY_INVITE")
    SendChatMessage("Sorry, I don't accept invites. You either need to use the word \"ghetto\" in SAY, YELL, WORLD or WHISPER.", "WHISPER", nil, arg1)
    return
  end

  -- skip on false-positives
  if text and name and string.find(string.lower(text), string.lower(player)) then return end
  if text and name and string.find(string.lower(text), string.lower("ghettoman")) then return end
  if text and name and string.find(string.lower(text), string.lower("ghetto mann")) then return end
  if text and name and string.find(string.lower(text), string.lower("ghetto man")) then return end

  -- make sure to leave party if theres no more space left
  if GetNumPartyMembers() > 3 then LeaveParty() end

  -- invite people when ghetto is found
  if text and name and name ~= player and string.find(string.lower(text), "ghetto") then
    -- invite player
    InviteUnit(name)

    -- announce name! (max every 5 seconds)
    if not this.lastcall or GetTime() - this.lastcall > 5 then
      local channel = event == "CHAT_MSG_CHANNEL" and "CHANNEL" or "SAY"
      if player == "Ghettomann" then SendChatMessage(player .. "!", channel, nil, GetChannelName("World")) end
      this.lastcall = GetTime()
    end

    ShaguGhetto_config = ShaguGhetto_config or {}
    ShaguGhetto_config[name] = ShaguGhetto_config[name] or 0
    ShaguGhetto_config[name] = ShaguGhetto_config[name] + 1

    print(name .. ": |cff33ffcc" .. ShaguGhetto_config[name])
    AddFriend(name)
  end
end)

function ShaguGhettoStats()
  for name, count in pairs(ShaguGhetto_config) do
    DEFAULT_CHAT_FRAME:AddMessage(name .. ": |cff33ffcc" .. count)
  end
end
