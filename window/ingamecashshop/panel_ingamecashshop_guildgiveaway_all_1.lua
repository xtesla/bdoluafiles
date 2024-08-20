function PaGlobal_IngameCashshop_GuildGiveaway:initialize()
  if true == PaGlobal_IngameCashshop_GuildGiveaway._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_TopGroup = UI.getChildControl(Panel_IngameCashShop_GuildGiveaway_All, "Static_TopGroup")
  self._ui_pc.btn_Close = UI.getChildControl(stc_TopGroup, "Button_Win_Close")
  self._ui_pc.btn_GetItem = UI.getChildControl(Panel_IngameCashShop_GuildGiveaway_All, "Button_GetItem")
  self._ui.stc_Deco = UI.getChildControl(Panel_IngameCashShop_GuildGiveaway_All, "Static_DecoTexture")
  self._ui.stc_TimeBg = UI.getChildControl(self._ui.stc_Deco, "Static_LimitTimeBG")
  self._ui.txt_RewardCount = UI.getChildControl(self._ui.stc_Deco, "StaticText_Count")
  self._ui.txt_Time = UI.getChildControl(self._ui.stc_TimeBg, "StaticText_Time")
  self._ui.txt_SubTitle = UI.getChildControl(Panel_IngameCashShop_GuildGiveaway_All, "StaticText_SubTitle")
  self._ui.txt_UserName = UI.getChildControl(Panel_IngameCashShop_GuildGiveaway_All, "StaticText_UserName")
  self._ui.txt_DescBox = UI.getChildControl(Panel_IngameCashShop_GuildGiveaway_All, "Static_DescBox")
  self._ui.txt_SubText = UI.getChildControl(Panel_IngameCashShop_GuildGiveaway_All, "StaticText_SubText")
  self._ui.txt_NoPresent = UI.getChildControl(Panel_IngameCashShop_GuildGiveaway_All, "StaticText_NoPresent")
  self._ui.stc_ItemSlot = UI.getChildControl(Panel_IngameCashShop_GuildGiveaway_All, "Static_ItemSlot")
  local baseSlot = UI.getChildControl(self._ui.stc_ItemSlot, "Static_ItemSlot01")
  local baseSelectItemSlot = UI.getChildControl(self._ui.stc_ItemSlot, "Static_SelectItem")
  for idx = 0, __eGuildGiveawaySelectedItemMaxCount - 1 do
    local slot = {parent = nil, selectSlot = nil}
    local parent = UI.cloneControl(baseSlot, self._ui.stc_ItemSlot, "Static_ItemSlot_" .. tostring(idx))
    parent:SetShow(false)
    slot.parent = parent
    SlotItem.new(slot, "ItemSlot", idx, parent, self._slotConfig)
    slot:createChild()
    slot.icon:SetPosX(2)
    slot.icon:SetPosY(2)
    local selectSlot = UI.cloneControl(baseSelectItemSlot, parent, "Static_SelectItemSlot_" .. tostring(idx))
    selectSlot:SetShow(false)
    selectSlot:SetPosX(0)
    selectSlot:SetPosY(0)
    slot.selectSlot = selectSlot
    self._selectItemSlot[idx] = slot
    self._selectItemSlot[idx]:clearItem()
  end
  UI.deleteControl(baseSlot)
  UI.deleteControl(baseSelectItemSlot)
  self._timePosX = self._ui.stc_TimeBg:GetPosX()
  self._timeSizeX = self._ui.stc_TimeBg:GetSizeX()
  self._timeEndPosX = self._timePosX + self._timeSizeX
  self._ui.stc_smallDeco = UI.getChildControl(Panel_IngameCashShop_GuildGiveaway_All, "Static_Deco_Small")
  self._ui.stc_smallCount = UI.getChildControl(self._ui.stc_smallDeco, "StaticText_Count")
  self._ui.stc_smallTimeBg = UI.getChildControl(self._ui.stc_smallDeco, "Static_LimitTimeBG")
  self._ui.txt_smallTime = UI.getChildControl(self._ui.stc_smallTimeBg, "StaticText_Time")
  local smallparent = UI.getChildControl(self._ui.stc_smallDeco, "Static_MainSlot")
  local smalltemp = {}
  SlotItem.new(smalltemp, "SmallMainItemSlot", 0, smallparent, self._slotConfig)
  smalltemp:createChild()
  smalltemp.icon:SetSize(42, 42)
  smalltemp.border:SetSize(44, 44)
  self._ui.stc_smallmainSlot = smalltemp
  self._ui.stc_smallmainSlot:clearItem()
  self._ui.stc_smallmainSlot.icon:addInputEvent("Mouse_Out", "")
  self._panelSizeX = Panel_IngameCashShop_GuildGiveaway_All:GetSizeX()
  self._itemSlotBgSizeX = self._ui.stc_ItemSlot:GetSizeX()
  self._ui.txt_SubText:SetShow(true)
  self._ui.txt_RewardCount:SetIgnore(false)
  self._ui.txt_Time:SetIgnore(false)
  self._ui.txt_NoPresent:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDGIVEAWAY_CHOISEREWARD"))
  self._ui.txt_NoPresent:SetShow(false)
  self._ui.txt_DescBox:SetShow(false)
  self._ui.stc_Deco:SetShow(false)
  self._ui.stc_ItemSlot:SetShow(false)
  self._ui.stc_smallDeco:SetShow(true)
  self._ui.stc_smallCount:SetIgnore(false)
  self._ui.txt_smallTime:SetIgnore(false)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_IngameCashshop_GuildGiveaway:registEventHandler()
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  if self._isConsole then
  else
    self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_IngameCashshop_GuildGiveaway_Close()")
    self._ui.txt_RewardCount:addInputEvent("Mouse_On", "HandleEventMInOut_IngameCashshop_GuildGiveaway_RewardCountTooltip( true)")
    self._ui.txt_RewardCount:addInputEvent("Mouse_Out", "HandleEventMInOut_IngameCashshop_GuildGiveaway_RewardCountTooltip( false )")
    self._ui.txt_Time:addInputEvent("Mouse_On", "HandleEventMInOut_IngameCashshop_GuildGiveaway_RewardTimeTooltip( true)")
    self._ui.txt_Time:addInputEvent("Mouse_Out", "HandleEventMInOut_IngameCashshop_GuildGiveaway_RewardTimeTooltip( false )")
    self._ui.stc_smallCount:addInputEvent("Mouse_On", "HandleEventMInOut_IngameCashshop_GuildGiveaway_RewardCountTooltip( true)")
    self._ui.stc_smallCount:addInputEvent("Mouse_Out", "HandleEventMInOut_IngameCashshop_GuildGiveaway_RewardCountTooltip( false )")
    self._ui.txt_smallTime:addInputEvent("Mouse_On", "HandleEventMInOut_IngameCashshop_GuildGiveaway_RewardTimeTooltip( true)")
    self._ui.txt_smallTime:addInputEvent("Mouse_Out", "HandleEventMInOut_IngameCashshop_GuildGiveaway_RewardTimeTooltip( false )")
  end
  registerEvent("FromClient_responseGuildGiveawayList", "FromClient_responseGuildGiveawayList")
  registerEvent("FromClient_setNewGuildGiveaway", "FromClient_setNewGuildGiveaway")
  registerEvent("FromClient_responseReceiveGuildGiveaway", "FromClient_responseReceiveGuildGiveaway")
  registerEvent("FromClient_UpdatePearlMileage", "FromClient_IngameCashshop_GuildGiveaway_UpdateRewardEffect")
  registerEvent("FromClient_useGuildGiveawayItem", "FromClient_useGuildGiveawayItem")
end
function PaGlobal_IngameCashshop_GuildGiveaway:prepareOpen()
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  if 0 == ToClient_getGiveawayDataCount() then
    local funcYesExe = function()
      local tabIdx = 13
      PaGlobal_InGameShop_GoToTab(tabIdx)
      InGameShop_TabEvent(tabIdx)
    end
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDGIVEAWAY_GOTO_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDGIVEAWAY_GOTO_DESC"),
      functionYes = funcYesExe,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  local showIndex = ToClient_getGiveawayDataIndex()
  self:update(showIndex)
  self:open()
end
function PaGlobal_IngameCashshop_GuildGiveaway:open()
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  Panel_IngameCashShop_GuildGiveaway_All:SetShow(true)
end
function PaGlobal_IngameCashshop_GuildGiveaway:prepareClose()
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  PaGlobal_IngameCashshop_GuildGiveaway:close()
end
function PaGlobal_IngameCashshop_GuildGiveaway:close()
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  Panel_IngameCashShop_GuildGiveaway_All:SetShow(false)
end
function PaGlobal_IngameCashshop_GuildGiveaway:update(idx)
  local dataWrapper = ToClient_getGiveawayDataWrapper(idx)
  if nil == dataWrapper then
    return
  end
  local keyRaw = dataWrapper:getKeyRaw()
  local listSize = ToClient_getGuildGiveawaySelectedListSize(keyRaw)
  local panelSizeY = 0
  if 1 == listSize then
    self:showItem(dataWrapper, idx)
    panelSizeY = self._ui.stc_smallDeco:GetPosY() + self._ui.stc_smallDeco:GetSizeY()
    self._selectItemIndex = 0
  elseif listSize > 1 then
    self:showItems(dataWrapper, idx)
    panelSizeY = self._ui.stc_Deco:GetPosY() + self._ui.stc_Deco:GetSizeY()
    self._selectItemIndex = -1
  else
    return
  end
  panelSizeY = panelSizeY + self._ui_pc.btn_GetItem:GetSizeY() + 20
  local txt_buyer = dataWrapper:getUserNickName()
  if nil ~= txt_buyer and "" ~= txt_buyer then
    txt_buyer = "<PAColor0xFFFFCE22>" .. "[" .. txt_buyer .. "]" .. "<PAOldColor>"
  else
    txt_buyer = "<PAColor0xFFFFCE22>" .. "[" .. PAGetString(Defines.StringSheet_GAME, "LUA_USERNICKNAME_NONAME") .. "]" .. "<PAOldColor>"
  end
  self._ui.txt_UserName:SetText(txt_buyer)
  Panel_IngameCashShop_GuildGiveaway_All:SetSize(self._panelSizeX, panelSizeY)
  Panel_IngameCashShop_GuildGiveaway_All:ComputePosAllChild()
  local index_s64 = dataWrapper:getIndex()
  self._ui_pc.btn_GetItem:addInputEvent("Mouse_LUp", "HandleEventLUp_IngameCashshop_GuildGiveaway_GetItem(" .. tostring(index_s64) .. ")")
  self._ui_pc.btn_GetItem:SetIgnore(false)
  Panel_IngameCashShop_GuildGiveaway_All:ClearUpdateLuaFunc()
end
function PaGlobal_IngameCashshop_GuildGiveaway:showItem(dataWrapper, idx)
  if nil == dataWrapper then
    return
  end
  self._ui.stc_smallDeco:SetShow(true)
  self._ui.stc_Deco:SetShow(false)
  self._ui.stc_ItemSlot:SetShow(false)
  self._ui.txt_NoPresent:SetShow(false)
  local txt_leftTime = converStringFromLeftDateTime(dataWrapper:getDeleteDate())
  self._ui.txt_smallTime:SetText(txt_leftTime)
  local nonExpireRewardCount = ToClient_getGiveawayDataCount()
  self._ui.stc_smallCount:SetText(nonExpireRewardCount)
  local itemEnchantKey = ToClient_getGuildGiveawaySelectedItemEnchantKey(dataWrapper:getKeyRaw(), 0)
  local itemCount = ToClient_getGuildGiveawaySelectedItemCount(dataWrapper:getKeyRaw(), 0)
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if nil ~= itemSSW then
    self._ui.stc_smallmainSlot:clearItem()
    self._ui.stc_smallmainSlot:setItemByStaticStatus(itemSSW, itemCount)
    self._ui.stc_smallmainSlot.icon:SetShow(true)
    self._ui.stc_smallmainSlot.icon:addInputEvent("Mouse_On", "HandleEventMOn_IngameCashshop_GuildGiveaway_ItemTooltipShow(true , 0 ," .. idx .. ")")
    self._ui.stc_smallmainSlot.icon:addInputEvent("Mouse_Out", "HandleEventMOut_IngameCashshop_GuildGiveaway_ItemTooltipHide()")
  end
end
function PaGlobal_IngameCashshop_GuildGiveaway:showItems(dataWrapper, idx)
  if nil == dataWrapper then
    return
  end
  self._ui.stc_smallDeco:SetShow(false)
  self._ui.stc_Deco:SetShow(true)
  self._ui.stc_ItemSlot:SetShow(true)
  self._ui.txt_NoPresent:SetShow(true)
  local txt_leftTime = converStringFromLeftDateTime(dataWrapper:getDeleteDate())
  self._ui.txt_Time:SetText(txt_leftTime)
  local nonExpireRewardCount = ToClient_getGiveawayDataCount()
  self._ui.txt_RewardCount:SetText(nonExpireRewardCount)
  local keyRaw = dataWrapper:getKeyRaw()
  local listSize = ToClient_getGuildGiveawaySelectedListSize(keyRaw)
  for ii = 0, __eGuildGiveawaySelectedItemMaxCount - 1 do
    local itemEnchantKey = ToClient_getGuildGiveawaySelectedItemEnchantKey(keyRaw, ii)
    local itemCount = ToClient_getGuildGiveawaySelectedItemCount(keyRaw, ii)
    local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
    local slot = self._selectItemSlot[ii]
    slot:clearItem()
    slot.selectSlot:SetShow(false)
    if nil ~= itemSSW then
      slot:setItemByStaticStatus(itemSSW, itemCount)
      slot.icon:SetShow(true)
      slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_IngameCashshop_GuildGiveaway_SelectItem(" .. tostring(ii) .. ")")
      slot.icon:addInputEvent("Mouse_On", "HandleEventMOn_IngameCashshop_GuildGiveaway_ItemTooltipShow(false , " .. tostring(ii) .. ", " .. tostring(idx) .. ")")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventMOut_IngameCashshop_GuildGiveaway_ItemTooltipHide()")
    else
      slot.icon:SetShow(false)
      slot.icon:addInputEvent("Mouse_On", "")
      slot.icon:addInputEvent("Mouse_Out", "")
    end
  end
  local half = math.floor(__eGuildGiveawaySelectedItemMaxCount / 2)
  local baseSlot = self._selectItemSlot[0].parent
  local initPosX = (self._itemSlotBgSizeX - (baseSlot:GetSizeX() * half + 5 * (half - 1))) / 2
  local initPosY = 0
  local itemSlotBgSizeY = 0
  if listSize > 5 then
    itemSlotBgSizeY = 120
    initPosY = (itemSlotBgSizeY - (2 * baseSlot:GetSizeY() + 5)) / 2
    for ii = 0, __eGuildGiveawaySelectedItemMaxCount - 1 do
      local parent = self._selectItemSlot[ii].parent
      local col = ii % half
      local row = math.floor(ii / half)
      local posX = initPosX + (parent:GetSizeX() + 5) * col
      local posY = initPosY + parent:GetSizeY() * row + 5 * row
      parent:SetPosX(posX)
      parent:SetPosY(posY)
      parent:SetShow(true)
    end
    self._ui.stc_ItemSlot:SetSize(self._itemSlotBgSizeX, itemSlotBgSizeY)
  else
    itemSlotBgSizeY = 100
    initPosY = (itemSlotBgSizeY - baseSlot:GetSizeY()) / 2
    for ii = 0, __eGuildGiveawaySelectedItemMaxCount - 1 do
      local parent = self._selectItemSlot[ii].parent
      local col = ii % half
      local row = math.floor(ii / half)
      local posX = initPosX + (parent:GetSizeX() + 5) * col
      local posY = initPosY + parent:GetSizeY() * row + 5 * row
      parent:SetPosX(posX)
      parent:SetPosY(posY)
      parent:SetShow(ii < 5)
    end
    self._ui.stc_ItemSlot:SetSize(self._itemSlotBgSizeX, itemSlotBgSizeY)
  end
end
function PaGlobal_IngameCashshop_GuildGiveaway:updatePerFrame(deltaTime)
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  self._curTime = self._curTime + deltaTime
  if self._curTime < 2 then
    return
  end
  self._curTime = 0
  self._ui.txt_UserName:EraseAllEffect()
  for index = 0, __eGuildGiveawaySelectedItemMaxCount - 1 do
    self._selectItemSlot[index].icon:EraseAllEffect()
  end
  self._ui.stc_smallmainSlot.icon:EraseAllEffect()
  local showIndex = ToClient_getGiveawayDataIndex()
  if -1 == showIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDGIVEAWAY_All_RECIEVE"))
    PaGlobal_IngameCashshop_GuildGiveaway_Close()
    return
  end
  self:update(showIndex)
end
function PaGlobal_IngameCashshop_GuildGiveaway:updateRecieveItem()
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  self._ui_pc.btn_GetItem:SetIgnore(true)
  self:checkBtnEffect()
end
function PaGlobal_IngameCashshop_GuildGiveaway:validate()
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
end
function PaGlobal_IngameCashshop_GuildGiveaway:checkBtnEffect()
  if nil == Panel_IngameCashShop_GuildGiveaway_All then
    return
  end
  local rewardCount = ToClient_getGiveawayDataCount()
  PaGlobalFunc_IngameCashShopSetEquip_GuildRewardBtnEffect(rewardCount)
end
function PaGlobal_IngameCashshop_GuildGiveaway:itemTooltipShow(isMainSlot, selectSlotIdex, RewardIndex)
  if true == isMainSlot then
    if nil == self._ui.stc_smallmainSlot then
      return
    end
    local dataWrapper = ToClient_getGiveawayDataWrapper(RewardIndex)
    if nil == dataWrapper then
      return
    end
    local itemEnchantKey = ToClient_getGuildGiveawaySelectedItemEnchantKey(dataWrapper:getKeyRaw(), RewardIndex)
    local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
    if nil ~= itemSSW then
      local name = itemSSW:getName()
      local desc = itemSSW:getDescription()
      Panel_Tooltip_Item_Show(itemSSW, self._ui.stc_smallmainSlot.icon, true)
    end
  else
    if nil == self._selectItemSlot[selectSlotIdex] then
      return
    end
    local dataWrapper = ToClient_getGiveawayDataWrapper(RewardIndex)
    if nil == dataWrapper then
      return
    end
    local itemEnchantKey = ToClient_getGuildGiveawaySelectedItemEnchantKey(dataWrapper:getKeyRaw(), selectSlotIdex)
    local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
    if nil ~= itemSSW then
      local name = itemSSW:getName()
      local desc = itemSSW:getDescription()
      Panel_Tooltip_Item_Show(itemSSW, self._selectItemSlot[selectSlotIdex].icon, true)
    end
  end
end
function PaGlobal_IngameCashshop_GuildGiveaway:itemTooltipHide()
  Panel_Tooltip_Item_hideTooltip()
end
