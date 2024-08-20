function HandleEventLUp_Dye_Palette_All_SelectTab(tabType)
  PaGlobal_Dye_Palette_All:selectTab(tabType)
end
function HandleEventLUp_Dye_Palette_All_SelectConsoleTab(varIndex)
  PaGlobal_Dye_Palette_All:selectConsoleTab(varIndex)
end
function HandleEventLUp_Dye_Palette_All_CategoryTooltip(isOn, categoryType)
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  if nil == isOn or nil == categoryType then
    return
  end
  local control
  local name = ""
  local desc
  if true == isOn then
    control = PaGlobal_Dye_Palette_All._rdo_Material[categoryType]
    name = PaGlobal_Dye_Palette_All._materialName[categoryType]
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventLUp_Dye_Palette_All_ColorToolTip(isShow, itemEnchantKey, rowsIdx, colsIdx)
  if nil == isShow or nil == itemEnchantKey or nil == rowsIdx or nil == colsIdx then
    return
  end
  if true == isShow then
    local uiControl = PaGlobal_Dye_Palette_All.slot[rowsIdx][colsIdx].btn
    local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
    if nil == itemEnchantSSW then
      return
    end
    local itemEnchantSS = itemEnchantSSW:get()
    local itemName = getItemName(itemEnchantSS)
    local desc
    TooltipSimple_Show(uiControl, itemName, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventLUp_Dye_Palette_All_SelectCategory(categoryIdx)
  PaGlobal_Dye_Palette_All:selectCategory(categoryIdx)
end
function HandleEventLUp_Dye_Palette_All_SelectConsoleCategory(varIndex)
  PaGlobal_Dye_Palette_All:selectConsoleCategory(varIndex)
end
function HandleEventLUp_Dye_Palette_All_SelectColor(colorIdx)
  PaGlobal_Dye_Palette_All:selectColor(colorIdx)
end
function HandleEventLUp_Dye_Palette_All_Palette_All_Scroll()
  PaGlobal_Dye_Palette_All:paletteScroll()
end
function InputScroll_Dye_Palette_All(isScrollUp)
  PaGlobal_Dye_Palette_All:paletteScroll(isScrollUp)
end
function HandleEventLUp_Dye_Palette_All_WithdrawColor()
  PaGlobal_Dye_Palette_All:withdrawColor()
end
function HandleEventLUp_Dye_Palette_All_MixColor()
  PaGlobal_Dye_Palette_All:mixColor()
end
function HandleEventRUp_Dye_Palette_All_ColorMixSlot(index)
  PaGlobal_Dye_Palette_All:colorMixSlotRClick(index)
end
function HandleEventOn_Dye_Palette_All_ColorMix_ShowTooltip(index)
  if nil == index then
    return
  end
  local _slotList = PaGlobal_Dye_Palette_All._ui.stc_slotList
  if nil ~= _slotList and nil ~= _slotList[index].itemWhereType and nil ~= _slotList[index].slotNo then
    local itemWrapper = getInventoryItemByType(_slotList[index].itemWhereType, _slotList[index].slotNo)
    if nil ~= itemWrapper then
      Panel_Tooltip_Item_Show(itemWrapper:getStaticStatus(), _slotList[index].icon, true, false)
    end
  end
end
function HandleEventOn_Dye_Palette_All_ColorMix_HideTooltip()
  Panel_Tooltip_Item_hideTooltip()
end
function HandleEventRUp_Dye_Palette_All_ColorMixDropHandler(index)
  PaGlobal_Dye_Palette_All:colorMixDropHandler(index)
end
function PaGlobal_Dye_Palette_All_Open(isPalette)
  PaGlobal_Dye_Palette_All:prepareOpen(isPalette)
end
function PaGlobal_Dye_Palette_All_Close()
  PaGlobal_Dye_Palette_All:prepareClose()
end
function PaGlobal_Dye_Palette_All_SetInvenFilter(slotNo, itemWrapper)
  if nil ~= itemWrapper then
    local isDyeAble = itemWrapper:getStaticStatus():get():isDyeingStaticStatus()
    return not isDyeAble
  else
    return true
  end
end
function PaGlobal_Dye_Palette_All_SetInvenRclick(slotNo, itemWrapper, count_s64, inventoryType)
  if nil == slotNo or nil == itemWrapper or nil == count_s64 or nil == inventoryType then
    return
  end
  local function doInsertPalette()
    ToClient_requestCreateDyeingPaletteFromItem(inventoryType, slotNo, count_s64)
  end
  local ampuleName = itemWrapper:getStaticStatus():getName()
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PALETTE_SURE_THIS_AMPLUE", "itemName", ampuleName)
  local messageBoxData = {
    title = messageTitle,
    content = messageBoxMemo,
    functionYes = doInsertPalette,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Dye_Palette_ColorMix_All_SetInvenRclick(slotNo, itemWrapper, itemCount, currentWhereType)
  if nil == slotNo or nil == itemWrapper or nil == itemCount or nil == currentWhereType then
    return
  end
  local _slotList = PaGlobal_Dye_Palette_All._ui.stc_slotList
  if not _slotList[0].icon:GetShow() then
    _slotList[0]:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemWrapper:get():getCount_s64())
    _slotList[0].icon:SetShow(true)
    _slotList[0].slotNo = slotNo
    _slotList[0].itemWhereType = currentWhereType
  elseif not _slotList[1].icon:GetShow() then
    if 1 == tonumber(_slotList[0].count:GetText()) and _slotList[0].slotNo == slotNo then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_COLORBALENCE_INVENRCLICK"))
      return
    end
    _slotList[1]:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemWrapper:get():getCount_s64())
    _slotList[1].icon:SetShow(true)
    _slotList[1].slotNo = slotNo
    _slotList[1].itemWhereType = currentWhereType
  else
    if 1 == tonumber(_slotList[0].count:GetText()) and _slotList[0].slotNo == slotNo or 1 == tonumber(_slotList[1].count:GetText()) and _slotList[1].slotNo == slotNo then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_COLORBALENCE_INVENRCLICK"))
      return
    end
    _slotList[1]:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemWrapper:get():getCount_s64())
    _slotList[1].icon:SetShow(true)
    _slotList[1].slotNo = slotNo
    _slotList[1].itemWhereType = currentWhereType
  end
  _slotList[2].icon:SetShow(false)
  _slotList[2]:clearItem()
end
function FromClient_Dye_Palette_All_PaletteUpdate()
  if nil ~= Panel_Window_Dye_Palette_All and Panel_Window_Dye_Palette_All:GetShow() then
    PaGlobal_Dye_Palette_All:paletteUpdate()
  end
  if nil ~= Panel_Window_Inventory_All and Panel_Window_Inventory_All:GetShow() then
    Inventory_updateSlotData(true)
  end
  if nil ~= Panel_Dye_ReNew and Panel_Dye_ReNew:GetShow() then
    FGlobal_Panel_DyeReNew_updateColorAmpuleList()
  end
end
function FromClient_Dye_Palette_All_MixSlotUpdate(itemWhereType, itemSlotNo)
  PaGlobal_Dye_Palette_All:mixColorUpdate(itemWhereType, itemSlotNo)
end
