function PaGlobalFunc_CrewMain_All_Open()
  PaGlobal_CrewMain_All:prepareOpen()
end
function PaGlobalFunc_CrewMain_All_Close(allClose)
  PaGlobal_CrewMain_All:prepareClose(allClose)
end
function PaGlobalFunc_CrewMain_All_SubMenuOpen(index)
  PaGlobal_CrewMain_All:subMenuOpen(index)
end
function PaGlobalFunc_CrewMain_All_EntryCrewMatch(isReady)
  ToClient_RequestEntryCrewMatch(isReady)
end
function PaGlobalFunc_CrewMain_All_StartCrewMatch()
  ToClient_RequestStartCrewMatch()
end
function PaGlobalFunc_CrewMain_All_DestroyCrew()
  local crewWrapper = ToClient_GetMyCrewInfoWrapper()
  if nil == crewWrapper then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CREW_MSG_NOTEXPLOSIVE"))
    return
  end
  if crewWrapper:getMemberCount() <= 1 then
    local DestroyCrew = function()
      ToClient_RequestDestroyCrew()
    end
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_CREW_MSG_EXPLOSIVE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_CREW_MSG_EXPLOSIVECONFIRM"),
      functionYes = DestroyCrew,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CREW_MSG_NOTEXPLOSIVE"))
  end
end
function PaGlobalFunc_CrewMain_All_InviteCrewMember()
  if nil ~= PaGlobalFunc_Invite_All_Open then
    PaGlobalFunc_Invite_All_Open(PaGlobal_Invite_All._type.Crew)
  end
end
function PaGlobalFunc_CrewMain_All_SetFocus()
  ClearFocusEdit()
  SetFocusEdit(PaGlobal_CrewMain_All._ui.edit_comment)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobal_CrewMain_All._ui.edit_comment:SetEditText(PaGlobal_CrewMain_All._ui.edit_comment:GetEditText(), true)
end
function PaGlobalFunc_CrewMain_All_VirtualKeyBoardEnd(str)
  if nil ~= str then
    ClearFocusEdit()
    PaGlobal_CrewName_All._ui.edit_crewName:SetEditText(str)
    PaGlobalFunc_CrewMain_All_SetCrewNotice()
  end
end
function PaGlobalFunc_CrewMain_All_SetCrewNotice()
  local notice = PaGlobal_CrewMain_All._ui.edit_comment:GetEditText()
  if nil == notice then
    return
  end
  ToClient_RequestSetCrewNotice(notice)
  ClearFocusEdit()
end
function PaGlobal_CrewMain_All_MemberList_ControlCreate(content, key)
  local index = Int64toInt32(key) * 2
  local leftSlot = {}
  local rightSlot = {}
  leftSlot.bg = UI.getChildControl(content, "Static_Slot_Left_BG")
  rightSlot.bg = UI.getChildControl(content, "Static_Slot_Right_BG")
  if nil == leftSlot.bg or nil == rightSlot.bg then
    return
  end
  leftSlot.bg:SetShow(true)
  rightSlot.bg:SetShow(true)
  leftSlot.bg:setNotImpactScrollEvent(true)
  rightSlot.bg:setNotImpactScrollEvent(true)
  leftSlot.bg:addInputEvent("Mouse_RUp", "PaGlobalFunc_CrewMain_All_SubMenuOpen(" .. index .. ")")
  leftSlot.bg:addInputEvent("Mouse_LUp", "")
  rightSlot.bg:addInputEvent("Mouse_RUp", "PaGlobalFunc_CrewMain_All_SubMenuOpen(" .. index + 1 .. ")")
  rightSlot.bg:addInputEvent("Mouse_LUp", "")
  if true == PaGlobal_CrewMain_All._isConsole then
    leftSlot.bg:addInputEvent("Mouse_On", "HandleEventMOn_CrewMain_All_SetConsoleEvent(" .. index .. ")")
    rightSlot.bg:addInputEvent("Mouse_On", "HandleEventMOn_CrewMain_All_SetConsoleEvent(" .. index + 1 .. ")")
  end
  leftSlot.class = UI.getChildControl(leftSlot.bg, "StaticText_Class")
  leftSlot.level = UI.getChildControl(leftSlot.bg, "StaticText_Lv")
  leftSlot.userName = UI.getChildControl(leftSlot.bg, "StaticText_Name")
  leftSlot.gameRecord = UI.getChildControl(leftSlot.bg, "StaticText_Log")
  leftSlot.onlineIcon = UI.getChildControl(leftSlot.bg, "StaticText_Online")
  leftSlot.offlineIcon = UI.getChildControl(leftSlot.bg, "StaticText_OffLine")
  rightSlot.class = UI.getChildControl(rightSlot.bg, "StaticText_Class")
  rightSlot.level = UI.getChildControl(rightSlot.bg, "StaticText_Lv")
  rightSlot.userName = UI.getChildControl(rightSlot.bg, "StaticText_Name")
  rightSlot.gameRecord = UI.getChildControl(rightSlot.bg, "StaticText_Log")
  rightSlot.onlineIcon = UI.getChildControl(rightSlot.bg, "StaticText_Online")
  rightSlot.offlineIcon = UI.getChildControl(rightSlot.bg, "StaticText_OffLine")
  local crewWrapper = ToClient_GetMyCrewInfoWrapper()
  if nil == crewWrapper then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfProxy = selfPlayer:get()
  if nil == selfProxy then
    return
  end
  local leftCrewMemberWrapper = crewWrapper:getMemberByIndex(index)
  if nil == leftCrewMemberWrapper then
    leftSlot.bg:SetShow(false)
  else
    if false == PaGlobal_CrewMain_All._isConsole and leftCrewMemberWrapper:getUserNo() == selfProxy:getUserNo() then
      leftSlot.bg:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewMain_All_EntryCrewMatch(true)")
    end
    local userName = leftCrewMemberWrapper:getName()
    leftSlot.userName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_MAIN_FAMILYNAME", "familyName", userName))
    local winCount = leftCrewMemberWrapper:getWinCount()
    local loseCount = leftCrewMemberWrapper:getWinCount()
    local record = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_CREW_MAIN_RECORD_VALUE", "win", tostring(winCount), "lose", tostring(loseCount))
    leftSlot.gameRecord:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_MAIN_RECORD", "record", record))
    if true == leftCrewMemberWrapper:isOnline() then
      leftSlot.onlineIcon:SetShow(true)
      leftSlot.offlineIcon:SetShow(false)
      leftSlot.class:SetShow(true)
      leftSlot.level:SetShow(true)
      local classType = leftCrewMemberWrapper:getClassType()
      if __eClassType_Count ~= classType then
        PaGlobalFunc_Util_ChangeTextureClass(leftSlot.class, classType)
      end
      local characterName = leftCrewMemberWrapper:getCharacterName()
      leftSlot.class:SetText(characterName)
      local level = leftCrewMemberWrapper:getLevel()
      leftSlot.level:SetText(level)
    else
      leftSlot.onlineIcon:SetShow(false)
      leftSlot.offlineIcon:SetShow(true)
      leftSlot.class:SetShow(false)
      leftSlot.level:SetShow(false)
    end
  end
  local rightCrewMemberWrapper = crewWrapper:getMemberByIndex(index + 1)
  if nil == rightCrewMemberWrapper then
    rightSlot.bg:SetShow(false)
  else
    if false == PaGlobal_CrewMain_All._isConsole and rightCrewMemberWrapper:getUserNo() == selfProxy:getUserNo() then
      rightSlot.bg:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewMain_All_EntryCrewMatch(true)")
    end
    local userName = rightCrewMemberWrapper:getName()
    rightSlot.userName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_MAIN_FAMILYNAME", "familyName", userName))
    local winCount = rightCrewMemberWrapper:getWinCount()
    local loseCount = rightCrewMemberWrapper:getWinCount()
    local record = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_CREW_MAIN_RECORD_VALUE", "win", tostring(winCount), "lose", tostring(loseCount))
    rightSlot.gameRecord:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_MAIN_RECORD", "record", record))
    if true == rightCrewMemberWrapper:isOnline() then
      rightSlot.onlineIcon:SetShow(true)
      rightSlot.offlineIcon:SetShow(false)
      rightSlot.class:SetShow(true)
      rightSlot.level:SetShow(true)
      local classType = rightCrewMemberWrapper:getClassType()
      if __eClassType_Count ~= classType then
        PaGlobalFunc_Util_ChangeTextureClass(rightSlot.class, classType)
      end
      local characterName = rightCrewMemberWrapper:getCharacterName()
      rightSlot.class:SetText(characterName)
      local level = rightCrewMemberWrapper:getLevel()
      rightSlot.level:SetText(level)
    else
      rightSlot.onlineIcon:SetShow(false)
      rightSlot.offlineIcon:SetShow(true)
      rightSlot.class:SetShow(false)
      rightSlot.level:SetShow(false)
    end
  end
end
function HandleEventMOn_CrewMain_All_SetConsoleEvent(index)
  if nil == index then
    return
  end
  local crewWrapper = ToClient_GetMyCrewInfoWrapper()
  if nil == crewWrapper then
    return
  end
  local crewMemberWrapper = crewWrapper:getMemberByIndex(index)
  if nil == crewMemberWrapper then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfProxy = selfPlayer:get()
  if nil == selfProxy then
    return
  end
  local userNo = selfProxy:getUserNo()
  if crewMemberWrapper:getUserNo() == userNo then
    PaGlobal_CrewMain_All._ui.stc_KeyGuideY:SetShow(true)
    if nil ~= crewWrapper:getEntryMember(userNo) then
      Panel_Window_CrewMain_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_CrewMain_All_EntryCrewMatch(false)")
    else
      Panel_Window_CrewMain_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_CrewMain_All_EntryCrewMatch(true)")
    end
  else
    PaGlobal_CrewMain_All._ui.stc_KeyGuideY:SetShow(false)
    Panel_Window_CrewMain_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  end
  PaGlobal_CrewMain_All._ui.stc_KeyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CREW_KEYGUIDE_MANAGE"))
  Panel_Window_CrewMain_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_CrewMain_All_SubMenuOpen(" .. index .. ")")
  PaGlobal_CrewMain_All:setAlignKeyGuide()
end
function HandleEventMOn_CrewMain_All_SetSubMenuEvent()
  PaGlobal_CrewMain_All._ui.stc_KeyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
  Panel_Window_CrewMain_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  PaGlobal_CrewMain_All:setAlignKeyGuide()
end
function HandleEventOnOut_CrewMain_All_ShowDestroyTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_CREW_MSG_EXPLOSIVE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CREW_MSG_EXPLOSIVE_DESC")
  local control = PaGlobal_CrewMain_All._ui.btn_destroyCrew
  if nil == control then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_CrewMain_All_SubMenu(menuIndex, index)
  if nil == Panel_Window_CrewMain_All then
    return
  end
  PaGlobal_CrewMain_All:subMenuClose()
  if nil == index then
    return
  end
  local crewWrapper = ToClient_GetMyCrewInfoWrapper()
  if nil == crewWrapper then
    return
  end
  local crewMemberWrapper = crewWrapper:getMemberByIndex(index)
  if nil == crewMemberWrapper then
    return
  end
  local messageTitle = ""
  local messageContent = ""
  local yesFunction
  local messageBoxType = 0
  local characterName = crewMemberWrapper:getCharacterName()
  local userNickName = crewMemberWrapper:getName()
  local isOnline = crewMemberWrapper:isOnline()
  local function partyInvite()
    RequestParty_inviteCharacter(characterName)
  end
  local function changeMaster()
    ToClient_RequestChangeCrewMaster(index)
  end
  local disjoinCrew = function()
    ToClient_RequestDisjoinCrew()
  end
  local function kickMember()
    local userNo = crewMemberWrapper:getUserNo()
    ToClient_RequestKickCrewMember(index, userNo)
  end
  if PaGlobal_CrewMain_All._subMenuIndex.WHISPER == menuIndex then
    if nil ~= FGlobal_ChattingInput_ShowWhisper then
      PaGlobal_ChattingInput_SendWhisper(characterName, userNickName)
      return
    end
  elseif PaGlobal_CrewMain_All._subMenuIndex.INVITEPARTY == menuIndex then
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
    if true == isOnline then
      messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_MAIN_MSG_INVITE", "name", characterName)
      yesFunction = partyInvite
    else
      messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_DETECTUSER_NOJOINUSER")
      yesFunction = MessageBox_Empty_function
      messageBoxType = 1
    end
  elseif PaGlobal_CrewMain_All._subMenuIndex.CHANGEMASTER == menuIndex then
    messageTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CREW_SUBMENU_CHANGELEADER")
    messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_MAIN_MSG_CHANGELEADER", "name", tostring(userNickName))
    yesFunction = changeMaster
  elseif PaGlobal_CrewMain_All._subMenuIndex.DISJOIN == menuIndex then
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_CREW_MAIN_SUBMENU_GETOUT")
    messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_CREW_MAIN_GETOUT")
    yesFunction = disjoinCrew
  elseif PaGlobal_CrewMain_All._subMenuIndex.KICKMEMBER == menuIndex then
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_CREW_MAIN_SUBMENU_EXILE")
    messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_MAIN_MSG_EXILE", "name", tostring(userNickName))
    yesFunction = kickMember
  end
  if 0 == messageBoxType then
    local messageboxData = {
      title = messageTitle,
      content = messageContent,
      functionYes = yesFunction,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    local messageboxData = {
      title = messageTitle,
      content = messageContent,
      functionApply = yesFunction,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function FromClient_CrewMain_All_Resize()
  if nil == Panel_Window_CrewMain_All then
    return
  end
  Panel_Window_CrewMain_All:ComputePos()
end
function FromClient_CrewMain_All_ResponseDestroyCrew()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CREW_SYSMSG_EXPLOSION"))
  PaGlobalFunc_CrewMain_All_Close(true)
end
function FromClient_CrewMain_All_ResonseDisjoinCrew(userName, isMe)
  local message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_SYSMSG_DISJOINCREW", "name", userName)
  Proc_ShowMessage_Ack(message)
  if true == isMe then
    PaGlobalFunc_CrewMain_All_Close(true)
  else
    PaGlobal_CrewMain_All:update()
  end
end
function FromClient_CrewMain_All_ResonseJoinCrew(userName)
  local message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_SYSMSG_JOINCREW", "name", userName)
  Proc_ShowMessage_Ack(message)
  PaGlobal_CrewMain_All:update()
end
function FromClient_CrewMain_All_ResonseChangeCrewMaster(userName)
  local message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_SYSMSG_CHANGEMASTER", "name", userName)
  Proc_ShowMessage_Ack(message)
  PaGlobal_CrewMain_All:updateCrewInfo()
  PaGlobal_CrewMain_All:updateButton()
end
function FromClient_CrewMain_All_ResponseSetCrewNotice()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CREW_SYSMSG_SETINFO"))
  PaGlobal_CrewMain_All:updateCrewInfo()
end
function FromClient_CrewMain_All_ResponseKickCrewMember(userName, isMe)
  local message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_SYSMSG_KICKCREW", "name", userName)
  Proc_ShowMessage_Ack(message)
  if true == isMe then
    PaGlobalFunc_CrewMain_All_Close(true)
  else
    PaGlobal_CrewMain_All:update()
  end
end
function FromClient_CrewMain_All_ResonseCrewInvite(s64_crewNo, crewName, hostUsername, hostName)
  local crewInviteMsg = PAGetString(Defines.StringSheet_GAME, "LUA_CREW_SYSMSG_INVITE")
  local contentString = hostUsername .. "(" .. hostName .. ")" .. crewInviteMsg
  local crewInvite_accept = function()
    ToClient_RequestAcceptCrewInvite()
  end
  local crewInvite_refuse = function()
    ToClient_RequestRefuseCrewInvite()
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CREW_INVITE_TITLE"),
    content = contentString,
    functionYes = crewInvite_accept,
    functionNo = crewInvite_refuse,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_CrewMain_All_ResonseRefuseCrewJoin(guestCharacterName)
  local crewString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CREW_TITLE")
  local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_REFUSE_GUILDINVITE", "name", guestCharacterName, "guild", crewString)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CREW_INVITE_TITLE"),
    content = contentString,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_CrewMain_All_UpdateCrewInformation()
  if nil == Panel_Window_CrewMain_All then
    return
  end
  if false == Panel_Window_CrewMain_All:GetShow() then
    return
  end
  PaGlobal_CrewMain_All:update()
end
