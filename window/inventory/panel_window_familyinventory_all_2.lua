function HandleEventLUp_FamilyInvenotry_ToggleMoveMode()
  PaGlobal_FamilyInventory_All:ToggleMoveMode()
end
function HandleEventRUp_FamilyInventory_SlotRClick(slotIndex)
  local slotNo = PaGlobal_FamilyInventory_All:getRealSlotNo(slotIndex)
  if true == PaGlobal_FamilyInventory_IsMoveMode() then
    PaGlobal_FamilyInventory_All:slotRClick_MoveMode(slotNo)
  else
    PaGlobal_FamilyInventory_All:slotRClick_UseMode(slotNo)
  end
end
function HandleEventRUp_FamilyInventory_InvenSlotRClick(slotNo)
  if nil == Panel_Window_FamilyInventory_All or false == Panel_Window_FamilyInventory_All:GetShow() then
    return
  end
  PaGlobal_FamilyInventory_All:slotRClick_Inventory(slotNo)
end
function HandleEventOnOut_FamilyInventory_IconTooltip(isShow, index)
  if false == isShow then
    PaGlobal_FamilyInventory_All._tooltipSlotNo = nil
    Panel_Tooltip_Item_Show_GeneralNormal(index, "FamilyInventory", false, false)
    TooltipSimple_Hide()
    return
  end
  local maxCapacity = ToClient_GetFamilyInvenotryMaxSlotCount() - __eTInventorySlotNoUseStart
  if maxCapacity > PaGlobal_FamilyInventory_All._capacity and PaGlobal_FamilyInventory_All._capacity == index and not isGameTypeGT() and _ContentsGroup_EasyBuy then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ADDINVENTORY_TOOLTIP_NAME")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ADDINVENTORY_TOOLTIP_DESC")
    local control = PaGlobal_Inventory_All.slots[index].icon
    TooltipSimple_Show(control, name, desc)
    return
  end
  local slotNo = PaGlobal_FamilyInventory_All:getRealSlotNo(index)
  PaGlobal_FamilyInventory_All._tooltipSlotNo = slotNo
  Panel_Tooltip_Item_Show_GeneralNormal(index, "FamilyInventory", true, false)
end
function HandleEventLDown_FamilyInventory_SlotLDown(slotIndex)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local inventoryType = CppEnums.ItemWhereType.eFamilyInventory
  local slotNo = PaGlobal_FamilyInventory_All:getRealSlotNo(slotIndex)
  if true == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    if (isGameTypeJapan() or isGameTypeRussia()) and getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_CBT then
      return
    end
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eFamilyInventory, slotNo)
    if nil ~= itemWrapper then
      ProductNote_Item_ShowToggle(itemWrapper:get():getKey():getItemKey())
      PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetShow(false)
    end
    return
  end
  local maxCapacity = ToClient_GetFamilyInvenotryMaxSlotCount() - __eTInventorySlotNoUseStart
  if PaGlobal_FamilyInventory_All._capacity == slotIndex and maxCapacity > PaGlobal_FamilyInventory_All._capacity then
    PaGlobal_EasyBuy:Open(87)
  end
end
function HandleEventLUp_FamilyInventory_ShowSlotBuy()
  local maxCapacity = ToClient_GetFamilyInvenotryMaxSlotCount() - __eTInventorySlotNoUseStart
  if maxCapacity > PaGlobal_FamilyInventory_All._capacity then
    PaGlobal_EasyBuy:Open(87)
  end
end
function HandleEventLUp_FamilyInventory_DropHandler(slotIndex)
  if nil == DragManager.dragStartPanel then
    return false
  end
  local slotNo = PaGlobal_FamilyInventory_All:getRealSlotNo(slotIndex)
  local isManufactureOpen = false
  if true == _ContentsGroup_NewUI_Manufacture_All then
    isManufactureOpen = Panel_Window_Manufacture_All:GetShow()
  else
    isManufactureOpen = Panel_Manufacture:GetShow()
  end
  local isAlchemyOpen = false
  if true == _ContentsGroup_NewUI_Alchemy_All then
    isAlchemyOpen = Panel_Window_Alchemy_All:GetShow()
  else
    isAlchemyOpen = Panel_Alchemy:GetShow()
  end
  if Panel_Window_Exchange:IsShow() or isManufactureOpen or isAlchemyOpen or MessageBoxGetShow() or false == _ContentsGroup_NewUI_XXX and true == FGlobal_Enchant_SetTargetItem() or Panel_Window_DetectUser:IsShow() or false == _ContentsGroup_NewUI_Pet_All and PaGlobalFunc_PetRegister_GetShow() or true == _ContentsGroup_NewUI_Pet_All and PaGlobal_PetRegister_All_GetShow() or true == PaGlobalFunc_RandomBoxSelect_All_GetShow() or true == Panel_UseItem_All:GetShow() then
    DragManager:clearInfo()
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_REPOSITIONITEM_WHILE_UI"))
    return false
  end
  if Panel_Window_FamilyInventory_All == DragManager.dragStartPanel then
    inventory_swapItem(CppEnums.ItemWhereType.eFamilyInventory, DragManager.dragSlotInfo, slotNo)
    DragManager:clearInfo()
  else
    DragManager:itemDragMove(CppEnums.MoveItemToType.Type_FamilyInventory, getSelfPlayer():getActorKey())
  end
  return true
end
function HandleEventPressMove_FamilyInventory_SlotDrag(slotIndex)
  if MessageBoxGetShow() then
    return
  end
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    if true == Panel_Window_Extraction_Caphras:GetShow() then
      return
    end
  elseif true == Panel_Window_Extraction_Caphras_All:GetShow() then
    return
  end
  local slotNo = PaGlobal_FamilyInventory_All:getRealSlotNo(slotIndex)
  local whereType = CppEnums.ItemWhereType.eFamilyInventory
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  DragManager:setDragInfo(Panel_Window_FamilyInventory_All, whereType, slotNo, "Icon/" .. itemWrapper:getStaticStatus():getIconPath(), PaGlobalFunc_Inventory_All_GroundClick, getSelfPlayer():getActorKey())
  if itemWrapper:getStaticStatus():get():isItemSkill() or itemWrapper:getStaticStatus():get():isUseToVehicle() or true == isEquip then
    QuickSlot_ShowBackGround()
  end
  Item_Move_Sound(itemWrapper)
  FGlobal_PopupMoveItem_Init(whereType, slotNo, CppEnums.MoveItemToType.Type_FamilyInventory, getSelfPlayer():getActorKey())
end
function HandleEventLUp_FamilyInventory_ToggleSort()
  local isSort = PaGlobal_FamilyInventory_All._ui._chkSort:IsCheck()
  ToClient_SetSortedFamilyInventory(isSort)
  if true == isSort then
    PaGlobal_FamilyInventory_All:updateSlots()
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    PaGlobal_FamilyInventory_All:updateSlots()
  end
  selfPlayerWrapper:get():sortInventorySlotNo(CppEnums.ItemWhereType.eFamilyInventory)
  PaGlobal_FamilyInventory_All:updateSlots()
end
function HandleEventScroll_FamilyInvnetory_UpdateScroll(isUp)
  local self = PaGlobal_FamilyInventory_All
  local prevSlotIndex = PaGlobal_Inventory_All._showStartSlot
  local maxShowSlotCount = __eTInventorySlotNoMax - __eTInventorySlotNoUseStart
  local intervalSlotIndex = maxShowSlotCount - self._showSlotCount
  local slotRows = self._showSlotCount / self._slotCols
  self._showStartSlot = UIScroll.ScrollEvent(self._ui._scroll, isUp, slotRows, maxShowSlotCount, self._showStartSlot, self._slotCols)
  if prevSlotIndex == self._showStartSlot then
    return
  end
  self:updateSlots()
end
function PaGlobal_FamilyInventory_ShowAni()
  if nil == Panel_Window_FamilyInventory_All then
    return
  end
  Panel_Window_FamilyInventory_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  local aniInfo1 = Panel_Window_FamilyInventory_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Panel_Window_FamilyInventory_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_FamilyInventory_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  aniInfo1:SetDisableWhileAni(true)
  local aniInfo2 = Panel_Window_FamilyInventory_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_FamilyInventory_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_FamilyInventory_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  aniInfo2:SetDisableWhileAni(true)
end
function PaGlobal_FamilyInventory_HideAni()
  if nil == Panel_Window_FamilyInventory_All then
    return
  end
  Panel_Window_FamilyInventory_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_FamilyInventory_All:addColorAnimation(0, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobal_FamilyInvnetory_UpdateFamilyInventory()
  if nil == Panel_Window_FamilyInventory_All or false == Panel_Window_FamilyInventory_All:GetShow() then
    return
  end
  PaGlobal_FamilyInventory_All:update()
end
function PaGlobalFunc_FamilyInvnetory_UpdatePerFrame(deltaTime)
  if deltaTime <= 0 then
    return
  end
  local self = PaGlobal_FamilyInventory_All
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local whereType = CppEnums.ItemWhereType.eFamilyInventory
  for ii = 0, self._showSlotCount - 1 do
    local slot = self._slots[ii]
    local slotNo = self:getRealSlotNo(ii)
    local remainTime = 0
    local itemReuseTime = 0
    local realRemainTime = 0
    local intRemainTime = 0
    if __eTInventorySlotNoUndefined ~= slotNo then
      remainTime = getItemCooltime(whereType, slotNo)
      itemReuseTime = getItemReuseCycle(whereType, slotNo) / 1000
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
function PaGlobal_FamilyInvnetory_Open()
  if nil == Panel_Window_FamilyInventory_All or true == Panel_Window_FamilyInventory_All:GetShow() then
    return
  end
  PaGlobal_FamilyInventory_All:prepareOpen()
end
function PaGlobal_FamilyInvnetory_Close(isOpenEquip)
  if nil == Panel_Window_FamilyInventory_All or false == Panel_Window_FamilyInventory_All:GetShow() then
    return
  end
  PaGlobal_FamilyInventory_All:prepareClose(isOpenEquip)
end
function PaGlobal_FamilyInvnetoryShowToggle()
  if nil == Panel_Window_FamilyInventory_All then
    return
  end
  if true == Panel_Window_FamilyInventory_All:GetShow() then
    InventoryWindow_Close()
  else
    PaGlobal_FamilyInventory_All:prepareOpen()
  end
end
function PaGlobal_FamilyInvnetory_IsMoveableItem(idx, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  return not itemWrapper:checkPushFamilyInventory()
end
function PaGlobal_FamilyInvnetory_PushItemToFamilyInventory(itemCount, slotNo, itemwhereType)
  if nil == Panel_Window_FamilyInventory_All or false == Panel_Window_FamilyInventory_All:GetShow() then
    return
  end
  ToClient_RequestPopInventoryItemToFamilyInventory(itemwhereType, slotNo, itemCount)
end
function PaGlobal_FamilyInvnetory_PopItemFromFamilyInventory(itemCount, slotNo)
  if nil == Panel_Window_FamilyInventory_All or false == Panel_Window_FamilyInventory_All:GetShow() then
    return
  end
  ToClient_RequestPushFamilyInventoryItemToInventory(slotNo, itemCount)
end
function PaGlobal_FamilyInvnetory_GetToopTipItem()
  if nil == PaGlobal_FamilyInventory_All._tooltipSlotNo then
    return nil
  end
  return getInventoryItemByType(CppEnums.ItemWhereType.eFamilyInventory, PaGlobal_FamilyInventory_All._tooltipSlotNo)
end
function PaGlobal_FamilyInventory_IsMoveMode()
  if nil == Panel_Window_FamilyInventory_All or false == Panel_Window_FamilyInventory_All:GetShow() then
    return false
  end
  return PaGlobal_FamilyInventory_All._ui._chkMove:IsCheck()
end
