function PaGlobal_Extraction_Caphras_All_Open()
  PaGlobal_Extraction_Caphras_All:prepareOpen()
end
function PaGlobal_Extraction_Caphras_All_Close()
  PaGlobal_Extraction_Caphras_All:prepareClose()
end
function HandleEventLUp_Extraction_Caphras_All_ClickMoneyWhereType(isInventory)
  if true == isInventory then
    PaGlobal_Extraction_Caphras_All._moneyWhereType = CppEnums.ItemWhereType.eInventory
  else
    PaGlobal_Extraction_Caphras_All._moneyWhereType = CppEnums.ItemWhereType.eWarehouse
  end
end
function HandleEventLUp_Extraction_Caphras_All_ExtractionButton()
  Panel_Window_Extraction_Caphras_All:RegisterUpdateFunc("PaGlobal_Extraction_Caphras_All_UpdateExtractionAni")
  if PaGlobal_Extraction_Caphras_All._fromSlotNo < 0 or 0 > PaGlobal_Extraction_Caphras_All._fromWhereType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTIONCAPHRAS_TARGET_EMPTY"))
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTIONCAPHRAS_ALERT"),
    functionYes = function()
      PaGlobal_Extraction_Caphras_All._delta_ani_time = 0
      PaGlobal_Extraction_Caphras_All._isAniStart = true
      PaGlobal_Extraction_Caphras_All._isSoundFx = true
      PaGlobal_Extraction_Caphras_All._ui.btn_aniSkip:SetIgnore(true)
      PaGlobal_Extraction_Caphras_All._ui.stc_extractableItemSlot:AddEffect("fUI_BlackExtractCaphras_01A", false, 0, 0)
      PaGlobal_Extraction_Caphras_All._ui.stc_resultItmeSlot:AddEffect("fUI_BlackExtractCaphras_01B", false, 0, 0)
      if false == PaGlobal_Extraction_Caphras_All._isConsole then
        PaGlobal_Extraction_Caphras_All._ui_pc.btn_extraction:SetEnable(false)
        PaGlobal_Extraction_Caphras_All._ui_pc.btn_extraction:SetMonoTone(true)
      else
        PaGlobal_Extraction_Caphras_All._ui_console.btn_extraction:SetEnable(false)
        PaGlobal_Extraction_Caphras_All._ui_console.btn_extraction:SetMonoTone(true)
        Panel_Window_Extraction_Caphras_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      end
      PaGlobal_Extraction_Caphras_All._ui.list2_extractableItem:SetEnable(false)
      local myMoney = 0
      if PaGlobal_Extraction_Caphras_All._moneyWhereType == CppEnums.ItemWhereType.eInventory then
        myMoney = PaGlobal_Extraction_Caphras_All._invenMoney
      else
        myMoney = PaGlobal_Extraction_Caphras_All._warehouseMoney
      end
      if myMoney < PaGlobal_Extraction_Caphras_All._extractionPrice then
        PaGlobal_Extraction_Caphras_All._isNoMoney = true
      end
      if false == PaGlobal_Extraction_Caphras_All._isSkipAni and false == PaGlobal_Extraction_Caphras_All._isNoMoney then
        audioPostEvent_SystemUi(5, 76)
        _AudioPostEvent_SystemUiForXBOX(5, 76)
      end
    end,
    functionNo = function()
    end,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_Extraction_Caphras_All_SkipAniButton()
  if false == PaGlobal_Extraction_Caphras_All._isSkipAni then
    PaGlobal_Extraction_Caphras_All._ui.btn_aniSkip:SetCheck(true)
    PaGlobal_Extraction_Caphras_All._isSkipAni = true
  else
    PaGlobal_Extraction_Caphras_All._ui.btn_aniSkip:SetCheck(false)
    PaGlobal_Extraction_Caphras_All._isSkipAni = false
  end
end
function HandleEventLUp_Extraction_Caphras_All_equipmentItem(equipNo)
  UI.ASSERT_NAME(nil ~= equipNo, "HandleEventLUp_Extraction_Caphras_All_equipmentItem\236\157\152 equipNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      HandleEventRUp_Equipment_All_EquipSlotRClick(equipNo)
    else
      Equipment_RClick(equipNo)
    end
  else
    InputMRUp_InventoryInfo_EquipSlot(equipNo)
  end
  PaGlobal_Extraction_Caphras_All._lastIndex = PaGlobal_Extraction_Caphras_All._ui.list2_extractableItem:getCurrenttoIndex()
  if PaGlobal_Extraction_Caphras_All._moneyWhereType == CppEnums.ItemWhereType.eInventory then
    PaGlobal_Extraction_Caphras_All._ui.btn_inven:SetCheck(true)
    PaGlobal_Extraction_Caphras_All._ui.btn_warehouse:SetCheck(false)
  else
    PaGlobal_Extraction_Caphras_All._ui.btn_inven:SetCheck(false)
    PaGlobal_Extraction_Caphras_All._ui.btn_warehouse:SetCheck(true)
  end
end
function HandleEventLUp_Extraction_Caphras_All_CaphrasItem(key)
  for index = 1, PaGlobal_Extraction_Caphras_All._caphrasCnt do
    PaGlobal_Extraction_Caphras_All._itemInfo.isExtractionEquip[index] = false
  end
  local slotNo = PaGlobal_Extraction_Caphras_All._itemInfo.slotNo[key]
  local itemWrapper = getInventoryItemByType(0, slotNo)
  PaGlobal_Extraction_Caphras_All:setExtractionIcon(slotNo, itemWrapper, PaGlobal_Extraction_Caphras_All._moneyWhereType)
  if PaGlobal_Extraction_Caphras_All._moneyWhereType == CppEnums.ItemWhereType.eInventory then
    PaGlobal_Extraction_Caphras_All._ui.btn_inven:SetCheck(true)
    PaGlobal_Extraction_Caphras_All._ui.btn_warehouse:SetCheck(false)
  else
    PaGlobal_Extraction_Caphras_All._ui.btn_inven:SetCheck(false)
    PaGlobal_Extraction_Caphras_All._ui.btn_warehouse:SetCheck(true)
  end
  PaGlobal_Extraction_Caphras_All._itemInfo.isExtractionEquip[key] = true
  PaGlobal_Extraction_Caphras_All._curSelectKey = key
  PaGlobal_Extraction_Caphras_All_ChangeHammerIcon()
end
function HandleEventLUp_Extraction_Caphras_All_ListControlCreate(control, key)
  UI.ASSERT_NAME(nil ~= control, "HandleEventLUp_Extraction_Caphras_All_ListControlCreate\236\157\152 control nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Extraction_Caphras_All_ListControlCreate\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local key_32 = Int64toInt32(key)
  local itemWrapper
  if nil == PaGlobal_Extraction_Caphras_All._equipNo[key_32] then
    itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, PaGlobal_Extraction_Caphras_All._itemInfo.slotNo[key_32])
  else
    itemWrapper = ToClient_getEquipmentItem(PaGlobal_Extraction_Caphras_All._equipNo[key_32])
  end
  if nil == itemWrapper then
    return
  end
  local btn_item = UI.getChildControl(control, "RadioButton_ExtractableItem")
  btn_item:SetCheck(false)
  local itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local itemIcon = UI.getChildControl(itemSlotBg, "Static_ItemIcon")
  local slot = {}
  SlotItem.reInclude(slot, "Caphras_Extraction", 0, itemIcon, PaGlobal_Extraction_Caphras_All._listSlotConfig)
  slot:setItem(itemWrapper)
  local itemText = UI.getChildControl(itemSlotBg, "StaticText_ItemName")
  local itemEnchant = UI.getChildControl(itemIcon, "Static_Text_Slot_Enchant_value")
  local text_equipment = UI.getChildControl(btn_item, "StaticText_EquipItem")
  local hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
  if nil == PaGlobal_Extraction_Caphras_All._equipNo[key_32] then
    if false == PaGlobal_Extraction_Caphras_All._isConsole then
      slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Caphras_All_CaphrasItem(" .. key_32 .. ")")
      slot.icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_Caphras_All_ShowListToolTip(" .. PaGlobal_Extraction_Caphras_All._itemInfo.slotNo[key_32] .. ",true,false)")
      slot.icon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Caphras_All_ShowListToolTip(" .. PaGlobal_Extraction_Caphras_All._itemInfo.slotNo[key_32] .. ",false,false)")
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_Extraction_Caphras_All_ShowDetailKeyGuide(true)")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Caphras_All_ShowDetailKeyGuide(false)")
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Extraction_Caphras_All_ShowListToolTip(" .. PaGlobal_Extraction_Caphras_All._itemInfo.slotNo[key_32] .. ",nil,false)")
    end
    btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Caphras_All_CaphrasItem(" .. key_32 .. ")")
    text_equipment:SetShow(false)
    hammerIcon:SetShow(false)
  else
    if false == PaGlobal_Extraction_Caphras_All._isConsole then
      slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Caphras_All_equipmentItem(" .. PaGlobal_Extraction_Caphras_All._equipNo[key_32] .. ")")
      slot.icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_Caphras_All_ShowListToolTip(" .. PaGlobal_Extraction_Caphras_All._equipNo[key_32] .. ",true,true)")
      slot.icon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Caphras_All_ShowListToolTip(" .. PaGlobal_Extraction_Caphras_All._equipNo[key_32] .. ",false,true)")
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_Extraction_Caphras_All_ShowDetailKeyGuide(true)")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Caphras_All_ShowDetailKeyGuide(false)")
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Extraction_Caphras_All_ShowListToolTip(" .. PaGlobal_Extraction_Caphras_All._equipNo[key_32] .. ",nil,true)")
    end
    btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Caphras_All_equipmentItem(" .. PaGlobal_Extraction_Caphras_All._equipNo[key_32] .. ")")
    text_equipment:SetShow(true)
    hammerIcon:SetShow(false)
  end
  PaGlobal_Extraction_Caphras_All._listControl[key_32] = control
  local itemName = PaGlobal_Extraction_Caphras_All._itemInfo.name[key_32]
  local itemIconPath = PaGlobal_Extraction_Caphras_All._itemInfo.iconPath[key_32]
  itemText:SetSize(itemText:GetSizeX() - text_equipment:GetTextSizeX(), itemText:GetSizeY())
  itemText:SetTextMode(__eTextMode_AutoWrap)
  itemText:SetText(itemName)
  itemIcon:ChangeTextureInfoName("icon/" .. itemIconPath)
  if nil ~= itemWrapper then
    PAGlobalFunc_SetItemTextColorForNewUI(itemText, itemWrapper:getStaticStatus())
  end
  if nil ~= PaGlobal_Extraction_Caphras_All._itemInfo.itemEnchantLevle[key_32] then
    itemEnchant:SetText(PaGlobal_Extraction_Caphras_All._itemInfo.itemEnchantLevle[key_32])
  end
  if true == PaGlobal_Extraction_Caphras_All._itemInfo.isExtractionEquip[key_32] then
    hammerIcon:SetShow(true)
    btn_item:SetCheck(true)
  end
  control:ComputePos()
end
function PaGlobal_Extraction_Caphras_All_ChangeHammerIcon()
  if nil == PaGlobal_Extraction_Caphras_All._curSelectKey then
    return
  end
  if nil == PaGlobal_Extraction_Caphras_All._preSelectKey then
    PaGlobal_Extraction_Caphras_All._preSelectKey = PaGlobal_Extraction_Caphras_All._curSelectKey
  end
  local btn_item = UI.getChildControl(PaGlobal_Extraction_Caphras_All._listControl[PaGlobal_Extraction_Caphras_All._preSelectKey], "RadioButton_ExtractableItem")
  local hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
  hammerIcon:SetShow(false)
  btn_item = UI.getChildControl(PaGlobal_Extraction_Caphras_All._listControl[PaGlobal_Extraction_Caphras_All._curSelectKey], "RadioButton_ExtractableItem")
  hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
  hammerIcon:SetShow(true)
  PaGlobal_Extraction_Caphras_All._preSelectKey = PaGlobal_Extraction_Caphras_All._curSelectKey
end
function PaGlobal_Extraction_Caphras_All_ClearHammerIcon()
  local btn_item, hammerIcon
  if nil ~= PaGlobal_Extraction_Caphras_All._curSelectKey then
    btn_item = UI.getChildControl(PaGlobal_Extraction_Caphras_All._listControl[PaGlobal_Extraction_Caphras_All._preSelectKey], "RadioButton_ExtractableItem")
    hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
    hammerIcon:SetShow(false)
  end
  if nil ~= PaGlobal_Extraction_Caphras_All._preSelectKey then
    btn_item = UI.getChildControl(PaGlobal_Extraction_Caphras_All._listControl[PaGlobal_Extraction_Caphras_All._curSelectKey], "RadioButton_ExtractableItem")
    hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
    hammerIcon:SetShow(false)
  end
  PaGlobal_Extraction_Caphras_All._preSelectKey = nil
  PaGlobal_Extraction_Caphras_All._curSelectKey = nil
end
function FromClient_Extraction_Caphras_All_ReSizePanel()
  if false == PaGlobal_Extraction_Caphras_All._isConsole then
    PaGlobal_Extraction_Caphras_All._ui_pc.btn_close:ComputePos()
    PaGlobal_Extraction_Caphras_All._ui_pc.btn_extraction:ComputePos()
  else
    PaGlobal_Extraction_Caphras_All._ui_console.btn_extraction:ComputePos()
  end
  PaGlobal_Extraction_Caphras_All._ui.stc_extractableItemSlot:ComputePos()
  PaGlobal_Extraction_Caphras_All._ui.stc_resultItmeSlot:ComputePos()
  PaGlobal_Extraction_Caphras_All._ui.stc_moneyArea:ComputePos()
  PaGlobal_Extraction_Caphras_All._ui.stc_moneyIcon:ComputePos()
  PaGlobal_Extraction_Caphras_All._ui.stc_money:ComputePos()
  PaGlobal_Extraction_Caphras_All._ui.btn_inven:ComputePos()
  PaGlobal_Extraction_Caphras_All._ui.stc_invenMoney:ComputePos()
  PaGlobal_Extraction_Caphras_All._ui.btn_warehouse:ComputePos()
  PaGlobal_Extraction_Caphras_All._ui.stc_warehouseMoney:ComputePos()
  PaGlobal_Extraction_Caphras_All._ui.stc_noticeDesc:ComputePos()
  PaGlobal_Extraction_Caphras_All._ui.btn_aniSkip:ComputePos()
  PaGlobal_Extraction_Caphras_All._ui.txt_noItem:ComputePos()
  PaGlobal_Extraction_Caphras_All._ui.list2_extractableItem:ComputePos()
end
function FromClient_Extraction_Caphras_All_EventWarehouseUpdate(value)
  if true == Panel_Window_Extraction_Caphras_All:GetShow() then
    PaGlobal_Extraction_Caphras_All._ui.stc_warehouseMoney:SetText(makeDotMoney(warehouse_moneyFromNpcShop_s64()))
  end
end
function FromClient_Extraction_Caphras_All_ExtracCaphrasItem(whereType, slotNo, variedCount, isSuccess)
  if nil == getSelfPlayer() then
    return
  end
  if isSuccess then
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if nil == itemWrapper then
      return
    end
    PaGlobal_Extraction_Caphras_All._ui.stc_invenMoney:SetText(makeDotMoney(getSelfPlayer():get():getInventory():getMoney_s64()))
    PaGlobal_Extraction_Caphras_All._ui.stc_warehouseMoney:SetText(makeDotMoney(warehouse_moneyFromNpcShop_s64()))
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXTRACTIONCAPHRAS_EXTRACTION_COUNT_ACK", "count", tostring(PaGlobal_Extraction_Caphras_All._savedCount)))
    PaGlobal_Extraction_Caphras_All:Clear()
    PaGlobal_Extraction_Caphras_All:updateExtractionList()
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CAPHRAS_FAILED_ACK"))
    PaGlobal_Extraction_Caphras_All:Clear()
    PaGlobal_Extraction_Caphras_All:updateExtractionList()
  end
end
function PaGlobal_Extraction_Caphras_All_UpdateExtractionAni(delta)
  if nil == Panel_Window_Extraction_Caphras_All or false == PaGlobal_Extraction_Caphras_All._isAniStart then
    return
  end
  PaGlobal_Extraction_Caphras_All._delta_ani_time = PaGlobal_Extraction_Caphras_All._delta_ani_time + delta
  if PaGlobal_Extraction_Caphras_All._sound_ani_time < PaGlobal_Extraction_Caphras_All._delta_ani_time and true == PaGlobal_Extraction_Caphras_All._isSoundFx and false == PaGlobal_Extraction_Caphras_All._isSkipAni then
    audioPostEvent_SystemUi(5, 77)
    _AudioPostEvent_SystemUiForXBOX(5, 77)
    PaGlobal_Extraction_Caphras_All._isSoundFx = false
  end
  if PaGlobal_Extraction_Caphras_All._const_ani_time < PaGlobal_Extraction_Caphras_All._delta_ani_time or true == PaGlobal_Extraction_Caphras_All._isSkipAni or true == PaGlobal_Extraction_Caphras_All._isNoMoney then
    PaGlobal_Extraction_Caphras_All._delta_ani_time = 0
    local itemWrapper = getInventoryItemByType(0, PaGlobal_Extraction_Caphras_All._fromSlotNo)
    if nil ~= itemWrapper then
      local isCaphrasPrice = itemWrapper:getExtractCaphrasPrice()
      local whereType = PaGlobal_Extraction_Caphras_All._moneyWhereType
      ToClient_ExtractCaphras(0, PaGlobal_Extraction_Caphras_All._fromSlotNo, whereType, 0, isCaphrasPrice)
      PaGlobal_Extraction_Caphras_All:Clear()
      PaGlobal_Extraction_Caphras_All:setExtractionPrice(0, 0)
      Panel_Window_Extraction_Caphras_All:ClearUpdateLuaFunc()
    end
    if false == PaGlobal_Extraction_Caphras_All._isConsole then
      PaGlobal_Extraction_Caphras_All._ui_pc.btn_extraction:SetEnable(false)
      PaGlobal_Extraction_Caphras_All._ui_pc.btn_extraction:SetMonoTone(false)
    else
      PaGlobal_Extraction_Caphras_All._ui_console.btn_extraction:SetEnable(false)
      PaGlobal_Extraction_Caphras_All._ui_console.btn_extraction:SetMonoTone(false)
      Panel_Window_Extraction_Caphras_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    end
    PaGlobal_Extraction_Caphras_All._resultSlotNo = PaGlobal_Extraction_Caphras_All._fromSlotNo
    PaGlobal_Extraction_Caphras_All._resultWhereType = PaGlobal_Extraction_Caphras_All._fromWhereType
    PaGlobal_Extraction_Caphras_All._isAniStart = false
    PaGlobal_Extraction_Caphras_All._isNoMoney = false
    PaGlobal_Extraction_Caphras_All:updateExtractionList()
  end
end
function PaGlobal_Extraction_Caphras_All_ShowToolTip(isShow)
  if false == PaGlobal_Extraction_Caphras_All._fromSlotOn then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_Extraction_Caphras_All._fromWhereType, PaGlobal_Extraction_Caphras_All._fromSlotNo)
  if nil == itemWrapper then
    return
  end
  if true == isShow then
    Panel_Tooltip_Item_SetPosition(0, PaGlobal_Extraction_Caphras_All._ui.stc_extractableItemSlot, "Purification")
    Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Extraction_Caphras_All, false, true, nil)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_Extraction_Caphras_All_ResultShowToolTip(isShow)
  if false == PaGlobal_Extraction_Caphras_All._fromSlotOn then
    return
  end
  local itemWrapper = ToClient_getPromotionEnchantItem()
  if nil == itemWrapper then
    return
  end
  if true == isShow then
    Panel_Tooltip_Item_SetPosition(0, PaGlobal_Extraction_Caphras_All._ui.stc_resultItmeSlot, "Purification")
    Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Extraction_Caphras_All, true, false)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_Extraction_Caphras_All_ShowListToolTip(idx, isShow, isEquip)
  local itemWrapper
  if true == isEquip then
    itemWrapper = ToClient_getEquipmentItem(idx)
  else
    itemWrapper = getInventoryItemByType(0, idx)
  end
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Extraction_Caphras_All._isConsole then
    if true == isShow then
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Extraction_Caphras_All, false, true, nil)
    else
      Panel_Tooltip_Item_hideTooltip()
    end
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function PaGlobal_Extraction_Caphras_All_ShowDetailKeyGuide(isShow)
  PaGlobal_Extraction_Caphras_All._ui_console.btn_detail:SetShow(isShow)
end
function PaGlobal_Extraction_Caphras_All_UpdateList()
  if nil == Panel_Window_Extraction_Caphras_All or false == Panel_Window_Extraction_Caphras_All:GetShow() then
    return
  end
  PaGlobal_Extraction_Caphras_All:updateExtractionList()
  if nil ~= PaGlobal_Extraction_Caphras_All._lastIndex then
    PaGlobal_Extraction_Caphras_All._ui.list2_extractableItem:moveIndex(PaGlobal_Extraction_Caphras_All._lastIndex)
  end
end
function PaGlobal_Extraction_Caphras_All_ShowAni()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
end
function PaGlobal_Extraction_Caphras_All_HideAni()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
end
