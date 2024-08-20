function PaGlobal_SimpleInventory_SearchResult:initialize()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleArea, "Button_Close")
  self._ui._btn_search = UI.getChildControl(self._ui._edit_control, "Button_BtnSearch_PCUI")
  self._ui._stc_keyX = UI.getChildControl(self._ui._edit_control, "StaticText_XButton")
  self._ui._btn_reset = UI.getChildControl(self._ui._edit_control, "Button_Reset")
  self._ui._stc_groupItemDesc = UI.getChildControl(self._ui._check_sort, "StaticText_1")
  self._ui._btn_close:SetShow(false == self._isConsole)
  self._ui._btn_search:SetShow(false == self._isConsole)
  self._ui._stc_keyX:SetShow(true == self._isConsole)
  self._ui._btn_reset:SetShow(false)
  self._SIMPLE_TOOLTIP_DATA[self._ENUM_SIMPLE_TOOPTIP_TYPE._TOOPTIP_RESET].control = self._ui._btn_reset
  self._SIMPLE_TOOLTIP_DATA[self._ENUM_SIMPLE_TOOPTIP_TYPE._TOOPTIP_GROUPITEM].control = self._ui._check_sort
  self._ui._stc_groupItemDesc:SetTextMode(__eTextMode_LimitText)
  self._ui._stc_groupItemDesc:SetText(self._ui._stc_groupItemDesc:GetText())
  self:validate()
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_SimpleInventory_SearchResult:clear()
  self._ui._edit_control:SetEditText("")
  self._ui._check_sort:SetCheck(false)
  self._isSearchedItemGroup = false
end
function PaGlobal_SimpleInventory_SearchResult:prepareOpen()
  if nil ~= Panel_Window_SimpleInventory and true == Panel_Window_SimpleInventory:GetShow() then
    local panelPadding = 15
    local posX = Panel_Window_SimpleInventory:GetPosX() + Panel_Window_SimpleInventory:GetSizeX() + panelPadding
    local posY = Panel_Window_SimpleInventory:GetPosY()
    Panel_Window_SimpleInventory_SearchResult:SetPosX(posX)
    Panel_Window_SimpleInventory_SearchResult:SetPosY(posY)
  end
  self:open()
end
function PaGlobal_SimpleInventory_SearchResult:open()
  if false == self._initialize then
    return
  end
  if false == _ContentsGroup_SimpleInvenSearch then
    return
  end
  self:reset()
  self:clear()
  Panel_Window_SimpleInventory_SearchResult:SetShow(true)
end
function PaGlobal_SimpleInventory_SearchResult:prepareClose()
  self._isSearchedItemGroup = false
  self:reset()
  self:close()
end
function PaGlobal_SimpleInventory_SearchResult:close()
  Panel_Window_SimpleInventory_SearchResult:SetShow(false)
  PaGlobal_SimpleInventory:clearSearchItemInfo(false, true)
  PaGlobal_SimpleInventory:clearSearchEquipItemInfo(false, true)
end
function PaGlobal_SimpleInventory_SearchResult:validate()
  self._ui._stc_titleArea:isValidate()
  self._ui._edit_control:isValidate()
  self._ui._check_sort:isValidate()
  self._ui._list2_result:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._btn_search:isValidate()
  self._ui._btn_reset:isValidate()
  self._ui._stc_keyX:isValidate()
end
function PaGlobal_SimpleInventory_SearchResult:registerEvent()
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_SimpleInventory_SearchResult:prepareClose()")
  self._ui._edit_control:RegistReturnKeyEvent("PaGlobal_SimpleInventory_SearchResult:doSearch()")
  self._ui._btn_search:addInputEvent("Mouse_LUp", "PaGlobal_SimpleInventory_SearchResult:doSearch()")
  self._ui._btn_reset:addInputEvent("Mouse_LUp", "PaGlobal_SimpleInventory_SearchResult:reset()")
  self._ui._check_sort:addInputEvent("Mouse_LUp", "PaGlobal_SimpleInventory_SearchResult:doSearch()")
  self._ui._btn_reset:addInputEvent("Mouse_On", "PaGlobalFunc_SimpleInventory_SearchResult_ShowSimpleToolTip(" .. tostring(self._ENUM_SIMPLE_TOOPTIP_TYPE._TOOPTIP_RESET) .. ",true)")
  self._ui._btn_reset:addInputEvent("Mouse_Out", "PaGlobalFunc_SimpleInventory_SearchResult_ShowSimpleToolTip(" .. tostring(self._ENUM_SIMPLE_TOOPTIP_TYPE._TOOPTIP_RESET) .. ",false)")
  self._ui._check_sort:addInputEvent("Mouse_On", "PaGlobalFunc_SimpleInventory_SearchResult_ShowSimpleToolTip(" .. tostring(self._ENUM_SIMPLE_TOOPTIP_TYPE._TOOPTIP_GROUPITEM) .. ",true)")
  self._ui._check_sort:addInputEvent("Mouse_Out", "PaGlobalFunc_SimpleInventory_SearchResult_ShowSimpleToolTip(" .. tostring(self._ENUM_SIMPLE_TOOPTIP_TYPE._TOOPTIP_GROUPITEM) .. ",false)")
  self._ui._list2_result:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_SimpleInventory_SearchResult_List2Update")
  self._ui._list2_result:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_SimpleInventory_SearchResult:doSearch()
  ClearFocusEdit()
  local searchCount = ToClient_getSimpleItemSearchResultCount(self._ui._edit_control:GetEditText(), self._ui._check_sort:IsCheck())
  if true == self._ui._check_sort:IsCheck() then
    self._isSearchedItemGroup = true
  else
    self._isSearchedItemGroup = false
  end
  self._ui._list2_result:getElementManager():clearKey()
  for ii = 0, searchCount - 1 do
    local itemWrapper = ToClient_SimpleSearchItemWrapper(ii)
    if nil ~= itemWrapper then
      self._ui._list2_result:getElementManager():pushKey(ii)
    end
  end
  self._ui._btn_search:SetShow(false)
  self._ui._btn_reset:SetShow(true)
end
function PaGlobal_SimpleInventory_SearchResult:gotoSlot(index)
  local itemWrapper = ToClient_SimpleSearchItemWrapper(index)
  if nil == itemWrapper then
    return
  end
  local characterNo = itemWrapper:getCharacterNo()
  local itemWhereType = itemWrapper:getItemWhereType()
  local selectIndex = self:getCharacterDataIndex(characterNo)
  if -1 == selectIndex then
    return
  end
  if false == self._isSearchedItemGroup then
    local slotNo = itemWrapper:getSlotNo()
    PaGlobal_SimpleInventory:searchItem(selectIndex, itemWhereType, slotNo)
  else
    local itemEnchantKey = itemWrapper:getItemEnchantKey()
    PaGlobal_SimpleInventory:searchItemByItemEnchantKey(selectIndex, itemWhereType, itemEnchantKey)
  end
end
function PaGlobal_SimpleInventory_SearchResult:getCharacterDataIndex(characterNo)
  local characterCount = getCharacterDataCount()
  for ii = 0, characterCount - 1 do
    local data = getCharacterDataByIndex(ii)
    if nil ~= data and data._characterNo_s64 == characterNo then
      return ii
    end
  end
  return -1
end
function PaGlobal_SimpleInventory_SearchResult:reset()
  self:clear()
  ClearFocusEdit()
  local searchCount = ToClient_getSimpleItemSearchResultCount(self._ui._edit_control:GetEditText(), self._ui._check_sort:IsCheck())
  self._ui._list2_result:getElementManager():clearKey()
  for ii = 0, searchCount - 1 do
    local itemWrapper = ToClient_SimpleSearchItemWrapper(ii)
    if nil ~= itemWrapper then
      self._ui._list2_result:getElementManager():pushKey(ii)
    end
  end
  self._ui._btn_search:SetShow(true)
  self._ui._btn_reset:SetShow(false)
  self._isSearchedItemGroup = false
  PaGlobal_SimpleInventory:clearSearchItemInfo(false, true)
  PaGlobal_SimpleInventory:clearSearchEquipItemInfo(false, true)
end
