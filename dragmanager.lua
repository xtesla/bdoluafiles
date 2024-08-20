DragManager = {
  dragStartPanel = nil,
  dragSlotInfo = nil,
  groundClickFunc = nil
}
local dragPanel = UI.createPanelAndSetPanelRenderMode("DragIconPanel", Defines.UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
  Defines.RenderMode.eRenderMode_Default,
  Defines.RenderMode.eRenderMode_SkillWindow,
  Defines.RenderMode.eRenderMode_Dialog
}))
dragPanel:SetSize(40, 40)
dragPanel:SetPosX(100)
dragPanel:SetPosY(100)
dragPanel:SetIgnore(true)
dragPanel:SetShow(false, false)
function DragPanel_PosUpdate()
  dragPanel:SetPosX(getMousePosX())
  dragPanel:SetPosY(getMousePosY())
end
dragPanel:RegisterUpdateFunc("DragPanel_PosUpdate")
function DragManager:setDragImageSize(x, y)
  dragPanel:SetSize(x, y)
end
function DragManager:getDragImageSize()
  return dragPanel:GetSizeX(), dragPanel:GetSizeY()
end
function DragManager:setDragInfo(panel, whereType, slot, IconPath, groundHitCallbackFunction, fromActorKeyRaw)
  if false == _ContentsGroup_RenewUI_Skill then
    if (panel == Panel_QuickSlot or panel == Panel_Window_Skill) and not isUseNewQuickSlot() then
      QuickSlot_ShowBackGround()
    end
  elseif panel == Panel_QuickSlot and not isUseNewQuickSlot() then
    QuickSlot_ShowBackGround()
  end
  self.dragStartPanel = panel
  self.dragWhereTypeInfo = whereType
  self.dragSlotInfo = slot
  self.groundClickFunc = groundHitCallbackFunction
  self.fromActorKeyRaw = fromActorKeyRaw
  dragPanel:ChangeTextureInfoName(IconPath)
  dragPanel:SetShow(true, false)
  dragPanel:OnDragItemPanelForUISubApp()
  DragPanel_PosUpdate()
end
function DragManager:isDragging()
  return self.groundClickFunc ~= nil or self.dragSlotInfo ~= nil
end
function DragManager:clearInfo()
  if dragPanel:IsShow() then
    dragPanel:SetShow(false, false)
    dragPanel:ClearDragItemPanelForUISubApp()
    self.dragStartPanel = nil
    self.dragWhereTypeInfo = nil
    self.dragSlotInfo = nil
    self.groundClickFunc = nil
    self.fromActorKeyRaw = nil
    QuickSlot_HideBackGround()
  end
end
function dragManagerGroundMouseClick()
  if DragManager.groundClickFunc ~= nil then
    DragManager.groundClickFunc(DragManager.dragWhereTypeInfo, DragManager.dragSlotInfo)
    if DragManager.dragStartPanel == Panel_QuickSlot then
      DragManager:clearInfo()
    end
    if DragManager.dragStartPanel == Panel_Window_SkillGroup_QuickSlot then
      DragManager:clearInfo()
    end
    return true
  end
  return false
end
local GroundMouseEmpty = function()
end
function DragManager:cancelInfo()
  dragPanel:SetShow(false, false)
  self.dragStartPanel = nil
  self.dragWhereTypeInfo = nil
  self.dragSlotInfo = nil
  self.groundClickFunc = GroundMouseEmpty
  self.fromActorKeyRaw = nil
end
function DragManager:getFromMoveType()
  local fromMoveType
  if Panel_Window_Inventory == self.dragStartPanel then
    fromMoveType = CppEnums.MoveItemToType.Type_Player
  elseif Panel_Window_Inventory_All == self.dragStartPanel then
    fromMoveType = CppEnums.MoveItemToType.Type_Player
  elseif Panel_Window_ServantInventory == DragManager.dragStartPanel then
    fromMoveType = CppEnums.MoveItemToType.Type_Vehicle
  elseif Panel_Window_Warehouse == self.dragStartPanel then
    fromMoveType = CppEnums.MoveItemToType.Type_Warehouse
  elseif Panel_Window_FamilyInventory_All == self.dragStartPanel then
    fromMoveType = CppEnums.MoveItemToType.Type_FamilyInventory
  end
  return fromMoveType
end
function DragManager:itemDragMove(toType, toActorKey)
  local fromWhereType = self.dragWhereTypeInfo
  local fromSlotNo = self.dragSlotInfo
  local fromMoveType = self:getFromMoveType()
  if nil == fromMoveType then
    return false
  end
  if CppEnums.MoveItemToType.Type_Player ~= fromMoveType and CppEnums.MoveItemToType.Type_FamilyInventory ~= fromMoveType and self.fromActorKeyRaw == toActorKey then
    return
  end
  local itemWrapper
  if CppEnums.MoveItemToType.Type_Player == fromMoveType or CppEnums.MoveItemToType.Type_FamilyInventory == fromMoveType then
    itemWrapper = getInventoryItemByType(fromWhereType, fromSlotNo)
  elseif CppEnums.MoveItemToType.Type_Vehicle == fromMoveType then
    itemWrapper = getServantInventoryItemBySlotNo(self.fromActorKeyRaw, fromSlotNo)
  elseif CppEnums.MoveItemToType.Type_Warehouse == fromMoveType then
    itemWrapper = PaGlobal_WareHouse_All:getWarehouse():getItem(fromSlotNo)
  end
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    audioPostEvent_SystemItem(itemStatic._itemMaterial)
  end
  FGlobal_PopupMoveItem_Init(fromWhereType, fromSlotNo, fromMoveType, self.fromActorKeyRaw, false)
  HandleClickedMoveItemButtonXXX(toType, toActorKey)
  self:clearInfo()
  return true
end
registerEvent("FromClient_GroundMouseClick", "dragManagerGroundMouseClick")
