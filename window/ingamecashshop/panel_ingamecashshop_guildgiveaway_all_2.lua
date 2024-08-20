function HandleEventLUp_IngameCashshop_GuildGiveaway_SelectItem(newIndex)
  local self = PaGlobal_IngameCashshop_GuildGiveaway
  local oldIndex = self._selectItemIndex
  if oldIndex == newIndex then
    return
  end
  self._selectItemIndex = newIndex
  local newSlot = self._selectItemSlot[newIndex].selectSlot
  newSlot:SetShow(true)
  if oldIndex >= 0 then
    local oldSlot = self._selectItemSlot[oldIndex].selectSlot
    oldSlot:SetShow(false)
  end
end
function HandleEventLUp_IngameCashshop_GuildGiveaway_GetItem(index)
  local self = PaGlobal_IngameCashshop_GuildGiveaway
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  if nil == index then
    return
  end
  if 0 <= self._selectItemIndex then
    if nil ~= self._selectItemSlot[self._selectItemIndex] and true == self._selectItemSlot[self._selectItemIndex].icon:GetShow() then
      self._selectItemSlot[self._selectItemIndex].icon:AddEffect("fUI_GuildCompensation_01A", true, 0, 0)
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDGIVEAWAY_CHOISEREWARD"))
    return
  end
  if true == self._ui.txt_UserName:GetShow() then
    self._ui.txt_UserName:AddEffect("fUI_GuildCompensation_Name_01A", true, 0, 0)
  end
  if true == self._ui.stc_smallmainSlot.icon:GetShow() then
    self._ui.stc_smallmainSlot.icon:AddEffect("fUI_GuildCompensation_01A", true, 0, 0)
  end
  Panel_IngameCashShop_GuildGiveaway_All:RegisterUpdateFunc("PaGlobal_IngameCashshop_GuildGiveaway_UpdatePerFrame")
  ToClient_requestReceiveGuildGiveaway(tonumber64(index), self._selectItemIndex)
end
function HandleEventMOn_IngameCashshop_GuildGiveaway_ItemTooltipShow(isMainSlot, selectSlotIdex, RewardIndex)
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  if nil == isMainSlot or nil == selectSlotIdex or nil == RewardIndex then
    return
  end
  PaGlobal_IngameCashshop_GuildGiveaway:itemTooltipShow(isMainSlot, selectSlotIdex, RewardIndex)
end
function HandleEventMOut_IngameCashshop_GuildGiveaway_ItemTooltipHide()
  PaGlobal_IngameCashshop_GuildGiveaway:itemTooltipHide()
end
function HandleEventMInOut_IngameCashshop_GuildGiveaway_RewardCountTooltip(isOn)
  local control
  local name = ""
  local desc
  if true == isOn then
    control = PaGlobal_IngameCashshop_GuildGiveaway._ui.stc_smallCount
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDGIVEAWAY_REWARDCOUNT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDGIVEAWAY_REWARDCOUNT_DESC")
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventMInOut_IngameCashshop_GuildGiveaway_RewardTimeTooltip(isOn)
  local control
  local name = ""
  local desc
  if true == isOn then
    control = PaGlobal_IngameCashshop_GuildGiveaway._ui.stc_smallTimeBg
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDGIVEAWAY_REWARDTIME_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDGIVEAWAY_REWARDTIME_DESC")
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_IngameCashshop_GuildGiveaway_Open()
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  PaGlobal_IngameCashshop_GuildGiveaway:prepareOpen()
end
function PaGlobal_IngameCashshop_GuildGiveaway_Close()
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  PaGlobal_IngameCashshop_GuildGiveaway:prepareClose()
end
function PaGlobal_IngameCashshop_GuildGiveaway_UpdatePerFrame(deltaTime)
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  PaGlobal_IngameCashshop_GuildGiveaway:updatePerFrame(deltaTime)
end
function FromClient_responseReceiveGuildGiveaway()
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  PaGlobal_IngameCashshop_GuildGiveaway:updateRecieveItem()
end
function FromClient_IngameCashshop_GuildGiveaway_UpdateRewardEffect()
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  PaGlobal_IngameCashshop_GuildGiveaway:checkBtnEffect()
end
function FromClient_responseGuildGiveawayList()
end
function FromClient_setNewGuildGiveaway()
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  PaGlobal_IngameCashshop_GuildGiveaway:checkBtnEffect()
end
function FromClient_useGuildGiveawayItem(fromWhereType, fromSlotNo)
  local function doUseGuildGiveawayItem()
    ToClient_requestUseGuildGiveawayItem(fromWhereType, fromSlotNo, PaGlobal_IngameCashshop_GuildGiveaway._isNotifyBuyer)
  end
  messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GUILDGIFT_BUY_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GUILDGIFT_BUY_PURCHASE_CONFIRM_DESC"),
    functionYes = doUseGuildGiveawayItem,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData, "top", false, true, 4)
end
