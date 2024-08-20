Panel_Popup_MoveItem:SetShow(false, false)
Panel_Popup_MoveItem:setMaskingChild(true)
Panel_Popup_MoveItem:ActiveMouseEventEffect(true)
Panel_Popup_MoveItem:SetDragEnable(true)
Panel_Popup_MoveItem:setGlassBackground(true)
Panel_Popup_MoveItem:RegisterShowEventFunc(true, "Popup_MoveItemShowAni()")
Panel_Popup_MoveItem:RegisterShowEventFunc(false, "Popup_MoveItemHideAni()")
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_color = Defines.Color
local isMoveItemMoney = false
local popupMoveItem = {
  _config = {
    constSlotStartX = 6,
    constSlotStartY = 5,
    constSlotGapY = 35
  },
  _staticBG = UI.getChildControl(Panel_Popup_MoveItem, "Static_FunctionBG"),
  _whereType = nil,
  _slotNo = nil,
  _s64_count = Defines.s64_const.s64_0,
  _fromWindowType = CppEnums.MoveItemToType.Type_Count,
  _fromActorKeyRaw = nil,
  _toActorKeyRaw = nil,
  _slots = Array.new()
}
function Popup_MoveItemShowAni()
  UIAni.fadeInSCR_Right(Panel_Popup_MoveItem)
end
function Popup_MoveItemHideAni()
  Panel_Popup_MoveItem:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Popup_MoveItem:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function popupMoveItem:init()
  UI.ASSERT(nil ~= self._staticBG and "number" ~= type(self._staticBG), "Static_FunctionBG")
  for ii = 0, CppEnums.MoveItemToType.Type_Count - 1 do
    local slot = {}
    slot.button = UI.createAndCopyBasePropertyControl(Panel_Popup_MoveItem, "Button_Function", Panel_Popup_MoveItem, "PopupMoveItem_Button_" .. ii)
    slot.button:SetPosX(self._config.constSlotStartX)
    slot.button:SetPosY(self._config.constSlotStartY + self._config.constSlotGapY * ii)
    slot.button:SetShow(true)
    slot.button:addInputEvent("Mouse_LUp", "HandleClickedMoveItemButton(" .. ii .. ")")
    slot._toType = nil
    slot._toActorKeyRaw = nil
    self._slots[ii] = slot
  end
  self._staticBG:SetShow(true)
end
function popupMoveItem:update()
  for ii = 0, CppEnums.MoveItemToType.Type_Count - 1 do
    local slot = self._slots[ii]
    slot.button:SetShow(false)
  end
  local count = 0
  local index = 0
  for ii = 0, CppEnums.MoveItemToType.Type_Count - 1 do
    if ii ~= self._fromWindowType then
      local slot = self._slots[ii]
      slot._toType = nil
      slot._toActorKeyRaw = nil
      if PopupMoveItem_IsButtonShow(slot, ii) then
        slot.button:SetPosX(self._config.constSlotStartX)
        slot.button:SetPosY(self._config.constSlotStartY + self._config.constSlotGapY * count)
        if 0 == ii then
          local temporaryWrapper = getTemporaryInformationWrapper()
          local vehicleWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
          if nil ~= temporaryWrapper and nil ~= vehicleWrapper then
            slot.button:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INVENTORY_TEXT_TITLE") .. "(" .. vehicleWrapper:getName() .. ")")
          end
        elseif 1 == ii then
          local temporaryWrapper = getTemporaryInformationWrapper()
          local vehicleWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
          if nil ~= temporaryWrapper and nil ~= vehicleWrapper then
            slot.button:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INVENTORY_TEXT_TITLE") .. "(" .. vehicleWrapper:getName() .. ")")
          end
        elseif 2 == ii then
          slot.button:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MOVEITEM_TO_BUTTON_TOPET"))
        elseif CppEnums.MoveItemToType.Type_FamilyInventory == ii then
          slot.button:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAMILYINVENTORY_TITLE"))
        else
          slot.button:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MOVEITEM_TO_BUTTON" .. tostring(ii - 1)))
        end
        slot.button:SetShow(true)
        count = count + 1
        index = ii
      end
    end
  end
  if 0 == count then
    if CppEnums.MoveItemToType.Type_Warehouse == self._fromWindowType then
      HandleClickedMoveItemButtonXXX(nil, nil)
    elseif CppEnums.MoveItemToType.Type_ShipWarehouse == self._fromWindowType then
      HandleClickedMoveItemButtonXXX(nil, nil)
    elseif CppEnums.MoveItemToType.Type_NewShip == self._fromWindowType then
      HandleClickedMoveItemButtonXXX(nil, nil)
    end
    return false
  elseif 1 == count then
    HandleClickedMoveItemButton(index)
    return false
  end
  return true
end
function popupMoveItem:registEventHandler()
end
function popupMoveItem:registMessageHandler()
end
function FGlobal_PopupMoveItem_InitByInventory(slotNo, itemWrapper, s64_count, inventoryType)
  FGlobal_PopupMoveItem_Init(inventoryType, slotNo, CppEnums.MoveItemToType.Type_Player, getSelfPlayer():getActorKey(), true)
end
function FGlobal_PopupMoveItem_Init(whereType, slotNo, fromWindowType, fromActorKeyRaw, isOpen)
  local self = popupMoveItem
  local itemWrapper = getItemFromTypeAndSlot(fromWindowType, fromActorKeyRaw, whereType, slotNo)
  if nil == itemWrapper or false == itemWrapper then
    return
  end
  self._whereType = whereType
  self._slotNo = slotNo
  self._fromWindowType = fromWindowType
  self._fromActorKeyRaw = fromActorKeyRaw
  self._s64_count = itemWrapper:get():getCount_s64()
  if true == _ContentsGroup_NewDelivery then
    self._s64_count = self._s64_count - toInt64(0, ToClient_NewDeliveryGetPackItemCountBySlotNo(slotNo))
  end
  if not isOpen then
    return
  end
  local isShow = self:update()
  local mousePosX = getMousePosX()
  local scrX = getScreenSizeX()
  if isShow then
    if scrX < mousePosX + Panel_Popup_MoveItem:GetSizeX() then
      Panel_Popup_MoveItem:SetPosX(scrX - Panel_Popup_MoveItem:GetSizeX() - 5)
    else
      Panel_Popup_MoveItem:SetPosX(getMousePosX())
    end
    Panel_Popup_MoveItem:SetPosY(getMousePosY() + 5)
    PopupMoveItem_Open()
  end
  if __eTInventorySlotNoMoney == self._slotNo then
    isMoveItemMoney = true
  else
    isMoveItemMoney = false
  end
  local itemWrapper
  if CppEnums.MoveItemToType.Type_Player == fromWindowType then
    itemWrapper = getInventoryItemByType(whereType, slotNo)
  elseif CppEnums.MoveItemToType.Type_Warehouse == fromWindowType then
    if _ContentsGroup_NewUI_WareHouse_All then
      itemWrapper = PaGlobal_Warehouse_All_GetItem(slotNo)
    else
      itemWrapper = Warehouse_GetItem(slotNo)
    end
  elseif CppEnums.MoveItemToType.Type_Vehicle == fromWindowType or CppEnums.MoveItemToType.Type_Ship == fromWindowType then
    itemWrapper = getServantInventoryItemBySlotNo(self._fromActorKeyRaw, slotNo)
  elseif CppEnums.MoveItemToType.Type_ShipWarehouse == fromWindowType then
    itemWrapper = PaGlobal_CargoLoading_GetMoveItem(slotNo)
  elseif CppEnums.MoveItemToType.Type_NewShip == fromWindowType then
    itemWrapper = PaGlobal_ShipInfo_All_GetMoveItem(slotNo)
  end
  if nil ~= itemWrapper then
    Item_Move_Sound(itemWrapper)
  end
end
function HandleClickedMoveItemButton(index)
  local self = popupMoveItem
  if CppEnums.MoveItemToType.Type_Count == self._fromWindowType then
    return
  end
  if nil == self._slots[index] then
    return
  end
  local toWhereType = self._slots[index]._toType
  local toActorKeyRaw = self._slots[index]._toActorKeyRaw
  HandleClickedMoveItemButtonXXX(toWhereType, toActorKeyRaw)
end
function HandleClickedMoveItemButtonXXX(toWhereType, toActorKeyRaw)
  local self = popupMoveItem
  local fromWhereType = self._fromWindowType
  local fromActorKeyRaw = self._fromActorKeyRaw
  if CppEnums.MoveItemToType.Type_Player == fromWhereType then
    if CppEnums.MoveItemToType.Type_Vehicle == toWhereType or CppEnums.MoveItemToType.Type_Ship == toWhereType or CppEnums.MoveItemToType.Type_Pet == toWhereType then
      PopupMoveItem_MoveInventoryItemFromActorToActor(toActorKeyRaw, self._s64_count, self._whereType, self._slotNo)
    elseif CppEnums.MoveItemToType.Type_Warehouse == toWhereType then
      local isMaidCheck = false
      if _ContentsGroup_NewUI_WareHouse_All then
        isMaidCheck = PaGlobal_Warehouse_All_OpenByMaidCheck()
      else
        isMaidCheck = FGlobal_WarehouseOpenByMaidCheck()
      end
      if isMaidCheck then
        local itemWrapper = getInventoryItemByType(self._whereType, self._slotNo)
        if nil ~= itemWrapper then
          local itemSSW = itemWrapper:getStaticStatus()
          local weight = Int64toInt32(itemSSW:get()._weight) / 10000
          local dividedByWeight = 0
          if weight > 0 then
            dividedByWeight = math.floor(100 / weight)
          end
          if false == _ContentsGroup_UseMultiMaid then
            if false == itemSSW:isMoney() then
              self._s64_count = toInt64(0, math.min(dividedByWeight, Int64toInt32(self._s64_count)))
            end
          elseif false == itemSSW:isMoney() then
            if nil == PaGlobal_Warehouse_All_IsUseMultiMaidOpen then
              return
            end
            if false == PaGlobal_Warehouse_All_IsUseMultiMaidOpen() then
              self._s64_count = toInt64(0, math.min(dividedByWeight, Int64toInt32(self._s64_count)))
            elseif false == _ContentsGroup_MoveNonStackItem or true == itemSSW:isStackable() then
              local maxMoveCountPerOnce = dividedByWeight
              local availableMaidCount = ToClient_getUsableMaidCountByType(false)
              if 0 == availableMaidCount then
                Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantFindUseableMaid"))
                return
              end
              local reqTotalMoveCount = availableMaidCount * maxMoveCountPerOnce
              self._s64_count = toInt64(0, math.min(reqTotalMoveCount, Int64toInt32(self._s64_count)))
            else
              local nonStackItemCount = ToClient_getNonStackItemCount(self._whereType, self._slotNo, false)
              local availableMaidCount = ToClient_getUsableMaidCountByType(false)
              if 0 == availableMaidCount then
                Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantFindUseableMaid"))
                return
              end
              if nonStackItemCount > 1 then
                self._s64_count = toInt64(0, math.min(nonStackItemCount, availableMaidCount))
              end
            end
          end
        end
        if self._s64_count <= Defines.s64_const.s64_0 then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMaidDeliveryCantHeavyItem"))
          return
        end
      elseif true == _ContentsGroup_MoveNonStackItem and true == PaGlobal_Warehouse_All_MoveNonStackItemCheck() then
        local itemWrapper = getInventoryItemByType(self._whereType, self._slotNo)
        if nil ~= itemWrapper and false == itemWrapper:getStaticStatus():isMoney() and false == itemWrapper:getStaticStatus():isStackable() then
          local nonStackItemCount = ToClient_getNonStackItemCount(self._whereType, self._slotNo, false)
          if nonStackItemCount > 1 then
            self._s64_count = toInt64(0, nonStackItemCount)
          end
        end
      end
      if _ContentsGroup_NewUI_WareHouse_All then
        PaGlobal_Warehouse_All_PushFromInventoryItem(self._s64_count, self._whereType, self._slotNo, fromActorKeyRaw)
      else
        Warehouse_PushFromInventoryItem(self._s64_count, self._whereType, self._slotNo, fromActorKeyRaw)
      end
    elseif CppEnums.MoveItemToType.Type_FamilyInventory == toWhereType and true == _ContentsGroup_FamilyInventory then
      if Defines.s64_const.s64_1 == self._s64_count then
        PaGlobal_FamilyInvnetory_PushItemToFamilyInventory(self._s64_count, self._slotNo, self._whereType)
      else
        Panel_NumberPad_Show(true, self._s64_count, self._slotNo, PaGlobal_FamilyInvnetory_PushItemToFamilyInventory, false, self._whereType)
      end
    end
  elseif CppEnums.MoveItemToType.Type_Vehicle == fromWhereType or CppEnums.MoveItemToType.Type_Ship == fromWhereType or CppEnums.MoveItemToType.Type_Pet == fromWhereType then
    if CppEnums.MoveItemToType.Type_Vehicle == toWhereType or CppEnums.MoveItemToType.Type_Ship == toWhereType or CppEnums.MoveItemToType.Type_Pet == toWhereType or CppEnums.MoveItemToType.Type_Player == toWhereType then
      PopupMoveItem_MoveInventoryItemFromActorToActor(toActorKeyRaw, self._s64_count, self._whereType, self._slotNo)
    elseif CppEnums.MoveItemToType.Type_Warehouse == toWhereType then
      if _ContentsGroup_NewUI_WareHouse_All then
        local isMaidCheck = PaGlobal_Warehouse_All_OpenByMaidCheck()
        if false == isMaidCheck then
          PaGlobal_Warehouse_All_PushFromInventoryItem(self._s64_count, self._whereType, self._slotNo, fromActorKeyRaw)
          PopupMoveItem_Close()
          return
        end
        local itemWrapper
        if true == (CppEnums.ItemWhereType.eServantInventory == self._whereType) then
          itemWrapper = getServantInventoryItemBySlotNo(fromActorKeyRaw, self._slotNo)
        else
          itemWrapper = getInventoryItemByType(self._whereType, self._slotNo)
        end
        if nil == itemWrapper then
          return
        end
        local itemSSW = itemWrapper:getStaticStatus()
        if nil == itemSSW then
          return
        end
        local availableMaidCount = ToClient_getUsableMaidCountByType(false)
        if 0 == availableMaidCount then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantFindUseableMaid"))
          return
        end
        local weight = Int64toInt32(itemSSW:get()._weight) / 10000
        local dividedByWeight = 0
        if weight > 0 then
          dividedByWeight = math.floor(100 / weight)
        end
        if false == _ContentsGroup_UseMultiMaid then
          if false == itemSSW:isMoney() then
            self._s64_count = toInt64(0, math.min(dividedByWeight, Int64toInt32(self._s64_count)))
          end
          if self._s64_count <= Defines.s64_const.s64_0 then
            Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMaidDeliveryCantHeavyItem"))
            return
          end
          PaGlobal_Warehouse_All_PushFromInventoryItem(self._s64_count, self._whereType, self._slotNo, fromActorKeyRaw)
        else
          if false == itemSSW:isMoney() then
            local maxMoveCountPerOnce = dividedByWeight
            if nil ~= PaGlobal_Warehouse_All_IsUseMultiMaidOpen and true == PaGlobal_Warehouse_All_IsUseMultiMaidOpen() then
              local reqTotalMoveCount = availableMaidCount * maxMoveCountPerOnce
              self._s64_count = toInt64(0, math.min(reqTotalMoveCount, Int64toInt32(self._s64_count)))
            else
              self._s64_count = toInt64(0, math.min(maxMoveCountPerOnce, Int64toInt32(self._s64_count)))
            end
          end
          if self._s64_count <= Defines.s64_const.s64_0 then
            Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMaidDeliveryCantHeavyItem"))
            return
          end
          PaGlobal_Warehouse_All_PushFromInventoryItem(self._s64_count, self._whereType, self._slotNo, fromActorKeyRaw)
        end
      else
        Warehouse_PushFromInventoryItem(self._s64_count, self._whereType, self._slotNo, fromActorKeyRaw)
      end
    end
  elseif CppEnums.MoveItemToType.Type_Warehouse == fromWhereType then
    if _ContentsGroup_NewUI_WareHouse_All then
      PaGlobal_Warehouse_All_PopToSomewhere(self._s64_count, self._slotNo, toActorKeyRaw)
    else
      Warehouse_PopToSomewhere(self._s64_count, self._slotNo, toActorKeyRaw)
    end
  elseif CppEnums.MoveItemToType.Type_ShipWarehouse == fromWhereType then
    PaGlobal_CargoLoading_PopToSomewhere(self._s64_count, self._slotNo)
  elseif CppEnums.MoveItemToType.Type_NewShip == fromWhereType then
    PaGlobal_ShipInfo_All_PopToSomewhere(self._s64_count, self._slotNo)
  elseif CppEnums.MoveItemToType.Type_FamilyInventory == fromWhereType then
    if true == _ContentsGroup_FamilyInventory then
      if Defines.s64_const.s64_1 == self._s64_count then
        PaGlobal_FamilyInvnetory_PopItemFromFamilyInventory(self._s64_count, self._slotNo)
      else
        Panel_NumberPad_Show(true, self._s64_count, self._slotNo, PaGlobal_FamilyInvnetory_PopItemFromFamilyInventory, false)
      end
    end
  else
    UI.ASSERT(false, "\236\149\132\236\157\180\237\133\156 \236\157\180\235\143\153 \237\131\128\236\158\133\236\157\180 \236\160\149\236\131\129\236\160\129\236\157\180\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!!!")
  end
  if __eTInventorySlotNoMoney == self._slotNo then
    isMoveItemMoney = true
  else
    isMoveItemMoney = false
  end
  PopupMoveItem_Close()
end
function PopupMoveItem_MoveInventoryItemFromActorToActor(toActorKeyRaw, s64_count, whereType, slotNo)
  local self = popupMoveItem
  self._toActorKeyRaw = toActorKeyRaw
  Panel_NumberPad_Show(true, s64_count, slotNo, PopupMoveItem_MoveInventoryItemFromActorToActorXXX, nil, whereType)
end
function PopupMoveItem_MoveInventoryItemFromActorToActorXXX(s64_count, slotNo, whereType)
  local self = popupMoveItem
  moveInventoryItemFromActorToActor(self._fromActorKeyRaw, self._toActorKeyRaw, whereType, slotNo, s64_count)
end
function getItemFromTypeAndSlot(type, actorKeyRaw, whereType, slotNo)
  local itemWrapper
  if CppEnums.MoveItemToType.Type_Player == type or CppEnums.MoveItemToType.Type_FamilyInventory == type then
    itemWrapper = getInventoryItemByType(whereType, slotNo)
    if nil == itemWrapper then
      return false
    end
  elseif CppEnums.MoveItemToType.Type_Vehicle == type or CppEnums.MoveItemToType.Type_Ship == type then
    itemWrapper = getServantInventoryItemBySlotNo(actorKeyRaw, slotNo)
  elseif CppEnums.MoveItemToType.Type_Warehouse == type then
    if _ContentsGroup_NewUI_WareHouse_All then
      itemWrapper = PaGlobal_Warehouse_All_GetItem(slotNo)
    else
      itemWrapper = Warehouse_GetItem(slotNo)
    end
  elseif CppEnums.MoveItemToType.Type_ShipWarehouse == type then
    itemWrapper = PaGlobal_CargoLoading_GetMoveItem(slotNo)
  elseif CppEnums.MoveItemToType.Type_NewShip == type then
    itemWrapper = PaGlobal_ShipInfo_All_GetMoveItem(slotNo)
  end
  return itemWrapper
end
function PopupMoveItem_IsButtonShow(slot, type)
  local self = popupMoveItem
  if CppEnums.MoveItemToType.Type_Vehicle == type or CppEnums.MoveItemToType.Type_Ship == type or CppEnums.MoveItemToType.Type_CampingTent == type or CppEnums.MoveItemToType.Type_Pet == type then
    if true == _ContentsGroup_UsePadSnapping then
      return false
    else
      if not PaGlobalFunc_ServantInventory_GetShow() and nil ~= Panel_Window_CampWarehouse_All and false == Panel_Window_CampWarehouse_All:GetShow() then
        return false
      end
      if self._fromWindowType == CppEnums.MoveItemToType.Type_NewShip and CppEnums.MoveItemToType.Type_Ship == type then
        return false
      end
      local inventory = ServantInventory_getInventoryFromType(type)
      if nil == inventory then
        return false
      end
      local actorKeyRaw = inventory._actorKeyRaw
      if nil == actorKeyRaw then
        return false
      end
      if getMoneySlotNo() == self._slotNo then
        return false
      end
      slot._toActorKeyRaw = actorKeyRaw
    end
  elseif CppEnums.MoveItemToType.Type_Player == type then
    local isInvenOpen = false
    if true == _ContentsGroup_NewUI_Inventory_All then
      isInvenOpen = Panel_Window_Inventory_All:GetShow()
    else
      isInvenOpen = Panel_Window_Inventory:GetShow()
    end
    if not isInvenOpen then
      return false
    end
    slot._toActorKeyRaw = getSelfPlayer():getActorKey()
  elseif CppEnums.MoveItemToType.Type_Warehouse == type then
    if _ContentsGroup_NewUI_WareHouse_All then
      if false == PaGlobal_Warehouse_All_IsMoveItem() then
        return false
      end
    elseif not FGlobal_Warehouse_IsMoveItem() then
      return false
    end
    if not Panel_Window_Warehouse:GetShow() then
      return false
    end
  elseif CppEnums.MoveItemToType.Type_ShipWarehouse == type then
    return false
  elseif CppEnums.MoveItemToType.Type_NewShip == type then
    return false
  elseif CppEnums.MoveItemToType.Type_FamilyInventory == type then
    return false
  end
  slot._toType = type
  return true
end
function Item_Move_Sound(itemWrapper)
  local itemSSW = itemWrapper:getStaticStatus()
  local itemType = itemSSW:getItemType()
  local isTradeItem = itemSSW:isTradeAble()
  if 1 == itemType then
  elseif 2 == itemType then
  elseif 3 == itemType then
  elseif 4 == itemType then
  elseif 5 == itemType then
  elseif 6 == itemType then
  elseif 8 == itemType then
  elseif 10 == itemType then
  else
    if isTradeItem == true then
    else
    end
  end
end
function PopupMoveItem_Open()
  if Panel_Popup_MoveItem:GetShow() then
    return
  end
  Panel_Popup_MoveItem:SetShow(true)
end
function PopupMoveItem_Close()
  if not Panel_Popup_MoveItem:GetShow() then
    return
  end
  Panel_Popup_MoveItem:SetShow(false)
end
function PaGlobalFunc_MoveMoneyCheck(isChange)
  if false == isChange then
    return isMoveItemMoney
  else
    isMoveItemMoney = not isMoveItemMoney
  end
end
popupMoveItem:init()
popupMoveItem:registEventHandler()
popupMoveItem:registMessageHandler()
