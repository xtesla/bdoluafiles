function PaGlobalFunc_ChannelChat_Open()
  PaGlobal_ChannelChat:prepareOpen()
end
function PaGlobalFunc_ChannelChat_Close()
  PaGlobal_ChannelChat:prepareClose()
end
function HandleEventLUp_Select_ChannelChat(idx)
  local self = PaGlobal_ChannelChat
  if false == self._ui_pc.btn_confirm:IsEnable() then
    local enable = true
    self._ui_pc.btn_confirm:SetMonoTone(not enable)
    self._ui_pc.btn_confirm:SetIgnore(not enable)
    self._ui_pc.btn_confirm:SetEnable(enable)
  end
  self._selectIndex = idx
  local myChannelChatRoomInfo = ToClient_getMyChannelChatRoom(__eChannelChatRoomType_System)
  local conevertRoomNo = Int64toInt32(myChannelChatRoomInfo._chatRoomNo)
  local currentRoomIndex = self._roomNoIndexTable[conevertRoomNo]
  if currentRoomIndex ~= self._selectIndex then
    enable = true
    self._ui_pc.btn_confirm:SetMonoTone(not enable)
    self._ui_pc.btn_confirm:SetIgnore(not enable)
    self._ui_pc.btn_confirm:SetEnable(enable)
  else
    enable = false
    self._ui_pc.btn_confirm:SetMonoTone(not enable)
    self._ui_pc.btn_confirm:SetIgnore(not enable)
    self._ui_pc.btn_confirm:SetEnable(enable)
  end
  if true == _ContentsGroup_UsePadSnapping then
    HandleEventLUp_ChannelChat_Confirm()
  end
end
function HandleEventLUp_ChannelChat_Confirm()
  local chatRoomInfo = ToClient_getChannelChatingRoomIndex(PaGlobal_ChannelChat._selectIndex)
  if nil == chatRoomInfo then
    return
  end
  local chatRoomName = chatRoomInfo:getRoomName()
  if nil == chatRoomName then
    return
  end
  local CancleConfirm = function()
    PaGlobal_ChannelChat._ui.btn_title[PaGlobal_ChannelChat._selectIndex]:SetCheck(false)
    PaGlobal_ChannelChat._ui.btn_radio[PaGlobal_ChannelChat._selectIndex]:SetCheck(false)
    local chatRoomInfo = ToClient_getMyChannelChatRoom(__eChannelChatRoomType_System)
    if nil == chatRoomInfo then
      return
    end
    local conevertRoomNo = Int64toInt32(chatRoomInfo._chatRoomNo)
    local currentIndex = PaGlobal_ChannelChat._roomNoIndexTable[conevertRoomNo]
    if nil ~= currentIndex then
      PaGlobal_ChannelChat._ui.btn_title[currentIndex]:SetCheck(true)
      PaGlobal_ChannelChat._ui.btn_radio[currentIndex]:SetCheck(true)
    end
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALERT_CHANNELTCHAT_ENTER", "chatRoomName", chatRoomName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = messageBoxMemo,
    functionYes = PaGlobalFunc_ChannelChat_Confirm,
    functionNo = CancleConfirm,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_ChannelChat_Confirm()
  local selectedIndex = PaGlobal_ChannelChat._selectIndex
  local chatRoomNo = ToClient_getChannelChatRoomNo(selectedIndex)
  ToClient_JoinChannelChatRoomReq(chatRoomNo)
end
function HandleEventLUp_ChannelChat_Exit()
  local chatRoomInfo = ToClient_getMyChannelChatRoom(__eChannelChatRoomType_System)
  if nil == chatRoomInfo then
    return
  end
  local chatRoomName = chatRoomInfo:getRoomName()
  if nil == chatRoomName then
    return
  end
  local chatRoomNo = Int64toInt32(chatRoomInfo._chatRoomNo)
  if nil == PaGlobal_ChannelChat._roomNoIndexTable[chatRoomNo] then
    return
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALERT_CHANNELTCHAT_EXIT", "chatRoomName", chatRoomName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = messageBoxMemo,
    functionYes = PaGlobalFunc_ChannelChat_Exit,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_ChannelChat_Exit()
  local self = PaGlobal_ChannelChat
  local chatRoomInfo = ToClient_getMyChannelChatRoom(__eChannelChatRoomType_System)
  if nil == chatRoomInfo then
    return
  end
  ToClient_LeaveChannelChatRoomReq(chatRoomInfo._chatRoomNo)
  if true == _ContentsGroup_UsePadSnapping then
    self._selectIndex = -1
    for index = 0, self._serverListCount - 1 do
      self._ui.btn_title[index]:SetCheck(false)
      self._ui.btn_radio[index]:SetCheck(false)
    end
  end
end
function HandleEventOnOut_ChannelChat_DescTooltip(index)
  local control = PaGlobal_ChannelChat._ui.stc_desc[index]
  if nil == control then
    return
  end
  if true == PaGlobal_ChannelChat._isConsole then
    local button = PaGlobal_ChannelChat._ui.btn_title[index]
    if nil == button then
      return
    end
    local pos = {}
    pos.x = button:GetParentPosX() + button:GetSizeX()
    pos.y = button:GetParentPosY()
    TooltipSimple_ShowSetSetPos_Console(pos, "", control:GetText())
  else
    TooltipSimple_Show(control, "", control:GetText())
  end
end
function FromClient_ChannelChatList(isClear)
  if true == isClear then
  end
  local maxShowCount = 0
  local self = PaGlobal_ChannelChat
  local channelChatRoomCount = ToClient_getChannelChaingtRoomCount()
  if channelChatRoomCount < PaGlobal_ChannelChat._maxListCount then
    self._serverListCount = channelChatRoomCount
  else
    self._serverListCount = PaGlobal_ChannelChat._maxListCount
  end
  self._roomNoIndexTable = {}
  self._selectIndex = -1
  local currentRoomNo = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eChannelChat)
  currentRoomNo = Int64toInt32(currentRoomNo)
  for index = 0, self._serverListCount - 1 do
    local ChannelChatRoomInfo = ToClient_getChannelChatingRoomIndex(index)
    if nil ~= ChannelChatRoomInfo then
      local roomNo = Int64toInt32(ChannelChatRoomInfo._chatRoomNo)
      local roomName = ChannelChatRoomInfo:getRoomName()
      local description = ChannelChatRoomInfo:getDescription()
      if currentRoomNo == roomNo then
        self._selectIndex = index
      end
      self._roomNoIndexTable[roomNo] = index
      self._ui.stc_title[index]:SetText(roomName)
      self._ui.stc_desc[index]:SetTextMode(__eTextMode_Limit_AutoWrap)
      self._ui.stc_desc[index]:setLineCountByLimitAutoWrap(3)
      self._ui.stc_desc[index]:SetText(description)
      if true == self._ui.stc_desc[index]:IsLimitText() then
        if true == self._isConsole then
          self._ui.stc_desc[index]:SetIgnore(true)
          self._ui.btn_title[index]:addInputEvent("Mouse_On", "HandleEventOnOut_ChannelChat_DescTooltip(" .. index .. ")")
          self._ui.btn_title[index]:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
        else
          self._ui.stc_desc[index]:SetIgnore(false)
          self._ui.stc_desc[index]:addInputEvent("Mouse_On", "HandleEventOnOut_ChannelChat_DescTooltip(" .. index .. ")")
          self._ui.stc_desc[index]:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
        end
      else
        self._ui.stc_desc[index]:SetIgnore(true)
      end
      if index >= self._startItemIndex and index < self._startItemIndex + self._config._slotCount then
        self._ui.btn_title[index]:SetShow(true)
      else
        self._ui.btn_title[index]:SetShow(false)
      end
      local textureHashKey = ChannelChatRoomInfo:getTextureHashKey()
      PaGlobal_ChannelChat:setTextureControl(self._ui.btn_bg[index], textureHashKey)
    else
      self._ui.btn_title[index]:SetShow(false)
    end
  end
  for index = 0, self._serverListCount - 1 do
    self._ui.btn_title[index]:SetCheck(false)
    self._ui.btn_radio[index]:SetCheck(false)
  end
  self._startItemIndex = 0
  self:Scroll(true)
  local enable = true
  if -1 ~= self._selectIndex then
    self._ui.btn_title[self._selectIndex]:SetCheck(true)
    self._ui.btn_radio[self._selectIndex]:SetCheck(true)
    self._ui_pc.btn_confirm:SetMonoTone(enable)
    self._ui_pc.btn_confirm:SetIgnore(enable)
    self._ui_pc.btn_confirm:SetEnable(not enable)
  else
    enable = false
    self._ui_pc.btn_confirm:SetMonoTone(not enable)
    self._ui_pc.btn_confirm:SetIgnore(not enable)
    self._ui_pc.btn_confirm:SetEnable(enable)
  end
  local myChannelChatRoomInfo = ToClient_getMyChannelChatRoom(__eChannelChatRoomType_System)
end
function PaGlobalFunc_GetChannelTextureIndex(idx)
  if idx < 0 or idx >= PaGlobal_ChannelChat._serverListCount then
    return -1
  end
  return PaGlobal_ChannelChat.channelIndexToTextureIndex[idx]
end
function FromClient_JoinChannelChatRoom(chatRoomInfo)
  if nil == chatRoomInfo then
    return
  end
  local chatRoomName = chatRoomInfo:getRoomName()
  local chatRoomNo = Int64toInt32(chatRoomInfo._chatRoomNo)
  PaGlobal_ChannelChat:setLuaCache(chatRoomNo)
  local chatRoomIndex = PaGlobal_ChannelChat._roomNoIndexTable[chatRoomNo]
  if nil ~= chatRoomIndex then
    for index = 0, PaGlobal_ChannelChat._serverListCount - 1 do
      PaGlobal_ChannelChat._ui.btn_radio[index]:SetCheck(false)
    end
    PaGlobal_ChannelChat._ui.btn_radio[chatRoomIndex]:SetCheck(true)
  end
  if false == _ContentsGroup_RenewUI then
    ChatInput_UpdatePermission()
  else
    PaGlobalFunc_ChattingInfo_UpdatePermission()
  end
  enable = false
  PaGlobal_ChannelChat._ui_pc.btn_confirm:SetMonoTone(not enable)
  PaGlobal_ChannelChat._ui_pc.btn_confirm:SetIgnore(not enable)
  PaGlobal_ChannelChat._ui_pc.btn_confirm:SetEnable(enable)
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENTER_CHANNELCHAT", "chatRoomName", chatRoomName))
end
function FromClient_LeaveChannelChatRoom(chatRoomInfo)
  if nil == chatRoomInfo then
    return
  end
  local chatRoomName = chatRoomInfo:getRoomName()
  local undefinedChatRoomNo = 0
  PaGlobal_ChannelChat:setLuaCache(undefinedChatRoomNo)
  if false == _ContentsGroup_RenewUI then
    ChatInput_UpdatePermission()
  else
    PaGlobalFunc_ChattingInfo_UpdatePermission()
  end
  enable = true
  PaGlobal_ChannelChat._ui_pc.btn_confirm:SetMonoTone(not enable)
  PaGlobal_ChannelChat._ui_pc.btn_confirm:SetIgnore(not enable)
  PaGlobal_ChannelChat._ui_pc.btn_confirm:SetEnable(enable)
  for index = 0, PaGlobal_ChannelChat._serverListCount - 1 do
    PaGlobal_ChannelChat._ui.btn_radio[index]:SetCheck(false)
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXIT_CHANNELCHAT", "chatRoomName", chatRoomName))
end
function FromClient_LogoutVoiceChatServer()
  PaGlobal_ChannelChat:clearAll()
end
function FromClient_LoginVoiceChatServer()
  if true == PaGlobal_ChannelChat._isFirstLogin then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
    local UIManagerWrapper = ToClient_getGameUIManagerWrapper()
    if nil == UIManagerWrapper then
      return
    end
    local isExistCacheData = UIManagerWrapper:hasLuaCacheDataList(__eChannelChat)
    local defaultChatRoomNo = PaGlobal_ChannelChat._defaultChatRoomNo
    local NewbieChatRoomNo = 1
    if false == isExistCacheData then
      if PaGlobal_ChannelChat._userType.Return == userType or PaGlobal_ChannelChat._userType.Newbie == userType then
        defaultChatRoomNo = NewbieChatRoomNo
      end
      PaGlobal_ChannelChat:setLuaCache(defaultChatRoomNo)
    else
      local currentRoomNo = UIManagerWrapper:getLuaCacheDataListNumber(__eChannelChat)
      if nil == currentRoomNo or currentRoomNo <= 0 or currentRoomNo > PaGlobal_ChannelChat._lastRoomNo then
        currentRoomNo = PaGlobal_ChannelChat._defaultChatRoomNo
        PaGlobal_ChannelChat:setLuaCache(currentRoomNo)
      end
    end
    PaGlobal_ChannelChat._isFirstLogin = false
    ToClient_ChannelChattingRoomList()
    ToClient_JoinChannelChatRoomReq(UIManagerWrapper:getLuaCacheDataListNumber(__eChannelChat))
  end
  if true == Panel_Widget_ChannelChat_Loading:GetShow() then
    PaGlobalFunc_ChannelChat_Loading_Close()
    PaGlobalFunc_ChannelChat_Open()
  end
end
function PaGlobal_ChannelChat:setLuaCache(RoomNo)
  local UIManagerWrapper = ToClient_getGameUIManagerWrapper()
  if nil == UIManagerWrapper then
    return
  end
  UIManagerWrapper:setLuaCacheDataListNumber(__eChannelChat, RoomNo, CppEnums.VariableStorageType.eVariableStorageType_User)
  if true == _ContentsGroup_RenewUI then
    ToClient_saveUserCache()
  end
end
