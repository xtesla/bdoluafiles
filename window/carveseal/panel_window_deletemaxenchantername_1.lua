function PaGlobal_DeleteMaxEnchanterName:initialize()
  if true == PaGlobal_DeleteMaxEnchanterName._initialize then
    return
  end
  self._ui.stc_TitleBg = UI.getChildControl(Panel_DeleteMaxEnchanterName, "Static_TitleBg")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleBg, "Button_Close")
  self._ui.list2_Item = UI.getChildControl(Panel_DeleteMaxEnchanterName, "List2_Item")
  self._ui.list2_content = UI.getChildControl(self._ui.list2_Item, "List2_1_Content")
  self._ui.btn_NameDelete = UI.getChildControl(Panel_DeleteMaxEnchanterName, "Button_NameDelete")
  self._ui.stc_SelectItemArea = UI.getChildControl(Panel_DeleteMaxEnchanterName, "Static_SelectItemArea")
  self._ui.stc_CarveSealImage = UI.getChildControl(self._ui.stc_SelectItemArea, "Static_CarveSealIMG")
  self._ui.stc_Slot = UI.getChildControl(self._ui.stc_CarveSealImage, "Static_Slot")
  self._ui.stc_RemoveItemArea = UI.getChildControl(self._ui.stc_SelectItemArea, "Static_RemoveItemArea")
  self._ui.stc_RemoveItemSlot = UI.getChildControl(self._ui.stc_RemoveItemArea, "Static_ItemSlot")
  self._ui.txt_RemoveItemName = UI.getChildControl(self._ui.stc_RemoveItemArea, "StaticText_ItemName")
  self._ui.txt_RemoveItemValue = UI.getChildControl(self._ui.stc_RemoveItemArea, "StaticText_3")
  self._ui.txt_Name = UI.getChildControl(self._ui.stc_SelectItemArea, "StaticText_1")
  local slot = {}
  local list2_itemslot = UI.getChildControl(self._ui.list2_content, "Static_ItemSlotBg")
  SlotItem.new(slot, "Item_Slot_Icon_", 0, list2_itemslot, self._slotConfig)
  slot:createChild()
  self._baseTexture = list2_itemslot:getBaseTexture()
  PaGlobal_DeleteMaxEnchanterName:registEventHandler()
  PaGlobal_DeleteMaxEnchanterName:validate()
  PaGlobal_DeleteMaxEnchanterName._initialize = true
end
function PaGlobal_DeleteMaxEnchanterName:registEventHandler()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  self._ui.list2_Item:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_DeleteMaxEnchanterName_CreateListControl")
  self._ui.list2_Item:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_DeleteMaxEnchanterName_Exit()")
  registerEvent("FromClient_DeleteEnchanterName", "FromClient_DeleteEnchanterName_Show")
  registerEvent("FromClient_FinishDeleteEnchanterName", "FromClient_FinishDeleteEnchanterName")
  Panel_DeleteMaxEnchanterName:RegisterUpdateFunc("PaGlobal_DeleteMaxEnchanterName_UpdateProcess")
end
function PaGlobal_DeleteMaxEnchanterName:prepareInitialize()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  self._ui.btn_NameDelete:SetMonoTone(false)
  self._ui.btn_NameDelete:SetIgnore(false)
  self._currentProcess = 0
  self._isProcessEffect = false
  self._selectIndex = 0
  self._fromInventorySlotNo = nil
  self._toInventoryType = nil
  self._toInventorySlotNo = nil
  self._ui.stc_Slot:setRenderTexture(self._baseTexture)
  self._ui.stc_Slot:SetIgnore(true)
  self._ui.txt_Name:SetText("")
  self._ui.txt_RemoveItemName:SetText(self._fromItemName)
  self._ui.stc_RemoveItemSlot:ChangeTextureInfoName("Icon/" .. self._fromItemIconPath)
  self._ui.stc_RemoveItemSlot:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_DeleteMaxEnchanterName_RemoveItemTooltipHide()")
  self._ui.stc_RemoveItemSlot:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer or nil == selfPlayer:get() then
    return
  end
  local invenSize = selfPlayer:get():getInventorySlotCount(self._fromInventoryType)
  local useStartSlot = inventorySlotNoUserStart()
  local slotIndex = 0
  local removeItemCount = 0
  for slotNo = useStartSlot, invenSize - 1 do
    local invenItemWrapper = getInventoryItemByType(self._fromInventoryType, slotNo)
    if nil ~= invenItemWrapper then
      local invenItemKey = invenItemWrapper:get():getKey():getItemKey()
      if invenItemKey == self._fromItemKey then
        self._fromInventorySlotNo = slotNo
        removeItemCount = removeItemCount + 1
      end
    end
  end
  if 0 == removeItemCount then
    self._ui.stc_RemoveItemSlot:SetMonoTone(true)
    self._ui.btn_NameDelete:addInputEvent("Mouse_LUp", "")
  else
    self._ui.stc_RemoveItemSlot:SetMonoTone(false)
    self._ui.btn_NameDelete:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_DeleteMaxEnchanterName_Button()")
  end
  self._ui.txt_RemoveItemValue:SetText(tostring(removeItemCount))
  self._ui.txt_Name:SetFontAlpha(1)
end
function PaGlobal_DeleteMaxEnchanterName:prepareOpen(fromWhereType, fromSlotNo)
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  self._fromInventoryType = fromWhereType
  self._fromInventorySlotNo = fromSlotNo
  local itemWrapper = getInventoryItemByType(self._fromInventoryType, self._fromInventorySlotNo)
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  self._fromItemName = itemSSW:getName()
  self._fromItemIconPath = itemSSW:getIconPath()
  self._fromItemKey = itemWrapper:get():getKey():getItemKey()
  self:prepareInitialize()
  self:update()
  PaGlobal_DeleteMaxEnchanterName:open()
end
function PaGlobal_DeleteMaxEnchanterName:open()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  Panel_DeleteMaxEnchanterName:SetShow(true)
end
function PaGlobal_DeleteMaxEnchanterName:prepareClose()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  self._ui.stc_CarveSealImage:EraseAllEffect()
  self._ui.txt_Name:EraseAllEffect()
  PaGlobal_DeleteMaxEnchanterName:close()
end
function PaGlobal_DeleteMaxEnchanterName:close()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  Panel_DeleteMaxEnchanterName:SetShow(false)
end
function PaGlobal_DeleteMaxEnchanterName:update()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  self:updateList()
end
function PaGlobal_DeleteMaxEnchanterName:updateList()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer or nil == selfPlayer:get() then
    return
  end
  local inventory = selfPlayer:get():getInventory(CppEnums.ItemWhereType.eInventory)
  if nil == inventory then
    return
  end
  self._ui.list2_Item:getElementManager():clearKey()
  local invenSize = selfPlayer:get():getInventorySlotCount(CppEnums.ItemWhereType.eInventory)
  local useStartSlot = inventorySlotNoUserStart()
  local slotIndex = 0
  for slotNo = useStartSlot, invenSize - 1 do
    local NameStr = getItemNaming(getTItemNoBySlotNo(slotNo), true)
    if nil ~= NameStr then
      slotIndex = slotIndex + 1
      self._viewSlotNo[slotIndex] = slotNo
      self._ui.list2_Item:getElementManager():pushKey(toInt64(0, slotIndex))
    end
  end
end
function PaGlobal_DeleteMaxEnchanterName:createList(control, key)
  local index = Int64toInt32(key)
  local listbutton = UI.getChildControl(control, "RadioButton_ItemList")
  local listSlot = UI.getChildControl(control, "Static_ItemSlotBg")
  local listName = UI.getChildControl(control, "StaticText_ItemName")
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, self._viewSlotNo[index])
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  listName:SetText(itemSSW:getName())
  listbutton:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_DeleteMaxEnchanterName_Select(" .. index .. ")")
  local slot = {}
  SlotItem.reInclude(slot, "Item_Slot_Icon_", 0, listSlot, self._slotConfig)
  slot:clearItem()
  slot.icon:SetIgnore(true)
  slot:setItem(itemWrapper)
  listbutton:SetCheck(self._selectIndex == index)
  listSlot:SetIgnore(false)
  listSlot:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_DeleteMaxEnchanterName_TooltipShow(" .. index .. ")")
  listSlot:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_DeleteMaxEnchanterName_TooltipHide()")
end
function PaGlobal_DeleteMaxEnchanterName:doDeleteName()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  if nil == self._toInventorySlotNo then
    return
  end
  if nil == self._toInventoryType then
    return
  end
  if nil == self._fromInventoryType then
    return
  end
  if nil == self._fromInventorySlotNo then
    return
  end
  local function DeletefunctionYes()
    self._currentProcess = 0
    self._isProcessEffect = true
    self._ui.btn_NameDelete:SetMonoTone(true)
    self._ui.btn_NameDelete:SetIgnore(true)
    self._ui.stc_CarveSealImage:AddEffect("fUI_LosePerfume_01A", false, 0, 0)
    self._ui.txt_Name:AddEffect("fUI_LosePerfume_Name_01A", false, 0, 0)
  end
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_MAXENCHANT_DELETENAME_MESSAGE_DESC")
  local messageBoxData = {
    title = msgTitle,
    content = msgContent,
    functionYes = DeletefunctionYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_DeleteMaxEnchanterName:selectItem(index)
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  if self._viewSlotNo[index] == nil then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, self._viewSlotNo[index])
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  self._toInventoryType = CppEnums.ItemWhereType.eInventory
  self._toInventorySlotNo = self._viewSlotNo[index]
  self._selectIndex = index
  self._ui.stc_Slot:ChangeTextureInfoName("Icon/" .. itemSSW:getIconPath())
  self._ui.stc_Slot:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_DeleteMaxEnchanterName_TooltipShow(" .. index .. ")")
  self._ui.stc_Slot:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_DeleteMaxEnchanterName_TooltipHide()")
  self._ui.stc_Slot:SetIgnore(false)
  local playerName = getItemNaming(getTItemNoBySlotNo(self._toInventorySlotNo), true)
  self._ui.txt_Name:SetText(playerName)
end
function PaGlobal_DeleteMaxEnchanterName:effect(deltaTime)
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  if true == self._isProcessEffect then
    self._currentProcess = self._currentProcess + deltaTime
    if self._effectTime < self._currentProcess then
      self._ui.txt_Name:SetFontAlpha(0)
      self._isProcessEffect = false
      self._currentProcess = 0
      ToClient_DeleteNamingItem(self._fromInventoryType, self._fromInventorySlotNo, self._toInventoryType, self._toInventorySlotNo)
    else
      self._ui.txt_Name:SetFontAlpha((self._effectTime - self._currentProcess) / self._effectTime)
    end
  end
end
function PaGlobal_DeleteMaxEnchanterName:validate()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  self._ui.stc_TitleBg:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.list2_Item:isValidate()
  self._ui.list2_content:isValidate()
  self._ui.btn_NameDelete:isValidate()
  self._ui.stc_SelectItemArea:isValidate()
  self._ui.stc_CarveSealImage:isValidate()
  self._ui.stc_Slot:isValidate()
  self._ui.stc_RemoveItemArea:isValidate()
  self._ui.stc_RemoveItemSlot:isValidate()
  self._ui.txt_RemoveItemName:isValidate()
  self._ui.txt_RemoveItemValue:isValidate()
  self._ui.txt_Name:isValidate()
end
