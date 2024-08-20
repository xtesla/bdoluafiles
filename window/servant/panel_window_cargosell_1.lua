function PaGlobal_CargoSell:initialize()
  if true == PaGlobal_CargoSell._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local titlebarBg = UI.getChildControl(Panel_Window_CargoSell, "Static_TitleBarBG")
  self._ui._btn_close = UI.getChildControl(titlebarBg, "Button_Close")
  self._ui._btn_close:SetShow(not _ContentsGroup_RenewUI)
  self._ui._stc_warehouseBg = UI.getChildControl(Panel_Window_CargoSell, "Static_MyWarehouse")
  self._ui._txt_capacity = UI.getChildControl(self._ui._stc_warehouseBg, "StaticText_Capacity")
  self._ui._stc_itemSlotFrame = UI.getChildControl(self._ui._stc_warehouseBg, "Static_ItemSlotFrame")
  self._ui._stc_itemSlotBg = UI.getChildControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_Template")
  self._ui._stc_lockIcon = UI.getChildControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_LockIcon")
  self._ui._stc_multipleSelect = UI.getChildControl(self._ui._stc_itemSlotFrame, "Static_MultipleSelect")
  self._ui._btn_itemsort = UI.getChildControl(self._ui._stc_warehouseBg, "CheckButton_ItemSort_PCUI")
  self._ui._stc_keyGuide_LSClick = UI.getChildControl(self._ui._stc_warehouseBg, "StaticText_LSClick_ConsoleUI")
  self._ui._btn_itemsort:SetShow(not self._isConsole)
  self._ui._stc_keyGuide_LSClick:SetShow(self._isConsole)
  self._ui._scroll_warehouse = UI.getChildControl(self._ui._stc_warehouseBg, "Scroll_Warehouse")
  self._ui._stc_Sell_Bg = UI.getChildControl(Panel_Window_CargoSell, "Static_Sell_List")
  self._ui._list2_sell = UI.getChildControl(self._ui._stc_Sell_Bg, "List2_1")
  self._ui._list2_content = UI.getChildControl(self._ui._list2_sell, "List2_1_Content")
  self._ui._list2_vscroll = UI.getChildControl(self._ui._list2_sell, "List2_1_VerticalScroll")
  local list2_slot = UI.getChildControl(self._ui._list2_content, "Static_Slot")
  local list2_slotBg = UI.getChildControl(list2_slot, "Static_SlotBG")
  local list2_slotItemIcon = UI.getChildControl(list2_slotBg, "Static_Icon")
  self._ui._txt_emptyDesc = UI.getChildControl(self._ui._stc_Sell_Bg, "StaticText_EmptyDesc")
  self._ui._txt_sell_total_price = UI.getChildControl(self._ui._stc_Sell_Bg, "StaticText_1")
  self._ui._btn_sell = UI.getChildControl(Panel_Window_CargoSell, "Button_Confirm")
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_Window_CargoSell, "Static_Console_KeyGuide_Main")
  self._ui._stc_keyGuide_X = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Console_X")
  self._ui._stc_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Console_Y")
  self._ui._stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Console_A")
  self._ui._stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Console_B")
  if true == _ContentsGroup_RenewUI then
    self._ui._stc_keyGuide_X:SetShow(true)
  else
    self._ui._stc_keyGuide_X:SetShow(false)
  end
  self:SetConsoleKeyGuide_SetAlign()
  self._isSorted = ToClient_IsSortedWarehouse()
  self._ui._btn_itemsort:SetCheck(self._isSorted)
  local itemSlot = {}
  SlotItem.new(itemSlot, "CargosellItemListSlot_", 0, list2_slotItemIcon, self._slotConfig)
  itemSlot:createChild()
  itemSlot.empty = true
  itemSlot:clearItem()
  itemSlot.icon:SetPosX(1)
  itemSlot.icon:SetPosY(1)
  itemSlot.border:SetSize(44, 44)
  self._config.slotRows = math.floor(self._config.slotCount / self._config.slotCols)
  if true == self._isConsole then
    Panel_Window_CargoSell:ignorePadSnapMoveToOtherPanel()
    local sizeY = self._ui._btn_sell:GetSizeY() + 10
    Panel_Window_CargoSell:SetSize(Panel_Window_CargoSell:GetSizeX(), Panel_Window_CargoSell:GetSizeY() - sizeY)
    Panel_Window_CargoSell:ComputePos()
    self._ui._stc_keyGuideBG:SetPosY(self._ui._stc_keyGuideBG:GetPosY() - sizeY)
  end
  PaGlobal_CargoSell:registEventHandler()
  PaGlobal_CargoSell:validate()
  self:createSlot()
  PaGlobal_CargoSell._initialize = true
end
function PaGlobal_CargoSell:registEventHandler()
  if nil == Panel_Window_CargoSell then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_CargoSell_Close()")
  self._ui._btn_itemsort:addInputEvent("Mouse_LUp", "HandleEventLUp_CargoSell_CheckSort()")
  self._ui._list2_sell:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_CargoSellList_CreateControlList2")
  self._ui._list2_sell:createChildContent(__ePAUIList2ElementManagerType_List)
  if true == self._isConsole then
    Panel_Window_CargoSell:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_CargoSell_Sell()")
    self._ui._btn_sell:SetShow(false)
  else
    self._ui._btn_sell:addInputEvent("Mouse_LUp", "HandleEventLUp_CargoSell_Sell()")
  end
  UIScroll.InputEvent(self._ui._scroll_warehouse, "HandleEvent_PaGlobal_CargoSell_Scroll")
  UIScroll.InputEventByControl(self._ui._stc_Sell_Bg, "HandleEvent_PaGlobal_CargoSell_Scroll")
  registerEvent("FromClient_CagoSellUpdate", "FromClient_PaGlobal_CargoSell_Update")
  registerEvent("FromClient_CargoSellComplete", "FromClient_CargoSellComplete")
  registerEvent("FromClient_SilverChange", "PaGlobalFunc_CargoSell_SilverChange")
end
function PaGlobal_CargoSell:prepareOpen(waypointKey)
  if nil == Panel_Window_CargoSell then
    return
  end
  PaGlobal_Warehouse_All_Close()
  self._selectWaypointKey = waypointKey
  ToClient_MakeCargoSellWareHouse()
  self._startSlotIndex = 0
  self._ui._scroll_warehouse:SetControlTop()
  self._ui._scroll_warehouse:SetControlPos(0)
  self:update()
  PaGlobalFunc_InterestKnowledge_All_Close()
  PaGlobal_CargoSell:open()
end
function PaGlobal_CargoSell:open()
  if nil == Panel_Window_CargoSell then
    return
  end
  Panel_Window_CargoSell:SetShow(true)
end
function PaGlobal_CargoSell:prepareClose()
  if nil == Panel_Window_CargoSell then
    return
  end
  Panel_NumberPad_Close()
  Panel_Tooltip_Item_hideTooltip()
  if true == _ContentsGroup_RenewUI then
    PaGlobalFunc_FloatingTooltip_Close()
    PaGlobalFunc_TooltipInfo_Close()
  end
  PaGlobal_CargoSell:close()
end
function PaGlobal_CargoSell:close()
  if nil == Panel_Window_CargoSell then
    return
  end
  Panel_Window_CargoSell:SetShow(false)
end
function PaGlobal_CargoSell:update()
  if nil == Panel_Window_CargoSell then
    return
  end
  local warehouseWrapper = ToClient_getCargoSellWareHouse()
  if nil == warehouseWrapper then
    return
  end
  local useStartSlot = 1
  local itemCount = warehouseWrapper:getSize()
  local useMaxCount = warehouseWrapper:getUseMaxCount()
  local freeCount = warehouseWrapper:getFreeCount()
  local maxCount = warehouseWrapper:getMaxCount()
  if itemCount < useMaxCount - useStartSlot then
    self._ui._txt_capacity:SetFontColor(Defines.Color.C_FFDDC39E)
  else
    self._ui._txt_capacity:SetFontColor(Defines.Color.C_FFD05D48)
  end
  if itemCount > useMaxCount - useStartSlot then
    self._ui._txt_capacity:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "Lua_WareHouse_OverCapacity", "HaveCount", tostring(itemCount), "FullCount", tostring(useMaxCount - useStartSlot)))
  else
    self._ui._txt_capacity:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "Lua_WareHouse_Capacity", "HaveCount", tostring(itemCount), "FullCount", tostring(useMaxCount - useStartSlot)))
  end
  local slotNoList = Array.new()
  slotNoList:fill(useStartSlot, maxCount - 1)
  if true == self._isSorted then
    local sortList = Array.new()
    sortList:fill(1, useMaxCount - 1)
    sortList:quicksort(PaGlobal_CargoSell_ItemComparer)
    for ii = 1, useMaxCount - 1 do
      slotNoList[ii] = sortList[ii]
    end
  end
  self:updateInitSlot(useMaxCount, maxCount, useStartSlot)
  self:updateSlot(slotNoList)
  self:updateList()
end
function PaGlobal_CargoSell:createSlot()
  if nil == Panel_Window_CargoSell then
    return
  end
  local maxRowsIdx = self._config.slotRows - 1
  for ii = 0, self._config.slotCount - 1 do
    local blankSlot
    if nil == self._blankSlots[ii] then
      local slotNo = ii + 1
      local slot = {}
      slot.empty = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_Template", self._ui._stc_itemSlotFrame, "CargoSell_Slot_Base_" .. ii)
      UIScroll.InputEventByControl(slot.empty, "HandleEvent_Warehouse_All_Scroll")
      local row = math.floor(ii / self._config.slotCols)
      local column = ii % self._config.slotCols
      slot.empty:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      slot.empty:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      if true == self._isConsole then
        if true == _ContentsGroup_RenewUI then
          slot.empty:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventRUp_PaGlobal_CargoSell_ShowDetailTooltip(" .. ii .. ", true)")
        end
        slot.empty:registerPadEvent(__eConsoleUIPadEvent_LSClick, "HandleEventLUp_CargoSell_CheckSort()")
        if 0 == row then
          slot.empty:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEvent_PaGlobal_CargoSell_Scroll(true)")
        elseif maxRowsIdx == row then
          slot.empty:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEvent_PaGlobal_CargoSell_Scroll(false)")
        end
      end
      self._blankSlots[ii] = slot
    end
    blankSlot = self._blankSlots[ii]
    if nil == self._slots[ii] then
      local slot = {}
      SlotItem.new(slot, "CargoCellItemIcon_" .. ii, ii, self._ui._stc_itemSlotFrame, self._slotConfig)
      slot:createChild()
      local row = math.floor(ii / self._config.slotCols)
      local column = ii % self._config.slotCols
      slot.icon:SetPosX(self._config.slotStartX + self._config.slotGapX * column + 1)
      slot.icon:SetPosY(self._config.slotStartY + self._config.slotGapY * row + 1)
      slot.icon:SetEnableDragAndDrop(true)
      slot.icon:SetAutoDisableTime(0.2)
      if true == self._isConsole then
        slot.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_PaGlobal_CargoSell_Item(" .. ii .. ")")
      else
        slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_PaGlobal_CargoSell_Item(" .. ii .. ")")
      end
      if false == _ContentsGroup_RenewUI then
        slot.icon:addInputEvent("Mouse_On", "HandleEventMOn_PaGlobal_CargoSell_IconOver(" .. ii .. ")")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventMOut_PaGlobal_CargoSell_IconOut(" .. ii .. ")")
      else
        slot.icon:addInputEvent("Mouse_On", "HandleEventConsoleMouseOn_PaGlobal_CargoSell_IconOver(" .. ii .. ",true)")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventConsoleMouseOn_PaGlobal_CargoSell_IconOver(" .. ii .. ",false)")
      end
      UIScroll.InputEventByControl(slot.icon, "HandleEvent_PaGlobal_CargoSell_Scroll")
      self._slots[ii] = slot
    end
    if nil ~= blankSlot then
      blankSlot.lock = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_LockIcon", self._ui._stc_itemSlotFrame, "Warehouse_Slot_Lock_" .. ii)
      blankSlot.plus = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotFrame, "Static_MultipleSelect", self._ui._stc_itemSlotFrame, "Warehouse_Slot_Plus_" .. ii)
      blankSlot.onlyPlus = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_Plus", self._ui._stc_itemSlotFrame, "Warehouse_Slot_OnlyPlus_" .. ii)
      local row = math.floor(ii / self._config.slotCols)
      local column = ii % self._config.slotCols
      blankSlot.lock:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      blankSlot.lock:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      blankSlot.plus:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      blankSlot.plus:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      blankSlot.onlyPlus:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      blankSlot.onlyPlus:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      blankSlot.lock:SetShow(true)
      blankSlot.plus:SetShow(false)
      blankSlot.onlyPlus:SetShow(false)
    end
  end
end
function PaGlobal_CargoSell:updateSlot(slotNoList)
  local warehouseWrapper = ToClient_getCargoSellWareHouse()
  if nil == warehouseWrapper then
    return
  end
  for ii = 0, self._config.slotCount - 1 do
    local slot = self._slots[ii]
    local slotNo = slotNoList[1 + ii + self._startSlotIndex]
    slot.slotNo = slotNo
    slot.icon:EraseAllEffect()
    local row = math.floor(ii / self._config.slotCols)
    local column = ii % self._config.slotCols
    slot.icon:SetPosX(self._config.slotStartX + self._config.slotGapX * column + 1)
    slot.icon:SetPosY(self._config.slotStartY + self._config.slotGapY * row + 1)
    slot.icon:SetMonoTone(false)
    slot.count:SetShow(false)
    local itemExist = false
    local canSell = false
    if nil == slotNo then
      slot:clearItem()
      slot.icon:SetEnableDragAndDrop(false)
    else
      local itemWrapper = warehouseWrapper:getItem(slotNo)
      if nil ~= itemWrapper then
        slot:setItem(itemWrapper, slotNo, nil, warehouseWrapper)
        local itemSSW = itemWrapper:getStaticStatus()
        if nil ~= itemSSW then
          if false == itemSSW:get():isCargoSellPossible() then
            canSell = false
          else
            canSell = true
          end
        end
        slot.icon:SetMonoTone(false)
        slot.icon:SetEnable(true)
        slot.icon:SetIgnore(false)
        itemExist = true
        slot.checkBox:SetShow(false)
      else
        slot.icon:SetMonoTone(false)
        slot.icon:SetEnable(true)
        slot.icon:SetIgnore(false)
      end
    end
    if not itemExist then
      slot:clearItem()
      slot.icon:SetEnable(true)
      slot.icon:SetMonoTone(true)
      slot.icon:SetIgnore(false)
    elseif true == canSell then
      slot.icon:SetMonoTone(false)
      slot.icon:SetAlpha(1)
      slot.icon:SetIgnore(false)
    else
      slot.icon:SetMonoTone(true)
      slot.icon:SetAlpha(0.5)
      slot.icon:SetIgnore(false)
    end
  end
end
function PaGlobal_CargoSell:updateList()
  local totalCount = 0
  self._sellTotalPrice = 0
  self._ui._list2_sell:getElementManager():clearKey()
  for index = 0, 19 do
    local CargoSellItemWrapper = ToClient_getCargoSellListItemWrapper(index)
    if nil ~= CargoSellItemWrapper and false == CargoSellItemWrapper:empty() then
      self._ui._list2_sell:getElementManager():pushKey(toInt64(0, index))
      totalCount = totalCount + 1
    end
  end
  if 0 == totalCount then
    self._ui._txt_emptyDesc:SetShow(true)
  else
    self._ui._txt_emptyDesc:SetShow(false)
  end
  PaGlobal_CargoSell._sellTotalPrice = ToClient_GetCargoListTotalMoney()
  PaGlobal_CargoSell._ui._txt_sell_total_price:SetText(makeDotMoney(PaGlobal_CargoSell._sellTotalPrice))
end
function PaGlobal_CargoSell:updateInitSlot(useMaxCount, maxCount, useStartSlot)
  for ii = 0, self._config.slotCount - 1 do
    local slot = self._blankSlots[ii]
    self._slots[ii].icon:SetShow(true)
    slot.empty:SetShow(true)
    slot.lock:SetShow(false)
    slot.plus:SetShow(false)
    slot.onlyPlus:SetShow(false)
    if ii < useMaxCount - useStartSlot - self._startSlotIndex then
      slot.empty:SetShow(true)
    elseif ii == useMaxCount - useStartSlot - self._startSlotIndex and ii < maxCount - useStartSlot - self._startSlotIndex then
      if self._slots[ii].icon:GetShow() then
        local isBuyalbe = false
        slot.lock:SetShow(true)
      else
        slot.plus:SetShow(true)
      end
    elseif ii >= maxCount - useStartSlot - self._startSlotIndex then
      self._slots[ii].icon:SetShow(false)
      slot.empty:SetShow(false)
    else
      slot.lock:SetShow(true)
    end
  end
  UIScroll.SetButtonSize(self._ui._scroll_warehouse, self._config.slotCount, maxCount - useStartSlot)
  for ii = 0, self._config.slotCount - 1 do
    local slot = self._slots[ii]
    slot:clearItem()
    slot.icon:SetEnable(true)
    if false == _ContentsGroup_NewDelivery then
      slot.icon:SetMonoTone(true)
    end
  end
end
function PaGlobal_CargoSell:validate()
  if nil == Panel_Window_CargoSell then
    return
  end
  self._ui._btn_close:isValidate()
  self._ui._stc_warehouseBg:isValidate()
  self._ui._txt_capacity:isValidate()
  self._ui._stc_itemSlotFrame:isValidate()
  self._ui._stc_itemSlotBg:isValidate()
  self._ui._stc_lockIcon:isValidate()
  self._ui._stc_multipleSelect:isValidate()
  self._ui._btn_itemsort:isValidate()
  self._ui._scroll_warehouse:isValidate()
  self._ui._list2_sell:isValidate()
  self._ui._list2_content:isValidate()
  self._ui._txt_emptyDesc:isValidate()
  self._ui._txt_sell_total_price:isValidate()
  self._ui._btn_sell:isValidate()
end
function PaGlobal_CargoSell:SetConsoleKeyGuide_SetAlign()
  local keyGuide = {
    self._ui._stc_keyGuide_A,
    self._ui._stc_keyGuide_Y,
    self._ui._stc_keyGuide_X,
    self._ui._stc_keyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
