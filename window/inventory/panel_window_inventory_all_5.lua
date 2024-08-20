function FromClient_Inventory_All_CursorOnOffSignal()
  if MessageBoxGetShow() then
    return
  end
  TooltipSimple_Hide()
end
function FromClient_Inventory_All_RenderModeChange_FlushRestoreFunc(prevRenderModeList, nextRenderModeList)
  local isUISubApp = Panel_Window_Inventory_All:IsUISubApp()
  PaGlobal_Inventory_All._ui.check_popup:SetCheck(isUISubApp)
  if true == Panel_Window_Inventory_All:GetShow() and true == DragManager:isDragging() then
    PaGlobalFunc_Inventory_All_Delete_No()
  end
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    if isFlushedUI() then
      if true == Panel_Window_Inventory_All:isPlayAnimation() then
        Panel_Window_Inventory_All:SetScaleDefault()
      end
      PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetEnable(false)
      PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetIgnore(true)
      PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetMonoTone(true)
      PaGlobal_Inventory_All._ui.btn_alchemyStone:SetEnable(false)
      PaGlobal_Inventory_All._ui.btn_alchemyStone:SetIgnore(true)
      PaGlobal_Inventory_All._ui.btn_alchemyStone:SetMonoTone(true)
      PaGlobal_Inventory_All._ui.btn_manufacture:SetEnable(false)
      PaGlobal_Inventory_All._ui.btn_manufacture:SetIgnore(true)
      PaGlobal_Inventory_All._ui.btn_manufacture:SetMonoTone(true)
      PaGlobal_Inventory_All._ui.btn_dyePalette:SetEnable(false)
      PaGlobal_Inventory_All._ui.btn_dyePalette:SetIgnore(true)
      PaGlobal_Inventory_All._ui.btn_dyePalette:SetMonoTone(true)
      local isWareHousePanelShow = false
      if nil ~= Panel_Window_Warehouse and true == Panel_Window_Warehouse:GetShow() then
        isWareHousePanelShow = true
      end
      PaGlobal_Inventory_All._ui.btn_doItemMove:SetShow(_ContentsGroup_ItemMove and isWareHousePanelShow)
      PaGlobal_Inventory_All._ui.btn_setItemMove:SetShow(_ContentsGroup_ItemMove and isWareHousePanelShow)
      if true == PaGlobal_Inventory_All._ui.btn_doItemMove:GetShow() then
        PaGlobal_Inventory_All._ui.btn_alchemyStone:SetShow(false)
        PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetShow(false)
      end
      if true == PaGlobal_Inventory_All._ui.btn_setItemMove:GetShow() then
        PaGlobal_Inventory_All._ui.btn_manufacture:SetShow(false)
        PaGlobal_Inventory_All._ui.btn_dyePalette:SetShow(false)
      end
      PaGlobalFunc_Inventory_All_familyInventoryButtonActive(false)
    end
    return
  else
    PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetEnable(true)
    PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetIgnore(false)
    PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetMonoTone(false)
    PaGlobal_Inventory_All._ui.btn_alchemyStone:SetEnable(true)
    PaGlobal_Inventory_All._ui.btn_alchemyStone:SetIgnore(false)
    PaGlobal_Inventory_All._ui.btn_alchemyStone:SetMonoTone(false)
    PaGlobal_Inventory_All._ui.btn_manufacture:SetEnable(true)
    PaGlobal_Inventory_All._ui.btn_manufacture:SetIgnore(false)
    PaGlobal_Inventory_All._ui.btn_manufacture:SetMonoTone(false)
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetEnable(true)
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetIgnore(false)
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetMonoTone(false)
    PaGlobal_Inventory_All._ui.btn_alchemyStone:SetShow(true)
    PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetShow(true)
    PaGlobal_Inventory_All._ui.btn_manufacture:SetShow(true)
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetShow(true)
    PaGlobal_Inventory_All._ui.btn_doItemMove:SetShow(false)
    PaGlobal_Inventory_All._ui.btn_setItemMove:SetShow(false)
    PaGlobalFunc_Inventory_All_familyInventoryButtonActive(true)
  end
end
function FromClient_Inventory_All_SetShowWithFilter(actorType)
  PaGlobalFunc_Inventory_All_SetShow(true)
  if CppEnums.ActorType.ActorType_Player == actorType or CppEnums.ActorType.ActorType_Deadbody == actorType then
    Inventory_SetFunctor(PaGlobalFunc_Inventory_All_FilterDead, PaGlobalFunc_Inventory_All_UseItemTarget, InventoryWindow_Close, nil)
  elseif CppEnums.ActorType.ActorType_Vehicle == actorType then
    Inventory_SetFunctor(PaGlobalFunc_Inventory_All_FilterFodder, PaGlobalFunc_Inventory_All_UseItemTarget, InventoryWindow_Close, nil)
  elseif CppEnums.ActorType.ActorType_Npc == actorType then
    Inventory_SetFunctor(PaGlobalFunc_Inventory_All_FilterFuel, PaGlobalFunc_Inventory_All_UseFuelItem, InventoryWindow_Close, nil)
  end
end
function FromClient_Inventory_All_AddItem(itemKey, slotNo, itemCount, whereType)
  if 1 == itemKey or 2 == itemKey then
    if 1 == itemKey then
      if itemCount >= toInt64(0, 0) and itemCount < toInt64(0, 1000000) then
        audioPostEvent_SystemUi(3, 12)
      elseif itemCount >= toInt64(0, 1000000) and itemCount < toInt64(0, 10000000) then
        audioPostEvent_SystemUi(6, 5)
      elseif itemCount >= toInt64(0, 10000000) and itemCount < toInt64(0, 50000000) then
        audioPostEvent_SystemUi(6, 6)
      elseif itemCount >= toInt64(0, 50000000) and itemCount < toInt64(0, 200000000) then
        audioPostEvent_SystemUi(6, 7)
      elseif itemCount >= toInt64(0, 200000000) and itemCount < toInt64(0, 500000000) then
        audioPostEvent_SystemUi(6, 8)
      else
        audioPostEvent_SystemUi(6, 9)
      end
    else
      audioPostEvent_SystemUi(3, 12)
    end
    return
  end
  if slotNo >= 0 and slotNo < PaGlobal_Inventory_All.INVEN_MAX_SLOTNO then
    if CppEnums.ItemWhereType.eInventory == whereType then
      PaGlobal_Inventory_All.newItemData[slotNo] = itemKey
    elseif CppEnums.ItemWhereType.eCashInventory == whereType then
      PaGlobal_Inventory_All.newPearlItemData[slotNo] = itemKey
    end
  end
  if true == Panel_Window_Inventory_All:GetShow() then
    PaGlobal_Inventory_All:setNewItemEffect()
    PaGlobal_Inventory_All:setNewPearlTabEffect()
  end
end
function FromClient_Inventory_All_UnequipItem(whereType, slotNo)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemStatic = itemWrapper:getStaticStatus():get()
  if nil == itemStatic then
    return
  end
  for ii = 0, PaGlobal_Inventory_All.config.slotCount - 1 do
    local slot = PaGlobal_Inventory_All.slots[ii]
    if slotNo == slot._slotNo then
      slot.background:AddEffect("fUI_Item_Clear", false, 0, 0)
    end
  end
  audioPostEvent_SystemUi(2, 0)
end
function FromClient_Inventory_All_UpdateSlotDataByAddItem()
  if true == Panel_Window_Inventory_All:GetShow() then
    Inventory_updateSlotData(false)
    PaGlobal_Inventory_All:findSearchItem(true)
  end
  if nil ~= PaGlobal_Inventory_All._whereUseItemMoveSlotNo then
    PaGlobalFunc_Inventory_All_ChangeObserveItemSlot(PaGlobal_Inventory_All._whereUseItemMoveSlotNo)
    PaGlobal_Inventory_All._whereUseItemMoveSlotNo = nil
  end
end
function FromClient_Inventory_All_FindExchangeItemNPC()
  local itemEnchantKey = getSelfPlayer():get():getCurrentFindExchangeItemEnchantKey()
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  if nil == itemSSW then
    return
  end
  PaGlobal_Inventory_All:findExchangeItemNPC(itemSSW)
end
function FromClient_Inventory_All_UseItemAskFromOtherPlayer(fromName)
  local UseItemFromOtherPlayer_Yes = function()
    useItemFromOtherPlayer(true)
  end
  local UseItemFromOtherPlayer_No = function()
    useItemFromOtherPlayer(false)
  end
  local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_USEITEM_MESSAGEBOX_REQUEST", "for_name", fromName)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_USEITEM_MESSAGEBOX_TITLE"),
    content = messageboxMemo,
    functionYes = UseItemFromOtherPlayer_Yes,
    functionCancel = UseItemFromOtherPlayer_No,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_Inventory_All_OpenFamilyInventory()
  if false == Panel_Window_Inventory_All:GetShow() then
    InventoryWindow_Show()
  end
  PaGlobal_Inventory_All._ui.rdo_familyInven:EraseAllEffect()
  PaGlobal_Inventory_All._ui.rdo_familyInven:AddEffect("fUI_Inventory_Tab_01A", false, 0, 0)
end
function PaGlobalFunc_ItemCoolTimeEffect_ShowAni()
  local coolTime_Hide = UIAni.AlphaAnimation(0, Panel_Inventory_CoolTime_Effect_Item_Slot, 0, 0.7)
  coolTime_Hide:SetHideAtEnd(true)
end
function PaGlobal_Inventory_UnCheckAutoSort()
  if true == isRealServiceMode() then
    return false
  end
  PaGlobal_Inventory_All._ui.check_itemSort:SetCheck(false)
  HandleEventLUp_Inventory_All_SetSorted()
  return true
end
