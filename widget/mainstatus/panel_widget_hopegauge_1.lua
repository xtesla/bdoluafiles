function PaGlobal_HopeGauge:initialize()
  if true == PaGlobal_HopeGauge._initialize then
    return
  end
  local infoUI = self._ui
  infoUI._btn_Close = UI.getChildControl(Panel_Widget_HopeGauge, "Button_Close")
  infoUI._stc_itemIcon = UI.getChildControl(Panel_Widget_HopeGauge, "Static_IconBg")
  infoUI._stc_selectIcon = UI.getChildControl(Panel_Widget_HopeGauge, "Static_Selected_Item_Icon")
  PaGlobal_HopeGauge:createcontrolFeedItem()
  PaGlobal_HopeGauge._ui._stc_itemIcon:SetShow(false)
  PaGlobal_HopeGauge:registEventHandler()
  PaGlobal_HopeGauge:validate()
  PaGlobal_HopeGauge._initialize = true
end
function PaGlobal_HopeGauge:createcontrolFeedItem()
  local infoUI = self._ui
  for i = 0, self._config._feedStaticItemCount - 1 do
    local info = {}
    info._button = UI.createControl(__ePAUIControl_Static, Panel_Widget_HopeGauge, "feedButton_" .. i)
    CopyBaseProperty(infoUI._stc_itemIcon, info._button)
    local itemSlot = {}
    SlotItem.new(itemSlot, "Item_Slot_" .. i, i, info._button, self._config._slotConfig)
    itemSlot:createChild()
    local slotConfig = self._config
    info._button:SetPosX(slotConfig._startX + slotConfig._gapX * (i % slotConfig._col))
    info._button:addInputEvent("Mouse_LUp", "HandleClicked_SelectFeedItem(" .. i .. ")")
    info._button:addInputEvent("Mouse_On", "HandleEventOn_HopeGause_IconTooltip(" .. i .. ")")
    info._button:addInputEvent("Mouse_Out", "HandleEventOut_HopeGause_IconTooltip(" .. i .. ")")
    itemSlot.icon:SetIgnore(true)
    info._slot = itemSlot
    info._button:SetShow(false)
    infoUI._static_ItemSlots[i] = info
  end
  infoUI._stc_selectIcon:SetPosY(infoUI._stc_selectIcon:GetPosY())
  Panel_Widget_HopeGauge:SetChildIndex(infoUI._stc_selectIcon, 9999)
end
function PaGlobal_HopeGauge:registEventHandler()
  if nil == Panel_Widget_HopeGauge then
    return
  end
  PaGlobal_HopeGauge._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_HopeGauge:prepareClose()")
end
function PaGlobal_HopeGauge:prepareOpen()
  if nil == Panel_Widget_HopeGauge then
    return
  end
  PaGlobal_HopeGauge:updatePos()
  PaGlobal_HopeGauge:update()
  PaGlobal_HopeGauge:open()
end
function PaGlobal_HopeGauge:open()
  if nil == Panel_Widget_HopeGauge then
    return
  end
  Panel_Widget_HopeGauge:SetShow(true)
end
function PaGlobal_HopeGauge:prepareClose()
  if nil == Panel_Widget_HopeGauge then
    return
  end
  PaGlobal_HopeGauge._selectItemIndex = -1
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_HopeGauge:close()
end
function PaGlobal_HopeGauge:close()
  if nil == Panel_Widget_HopeGauge then
    return
  end
  Panel_Widget_HopeGauge:SetShow(false)
end
function PaGlobal_HopeGauge:updatePos()
  local posX = Panel_Widget_HopeGaugeOnOff:GetPosX() + Panel_Widget_HopeGaugeOnOff:GetSizeX() + 20
  local posY = Panel_Widget_HopeGaugeOnOff:GetPosY() + Panel_Widget_HopeGaugeOnOff:GetSizeY() - 20
  Panel_Widget_HopeGauge:SetPosXY(posX, posY)
end
function PaGlobal_HopeGauge:update()
  if nil == Panel_Widget_HopeGauge then
    return
  end
  if false == self._initialize then
    return
  end
  local infoUI = self._ui
  PaGlobal_HopeGauge:updateFeedItem()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  infoUI._stc_selectIcon:SetShow(false)
  self._selectItemIndex = -1
  self._selectedCount = 0
  self._selectedPoint = 0
end
function PaGlobal_HopeGauge:updateFeedItem()
  local infoUI = self._ui
  local userFeedItemCount = ToClient_getItemCollectionScrollCount()
  for i = 0, self._config._feedStaticItemCount - 1 do
    local targetSlot = infoUI._static_ItemSlots[i]
    if i < userFeedItemCount then
      local feedItem = ToClient_getItemCollectionScrollByIndex(i)
      if nil == feedItem then
        return
      end
      if nil == targetSlot then
        return
      end
      targetSlot._slot:clearItem()
      targetSlot._slot:setItem(feedItem)
      targetSlot._slot.icon:SetShow(true)
      targetSlot._button:SetShow(true)
      targetSlot._button:SetIgnore(false)
      targetSlot._button:SetEnable(true)
      if (-1 == self._selectItemIndex or userFeedItemCount <= self._selectItemIndex) and 0 == i then
        self._selectItemIndex = i
      else
      end
    elseif i == self._selectItemIndex and nil ~= targetSlot then
      targetSlot._button:SetShow(false)
      targetSlot._slot:clearItem()
    end
  end
end
function PaGlobal_HopeGauge:validate()
  if nil == Panel_Widget_HopeGauge then
    return
  end
  local infoUI = PaGlobal_HopeGauge._ui
  infoUI._btn_Close:isValidate()
  infoUI._stc_itemIcon:isValidate()
  infoUI._stc_selectIcon:isValidate()
  for i = 0, self._config._feedStaticItemCount - 1 do
    infoUI._static_ItemSlots[i]._button:isValidate()
  end
end
function PaGlobal_HopeGauge:ChargeOpen(isOpen)
  PaGlobal_HopeGauge._ui._stc_FeedingBg:SetShow(isOpen)
end
function PaGlobal_HopeGauge_ChargeScroll(inputNumber)
  local self = PaGlobal_HopeGauge
  self._selectedCount = Int64toInt32(inputNumber)
  local function charrgeScroll()
    ToClient_ChargeItemCollectionScroll(self._selectItemIndex, self._selectedCount)
  end
  local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ITEMGETSCROLL_WARNING", "count", tostring(self._selectedCount), "chargeCount", Util.Time.timeFormatting(self._selectedCount * self._selectedPoint))
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_TOOLTIP_TITLE"),
    content = contentString,
    functionYes = charrgeScroll,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if -1 ~= self._selectItemIndex then
    MessageBox.showMessageBox(messageboxData)
  end
end
function PaGlobal_HopeGauge:selectFeedItem(idx)
  local infoUI = self._ui
  local feedItem = ToClient_getItemCollectionScrollByIndex(idx)
  if nil == feedItem then
    return
  end
  local itemStatic = feedItem:getStaticStatus()
  self._selectItemIndex = idx
  if nil ~= itemStatic then
    self._selectedPoint = itemStatic:getContentsEventParam1()
  end
  Panel_NumberPad_Show(true, feedItem:getCount(), nil, PaGlobal_HopeGauge_ChargeScroll)
  Panel_Tooltip_Item_hideTooltip()
  local slot = infoUI._static_ItemSlots[idx]
  if nil ~= slot then
    infoUI._stc_selectIcon:SetPosX(slot._button:GetPosX() + self._config._checkX)
    infoUI._stc_selectIcon:SetShow(true)
  end
end
