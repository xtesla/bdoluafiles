function PaGlobal_SimpleInventory:init()
  self._ui._txt_titleBar = UI.getChildControl(self._ui._titleBar, "StaticText_TitleIcon")
  self._ui._btn_close = UI.getChildControl(self._ui._titleBar, "Button_Win_Close_PCUI")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_SimpleInventory:close(true)")
  self._ui._tabBg = UI.getChildControl(self._ui._invenBG, "Static_TabBg")
  self._ui._topBg = UI.getChildControl(self._ui._invenBG, "Static_TopBg")
  self._ui._mainBg = UI.getChildControl(self._ui._invenBG, "Static_MainSlotBG")
  self._ui._rdoBtn_inven = UI.getChildControl(self._ui._tabBg, "RadioButton_NormalInventory")
  self._ui._rdoBtn_cashInven = UI.getChildControl(self._ui._tabBg, "RadioButton_CashInventory")
  self._ui._rdoBtn_inven:addInputEvent("Mouse_LUp", "PaGlobal_SimpleInventory:selectInventroy(" .. CppEnums.ItemWhereType.eInventory .. ")")
  self._ui._rdoBtn_cashInven:addInputEvent("Mouse_LUp", "PaGlobal_SimpleInventory:selectInventroy(" .. CppEnums.ItemWhereType.eCashInventory .. ")")
  self._ui._stc_keyguideLB = UI.getChildControl(self._ui._tabBg, "Static_LB_ConsoleUI")
  self._ui._stc_keyguideRB = UI.getChildControl(self._ui._tabBg, "Static_RB_ConsoleUI")
  self._ui._btn_SortItem = UI.getChildControl(self._ui._topBg, "CheckBox_ItemSort")
  self._ui._btn_SortItem:addInputEvent("Mouse_LUp", "HandleEventLUp_SimpleInventory_SortItem()")
  self._ui._btn_SortItem:SetEnableArea(0, 0, self._ui._btn_SortItem:GetTextSizeX(), self._ui._btn_SortItem:GetSizeY())
  self._ui._btn_SortItem:SetCheck(true)
  self._ui._txt_money = UI.getChildControl(self._ui._topBg, "Static_Text_Money")
  self._ui._btn_money = UI.getChildControl(self._ui._topBg, "Button_Money")
  if true == _ContentsGroup_SimpleInvenSearch then
    self._ui._btn_search = UI.getChildControl(self._ui._topBg, "Button_Search")
    self._ui._btn_search:SetShow(true)
    self._ui._btn_search:addInputEvent("Mouse_LUp", "PaGlobal_SimpleInventory_SearchResult:prepareOpen()")
    self._ui._btn_search:addInputEvent("Mouse_On", "PaGlobalFunc_SimpleInventory_ShowSimpleToolTipSearch(true)")
    self._ui._btn_search:addInputEvent("Mouse_Out", "PaGlobalFunc_SimpleInventory_ShowSimpleToolTipSearch(false)")
    self._ui._btn_SortItem:SetPosX(self._ui._btn_search:GetPosX() + self._ui._btn_search:GetSizeX() + 5)
  end
  self._ui._scroll = UI.getChildControl(self._ui._mainBg, "Scroll_CashInven")
  UIScroll.InputEvent(self._ui._scroll, "HandleEventScroll_SimpleInventory")
  UIScroll.SetButtonSize(self._ui._scroll, self._config._slotCount, self._config._inventoryMax)
  UIScroll.InputEventByControl(self._ui._mainBg, "HandleEventScroll_SimpleInventory")
  local tmpSlotBg = UI.getChildControl(self._ui._mainBg, "Static_SlotBg_Template")
  local tmpLockSlotBg = UI.getChildControl(self._ui._mainBg, "Static_LockedSlotBg_Template")
  local gapX = tmpSlotBg:GetSizeX() + self._config._initPosX
  local gapY = tmpSlotBg:GetSizeY() + self._config._initPosY
  for ii = 0, self._config._slotCount - 1 do
    local slot = {
      bg = nil,
      icon = nil,
      lock = nil
    }
    local row = math.floor(ii / self._config._slotCols)
    local col = ii % self._config._slotCols
    slot.lock = UI.createControl(__ePAUIControl_Static, self._ui._mainBg, "slotLockBg_" .. ii)
    CopyBaseProperty(tmpLockSlotBg, slot.lock)
    slot.lock:SetPosX(self._config._initPosX + gapX * col)
    slot.lock:SetPosY(self._config._initPosY + gapY * row)
    slot.lock:SetShow(false)
    slot.bg = UI.createControl(__ePAUIControl_Static, self._ui._mainBg, "slotBg_" .. ii)
    CopyBaseProperty(tmpSlotBg, slot.bg)
    slot.bg:SetPosX(self._config._initPosX + gapX * col)
    slot.bg:SetPosY(self._config._initPosY + gapY * row)
    slot.bg:SetShow(false)
    SlotItem.new(slot, "slotIcon_" .. ii, ii, slot.bg, self._slotConfig)
    slot:createChild()
    slot.icon:SetShow(true)
    UIScroll.InputEventByControl(slot.icon, "HandleEventScroll_SimpleInventory")
    UIScroll.InputEventByControl(slot.lock, "HandleEventScroll_SimpleInventory")
    self._slots[ii] = slot
  end
  deleteControl(tmpSlotBg)
  deleteControl(tmpLockSlotBg)
  self._ui.stc_circle = UI.getChildControl(self._ui._equipBG, "Static_MainCircle")
  for slotNo = self._EquipNoMin, self._EquipNoMax - 1 do
    if true == PaGlobal_SimpleInventory:checkUsableSlot(slotNo) then
      local slotBG = UI.getChildControl(self._ui.stc_circle, self._slotNoId[slotNo] .. "_BG")
      slotBG:SetShow(false)
      self._equipSlotBG[slotNo] = slotBG
      local slot = {}
      slot.icon = UI.getChildControl(self._ui.stc_circle, self._slotNoId[slotNo])
      SlotItem.new(slot, "Equipment_" .. slotNo, slotNo, self._ui._equipBG, self._equipSlotConfig)
      slot:createChild()
      Panel_Tooltip_Item_SetPosition(slotNo, slot, "simpleEquipment")
      self._equipSlot[slotNo] = slot
    end
  end
  self._ui.stc_abilityArea = UI.getChildControl(self._ui._equipBG, "Static_AbilityArea")
  self._ui.stc_offenceIcon = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Attack")
  self._ui.txt_offenceText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Attack_Value")
  self._ui.stc_defenceIcon = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Defence")
  self._ui.txt_defenceText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Defence_Value")
  self._ui.stc_awakenOffenceIcon = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_AwakenAttack")
  self._ui.txt_awakenOffenceText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_AwakenAttack_Value")
  self._ui.stc_shyAwakenIcon = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_ShyStat1_Title")
  self._ui.txt_shyAwakenText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_ShyStat1_Value")
  self._ui.stc_offenceIcon:addInputEvent("Mouse_On", "HandleEventOnOut_SimpleInventory_StatTooltip(0, true)")
  self._ui.stc_offenceIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_StatTooltip(0, false)")
  self._ui.stc_defenceIcon:addInputEvent("Mouse_On", "HandleEventOnOut_SimpleInventory_StatTooltip(1, true)")
  self._ui.stc_defenceIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_StatTooltip(1, false)")
  self._ui.stc_awakenOffenceIcon:addInputEvent("Mouse_On", "HandleEventOnOut_SimpleInventory_StatTooltip(2, true)")
  self._ui.stc_awakenOffenceIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_StatTooltip(2, false)")
  self._ui.stc_shyAwakenIcon:addInputEvent("Mouse_On", "HandleEventOnOut_SimpleInventory_StatTooltip(3, true)")
  self._ui.stc_shyAwakenIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_StatTooltip(3, false)")
  self._ui.btn_equipCrystal = UI.getChildControl(self._ui._equipBG, "Button_EquipCrystal")
  self._ui.btn_equipCrystal:addInputEvent("Mouse_On", "PAGlobalFunc_CrystalTooltip_Show_ForSimpleItem(true)")
  self._ui.btn_equipCrystal:addInputEvent("Mouse_Out", "PAGlobalFunc_CrystalTooltip_Show_ForSimpleItem(false)")
  self._ui.btn_equipCrystal:addInputEvent("Mouse_LUp", "PAGlobalFunc_CrystalTooltip_ToggleDetail_ForSimpleItem()")
  local underwearSlotBG = self._equipSlotBG[CppEnums.EquipSlotNo.avatarUnderWear]
  if nil ~= underwearSlotBG then
    self._originUnderWearSpanX = underwearSlotBG:GetSpanSize().x
  end
  local faceDecoSlotBG = self._equipSlotBG[CppEnums.EquipSlotNo.faceDecoration2]
  if nil ~= faceDecoSlotBG then
    self._changeUnderWearSpanX = faceDecoSlotBG:GetSpanSize().x
  end
  self._ui.stc_blankSlotTooltip = UI.getChildControl(self._ui._equipBG, "StaticText_Notice_1")
  self._ui.stc_blankSlotTooltip:SetColor(Defines.Color.C_FFFFFFFF)
  self._ui.stc_blankSlotTooltip:SetFontColor(Defines.Color.C_FFC4BEBE)
  self._ui.stc_blankSlotTooltip:SetTextHorizonCenter()
  self._ui.txt_selectedCharName = UI.getChildControl(self._ui._characterBG, "StaticText_SelectedName")
  self._ui.btn_prevChar = UI.getChildControl(self._ui._characterBG, "Button_Before")
  self._ui.btn_nextChar = UI.getChildControl(self._ui._characterBG, "Button_Next")
  self._ui.btn_prevChar:addInputEvent("Mouse_LUp", "HandleEventLUp_SimpleInventory_ChangeCharacter(false)")
  self._ui.btn_nextChar:addInputEvent("Mouse_LUp", "HandleEventLUp_SimpleInventory_ChangeCharacter(true)")
  self._characterDataCount = getCharacterDataCount()
  local selfProxy = getSelfPlayer()
  if nil ~= selfProxy then
    self._currentCharacterNo = selfProxy:getCharacterNo_64()
    PaGlobal_SimpleInventory:setCurrentCharacterIndex()
  end
  self._ui._stc_keyguideLS = UI.getChildControl(self._ui._keyguideBg, "StaticText_Sort_ConsoleUI")
  self._ui._stc_keyguideX = UI.getChildControl(self._ui._keyguideBg, "StaticText_X_ConsoleUI")
  self._ui._stc_keyguideY = UI.getChildControl(self._ui._keyguideBg, "StaticText_Y_ConsoleUI")
  self._ui._stc_keyguideB = UI.getChildControl(self._ui._keyguideBg, "StaticText_B_ConsoleUI")
  self._ui._stc_keyguideLT = UI.getChildControl(self._ui._keyguideBg, "StaticText_Ltrigger_ConsoleUI")
  self._ui._stc_keyguideRT = UI.getChildControl(self._ui._keyguideBg, "StaticText_Rtrigger_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_SimpleInventory:setConsoleUI()
  PaGlobal_SimpleInventory:validate()
  self._originPanelSizeX = Panel_Window_SimpleInventory:GetSizeX()
  registerEvent("FromClient_LoadCompleteSimpleItem", "FromClient_SimpleInventory_LoadCompleteSimpleItem")
  registerEvent("FromClient_LoadCompleteOtherPlayerSimpleItem", "FromClient_SimpleInventory_LoadCompleteOtherPlayerSimpleItem")
end
function PaGlobal_SimpleInventory:setCurrentCharacterIndex()
  for idx = 0, self._characterDataCount - 1 do
    local data = getCharacterDataByIndex(idx)
    if nil ~= data and data._characterNo_s64 == self._currentCharacterNo then
      self._currentCharacterIndex = idx
      return
    end
  end
end
function PaGlobal_SimpleInventory:setConsoleUI()
  if true == self._isConsole then
    self._ui._btn_close:SetShow(false)
    self._ui._btn_SortItem:SetShow(false)
    self._ui.btn_equipCrystal:SetShow(false)
    self._ui.btn_prevChar:SetShow(false)
    self._ui.btn_nextChar:SetShow(false)
    PaGlobal_SimpleInventory:updateSortKeyguide()
    self._ui.stc_abilityArea:SetSpanSize(self._ui.stc_abilityArea:GetSpanSize().x, self._ui.stc_abilityArea:GetSpanSize().y + 20)
    self._ui._stc_keyguideLB:SetShow(true)
    self._ui._stc_keyguideRB:SetShow(true)
    if nil ~= Panel_Window_SimpleInventory then
      Panel_Window_SimpleInventory:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobalFunc_SimpleInventory_SelectInventoryForConsole(true)")
      Panel_Window_SimpleInventory:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobalFunc_SimpleInventory_SelectInventoryForConsole(false)")
      Panel_Window_SimpleInventory:registerPadEvent(__eConsoleUIPadEvent_LSClick, "PaGlobalFunc_SimpleInventory_SortItemForConsole()")
      Panel_Window_SimpleInventory:registerPadEvent(__eConsoleUIPadEvent_LT, "HandleEventLUp_SimpleInventory_ChangeCharacter(false)")
      Panel_Window_SimpleInventory:registerPadEvent(__eConsoleUIPadEvent_RT, "HandleEventLUp_SimpleInventory_ChangeCharacter(true)")
      Panel_Window_SimpleInventory:registerPadEvent(__eConsoleUIPadEvent_Y, "PAGlobalFunc_SimpleInventory_ShowCrystalInfoForConsole()")
    end
    PaGlobal_SimpleInventory:alignKeyGuides()
    Panel_Window_SimpleInventory:ignorePadSnapMoveToOtherPanel()
  end
end
function PaGlobal_SimpleInventory:alignKeyGuides()
  if true == self._isConsole then
    local keyGuides = {
      self._ui._stc_keyguideLS,
      self._ui._stc_keyguideY,
      self._ui._stc_keyguideLT,
      self._ui._stc_keyguideRT,
      self._ui._stc_keyguideX,
      self._ui._stc_keyguideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_SimpleInventory:updateSortKeyguide()
  if false == self._ui._btn_SortItem:IsCheck() then
    self._ui._stc_keyguideLS:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SORT"))
  else
    self._ui._stc_keyguideLS:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_KEYGUIDE_UNSORT"))
  end
  self:alignKeyGuides()
end
function PaGlobal_SimpleInventory:clear()
  self._invenWrapper = nil
  self._equipWrapper = nil
  self._ui._rdoBtn_inven:SetCheck(CppEnums.ItemWhereType.eInventory == self._itemWhereType)
  self._ui._rdoBtn_cashInven:SetCheck(CppEnums.ItemWhereType.eCashInventory == self._itemWhereType)
  self._ui._txt_money:SetText("0")
  self._ui._btn_money:SetPosX(self._ui._topBg:GetSizeX() - self._ui._txt_money:GetTextSizeX() - 60)
  self._selectedCharacterNo = nil
  self._selectedCharacterEquipAwakenWeapon = false
  self._searchItemWhereType = nil
  TooltipSimple_Hide()
end
function PaGlobal_SimpleInventory:slotsClear()
  self._currentItemCount = 0
  for ii = 0, self._config._slotCount - 1 do
    local slot = self._slots[ii]
    slot:clearItem()
    slot.lock:SetShow(true)
    slot.bg:SetShow(false)
  end
end
function PaGlobal_SimpleInventory:open(characterNo_s64)
  if nil == Panel_Window_SimpleInventory then
    return
  end
  PaGlobal_SimpleInventory:prepareOpen(true)
  self:clear()
  self._selectedCharacterNo = characterNo_s64
  self._selectedCharacterEquipAwakenWeapon = false
  local invenWrapper = ToClient_SimpleInventoryWrapper(characterNo_s64)
  if nil == invenWrapper then
    return
  end
  self._invenWrapper = invenWrapper
  self._ui._txt_money:SetText(makeDotMoney(self._invenWrapper:getMoney_s64()))
  self._ui._btn_money:SetPosX(self._ui._topBg:GetSizeX() - self._ui._txt_money:GetTextSizeX() - 50)
  self:selectInventroy(self._itemWhereType)
  local equipWrapper = ToClient_SimpleEquipmentWrapper(characterNo_s64)
  if nil == equipWrapper then
    return
  end
  self._equipWrapper = equipWrapper
  self:updateEquipment()
  self._ui.btn_prevChar:setRenderTexture(self._ui.btn_prevChar:getBaseTexture())
  self._ui.btn_nextChar:setRenderTexture(self._ui.btn_nextChar:getBaseTexture())
  self:updateStat()
  Panel_Window_SimpleInventory:SetShow(true)
end
function PaGlobal_SimpleInventory:openOtherPlayerInventory()
  if nil == Panel_Window_SimpleInventory then
    return
  end
  PaGlobal_SimpleInventory:prepareOpen(false)
  self:clear()
  local invenWrapper = ToClient_OtherPlayerSimpleInventoryWrapper()
  if nil == invenWrapper then
    return
  end
  self._invenWrapper = invenWrapper
  self._ui._txt_money:SetText(makeDotMoney(self._invenWrapper:getMoney_s64()))
  self._ui._btn_money:SetPosX(self._ui._topBg:GetSizeX() - self._ui._txt_money:GetTextSizeX() - 50)
  self:selectInventroy(CppEnums.ItemWhereType.eInventory)
  self._ui._equipBG:SetShow(false)
  local characterName = ToClient_GetOtherPlayerCharacterName()
  if nil == characterName then
    return
  end
  self._ui.txt_selectedCharName:SetText(characterName)
  Panel_Window_SimpleInventory:SetShow(true)
end
function PaGlobal_SimpleInventory:prepareOpen(isMyCharacter)
  if self._ui._equipBG:GetShow() == isMyCharacter then
    return
  end
  local grayLine = UI.getChildControl(self._ui._characterBG, "Static_Line")
  self._ui._equipBG:SetShow(isMyCharacter)
  self._ui.btn_nextChar:SetShow(isMyCharacter)
  self._ui.btn_prevChar:SetShow(isMyCharacter)
  grayLine:SetShow(isMyCharacter)
  if true == isMyCharacter then
    Panel_Window_SimpleInventory:SetSize(self._originPanelSizeX, Panel_Window_SimpleInventory:GetSizeY())
    self._ui._characterBG:SetSize(self._originPanelSizeX, self._ui._characterBG:GetSizeY())
    self._ui._titleBar:SetSize(self._originPanelSizeX, self._ui._titleBar:GetSizeY())
    self._ui._txt_titleBar:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_SUBINVENTORY_TITLE"))
  else
    Panel_Window_SimpleInventory:SetSize(self._ui._invenBG:GetSizeX(), Panel_Window_SimpleInventory:GetSizeY())
    self._ui._characterBG:SetSize(self._ui._invenBG:GetSizeX(), self._ui._characterBG:GetSizeY())
    self._ui._titleBar:SetSize(self._ui._invenBG:GetSizeX(), self._ui._titleBar:GetSizeY())
    self._ui._txt_titleBar:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEEXIT_VIEW_INVENTORY"))
  end
  Panel_Window_SimpleInventory:ComputePosAllChild()
end
function PaGlobal_SimpleInventory:close(isCloseAll)
  if nil == Panel_Window_SimpleInventory then
    return
  end
  TooltipSimple_Hide()
  if true == _ContentsGroup_SimpleInvenSearch and nil ~= Panel_Window_SimpleInventory_SearchResult and true == Panel_Window_SimpleInventory_SearchResult:GetShow() then
    PaGlobal_SimpleInventory_SearchResult:prepareClose()
    if true ~= isCloseAll then
      return
    end
  end
  if true == self._isConsole then
    if nil ~= Panel_Window_Inventory_Detail and true == Panel_Window_Inventory_Detail:GetShow() then
      PaGlobal_InventoryEquip_Detail_Renew_Close()
      return
    end
  else
    PAGlobalFunc_CrystalTooltip_Show_ForSimpleItem(false)
  end
  self._itemWhereType = CppEnums.ItemWhereType.eInventory
  self:itemTooltip_Hide()
  Panel_Window_SimpleInventory:SetShow(false)
end
function PaGlobal_SimpleInventory:requestSimpleInventory(index)
  local data = getCharacterDataByIndex(index)
  if nil == data then
    return
  end
  if true == _ContentsGroup_PreSeason and data._characterSeasonType == __eCharacterSeasonType_Season then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_1"))
    return
  end
  self._selectedCharacterClassType = getCharacterClassType(data)
  self._selectedCharacterIndex = index
  self._ui.txt_selectedCharName:SetText(getCharacterName(data))
  PaGlobal_SimpleInventory:updateChangeButton(index)
  PaGlobal_SimpleInventory:clearSearchItemInfo(false, true)
  PaGlobal_SimpleInventory:clearSearchEquipItemInfo(false, true)
  ToClient_requestSimpleItem(index)
end
function PaGlobal_SimpleInventory:itemTooltip_Show(itemEnchantKey, index)
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  local control = Panel_Window_SimpleInventory
  if nil ~= itemSSW and nil ~= control then
    Panel_Tooltip_Item_Show(itemSSW, control, true)
  end
end
function PaGlobal_SimpleInventory:itemTooltip_Hide()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_SimpleInventory:setSlot(itemSSW, itemCount_s64)
  if nil == itemSSW then
    return
  end
  local slot = self._slots[self._currentItemCount]
  if nil == slot then
    return
  end
  slot:setItemByStaticStatus(itemSSW, itemCount_s64)
  if false == self._isConsole then
    slot.icon:addInputEvent("Mouse_On", "PaGlobal_SimpleInventory:itemTooltip_Show(" .. itemSSW:get()._key:get() .. "," .. self._currentItemCount .. ")")
    slot.icon:addInputEvent("Mouse_Out", "PaGlobal_SimpleInventory:itemTooltip_Hide()")
  elseif false == _ContentsGroup_RenewUI_Tooltip then
    slot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_SimpleInventory:itemTooltip_Show(" .. itemSSW:get()._key:get() .. "," .. self._currentItemCount .. ")")
    slot.bg:addInputEvent("Mouse_Out", "PaGlobal_SimpleInventory:itemTooltip_Hide()")
  else
    slot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_SimpleInventory_ShowItemTooltipForConsole(" .. itemSSW:get()._key:get() .. ")")
  end
  slot.lock:SetShow(false)
  slot.bg:SetShow(true)
  self._currentItemCount = self._currentItemCount + 1
end
function PaGlobal_SimpleInventory:selectInventroy(itemWhereType)
  if nil == Panel_Window_SimpleInventory then
    return
  end
  if CppEnums.ItemWhereType.eInventory ~= itemWhereType and CppEnums.ItemWhereType.eCashInventory ~= itemWhereType then
    return
  end
  self._currentIndex = 0
  self._maxSlotCount = self._invenWrapper:getInventorySize(itemWhereType)
  self._itemWhereType = itemWhereType
  self._ui._scroll:SetControlTop()
  self._ui._scroll:SetControlPos(0)
  self._ui._rdoBtn_inven:SetCheck(CppEnums.ItemWhereType.eInventory == itemWhereType)
  self._ui._rdoBtn_cashInven:SetCheck(CppEnums.ItemWhereType.eCashInventory == itemWhereType)
  self:sortItem()
  self:updateSlot()
end
function PaGlobal_SimpleInventory:updateSlot()
  self:slotsClear()
  PaGlobal_SimpleInventory:updateSearchItem()
  for ii = self._currentIndex, self._maxSlotCount do
    if self._config._slotCount <= self._currentItemCount then
      return
    end
    local itemWrapper
    if self._ui._btn_SortItem:IsCheck() then
      itemWrapper = self._invenWrapper:getSimpleItemWrapper(self._itemWhereType, self._sortedItemList[ii + 1])
    else
      itemWrapper = self._invenWrapper:getSimpleItemWrapper(self._itemWhereType, ii)
    end
    if nil ~= itemWrapper then
      local itemSSW = getItemEnchantStaticStatus(itemWrapper:getItemEnchantKey())
      if nil ~= itemSSW then
        self:setSlot(itemSSW, itemWrapper:getItemCount_s64())
      end
    end
  end
end
function PaGlobal_SimpleInventory:sortItem()
  self._sortedItemList:fill(0, self._maxSlotCount)
  if self._ui._btn_SortItem:IsCheck() then
    local sortList = Array.new()
    sortList:fill(0, self._maxSlotCount)
    sortList:quicksort(PaGlobalFunc_SimpleInventory_ItemComparer)
    for ii = 0, self._maxSlotCount do
      self._sortedItemList[ii] = sortList[ii]
    end
  end
  self:updateSlot()
  self:updateSearchItem()
end
function PaGlobal_SimpleInventory:checkUsableSlot(index)
  if index == self._UnUsedEquipNo_01 or index == self._UnUsedEquipNo_02 or index == CppEnums.EquipSlotNo.equipSlotNoCount or index == CppEnums.EquipSlotNo.explorationBonus0 or index == CppEnums.EquipSlotNo.installation4 or index == CppEnums.EquipSlotNo.body or index == CppEnums.EquipSlotNo.avatarBody then
    return false
  end
  return true
end
function PaGlobal_SimpleInventory:updateEquipment()
  self._extendedSlotInfoArray = {}
  local checkExtendedSlot = false
  local classType = self._selectedCharacterClassType
  for slotNo = self._EquipNoMin, self._EquipNoMax - 1 do
    if true == PaGlobal_SimpleInventory:checkUsableSlot(slotNo) then
      PaGlobal_SimpleInventory:setEquipSlotBGIcon(slotNo, classType)
      local equipItemWrapper = self._equipWrapper:getSimpleEquipItemWrapper(slotNo)
      if nil == equipItemWrapper then
        return
      end
      local slotBG = self._equipSlotBG[slotNo]
      local slot = self._equipSlot[slotNo]
      if nil == slotBG or nil == slot then
        return
      end
      local itemWrapper = equipItemWrapper:getItem()
      if nil ~= itemWrapper then
        local itemSSW = itemWrapper:getStaticStatus()
        local slotNoMax = itemSSW:getExtendedSlotCount()
        for i = 1, slotNoMax do
          local extendSlotNo = itemSSW:getExtendedSlotIndex(i - 1)
          if slotNoMax ~= extendSlotNo then
            self._extendedSlotInfoArray[extendSlotNo] = slotNo
            checkExtendedSlot = true
          end
        end
        PaGlobal_SimpleInventory:setItemInfoUseWrapper(slot, itemWrapper, false, false, slotNo)
        slotBG:SetShow(false)
        slot.icon:SetEnable(true)
        slot.icon:SetShow(true)
        if CppEnums.EquipSlotNo.awakenWeapon == slotNo then
          self._selectedCharacterEquipAwakenWeapon = true
        end
        if false == self._isConsole then
          slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SimpleInventory_EquipmentTooltip(" .. slotNo .. ",true)")
          slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_EquipmentTooltip(" .. slotNo .. ",false)")
        elseif false == _ContentsGroup_RenewUI_Tooltip then
          slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SimpleInventory_EquipmentTooltip(" .. slotNo .. ",true)")
          slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_EquipmentTooltip(" .. slotNo .. ",false)")
        else
          slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_SimpleInventory_ShowEquipItemTooltipForConsole(" .. slotNo .. ")")
        end
        local isDuplicatedItem = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
        if true == isDuplicatedItem then
          slot.duplicatedForDuelIcon:SetShow(true)
        end
      else
        slot:clearItem()
        slot.icon:SetEnable(true)
        slotBG:SetShow(true)
        local useAwakenWeapon = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType)
        if CppEnums.EquipSlotNo.awakenWeapon == slotNo then
          slotBG:SetShow(useAwakenWeapon)
          slot.icon:SetEnable(useAwakenWeapon)
          slot.icon:SetShow(useAwakenWeapon)
          self._selectedCharacterEquipAwakenWeapon = false
        elseif CppEnums.EquipSlotNo.avatarAwakenWeapon == slotNo then
          local isShow = useAwakenWeapon
          if __eClassType_ShyWaman == classType then
            isShow = false
          end
          slotBG:SetShow(isShow)
          slot.icon:SetEnable(isShow)
          slot.icon:SetShow(isShow)
        end
        if false == self._isConsole then
          slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SimpleInventory_EmptySlotTooltip(" .. slotNo .. ",true)")
          slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_EmptySlotTooltip(" .. slotNo .. ",false)")
        end
        if CppEnums.EquipSlotNo.lantern == slotNo then
          slot.icon:SetShow(false)
          slotBG:SetShow(false)
        end
      end
    end
  end
  if true == checkExtendedSlot then
    PaGlobal_SimpleInventory:updateExtendedSlot()
  end
end
function PaGlobal_SimpleInventory:updateExtendedSlot()
  if nil == Panel_Window_SimpleInventory then
    return
  end
  if nil == self._extendedSlotInfoArray then
    return
  end
  for extendSlotNo, parentSlotNo in pairs(self._extendedSlotInfoArray) do
    if nil ~= extendSlotNo and nil ~= parentSlotNo then
      local parrentEquipItemWrapper = self._equipWrapper:getSimpleEquipItemWrapper(parentSlotNo)
      if nil == parrentEquipItemWrapper then
        return
      end
      local setSlotBG = self._equipSlotBG[extendSlotNo]
      local slot = self._equipSlot[extendSlotNo]
      if nil == setSlotBG or nil == slot then
        return
      end
      local itemWrapper = parrentEquipItemWrapper:getItem()
      if nil ~= itemWrapper then
        setSlotBG:SetShow(false)
        PaGlobal_SimpleInventory:setItemInfoUseWrapper(slot, itemWrapper, true, true)
      end
    end
  end
end
function PaGlobal_SimpleInventory:setEquipSlotBGIcon(slotNo, classType)
  if nil == slotNo or nil == classType then
    return
  end
  if slotNo < self._EquipNoMin or slotNo >= self._EquipNoMax then
    return
  end
  local slotBG = self._equipSlotBG[slotNo]
  local slot = self._equipSlot[slotNo]
  if nil == slotBG or nil == slot then
    return
  end
  if __eClassType_ShyWaman == classType then
    if CppEnums.EquipSlotNo.awakenWeapon == slotNo then
      slotBG:ChangeTextureInfoName("combine/icon/combine_equip_icon_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(slotBG, 283, 48, 329, 94)
      slotBG:getBaseTexture():setUV(x1, y1, x2, y2)
      slotBG:setRenderTexture(slotBG:getBaseTexture())
    elseif CppEnums.EquipSlotNo.avatarAwakenWeapon == slotNo then
      slotBG:ChangeTextureInfoName("combine/icon/combine_equip_icon_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(slotBG, 330, 48, 376, 94)
      slotBG:getBaseTexture():setUV(x1, y1, x2, y2)
      slotBG:setRenderTexture(slotBG:getBaseTexture())
    end
  elseif CppEnums.EquipSlotNo.awakenWeapon == slotNo then
    slotBG:ChangeTextureInfoName("combine/icon/combine_equip_icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(slotBG, 95, 1, 141, 47)
    slotBG:getBaseTexture():setUV(x1, y1, x2, y2)
    slotBG:setRenderTexture(slotBG:getBaseTexture())
  elseif CppEnums.EquipSlotNo.avatarAwakenWeapon == slotNo then
    slotBG:ChangeTextureInfoName("combine/icon/combine_equip_icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(slotBG, 95, 95, 141, 141)
    slotBG:getBaseTexture():setUV(x1, y1, x2, y2)
    slotBG:setRenderTexture(slotBG:getBaseTexture())
  end
  local underwearSlotNo = CppEnums.EquipSlotNo.avatarUnderWear
  local underwearSlotBG = self._equipSlotBG[underwearSlotNo]
  local underwearSlot = self._equipSlot[underwearSlotNo]
  if nil == underwearSlotBG or nil == underwearSlot then
    return
  end
  local spanY = underwearSlotBG:GetSpanSize().y
  if __eClassType_ShyWaman == classType or false == PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType) then
    underwearSlotBG:SetSpanSize(self._changeUnderWearSpanX, spanY)
    underwearSlot.icon:SetSpanSize(self._changeUnderWearSpanX, spanY)
  else
    underwearSlotBG:SetSpanSize(self._originUnderWearSpanX, spanY)
    underwearSlot.icon:SetSpanSize(self._originUnderWearSpanX, spanY)
  end
end
function PaGlobal_SimpleInventory:setItemInfoUseWrapper(slot, itemWrapper, isMono, isExtended, slotNo)
  slot:setItem(itemWrapper, slotNo, true)
  if false == isExtended then
    slot.icon:SetEnable(true)
  else
    slot.icon:SetEnable(false)
  end
  if true == isMono then
    slot.icon:SetMonoTone(true)
  elseif false == isMono then
    slot.icon:SetMonoTone(false)
  end
end
function PaGlobal_SimpleInventory:updateChangeButton(index)
  local preCharacterShow = -1 ~= PaGlobal_SimpleInventory:getNextIndex(false, index)
  local nextCharacterShow = -1 ~= PaGlobal_SimpleInventory:getNextIndex(true, index)
  local prevIndex = index - 1
  local prevShow = true
  if prevIndex == self._currentCharacterIndex then
    prevIndex = prevIndex - 1
  end
  if prevIndex < 0 then
    prevShow = false
  end
  if false == self._isConsole then
    self._ui.btn_prevChar:SetShow(preCharacterShow)
  else
    self._ui._stc_keyguideLT:SetShow(preCharacterShow)
  end
  local nextIndex = index + 1
  local nextShow = true
  if nextIndex == self._currentCharacterIndex then
    nextIndex = nextIndex + 1
  end
  if nextIndex >= self._characterDataCount then
    nextShow = false
  end
  if false == self._isConsole then
    self._ui.btn_nextChar:SetShow(nextCharacterShow)
  else
    self._ui._stc_keyguideRT:SetShow(nextCharacterShow)
  end
  if true == self._isConsole then
    self:alignKeyGuides()
  end
end
function PaGlobal_SimpleInventory:updateStat()
  if nil == self._selectedCharacterNo then
    return
  end
  local statWrapper = ToClient_SimpleStatWrapper(self._selectedCharacterNo)
  if nil == statWrapper then
    return
  end
  local offence = statWrapper:getOffence()
  local defence = statWrapper:getDefence()
  local awakenOffence = statWrapper:getAwakenOffence()
  self._ui.txt_offenceText:SetText(tostring(offence))
  self._ui.txt_defenceText:SetText(tostring(defence))
  local awakenWeaponContentsOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(self._selectedCharacterClassType)
  if false == awakenWeaponContentsOpen or false == self._selectedCharacterEquipAwakenWeapon then
    self._ui.stc_shyAwakenIcon:SetShow(false)
    self._ui.txt_shyAwakenText:SetShow(false)
    self._ui.stc_awakenOffenceIcon:SetShow(false)
    self._ui.txt_awakenOffenceText:SetShow(false)
    self._ui.stc_offenceIcon:SetSpanSize(110, self._ui.stc_offenceIcon:GetSpanSize().y)
    self._ui.txt_offenceText:SetSpanSize(90, self._ui.txt_offenceText:GetSpanSize().y)
    self._ui.stc_defenceIcon:SetSpanSize(110, self._ui.stc_defenceIcon:GetSpanSize().y)
    self._ui.txt_defenceText:SetSpanSize(90, self._ui.txt_defenceText:GetSpanSize().y)
  else
    if __eClassType_ShyWaman == self._selectedCharacterClassType then
      self._ui.stc_shyAwakenIcon:SetShow(true)
      self._ui.txt_shyAwakenText:SetShow(true)
      self._ui.stc_awakenOffenceIcon:SetShow(false)
      self._ui.txt_awakenOffenceText:SetShow(false)
      self._ui.txt_shyAwakenText:SetText(tostring(awakenOffence))
    else
      self._ui.stc_shyAwakenIcon:SetShow(false)
      self._ui.txt_shyAwakenText:SetShow(false)
      self._ui.stc_awakenOffenceIcon:SetShow(true)
      self._ui.txt_awakenOffenceText:SetShow(true)
      self._ui.txt_awakenOffenceText:SetText(tostring(awakenOffence))
    end
    self._ui.stc_offenceIcon:SetSpanSize(90, self._ui.stc_offenceIcon:GetSpanSize().y)
    self._ui.txt_offenceText:SetSpanSize(70, self._ui.txt_offenceText:GetSpanSize().y)
    self._ui.stc_defenceIcon:SetSpanSize(90, self._ui.stc_defenceIcon:GetSpanSize().y)
    self._ui.txt_defenceText:SetSpanSize(70, self._ui.txt_defenceText:GetSpanSize().y)
  end
end
function PaGlobal_SimpleInventory:getNextIndex(isNext, selectIndex)
  local changeIndex = selectIndex
  if true == isNext then
    changeIndex = changeIndex + 1
  else
    changeIndex = changeIndex - 1
  end
  if changeIndex == PaGlobal_SimpleInventory._currentCharacterIndex then
    if true == isNext then
      changeIndex = changeIndex + 1
    else
      changeIndex = changeIndex - 1
    end
  end
  local data = getCharacterDataByIndex(changeIndex)
  if nil == data then
    return -1
  end
  local removeTime = getCharacterDataRemoveTime(changeIndex)
  if true == _ContentsGroup_PreSeason and data._characterSeasonType == __eCharacterSeasonType_Season or nil ~= removeTime then
    local index = PaGlobal_SimpleInventory:getNextIndex(isNext, changeIndex)
    return index
  end
  return changeIndex
end
function PaGlobal_SimpleInventory:validate()
  if nil == Panel_Window_SimpleInventory then
    UI.ASSERT_NAME(false, "Panel_Window_SimpleInventory\236\157\180 \235\161\156\235\147\156\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.", "\236\154\176\236\160\149\235\172\180")
    return
  end
  self._ui._txt_titleBar:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._tabBg:isValidate()
  self._ui._topBg:isValidate()
  self._ui._mainBg:isValidate()
  self._ui._rdoBtn_inven:isValidate()
  self._ui._rdoBtn_cashInven:isValidate()
  self._ui._stc_keyguideLB:isValidate()
  self._ui._stc_keyguideRB:isValidate()
  self._ui._btn_SortItem:isValidate()
  self._ui._txt_money:isValidate()
  self._ui._btn_money:isValidate()
  self._ui._scroll:isValidate()
  self._ui.stc_circle:isValidate()
  self._ui.btn_equipCrystal:isValidate()
  self._ui.stc_blankSlotTooltip:isValidate()
  self._ui.stc_abilityArea:isValidate()
  self._ui.stc_offenceIcon:isValidate()
  self._ui.txt_offenceText:isValidate()
  self._ui.stc_defenceIcon:isValidate()
  self._ui.txt_defenceText:isValidate()
  self._ui.stc_awakenOffenceIcon:isValidate()
  self._ui.txt_awakenOffenceText:isValidate()
  self._ui.stc_shyAwakenIcon:isValidate()
  self._ui.txt_shyAwakenText:isValidate()
  self._ui.txt_selectedCharName:isValidate()
  self._ui.btn_prevChar:isValidate()
  self._ui.btn_nextChar:isValidate()
  self._ui._stc_keyguideLS:isValidate()
  self._ui._stc_keyguideX:isValidate()
  self._ui._stc_keyguideY:isValidate()
  self._ui._stc_keyguideB:isValidate()
  self._ui._stc_keyguideLT:isValidate()
  self._ui._stc_keyguideRT:isValidate()
end
function PaGlobal_SimpleInventory:searchItem(selectIndex, itemWhereType, slotNo)
  self:requestSimpleInventory(selectIndex)
  self:clearSearchItemInfo(true, true)
  self:clearSearchEquipItemInfo(true, true)
  if CppEnums.ItemWhereType.eEquip == itemWhereType then
    slot = self._equipSlot[slotNo]
    if nil ~= slot then
      table.insert(self._searchItemEquipSlotList, slotNo)
    end
  else
    self._searchItemWhereType = itemWhereType
    table.insert(self._searchItemSlotList, slotNo)
    self:selectInventroy(itemWhereType)
  end
  self:scrollToSearchItem()
  self:updateSearchItemEquip()
  self:updateSearchItem()
end
function PaGlobal_SimpleInventory:searchItemByItemEnchantKey(selectIndex, itemWhereType, itemEnchantKey)
  if nil == Panel_Window_SimpleInventory then
    return
  end
  self:requestSimpleInventory(selectIndex)
  self:clearSearchItemInfo(true, true)
  self:clearSearchEquipItemInfo(true, true)
  self._searchItemWhereType = itemWhereType
  self:selectInventroy(itemWhereType)
  for slotNo, slotControl in pairs(self._equipSlot) do
    if nil ~= slotNo and nil ~= slotControl then
      local equipItemWrapper = self._equipWrapper:getSimpleEquipItemWrapper(slotNo)
      if nil ~= equipItemWrapper then
        local equipItemEnchantKey = equipItemWrapper:getItemEnchantKey()
        if itemEnchantKey:getItemKey() == equipItemEnchantKey:getItemKey() and itemEnchantKey:getEnchantLevel() == equipItemEnchantKey:getEnchantLevel() then
          table.insert(self._searchItemEquipSlotList, slotNo)
        end
      end
    end
  end
  for ii = self._currentIndex, self._maxSlotCount do
    local itemWrapper, slotNo
    if self._ui._btn_SortItem:IsCheck() then
      slotNo = self._sortedItemList[ii + 1]
    else
      slotNo = ii
    end
    if nil ~= slotNo then
      itemWrapper = self._invenWrapper:getSimpleItemWrapper(self._itemWhereType, slotNo)
      if nil ~= itemWrapper then
        local inventoryItemEnchantKey = itemWrapper:getItemEnchantKey()
        if itemEnchantKey:getItemKey() == inventoryItemEnchantKey:getItemKey() and itemEnchantKey:getEnchantLevel() == inventoryItemEnchantKey:getEnchantLevel() then
          table.insert(self._searchItemSlotList, slotNo)
        end
      end
    end
  end
  self:scrollToSearchItem()
  self:updateSearchItem()
  self:updateSearchItemEquip()
end
function PaGlobal_SimpleInventory:scrollToSearchItem()
  if nil == Panel_Window_SimpleInventory then
    return
  end
  if self._config._slotRows <= 0 then
    return
  end
  if self._itemWhereType ~= self._searchItemWhereType then
    return
  end
  local slotNo = self._searchItemSlotList[1]
  if nil == slotNo then
    return
  end
  if true == self._ui._btn_SortItem:IsCheck() then
    slotNo = self:getSortSlotNo(slotNo)
    if 0 == slotNo then
      return
    end
  end
  local screenShowCount = self._config._slotRows * self._config._slotCols
  local scrollEndIndex = self._config._inventoryMax - screenShowCount
  local limitEndIndex = math.floor(scrollEndIndex / self._config._slotRows) * self._config._slotRows
  self._currentIndex = math.floor(slotNo / self._config._slotRows) * self._config._slotRows
  self._currentIndex = math.min(limitEndIndex, self._currentIndex)
  self._ui._scroll:SetControlPos(math.min(self._currentIndex / scrollEndIndex, 1))
  self:updateSlot()
end
function PaGlobal_SimpleInventory:updateSearchItem()
  if nil == self._searchItemWhereType then
    return
  end
  self:clearSearchItemInfo(true, false)
  if self._itemWhereType ~= self._searchItemWhereType then
    return
  end
  for key, slotNo in pairs(self._searchItemSlotList) do
    local sortedSlotNo = slotNo
    if true == self._ui._btn_SortItem:IsCheck() then
      sortedSlotNo = self:getSortSlotNo(slotNo)
    end
    local slot = self._slots[sortedSlotNo - self._currentIndex]
    if nil ~= slot then
      slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
      slot.icon:SetMonoTone(false)
    end
  end
end
function PaGlobal_SimpleInventory:updateSearchItemEquip()
  if nil == Panel_Window_SimpleInventory then
    return
  end
  self:clearSearchEquipItemInfo(true, false)
  for key, slotNo in pairs(self._searchItemEquipSlotList) do
    if nil ~= slotNo then
      local slotControl = self._equipSlot[slotNo]
      if nil ~= slotControl then
        slotControl.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
        slotControl.icon:SetMonoTone(false)
      end
    end
  end
end
function PaGlobal_SimpleInventory:clearSearchItemInfo(isMonoTone, isDataClear)
  if nil == Panel_Window_SimpleInventory then
    return
  end
  for ii = 0, self._config._slotCount - 1 do
    local slot = self._slots[ii]
    if nil ~= slot then
      slot.icon:SetMonoTone(isMonoTone)
      slot.icon:EraseAllEffect()
    end
  end
  if true == isDataClear then
    self._searchItemWhereType = nil
    self._searchItemSlotList = {}
  end
end
function PaGlobal_SimpleInventory:clearSearchEquipItemInfo(isMonoTone, isDataClear)
  if nil == Panel_Window_SimpleInventory then
    return
  end
  for ii = self._EquipNoMin, self._EquipNoMax - 1 do
    local slot = self._equipSlot[ii]
    if nil ~= slot then
      slot.icon:SetMonoTone(isMonoTone)
      slot.icon:EraseAllEffect()
    end
  end
  if true == isDataClear then
    self._searchItemEquipSlotList = {}
  end
  PaGlobal_SimpleInventory:updateExtendedSlot()
end
function PaGlobal_SimpleInventory:getSortSlotNo(oriSlotNo)
  local self = PaGlobal_SimpleInventory
  for key, value in pairs(self._sortedItemList) do
    if oriSlotNo == value then
      return key - 1
    end
  end
  return 0
end
