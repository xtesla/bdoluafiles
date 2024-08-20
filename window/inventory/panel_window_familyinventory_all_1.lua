function PaGlobal_FamilyInventory_All:initialize()
  if true == PaGlobal_FamilyInventory_All._initialize then
    return
  end
  local topBG = UI.getChildControl(Panel_Window_FamilyInventory_All, "Static_TopItemSortBG")
  self._ui._chkSort = UI.getChildControl(topBG, "CheckButton_ItemSort")
  self._ui._stcCapacity = UI.getChildControl(topBG, "Static_Text_Capacity")
  local stc_mainSlotBG = UI.getChildControl(Panel_Window_FamilyInventory_All, "Static_MainSlotBG")
  self._ui._scroll = UI.getChildControl(stc_mainSlotBG, "Scroll_CashInven")
  self._ui._stc_scrollArea = UI.getChildControl(Panel_Window_FamilyInventory_All, "Scroll_Area")
  local WeightBG = UI.getChildControl(Panel_Window_FamilyInventory_All, "Static_Texture_Weight_Background")
  self._ui._btnBuyWeight = UI.getChildControl(WeightBG, "Button_BuyWeight")
  self._ui._progressWeight = UI.getChildControl(WeightBG, "Progress2_Weight")
  self._ui._stcWeight = UI.getChildControl(WeightBG, "StaticText_Weight")
  self._ui._stcWeightIcon = UI.getChildControl(WeightBG, "Static_WeightIcon")
  local bottomBG = UI.getChildControl(Panel_Window_FamilyInventory_All, "Static_ButtonTypeBG")
  self._ui._chkMove = UI.getChildControl(bottomBG, "CheckButton_OpenEquip")
  local backBg = UI.getChildControl(Panel_Window_FamilyInventory_All, "Static_1")
  self._maxSlotCount = ToClient_GetFamilyInvenotryMaxSlotCount() - __eTInventorySlotNoUseStart
  if false == self._showBuyWeight then
    self._ui._btnBuyWeight:SetShow(false)
    self._ui._btnBuyWeight:SetIgnore(true)
    local buttonSizeX = self._ui._btnBuyWeight:GetSizeX()
    WeightBG:SetSize(WeightBG:GetSizeX() + buttonSizeX, WeightBG:GetSizeY())
    self._ui._progressWeight:SetSize(self._ui._progressWeight:GetSizeX() + buttonSizeX, self._ui._progressWeight:GetSizeY())
  end
  if true == _ContentsGroup_changeFamilyInvenOpenAction then
    backBg:SetDepth(1)
    Panel_Window_FamilyInventory_All:SetDepthSort()
    Panel_Window_FamilyInventory_All:SetSpanSize(620, Panel_Window_FamilyInventory_All:GetSpanSize().y)
  end
  backBg:SetShow(_ContentsGroup_changeFamilyInvenOpenAction)
  self._ui._chkMove:SetShow(not _ContentsGroup_changeFamilyInvenOpenAction)
  local slotGapX = 54
  local slotGapY = 54
  self._showSlotCount = math.floor(stc_mainSlotBG:GetSizeY() / slotGapY) * self._slotCols
  self._ui._chkSort:SetCheck(ToClient_IsSortedFamilyInventory())
  self._ui._chkSort:SetEnableArea(0, 0, self._ui._chkSort:GetSizeX() + self._ui._chkSort:GetTextSizeX() + 10, self._ui._chkSort:GetSizeY())
  self:initSlotControl(stc_mainSlotBG, slotGapX, slotGapY)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_FamilyInventory_All:validate()
  if nil == Panel_Window_FamilyInventory_All then
    return
  end
  self._ui._chkSort:isValidate()
  self._ui._stcCapacity:isValidate()
  self._ui._stc_scrollArea:isValidate()
  self._ui._scroll:isValidate()
  self._ui._btnBuyWeight:isValidate()
  self._ui._progressWeight:isValidate()
  self._ui._stcWeight:isValidate()
  self._ui._stcWeightIcon:isValidate()
  self._ui._chkMove:isValidate()
end
function PaGlobal_FamilyInventory_All:initSlotControl(stc_mainSlotBG, slotGapX, slotGapY)
  if nil ~= self._slotsBG then
    return
  end
  local slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCooltime = true,
    createExpiration = true,
    createExpirationBG = true,
    createExpiration2h = true,
    createCooltimeText = true,
    createCash = true,
    isTranslation = true
  }
  self._slotsBG = Array.new()
  self._slots = Array.new()
  local slotStartX = 15
  local slotStartY = 150
  local template_slotBG = UI.getChildControl(stc_mainSlotBG, "Static_SlotBG_Temp")
  local template_slot = UI.getChildControl(stc_mainSlotBG, "Static_Slot_Temp")
  local template_lockSlot = UI.getChildControl(stc_mainSlotBG, "Static_LockSlot_Temp")
  local template_plusSlot = UI.getChildControl(stc_mainSlotBG, "Static_PlusSlot")
  for ii = 0, self._showSlotCount - 1 do
    local slotBG = {}
    slotBG.background = UI.cloneControl(template_slotBG, Panel_Window_FamilyInventory_All, "FInven_Slot_BG_" .. ii)
    local slot = SlotItem.new(slot, "FamilyInventory_" .. ii, ii, Panel_Window_FamilyInventory_All, slotConfig)
    slot:createChild()
    slotBG.empty = UI.cloneControl(template_slot, Panel_Window_FamilyInventory_All, "FInven_Slot_Base_" .. ii)
    slotBG.lock = UI.cloneControl(template_lockSlot, Panel_Window_FamilyInventory_All, "FInven_Slot_Lock_" .. ii)
    slotBG.plus = UI.cloneControl(template_plusSlot, Panel_Window_FamilyInventory_All, "FInven_Slot_Plus_" .. ii)
    local row = math.floor(ii / self._slotCols)
    local col = ii % self._slotCols
    slot.icon:SetPosX(slotStartX + slotGapX * col)
    slot.icon:SetPosY(slotStartY + slotGapY * row)
    slot.icon:SetSize(44, 44)
    slot.border:SetSize(44, 44)
    slot.border:SetPosX(0.5)
    slot.border:SetPosY(0.5)
    slot.cooltime:SetSize(44, 44)
    slot.cooltime:SetPosX(0)
    slot.cooltime:SetPosY(0)
    slotBG.background:SetSize(slot.icon:GetSizeX(), slot.icon:GetSizeY())
    slotBG.background:SetPosX(slot.icon:GetPosX())
    slotBG.background:SetPosY(slot.icon:GetPosY())
    slotBG.background:SetShow(true)
    slotBG.empty:SetPosX(slotStartX + slotGapX * col)
    slotBG.empty:SetPosY(slotStartY + slotGapY * row)
    slotBG.lock:SetPosX(slotStartX + slotGapX * col)
    slotBG.lock:SetPosY(slotStartY + slotGapY * row)
    slotBG.plus:SetPosX(slotStartX + slotGapX * col - 1)
    slotBG.plus:SetPosY(slotStartY + slotGapY * row - 1)
    slot.icon:SetAutoDisableTime(0.2)
    slot.icon:SetEnableDragAndDrop(true)
    slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_FamilyInventory_SlotRClick(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_LDown", "HandleEventLDown_FamilyInventory_SlotLDown(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_FamilyInventory_DropHandler(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_PressMove", "HandleEventPressMove_FamilyInventory_SlotDrag(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_FamilyInventory_IconTooltip(true, " .. ii .. ")")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_FamilyInventory_IconTooltip(false, " .. ii .. ")")
    Panel_Tooltip_Item_SetPosition(ii, slot, "FamilyInventory")
    self._slots[ii] = slot
    self._slotsBG[ii] = slotBG
  end
end
function PaGlobal_FamilyInventory_All:registEventHandler()
  if nil == Panel_Window_FamilyInventory_All then
    return
  end
  local titleArea = UI.getChildControl(Panel_Window_FamilyInventory_All, "StaticText_Title")
  local btnClose = UI.getChildControl(titleArea, "Button_Win_Close")
  btnClose:addInputEvent("Mouse_LUp", "PaGlobal_FamilyInvnetory_Close(true)")
  local btnQuestion = UI.getChildControl(titleArea, "Button_Question")
  btnQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"FamilyInventory\" )")
  if true == self._showBuyWeight then
    self._ui._btnBuyWeight:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BuyWeightTooltip(true)")
    self._ui._btnBuyWeight:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BuyWeightTooltip(false)")
    self._ui._btnBuyWeight:addInputEvent("Mouse_LUp", "PaGlobal_EasyBuy:Open( 86 )")
  end
  self._ui._stcCapacity:addInputEvent("Mouse_LUp", "HandleEventLUp_FamilyInventory_ShowSlotBuy()")
  if false == _ContentsGroup_changeFamilyInvenOpenAction then
    self._ui._chkMove:addInputEvent("Mouse_LUp", "HandleEventLUp_FamilyInvenotry_ToggleMoveMode()")
  end
  self._ui._chkSort:addInputEvent("Mouse_LUp", "HandleEventLUp_FamilyInventory_ToggleSort()")
  registerEvent("FromClient_InventoryUpdate", "PaGlobal_FamilyInvnetory_UpdateFamilyInventory")
  registerEvent("FromClient_FamilyInventoryChanged", "PaGlobal_FamilyInvnetory_UpdateFamilyInventory")
  if false == _ContentsGroup_changeFamilyInvenOpenAction then
    Panel_Window_FamilyInventory_All:RegisterShowEventFunc(true, "PaGlobal_FamilyInventory_ShowAni()")
    Panel_Window_FamilyInventory_All:RegisterShowEventFunc(false, "PaGlobal_FamilyInventory_HideAni()")
  end
  Panel_Window_FamilyInventory_All:RegisterUpdateFunc("PaGlobalFunc_FamilyInvnetory_UpdatePerFrame")
end
function PaGlobal_FamilyInventory_All:prepareOpen()
  if nil == Panel_Window_FamilyInventory_All or true == Panel_Window_FamilyInventory_All:GetShow() then
    return
  end
  if false == ToClient_isOpenFamilyInventory() then
    return
  end
  if true == self._ui._chkSort:IsCheck() then
    local selfPlayerWrapper = getSelfPlayer()
    if nil == selfPlayerWrapper then
      self._ui._chkSort:SetCheck(false)
    else
      selfPlayerWrapper:get():sortInventorySlotNo(CppEnums.ItemWhereType.eFamilyInventory)
    end
  end
  self._showStartSlot = 0
  self:updateSlots()
  self:updateFamilyInventoryInfo()
  if true == _ContentsGroup_NewUI_Inventory_All then
    if true == _ContentsGroup_changeFamilyInvenOpenAction then
      InventoryWindow_Show()
      PaGlobalFunc_Inventory_All_familyInventoryButtonActive(false)
    elseif false == Panel_Window_Inventory_All:GetShow() then
      InventoryWindow_Show()
    end
  end
  if _ContentsGroup_NewUI_Dye_Palette_All then
    if nil ~= Panel_Window_Dye_Palette_All and true == Panel_Window_Dye_Palette_All:GetShow() then
      PaGlobal_Dye_Palette_All_Close()
    end
  elseif nil ~= Panel_DyePalette and true == Panel_DyePalette:GetShow() then
    FGlobal_DyePalette_Close()
  end
  if true == _ContentsGroup_NewUI_Equipment_All then
    PaGlobalFunc_Equipment_All_Close(true)
  else
    HandleClicked_EquipmentWindow_Close()
  end
  if true == _ContentsGroup_changeFamilyInvenOpenAction then
    self._ui._chkMove:SetCheck(true)
    self:ToggleMoveMode()
  end
  PaGlobal_FamilyInventory_All:open()
  Inventory_SetBottomButton()
end
function PaGlobal_FamilyInventory_All:open()
  if nil == Panel_Window_FamilyInventory_All then
    return
  end
  Panel_Window_FamilyInventory_All:SetShow(true, not _ContentsGroup_changeFamilyInvenOpenAction)
end
function PaGlobal_FamilyInventory_All:prepareClose(isOpenEquip)
  if nil == Panel_Window_FamilyInventory_All or false == Panel_Window_FamilyInventory_All:GetShow() then
    return
  end
  if true == isOpenEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_Open(true)
    else
      HandleClicked_EquipmentWindow_Open()
    end
  end
  if true == self._ui._chkMove:IsCheck() then
    self._ui._chkMove:SetCheck(false)
    self:ToggleMoveMode()
  end
  if true == _ContentsGroup_changeFamilyInvenOpenAction then
    PaGlobalFunc_Inventory_All_familyInventoryButtonActive(true)
    InventoryWindow_Show(true, false, false, true)
  end
  PaGlobal_FamilyInventory_All:close()
end
function PaGlobal_FamilyInventory_All:close()
  if nil == Panel_Window_FamilyInventory_All then
    return
  end
  Panel_Window_FamilyInventory_All:SetShow(false, not _ContentsGroup_changeFamilyInvenOpenAction)
end
function PaGlobal_FamilyInventory_All:update()
  if nil == Panel_Window_FamilyInventory_All or false == self._initialize then
    return
  end
  self:updateSlots()
  self:updateFamilyInventoryInfo()
end
function PaGlobal_FamilyInventory_All:updateSlots()
  if false == self._initialize then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local inventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eFamilyInventory)
  local usableSlotCount = inventory:size()
  local isShowPlus = usableSlotCount < ToClient_GetFamilyInvenotryMaxSlotCount()
  for ii = 0, self._showSlotCount - 1 do
    local slotBG = self._slotsBG[ii]
    local slot = self._slots[ii]
    if nil ~= slotBG and nil ~= slot then
      local slotNo = self:getRealSlotNo(ii)
      local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eFamilyInventory, slotNo)
      if nil == itemWrapper then
        slot:clearItem(true)
      else
        slot:setItem(itemWrapper, slotNo)
      end
      slotBG.empty:SetShow(usableSlotCount > slotNo)
      slotBG.plus:SetShow(isShowPlus and slotNo == usableSlotCount)
      if true == isShowPlus then
        slotBG.lock:SetShow(usableSlotCount < slotNo)
      else
        slotBG.lock:SetShow(usableSlotCount <= slotNo)
      end
    end
  end
end
function PaGlobal_FamilyInventory_All:updateFamilyInventoryInfo()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local inventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eFamilyInventory)
  local s64_allWeight = inventory:getWeight_s64()
  local s64_maxWeight = ToClient_GetFamilyInventoryMaxWeight_s64()
  local progressRate = Int64toInt32(s64_allWeight) / Int64toInt32(s64_maxWeight) * 100
  self._ui._progressWeight:SetProgressRate(progressRate)
  self._ui._stcWeight:SetText(makeWeightString(s64_allWeight, 1) .. " / " .. makeWeightString(s64_maxWeight, 0) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  if progressRate >= 80 then
    self._ui._stcWeightIcon:SetColor(Defines.Color.C_FFD05D48)
  else
    self._ui._stcWeightIcon:SetColor(Defines.Color.C_FFFFEDD4)
  end
  self._capacity = inventory:size() - __eTInventorySlotNoUseStart
  local freeCount = inventory:getFreeCount()
  local useSlotCount = self._capacity - freeCount
  local leftCountPercent = useSlotCount / self._capacity * 100
  if leftCountPercent >= 100 then
    fontColor = "<PAColor0xFFF03838>"
  elseif leftCountPercent > 90 then
    fontColor = "<PAColor0xFFFF8957>"
  else
    fontColor = "<PAColor0xFFFFF3AF>"
  end
  self._ui._stcCapacity:SetText(fontColor .. tostring(useSlotCount) .. "/" .. tostring(self._capacity) .. "<PAOldColor>")
end
function PaGlobal_FamilyInventory_All:ToggleMoveMode()
  if true == self._ui._chkMove:IsCheck() then
    Inventory_SetFunctor(PaGlobal_FamilyInvnetory_IsMoveableItem, HandleEventRUp_FamilyInventory_InvenSlotRClick, nil, nil)
  else
    Inventory_SetFunctor(nil, nil, nil, nil)
  end
end
function PaGlobal_FamilyInventory_All:slotRClick_MoveMode(slotNo)
  local itemWhereType = CppEnums.ItemWhereType.eFamilyInventory
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  if Defines.s64_const.s64_1 == itemCount then
    PaGlobal_FamilyInvnetory_PopItemFromFamilyInventory(1, slotNo, itemWhereType)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobal_FamilyInvnetory_PopItemFromFamilyInventory)
  end
end
function PaGlobal_FamilyInventory_All:slotRClick_UseMode(slotNo)
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local itemWhereType = CppEnums.ItemWhereType.eFamilyInventory
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if nil == itemWrapper or true == itemWrapper:empty() then
    return
  end
  local itemEnchantWrapper = itemWrapper:getStaticStatus()
  if nil == itemEnchantWrapper then
    return
  end
  local itemConnectUi = itemEnchantWrapper:getConnectUi()
  local itemStatic = itemEnchantWrapper:get()
  if nil ~= itemStatic then
    audioPostEvent_SystemItem(itemStatic._itemMaterial)
  end
  if selfPlayerWrapper:get():doRideMyVehicle() and itemStatic:isUseToVehicle() then
    inventoryUseItem(itemWhereType, slotNo, itemEnchantWrapper:getEquipSlotNo(), false)
    return
  end
  if true == itemEnchantWrapper:isPopupItem() then
    if false == _ContentsGroup_NewUI_UseItem_All then
      Panel_UserItem_PopupItem(itemEnchantWrapper, itemWhereType, slotNo, nil)
    else
      PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, itemWhereType, slotNo, nil)
    end
  elseif eConnectUiType.eConnectUi_Undefined ~= itemConnectUi then
    if eConnectUiType.eConnectUi_Letter == itemConnectUi then
      ConnectLetterUI(itemWrapper:get():getKey():getItemKey())
    else
      ConnectUI(itemConnectUi)
    end
  elseif false == itemStatic:isUseToVehicle() then
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_UseItemTargetSelf(itemWhereType, slotNo, nil)
    else
      Inventory_UseItemTargetSelf(itemWhereType, slotNo, nil)
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CANT_USEITEM"))
  end
end
function PaGlobal_FamilyInventory_All:slotRClick_Inventory(slotNo)
  local itemCount = 0
  local itemWhereType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if nil == itemWrapper then
    return
  end
  itemCount = itemWrapper:get():getCount_s64()
  if Defines.s64_const.s64_1 == itemCount then
    PaGlobal_FamilyInvnetory_PushItemToFamilyInventory(1, slotNo, itemWhereType)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobal_FamilyInvnetory_PushItemToFamilyInventory, false, itemWhereType)
  end
end
function PaGlobal_FamilyInventory_All:getRealSlotNo(slotIndex)
  if false == self._ui._chkSort:IsCheck() then
    return slotIndex + self._showStartSlot + __eTInventorySlotNoUseStart
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return __eTInventorySlotNoUndefined
  end
  if self._maxSlotCount <= slotIndex + self._showStartSlot then
    return __eTInventorySlotNoUndefined
  end
  return selfPlayerWrapper:get():getRealInventorySlotNo(CppEnums.ItemWhereType.eFamilyInventory, slotIndex + self._showStartSlot)
end
