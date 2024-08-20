function PaGlobalFunc_PartyList_All_Open()
  PaGlobal_PartyList_All:prepareOpen()
end
function PaGlobalFunc_PartyList_All_Close()
  PaGlobal_PartyList_All:prepareClose()
end
function PaGlobalFunc_PartyList_All_Update()
  if nil == Panel_PartyList_All then
    return
  end
  if false == Panel_PartyList_All:GetShow() then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    _AudioPostEvent_SystemUiForXBOX(50, 0)
  end
  ToClient_RequestListPartyRecruitment()
end
function HandleEventLUp_PartyList_All_SearchEdit()
  if nil == Panel_PartyList_All then
    return
  end
  if false == Panel_PartyList_All:GetShow() then
    return
  end
  SetFocusEdit(PaGlobal_PartyList_All._ui.edit_search)
  PaGlobal_PartyList_All._ui.edit_search:SetEditText(PaGlobal_PartyList_All._ui.edit_search:GetEditText(), true)
end
function HandleEventLUp_PartyList_All_DoSearch(str)
  if nil == Panel_PartyList_All then
    return
  end
  if false == Panel_PartyList_All:GetShow() then
    return
  end
  local msg = ""
  if PaGlobal_PartyList_All._isPadSnap then
    if nil == str then
      msg = PaGlobal_PartyList_All._ui.edit_search:GetEditText()
    else
      msg = str
      PaGlobal_PartyList_All._ui.edit_search:SetEditText(str)
    end
    ClearFocusEdit()
  else
    msg = PaGlobal_PartyList_All._ui.edit_search:GetEditText()
  end
  if "" == msg then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLIST_SEARCHALERT"))
    return
  end
  local serverNo = 0
  ToClient_FilteredPartyRecruitmentList(serverNo, msg)
  ClearFocusEdit()
end
function HandleEventLUp_PartyList_All_Reset()
  if nil == Panel_PartyList_All then
    return
  end
  local serverNo = 0
  local msg = ""
  PaGlobal_PartyList_All._ui.edit_search:SetEditText(msg)
  ToClient_FilteredPartyRecruitmentList(serverNo, msg)
end
function PadEventXUp_PatyList_All_RecruiteShow()
  if false == ToClient_isCommunicationAllowed() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    ToClient_showPrivilegeError()
    return
  end
  if false == PaGlobal_PartyList_All._canInvite then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_FAVORITE_ALREADYREGIST"))
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobalFunc_FindPartyRecruite_Show()
end
function HandleEventOn_PartyList_All_OnSelectButton(id, eType)
  if nil == Panel_PartyList_All then
    return
  end
  local partyWrapper = PaGlobal_PartyList_All._partySortTable[id]
  if nil == partyWrapper then
    return
  end
  PaGlobal_PartyList_All:setButtonText(eType)
end
function HandleEventLUp_PartyList_All_ClickSelectButton(index, eType, param1, param2)
  if nil == Panel_PartyList_All then
    return
  end
  local partyWrapper = PaGlobal_PartyList_All._partySortTable[index]
  if nil == partyWrapper then
    return
  end
  PaGlobal_PartyList_All:doAction(index, eType, param1, param2)
end
function HandleEventLUp_PartyList_All_Advertising(index)
  if nil == Panel_PartyList_All then
    return
  end
  if nil == index then
    return
  end
  if true == PaGlobal_PartyList_All._isDisable then
    return
  end
  PaGlobal_PartyList_All._isDisable = true
  if true == PaGlobal_PartyList_All._isConsole then
    PaGlobal_PartyList_All._ui_console.list2_party:requestUpdateVisible()
  else
    PaGlobal_PartyList_All._ui_pc.list2_party:requestUpdateVisible()
  end
  local partyWrapper = ToClient_GetRecruitmentPartyListAt(index)
  if nil ~= partyWrapper then
    ToClient_SetLinkedPartyRecruitInfo(index)
    chatting_sendMessageNoMatterEmpty("", partyWrapper:getTitle(), CppEnums.ChatType.World)
  end
end
function HandleEventLUp_PartyList_All_Cancle()
  if nil == Panel_PartyList_All then
    return
  end
  local party_Cancel = function()
    ToClient_RequestCancelRecruitPartyMember()
  end
  local memoTitle = PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLIST_MSGCANCELTITLE")
  local memoContent = PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLIST_MSGCANCELCONTENT")
  local messageBoxData = {
    title = memoTitle,
    content = memoContent,
    functionYes = party_Cancel,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_PartyList_All_Support(index)
  if nil == Panel_PartyList_All then
    return
  end
  if nil == index then
    return
  end
  local partyWrapper = ToClient_GetRecruitmentPartyListAt(index)
  if nil == partyWrapper then
    return
  end
  local partyNo = partyWrapper:getPartyNo()
  local serverNo = partyWrapper:getServerNo()
  local function requestJoinPartyRecruitment()
    if PaGlobalFunc_PartList_All_IsBlockedLeader(partyWrapper:getXuid()) then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
        content = messageBoxMemo,
        functionYes = MessageBox_Empty_function,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      ToClient_RequestJoinPartyRecruitment(partyNo, serverNo)
    end
  end
  local function requestBreakPartyRecruitment()
    ToClient_RequestBreakPartyRecruitment(partyNo, serverNo)
  end
  if ToClient_SelfPlayerIsGM() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_BREAK_PARTYRECRUITMENT_BY_MASTER")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = requestBreakPartyRecruitment,
      functionNo = requestJoinPartyRecruitment,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if PaGlobalFunc_PartList_All_IsBlockedLeader(partyWrapper:getXuid()) then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    ToClient_RequestJoinPartyRecruitment(partyNo, serverNo)
  end
end
function PaGlobalFunc_PartList_All_IsBlockedLeader(xuid)
  return ToClient_IsBlockedLeaderFromMe(xuid)
end
function HandleEventLUp_PartyList_All_WhisperToLeader(index)
  if nil == Panel_PartyList_All then
    return
  end
  if nil == index then
    return
  end
  local partyWrapper = ToClient_GetRecruitmentPartyListAt(index)
  if nil == partyWrapper then
    return
  end
  local leaderName = partyWrapper:getLeaderCharacterName()
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLIST_MSGWHISPERTITLE")
  local content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PARTYLIST_MSGWHISPERDESC", "name", leaderName)
  local function party_Whisper()
    FGlobal_ChattingInput_ShowWhisper(leaderName)
  end
  local messageBoxData = {
    title = title,
    content = content,
    functionYes = party_Whisper,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_PartyList_All_MoveServer(serverNo, partyNo)
  if nil == Panel_PartyList_All then
    return
  end
  if nil == serverNo or nil == partyNo then
    return
  end
  local serverCount = getGameWorldServerDataCount()
  local curChannelData = getCurrentChannelServerData()
  local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
  local channelCount = getGameChannelServerDataCount(curWorldData._worldNo)
  local channelName = getChannelName(curChannelData._worldNo, serverNo)
  local serverIndex
  for sIndex = 0, serverCount - 1 do
    for index = 0, channelCount - 1 do
      local serverData = getGameChannelServerDataByIndex(sIndex, index)
      if nil ~= serverData then
        local _serverNo = serverData._serverNo
        if serverNo == _serverNo then
          serverIndex = index
          break
        end
      end
    end
  end
  local function moveServer()
    if nil ~= serverIndex then
      gameExit_MoveChannel(serverIndex)
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELWAIT_MSG")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"),
        content = messageBoxMemo,
        functionYes = nil,
        functionClose = nil,
        exitButton = true,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  end
  local function requestBreakPartyRecruitment()
    ToClient_RequestBreakPartyRecruitment(partyNo, serverNo)
  end
  if ToClient_SelfPlayerIsGM() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_BREAK_PARTYRECRUITMENT_BY_MASTER")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = requestBreakPartyRecruitment,
      functionNo = moveServer,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local isMoveAbleServer = PaGlobalFunc_PartyList_All_IsMoveAbleServer(serverIndex)
  if false == isMoveAbleServer then
    return
  end
  local memoTitle = PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLIST_MOVESERVER")
  local memoContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PARTYLIST_MSGMOVESERVERCONTENT", "serverName", channelName)
  local messageBoxData = {
    title = memoTitle,
    content = memoContent,
    functionYes = moveServer,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_PartyList_All_IsMoveAbleServer(serverIndex)
  if nil == serverIndex then
    return false
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  if nil ~= PaGlobal_TutorialManager and true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoPlayerIsDoingTutorial"))
    return false
  end
  if true == ToClient_SelfPlayerCheckAction("READ_BOOK") then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXITSERVERSELECT_READBOOK_WARNNING"))
    return false
  end
  local curChannelData = getCurrentChannelServerData()
  local selectedChannel = getGameChannelServerDataByWorldNo(curChannelData._worldNo, serverIndex)
  if nil == selectedChannel then
    return false
  end
  local busyState = selectedChannel._busyState
  local isSpecialCharacter = getTemporaryInformationWrapper():isSpecialCharacter()
  if 0 == busyState then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_DONTJOIN"))
    return false
  elseif true == selfPlayer:get():isBattleGroundDefine() and true == selectedChannel._isSiegeChannel or true == selectedChannel._isSiegeChannel and true == isSpecialCharacter then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_BATTLEGROURND"))
    return false
  end
  if true == ToClient_isTotalGameClient() then
    local gamePlatformType = ToClient_getGamePlatformType()
    local servicePlatformType = selectedChannel._servicePlatformType
    if gamePlatformType ~= servicePlatformType then
      local canCrossPlay = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
      if __ePlatformType_COUNT == servicePlatformType and false == canCrossPlay then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CROSSPLAY_CANT_SELECTSERVER"))
        return false
      elseif __ePlatformType_COUNT ~= servicePlatformType then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_CANT_CONNECTABLE_PLATFORM"))
        return false
      end
    end
  end
  if true == _ContentsGroup_SeasonContents and true == selectedChannel._isSeasonChannel then
    if false == selfPlayer:get():isSeasonCharacter() and false == ToClient_SelfPlayerIsGM() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_CANNOT_ACCESS"))
      return false
    end
    if true == selectedChannel._isSeasonNewbieChannel then
      local isAccessible = ToClient_CheckToAccessSeasonNewbieChannel()
      if false == isAccessible then
        local myTotalLevel = ToClient_GetAllCharacterTotalLevel()
        Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SEASON_LOWLEVEL_DESC", "level", myTotalLevel))
        return false
      end
    end
  end
  if true == selectedChannel._isSpeedChannel then
    local tempWrapper = getTemporaryInformationWrapper()
    if nil ~= tempWrapper and 0 == tempWrapper:getMyAdmissionToSpeedServer() and false == ToClient_SelfPlayerIsGM() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_NEWOLVIA_ALERT"))
      return false
    end
    if true == selectedChannel._isSeasonNewbieChannel then
      local isAccessible = ToClient_CheckToAccessSeasonNewbieChannel()
      if false == isAccessible then
        local myTotalLevel = ToClient_GetAllCharacterTotalLevel()
        Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEWOLVIA_LOWLEVEL_DESC", "level", myTotalLevel))
        return false
      end
    end
  end
  if true == selectedChannel._isEventChannel and false == selfPlayer:get():isEventCharacter() and false == ToClient_SelfPlayerIsGM() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EVENTCONTENT_CANNOT_ACCESS"))
    return false
  end
  local channelName = getChannelName(selectedChannel._worldNo, selectedChannel._serverNo)
  local changeChannelTime = getChannelMoveableRemainTime(curChannelData._worldNo)
  local changeRealChannelTime = convertStringFromDatetime(changeChannelTime)
  local changeSpecialChannelTime = getSpecialChannelMoveableRemainTime(curChannelData._worldNo)
  local changeRealSpecialChannelTime = convertStringFromDatetime(changeSpecialChannelTime)
  local isSeigeBeing = deadMessage_isSiegeBeingMyChannel()
  local isInSiegeBattle = deadMessage_isInSiegeBattle()
  if true == isSeigeBeing and false == isInSiegeBattle then
    return true
  else
    if true == selectedChannel._isEventChannel then
      changeChannelTime = toInt64(0, 0)
    end
    local selfPlayer = getSelfPlayer()
    local isVolunteer = false
    if nil ~= selfPlayer and __eGuildMemberGradeVolunteer == selfPlayer:getGuildMemberGrade() then
      isVolunteer = true
    end
    local guildWrapper = ToClient_GetMyGuildInfoWrapper()
    if nil ~= guildWrapper then
      local guildMainServerGroupNo = guildWrapper:getGuildMainServerGroupNo()
      if curChannelData._serverGroupNo == guildMainServerGroupNo and selectedChannel._serverGroupNo == guildMainServerGroupNo and false == isVolunteer then
        changeChannelTime = toInt64(0, 0)
      end
    end
    if changeChannelTime > toInt64(0, 0) and false == selectedChannel._isSeasonChannel then
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANGECHANNEL_PENALTY", "changeRealChannelTime", changeRealChannelTime))
      return false
    elseif changeSpecialChannelTime > toInt64(0, 0) and true == selectedChannel._isSeasonChannel then
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANGECHANNEL_PENALTY", "changeRealChannelTime", changeRealSpecialChannelTime))
      return false
    end
  end
  return true
end
function FromClient_PartyList_All_ResponsePartyRecruitmentInfo(param1)
  if nil == Panel_PartyList_All then
    return
  end
  if 0 == param1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLIST_REGISTALERT"))
  elseif 1 == param1 then
  elseif 2 == param1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLIST_CANCELALERT"))
  end
  PaGlobal_PartyList_All:update()
end
function FromClient_PartyList_All_RequestPartyJoin(guestActorKey, characterName, level, classType, partyType)
  if nil == Panel_PartyList_All then
    return
  end
  if nil == characterName or nil == classType then
    return
  end
  local function partyJoin()
    if true == _ContentsGroup_UsePadSnapping then
      _AudioPostEvent_SystemUiForXBOX(50, 1)
    end
    if CppEnums.PartyType.ePartyType_Normal == partyType then
      RequestParty_inviteCharacter(characterName)
    elseif CppEnums.PartyType.ePartyType_Large == partyType then
      ToClient_InviteLargePartyByCharacterName(characterName)
    end
  end
  local function partyReject()
    ToClient_requestSystemMessageToTarget(guestActorKey, "eErrNoSystemMessageRejectParty")
  end
  local className = getClassName(classType)
  local memoTitle = PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLISTRECRUITE_ALERTTITLE")
  local memoContent = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_PARTYLISTRECRUITE_ALERTCONTENT", "name", characterName, "class", className, "level", level)
  local messageBoxData = {
    title = memoTitle,
    content = memoContent,
    functionYes = partyJoin,
    functionNo = partyReject,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_PartyList_All_Resize()
  if nil == Panel_PartyList_All then
    return
  end
  PaGlobal_PartyList_All:resize()
end
function PaGlobalFunc_PartyList_All_CheckUiEdit(targetUI)
  if nil == Panel_PartyList_All then
    return false
  end
  if nil == targetUI then
    return false
  end
  if false == Panel_PartyList_All:GetShow() then
    return
  end
  return targetUI:GetKey() == PaGlobal_PartyList_All._ui.edit_search:GetKey()
end
function PaGlobalFunc_PartyList_All_ClearFocusEdit()
  ClearFocusEdit()
  CheckChattingInput()
end
function PaGlobalFunc_PartyList_All_SetLinkedParty(recruitKey64)
  if nil == Panel_PartyList_All then
    return
  end
  if nil == recruitKey64 then
    return
  end
  PaGlobal_PartyList_All._clickedPartyRecruitKey = recruitKey64
end
function PaGlobalFunc_PartyList_All_IsBtnDisableSet()
  if nil == Panel_PartyList_All then
    return false
  end
  return PaGlobal_PartyList_All._isDisable
end
function PaGlobal_PartyList_All_UpdateFunc(deltaTime)
  if nil == Panel_PartyList_All then
    return
  end
  PaGlobal_PartyList_All._currentTime = PaGlobal_PartyList_All._currentTime + deltaTime
  if PaGlobal_PartyList_All._adBtnDisableTime <= PaGlobal_PartyList_All._currentTime then
    PaGlobal_PartyList_All._isDisable = false
    PaGlobal_PartyList_All._currentTime = 0
    PaGlobal_PartyList_All:update()
  end
end
function FromClient_responseSystemMessageFromTarget(rv)
  local messageData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_TEXT_TITLE"),
    content = PAGetStringSymNo(rv),
    functionYes = nil,
    functionNo = nil,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
