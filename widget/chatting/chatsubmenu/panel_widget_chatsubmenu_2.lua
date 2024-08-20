function HandleEventOn_ChattingSubMenu()
  if nil ~= currentPanelIndex then
    Chatting_PanelTransparency(currentPanelIndex, false)
  end
end
function HandleEventLUp_ChatSubMenuSendWhisper()
  if nil ~= PaGlobal_ChatSubMenu._clickedName and nil ~= PaGlobal_ChatSubMenu._clickedUserNickName then
    local nameType = ToClient_getChatNameType()
    if nameType == 0 then
      FGlobal_ChattingInput_ShowWhisper(PaGlobal_ChatSubMenu._clickedName)
    elseif nameType == 1 then
      FGlobal_ChattingInput_ShowWhisper(PaGlobal_ChatSubMenu._clickedUserNickName)
    end
    PaGlobal_ChatSubMenu:SetShow(false)
    PaGlobal_ChatSubMenuSetClickedInfoInit()
  end
end
function HandleEventLUp_ChatSubMenuAddFriend()
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
    return
  end
  if nil ~= PaGlobal_ChatSubMenu._clickedName and nil ~= PaGlobal_ChatSubMenu._clickedUserNickName then
    local nameType = ToClient_getChatNameType()
    if nameType == 0 then
      requestFriendList_addFriend(PaGlobal_ChatSubMenu._clickedName, true)
    elseif nameType == 1 then
      requestFriendList_addFriend(PaGlobal_ChatSubMenu._clickedUserNickName, false)
    end
    PaGlobal_ChatSubMenu:SetShow(false)
    PaGlobal_ChatSubMenuSetClickedInfoInit()
  end
end
function HandleEventLUp_ChatSubMenuInviteParty()
  if true == ToClient_IsInstanceRandomMatching() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RANDOMMATCH_FAILACK"))
    return
  end
  if nil ~= PaGlobal_ChatSubMenu._currentPoolIndex and nil ~= PaGlobal_ChatSubMenu._clickedMessageIndex then
    ToClient_RequestInvitePartyByChatSubMenu(PaGlobal_ChatSubMenu._currentPoolIndex, PaGlobal_ChatSubMenu._clickedName)
    PaGlobal_ChatSubMenu:SetShow(false)
    local isSelfPlayerPlayingPvPMatch = getSelfPlayer():isDefinedPvPMatch()
    if false == isSelfPlayerPlayingPvPMatch then
      local nameType = ToClient_getChatNameType()
      local selectName
      if nameType == 0 then
        selectName = PaGlobal_ChatSubMenu._clickedName
      elseif nameType == 1 then
        selectName = PaGlobal_ChatSubMenu._clickedUserNickName
      end
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_INVITE", "targetName", selectName))
    end
    PaGlobal_ChatSubMenuSetClickedInfoInit()
  end
end
function HandleEventLUp_ChatSubMenuInviteLargeParty()
  if nil ~= PaGlobal_ChatSubMenu._currentPoolIndex and nil ~= PaGlobal_ChatSubMenu._clickedMessageIndex then
    ToClient_InviteLargePartyByCharacterName(PaGlobal_ChatSubMenu._clickedName)
    PaGlobal_ChatSubMenu:SetShow(false)
    local isSelfPlayerPlayingPvPMatch = getSelfPlayer():isDefinedPvPMatch()
    if false == isSelfPlayerPlayingPvPMatch then
      local nameType = ToClient_getChatNameType()
      local selectName
      if nameType == 0 then
        selectName = PaGlobal_ChatSubMenu._clickedName
      elseif nameType == 1 then
        selectName = PaGlobal_ChatSubMenu._clickedUserNickName
      end
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_LARGEPARTYINVITE", "targetName", selectName))
    end
    PaGlobal_ChatSubMenuSetClickedInfoInit()
  end
end
function HandleEventLUp_ChatSubMenuInviteGuild()
  if nil ~= PaGlobal_ChatSubMenu._currentPoolIndex and nil ~= PaGlobal_ChatSubMenu._clickedMessageIndex then
    if true == _ContentsGroup_NewGuildNone then
      local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
      if nil == myGuildInfo then
        return
      end
      local guildGrade = myGuildInfo:getGuildGrade()
      if 0 == guildGrade then
        ToClient_RequestInviteGuildByChatSubMenu(PaGlobal_ChatSubMenu._currentPoolIndex, PaGlobal_ChatSubMenu._clickedName)
      else
        ToClient_RequestSimpleInviteGuildByChatSubMenu(PaGlobal_ChatSubMenu._clickedUserNickName, PaGlobal_ChatSubMenu._clickedName)
      end
    else
      ToClient_RequestInviteGuildByChatSubMenu(PaGlobal_ChatSubMenu._currentPoolIndex, PaGlobal_ChatSubMenu._clickedName)
    end
    PaGlobal_ChatSubMenu:SetShow(false)
  end
end
function HandleEventLUp_ChatSubMenuInviteCompetition()
  if nil ~= PaGlobal_ChatSubMenu._currentPoolIndex and nil ~= PaGlobal_ChatSubMenu._clickedMessageIndex then
    ToClient_RequestInviteCompetitionByChatSubMenu(PaGlobal_ChatSubMenu._clickedName, false)
    PaGlobal_ChatSubMenu:SetShow(false)
  end
end
function HandleEventLUp_ChatSubMenuInviteVolunteer()
  if nil ~= PaGlobal_ChatSubMenu._currentPoolIndex and nil ~= PaGlobal_ChatSubMenu._clickedMessageIndex then
    FGlobal_AgreementVolunteer_Master_Open(PaGlobal_ChatSubMenu._clickedName)
    PaGlobal_ChatSubMenu:SetShow(false)
  end
end
function HandleEventLUp_ChatSubMenuClose()
  PaGlobal_ChatSubMenu:SetShow(false)
end
function HandleEventLUp_ChatSubMenuBlock()
  if nil ~= PaGlobal_ChatSubMenu._currentPoolIndex and nil ~= PaGlobal_ChatSubMenu._clickedMessageIndex then
    local chatBlock = function()
      ToClient_RequestBlockCharacter(PaGlobal_ChatSubMenu._currentPoolIndex, PaGlobal_ChatSubMenu._clickedUserNickName)
      PaGlobal_ChatSubMenu:SetShow(false)
      PaGlobal_ChatSubMenuSetClickedInfoInit()
    end
    local messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHNATNEW_INTERCEPTION_MEMO", "clickedName", PaGlobal_ChatSubMenu._clickedUserNickName)
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_CHNATNEW_INTERCEPTION_TITLE"),
      content = messageContent,
      functionYes = chatBlock,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function HandleEventLUp_ChatSubMenuReportGoldSeller()
  local selfProxy = getSelfPlayer():get()
  local inventory = selfProxy:getCashInventory()
  local hasItem = inventory:getItemCount_s64(ItemEnchantKey(65208, 0))
  if toInt64(0, 0) == hasItem then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_NO_HAVE_ITEM"))
    return
  end
  local limitLevel = 20
  if limitLevel > getSelfPlayer():get():getLevel() then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHATNEW_GOLDSELLERITEM_LIMITLEVEL", "limitLevel", limitLevel))
    return
  end
  if nil ~= PaGlobal_ChatSubMenu._currentPoolIndex and nil ~= PaGlobal_ChatSubMenu._clickedMessageIndex and nil ~= PaGlobal_ChatSubMenu._clickedMsg then
    FGlobal_reportSeller_Open(PaGlobal_ChatSubMenu._clickedName, PaGlobal_ChatSubMenu._clickedMsg)
  end
end
function HandleEventLUp_ChatSubMenuBlockVote()
  if nil ~= PaGlobal_ChatSubMenu._currentPoolIndex and nil ~= PaGlobal_ChatSubMenu._clickedMessageIndex then
    local chatBlockVote = function()
      ToClient_RequestBlockChatByUser(PaGlobal_ChatSubMenu._clickedName, PaGlobal_ChatSubMenu._clickedUserNickName)
      PaGlobal_ChatSubMenu:SetShow(false)
      PaGlobal_ChatSubMenuSetClickedInfoInit()
    end
    local nameType = ToClient_getChatNameType()
    local selectName
    if nameType == 0 then
      selectName = PaGlobal_ChatSubMenu._clickedName
    elseif nameType == 1 then
      selectName = PaGlobal_ChatSubMenu._clickedUserNickName
    end
    local messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHATNEW_CHAT_BAN_MEMO", "clickedName", selectName)
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_CHNATNEW_CHAT_BAN_TITLE"),
      content = messageContent,
      functionYes = chatBlockVote,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function HandleEventLUp_Recommand()
  local senderUserNo = PaGlobal_ChatSubMenu._senderUserNo
  local chatRoomNo = PaGlobal_ChatSubMenu._chatRoomNo
  UI.ASSERT_NAME(nil ~= senderUserNo, "PaGlobal_ChatSubMenuSetClickedInfo senderUserNo nil", "\234\185\128\236\167\128\237\152\129")
  UI.ASSERT_NAME(nil ~= chatRoomNo, "PaGlobal_ChatSubMenuSetClickedInfo chatRoomNo nil", "\234\185\128\236\167\128\237\152\129")
  PaGlobal_ChatSubMenu:SetShow(false)
  PaGlobal_ChatSubMenuSetClickedInfoInit()
  local selfUserNo = getSelfPlayer():get():getUserNo()
  if nil == selfUserNo then
    return
  end
  if selfUserNo == senderUserNo then
    return
  end
  ToClient_GiveThumbsUp(senderUserNo, chatRoomNo)
end
function FromClient_requestInviteGuildByChatSubMenu(actorKeyRaw)
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local guildGrade = myGuildInfo:getGuildGrade()
  if 0 == guildGrade then
    toClient_RequestInviteGuild(PaGlobal_ChatSubMenu._clickedName, 0, 0, 0)
  else
    FGlobal_AgreementGuild_Master_Open_ForJoin(actorKeyRaw, PaGlobal_ChatSubMenu._clickedName, 0)
  end
  PaGlobal_ChatSubMenuSetClickedInfoInit()
end
function FromClient_ResetThumbsUpVoteCount()
  if true == PaGlobal_ChatSubMenu._ui._buttonRecommand:GetShow() then
    PaGlobal_ChatSubMenu._ui._buttonRecommand:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_THUMBSUP_VOTECOUNT", "currentVoteCount", ToClient_GetThumbsUpVoteCount(), "maxVoteCount", ToClient_getMaxThumbsUpVoteCount()))
  end
end
registerEvent("FromClient_requestInviteGuildByChatSubMenu", "FromClient_requestInviteGuildByChatSubMenu")
registerEvent("FromClient_ResetThumbsUpVoteCount", "FromClient_ResetThumbsUpVoteCount")
function PaGlobalFunc_ChatSubMenu_RightCheck(eRightType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  local OriginalCheck = function()
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
    return true == isGuildMaster or true == isGuildSubMaster
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
