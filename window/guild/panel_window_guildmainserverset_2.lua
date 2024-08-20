function PaGlobalFunc_GuildMainServerSet_Open()
  if nil == Panel_Guild_MainServerSet_All then
    return
  end
  PaGlobal_GuildMainServerSet:prepareOpen()
end
function PaGlobalFunc_GuildMainServerSet_Close()
  if nil == Panel_Guild_MainServerSet_All then
    return
  end
  PaGlobal_GuildMainServerSet:prepareClose()
end
function PaGlobalFunc_GuildMainServerSet_ListCreateControl(content, key)
  local index = Int64toInt32(key) * 2
  local leftButton = UI.getChildControl(content, "Button_MainServerList_Left")
  local rightButton = UI.getChildControl(content, "Button_MainServerList_Right")
  if nil == leftButton or nil == rightButton then
    return
  end
  local leftServerInfo = ToClient_GetNormalServerInfoByIndex(index)
  if 0 == leftServerInfo._serverNo then
    leftButton:SetShow(false)
    rightButton:SetShow(false)
    return
  end
  local channelName = getChannelName(leftServerInfo._worldNo, leftServerInfo._serverNo)
  local groupName = PaGlobalFunc_Util_GetServerGroupName(channelName)
  leftButton:SetTextMode(__eTextMode_LimitText)
  leftButton:SetText(groupName)
  leftButton:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMainServerSet_SetServer(" .. index .. ")")
  local rightServerInfo = ToClient_GetNormalServerInfoByIndex(index + 1)
  if 0 == rightServerInfo._serverNo then
    rightButton:SetShow(false)
    return
  end
  channelName = getChannelName(rightServerInfo._worldNo, rightServerInfo._serverNo)
  groupName = PaGlobalFunc_Util_GetServerGroupName(channelName)
  rightButton:SetTextMode(__eTextMode_LimitText)
  rightButton:SetText(groupName)
  rightButton:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMainServerSet_SetServer(" .. index + 1 .. ")")
end
function HandleEventLUp_GuildMainServerSet_SetServer(index)
  local serverInfo = ToClient_GetNormalServerInfoByIndex(index)
  if 0 == serverInfo._serverNo then
    return
  end
  local function setGuildMainServer()
    ToClient_SetGuildMainServerGroup(serverInfo._serverGroupNo, serverInfo._serverNo)
  end
  local channelName = getChannelName(serverInfo._worldNo, serverInfo._serverNo)
  local groupName = PaGlobalFunc_Util_GetServerGroupName(channelName)
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local coolTime = ToClient_GetGuildMainServerCoolTime()
  local contentString = ""
  local oneDay = 86400
  if coolTime >= oneDay then
    local day = math.ceil(coolTime / oneDay)
    contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILDSERVERSET_CONFIRM_MESSAGE_DAY", "name", tostring(groupName), "day", tostring(day))
  else
    local hour = math.ceil(coolTime / 3600)
    contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILDSERVERSET_CONFIRM_MESSAGE_HOUR", "name", tostring(groupName), "hour", tostring(hour))
  end
  contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDSERVERSET_CONFIRM_MESSAGE_NORMAL", "name", tostring(groupName))
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = setGuildMainServer,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData, nil, nil, false)
end
function FromClient_GuildMainServerSet_ChangeGuildMainServer(isSet)
  if false == isSet then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isGuildMaster = selfPlayer:get():isGuildMaster()
  if false == isGuildMaster then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  local guildMainServerGroupNo = guildWrapper:getGuildMainServerGroupNo()
  if 0 == guildMainServerGroupNo then
    return
  end
  local serverInfo = ToClient_GetNormalServerInfoByGroupNo(guildMainServerGroupNo)
  if 0 == serverInfo._serverNo then
    return
  end
  local channelName = getChannelName(serverInfo._worldNo, serverInfo._serverNo)
  local groupName = PaGlobalFunc_Util_GetServerGroupName(channelName)
  local completeString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDSERVERSET_CHANGE_COMPLETE", "name", tostring(groupName))
  Proc_ShowMessage_Ack(completeString)
  PaGlobalFunc_GuildMainServerSet_Close()
end
