function PaGlobalFunc_Inventory_All_Close()
  if nil == Panel_Window_Inventory_All then
    return
  end
  if true == _ContentsGroup_NewUI_SpiritEnchant_All and nil ~= Panel_Window_StackExtraction_All and true == Panel_Window_StackExtraction_All:GetShow() then
    return
  end
  audioPostEvent_SystemUi(1, 1)
  Panel_Window_Inventory_All:CloseUISubApp()
  PaGlobal_Inventory_All._ui.check_popup:SetCheck(false)
  InventoryWindow_Close()
end
function PaGlobalFunc_Inventory_All_SetShow(isShow)
  PaGlobal_Inventory_All._isFirstTab = true
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    PaGlobal_TutorialUiManager:getUiMasking():hideQuestMasking()
    InventoryWindow_Close()
  else
    InventoryWindow_Show()
  end
end
function PaGlobalFunc_Inventory_All_ShowToggle()
  PaGlobalFunc_Inventory_All_SetShow(not Panel_Window_Inventory_All:GetShow())
end
function PaGlobalFunc_Inventory_All_OnScreenResize()
  local scrSizeX = getScreenSizeX()
  local scrSizeY = getScreenSizeY()
  local invenSizeX = Panel_Window_Inventory_All:GetSizeX()
  local invenSizeY = PaGlobal_Inventory_All._defaultSizeY
  local dialogSizeY = 0
  local dialogShow = false
  if false == _ContentsGroup_NewUI_Dialog_All then
    dialogSizeY = Panel_Npc_Dialog:GetSizeY()
    dialogShow = Panel_Npc_Dialog:GetShow()
  else
    dialogSizeY = Panel_Npc_Dialog_All:GetSizeY()
    dialogShow = Panel_Npc_Dialog_All:GetShow()
  end
  Panel_Window_Inventory_All:SetPosX(scrSizeX - invenSizeX - 10)
  Panel_Window_Inventory_All:SetPosY(math.max(0, (scrSizeY - invenSizeY) / 2))
  PaGlobal_Inventory_All._defaultPosX = Panel_Window_Inventory_All:GetPosX()
  PaGlobal_Inventory_All._defaultPosY = Panel_Window_Inventory_All:GetPosY()
  if true == dialogShow and nil == dialog_getTalker() then
    if scrSizeY < invenSizeY + dialogSizeY then
      Panel_Window_Inventory_All:SetPosY(0)
    elseif false == _ContentsGroup_NewUI_Dialog_All then
      Panel_Window_Inventory_All:SetPosY(scrSizeY - invenSizeY - dialogSizeY)
    else
      Panel_Window_Inventory_All:SetPosY(Panel_Window_Inventory_All:GetPosY())
    end
  end
end
function PaGlobalFunc_Inventory_All_ShowAni()
  Panel_Window_Inventory_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  PaGlobal_Inventory_All._isFirstTab = false
  local aniInfo1 = Panel_Window_Inventory_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Panel_Window_Inventory_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Inventory_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  aniInfo1:SetDisableWhileAni(true)
  local aniInfo2 = Panel_Window_Inventory_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_Inventory_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_Inventory_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  aniInfo2:SetDisableWhileAni(true)
end
function PaGlobalFunc_Inventory_All_HideAni()
  Panel_Window_Inventory_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_Inventory_All:addColorAnimation(0, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
  PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetShow(false)
end
function PaGlobalFunc_Inventory_All_OpenWithSpiritEnchant()
  PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetShow(false)
  PaGlobal_Inventory_All._ui.btn_alchemyStone:SetShow(false)
  PaGlobal_Inventory_All._ui.btn_manufacture:SetShow(false)
  PaGlobal_Inventory_All._ui.btn_dyePalette:SetShow(false)
  PaGlobal_Inventory_All._ui.btn_openEquip:SetShow(true)
  PaGlobalFunc_Inventory_All_familyInventoryButtonActive(false)
  InventoryWindow_Show()
end
function PaGlobalFunc_Inventory_All_CloseWithSpiritEnchant()
  PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetShow(_ContentsGroup_AlchemyFigureHead)
  PaGlobal_Inventory_All._ui.btn_alchemyStone:SetShow(_ContentsGroup_AlchemyStone)
  PaGlobal_Inventory_All._ui.btn_manufacture:SetShow(true)
  PaGlobal_Inventory_All._ui.btn_dyePalette:SetShow(true)
  PaGlobal_Inventory_All._ui.btn_openEquip:SetShow(false)
  PaGlobalFunc_Inventory_All_familyInventoryButtonActive(true)
  InventoryWindow_Close()
end
function PaGlobalFunc_Inventory_All_OpenWithNpcShop()
  if true == _ContentsGroup_SellAtOnceItem then
    PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetShow(false)
    PaGlobal_Inventory_All._ui.btn_alchemyStone:SetShow(false)
    PaGlobal_Inventory_All._ui.btn_manufacture:SetShow(false)
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetShow(false)
    PaGlobal_Inventory_All._ui.btn_sellEtcAll:SetShow(true)
  end
  InventoryWindow_Show()
end
function PaGlobalFunc_Inventory_All_CloseWithSpiritNpcShop()
  if true == _ContentsGroup_SellAtOnceItem then
    PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetShow(_ContentsGroup_AlchemyFigureHead)
    PaGlobal_Inventory_All._ui.btn_alchemyStone:SetShow(_ContentsGroup_AlchemyStone)
    PaGlobal_Inventory_All._ui.btn_manufacture:SetShow(true)
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetShow(true)
    PaGlobal_Inventory_All._ui.btn_sellEtcAll:SetShow(false)
  end
  InventoryWindow_Close()
end
function PaGlobalFunc_Inventory_All_OpenWithItemCopy()
  PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetShow(false)
  PaGlobal_Inventory_All._ui.btn_alchemyStone:SetShow(false)
  PaGlobal_Inventory_All._ui.btn_manufacture:SetShow(false)
  PaGlobal_Inventory_All._ui.btn_dyePalette:SetShow(false)
  PaGlobal_Inventory_All._ui.btn_openEquip:SetShow(true)
  if nil ~= Panel_Window_Inventory_All and false == Panel_Window_Inventory_All:GetShow() then
    PaGlobalFunc_Inventory_All_familyInventoryButtonActive(false)
  end
  if nil ~= PaGlobalFunc_Equipment_All_SetShow then
    PaGlobalFunc_Equipment_All_SetShow(true)
  end
  InventoryWindow_Show()
end
function PaGlobalFunc_Inventory_All_CloseWithItemCopy()
  PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetShow(_ContentsGroup_AlchemyFigureHead)
  PaGlobal_Inventory_All._ui.btn_alchemyStone:SetShow(_ContentsGroup_AlchemyStone)
  PaGlobal_Inventory_All._ui.btn_manufacture:SetShow(true)
  PaGlobal_Inventory_All._ui.btn_dyePalette:SetShow(true)
  PaGlobal_Inventory_All._ui.btn_openEquip:SetShow(false)
  PaGlobalFunc_Inventory_All_familyInventoryButtonActive(true)
  if nil ~= PaGlobalFunc_Equipment_All_SetShow then
    PaGlobalFunc_Equipment_All_SetShow(false)
  end
  InventoryWindow_Close()
end
function PaGlobalFunc_Inventory_All_ToggleFamilyInventory()
  if false == _ContentsGroup_FamilyInventory then
    return
  end
  if DragManager:isDragging() then
    DragManager:clearInfo()
  end
  if true == Panel_Window_FamilyInventory_All:GetShow() then
    PaGlobal_FamilyInvnetory_Close(true)
  else
    PaGlobal_FamilyInvnetory_Open()
  end
end
function PaGlobalFunc_Inventory_All_ToggleOlympicFilterInventory()
  PaGlobal_Inventory_All._isOlympicFilter = not PaGlobal_Inventory_All._isOlympicFilter
  Inventory_updateOnlySlotData()
end
function PaGlobalFunc_Inventory_All_familyInventoryButtonActive(isActive)
  if false == _ContentsGroup_FamilyInventory then
    return
  end
  if true == isActive then
    PaGlobal_Inventory_All._familyInventoryIgnoreCount = PaGlobal_Inventory_All._familyInventoryIgnoreCount - 1
  else
    PaGlobal_Inventory_All._familyInventoryIgnoreCount = PaGlobal_Inventory_All._familyInventoryIgnoreCount + 1
  end
  if PaGlobal_Inventory_All._familyInventoryIgnoreCount > 0 then
    PaGlobal_Inventory_All._ui.rdo_familyInven:SetEnable(false)
    PaGlobal_Inventory_All._ui.rdo_familyInven:SetIgnore(true)
    PaGlobal_Inventory_All._ui.rdo_familyInven:SetMonoTone(true)
    PaGlobal_FamilyInvnetory_Close(false)
  else
    PaGlobal_Inventory_All._familyInventoryIgnoreCount = 0
    PaGlobal_Inventory_All._ui.rdo_familyInven:SetEnable(true)
    PaGlobal_Inventory_All._ui.rdo_familyInven:SetIgnore(false)
    PaGlobal_Inventory_All._ui.rdo_familyInven:SetMonoTone(false)
  end
end
function PaGlobalFunc_Inventory_All_familyInventoryIsActive()
  if false == _ContentsGroup_FamilyInventory then
    return false
  end
  return PaGlobal_Inventory_All._ui.rdo_familyInven:IsEnable()
end
function HandleEventLUp_Inventory_All_OpenEquipment()
  if nil ~= PaGlobalFunc_Equipment_All_SetShow then
    PaGlobalFunc_Equipment_All_SetShow(true)
  end
end
function PaGlobalFunc_Inventory_All_GetStartIndex()
  return PaGlobal_Inventory_All._startSlotIndex
end
function PaGlobalFunc_Inventory_All_GetToopTipItem()
  if nil == PaGlobal_Inventory_All._tooltipWhereType or nil == PaGlobal_Inventory_All._tooltipSlotNo then
    return nil
  end
  return getInventoryItemByType(PaGlobal_Inventory_All._tooltipWhereType, PaGlobal_Inventory_All._tooltipSlotNo)
end
function PaGlobalFunc_Inventory_All_GetToolTipItemSlotNo()
  if nil == PaGlobal_Inventory_All._tooltipWhereType or nil == PaGlobal_Inventory_All._tooltipSlotNo then
    return nil
  end
  return PaGlobal_Inventory_All._tooltipSlotNo
end
function PaGlobalFunc_Inventory_All_GetInventorySlotNoByNotSorted(fromSlotNo)
  if nil == fromSlotNo then
    return
  end
  return PaGlobal_Inventory_All.slots[fromSlotNo]._slotNo
end
function PaGlobalFunc_Inventory_All_GetRealSlotNo(index)
  if nil == PaGlobal_Inventory_All.slots[index] then
    return index
  end
  return PaGlobal_Inventory_All.slots[index]._slotNo
end
function PaGlobalFunc_Inventory_All_GetFirstItemCount()
  local aCount = 0
  for ii = 0, PaGlobal_Inventory_All.INVEN_MAX_SLOTNO do
    if nil ~= PaGlobal_Inventory_All.newItemData[ii] then
      aCount = aCount + 1
    end
    if nil ~= PaGlobal_Inventory_All.newPearlItemData[ii] then
      aCount = aCount + 1
    end
  end
  return aCount
end
function PaGlobalFunc_Inventory_All_InventorySetPosWithWarehouse()
  Panel_Window_Inventory_All:SetPosX(getScreenSizeX() - Panel_Window_Inventory_All:GetSizeX() - 10)
  Panel_Window_Inventory_All:SetPosY(Panel_Window_Warehouse:GetPosY())
end
function PaGlobalFunc_Inventory_All_FindPuzzle()
  if false == Panel_Window_Inventory_All:GetShow() then
    return
  end
  PaGlobal_Inventory_All:findPuzzle()
end
function PaGlobalFunc_Inventory_All_HasWeaponBlackStone()
  return PaGlobal_Inventory_All._hasWeaponBlackStone
end
function PaGlobalFunc_Inventory_All_HasArmorBlackStone()
  return PaGlobal_Inventory_All._hasArmorBlackStone
end
function PaGlobalFunc_Inventory_All_HasSocketItem()
  return PaGlobal_Inventory_All._hasSocketItem
end
function PaGlobalFunc_Inventory_All_FlushRestoreFunc()
  if true == Panel_Window_Inventory_All:isPlayAnimation() then
    Panel_Window_Inventory_All:SetScaleDefault()
  end
  PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetEnable(true)
  PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetMonoTone(false)
  PaGlobal_Inventory_All._ui.btn_alchemyStone:SetEnable(true)
  PaGlobal_Inventory_All._ui.btn_alchemyStone:SetMonoTone(false)
  PaGlobal_Inventory_All._ui.btn_manufacture:SetEnable(true)
  PaGlobal_Inventory_All._ui.btn_manufacture:SetMonoTone(false)
  PaGlobal_Inventory_All._ui.btn_dyePalette:SetEnable(true)
  PaGlobal_Inventory_All._ui.btn_dyePalette:SetMonoTone(false)
  Panel_Window_Inventory_All:SetSize(Panel_Window_Inventory_All:GetSizeX(), PaGlobal_Inventory_All._defaultSizeY)
  PaGlobal_Inventory_All._ui.stc_buttonBG:SetShow(true)
  PaGlobal_Inventory_All._ui.stc_buttonBG:ComputePos()
  PaGlobal_Inventory_All._ui.btn_trash:ComputePos()
  PaGlobal_Inventory_All._ui.stc_moneyBG:ComputePos()
  PaGlobal_Inventory_All._ui.stc_weightBG:ComputePos()
end
function PaGlobalFunc_Inventory_All_SelectNormalInventory()
  if not PaGlobal_Inventory_All._ui.rdo_normalInven:IsCheck() then
    PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(true)
    PaGlobal_Inventory_All._ui.rdo_pearlInven:SetCheck(false)
    if true == _ContentsGroup_changeFamilyInvenOpenAction then
      PaGlobal_Inventory_All._ui.rdo_familyInven:SetCheck(false)
    end
    HandleEventLUp_Inventory_All_SelectTab()
  end
end
function PaGlobalFunc_Inventory_All_SelectPearlInventory()
  if not PaGlobal_Inventory_All._ui.rdo_pearlInven:IsCheck() then
    PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(false)
    PaGlobal_Inventory_All._ui.rdo_pearlInven:SetCheck(true)
    if true == _ContentsGroup_changeFamilyInvenOpenAction then
      PaGlobal_Inventory_All._ui.rdo_familyInven:SetCheck(false)
    end
    HandleEventLUp_Inventory_All_SelectTab()
  end
end
function PaGlobalFunc_Inventory_All_PosSave()
  PaGlobal_Inventory_All._tempPosX = Panel_Window_Inventory_All:GetPosX()
  PaGlobal_Inventory_All._tempPosY = Panel_Window_Inventory_All:GetPosY()
end
function PaGlobalFunc_Inventory_All_PosLoad()
  Panel_Window_Inventory_All:SetPosX(PaGlobal_Inventory_All._tempPosX)
  Panel_Window_Inventory_All:SetPosY(PaGlobal_Inventory_All._tempPosY)
end
function PaGlobalFunc_Inventory_All_ResetExchangeData()
  for i = PaGlobal_Inventory_All._exchangeIndex, -1, -1 do
    PaGlobal_Inventory_All._exchangeSlotNo[i] = nil
  end
  PaGlobal_Inventory_All._exchangeIndex = -1
end
function PaGlobalFunc_Inventory_All_AddEffect_WhileExchange(invenSlotNo)
  if tradePC_GetMyLock() then
    return
  end
  if PaGlobal_Inventory_All._exchangeIndex < 0 then
    PaGlobal_Inventory_All._exchangeIndex = PaGlobal_Inventory_All._exchangeIndex + 1
  end
  for i = 0, PaGlobal_Inventory_All._exchangeIndex do
    if nil == PaGlobal_Inventory_All._exchangeSlotNo[i] then
      PaGlobal_Inventory_All._exchangeSlotNo[i] = invenSlotNo
      Inventory_updateSlotData()
      return
    end
  end
  PaGlobal_Inventory_All._exchangeIndex = PaGlobal_Inventory_All._exchangeIndex + 1
  PaGlobal_Inventory_All._exchangeSlotNo[_exchangeIndex] = invenSlotNo
  Inventory_updateSlotData()
end
function PaGlobalFunc_Inventory_All_EraseEffect_WhileExchange(exchangeIndex)
  if tradePC_GetMyLock() then
    return
  end
  PaGlobal_Inventory_All._exchangeSlotNo[exchangeIndex] = nil
  Inventory_updateSlotData()
end
function PaGlobalFunc_Inventory_All_RecentCookItemCheck()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  local returnSlotNo
  local selfPlayer = selfPlayerWrapper:get()
  local invenUseSize = selfPlayer:getInventorySlotCount(not PaGlobal_Inventory_All._isNormalInven)
  for i = 0, invenUseSize - 1 do
    local slotNo = i + useStartSlot
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local invenItemKey = itemSSW:get()._key:getItemKey()
      if itemKey == invenItemKey then
        returnSlotNo = slotNo
      end
    end
  end
  return returnSlotNo
end
function PaGlobalFunc_Inventory_All_FindItemCountByEventType(targetContentsEventType, typeParam1, typeParam2)
  local inventory = getSelfPlayer():get():getInventory(CppEnums.ItemWhereType.eCashInventory)
  local itemCount = 0
  if nil ~= inventory then
    local invenMaxSize = inventory:sizeXXX()
    for ii = 0, invenMaxSize - 1 do
      local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, ii)
      if nil ~= itemWrapper then
        local itemSSW = itemWrapper:getStaticStatus()
        local ContentsEventType = itemSSW:get():getContentsEventType()
        local ContentsEventParam1 = itemSSW:get()._contentsEventParam1
        local ContentsEventParam2 = itemSSW:get()._contentsEventParam2
        local enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
        if ContentsEventType == targetContentsEventType then
          if nil == typeParam1 and nil == typeParam2 then
            itemCount = itemCount + Int64toInt32(itemWrapper:get():getCount_s64())
          elseif nil ~= typeParam1 and ContentsEventParam1 == typeParam1 then
            if nil ~= typeParam2 and ContentsEventParam2 == typeParam2 then
              itemCount = itemCount + Int64toInt32(itemWrapper:get():getCount_s64())
            elseif nil == typeParam2 then
              itemCount = itemCount + Int64toInt32(itemWrapper:get():getCount_s64())
            end
          end
        end
      end
    end
  end
  inventory = getSelfPlayer():get():getInventory(CppEnums.ItemWhereType.eInventory)
  if nil ~= inventory then
    local invenMaxSize = inventory:sizeXXX()
    for ii = 0, invenMaxSize - 1 do
      local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, ii)
      if nil ~= itemWrapper then
        local itemSSW = itemWrapper:getStaticStatus()
        local ContentsEventType = itemSSW:get():getContentsEventType()
        local ContentsEventParam1 = itemSSW:get()._contentsEventParam1
        local ContentsEventParam2 = itemSSW:get()._contentsEventParam2
        local enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
        if ContentsEventType == targetContentsEventType then
          if nil == typeParam1 and nil == typeParam2 then
            itemCount = itemCount + Int64toInt32(itemWrapper:get():getCount_s64())
          elseif nil ~= typeParam1 and ContentsEventParam1 == typeParam1 then
            if nil ~= typeParam2 and ContentsEventParam2 == typeParam2 then
              itemCount = itemCount + Int64toInt32(itemWrapper:get():getCount_s64())
            elseif nil == typeParam2 then
              itemCount = itemCount + Int64toInt32(itemWrapper:get():getCount_s64())
            end
          end
        end
      end
    end
  end
  if true == ToClient_IsDevelopment() then
    inventory = getSelfPlayer():get():getInventory(CppEnums.ItemWhereType.eInstanceInventory)
    if nil ~= inventory then
      local invenMaxSize = inventory:sizeXXX()
      for ii = 0, invenMaxSize - 1 do
        local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInstanceInventory, ii)
        if nil ~= itemWrapper then
          local itemSSW = itemWrapper:getStaticStatus()
          local ContentsEventType = itemSSW:get():getContentsEventType()
          local ContentsEventParam1 = itemSSW:get()._contentsEventParam1
          local ContentsEventParam2 = itemSSW:get()._contentsEventParam2
          local enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
          if ContentsEventType == targetContentsEventType then
            if nil == typeParam1 and nil == typeParam2 then
              itemCount = itemCount + Int64toInt32(itemWrapper:get():getCount_s64())
            elseif nil ~= typeParam1 and ContentsEventParam1 == typeParam1 then
              if nil ~= typeParam2 and ContentsEventParam2 == typeParam2 then
                itemCount = itemCount + Int64toInt32(itemWrapper:get():getCount_s64())
              elseif nil == typeParam2 then
                itemCount = itemCount + Int64toInt32(itemWrapper:get():getCount_s64())
              end
            end
          end
        end
      end
    end
  end
  return itemCount
end
function PaGlobalFunc_Inventory_All_IsFirstSummonItemUse()
  return PaGlobal_Inventory_All._isFirstSummonItemUse
end
function PaGlobalFunc_Inventory_All_IsValuePackageItemUse()
  return PaGlobal_Inventory_All._isValuePackageItemUse
end
function PaGlobalFunc_Inventory_All_SetInventoryDragNoUse(pPanel)
  PaGlobal_Inventory_All._inventoryDragNoUsePanel = pPanel
end
function PaGlobalFunc_Inventory_All_SetCheckNormalInventory(bCheck)
  PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(bCheck)
end
function PaGlobalFunc_Inventory_All_ProcessThrowItem(count, slotNo)
  ToClient_Inventory_ThrowItem(slotNo, count)
end
function PaGlobalFunc_Inventory_All_AddSlotEffectForTutorial(slot, effectString, isLoop, posX, posY)
  slot.icon:AddEffect(effectString, isLoop, posX, posY)
  PaGlobal_TutorialUiManager:getUiMasking():showInventoryMasking(slot.icon:GetPosX(), slot.icon:GetPosY())
end
function PaGlobalFunc_Inventory_All_FilterDead(slotNo, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  if itemWrapper:getStaticStatus():get()._key:getItemKey() == 54002 then
    if true == ToClient_IsAnySiegeBeingOfMyChannel() and true == _ContentsGroup_SeigeSeason5 then
      return true
    else
      return false
    end
  end
  return itemWrapper:getStaticStatus():get():isItemTargetAlive() or not itemWrapper:checkConditions()
end
function PaGlobalFunc_Inventory_All_FilterFodder(slotNo, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  return not itemWrapper:getStaticStatus():get():isUseToVehicle() or not itemWrapper:checkConditions()
end
function PaGlobalFunc_Inventory_All_FilterFuel(slotNo, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  return not isFusionItem(Inventory_GetCurrentInventoryType(), slotNo)
end
function PaGlobalFunc_Inventory_All_UseItemTarget(slotNo, itemWrapper, count_s64, inventoryType)
  if true == PaGlobal_Inventory_All:isRestricted() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_USEITEM"))
    return
  end
  local isTargetSelfPlayer = false
  inventoryUseItem(inventoryType, slotNo, isTargetSelfPlayer)
end
function PaGlobalFunc_Inventory_All_UseFuelItem(slotNo, itemWrapper, count_s64, inventoryType)
  burnItemToActor(inventoryType, slotNo, 1, false)
end
function PaGlobalFunc_Inventory_All_UseItemTargetSelf(whereType, slotNo, equipSlotNo)
  if true == PaGlobal_Inventory_All:isRestricted() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_USEITEM"))
    return
  end
  local isTargetSelfPlayer = true
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemKey = itemWrapper:get():getKey():getItemKey()
  if itemKey >= 41548 and itemKey <= 41570 or itemKey >= 42000 and itemKey <= 42010 or itemKey >= 42034 and itemKey <= 42040 or 42053 == itemKey or 42054 == itemKey then
    audioPostEvent_SystemUi(0, 14)
  end
  if nil == equipSlotNo then
    equipSlotNo = CppEnums.EquipSlotNoClient.eEquipSlotNoCount
  end
  inventoryUseItem(whereType, slotNo, equipSlotNo, isTargetSelfPlayer)
  if (42000 == itemKey or 42001 == itemKey or 42002 == itemKey or 42010 == itemKey or 42003 == itemKey or 42004 == itemKey or 42034 == itemKey or 42035 == itemKey or 42037 == itemKey or 42036 == itemKey or 42006 == itemKey or 42008 == itemKey or 42039 == itemKey or 42038 == itemKey or 42007 == itemKey or 42053 == itemKey or 41610 == itemKey or 42009 == itemKey or 42054 == itemKey or 42057 == itemKey or 42061 == itemKey or 42066 == itemKey or 42055 == itemKey or 42056 == itemKey or 42269 == itemKey or 42270 == itemKey or 42002 == itemKey or 42271 == itemKey or 42276 == itemKey or 42277 == itemKey or 42034 == itemKey or 42277 == itemKey or 42003 == itemKey or 42035 == itemKey or 42009 == itemKey or 41675 == itemKey or 42511 == itemKey or 42038 == itemKey or 42054 == itemKey or 41610 == itemKey or 42037 == itemKey or 42036 == itemKey or 42008 == itemKey or 42271 == itemKey or 42039 == itemKey or 42007 == itemKey) and PaGlobal_SummonBossTutorial_Manager:isDoingSummonBossTutorial() then
    PaGlobal_Inventory_All._isFirstSummonItemUse = true
  end
  if (290033 == itemKey or 290034 == itemKey or 290035 == itemKey or 290036 == itemKey or 290037 == itemKey or 290038 == itemKey or 290039 == itemKey or 290040 == itemKey or 290041 == itemKey) and PaGlobal_ValuePackageTutorial_Manager:isDoingValuePackageTutorial() then
    PaGlobal_Inventory_All._isValuePackageItemUse = true
  end
  if 32 == itemWrapper:getStaticStatus():get():getContentsEventType() then
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_UseAlchemyStoneCheck(true)
    else
      PaGlobalFunc_Equipment_UseAlchemyStoneCheck(true)
    end
    local isAlchemyStoneCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eAlchemyStone)
    if isAlchemyStoneCheck and 0 < itemWrapper:get():getEndurance() then
      useAlchemyStone()
    end
  end
end
function PaGlobalFunc_Inventory_All_InventoryItemComparer(ii, jj)
  return Global_ItemComparer(ii, jj, getInventoryItemByType, Inventory_GetCurrentInventoryType())
end
function PaGlobalFunc_Inventory_All_CompareSpec(whereType, slotNo, isAccessory)
  local selfPlayerWrapper = getSelfPlayer()
  local classType = selfPlayerWrapper:getClassType()
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  local equipItemWrapper = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo())
  local offencePoint = (itemWrapper:getStaticStatus():getMinDamage(0) + itemWrapper:getStaticStatus():getMaxDamage(0)) / 2
  local defencePoint = itemWrapper:getStaticStatus():getDefence(0)
  local equipOffencePoint = 0
  local equipDefencePoint = 0
  local matchEquip = false
  local isEquip = itemWrapper:getStaticStatus():get()._usableClassType:isOn(classType)
  if isEquip and not Panel_Window_Exchange:GetShow() then
    local equipType = itemWrapper:getStaticStatus():getEquipType()
    local firstRingOffence = 0
    local firstRingDeffence = 0
    local secondRingOffence = 0
    local secondRingDeffence = 0
    local matchEquip = true
    if 16 == equipType or 17 == equipType then
      local accSlotNo = PaGlobalFunc_GetAccesoryWorseEquipment_Key(itemWrapper)
      equipItemWrapper = ToClient_getEquipmentItem(accSlotNo)
      if nil ~= equipItemWrapper then
        equipOffencePoint = (equipItemWrapper:getStaticStatus():getMinDamage(0) + equipItemWrapper:getStaticStatus():getMaxDamage(0)) / 2
        equipDefencePoint = equipItemWrapper:getStaticStatus():getDefence()
        return offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, true
      else
        return offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, true
      end
    elseif 15 == equipType or 18 == equipType then
      equipItemWrapper = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo())
      if nil ~= equipItemWrapper then
        equipOffencePoint = (ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getMinDamage(0) + ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getMaxDamage(0)) / 2
        equipDefencePoint = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getDefence()
        matchEquip = true
      else
        equipOffencePoint = 0
        equipDefencePoint = 0
        matchEquip = true
      end
      return offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, true
    end
    equipItemWrapper = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo())
    if nil ~= equipItemWrapper then
      local isTimeOver = equipItemWrapper:checkTimeover()
      if false == isTimeOver then
        equipDefencePoint = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getDefence(0)
      end
      if isEquip then
        local attackType = PaGlobal_Inventory_All:getClassAttackType(classType)
        offencePoint = (itemWrapper:getStaticStatus():getMinDamage(attackType) + itemWrapper:getStaticStatus():getMaxDamage(attackType)) / 2
        if false == isTimeOver then
          equipOffencePoint = (ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getMinDamage(attackType) + ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getMaxDamage(attackType)) / 2
        end
        if __eClassType_Warrior == classType or __eClassType_Valkyrie == classType then
          defencePoint = itemWrapper:getStaticStatus():getDefence(0)
        end
        matchEquip = true
      end
    elseif isEquip then
      local attackType = PaGlobal_Inventory_All:getClassAttackType(classType)
      offencePoint = (itemWrapper:getStaticStatus():getMinDamage(attackType) + itemWrapper:getStaticStatus():getMaxDamage(attackType)) / 2
      defencePoint = itemWrapper:getStaticStatus():getDefence(0)
      matchEquip = true
    end
    isAccessory = false
    if true == _ContentsGroup_ItemRandomOption then
      if nil ~= itemWrapper and false == itemWrapper:isEmptyRandomOption() then
        local randomOptionOffence = 0
        local randomOptionDefence = 0
        for index = 0, __eMaxItemOptionCount - 1 do
          local optionType = itemWrapper:getRandomOptionType(index)
          local optionValue = itemWrapper:getRandomOptionValue(index)
          if __eRandomOptionStatType_DD == optionType then
            randomOptionOffence = optionValue
          elseif __eRandomOptionStatType_PV == optionType then
            randomOptionDefence = randomOptionDefence + optionValue
          elseif __eRandomOptionStatType_DV == optionType then
            randomOptionDefence = randomOptionDefence + optionValue
          end
        end
        offencePoint = offencePoint + randomOptionOffence
        defencePoint = defencePoint + randomOptionDefence
      end
      if nil ~= equipItemWrapper and false == equipItemWrapper:isEmptyRandomOption() then
        local equipRandomOptionOffence = 0
        local equipRandomOptionDefence = 0
        for index = 0, __eMaxItemOptionCount - 1 do
          local optionType = equipItemWrapper:getRandomOptionType(index)
          local optionValue = equipItemWrapper:getRandomOptionValue(index)
          if __eRandomOptionStatType_DD == optionType then
            equipRandomOptionOffence = optionValue
          elseif __eRandomOptionStatType_PV == optionType then
            equipRandomOptionDefence = equipRandomOptionDefence + optionValue
          elseif __eRandomOptionStatType_DV == optionType then
            equipRandomOptionDefence = equipRandomOptionDefence + optionValue
          end
        end
        equipOffencePoint = equipOffencePoint + equipRandomOptionOffence
        equipDefencePoint = equipDefencePoint + equipRandomOptionDefence
      end
    end
    return offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, isAccessory
  end
end
function PaGlobalFunc_Inventory_All_OpenPalette()
  if false == PaGlobal_Inventory_All._ui.rdo_pearlInven:IsCheck() then
    PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(false)
    PaGlobal_Inventory_All._ui.rdo_pearlInven:SetCheck(true)
    if true == _ContentsGroup_changeFamilyInvenOpenAction then
      PaGlobal_Inventory_All._ui.rdo_familyInven:SetCheck(false)
    end
    HandleEventLUp_Inventory_All_SelectTab()
  end
  if _ContentsGroup_NewUI_Dye_All then
    PaGlobal_Palette_All_Open()
  elseif _ContentsGroup_NewUI_Dye_Palette_All then
    PaGlobal_Dye_Palette_All_Open(true)
  else
    FGlobal_DyePalette_Open()
  end
end
function PaGlobalFunc_Inventory_All_OpenManufacture()
  if MiniGame_Manual_Value_FishingStart == true then
    return
  else
    if not IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_MANUFACTURE"))
      return
    end
    if Panel_Window_Inventory_All ~= nil then
      local isInvenOpen = Panel_Window_Inventory_All:GetShow()
      local isManufactureOpen = false
      if true == _ContentsGroup_NewUI_Manufacture_All then
        if nil ~= Panel_Window_Manufacture_All then
          isManufactureOpen = Panel_Window_Manufacture_All:GetShow()
        end
      elseif nil ~= Panel_Manufacture then
        isManufactureOpen = Panel_Manufacture:GetShow()
      end
      if isManufactureOpen == false or isInvenOpen == false then
        audioPostEvent_SystemUi(1, 26)
        if false == _ContentsGroup_NewUI_Manufacture_All then
          Manufacture_Show(nil, CppEnums.ItemWhereType.eInventory, true, true)
        else
          PaGlobalFunc_Manufacture_All_Open(nil, CppEnums.ItemWhereType.eInventory, true, true)
        end
        if isManufactureOpen then
          if true == _ContentsGroup_NewUI_Equipment_All then
            Panel_Window_Equipment_All:SetShow(false)
          else
            Panel_Equipment:SetShow(false)
          end
          if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
            PaGlobalFunc_ClothInventory_All_Close()
          else
            ClothInventory_Close()
          end
        end
      end
    end
  end
end
function PaGlobalFunc_Inventory_All_UpdatePerFrame(deltaTime)
  if deltaTime <= 0 then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  local currentWhereType = Inventory_GetCurrentInventoryType()
  for ii = 0, PaGlobal_Inventory_All.config.slotCount - 1 do
    local slot = PaGlobal_Inventory_All.slots[ii]
    local slotNo = slot._slotNo
    local remainTime = 0
    local itemReuseTime = 0
    local realRemainTime = 0
    local intRemainTime = 0
    if __eTInventorySlotNoUndefined ~= slotNo then
      remainTime = getItemCooltime(currentWhereType, slotNo)
      itemReuseTime = getItemReuseCycle(currentWhereType, slotNo) / 1000
      realRemainTime = remainTime * itemReuseTime
      intRemainTime = realRemainTime - realRemainTime % 1 + 1
    end
    if remainTime > 0 then
      slot.cooltime:UpdateCoolTime(remainTime)
      slot.cooltime:SetShow(true)
      slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
      if itemReuseTime >= intRemainTime then
        slot.cooltimeText:SetShow(true)
      else
        slot.cooltimeText:SetShow(false)
      end
    elseif slot.cooltime:GetShow() then
      slot.cooltime:SetShow(false)
      slot.cooltimeText:SetShow(false)
      local skillSlotItemPosX = slot.cooltime:GetParentPosX()
      local skillSlotItemPosY = slot.cooltime:GetParentPosY()
      audioPostEvent_SystemUi(2, 1)
      Panel_Inventory_CoolTime_Effect_Item_Slot:SetShow(true, true)
      Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("UI_Button_Hide", false, 2.5, 7)
      Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("fUI_Button_Hide", false, 2.5, 7)
      Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosX(skillSlotItemPosX - 7)
      Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosY(skillSlotItemPosY - 10)
    end
  end
end
function PaGlobalFunc_Inventory_All_UpdateInventoryWeight()
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local inventoryType = Inventory_GetCurrentInventoryType()
  local s64_moneyWeight = Defines.u64_const.u64_0
  local s64_equipmentWeight = Defines.u64_const.u64_0
  local s64_allWeight = Defines.u64_const.u64_0
  local s64_maxWeight = Defines.u64_const.u64_0
  if false == _ContentsGroup_changeFamilyInvenOpenAction or CppEnums.ItemWhereType.eFamilyInventory ~= inventoryType then
    local normalInventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eInventory)
    s64_moneyWeight = normalInventory:getMoneyWeight_s64()
    s64_equipmentWeight = selfPlayer:getEquipment():getWeight_s64()
    s64_allWeight = selfPlayer:getCurrentWeight_s64()
    s64_maxWeight = selfPlayer:getPossessableWeight_s64()
  else
    local inventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eFamilyInventory)
    s64_allWeight = inventory:getWeight_s64()
    s64_maxWeight = ToClient_GetFamilyInventoryMaxWeight_s64()
  end
  local s64_allWeight_div = s64_allWeight / Defines.s64_const.s64_100
  local s64_maxWeight_div = s64_maxWeight / Defines.s64_const.s64_100
  if Int64toInt32(s64_allWeight) <= Int64toInt32(s64_maxWeight) then
    PaGlobal_Inventory_All._ui.progress_equipment:SetProgressRate(Int64toInt32((s64_moneyWeight + s64_equipmentWeight) / s64_maxWeight_div))
    PaGlobal_Inventory_All._ui.progress_weight:SetProgressRate(Int64toInt32(s64_allWeight / s64_maxWeight_div))
  else
    PaGlobal_Inventory_All._ui.progress_equipment:SetProgressRate(Int64toInt32((s64_moneyWeight + s64_equipmentWeight) / s64_allWeight_div))
    PaGlobal_Inventory_All._ui.progress_weight:SetProgressRate(Int64toInt32(s64_allWeight / s64_allWeight_div))
  end
  PaGlobal_Inventory_All._ui.txt_weightValue:SetText(makeWeightString(s64_allWeight, 1) .. " / " .. makeWeightString(s64_maxWeight, 0) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  PaGlobal_Inventory_All:changeWeightIcon(s64_allWeight, s64_maxWeight_div)
end
function PaGlobalFunc_Inventory_All_GroundClick(whereType, slotNo)
  if false == Panel_Window_Inventory_All:GetShow() or MessageBoxGetShow() then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  PaGlobal_Inventory_All._deleteItemCount = itemWrapper:get():getCount_s64()
  PaGlobal_Inventory_All._deleteItemName = itemWrapper:getStaticStatus():getName()
  if Defines.s64_const.s64_1 == PaGlobal_Inventory_All._deleteItemCount then
    PaGlobalFunc_Inventory_All_GroundClickMessage(Defines.s64_const.s64_1, slotNo, whereType)
  elseif isUseNewQuickSlot() then
    PaGlobalFunc_Inventory_All_GroundClickMessage(Defines.s64_const.s64_1, slotNo, whereType)
  else
    Panel_NumberPad_Show(true, PaGlobal_Inventory_All._deleteItemCount, slotNo, PaGlobalFunc_Inventory_All_GroundClickMessage, nil, whereType)
  end
end
function PaGlobalFunc_Inventory_All_GroundClickMessage(s64_itemCount, slotNo, whereType)
  if true == PaGlobal_Inventory_All:isRestricted() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_REMOVEITEM"))
    return false
  end
  PaGlobal_Inventory_All._deleteWhereType = whereType
  PaGlobal_Inventory_All._deleteSlotNo = slotNo
  PaGlobal_Inventory_All._deleteItemCount = s64_itemCount
  local Inventory_BurnItemToActor_Yes = function()
    if PaGlobal_Inventory_All._deleteSlotNo ~= nil then
      burnItemToActor(PaGlobal_Inventory_All._deleteWhereType, PaGlobal_Inventory_All._deleteSlotNo, PaGlobal_Inventory_All._deleteItemCount)
    end
  end
  if true == isNearFusionCore() then
    local luaPushItemToCampfireMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_PUSHITEMTOCAMPFIRE_MSG", "itemName", PaGlobal_Inventory_All._deleteItemName, "itemCount", tostring(PaGlobal_Inventory_All._deleteItemCount))
    local luaBurn = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_BURN")
    local messageContent = luaPushItemToCampfireMsg
    local messageboxData = {
      title = luaBurn,
      content = messageContent,
      functionYes = Inventory_BurnItemToActor_Yes,
      functionNo = PaGlobalFunc_Inventory_All_Delete_No,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  elseif isUseNewQuickSlot() then
    FGlobal_SetNewQuickSlot_ByGroundClick(s64_itemCount, slotNo, whereType)
  else
    local luaDeleteItemMsg = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ONLYTRASH_INVENTORY")
    local luaDelete = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE")
    local messageContent = luaDeleteItemMsg
    local messageboxData = {
      title = luaDelete,
      content = messageContent,
      functionYes = PaGlobalFunc_Inventory_All_Delete_No,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    PaGlobalFunc_Inventory_All_RunTrashBtnEffect()
  end
end
function PaGlobalFunc_Inventory_All_CheckDragStartPanel()
  if Panel_Window_Inventory_All == DragManager.dragStartPanel or Panel_Window_ServantInventory == DragManager.dragStartPanel then
    return true
  end
  return false
end
function PaGlobalFunc_Inventory_All_ItemDelete_Check(count, slotNo, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  if true == itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem) then
    local messagebox = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_COPYITEM_DELETE_MSGDESC"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messagebox)
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  PaGlobal_Inventory_All._deleteWhereType = whereType
  PaGlobal_Inventory_All._deleteSlotNo = slotNo
  PaGlobal_Inventory_All._deleteItemCount = count
  DragManager:clearInfo()
  if PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetShow() then
    PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(false)
  end
  local isManufactureOpen = false
  if true == _ContentsGroup_NewUI_Manufacture_All then
    isManufactureOpen = Panel_Window_Manufacture_All:GetShow()
  else
    isManufactureOpen = Panel_Manufacture:GetShow()
  end
  if isManufactureOpen then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_MANUFACTURE_REMOVE"))
    return
  end
  local luaDeleteItemMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETEITEM_MSG", "itemName", itemName, "itemCount", tostring(count))
  local luaDelete = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE")
  local itemExpiration = itemWrapper:getExpirationDate()
  if nil ~= itemExpiration and false == itemExpiration:isIndefinite() then
    local s64_remainTime = getLeftSecond_s64(itemExpiration)
    if Defines.s64_const.s64_0 ~= s64_remainTime then
      luaDeleteItemMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETEITEM_PERIOD_MSG", "itemName", itemName, "itemCount", tostring(count))
    end
  end
  local messageContent = luaDeleteItemMsg
  local messageboxData = {
    title = luaDelete,
    content = messageContent,
    functionYes = PaGlobalFunc_Inventory_All_Delete_Yes,
    functionNo = PaGlobalFunc_Inventory_All_Delete_No,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_Inventory_All_Delete_Yes()
  if nil == PaGlobal_Inventory_All._deleteSlotNo then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_Inventory_All._deleteWhereType, PaGlobal_Inventory_All._deleteSlotNo)
  if nil == itemWrapper then
    return
  end
  local Inventory_Delete_YesXXX = function()
    if nil == PaGlobal_Inventory_All._deleteSlotNo then
      return
    end
    deleteItem(getSelfPlayer():getActorKey(), PaGlobal_Inventory_All._deleteWhereType, PaGlobal_Inventory_All._deleteSlotNo, PaGlobal_Inventory_All._deleteItemCount)
    DragManager:clearInfo()
  end
  if CppEnums.ContentsEventType.ContentsType_InventoryBag == itemWrapper:getStaticStatus():get():getContentsEventType() then
    local bagType = itemWrapper:getStaticStatus():getContentsEventParam1()
    local bagSize = itemWrapper:getStaticStatus():getContentsEventParam2()
    for index = 0, bagSize - 1 do
      local bagItemWrapper = getInventoryBagItemByType(PaGlobal_Inventory_All._deleteWhereType, PaGlobal_Inventory_All._deleteSlotNo, index)
      if nil ~= bagItemWrapper then
        if CppEnums.InventoryBagType.eInventoryBagType_Cash == bagType then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DELETEITEM_ALERT"))
        elseif CppEnums.InventoryBagType.eInventoryBagType_Equipment == bagType then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DELETEITEM_ALERT2"))
        else
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DELETEITEM_ALERT3"))
        end
        DragManager:clearInfo()
        return
      end
    end
  end
  if itemWrapper:isCash() and false == itemWrapper:checkTimeover() and true == checkPaymentPassword() then
    PaymentPassword(Inventory_Delete_YesXXX)
    return
  end
  Inventory_Delete_YesXXX()
  PaGlobal_TutorialManager:handleInventoryDelete(itemWrapper, PaGlobal_Inventory_All._deleteWhereType, PaGlobal_Inventory_All._deleteSlotNo)
end
function PaGlobalFunc_Inventory_All_Delete_No()
  PaGlobal_Inventory_All._deleteWhereType = nil
  PaGlobal_Inventory_All._deleteSlotNo = nil
  DragManager:clearInfo()
  PaGlobalFunc_Inventory_All_ResetTrashBtnEffect()
end
function PaGlobalFunc_Inventory_All_RunTrashBtnEffect()
  if false == PaGlobalFunc_InventoryInfo_GetShow() then
    return
  end
  PaGlobal_Inventory_All._ui.btn_trash:SetVertexAniRun("Ani_Color_New", true)
end
function PaGlobalFunc_Inventory_All_ResetTrashBtnEffect()
  PaGlobal_Inventory_All._ui.btn_trash:SetVertexAniRun("Ani_Color_New", false)
  PaGlobal_Inventory_All._ui.btn_trash:SetColor(Defines.Color.C_FFFFFFFF)
end
function PaGlobalFunc_Inventory_All_ChangeObserveItemSlot(slotNo)
  if nil == slotNo then
    return
  end
  local inventoryType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  PaGlobal_Inventory_All._whereUseItemSlotNo = slotNo
  PaGlobal_Inventory_All._whereUseItemSSW = itemSSW
  WhereUseItemDirectionUpdate(itemSSW, slotNo, true)
end
function PaGlobalFunc_InventoryInfo_GetShow()
  return Panel_Window_Inventory_All:GetShow()
end
function Inventory_GetCurrentInventoryType()
  if false == PaGlobal_Inventory_All._initialize then
    return
  end
  if true == PaGlobal_Inventory_All._ui.rdo_normalInven:IsChecked() then
    return CppEnums.ItemWhereType.eInventory
  elseif true == PaGlobal_Inventory_All._ui.rdo_pearlInven:IsChecked() then
    return CppEnums.ItemWhereType.eCashInventory
  elseif true == _ContentsGroup_changeFamilyInvenOpenAction and true == PaGlobal_Inventory_All._ui.rdo_familyInven:IsChecked() then
    return CppEnums.ItemWhereType.eFamilyInventory
  else
    return CppEnums.ItemWhereType.eInstanceInventory
  end
  return CppEnums.ItemWhereType.eInventory
end
function Inventory_GetCurrentInventory()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return nil
  end
  local selfPlayer = selfPlayerWrapper:get()
  local inventory = selfPlayer:getInventoryByType(Inventory_GetCurrentInventoryType())
  return inventory
end
function Inventory_updateSlotData(isLoad)
  if true == isLoad then
    PaGlobal_Inventory_All:setSlotNoList()
  end
  Inventory_updateOnlySlotData()
  Invnetory_updateData()
end
function Invnetory_updateData()
  if false == PaGlobal_Inventory_All._initialize then
    return
  end
  if false == Panel_Window_Inventory_All:GetShow() then
    return
  end
  if false == ToClient_isOpenFamilyInventory() then
    PaGlobal_Inventory_All._ui.rdo_familyInven:SetShow(false)
    PaGlobal_Inventory_All._ui.rdo_normalInven:SetSpanSize(PaGlobal_Inventory_All._normalInvenButtonSpanX + PaGlobal_Inventory_All._radioButtonSpanXGap, PaGlobal_Inventory_All._ui.rdo_normalInven:GetSpanSize().y)
    PaGlobal_Inventory_All._ui.rdo_pearlInven:SetSpanSize(PaGlobal_Inventory_All._pearlInvenButtonSpanX + PaGlobal_Inventory_All._radioButtonSpanXGap, PaGlobal_Inventory_All._ui.rdo_pearlInven:GetSpanSize().y)
  else
    PaGlobal_Inventory_All._ui.rdo_familyInven:SetShow(true)
    PaGlobal_Inventory_All._ui.rdo_pearlInven:SetSpanSize(PaGlobal_Inventory_All._pearlInvenButtonSpanX, PaGlobal_Inventory_All._ui.rdo_pearlInven:GetSpanSize().y)
    if CppEnums.ServiceResourceType.eServiceResourceType_TR == ToClient_getResourceType() then
      PaGlobal_Inventory_All._ui.rdo_normalInven:SetSpanSize(PaGlobal_Inventory_All._normalInvenButtonSpanX - 10, PaGlobal_Inventory_All._ui.rdo_normalInven:GetSpanSize().y)
      PaGlobal_Inventory_All._ui.rdo_familyInven:SetSpanSize(PaGlobal_Inventory_All._ui.rdo_normalInven:GetSpanSize().x * -1, PaGlobal_Inventory_All._ui.rdo_familyInven:GetSpanSize().y)
    else
      PaGlobal_Inventory_All._ui.rdo_normalInven:SetSpanSize(PaGlobal_Inventory_All._normalInvenButtonSpanX, PaGlobal_Inventory_All._ui.rdo_normalInven:GetSpanSize().y)
    end
  end
  Inventory_SetBottomButton()
  PaGlobal_Inventory_All._ui.btn_olympicFilter:SetShow(nil == PaGlobal_Inventory_All.filterFunc and true == _ContentsGroup_Olympic)
  PaGlobal_Inventory_All:updateSelectBar()
  PaGlobal_Inventory_All:updateMoney()
  PaGlobal_Inventory_All:updateMileageValue()
  PaGlobalFunc_Inventory_All_UpdateInventoryWeight()
  PaGlobal_Inventory_All:updateCapacity()
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    Panel_NewEquip_EffectLastUpdate()
    FGlobal_Inventory_WeightCheck()
  end
  if Panel_Window_Servant_GetShow() then
    Panel_Window_Servant_Update()
  end
  if Panel_IngameCashShop_EasyPayment:IsShow() then
    PaGlobal_EasyBuy:MyPearlUpdate()
    PaGlobal_EasyBuy:Update()
  end
  WhereUseItemDirectionUpdate(PaGlobal_Inventory_All._whereUseItemSSW, PaGlobal_Inventory_All._whereUseItemSlotNo)
  PaGlobalFunc_RepairFunc_All_MoneyUpdate()
  FromClient_RandomShop_All_MoneyUpdate()
end
function Inventory_SetBottomButton()
  if true == _ContentsGroup_changeFamilyInvenOpenAction and (CppEnums.ItemWhereType.eFamilyInventory == Inventory_GetCurrentInventoryType() or true == Panel_Window_FamilyInventory_All:GetShow()) then
    PaGlobal_Inventory_All._ui.btn_moveFamilyInven:SetShow(true)
    PaGlobal_Inventory_All._ui.btn_trash:SetShow(false)
  else
    PaGlobal_Inventory_All._ui.btn_moveFamilyInven:SetShow(false)
    PaGlobal_Inventory_All._ui.btn_trash:SetShow(true)
  end
end
function Inventory_updateOnlySlotData(isLoad)
  if false == PaGlobal_Inventory_All._initialize then
    return
  end
  if false == Panel_Window_Inventory_All:GetShow() then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  PaGlobal_Inventory_All._isFirstSummonItemUse = false
  PaGlobal_Inventory_All._isValuePackageItemUse = false
  local selfPlayer = selfPlayerWrapper:get()
  local playerLevel = selfPlayer:getLevel()
  local isNormalInventory = PaGlobal_Inventory_All._ui.rdo_normalInven:IsChecked()
  local useStartSlot = inventorySlotNoUserStart()
  local inventory = Inventory_GetCurrentInventory()
  local invenUseSize = inventory:size()
  local invenMaxSize = inventory:sizeXXX()
  local currentWhereType = Inventory_GetCurrentInventoryType()
  local classType = selfPlayerWrapper:getClassType()
  local isSorted = PaGlobal_Inventory_All._ui.check_itemSort:IsCheck()
  PaGlobal_Inventory_All._isNormalInven = isNormalInventory
  if CppEnums.ItemWhereType.eFamilyInventory == currentWhereType then
    invenMaxSize = ToClient_GetFamilyInvenotryMaxSlotCount()
  end
  UIScroll.SetButtonSize(PaGlobal_Inventory_All._ui.scroll_inven, PaGlobal_Inventory_All.config.slotCount, invenMaxSize - useStartSlot)
  PaGlobal_Inventory_All._hasWeaponBlackStone = false
  PaGlobal_Inventory_All._hasArmorBlackStone = false
  PaGlobal_Inventory_All._hasSocketItem = false
  PaGlobal_Inventory_All._ui.stc_pearlInvenEffect:EraseAllEffect()
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    Panel_NewEquip_EffectClear()
  end
  for ii = 0, PaGlobal_Inventory_All.config.slotCount - 1 do
    local slotBG = PaGlobal_Inventory_All._slotsBackground[ii]
    slotBG.empty:SetShow(false)
    slotBG.lock:SetShow(false)
    slotBG.plus:SetShow(false)
    slotBG.onlyPlus:SetShow(false)
    slotBG.olympic:SetShow(false)
    if ii < invenUseSize - useStartSlot - PaGlobal_Inventory_All._startSlotIndex then
      slotBG.empty:SetShow(true)
    elseif ii == invenUseSize - useStartSlot - PaGlobal_Inventory_All._startSlotIndex and ii < invenMaxSize - useStartSlot - PaGlobal_Inventory_All._startSlotIndex then
      local isDye = nil ~= Panel_Widget_Dye_All and Panel_Widget_Dye_All:GetShow()
      if not isGameTypeGT() and _ContentsGroup_EasyBuy and not isDye then
        slotBG.lock:SetShow(true)
        if PaGlobal_Inventory_All.slots[ii].icon:GetShow() then
          slotBG.onlyPlus:SetShow(true)
          slotBG.lock:SetShow(false)
        else
          slotBG.plus:SetShow(true)
        end
      else
        slotBG.lock:SetShow(true)
      end
    else
      slotBG.lock:SetShow(true)
    end
    local slot = PaGlobal_Inventory_All.slots[ii]
    slot:clearItem(true)
    slot.icon:SetEnable(true)
    slot.icon:SetIgnore(false)
    slot.icon:SetMonoTone(true)
    slot.isEmpty = true
    slot.icon:EraseAllEffect()
    local slotNo = ii + 2 + PaGlobal_Inventory_All._startSlotIndex
    if true == isSorted then
      slotNo = selfPlayer:getRealInventorySlotNo(currentWhereType, ii + PaGlobal_Inventory_All._startSlotIndex)
    end
    slot._slotNo = slotNo
    local row = math.floor(ii / PaGlobal_Inventory_All.config.slotCols)
    local col = ii % PaGlobal_Inventory_All.config.slotCols
    slot.icon:SetPosX(PaGlobal_Inventory_All.config.slotStartX + PaGlobal_Inventory_All.config.slotGapX * col)
    slot.icon:SetPosY(PaGlobal_Inventory_All.config.slotStartY + PaGlobal_Inventory_All.config.slotGapY * row)
    slot.bagIcon:SetShow(false)
    PaGlobal_Inventory_All.slotEtcData[ii].puzzleControl:SetShow(false)
    local itemWrapper = getInventoryItemByType(currentWhereType, slotNo)
    if nil ~= itemWrapper then
      slot.icon:SetColor(Defines.Color.C_FFFFFFFF)
      slot:setItem(itemWrapper, slotNo)
      slot.isEmpty = false
      local isFiltered = false
      if nil ~= PaGlobal_Inventory_All.filterFunc then
        isFiltered = PaGlobal_Inventory_All.filterFunc(slotNo, itemWrapper, currentWhereType)
        PaGlobal_Inventory_All._isOlympicFilter = false
      end
      slot.icon:SetEnable(not isFiltered)
      slot.icon:SetMonoTone(isFiltered)
      slot.icon:SetIgnore(isFiltered)
      if isFiltered then
        slot.icon:SetAlpha(0.5)
        slot.icon:EraseAllEffect()
      elseif nil ~= PaGlobal_Inventory_All.filterFunc then
        slot.icon:AddEffect("UI_Inventory_Filtering_NoOutline", true, 0, 0)
      end
      local itemSSW = itemWrapper:getStaticStatus()
      local itemEnchantKey = itemWrapper:get():getKey()
      local itemKey = itemEnchantKey:getItemKey()
      for iii = 0, PaGlobal_Inventory_All._exchangeIndex do
        if Panel_Window_Exchange:GetShow() and slotNo == PaGlobal_Inventory_All._exchangeSlotNo[iii] then
          slot.icon:SetColor(Defines.Color.C_FFD20000)
        elseif slotNo == PaGlobal_Inventory_All._exchangeSlotNo[iii] and nil == PaGlobal_Inventory_All._exchangeSlotNo[iii] then
          slot.icon:SetColor(Defines.Color.C_FFFFFFFF)
        end
      end
      local itemBindType = itemSSW:get()._vestedType:getItemKey()
      if Panel_Window_Exchange:GetShow() and itemBindType > 0 then
        slot.icon:SetColor(Defines.Color.C_FFD20000)
      end
      PaGlobal_TutorialManager:handleUpdateInventorySlotData(slot, itemKey)
      if true == itemSSW:isEquipable() then
        local offencePoint = 0
        local defencePoint = 0
        local equipOffencePoint = 0
        local equipDefencePoint = 0
        local matchEquip = false
        local isAccessory = false
        offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, isAccessory = PaGlobalFunc_Inventory_All_CompareSpec(currentWhereType, slotNo, isAccessory)
        local currentEndurance = itemWrapper:get():getEndurance()
        local isUsableServant = itemSSW:isUsableServant()
        if not isUsableServant and not Panel_Window_Exchange:GetShow() and nil ~= defencePoint and nil ~= offencePoint and currentEndurance > 0 and true == matchEquip and true == PaGlobalFunc_Util_CheckSeasonEquip(itemSSW) and defencePoint + offencePoint > equipDefencePoint + equipOffencePoint then
          slot.icon:AddEffect("fUI_BetterItemAura01", true, 0, 0)
          local equipPos = itemWrapper:getStaticStatus():getEquipSlotNo()
          if false == _ContentsGroup_RemasterUI_Main_Alert then
            Panel_NewEquip_Update(equipPos)
          end
          if false == isAccessory then
            PaGlobal_TutorialManager:handleNewEquipInInventory(slot)
          end
        end
        if false == isUsableServant and false == itemSSW:get()._usableClassType:isOn(classType) or false == isUsableServant and false == PaGlobalFunc_Util_CheckSeasonEquip(itemSSW) then
          slot.icon:SetColor(Defines.Color.C_FFD20000)
        end
      elseif true == itemSSW:get():isPushableToSocket() then
        PaGlobal_Inventory_All._hasSocketItem = true
      elseif itemWrapper:isSoulCollector() then
        local isCurrentSoulCount = itemWrapper:getSoulCollectorCount()
        local isMaxSoulCount = itemWrapper:getSoulCollectorMaxCount()
        local itemIconPath = itemWrapper:getStaticStatus():getIconPath()
        if isCurrentSoulCount == isMaxSoulCount then
          slot.icon:ChangeTextureInfoName("New_UI_Common_forLua/ExceptionIcon/00040351_2.dds")
        elseif isCurrentSoulCount > 0 then
          slot.icon:ChangeTextureInfoName("New_UI_Common_forLua/ExceptionIcon/00040351_1.dds")
        else
          slot.icon:ChangeTextureInfoName("icon/" .. itemIconPath)
        end
        local x1, y1, x2, y2 = setTextureUV_Func(slot.icon, 0, 0, 42, 42)
        slot.icon:getBaseTexture():setUV(x1, y1, x2, y2)
        slot.icon:setRenderTexture(slot.icon:getBaseTexture())
      else
        PaGlobal_Inventory_All:addEffectBlackStone(ii, isFiltered, slotNo)
        PaGlobal_Inventory_All:potionAutoSetPosition(playerLevel, itemKey, currentWhereType, slotNo)
        if true == PaGlobal_SummonBossTutorial_Manager:isDoingSummonBossTutorial() and not PaGlobalFunc_Inventory_All_IsFirstSummonItemUse() and (42000 == itemKey or 42001 == itemKey or 41607 == itemKey or 42002 == itemKey or 42010 == itemKey or 42003 == itemKey or 42004 == itemKey or 42034 == itemKey or 42035 == itemKey or 42037 == itemKey or 42036 == itemKey or 42006 == itemKey or 42008 == itemKey or 42039 == itemKey or 42038 == itemKey or 42007 == itemKey or 42053 == itemKey or 41610 == itemKey or 42009 == itemKey or 42054 == itemKey or 42057 == itemKey or 42061 == itemKey or 42066 == itemKey or 42055 == itemKey or 42056 == itemKey or 42269 == itemKey or 42270 == itemKey or 42002 == itemKey or 42271 == itemKey or 42276 == itemKey or 42277 == itemKey or 42034 == itemKey or 42277 == itemKey or 42003 == itemKey or 42035 == itemKey or 42009 == itemKey or 41675 == itemKey or 42511 == itemKey or 42038 == itemKey or 42054 == itemKey or 41610 == itemKey or 42037 == itemKey or 42036 == itemKey or 42008 == itemKey or 42271 == itemKey or 42039 == itemKey or 42007 == itemKey) then
          slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
        end
        if 42405 == itemKey and questList_hasProgressQuest(4015, 6) then
          slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
        end
        if true == PaGlobal_ValuePackageTutorial_Manager:isDoingValuePackageTutorial() and not PaGlobalFunc_Inventory_All_IsValuePackageItemUse() and (290033 == itemKey or 290034 == itemKey or 290035 == itemKey or 290036 == itemKey or 290037 == itemKey or 290038 == itemKey or 290039 == itemKey or 290040 == itemKey or 290041 == itemKey) then
          slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
        end
      end
      if true == PaGlobal_Inventory_All._isOlympicFilter and true == _ContentsGroup_Olympic and __eOlympicItemType_Mission == itemSSW:get()._olympicItemType then
        slotBG.olympic:SetShow(true)
      end
    end
  end
  PaGlobal_Inventory_All:setNewItemEffect()
  PaGlobal_Inventory_All:setNewPearlTabEffect()
  PaGlobalFunc_Inventory_All_FindPuzzle()
  PaGlobal_Inventory_All:findSearchItem(false)
end
function Inventory_SetFunctor(filterFunction, rClickFunction, otherWindowOpenFunction, effect)
  if nil ~= PaGlobal_Inventory_All.otherWindowOpenFunc and nil ~= otherWindowOpenFunction then
    local otherWindowOpenFuncDiff = otherWindowOpenFunction ~= PaGlobal_Inventory_All.otherWindowOpenFunc
    if otherWindowOpenFuncDiff and (nil ~= filterFunction or nil ~= rClickFunction or nil ~= otherWindowOpenFunction) then
      PaGlobal_Inventory_All.otherWindowOpenFunc()
    end
  end
  if nil ~= filterFunction and "function" ~= type(filterFunction) then
    filterFunction = nil
    UI.ASSERT(false, "Param 1 must be Function type")
  end
  if nil ~= rClickFunction and "function" ~= type(rClickFunction) then
    rClickFunction = nil
    UI.ASSERT(false, "Param 1 must be Function type")
  end
  if nil ~= effect and "function" ~= type(effect) then
    effect = nil
    UI.ASSERT(false, "Param 1 must be Function type")
  end
  PaGlobal_Inventory_All.otherWindowOpenFunc = otherWindowOpenFunction
  PaGlobal_Inventory_All.rClickFunc = rClickFunction
  PaGlobal_Inventory_All.filterFunc = filterFunction
  PaGlobal_Inventory_All.effect = effect
  if Panel_Window_Inventory_All:GetShow() then
    Inventory_updateSlotData()
  end
end
function InventoryWindow_Show(uiType, isCashInven, isMarket, isFamilyInven)
  if true == _ContentsGroup_DuelCharacterCopyEquip and nil ~= PaGlobal_Equip_CharacterTag_ItemCopy_CanOpenInventory and false == PaGlobal_Equip_CharacterTag_ItemCopy_CanOpenInventory() then
    return
  end
  if true == _ContentsGroup_isFairy and true == _ContentsGroup_NewUI_Fairy_All and (true == PaGlobal_FairyInfo_IsGetShow() or true == PaGlobal_FairyChangeSkill_IsGetShow()) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYOPEN_NOUSE"))
    return
  end
  if true == _ContentsGroup_DeleteMaxEnchanterName and true == PaGlobal_DeleteMaxEnchanterName_GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MAXENCHANT_DELETENAME_NOUSE"))
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_Inventory_All.effect = nil
  PaGlobal_Inventory_All._startSlotIndex = 0
  PaGlobal_Inventory_All._openUiType = uiType
  PaGlobal_Inventory_All._isMarketOpen = isMarket
  local isSorted = ToClient_IsSortedInventory()
  PaGlobal_Inventory_All._ui.check_itemSort:SetCheck(isSorted)
  local isUISubApp = Panel_Window_Inventory_All:IsUISubApp()
  PaGlobal_Inventory_All._ui.check_popup:SetCheck(isUISubApp)
  local openFamilyInven = false
  if true == _ContentsGroup_changeFamilyInvenOpenAction and nil ~= isFamilyInven then
    openFamilyInven = isFamilyInven
  end
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    if nil == isCashInven then
      if nil ~= Panel_ColorBalance and Panel_ColorBalance:GetShow() or nil ~= Panel_Window_ColorMix_All and Panel_Window_ColorMix_All:GetShow() or Panel_Window_Extraction_Cloth:GetShow() then
        PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(false)
        PaGlobal_Inventory_All._ui.rdo_pearlInven:SetCheck(true)
      else
        PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(true)
        PaGlobal_Inventory_All._ui.rdo_pearlInven:SetCheck(false)
      end
    elseif isCashInven then
      PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(false)
      PaGlobal_Inventory_All._ui.rdo_pearlInven:SetCheck(true)
    else
      PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(true)
      PaGlobal_Inventory_All._ui.rdo_pearlInven:SetCheck(false)
    end
  elseif nil == isCashInven then
    if nil ~= Panel_ColorBalance and Panel_ColorBalance:GetShow() or nil ~= Panel_Window_ColorMix_All and Panel_Window_ColorMix_All:GetShow() or nil ~= Panel_Window_Extraction_Costume_All and Panel_Window_Extraction_Costume_All:GetShow() then
      PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(false)
      PaGlobal_Inventory_All._ui.rdo_pearlInven:SetCheck(true)
      if true == _ContentsGroup_changeFamilyInvenOpenAction then
        PaGlobal_Inventory_All._ui.rdo_familyInven:SetCheck(false)
      end
    else
      PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(not openFamilyInven)
      PaGlobal_Inventory_All._ui.rdo_pearlInven:SetCheck(false)
      if true == _ContentsGroup_changeFamilyInvenOpenAction then
        PaGlobal_Inventory_All._ui.rdo_familyInven:SetCheck(openFamilyInven)
      end
    end
  elseif isCashInven then
    PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(false)
    PaGlobal_Inventory_All._ui.rdo_pearlInven:SetCheck(true)
    if true == _ContentsGroup_changeFamilyInvenOpenAction then
      PaGlobal_Inventory_All._ui.rdo_familyInven:SetCheck(false)
    end
  else
    PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(not openFamilyInven)
    PaGlobal_Inventory_All._ui.rdo_pearlInven:SetCheck(false)
    if true == _ContentsGroup_changeFamilyInvenOpenAction then
      PaGlobal_Inventory_All._ui.rdo_familyInven:SetCheck(openFamilyInven)
    end
  end
  PaGlobal_Inventory_All._ui.scroll_inven:SetControlTop()
  local curUIMode = GetUIMode()
  if Defines.UIMode.eUIMode_InGameCashShop == curUIMode or Defines.UIMode.eUIMode_DyeNew == curUIMode then
    Panel_Window_Inventory_All:SetShow(true, false)
  else
    Panel_Window_Inventory_All:SetShow(true, true)
  end
  Inventory_updateSlotData(true)
  PaGlobal_TutorialManager:handleOpenedInventory()
  if isGameTypeRussia() and (getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_CBT or getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_OBT) then
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetMonoTone(true)
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetIgnore(true)
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetEnable(false)
  else
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetMonoTone(false)
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetIgnore(false)
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetEnable(true)
  end
  if isFlushedUI() then
    PaGlobal_Inventory_All._ui.btn_manufacture:SetEnable(false)
    PaGlobal_Inventory_All._ui.btn_manufacture:SetMonoTone(true)
    PaGlobal_Inventory_All._ui.btn_alchemyStone:SetEnable(false)
    PaGlobal_Inventory_All._ui.btn_alchemyStone:SetMonoTone(true)
    PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetEnable(false)
    PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetMonoTone(true)
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetEnable(false)
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
  else
    PaGlobal_Inventory_All._ui.btn_manufacture:SetEnable(true)
    PaGlobal_Inventory_All._ui.btn_manufacture:SetMonoTone(false)
    PaGlobal_Inventory_All._ui.btn_alchemyStone:SetEnable(true)
    PaGlobal_Inventory_All._ui.btn_alchemyStone:SetMonoTone(false)
    PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetEnable(true)
    PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetMonoTone(false)
    if isGameTypeRussia() and (getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_CBT or getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_OBT) then
      PaGlobal_Inventory_All._ui.btn_dyePalette:SetEnable(false)
      PaGlobal_Inventory_All._ui.btn_dyePalette:SetMonoTone(true)
    else
      PaGlobal_Inventory_All._ui.btn_dyePalette:SetEnable(true)
      PaGlobal_Inventory_All._ui.btn_dyePalette:SetMonoTone(false)
    end
    PaGlobal_Inventory_All._ui.btn_alchemyStone:SetShow(true)
    PaGlobal_Inventory_All._ui.btn_alchemyFigureHead:SetShow(true)
    PaGlobal_Inventory_All._ui.btn_manufacture:SetShow(true)
    PaGlobal_Inventory_All._ui.btn_dyePalette:SetShow(true)
    PaGlobal_Inventory_All._ui.btn_doItemMove:SetShow(false)
    PaGlobal_Inventory_All._ui.btn_setItemMove:SetShow(false)
  end
  if false == _ContentsGroup_NewUI_Dialog_All then
    if true == Panel_Npc_Dialog:GetShow() and nil == dialog_getTalker() then
      PaGlobalFunc_Inventory_All_OnScreenResize()
    end
  elseif true == Panel_Npc_Dialog_All:GetShow() and nil == dialog_getTalker() then
    PaGlobalFunc_Inventory_All_OnScreenResize()
  end
  if _ContentsGroup_NewUI_Dye_All then
    local isDye = nil ~= Panel_Widget_Dye_All and Panel_Widget_Dye_All:GetShow()
    PaGlobal_Inventory_All._ui.btn_buyWeight:SetMonoTone(isDye)
    PaGlobal_Inventory_All._ui.btn_buyWeight:SetIgnore(isDye)
  end
  PaGlobalFunc_BetterEquipment_Close()
  PaGlobal_Inventory_All:changeMileageIcon()
  PaGlobal_Inventory_All:clearFocusSearchText()
end
function InventoryWindow_Close()
  if true == PaGlobalFunc_ExchangePC_GetShow() then
    return
  end
  if nil ~= PaGlobalFunc_ServantIcon_MaidCoolUpdate then
    PaGlobalFunc_ServantIcon_MaidCoolUpdate()
  end
  if Panel_Window_Inventory_All:IsUISubApp() then
    Inventory_SetFunctor(nil, nil, nil, nil)
    return
  end
  if true == _ContentsGroup_NewUI_Equipment_All then
    if Panel_Window_Equipment_All:IsUISubApp() then
      PaGlobalFunc_Equipment_All_Close(true)
    end
  elseif Panel_Equipment:IsUISubApp() then
    HandleClicked_EquipmentWindow_Close()
  end
  if false == PaGlobal_Inventory_All_CheckHasFilterOtherWindowOpen() then
    if nil ~= PaGlobal_Inventory_All.otherWindowOpenFunc then
      local callFunc = PaGlobal_Inventory_All.otherWindowOpenFunc
      PaGlobal_Inventory_All.otherWindowOpenFunc = nil
      callFunc()
    end
    PaGlobal_Inventory_All.filterFunc = nil
    PaGlobal_Inventory_All.rClickFunc = nil
    PaGlobal_Inventory_All.effect = nil
  end
  PaGlobalFunc_Inventory_All_ResetTrashBtnEffect()
  PaGlobal_Inventory_All._isOlympicFilter = false
  if ToClient_IsSavedUi() then
    ToClient_SaveUiInfo(false)
    ToClient_SetSavedUi(false)
  end
  if Panel_NumberPad_IsPopUp() then
    Panel_NumberPad_Show(false, Defines.s64_const.s64_0, 0, nil)
  end
  if true == Panel_Window_Inventory_All:GetShow() then
    for ii = 0, PaGlobal_Inventory_All.INVEN_MAX_SLOTNO do
      PaGlobal_Inventory_All.newItemData[ii] = nil
      PaGlobal_Inventory_All.newPearlItemData[ii] = nil
      PaGlobal_Inventory_All.searchItemEffectOff[ii] = nil
    end
    UIMain_ItemUpdateRemove()
  end
  if true == _ContentsGroup_FamilyInventory then
    PaGlobal_FamilyInvnetory_Close()
  end
  Panel_Window_Inventory_All:SetShow(false, false)
  if true == _ContentsGroup_NewUI_Equipment_All then
    PaGlobalFunc_Equipment_All_SetShow(false)
  else
    Equipment_SetShow(false)
  end
  PaGlobal_TutorialManager:handleClosedInventory()
  Panel_Tooltip_Item_hideTooltip()
  if true == _ContentsGroup_NewUI_AlchemyStone_All then
    if nil ~= Panel_Window_AlchemyStone_All and true == Panel_Window_AlchemyStone_All:GetShow() then
      PaGlobalFunc_AlchemyStone_All_Close()
    end
  elseif nil ~= Panel_AlchemyStone and true == Panel_AlchemyStone:GetShow() then
    FGlobal_AlchemyStone_Close()
  end
  if false == _ContentsGroup_NewUI_AlchemyFigureHead_All then
    if nil ~= Panel_AlchemyFigureHead and Panel_AlchemyFigureHead:GetShow() then
      FGlobal_AlchemyFigureHead_Close()
    end
  elseif nil ~= Panel_AlchemyFigureHead_All and Panel_AlchemyFigureHead_All:GetShow() then
    PaGlobal_AlchemyFigureHead_All_Close()
  end
  if _ContentsGroup_NewUI_Dye_All then
    if Panel_Window_Palette_All:GetShow() then
      PaGlobal_Palette_All_Close()
    end
  elseif _ContentsGroup_NewUI_Dye_Palette_All then
    if nil ~= Panel_Window_Dye_Palette_All and Panel_Window_Dye_Palette_All:GetShow() then
      PaGlobal_Dye_Palette_All_Close()
    end
  elseif nil ~= Panel_DyePalette and Panel_DyePalette:GetShow() then
    FGlobal_DyePalette_Close()
  end
  PaGlobal_Inventory_All._ui.stc_pearlInvenEffect:EraseAllEffect()
  for _, slot in pairs(PaGlobal_Inventory_All.slots) do
    slot.icon:EraseAllEffect()
    slot.icon:SetEnable(true)
    slot.icon:SetMonoTone(false)
    slot.icon:SetIgnore(false)
  end
  if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
    if PaGlobalFunc_ClothInventory_All_GetShow() then
      PaGlobalFunc_ClothInventory_All_Close()
    end
  elseif Panel_Window_ClothInventory:GetShow() then
    ClothInventory_Close()
  end
  if true == PaGlobalFunc_ServantInventory_GetShow() then
    ServantInventory_Close()
  end
  if true == PaGlobal_Inventory_All._openUiType then
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_SetShow(false)
    else
      FGlobal_Equipment_SetHide(false)
    end
  elseif false == PaGlobal_Inventory_All._openUiType then
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_SetShow(true)
    else
      FGlobal_Equipment_SetHide(true)
    end
  end
  if true == _ContentsGroup_ItemMove and true == Panel_Window_ItemMoveSet:GetShow() then
    PaGlobal_ItemMoveSet:prepareClose(false)
  end
  PaGlobal_Inventory_All:clearFocusSearchText()
  TooltipSimple_Hide()
  PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetShow(false)
  PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(false)
  Panel_Window_Inventory_All:SetPosX(PaGlobal_Inventory_All._defaultPosX)
  Panel_Window_Inventory_All:SetPosY(PaGlobal_Inventory_All._defaultPosY)
end
function PaGlobal_Inventory_All_CheckBlackStoneAndSocket()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  PaGlobal_Inventory_All._hasWeaponBlackStone = false
  PaGlobal_Inventory_All._hasArmorBlackStone = false
  PaGlobal_Inventory_All._hasSocketItem = false
  local startSlotNo = inventorySlotNoUserStart()
  local slotCount = selfPlayerWrapper:get():getInventorySlotCount(false)
  for slotNo = startSlotNo, slotCount do
    itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), slotNo)
    if nil ~= itemWrapper then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      local itemSSW = itemWrapper:getStaticStatus()
      if 16001 == itemKey then
        PaGlobal_Inventory_All._hasWeaponBlackStone = true
      elseif 16002 == itemKey then
        PaGlobal_Inventory_All._hasArmorBlackStone = true
      elseif nil ~= itemSSW and itemSSW:get():isPushableToSocket() then
        PaGlobal_Inventory_All._hasSocketItem = true
      end
    end
  end
end
function PaGlobal_Inventory_All_CheckHasFilterOtherWindowOpen()
  if nil ~= Panel_Window_ServantInventory and true == Panel_Window_ServantInventory:GetShow() then
    return true
  end
  if nil ~= Panel_Window_VehicleInfo_All and true == Panel_Window_VehicleInfo_All:GetShow() then
    return true
  end
  if nil ~= Panel_Window_ShipInfo_All and true == Panel_Window_ShipInfo_All:GetShow() then
    return true
  end
  return false
end
function PaGlobal_Inventory_All_ChangeInventoryItemSlotRUpEvent(isChange)
  if false == _ContentsGroup_ItemMove then
    return
  end
  local self = PaGlobal_Inventory_All
  for ii = 0, self.config.slotCount - 1 do
    local slot = self.slots[ii]
    if true == isChange then
      slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Inventory_All_ItemMoveSetExceptionItemKey(" .. ii .. ")")
    else
      slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Inventory_All_SlotRClick(" .. ii .. ")")
    end
  end
end
function HandleEventRUp_Inventory_All_ItemMoveSetExceptionItemKey(index)
  if false == _ContentsGroup_ItemMove then
    return
  end
  local self = PaGlobal_Inventory_All
  local whereType = Inventory_GetCurrentInventoryType()
  local slotNo = self.slots[index]._slotNo
  if false == PaGlobal_ItemMoveSet_BasicItemFilter(slotNo, nil, whereType) then
    PaGlobal_ItemMoveSet:setExceptionItemKey(whereType, slotNo)
  end
end
