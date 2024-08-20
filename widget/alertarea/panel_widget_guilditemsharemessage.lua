PaGlobal_GuildItemShare_Message = {
  _ui = {
    _stc_bg = nil,
    _stc_slotIconBg = nil,
    _txt_ItemName = nil,
    _txt_desc = nil,
    _prog2_timer = nil,
    _btn_Confirm = nil,
    _btn_Cancel = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = true,
    createEnchant = true,
    createEnduranceIcon = true,
    createOriginalForDuel = true
  },
  _itemNo = nil,
  _itemEnchantKey = nil,
  _houseHoldNo = nil,
  _exprationTime = 0,
  _userNo = nil,
  _currentTime = 0,
  _closeTime = 15,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildItemShare_Message_Init")
function FromClient_GuildItemShare_Message_Init()
  PaGlobal_GuildItemShare_Message:initialize()
end
function PaGlobal_GuildItemShare_Message:initialize()
  if true == self._initialize or nil == Panel_GuildItemShare_Message then
    return
  end
  self._ui._stc_bg = UI.getChildControl(Panel_GuildItemShare_Message, "Static_Bg")
  self._ui._stc_slotIconBg = UI.getChildControl(self._ui._stc_bg, "Static_Slot_IconBG")
  self._ui._txt_ItemName = UI.getChildControl(self._ui._stc_bg, "StaticText_ItemName")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_bg, "StaticText_Desc")
  self._ui._prog2_timer = UI.getChildControl(self._ui._stc_bg, "Progress2_Challenge")
  self._ui._btn_Confirm = UI.getChildControl(self._ui._stc_bg, "Button_Confirm")
  self._ui._btn_Cancel = UI.getChildControl(self._ui._stc_bg, "Button_Cancel")
  local slot = {}
  SlotItem.new(slot, "GuildShareItem_Msg_Icon", 0, self._ui._stc_slotIconBg, self._slotConfig)
  slot:createChild()
  slot.icon:SetHorizonCenter()
  slot.icon:SetVerticalMiddle()
  slot.icon:ComputePos()
  self._itemSlot = slot
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
  PaGlobal_GuildItemShare_Message:registerEvent()
  PaGlobal_GuildItemShare_Message:validate()
  self._initialize = true
end
function PaGlobal_GuildItemShare_Message:registerEvent()
  registerEvent("FromClient_GuildItemShare_MessageOpen", "FromClient_GuildItemShare_MessageOpen")
  registerEvent("FromClient_GuildItemShare_MessageWating", "FromClient_GuildItemShare_MessageWating")
  registerEvent("FromClient_GuildItemShare_MessageRejected", "FromClient_GuildItemShare_MessageRejected")
  registerEvent("FromClient_GuildItemShare_MessageAccepted", "FromClient_GuildItemShare_MessageAccepted")
  self._ui._btn_Confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildItemShare_Message_Accept()")
  self._ui._btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildItemShare_Message_Decline()")
end
function PaGlobal_GuildItemShare_Message:validate()
  self._ui._stc_bg:isValidate()
  self._ui._stc_slotIconBg:isValidate()
  self._ui._txt_ItemName:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._prog2_timer:isValidate()
  self._ui._btn_Confirm:isValidate()
  self._ui._btn_Cancel:isValidate()
end
function PaGlobal_GuildItemShare_Message:prepareOpen()
  if false == _ContentsGroup_GuildShareItemWareHouse then
    return
  end
  self._currentTime = 0
  Panel_GuildItemShare_Message:RegisterUpdateFunc("PaGlobalFunc_GuildItemShare_UpdatePerFrame")
  PaGlobal_GuildItemShare_Message:open()
end
function PaGlobal_GuildItemShare_Message:open()
  Panel_GuildItemShare_Message:SetShow(true)
end
function PaGlobal_GuildItemShare_Message:prepareClose()
  self._itemSlot:clearItem()
  self._currentTime = 0
  Panel_GuildItemShare_Message:ClearUpdateLuaFunc()
  PaGlobal_GuildItemShare_Message:close()
end
function PaGlobal_GuildItemShare_Message:close()
  Panel_GuildItemShare_Message:SetShow(false)
end
function FromClient_GuildItemShare_MessageOpen(itemNo, itemKey, ItemEnchantLevel, houseHoldNo, userNo, nickName, exprationTime)
  if false == _ContentsGroup_GuildShareItemWareHouse then
    return
  end
  if nil == itemKey then
    return
  end
  if true == Panel_GuildItemShare_Message:GetShow() then
    return
  end
  PaGlobal_GuildItemShare_Message._itemNo = 0
  PaGlobal_GuildItemShare_Message._itemEnchantKey = 0
  PaGlobal_GuildItemShare_Message._houseHoldNo = 0
  PaGlobal_GuildItemShare_Message._userNo = nil
  PaGlobal_GuildItemShare_Message._itemEnchantKey = ItemEnchantKey(itemKey, ItemEnchantLevel)
  PaGlobal_GuildItemShare_Message._itemNo = itemNo
  PaGlobal_GuildItemShare_Message._houseHoldNo = houseHoldNo
  PaGlobal_GuildItemShare_Message._userNo = userNo
  PaGlobal_GuildItemShare_Message._exprationTime = exprationTime
  if false == PaGlobal_GuildItemShare_Message._itemEnchantKey:isDefined() then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(PaGlobal_GuildItemShare_Message._itemEnchantKey)
  if nil == itemSSW then
    return
  end
  PaGlobal_GuildItemShare_Message._itemSlot:clearItem()
  PaGlobal_GuildItemShare_Message._itemSlot:setItemByStaticStatus(itemSSW, Defines.s64_const.s64_1)
  PaGlobal_GuildItemShare_Message._ui._txt_ItemName:SetText(itemSSW:getName())
  PaGlobal_GuildItemShare_Message._ui._txt_desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_ITEMSHARE_RENT_DESC", "name", nickName))
  PaGlobal_GuildItemShare_Message:prepareOpen()
end
function HandleEventLUp_GuildItemShare_Message_Accept()
  if false == _ContentsGroup_GuildShareItemWareHouse then
    return
  end
  if nil == PaGlobal_GuildItemShare_Message._userNo then
    return
  end
  if nil == PaGlobal_GuildItemShare_Message._itemNo or nil == PaGlobal_GuildItemShare_Message._itemEnchantKey or nil == PaGlobal_GuildItemShare_Message._houseHoldNo then
    return
  end
  local self = PaGlobal_GuildItemShare_Message
  ToClient_ResponseGuildRentalRequest(self._itemNo, self._itemEnchantKey, self._houseHoldNo, true, self._userNo, self._exprationTime)
  PaGlobal_GuildItemShare_Message:prepareClose()
end
function HandleEventLUp_GuildItemShare_Message_Decline()
  if false == _ContentsGroup_GuildShareItemWareHouse then
    return
  end
  PaGlobal_GuildItemShare_Message:prepareClose()
  if nil == PaGlobal_GuildItemShare_Message._userNo then
    return
  end
  local self = PaGlobal_GuildItemShare_Message
  ToClient_ResponseGuildRentalRequest(self._itemNo, self._itemEnchantKey, self._houseHoldNo, false, self._userNo)
end
function PaGlobalFunc_GuildItemShare_UpdatePerFrame(deltaTime)
  if false == _ContentsGroup_GuildShareItemWareHouse then
    return
  end
  if false == Panel_GuildItemShare_Message:GetShow() then
    return
  end
  PaGlobal_GuildItemShare_Message._currentTime = PaGlobal_GuildItemShare_Message._currentTime + deltaTime
  local rate = (PaGlobal_GuildItemShare_Message._closeTime - PaGlobal_GuildItemShare_Message._currentTime) / PaGlobal_GuildItemShare_Message._closeTime * 100
  PaGlobal_GuildItemShare_Message._ui._prog2_timer:SetProgressRate(rate)
  if PaGlobal_GuildItemShare_Message._closeTime <= PaGlobal_GuildItemShare_Message._currentTime then
    HandleEventLUp_GuildItemShare_Message_Decline()
  end
end
function FromClient_GuildItemShare_MessageWating()
  if false == _ContentsGroup_GuildShareItemWareHouse then
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ITEMSHARE_RENT_WAITING"),
    isProgress = true,
    isTimeCount = true,
    countTime = PaGlobal_GuildItemShare_Message._closeTime * 2,
    isStartTimer = true,
    afterFunction = FromClient_GuildItemShare_MessageRejected,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_GuildItemShare_MessageRejected(isNotLogin)
  if false == _ContentsGroup_GuildShareItemWareHouse then
    return
  end
  if nil == isNotLogin then
    isNotLogin = false
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ITEMSHARE_RENT_NEGATIVE"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if true == isNotLogin then
    messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ITEMSHARE_RENT_DISCONNECTED"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
  end
  FromClient_Warehouse_All_GuildUpdate(false, false, true)
  allClearMessageData()
  PaGlobal_GuildItemShare_Message:prepareClose()
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_GuildItemShare_MessageAccepted()
  if false == _ContentsGroup_GuildShareItemWareHouse then
    return
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ITEMSHARE_RENT_COMPLETE"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  FromClient_Warehouse_All_GuildUpdate(false, false, true)
  allClearMessageData()
  PaGlobal_GuildItemShare_Message:prepareClose()
  MessageBox.showMessageBox(messageboxData)
end
