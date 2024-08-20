function PaGlobal_FriendInfoList_All:prepareOpen()
  if nil == Panel_FriendInfoList_All then
    return
  end
  ToClient_updateAddFriendAllowed()
  RequestFriendList_getFriendList()
  RequestFriendList_getAddFriendList()
  if false == _ContentsGroup_RenewUI then
    PaGlobal_FriendInfoList_All:loadOption()
  end
  PaGlobal_FriendInfoList_All_SetRequestNew()
  PaGlobal_FriendInfoList_All:updateTab()
  PaGlobal_FriendInfoList_All:open()
end
function PaGlobal_FriendInfoList_All:open()
  if nil == Panel_FriendInfoList_All then
    return
  end
  Panel_FriendInfoList_All:SetShow(true, true)
end
function PaGlobal_FriendInfoList_All:prepareClose()
  if nil == Panel_FriendInfoList_All then
    return
  end
  if true == PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionBG:GetShow() then
    PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionBG:SetShow(false)
    ToClient_padSnapSetTargetGroup(PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionBG)
    return
  elseif true == PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionBG:GetShow() then
    PaGlobal_FriendInfoList_All:hidePopupMenu()
    return
  elseif true == PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionBG:GetShow() then
    PaGlobal_FriendInfoList_All:hidePopupMenu()
    return
  elseif true == PaGlobal_FriendInfoList_All._ui.stc_XBFunctionBG:GetShow() then
    PaGlobal_FriendInfoList_All:hidePopupMenu()
    return
  elseif true == _ContentsGroup_UsePadSnapping and nil ~= PaGlobal_FriendInfoList_All._currentOpenMessangerId then
    PaGlobalFunc_FriendInfoList_All_MessangerCloseInFriendList()
    return
  end
  if true == Panel_Friend_RequestList_All:GetShow() then
    PaGlobal_FriendRequest_All_Close()
  end
  PaGlobalFunc_FriendInfoList_All_MessangerCloseInFriendList()
  PaGlobal_FriendInfoList_All:clearGroupListData()
  PaGlobal_FriendInfoList_All:clearFriendListData()
  PaGlobal_FriendInfoList_All._groupListData._selectedGroupIndex = -1
  PaGlobal_FriendInfoList_All._friendListData._selectedFriendIndex = -1
  PaGlobal_FriendInfoList_All._friendListData._selectedFriendUserNo = nil
  PaGlobal_FriendInfoList_All._listMoveIndex = nil
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  TooltipSimple_Hide()
  PaGlobal_FriendInfoList_All:close()
end
function PaGlobal_FriendInfoList_All:close()
  if nil == Panel_FriendInfoList_All then
    return
  end
  Panel_FriendInfoList_All:SetShow(false, false)
  Panel_FriendList_Add_All:SetShow(false)
  Panel_Friend_RequestList_All:SetShow(false)
  Panel_Friend_GroupRename_All:SetShow(false)
end
function PaGlobal_FriendInfoList_All:clearGroupListData()
  _defaultGroupIndex = -1
  _partyplayGroupIndex = -1
  PaGlobal_FriendInfoList_All._groupListData._uiGroups = {}
  PaGlobal_FriendInfoList_All._groupListData._groupInfo = {}
  PaGlobal_FriendInfoList_All._groupListData._groupCount = 0
end
function PaGlobal_FriendInfoList_All:clearFriendListData()
  PaGlobal_FriendInfoList_All._friendListData._uiFriends = {}
  PaGlobal_FriendInfoList_All._friendListData._friendInfo = {}
end
function PaGlobal_FriendInfoList_All:updateTab()
  if PaGlobal_FriendInfoList_All._tab._consoleFriendTab == PaGlobal_FriendInfoList_All._currentTab then
    PaGlobal_FriendInfoList_All:updateFriendListForConsole()
    if true == _ContentsGroup_RenewUI then
      PaGlobal_FriendInfoList_All._ui.btn_PCFriend:SetFontColor(Defines.Color.C_FF585453)
      PaGlobal_FriendInfoList_All._ui.btn_ConsoleFriend:SetFontColor(Defines.Color.C_FFFFEDD4)
    end
  else
    PaGlobal_FriendInfoList_All:updateFriendList()
    if true == _ContentsGroup_RenewUI then
      PaGlobal_FriendInfoList_All._ui.btn_PCFriend:SetFontColor(Defines.Color.C_FFFFEDD4)
      PaGlobal_FriendInfoList_All._ui.btn_ConsoleFriend:SetFontColor(Defines.Color.C_FF585453)
    end
  end
  if true == _ContentsGroup_UsePadSnapping then
    local firstFriend = PaGlobal_FriendInfoList_All._ui.list2_Friend:GetContentByKey(0)
    if nil == firstFriend then
      PaGlobal_FriendInfoList_All._currentKeyGuideType = PaGlobal_FriendInfoList_All._keyGuideType._None
      PaGlobal_FriendInfoList_All:updateKeyGuides()
    end
  end
end
function PaGlobal_FriendInfoList_All:loadOption()
  local noticeSound = ToClient_RoadToggleSoundNotice()
  local noticeEffect = ToClient_RoadToggleEffectNotice()
  PaGlobal_FriendInfoList_All._ui.btn_Sound:SetCheck(noticeSound)
  PaGlobal_FriendInfoList_All._ui.btn_Effect:SetCheck(noticeEffect)
end
function PaGlobal_FriendInfoList_All:updateKeyGuides()
  local Type = PaGlobal_FriendInfoList_All._keyGuideType
  if Type._DefaultGroup == PaGlobal_FriendInfoList_All._currentKeyGuideType then
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_X:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_A:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_B:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_RS:SetShow(false)
  elseif Type._Group == PaGlobal_FriendInfoList_All._currentKeyGuideType then
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_X:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_A:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_B:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_RS:SetShow(false)
  elseif Type._Friend == PaGlobal_FriendInfoList_All._currentKeyGuideType then
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_X:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_B:SetShow(true)
    if nil == PaGlobal_FriendInfoList_All._currentOpenMessangerId then
      PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_RS:SetShow(false)
      PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_A:SetShow(true)
    else
      PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_RS:SetShow(true)
      PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_A:SetShow(false)
    end
  elseif Type._XBFriend == PaGlobal_FriendInfoList_All._currentKeyGuideType then
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_X:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_A:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_B:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_RS:SetShow(false)
  elseif Type._Popup == PaGlobal_FriendInfoList_All._currentKeyGuideType then
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_X:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_A:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_B:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_RS:SetShow(false)
  elseif Type._AddGroup == PaGlobal_FriendInfoList_All._currentKeyGuideType then
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_X:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_A:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_B:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_RS:SetShow(false)
  elseif Type._None == PaGlobal_FriendInfoList_All._currentKeyGuideType then
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_X:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_A:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_B:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_RS:SetShow(false)
  end
  local isLBShow = true == PaGlobal_FriendInfoList_All._isPS4
  PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_LB:SetShow(isLBShow)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_FriendInfoList_All._keyGuides, PaGlobal_FriendInfoList_All._ui.stc_BottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_FriendInfoList_All:updateFriendList()
  if nil == Panel_FriendInfoList_All then
    return
  end
  ToClient_sortFriendList()
  local friendList = PaGlobal_FriendInfoList_All._ui.list2_Friend
  local _groupListData = PaGlobal_FriendInfoList_All._groupListData
  local _friendListData = PaGlobal_FriendInfoList_All._friendListData
  PaGlobal_FriendInfoList_All:clearGroupListData()
  PaGlobal_FriendInfoList_All:clearFriendListData()
  friendList:getElementManager():clearKey()
  local mainElement = friendList:getElementManager():getMainElement()
  if true == _ContentsGroup_RenewUI then
    local pcFriendGroup = RequestFriends_getFriendGroupAt(0)
    local friendCount = pcFriendGroup:getFriendCount()
    for index = 0, friendCount - 1 do
      local treeElement = mainElement:createChild(toInt64(0, index))
      local friendInfo = pcFriendGroup:getFriendAt(index)
      _friendListData._friendInfo[index] = friendInfo
    end
  else
    local friendGroupCount = RequestFriends_getFriendGroupCount()
    local indexCnt = 0
    local groupIndexCnt = 0
    for groupIndex = 0, friendGroupCount - 1 do
      local friendGroup = RequestFriends_getFriendGroupAt(groupIndex)
      local treeElement = mainElement:createChild(toInt64(0, indexCnt))
      _groupListData._groupInfo[indexCnt] = friendGroup
      _groupListData._groupInfoByGroupIndex[groupIndex] = friendGroup
      _groupListData._groupCount = friendGroupCount
      indexCnt = indexCnt + 1
      groupIndexCnt = indexCnt
      if false == friendGroup:isHide() then
        local friendCount = friendGroup:getFriendCount()
        for friendIndex = 0, friendCount - 1 do
          local friendInfo = friendGroup:getFriendAt(friendIndex)
          local subTreeElement = treeElement:createChild(toInt64(0, indexCnt))
          _friendListData._friendInfo[indexCnt] = friendInfo
          indexCnt = indexCnt + 1
        end
      end
    end
  end
  friendList:getElementManager():refillKeyList()
  if nil ~= PaGlobal_FriendInfoList_All._listMoveIndex then
    friendList:moveIndex(PaGlobal_FriendInfoList_All._listMoveIndex)
  else
    friendList:moveIndex(0)
  end
end
function PaGlobal_FriendInfoList_All:updateFriendListForConsole()
  if nil == Panel_FriendInfoList_All then
    return
  end
  local friendList = PaGlobal_FriendInfoList_All._ui.list2_Friend
  local _friendListData = PaGlobal_FriendInfoList_All._friendListData
  PaGlobal_FriendInfoList_All:clearGroupListData()
  PaGlobal_FriendInfoList_All:clearFriendListData()
  friendList:getElementManager():clearKey()
  local mainElement = friendList:getElementManager():getMainElement()
  local friendCount = ToClient_InitializeXboxFriendForLua()
  for index = 0, friendCount - 1 do
    local treeElement = mainElement:createChild(toInt64(0, index))
    local friendInfo = ToClient_getXboxFriendInfoByIndex(index)
    _friendListData._friendInfo[index] = friendInfo
  end
  friendList:getElementManager():refillKeyList()
  if nil ~= PaGlobal_FriendInfoList_All._listMoveIndex then
    friendList:moveIndex(PaGlobal_FriendInfoList_All._listMoveIndex)
  else
    friendList:moveIndex(0)
  end
end
function PaGlobal_FriendInfoList_All:groupMoveList()
  if nil == Panel_FriendInfoList_All then
    return
  end
  local _friendListData = PaGlobal_FriendInfoList_All._friendListData
  if nil == _friendListData._selectedFriendUserNo then
    PaGlobal_FriendInfoList_All:hidePopupMenu()
    return
  end
  local moveGroupBG = PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionBG
  local moveGroup = PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[PaGlobal_FriendInfoList_All._friendFunction.GROUP_MOVE]
  PaGlobal_FriendInfoList_All:groupMoveSetShow(true)
  moveGroupBG:SetPosX(PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionBG:GetPosX() - moveGroupBG:GetSizeX() - 10)
  moveGroupBG:SetPosY(PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionBG:GetPosY() + moveGroup:GetPosY())
end
function PaGlobal_FriendInfoList_All:whisperWithFriend()
  if nil == Panel_FriendInfoList_All then
    return
  end
  local _friendListData = PaGlobal_FriendInfoList_All._friendListData
  if nil == _friendListData._selectedFriendUserNo then
    PaGlobal_FriendInfoList_All:hidePopupMenu()
    return
  end
  local friendInfo = ToClient_getFreindInfoByUserNo(_friendListData._selectedFriendUserNo)
  if nil == friendInfo then
    return
  end
  local isOnline = friendInfo:isOnline()
  if true == isOnline then
    local userName = friendInfo:getName()
    local characterName = friendInfo:getCharacterName()
    PaGlobal_ChattingInput_SendWhisper(characterName, userName)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DETECTUSER_NOJOINUSER"))
  end
end
function PaGlobal_FriendInfoList_All:showXBMenu(index)
end
function PaGlobal_FriendInfoList_All:ShowXBoxProfile()
end
function PaGlobal_FriendInfoList_All:SendXboxInvite()
end
function PaGlobal_FriendInfoList_All:isSelectFriendBlocked()
  if nil == Panel_FriendInfoList_All then
    return
  end
  local _friendListData = PaGlobal_FriendInfoList_All._friendListData
  if nil == _friendListData._selectedFriendUserNo then
    return
  end
  local friendInfo = ToClient_getFreindInfoByUserNo(_friendListData._selectedFriendUserNo)
  if nil == friendInfo then
    return
  end
  local userNo = friendInfo:getUserNo()
  local groupNo = friendInfo:getGroupNo()
  return RequestFriends_isBlockedFriend(userNo, groupNo)
end
function PaGlobal_FriendInfoList_All:renameFriendGroup()
  if nil == Panel_FriendInfoList_All then
    return
  end
  PaGlobal_Friend_GroupRename_All_Open(false)
  PaGlobal_FriendInfoList_All._ui.stc_XBFunctionBG:SetShow(false)
end
function PaGlobal_FriendInfoList_All:partyInvite()
  if nil == Panel_FriendInfoList_All then
    return
  end
  local _friendListData = PaGlobal_FriendInfoList_All._friendListData
  if nil == _friendListData._selectedFriendUserNo then
    PaGlobal_FriendInfoList_All:hidePopupMenu()
    return
  end
  local friendInfo = ToClient_getFreindInfoByUserNo(_friendListData._selectedFriendUserNo)
  if nil == friendInfo then
    return
  end
  local userCharacterName = friendInfo:getCharacterName()
  local isOnline = friendInfo:isOnline()
  local isSelfPlayerPlayingPvPMatch = getSelfPlayer():isDefinedPvPMatch()
  if PaGlobal_FriendInfoList_All:isSelectFriendBlocked() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if nil ~= userCharacterName and "" ~= userCharacterName and false == isSelfPlayerPlayingPvPMatch then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_INVITE", "targetName", userCharacterName))
  end
  RequestParty_inviteCharacter(userCharacterName)
  PaGlobal_FriendInfoList_All:hidePopupMenu()
end
function PaGlobal_FriendInfoList_All:guildInvite()
  local _friendListData = PaGlobal_FriendInfoList_All._friendListData
  if nil == _friendListData._selectedFriendUserNo then
    PaGlobal_FriendInfoList_All:hidePopupMenu()
    return
  end
  local friendInfo = ToClient_getFreindInfoByUserNo(_friendListData._selectedFriendUserNo)
  if nil == friendInfo then
    return
  end
  local userCharacterName = friendInfo:getCharacterName()
  local isOnline = friendInfo:isOnline()
  local isRightInviteGuild = PaGlobalFunc_FriendInfoList_All_RightCheck(__eGuildRightType_Join)
  if false == isRightInviteGuild then
    return
  end
  if false == isOnline then
    local messageBoxMemo = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoGuildTeamBattleAttendCantAttach")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_TEXT_TITLE"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local guildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil ~= guildInfo then
    if guildInfo:getJoinableMemberCount() <= guildInfo:getMemberCount() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_GUILDINVITE_CANNOTJOINNOMORE"))
      return
    end
    if nil ~= guildInfo:getMemberByUserNo() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_ALREADY_JOIN_CLAN_OR_GUILD"))
      return
    end
  end
  if true == _ContentsGroup_NewUI_Guild_All then
    FromClient_GuildInfo_All_GuildInviteForGuildGrade(0, userCharacterName, 0)
  else
    FromClient_GuildMain_ResponseGuildInviteForGuild(0, userCharacterName, 0)
  end
end
function PaGlobal_FriendInfoList_All:deleteFriend()
  if nil == Panel_FriendInfoList_All then
    return
  end
  local _friendListData = PaGlobal_FriendInfoList_All._friendListData
  if nil ~= _friendListData._selectedFriendUserNo then
    local friendInfo = ToClient_getFreindInfoByUserNo(_friendListData._selectedFriendUserNo)
    if nil ~= friendInfo then
      requestFriendList_deleteFriend(friendInfo:getUserNo())
    end
  end
  PaGlobal_FriendInfoList_All._listMoveIndex = PaGlobal_FriendInfoList_All._friendListData._selectedFriendIndex - 1
  PaGlobal_FriendInfoList_All:hidePopupMenu()
end
function PaGlobal_FriendInfoList_All:deleteFriendGroup()
  if nil == Panel_FriendInfoList_All then
    return
  end
  local _groupListData = PaGlobal_FriendInfoList_All._groupListData
  if 0 <= _groupListData._selectedGroupIndex then
    local friendGroup = _groupListData._groupInfo[_groupListData._selectedGroupIndex]
    if 0 > friendGroup:getGroupNo() then
      return
    end
    Toclient_deleteFriendGroup(friendGroup:getGroupNo())
  end
  PaGlobal_FriendInfoList_All:hidePopupMenu()
end
function PaGlobal_FriendInfoList_All:showFriendPopupMenu(isShow)
  if nil == Panel_FriendInfoList_All then
    return
  end
  local friendListData = PaGlobal_FriendInfoList_All._friendListData
  local groupListData = PaGlobal_FriendInfoList_All._groupListData
  local popupBG = PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionBG
  popupBG:SetShow(isShow)
  if true == isShow then
    if nil == friendListData._selectedFriendUserNo then
      return
    end
    local friendInfo = ToClient_getFreindInfoByUserNo(friendListData._selectedFriendUserNo)
    if nil == friendInfo then
      return
    end
    local isOnline = friendInfo:isOnline()
    local isMessangerShow = true
    local isWhisperShow = isOnline
    if true == _ContentsGroup_RenewUI then
      isMessangerShow = false
    end
    if true == _ContentsGroup_RenewUI then
      PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[PaGlobal_FriendInfoList_All._friendFunction.PARTY_INVITE]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INVITE"))
      local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
      if nil ~= myGuildInfo then
        local guildGrade = myGuildInfo:getGuildGrade()
        if 0 == guildGrade then
          PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[PaGlobal_FriendInfoList_All._friendFunction.PARTY_INVITE]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLAN_INVITE"))
        end
      end
    end
    local isGroupMove = 2 <= groupListData._groupCount
    local control
    local index = friendListData._selectedFriendIndex
    if -1 ~= index then
      control = PaGlobal_FriendInfoList_All._ui.list2_Friend:GetContentByKey(toInt64(0, index))
    end
    if nil ~= control then
      local posY = PaGlobal_FriendInfoList_All._ui.list2_Friend:GetPosY() + control:GetPosY()
      popupBG:SetPosY(posY)
      local posX = -popupBG:GetSizeX() - 10
      popupBG:SetPosX(posX)
    end
    ToClient_padSnapSetTargetGroup(popupBG)
    ToClient_padSnapIgnoreGroupMove()
    PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[PaGlobal_FriendInfoList_All._friendFunction.GROUP_MOVE]:SetShow(isGroupMove)
    PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[PaGlobal_FriendInfoList_All._friendFunction.MESSANGER]:SetShow(isMessangerShow)
    PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[PaGlobal_FriendInfoList_All._friendFunction.WHISPER]:SetShow(isWhisperShow)
    local gapY = PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[0]:GetSizeY()
    local activeCount = 0
    for i = 0, PaGlobal_FriendInfoList_All._MAX_FUNCTION_COUNT - 1 do
      stc_Function = PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[i]
      if true == stc_Function:GetShow() then
        stc_Function:SetPosY(gapY * activeCount)
        activeCount = activeCount + 1
      end
    end
    popupBG:SetSize(popupBG:GetSizeX(), gapY * activeCount)
    PaGlobal_FriendInfoList_All._currentKeyGuideType = PaGlobal_FriendInfoList_All._keyGuideType._Popup
    PaGlobal_FriendInfoList_All:updateKeyGuides()
    PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionBG:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionBG:SetShow(false)
  end
end
function PaGlobal_FriendInfoList_All:showGroupPopupMenu(isShow)
  if nil == Panel_FriendInfoList_All then
    return
  end
  local friendListData = PaGlobal_FriendInfoList_All._friendListData
  local groupListData = PaGlobal_FriendInfoList_All._groupListData
  local popupBG = PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionBG
  popupBG:SetShow(isShow)
  local control
  local index = PaGlobal_FriendInfoList_All._groupListData._selectedGroupIndex
  if -1 ~= index then
    control = PaGlobal_FriendInfoList_All._ui.list2_Friend:GetContentByKey(toInt64(0, index))
  end
  if nil ~= control then
    local posY = PaGlobal_FriendInfoList_All._ui.list2_Friend:GetPosY() + control:GetPosY()
    popupBG:SetPosY(posY)
    local posX = -popupBG:GetSizeX() - 10
    popupBG:SetPosX(posX)
  end
  ToClient_padSnapSetTargetGroup(popupBG)
  ToClient_padSnapIgnoreGroupMove()
  PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionList[PaGlobal_FriendInfoList_All._groupFunction.GROUP_RENAME]:SetShow(true)
  PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionList[PaGlobal_FriendInfoList_All._groupFunction.GROUP_DELETE]:SetShow(true)
  local gapY = PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionList[0]:GetSizeY()
  local activeCount = 0
  for i = 0, 1 do
    stc_Function = PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionList[i]
    if true == stc_Function:GetShow() then
      stc_Function:SetPosY(gapY * activeCount)
      activeCount = activeCount + 1
    end
  end
  popupBG:SetSize(popupBG:GetSizeX(), gapY * activeCount)
  PaGlobal_FriendInfoList_All._currentKeyGuideType = PaGlobal_FriendInfoList_All._keyGuideType._Popup2
  PaGlobal_FriendInfoList_All:updateKeyGuides()
  PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionBG:SetShow(false)
  PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionBG:SetShow(false)
end
function PaGlobal_FriendInfoList_All:hidePopupMenu()
  PaGlobal_FriendInfoList_All._ui.stc_XBFunctionBG:SetShow(false)
  PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionBG:SetShow(false)
  PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionBG:SetShow(false)
  PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionBG:SetShow(false)
  if true == _ContentsGroup_UsePadSnapping then
    local index = 0
    if PaGlobal_FriendInfoList_All._tab._pcFriendTab == PaGlobal_FriendInfoList_All._currentTab then
      index = PaGlobal_FriendInfoList_All._friendListData._selectedFriendIndex
    else
      index = PaGlobal_FriendInfoList_All._selectedXBFriendIndex
    end
    PaGlobal_FriendInfoList_All._friendListData._selectedFriendIndex = -1
    PaGlobal_FriendInfoList_All._friendListData._selectedFriendUserNo = -1
    PaGlobal_FriendInfoList_All._selectedXBFriendIndex = -1
  end
end
function PaGlobal_FriendInfoList_All:updateGroups()
  if nil == Panel_FriendInfoList_All then
    return
  end
  local popupBG = PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionBG
  local menuList = PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionList
  local groupCount = PaGlobal_FriendInfoList_All._groupListData._groupCount
  local buttonSizeX = PaGlobal_FriendInfoList_All._ui.stc_Function:GetSizeX()
  local buttonSizeY = PaGlobal_FriendInfoList_All._ui.stc_Function:GetSizeY()
  for index = 0, PaGlobal_FriendInfoList_All._MAX_GROUP_COUNT - 1 do
    menuList[index]:SetShow(false)
  end
  local friendGroupNoPartyFriend = -2
  popupBG:SetSize(buttonSizeX, buttonSizeY * groupCount)
  local count = 0
  for groupIndex = 0, groupCount - 1 do
    local groupName = PaGlobal_FriendInfoList_All._groupListData._groupInfoByGroupIndex[groupIndex]:getName()
    local groupNo = PaGlobal_FriendInfoList_All._groupListData._groupInfoByGroupIndex[groupIndex]:getGroupNo()
    if groupNo ~= friendGroupNoPartyFriend then
      if groupName == "" then
        menuList[groupIndex]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FRIENDSGRUOP_DEFAULT"))
      else
        menuList[groupIndex]:SetText(groupName)
      end
      menuList[groupIndex]:SetShow(true)
      menuList[groupIndex]:SetPosY(buttonSizeY * count)
      menuList[groupIndex]:addInputEvent("Mouse_LUp", "PaGlobal_FriendInfoList_All:moveGroupTo(" .. groupIndex .. ")")
      count = count + 1
    end
  end
end
function PaGlobal_FriendInfoList_All:moveGroupTo(groupIndex)
  if nil == Panel_FriendInfoList_All then
    return
  end
  local _friendListData = PaGlobal_FriendInfoList_All._friendListData
  if nil == _friendListData._selectedFriendUserNo then
    PaGlobal_FriendInfoList_All:hidePopupMenu()
    return
  end
  local friendInfo = ToClient_getFreindInfoByUserNo(_friendListData._selectedFriendUserNo)
  if nil == friendInfo then
    return
  end
  requestFriendList_moveGroup(friendInfo:getUserNo(), PaGlobal_FriendInfoList_All._groupListData._groupInfoByGroupIndex[groupIndex]:getGroupNo())
  _friendListData._selectedFriendIndex = nil
  _friendListData._selectedFriendUserNo = nil
  PaGlobal_FriendInfoList_All._listMoveIndex = nil
  PaGlobal_FriendInfoList_All:hidePopupMenu()
end
function PaGlobal_FriendInfoList_All:groupMoveSetShow(isShow)
  if nil == Panel_FriendInfoList_All then
    return
  end
  PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionBG:SetShow(isShow)
  if isShow then
    PaGlobal_FriendInfoList_All:updateGroups()
    ToClient_padSnapSetTargetGroup(PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionBG)
    ToClient_padSnapIgnoreGroupMove()
    PaGlobal_FriendInfoList_All._currentKeyGuideType = PaGlobal_FriendInfoList_All._keyGuideType._Popup
    PaGlobal_FriendInfoList_All:updateKeyGuides()
  end
end
function PaGlobal_FriendInfoList_All:messangerPrepareOpen()
  if nil == Panel_FriendInfoList_All then
    return
  end
  local _friendListData = PaGlobal_FriendInfoList_All._friendListData
  if nil == _friendListData._selectedFriendUserNo then
    PaGlobal_FriendInfoList_All:hidePopupMenu()
    return
  end
  local friendInfo = ToClient_getFreindInfoByUserNo(_friendListData._selectedFriendUserNo)
  if nil == friendInfo then
    return
  end
  local userNo = friendInfo:getUserNo()
  local messangerId = friendInfo:getMessengerNo()
  if true == PaGlobal_FriendInfoList_All:isSelectFriendBlocked() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if false == ToClient_isLoggedInVoiceChatServer() then
    return
  end
  ToClient_OpenFriendMessenger(messangerId, __eMessengerTypeFriend, userNo)
  PaGlobal_FriendInfoList_All:hidePopupMenu()
end
function PaGlobal_FriendInfoList_All:messangerOpen(messangerId, friendUserNo)
  if nil == Panel_FriendInfoList_All then
    return
  end
  ToClient_sortMessengerMessage()
  local friendInfo = ToClient_getFreindInfoByUserNo(friendUserNo)
  if nil == friendInfo then
    return
  end
  local messangerIdstr = tostring(messangerId)
  local userName = friendInfo:getName()
  local characterName = friendInfo:getCharacterName()
  local isOnline = friendInfo:isOnline()
  local chatName = userName
  if nil ~= characterName and "" ~= characterName then
    chatName = chatName .. "(" .. characterName .. ")"
  end
  PaGlobal_FriendInfoList_All._ui.stc_ChatName:SetText(chatName)
  PaGlobal_FriendInfoList_All._ui.stc_Edit:SetMaxInput(100)
  PaGlobal_FriendInfoList_All._ui.stc_Edit:SetEnable(true)
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_FriendInfoList_All._ui.btn_Enter:SetShow(false)
    Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_FriendInfoList_All_SetFocusEdit()")
    Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "PaGlobal_FriendInfoList_All:MessangerOnMouseWheel( true )")
    Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "PaGlobal_FriendInfoList_All:MessangerOnMouseWheel( false )")
    Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "PaGlobal_FriendInfoList_All:MessangerOnMouseWheel( false )")
  else
    PaGlobal_FriendInfoList_All._ui.btn_Enter:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.btn_Enter:SetEnable(true)
  end
  if false == _ContentsGroup_UsePadSnapping then
    PaGlobal_FriendInfoList_All._ui.stc_Edit:addInputEvent("Mouse_LUp", "PaGlobalFunc_FriendInfoList_All_SetFocusEdit()")
    PaGlobal_FriendInfoList_All._ui.btn_Enter:addInputEvent("Mouse_LUp", "PaGlobalFunc_FriendInfoList_All_sendMessage(" .. messangerIdstr .. ")")
  end
  if true == _ContentsGroup_RenewUI then
    PaGlobal_FriendInfoList_All._ui.stc_Edit:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_FriendInfoList_All_sendMessageByKey")
  else
    PaGlobal_FriendInfoList_All._ui.stc_Edit:RegistReturnKeyEvent("PaGlobalFunc_FriendInfoList_All_sendMessageByKey()")
  end
  PaGlobal_FriendInfoList_All._ui.stc_Edit:setClickMouseCursorType(__eMouseCursorType_Text)
  PaGlobal_FriendInfoList_All._ui.stc_Edit:setOnMouseCursorType(__eMouseCursorType_Text)
  Panel_FriendInfoList_All:addInputEvent("Mouse_UpScroll", "PaGlobal_FriendInfoList_All:MessangerOnMouseWheel( true )")
  Panel_FriendInfoList_All:addInputEvent("Mouse_DownScroll", "PaGlobal_FriendInfoList_All:MessangerOnMouseWheel( false )")
  local messangerId_s64 = tonumber64(messangerIdstr)
  local messengerInfo = ToClient_GetMessengerInfo(messangerId_s64)
  if nil == messengerInfo then
    return
  end
  local friendUserNo = ToClient_GetMessengerInFriendUserNo(messangerId_s64)
  if toInt64(0, 0) == friendUserNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoStaticStatusInvalidValue"))
    return
  end
  local friendInfo = ToClient_getFreindInfoByUserNo(friendUserNo)
  if nil == friendInfo then
    return
  end
  local friendClass = friendInfo:getClassType()
  local isOnline = friendInfo:isOnline()
  local message = messengerInfo:beginMessage()
  PaGlobal_FriendInfoList_All:clearAllMessage()
  while message ~= nil do
    PaGlobal_FriendInfoList_All:updateMessage(message, friendClass, isOnline)
    message = messengerInfo:nextMessage()
  end
  PaGlobal_FriendInfoList_All._ui.btn_Alarm:SetCheck(not messengerInfo:getAlarmIsOn())
  PaGlobal_FriendInfoList_All._ui.FrameContent:SetSize(0, 0)
  PaGlobal_FriendInfoList_All._ui.FrameScroll:SetControlBottom()
  PaGlobal_FriendInfoList_All._ui.Frame_Chat:UpdateContentScroll()
  PaGlobal_FriendInfoList_All._ui.Frame_Chat:UpdateContentPos()
  PaGlobal_FriendInfoList_All._ui.FrameScroll:GetControlButton():SetPosX(0)
  PaGlobal_FriendInfoList_All._currentOpenMessangerId = messangerId
  PaGlobal_FriendInfoList_All._currentKeyGuideType = PaGlobal_FriendInfoList_All._keyGuideType._Friend
  PaGlobal_FriendInfoList_All:updateKeyGuides()
end
function PaGlobal_FriendInfoList_All:clearAllMessage()
  for index = 0, PaGlobal_FriendInfoList_All._messageCount - 1 do
    PaGlobal_FriendInfoList_All._StaticBg[index]:SetShow(false)
    PaGlobal_FriendInfoList_All._StaticText[index]:SetShow(false)
    PaGlobal_FriendInfoList_All._StaticTime[index]:SetShow(false)
    PaGlobal_FriendInfoList_All._StaticClass[index]:SetShow(false)
    UI.deleteControl(PaGlobal_FriendInfoList_All._StaticBg[index])
    UI.deleteControl(PaGlobal_FriendInfoList_All._StaticText[index])
    UI.deleteControl(PaGlobal_FriendInfoList_All._StaticTime[index])
    UI.deleteControl(PaGlobal_FriendInfoList_All._StaticClass[index])
  end
  PaGlobal_FriendInfoList_All._messageCount = 0
  PaGlobal_FriendInfoList_All._currentOpenMessangerId = nil
end
function PaGlobal_FriendInfoList_All:updateMessage(chattingMessage, friendClass, isOnline)
  local msg = chattingMessage:getContent()
  local msgTime = chattingMessage:getTime()
  local isMe = chattingMessage.isMe
  PaGlobal_FriendInfoList_All:showMessage(isMe, msg, msgTime, friendClass, isOnline)
  PaGlobal_FriendInfoList_All._messageCount = PaGlobal_FriendInfoList_All._messageCount + 1
end
function PaGlobal_FriendInfoList_All:showMessage(isMe, msg, msgTime, friendClass, isOnline)
  PaGlobal_FriendInfoList_All:createMessageUI(isMe)
  PaGlobal_FriendInfoList_All:resizeMessageUI(isMe, msg, msgTime, friendClass, isOnline)
  PaGlobal_FriendInfoList_All:setPosMessageUI(isMe)
end
function PaGlobal_FriendInfoList_All:createMessageUI(isMe)
  local messageCount = PaGlobal_FriendInfoList_All._messageCount
  local frameChat = UI.getChildControl(Panel_FriendInfoList_All, "Frame_Chat")
  local frameContent = UI.getChildControl(frameChat, "Frame_1_Content")
  local styleBg = UI.getChildControl(frameContent, "Static_To")
  local styleText = UI.getChildControl(styleBg, "StaticText_To")
  local styleTime = UI.getChildControl(styleBg, "StaticText_Time")
  local styleClass = UI.getChildControl(styleBg, "Static_ClassIcon")
  if false == isMe then
    styleBg = UI.getChildControl(frameContent, "Static_From")
    styleText = UI.getChildControl(styleBg, "StaticText_From")
    styleTime = UI.getChildControl(styleBg, "StaticText_Time")
    styleClass = UI.getChildControl(styleBg, "Static_ClassIcon")
  end
  PaGlobal_FriendInfoList_All._StaticBg[messageCount] = UI.createControl(__ePAUIControl_Static, frameContent, "Static_BG_" .. messageCount)
  PaGlobal_FriendInfoList_All._StaticText[messageCount] = UI.createControl(__ePAUIControl_StaticText, frameContent, "Static_Text_" .. messageCount)
  PaGlobal_FriendInfoList_All._StaticTime[messageCount] = UI.createControl(__ePAUIControl_StaticText, frameContent, "Static_Time_" .. messageCount)
  PaGlobal_FriendInfoList_All._StaticClass[messageCount] = UI.createControl(__ePAUIControl_Static, frameContent, "Static_Class_" .. messageCount)
  CopyBaseProperty(styleBg, PaGlobal_FriendInfoList_All._StaticBg[messageCount])
  CopyBaseProperty(styleText, PaGlobal_FriendInfoList_All._StaticText[messageCount])
  CopyBaseProperty(styleTime, PaGlobal_FriendInfoList_All._StaticTime[messageCount])
  CopyBaseProperty(styleClass, PaGlobal_FriendInfoList_All._StaticClass[messageCount])
  PaGlobal_FriendInfoList_All._StaticBg[messageCount]:SetShow(true)
  PaGlobal_FriendInfoList_All._StaticText[messageCount]:SetIgnore(true)
  PaGlobal_FriendInfoList_All._StaticText[messageCount]:SetShow(true)
  PaGlobal_FriendInfoList_All._StaticTime[messageCount]:SetIgnore(true)
  PaGlobal_FriendInfoList_All._StaticTime[messageCount]:SetShow(true)
  if false == isMe then
    PaGlobal_FriendInfoList_All._StaticClass[messageCount]:SetIgnore(true)
    PaGlobal_FriendInfoList_All._StaticClass[messageCount]:SetShow(true)
  else
    PaGlobal_FriendInfoList_All._StaticClass[messageCount]:SetIgnore(true)
    PaGlobal_FriendInfoList_All._StaticClass[messageCount]:SetShow(false)
  end
end
function PaGlobal_FriendInfoList_All:resizeMessageUI(isMe, msg, msgTime, friendClass, isOnline)
  local messageCount = PaGlobal_FriendInfoList_All._messageCount
  local panelSizeX = Panel_FriendInfoList_All:GetSizeX()
  local maxTextSizeX = panelSizeX - 100
  local maxTimeTextSize = 100
  local staticText = PaGlobal_FriendInfoList_All._StaticText[messageCount]
  local staticBg = PaGlobal_FriendInfoList_All._StaticBg[messageCount]
  local staticTime = PaGlobal_FriendInfoList_All._StaticTime[messageCount]
  local staticClass = PaGlobal_FriendInfoList_All._StaticClass[messageCount]
  if false == isMe then
    staticText:SetFontColor(Defines.Color.C_FF6C6C6C)
  else
    staticText:SetFontColor(Defines.Color.C_FFFFEDD4)
  end
  staticText:SetSize(maxTextSizeX, staticText:GetSizeY())
  staticText:SetAutoResize(true)
  staticText:SetTextMode(__eTextMode_AutoWrap)
  staticText:SetText(msg)
  staticTime:SetFontColor(Defines.Color.C_FF988D83)
  staticTime:SetSize(maxTimeTextSize, staticTime:GetSizeY())
  local timeValue = PATime(msgTime)
  staticTime:SetText(timeValue:GetYear() .. "/" .. timeValue:GetMonth() .. "/" .. timeValue:GetDay() .. " " .. timeValue:GetHour() .. ":" .. timeValue:GetMinute())
  if true == isOnline then
    PaGlobal_Friend_SetTexture(staticClass, friendClass)
  else
    PaGlobal_Friend_SetTexture(staticClass, __eClassType_Count)
  end
  local scaleX = PaGlobal_FriendInfoList_All._ui.Frame_Chat:GetScale().x
  local scaleY = PaGlobal_FriendInfoList_All._ui.Frame_Chat:GetScale().y
  staticBg:SetSize((staticText:GetTextSizeX() + 20) * scaleX, (staticText:GetSizeY() + 15) * scaleY)
end
function PaGlobal_FriendInfoList_All:setPosMessageUI(isMe)
  local scaleX = PaGlobal_FriendInfoList_All._ui.Frame_Chat:GetScale().x
  local scaleY = PaGlobal_FriendInfoList_All._ui.Frame_Chat:GetScale().y
  local messageCount = PaGlobal_FriendInfoList_All._messageCount
  local prevBgSizeY = 0
  local prevBgPosY = 0
  local gapX = 10 * scaleX
  local gapY = 10 * scaleY
  local preTimeSizeY = PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetSizeY() + 1
  if messageCount > 0 then
    prevBgSizeY = PaGlobal_FriendInfoList_All._StaticBg[messageCount - 1]:GetSizeY()
    prevBgPosY = PaGlobal_FriendInfoList_All._StaticBg[messageCount - 1]:GetPosY() + preTimeSizeY
  end
  if false == isMe then
    PaGlobal_FriendInfoList_All._StaticClass[messageCount]:SetPosX(5)
    PaGlobal_FriendInfoList_All._StaticBg[messageCount]:SetPosX(PaGlobal_FriendInfoList_All._StaticClass[messageCount]:GetPosX() + PaGlobal_FriendInfoList_All._StaticClass[messageCount]:GetSizeX() + gapX)
    PaGlobal_FriendInfoList_All._StaticText[messageCount]:SetPosX(PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetPosX() + gapX)
    PaGlobal_FriendInfoList_All._StaticTime[messageCount]:SetPosX(PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetPosX() + gapX * 0.5)
  else
    PaGlobal_FriendInfoList_All._StaticBg[messageCount]:SetPosX(PaGlobal_FriendInfoList_All._ui.FrameScroll:GetPosX() - PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetSizeX() - gapX)
    PaGlobal_FriendInfoList_All._StaticText[messageCount]:SetPosX(Panel_FriendInfoList_All:GetSizeX() - PaGlobal_FriendInfoList_All._StaticText[messageCount]:GetSizeX() - gapX * 4)
    PaGlobal_FriendInfoList_All._StaticTime[messageCount]:SetPosX(Panel_FriendInfoList_All:GetSizeX() - PaGlobal_FriendInfoList_All._StaticTime[messageCount]:GetSizeX() - gapX * 2)
  end
  PaGlobal_FriendInfoList_All._StaticBg[messageCount]:SetPosY(prevBgPosY + prevBgSizeY)
  PaGlobal_FriendInfoList_All._StaticText[messageCount]:SetPosY(PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetPosY() + gapY)
  PaGlobal_FriendInfoList_All._StaticTime[messageCount]:SetPosY(PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetPosY() + PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetSizeY() + 5)
  PaGlobal_FriendInfoList_All._StaticClass[messageCount]:SetPosY(PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetPosY())
end
function PaGlobal_FriendInfoList_All:resizeMessageUIDrag(messageCount, isMe, msg, msgTime)
  local panelSizeX = Panel_FriendInfoList_All:GetSizeX()
  local maxTextSizeX = panelSizeX - 100
  local maxTimeTextSize = 100
  local staticText = PaGlobal_FriendInfoList_All._StaticText[messageCount]
  local staticBg = PaGlobal_FriendInfoList_All._StaticBg[messageCount]
  local staticTime = PaGlobal_FriendInfoList_All._StaticTime[messageCount]
  local staticClass = PaGlobal_FriendInfoList_All._StaticClass[messageCount]
  staticText:SetSize(maxTextSizeX, staticText:GetSizeY())
  staticText:SetTextMode(__eTextMode_AutoWrap)
  staticText:SetText(msg)
  staticTime:SetSize(maxTimeTextSize, staticTime:GetSizeY())
  local scaleX = PaGlobal_FriendInfoList_All._ui.Frame_Chat:GetScale().x
  local scaleY = PaGlobal_FriendInfoList_All._ui.Frame_Chat:GetScale().y
  staticBg:SetSize((staticText:GetTextSizeX() + 20) * scaleX, (staticText:GetSizeY() + 15) * scaleY)
  local prevBgSizeY = 0
  local prevBgPosY = 0
  local gapX = 10 * scaleX
  local gapY = 10 * scaleY
  local preTimeSizeY = PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetSizeY() + 1
  if messageCount > 0 then
    prevBgSizeY = PaGlobal_FriendInfoList_All._StaticBg[messageCount - 1]:GetSizeY()
    prevBgPosY = PaGlobal_FriendInfoList_All._StaticBg[messageCount - 1]:GetPosY() + preTimeSizeY
  end
  if false == isMe then
    PaGlobal_FriendInfoList_All._StaticClass[messageCount]:SetPosX(5)
    PaGlobal_FriendInfoList_All._StaticBg[messageCount]:SetPosX(PaGlobal_FriendInfoList_All._StaticClass[messageCount]:GetPosX() + PaGlobal_FriendInfoList_All._StaticClass[messageCount]:GetSizeX() + gapX)
    PaGlobal_FriendInfoList_All._StaticText[messageCount]:SetPosX(PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetPosX() + gapX)
    PaGlobal_FriendInfoList_All._StaticTime[messageCount]:SetPosX(PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetPosX() + gapX * 0.5)
  else
    PaGlobal_FriendInfoList_All._StaticBg[messageCount]:SetPosX(PaGlobal_FriendInfoList_All._ui.FrameScroll:GetPosX() - PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetSizeX() - gapX)
    PaGlobal_FriendInfoList_All._StaticText[messageCount]:SetPosX(Panel_FriendInfoList_All:GetSizeX() - PaGlobal_FriendInfoList_All._StaticText[messageCount]:GetSizeX() - gapX * 4)
    PaGlobal_FriendInfoList_All._StaticTime[messageCount]:SetPosX(Panel_FriendInfoList_All:GetSizeX() - PaGlobal_FriendInfoList_All._StaticTime[messageCount]:GetSizeX() - gapX * 2)
  end
  PaGlobal_FriendInfoList_All._StaticBg[messageCount]:SetPosY(prevBgPosY + prevBgSizeY)
  PaGlobal_FriendInfoList_All._StaticText[messageCount]:SetPosY(PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetPosY() + gapY)
  PaGlobal_FriendInfoList_All._StaticTime[messageCount]:SetPosY(PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetPosY() + PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetSizeY() + 5)
  PaGlobal_FriendInfoList_All._StaticClass[messageCount]:SetPosY(PaGlobal_FriendInfoList_All._StaticBg[messageCount]:GetPosY())
end
function PaGlobal_FriendInfoList_All:MessangerOnMouseWheel(isUp)
  local targetScroll = PaGlobal_FriendInfoList_All._ui.FrameScroll
  if isUp then
    targetScroll:ControlButtonUp()
  else
    targetScroll:ControlButtonDown()
  end
  PaGlobal_FriendInfoList_All._ui.Frame_Chat:UpdateContentPos()
end
function HandleEventRUp_FriendInfoList_All_GroupRenameOpen(index)
  PaGlobal_FriendInfoList_All._groupListData._selectedGroupIndex = index
  PaGlobal_FriendInfoList_All._friendListData._selectedFriendIndex = nil
  PaGlobal_FriendInfoList_All._friendListData._selectedFriendUserNo = nil
  PaGlobal_FriendInfoList_All._listMoveIndex = index
  PaGlobal_Friend_GroupRename_All_Open(false)
end
function HandleEventRUp_FriendInfoList_All_ShowFriendPopup(index, friendUserNo)
  PaGlobal_FriendInfoList_All._groupListData._selectedGroupIndex = nil
  PaGlobal_FriendInfoList_All._friendListData._selectedFriendIndex = index
  PaGlobal_FriendInfoList_All._friendListData._selectedFriendUserNo = tonumber64(friendUserNo)
  PaGlobal_FriendInfoList_All._listMoveIndex = index
  PaGlobal_FriendInfoList_All:showFriendPopupMenu(true)
end
function HandleEventRUp_FriendInfoList_All_ShowGroupPopup(index)
  PaGlobal_FriendInfoList_All._groupListData._selectedGroupIndex = index
  PaGlobal_FriendInfoList_All._friendListData._selectedFriendIndex = nil
  PaGlobal_FriendInfoList_All._friendListData._selectedFriendUserNo = nil
  PaGlobal_FriendInfoList_All._listMoveIndex = nil
  PaGlobal_FriendInfoList_All:showGroupPopupMenu(true)
end
function HandleEventLUp_FriendInfoList_All_MessangerPrepareOpen(index, friendUserNo)
  PaGlobal_FriendInfoList_All._groupListData._selectedGroupIndex = nil
  PaGlobal_FriendInfoList_All._friendListData._selectedFriendIndex = index
  PaGlobal_FriendInfoList_All._friendListData._selectedFriendUserNo = tonumber64(friendUserNo)
  PaGlobal_FriendInfoList_All._listMoveIndex = PaGlobal_FriendInfoList_All._ui.list2_Friend:getCurrenttoIndex()
  PaGlobal_FriendInfoList_All:messangerPrepareOpen()
end
function HandleEventLUp_FriendInfoList_All_MessangerCloseInFriendList()
  PaGlobalFunc_FriendInfoList_All_MessangerCloseInFriendList()
  PaGlobal_FriendInfoList_All:updateFriendList()
end
function PaGlobalFunc_FriendInfoList_All_MessangerCloseInFriendList()
  if nil ~= PaGlobal_FriendInfoList_All._currentOpenMessangerId then
    ToClient_CloseFriendMessenger(PaGlobal_FriendInfoList_All._currentOpenMessangerId, __eMessengerTypeFriend)
  end
  PaGlobal_FriendInfoList_All._ui.stc_Chat_TitleBar:SetShow(false)
  PaGlobal_FriendInfoList_All._ui.Frame_Chat:SetShow(false)
  PaGlobal_FriendInfoList_All._ui.stc_EditGroup:SetShow(false)
  PaGlobal_FriendInfoList_All._ui.stc_Emoticon_BG:SetShow(false)
  PaGlobal_FriendInfoList_All._ui.list2_Friend:SetShow(true)
  PaGlobal_FriendInfoList_All._ui.btn_Drop:addInputEvent("Mouse_LUp", "")
  PaGlobal_FriendInfoList_All._ui.btn_Alarm:addInputEvent("Mouse_LUp", "")
  PaGlobal_FriendInfoList_All._ui.btn_Enter:addInputEvent("Mouse_LUp", "")
  Panel_FriendInfoList_All:addInputEvent("Mouse_UpScroll", "")
  Panel_FriendInfoList_All:addInputEvent("Mouse_DownScroll", "")
  Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "")
  Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "")
  PaGlobal_FriendInfoList_All:clearAllMessage()
  PaGlobal_FriendInfoList_All._currentKeyGuideType = PaGlobal_FriendInfoList_All._keyGuideType._Friend
  PaGlobal_FriendInfoList_All:updateKeyGuides()
end
function PaGlobal_FriendInfoList_Show_All()
  if nil == Panel_FriendInfoList_All then
    return
  end
  PaGlobal_FriendInfoList_All:prepareOpen()
  if 0 < RequestFriends_getAddFriendCount() then
    PaGlobal_FriendRequest_All_Open(false)
  end
end
function PaGlobal_FriendInfoList_All_Close()
  if nil == Panel_FriendInfoList_All then
    return
  end
  PaGlobal_FriendInfoList_All:prepareClose()
end
function PaGlobal_FriendInfoList_Hide_All()
  if nil == Panel_FriendInfoList_All then
    return
  end
  PaGlobal_FriendInfoList_All:hidePopupMenu()
  PaGlobal_FriendInfoList_All:prepareClose()
end
function PaGlobal_FriendInfoList_All_List2ControlCreate(control, key64)
  local index = Int64toInt32(key64)
  local parentBG = UI.getChildControl(control, "Static_ParentBG")
  local groupName = UI.getChildControl(parentBG, "StaticText_Name")
  local btnOption = UI.getChildControl(parentBG, "Button_Option")
  local keyGuideY = UI.getChildControl(parentBG, "Static_Y_ConsoleUI")
  local checkButton = UI.getChildControl(parentBG, "CheckButton_1")
  local childBG = UI.getChildControl(control, "Static_ChildBG")
  local classIcon = UI.getChildControl(childBG, "Static_ClassIcon")
  local isOnlineIcon = UI.getChildControl(classIcon, "Static_Online")
  local isOfflineIcon = UI.getChildControl(classIcon, "Static_OffLine")
  local lv = UI.getChildControl(childBG, "StaticText_Lv")
  local name = UI.getChildControl(childBG, "StaticText_Name")
  local server = UI.getChildControl(childBG, "StaticText_Server")
  local new = UI.getChildControl(childBG, "StaticText_New")
  local targetPlatformIcon = UI.getChildControl(control, "Static_PlatformIcon_ConsoleUI")
  local _groupListData = PaGlobal_FriendInfoList_All._groupListData
  local _friendListData = PaGlobal_FriendInfoList_All._friendListData
  local friendGroupNoDefault = -1
  local friendGroupNoPartyFriend = -2
  parentBG:SetShow(false)
  childBG:SetShow(false)
  control:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  parentBG:addInputEvent("Mouse_RUp", "")
  parentBG:setNotImpactScrollEvent(true)
  childBG:setNotImpactScrollEvent(true)
  if PaGlobal_FriendInfoList_All._tab._pcFriendTab == PaGlobal_FriendInfoList_All._currentTab then
    if true == _ContentsGroup_RenewUI then
      local curChannelData = getCurrentChannelServerData()
      local pcFriendGroup = RequestFriends_getFriendGroupAt(0)
      local friendInfo = pcFriendGroup:getFriendAt(index)
      local friendName = friendInfo:getName()
      local regionName = friendInfo:getRegionName()
      local serverName = getChannelName(curChannelData._worldNo, friendInfo:getServerNo())
      local level = "Lv." .. tostring(friendInfo:getLevel())
      local charcterName = friendInfo:getCharacterName()
      local classType = friendInfo:getClassType()
      childBG:SetShow(true)
      childBG:SetCheck(false)
      if index == PaGlobal_FriendInfoList_All._friendListData._selectedFriendIndex then
        childBG:SetCheck(true)
      end
      if true == ToClient_isPS4() then
        local psOnlineId = ToClient_getOnlineId(friendInfo:getUserNo())
        local selfPlayerPlatform = ToClient_getGamePlatformType()
        local friendPlatform = friendInfo:getPlatformType()
        if nil == psOnlineId or "" == psOnlineId or friendPlatform ~= selfPlayerPlatform then
          psOnlineId = "-"
        end
        if false == friendInfo:isOnline() then
          psOnlineId = "Not Login"
        end
        charcterName = psOnlineId
      end
      local isOffline = false == friendInfo:isOnline() or true == friendInfo:isGhostMode()
      if nil == regionName then
        regionName = ""
      end
      if nil == serverName then
        serverName = ""
      end
      if nil == level then
        level = ""
      end
      if nil == charcterName then
        charcterName = ""
      end
      if true == isOffline then
        local s64_lastLogoutTime = friendInfo:getLastLogoutTime_s64()
        lv:SetShow(false)
        name:SetShow(true)
        server:SetShow(true)
        name:SetText(friendName)
        convertStringFromDatetimeOverHourForFriends(s64_lastLogoutTime)
        server:SetText(s64_lastLogoutTime)
        PaGlobal_Friend_SetTexture(classIcon, __eClassType_Count)
        lv:SetPosY(childBG:GetPosY() + 5)
        name:SetPosY(childBG:GetPosY() + 5)
      else
        lv:SetShow(true)
        name:SetShow(true)
        server:SetShow(true)
        friendName = friendName .. " " .. "(" .. charcterName .. ")"
        lv:SetText(level)
        server:SetText(serverName .. " / " .. regionName)
        name:SetText(friendName)
        PaGlobal_Friend_SetTexture(classIcon, classType)
        server:SetShow(false)
        lv:SetPosY(childBG:GetPosY() + childBG:GetSizeY() / 2 - 5)
        name:SetPosY(childBG:GetPosY() + childBG:GetSizeY() / 2 - 5)
      end
      control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_FriendInfoList_All_ShowFriendPopup(" .. index .. ")")
      control:addInputEvent("Mouse_On", "PaGlobal_FriendInfoList_All_SetSelectedFriendIndex()")
      if true == lv:GetShow() then
        name:SetPosX(lv:GetPosX() + lv:GetSizeX())
      else
        name:SetPosX(classIcon:GetPosX() + classIcon:GetSizeX() + 10)
      end
      isOnlineIcon:SetShow(not isOffline)
      isOfflineIcon:SetShow(isOffline)
      if true == ToClient_isTotalGameClient() then
        PaGlobal_FriendInfoList_All_CrossPlayIconSetting(targetPlatformIcon, friendInfo:getPlatformType(), name)
      end
    elseif nil ~= _groupListData._groupInfo[index] then
      local friendGroup = _groupListData._groupInfo[index]
      local treeElement = PaGlobal_FriendInfoList_All._ui.list2_Friend:getElementManager():getByKey(key64)
      if true == friendGroup:isHide() then
        checkButton:SetCheck(false)
      else
        checkButton:SetCheck(true)
      end
      parentBG:SetShow(true)
      btnOption:SetShow(false)
      if friendGroup:getGroupNo() == friendGroupNoDefault then
        groupName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FRIENDSGRUOP_DEFAULT"))
      elseif friendGroup:getGroupNo() == friendGroupNoPartyFriend then
        groupName:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_GROUP_PARTY"))
      else
        btnOption:SetShow(true)
        groupName:SetText(friendGroup:getName())
        if true == _ContentsGroup_UsePadSnapping then
          btnOption:SetShow(false)
          keyGuideY:SetShow(true)
          control:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventRUp_FriendInfoList_All_ShowGroupPopup(" .. index .. ")")
        else
          btnOption:addInputEvent("Mouse_LUp", "HandleEventRUp_FriendInfoList_All_ShowGroupPopup(" .. index .. ")")
        end
      end
      if true == _ContentsGroup_UsePadSnapping then
        control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_FriendInfoList_All_ToggleGroup(" .. index .. ")")
        control:addInputEvent("Mouse_On", "PaGlobal_FriendInfoList_All_SetSelectedGroupIndex(" .. index .. ")")
      else
        parentBG:addInputEvent("Mouse_LUp", "PaGlobal_FriendInfoList_All_ToggleGroup(" .. index .. ")")
      end
    elseif nil ~= _friendListData._friendInfo[index] then
      local friendInfo = _friendListData._friendInfo[index]
      local curChannelData = getCurrentChannelServerData()
      local pcFriendGroup = RequestFriends_getFriendGroupAt(0)
      local friendName = friendInfo:getName()
      local regionName = friendInfo:getRegionName()
      local serverName = getChannelName(curChannelData._worldNo, friendInfo:getServerNo())
      local level = "Lv." .. tostring(friendInfo:getLevel())
      local charcterName = friendInfo:getCharacterName()
      local classType = friendInfo:getClassType()
      childBG:SetShow(true)
      local isOffline = false == friendInfo:isOnline()
      if nil == regionName then
        regionName = ""
      end
      if nil == serverName then
        serverName = ""
      end
      if nil == level then
        level = ""
      end
      if nil == charcterName then
        charcterName = ""
      end
      if true == isOffline then
        local s64_lastLogoutTime = friendInfo:getLastLogoutTime_s64()
        lv:SetShow(false)
        name:SetShow(true)
        server:SetShow(true)
        name:SetText(friendName)
        server:SetText(convertStringFromDatetimeOverHourForFriends(s64_lastLogoutTime))
        PaGlobal_Friend_SetTexture(classIcon, __eClassType_Count)
        lv:SetPosY(childBG:GetPosY() + 5)
        name:SetPosY(childBG:GetPosY() + 5)
      else
        lv:SetShow(true)
        name:SetShow(true)
        server:SetShow(true)
        if "" ~= charcterName then
          friendName = friendName .. " " .. "(" .. charcterName .. ")"
        end
        lv:SetText(level)
        server:SetText(serverName .. " / " .. regionName)
        name:SetText(friendName)
        PaGlobal_Friend_SetTexture(classIcon, classType)
        server:SetShow(false)
        lv:SetPosY(childBG:GetPosY() + childBG:GetSizeY() / 2 - 5)
        name:SetPosY(childBG:GetPosY() + childBG:GetSizeY() / 2 - 5)
      end
      if true == _ContentsGroup_UsePadSnapping then
        control:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
        control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_FriendInfoList_All_ShowFriendPopup(" .. index .. "," .. tostring(friendInfo:getUserNo()) .. ")")
        control:addInputEvent("Mouse_On", "PaGlobal_FriendInfoList_All_SetSelectedFriendIndex()")
      else
        childBG:addInputEvent("Mouse_RUp", "HandleEventRUp_FriendInfoList_All_ShowFriendPopup(" .. index .. "," .. tostring(friendInfo:getUserNo()) .. ")")
        childBG:addInputEvent("Mouse_LUp", "HandleEventLUp_FriendInfoList_All_MessangerPrepareOpen(" .. index .. "," .. tostring(friendInfo:getUserNo()) .. ")")
      end
      if true == lv:GetShow() then
        name:SetPosX(lv:GetPosX() + lv:GetSizeX())
      else
        name:SetPosX(classIcon:GetPosX() + classIcon:GetSizeX() + 10)
      end
      isOnlineIcon:SetShow(not isOffline)
      isOfflineIcon:SetShow(isOffline)
      local messangerId_s64 = friendInfo:getMessengerNo()
      local messageList = ToClient_GetMessengerInfo(messangerId_s64)
      if nil ~= messageList then
        local messageCount = messageList:getNoneReadMessageCount()
        if messageCount > 0 then
          new:SetShow(true)
          new:SetText(tostring(messageCount))
          if messageCount >= 100 then
            new:SetText("99+")
          end
        else
          new:SetShow(false)
          new:SetText("0")
        end
      else
        new:SetShow(false)
        new:SetText("0")
      end
    end
  elseif PaGlobal_FriendInfoList_All._tab._consoleFriendTab == PaGlobal_FriendInfoList_All._currentTab then
    childBG:SetShow(true)
    addGroup:SetShow(false)
    childBG:SetCheck(false)
    if index == PaGlobal_FriendInfoList_All._selectedXBFriendIndex then
      childBG:SetCheck(true)
    end
    local xboxFriendInfo = ToClient_getXboxFriendInfoByIndex(index)
    local isLogin = xboxFriendInfo:isOnline()
    local familyNameStr = xboxFriendInfo:getName()
    local friendName = xboxFriendInfo:getGamerTag()
    if true == isLogin then
      if nil == familyNameStr or "" == familyNameStr then
        friendName = friendName .. " (" .. PAGetString(Defines.StringSheet_GAME, "LUA_FRIENDLIST_NOTINGAME") .. ")"
      else
        friendName = friendName .. " (" .. familyNameStr .. ", " .. PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_ONLINE") .. ")"
      end
    else
      friendName = friendName .. " (" .. PAGetString(Defines.StringSheet_GAME, "LUA_FRIENDINFO_LOGOUT") .. ")"
    end
    name:SetText(friendName)
    if true == ToClient_isTotalGameClient() then
      PaGlobal_FriendInfoList_All_CrossPlayIconSetting(targetPlatformIcon, xboxFriendInfo:getPlatformType(), name)
    end
    control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_FriendInfoList_All:showXBMenu(" .. index .. ")")
    control:addInputEvent("Mouse_On", "PaGlobal_FriendInfoList_All_SetSelectedXBFriendIndex()")
  end
end
function PaGlobal_FriendInfoList_All_CrossPlayIconSetting(targetPlatformIconControl, friendPlatformType, nameControl)
  targetPlatformIconControl:SetShow(false)
  if nil == friendPlatformType then
    return
  end
  if true == _ContentsGroup_ConsoleIntegration then
    targetPlatformIconControl:SetShow(true)
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    if selfPlayerPlatform == friendPlatformType then
      if __eGAME_PLATFORM_TYPE_PS == selfPlayerPlatform then
        targetPlatformIconControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_ps.dds")
      elseif __eGAME_PLATFORM_TYPE_XB == selfPlayerPlatform then
        targetPlatformIconControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_xb.dds")
      end
    else
      targetPlatformIconControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_other.dds")
    end
    nameControl:SetPosX(targetPlatformIconControl:GetPosY() + targetPlatformIconControl:GetSizeX() + nameControl:GetSpanSize().x)
  end
end
function PaGlobal_FriendInfoList_All_ToggleGroup(id)
  PaGlobal_FriendInfoList_All:hidePopupMenu()
  PaGlobal_FriendInfoList_All._groupListData._selectedGroupIndex = id
  PaGlobal_FriendInfoList_All._friendListData._selectedFriendIndex = nil
  PaGlobal_FriendInfoList_All._friendListData._selectedFriendUserNo = nil
  PaGlobal_FriendInfoList_All._listMoveIndex = id
  local groupListData = PaGlobal_FriendInfoList_All._groupListData._groupInfo[PaGlobal_FriendInfoList_All._groupListData._selectedGroupIndex]
  if nil ~= groupListData then
    local groupNo = groupListData:getGroupNo()
    requestFriendList_checkGroup(groupNo)
  end
end
function PaGlobal_FriendInfoList_All_SetSelectedGroupIndex(index)
  if 0 ~= index then
    PaGlobal_FriendInfoList_All._currentKeyGuideType = PaGlobal_FriendInfoList_All._keyGuideType._Group
  else
    PaGlobal_FriendInfoList_All._currentKeyGuideType = PaGlobal_FriendInfoList_All._keyGuideType._DefaultGroup
  end
  PaGlobal_FriendInfoList_All:updateKeyGuides()
end
function PaGlobal_FriendInfoList_All_SetSelectedFriendIndex()
  PaGlobal_FriendInfoList_All._currentKeyGuideType = PaGlobal_FriendInfoList_All._keyGuideType._Friend
  PaGlobal_FriendInfoList_All:updateKeyGuides()
end
function PaGlobal_FriendInfoList_All_SetSelectedXBFriendIndex()
  PaGlobal_FriendInfoList_All._currentKeyGuideType = PaGlobal_FriendInfoList_All._keyGuideType._XBFriend
  PaGlobal_FriendInfoList_All:updateKeyGuides()
end
function PaGlobal_FriendInfoList_All_OnAddGroupBtn()
  PaGlobal_FriendInfoList_All._currentKeyGuideType = PaGlobal_FriendInfoList_All._keyGuideType._AddGroup
  PaGlobal_FriendInfoList_All:updateKeyGuides()
end
function PaGlobal_FriendInfoList_All_ClickAddFriendButton()
  if nil == Panel_FriendInfoList_All then
    return
  end
  if false == ToClient_isAddFriendAllowed() then
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
  elseif PaGlobal_FriendInfoList_All._tab._pcFriendTab == PaGlobal_FriendInfoList_All._currentTab then
    if false == Panel_FriendList_Add_All:GetShow() then
      PaGlobal_AddFriend_All_Open()
    else
      PaGlobal_AddFriend_All_Close()
    end
  end
end
function PaGlobal_FriendInfoList_All_ShowPSInviteDialog()
  ToClient_showInviteDialog()
end
function PaGlobal_FriendInfoList_All_ChangeTab()
  if nil == Panel_FriendInfoList_All then
    return
  end
  if PaGlobal_FriendInfoList_All._tab._consoleFriendTab == PaGlobal_FriendInfoList_All._currentTab then
    PaGlobal_FriendInfoList_All._currentTab = PaGlobal_FriendInfoList_All._tab._pcFriendTab
  else
    PaGlobal_FriendInfoList_All._currentTab = PaGlobal_FriendInfoList_All._tab._consoleFriendTab
  end
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  PaGlobal_FriendInfoList_All:hidePopupMenu()
  PaGlobal_FriendInfoList_All:updateTab()
  ToClient_padSnapResetControl()
end
function FromClient_NotifyFriendMessage(msgType, strParam1, param1, param2)
  local msgStr = ""
  if 0 == msgType then
    if 1 == param1 then
      msgStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FRIENDS_NOTIFYFRIENDMESSAGE_LOGIN", "strParam1", strParam1)
    elseif 0 == param1 then
      msgStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FRIENDS_NOTIFYFRIENDMESSAGE_LOGOUT", "strParam1", strParam1)
    end
    if true == GameOption_ShowFriendLoginMessage() then
      Proc_ShowMessage_Ack(msgStr)
    end
    PaGlobal_FriendInfoList_All._listMoveIndex = PaGlobal_FriendInfoList_All._ui.list2_Friend:getCurrenttoIndex()
    PaGlobal_FriendInfoList_All:updateTab()
  end
end
function FromClient_FriendDirectlyMessage(fromUserName)
  local directlyYes = function()
    ToClient_RquestDirectlyCompelte(true)
  end
  local directlyNo = function()
    ToClient_RquestDirectlyCompelte(false)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_TEXT_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_XBOX_FRIEND_MESSAGE", "userName", fromUserName),
    functionYes = directlyYes,
    functionNo = directlyNo,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_NoticeNewMessage_All(isSoundNotice, isEffectNotice)
  if nil == Panel_FriendInfoList_All then
    return
  end
  if isSoundNotice then
    audioPostEvent_SystemUi(3, 11)
    _AudioPostEvent_SystemUiForXBOX(3, 11)
  end
end
function FromClient_FriendInfoList_All_ResponseUpdateFriends()
  if nil == Panel_FriendInfoList_All then
    return
  end
  if PaGlobal_FriendInfoList_All._tab._consoleFriendTab == PaGlobal_FriendInfoList_All._currentTab then
    PaGlobal_FriendInfoList_All:updateFriendListForConsole()
  else
    PaGlobal_FriendInfoList_All:updateFriendList()
  end
end
function FromClient_FriendInfoList_All_CantFindFriendForXbox()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_TEXT_TITLE"),
    content = PAGetString(Defines.StringSheet_SymbolNo, "eErrCantFindFriendForXbox"),
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_FriendInfoList_All_ResponseFriendResult(fromUserName, isAccept)
  local messageStr = ""
  local isAlReadyXboxFriend = ToClient_isAlreadyXboxFriend()
  if true == isAccept then
    if true == isAlReadyXboxFriend then
      messageStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_XBOX_FRIEND_REQUEST_ACCEPT", "characterName", fromUserName)
      local messageBoxDataXX = {
        title = PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_TEXT_TITLE"),
        content = messageStr,
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxDataXX)
      return
    else
      local XboxFriendAsyncCall = function()
        ToClient_addXboxFriendAsync()
      end
      messageStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_XBOX_FRIEND_REQUEST_ACCEPT_AND_XBOX_FRIEND", "characterName", fromUserName)
      local messageBoxDataXX = {
        title = PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_TEXT_TITLE"),
        content = messageStr,
        functionYes = XboxFriendAsyncCall,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxDataXX)
      return
    end
  else
    messageStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_XBOX_FRIEND_REQUEST_REFUSE", "characterName", fromUserName)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_TEXT_TITLE"),
    content = messageStr,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_FriendRegionChangeNotify()
  if nil == Panel_FriendInfoList_All then
    return
  end
  if false == Panel_FriendInfoList_All:GetShow() then
    return
  end
  PaGlobal_FriendInfoList_All._listMoveIndex = PaGlobal_FriendInfoList_All._ui.list2_Friend:getCurrenttoIndex()
  PaGlobal_FriendInfoList_All:updateTab()
end
function FromClient_FriendInfoListOpenMessangerInFriendList(messangerId)
  local friendUserNo = ToClient_GetMessengerInFriendUserNo(messangerId)
  if toInt64(0, 0) == friendUserNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoStaticStatusInvalidValue"))
    return
  end
  PaGlobal_FriendInfoList_All._ui.stc_Chat_TitleBar:SetShow(true)
  PaGlobal_FriendInfoList_All._ui.Frame_Chat:SetShow(true)
  PaGlobal_FriendInfoList_All._ui.stc_EditGroup:SetShow(true)
  PaGlobal_FriendInfoList_All._ui.stc_Emoticon_BG:SetShow(false)
  PaGlobal_FriendInfoList_All._ui.list2_Friend:SetShow(false)
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_FriendInfoList_All._ui.stc_KeyX:SetShow(true)
    Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_FriendInfoList_All_sendMessageByKey( )")
  end
  PaGlobal_FriendInfoList_All._ui.btn_Drop:addInputEvent("Mouse_LUp", "FromClient_FriendInfoListOpenMessanger(" .. tostring(messangerId) .. "," .. tostring(friendUserNo) .. " )")
  PaGlobal_FriendInfoList_All._ui.btn_Drop:addInputEvent("Mouse_On", "HandleEventOnOut_FriendInfoList_All_ShowSimpleTooltip(true" .. "," .. "0" .. " )")
  PaGlobal_FriendInfoList_All._ui.btn_Drop:addInputEvent("Mouse_Out", "HandleEventOnOut_FriendInfoList_All_ShowSimpleTooltip(false" .. "," .. "0" .. " )")
  PaGlobal_FriendInfoList_All._ui.btn_Alarm:addInputEvent("Mouse_LUp", "HandleEventLUp_FriendInfoList_All_MessangerAlarmToggle(" .. tostring(messangerId) .. " )")
  PaGlobal_FriendInfoList_All._ui.stc_Edit:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_STCTXT_EDIT_DESC"))
  PaGlobal_FriendInfoList_All:messangerOpen(messangerId, friendUserNo)
end
function PaGlobal_FriendInfoList_All_ShowAni()
  audioPostEvent_SystemUi(1, 0)
  UIAni.AlphaAnimation(1, Panel_FriendInfoList_All, 0, 0.15)
end
function PaGlobal_FriendInfoList_All_HideAni()
  audioPostEvent_SystemUi(1, 1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_FriendInfoList_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_FriendInfoList_All_SetStartPos()
  Panel_FriendInfoList_All:ComputePos()
  PaGlobal_FriendInfoList_All._panelOpenPosX = Panel_FriendInfoList_All:GetPosX() + Panel_FriendInfoList_All:GetSizeX()
  PaGlobal_FriendInfoList_All._panelOpenPosY = Panel_FriendInfoList_All:GetPosY()
end
function FromClient_FriendInfoList_All_OnScreenResize()
  PaGlobal_FriendInfoList_All_SetStartPos()
  PaGlobal_FriendRequest_All_SetBasicPos()
end
function PaGlobal_FriendInfoList_All_ScaleResizingSetPosition()
  Panel_FriendInfoList_All:SetPosX(PaGlobal_FriendInfoList_All._panelOpenPosX - Panel_FriendInfoList_All:GetSizeX())
  Panel_FriendInfoList_All:SetPosY(PaGlobal_FriendInfoList_All._panelOpenPosY)
end
function PaGlobal_FriendInfoList_All_SetRequestNew()
  if false == Panel_FriendInfoList_All:GetShow() then
    return
  end
  local friendCount = RequestFriends_getAddFriendCount()
  if friendCount > 0 then
    PaGlobal_FriendInfoList_All._ui.txt_RequestNew:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.txt_RequestNew:SetText(tostring(friendCount))
  else
    PaGlobal_FriendInfoList_All._ui.txt_RequestNew:SetShow(false)
  end
end
function HandleEventLDown_FriendInfoList_All_ScaleResizeStart()
  PaGlobal_FriendInfoList_All._panelOpenPosX = Panel_FriendInfoList_All:GetPosX() + Panel_FriendInfoList_All:GetSizeX()
  PaGlobal_FriendInfoList_All._panelOpenPosY = Panel_FriendInfoList_All:GetPosY()
  PaGlobal_FriendInfoList_All:hidePopupMenu()
  UI.PanelDynamicSacle_ResizeStart(Panel_FriendInfoList_All)
  PaGlobal_FriendInfoList_All._listMoveIndex = PaGlobal_FriendInfoList_All._ui.list2_Friend:getCurrenttoIndex()
end
function HandleEventLPress_FriendInfoList_All_ScaleResizing()
  UI.PanelDynamicSacle_ResizePressing_Reverse(Panel_FriendInfoList_All)
  PaGlobal_FriendInfoList_All:updateTab()
  PaGlobal_FriendInfoList_All._ui.list2_Friend:requestUpdateVisible()
  PaGlobal_FriendInfoList_All_ScaleResizingSetPosition()
  PaGlobalFunc_FriendInfoList_All_Resize()
end
function HandleEventLUp_FriendInfoList_All_ScaleResizeEnd()
  UI.PanelDynamicSacle_ResizeEnd(Panel_FriendInfoList_All)
end
function HandleEventOnOut_FriendInfoList_All_ShowSimpleTooltip(isShow, tipType)
  if false == isShow or nil == tipType then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FRIENDS_CHAT_DIVISION")
    desc = ""
    control = PaGlobal_FriendInfoList_All._ui.btn_Drop
  end
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_FriendInfoList_All_MessangerAlarmToggle(messangerId)
  local messangerIdstr = tostring(messangerId)
  if true == PaGlobal_FriendInfoList_All._ui.btn_Alarm:IsCheck() then
    ToClient_UpdateMessengerAlarm(tonumber64(messangerIdstr), __eMessengerTypeFriend, false)
  else
    ToClient_UpdateMessengerAlarm(tonumber64(messangerIdstr), __eMessengerTypeFriend, true)
  end
end
function PaGlobalFunc_FriendInfoList_All_RightCheck(eRightType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  local function OriginalCheck()
    local selfActorKeyRaw = selfPlayer:getActorKey()
    local isGuildMaster = selfPlayer:isSpecialGuildMember(selfActorKeyRaw)
    return isGuildMaster
  end
  if false == _ContentsGroup_GuildRightInfo then
    return OriginalCheck()
  end
  local isDefineRightType = ToClient_IsDefineGuildRightType(eRightType)
  if false == isDefineRightType then
    return OriginalCheck()
  end
  return ToClient_IsCheckGuildRightType(eRightType)
end
function PaGlobalFunc_FriendInfoList_All_Resize()
  if nil == PaGlobal_FriendInfoList_All._currentOpenMessangerId then
    return
  end
  local panel = PaGlobal_FriendInfoList_All._ui.Frame_Chat
  if nil == panel then
    return
  end
  local messangerIdstr = tostring(PaGlobal_FriendInfoList_All._currentOpenMessangerId)
  local messangerId_s64 = tonumber64(messangerIdstr)
  local messengerInfo = ToClient_GetMessengerInfo(messangerId_s64)
  if nil == messengerInfo then
    return
  end
  local friendUserNo = ToClient_GetMessengerInFriendUserNo(messangerId_s64)
  if toInt64(0, 0) == friendUserNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoStaticStatusInvalidValue"))
    return
  end
  local friendInfo = ToClient_getFreindInfoByUserNo(friendUserNo)
  if nil == friendInfo then
    return
  end
  local friendClass = friendInfo:getClassType()
  local isOnline = friendInfo:isOnline()
  local message = messengerInfo:beginMessage()
  for index = 0, PaGlobal_FriendInfoList_All._messageCount - 1 do
    if nil ~= message then
      local msg = message:getContent()
      local msgTime = message:getTime()
      local isMe = message.isMe
      PaGlobal_FriendInfoList_All:resizeMessageUIDrag(index, isMe, msg)
      message = messengerInfo:nextMessage()
    end
  end
  PaGlobal_FriendInfoList_All._ui.FrameContent:SetSize(0, 0)
  PaGlobal_FriendInfoList_All._ui.FrameScroll:SetControlBottom()
  PaGlobal_FriendInfoList_All._ui.Frame_Chat:UpdateContentScroll()
  PaGlobal_FriendInfoList_All._ui.Frame_Chat:UpdateContentPos()
  PaGlobal_FriendInfoList_All._ui.FrameScroll:GetControlButton():SetPosX(0)
end
function PaGlobalFunc_FriendInfoList_All_SetFocusEdit()
  SetFocusEdit(PaGlobal_FriendInfoList_All._ui.stc_Edit)
  PaGlobal_FriendInfoList_All._ui.stc_Edit:SetEditText("")
end
function PaGlobalFunc_FriendInfoList_All_KillFocusEdit()
  ClearFocusEdit()
  CheckChattingInput()
end
function PaGlobalFunc_FriendInfoList_All_KillFocusMessangerByKey()
  FriendMessanger_KillFocusEdit()
end
function PaGlobalFunc_FriendInfoList_All_sendMessageByKey()
  local messangerIdstr = tostring(PaGlobal_FriendInfoList_All._currentOpenMessangerId)
  PaGlobalFunc_FriendInfoList_All_sendMessage(messangerIdstr)
end
function PaGlobalFunc_FriendInfoList_All_sendMessage(messangerIdstr)
  local messangerId = tonumber64(messangerIdstr)
  local friendUserNo = ToClient_GetMessengerInFriendUserNo(messangerId)
  if toInt64(0, 0) == friendUserNo then
    return
  end
  ToClient_SetSenderMessengerNo(messangerId)
  ToClient_SetSenderMessengerType(__eMessengerTypeFriend)
  chatting_sendMessageByUserNo(friendUserNo, PaGlobal_FriendInfoList_All._ui.stc_Edit:GetEditText(), CppEnums.ChatType.Messenger)
  PaGlobal_FriendInfoList_All._ui.stc_Edit:SetEditText("", true)
end
function PaGlobalFunc_FriendInfoList_All_MessageCountUpdate(messangerId, isforce)
  if nil == isforce then
    isforce = false
  end
  local isMessangerOpen = FriendMessanger_IsOpenMessanger(messangerId)
  local isFriendListMessangerOpen = PaGlobalFunc_FriendInfoList_All_IsFriendInfoMessangerOpen(messangerId)
  if true == isMessangerOpen or true == isFriendListMessangerOpen or true == isforce then
    local messengerInfo = ToClient_GetMessengerInfo(messangerId)
    if nil == messengerInfo then
      return
    end
    local messageCount = messengerInfo:getMessageCount()
    messengerInfo:setReadMessageCount(messageCount)
  end
end
function PaGlobalFunc_FriendInfoList_All_IsFriendInfoMessangerOpen(messangerId)
  if nil ~= PaGlobal_FriendInfoList_All._currentOpenMessangerId and PaGlobal_FriendInfoList_All._currentOpenMessangerId == messangerId then
    return true
  end
  return false
end
function PaGlobalFunc_FriendInfoList_All_FriendMessangerUpdate(messangerId)
  if false == Panel_FriendInfoList_All:GetShow() then
    return
  end
  if nil == PaGlobal_FriendInfoList_All._currentOpenMessangerId then
    PaGlobal_FriendInfoList_All:updateFriendList()
  end
  if PaGlobal_FriendInfoList_All._currentOpenMessangerId ~= messangerId then
    return
  end
  local friendUserNo = ToClient_GetMessengerInFriendUserNo(messangerId)
  if toInt64(0, 0) == friendUserNo then
    return
  end
  PaGlobal_FriendInfoList_All:messangerOpen(messangerId, friendUserNo)
end
function FromClient_FriendInfoList_All_FriendMessangerUpdate(messangerId, isForce)
  PaGlobalFunc_FriendInfoList_All_MessageCountUpdate(messangerId, isForce)
  FromClient_FriendMessangerUpdate(messangerId)
  PaGlobalFunc_FriendInfoList_All_FriendMessangerUpdate(messangerId)
  FromClient_FriendMessangerFloatingUpdate(messangerId)
end
function FromClient_FriendMessangerAlarm(messangerId, isOn)
  if nil ~= PaGlobal_FriendInfoList_All._currentOpenMessangerId and PaGlobal_FriendInfoList_All._currentOpenMessangerId == messangerId then
    PaGlobal_FriendInfoList_All._ui.btn_Alarm:SetCheck(not isOn)
  end
  FromClient_AlarmToggle(messangerId, isOn)
end
