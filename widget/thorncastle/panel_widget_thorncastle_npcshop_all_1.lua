function PaGlobal_ThornCastle_NpcShop_All:initialize()
  if true == PaGlobal_ThornCastle_NpcShop_All._initialize then
    return
  end
  self._ui.stc_titleBG = UI.getChildControl(Panel_ThornCastle_Shop, "Static_Title_BG")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Close_PCUI")
  self._ui.list2_itemList = UI.getChildControl(Panel_ThornCastle_Shop, "List2_ItemList")
  self._ui.list2_content = UI.getChildControl(self._ui.list2_itemList, "List2_1_Content")
  self._ui.btn_radiocontent = UI.getChildControl(self._ui.list2_content, "RadioButton_1")
  self._ui.stc_itemSlot = UI.getChildControl(self._ui.btn_radiocontent, "Static_Item_Slot")
  self._ui.btn_radiocontent2 = UI.getChildControl(self._ui.list2_content, "RadioButton_2")
  self._ui.stc_itemSlot2 = UI.getChildControl(self._ui.btn_radiocontent2, "Static_Item_Slot")
  self._ui.stc_silver = UI.getChildControl(Panel_ThornCastle_Shop, "Static_Silver")
  self._ui.btn_Inven = UI.getChildControl(self._ui.stc_silver, "Radiobutton_Inven")
  self._ui.txt_unit = UI.getChildControl(self._ui.btn_Inven, "StaticText_1")
  self._ui.txt_point = UI.getChildControl(self._ui.btn_Inven, "StaticText_2")
  self._ui.btn_buy = UI.getChildControl(Panel_ThornCastle_Shop, "Button_Command_PCUI")
  self._ui.btn_buy_value = UI.getChildControl(Panel_ThornCastle_Shop, "Button_Command_ChangeAll")
  local itemImageLeftSlot = {}
  local itemImageRightSlot = {}
  SlotItem.new(itemImageLeftSlot, "Left_Item_Icon_", 0, self._ui.stc_itemSlot, self._slotConfig)
  SlotItem.new(itemImageRightSlot, "Right_Item_Icon_", 0, self._ui.stc_itemSlot2, self._slotConfig)
  itemImageLeftSlot:createChild()
  itemImageRightSlot:createChild()
  PaGlobal_ThornCastle_NpcShop_All:registEventHandler()
  PaGlobal_ThornCastle_NpcShop_All:validate()
  PaGlobal_ThornCastle_NpcShop_All._initialize = true
end
function PaGlobal_ThornCastle_NpcShop_All:registEventHandler()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ThornCastle_NpcShop_All_Close()")
  self._ui.list2_itemList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_ThornCastle_NpcShop_All_CreateListControl")
  self._ui.list2_itemList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_buy:addInputEvent("Mouse_LUp", "HandleEventLUp_ThornCastle_NpcShop_BuyButton()")
  self._ui.btn_buy_value:addInputEvent("Mouse_LUp", "HandleEventLUp_ThornCastle_NpcShop_BuyValueButton()")
  registerEvent("FromClient_ThornCastlePointUpdate", "PaGlobal_ThornCastle_NpcShop_All_ChangePoint")
  registerEvent("FromClient_OthilitaDungeon_NpcShop_Open", "PaGlobal_ThornCastle_NpcShop_All_Open")
end
function PaGlobal_ThornCastle_NpcShop_All:prepareOpen()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  self:update()
  PaGlobal_ThornCastle_NpcShop_All:open()
end
function PaGlobal_ThornCastle_NpcShop_All:open()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  Panel_ThornCastle_Shop:SetShow(true)
end
function PaGlobal_ThornCastle_NpcShop_All:prepareClose()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  Panel_NumberPad_Close()
  PaGlobal_ThornCastle_NpcShop_All:close()
end
function PaGlobal_ThornCastle_NpcShop_All:close()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  Panel_ThornCastle_Shop:SetShow(false)
end
function PaGlobal_ThornCastle_NpcShop_All:update()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  self:updateList()
  local point = ToClient_OthilitaDungeonMyPoint()
  self._ui.txt_point:SetText(tostring(point))
end
function PaGlobal_ThornCastle_NpcShop_All:updateList()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  self._selectIndex = nil
  self.showItemList = {}
  self._ui.list2_itemList:getElementManager():clearKey()
  local showItemIndex = 0
  local itemListSize = ToClient_GetOthilitaDungeonShopItemCount()
  for index = 0, itemListSize do
    local isShow = ToClient_IsShowOthilitaDungeonShotItemByTeamNo(index)
    if true == isShow then
      self.showItemList[showItemIndex] = index
      showItemIndex = showItemIndex + 1
    end
  end
  if showItemIndex > self._MAX_ITEMLIST_COUNT * 2 then
    self._MAX_ITEMLIST_COUNT = showItemIndex / 2 + 1
  end
  for index = 0, self._MAX_ITEMLIST_COUNT, 2 do
    self._ui.list2_itemList:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_ThornCastle_NpcShop_All:createItemList(control, key)
  local index = Int64toInt32(key)
  local itemIndex1 = self.showItemList[index]
  local button1 = UI.getChildControl(control, "RadioButton_1")
  local itemIndex2 = self.showItemList[index + 1]
  local button2 = UI.getChildControl(control, "RadioButton_2")
  button1:SetCheck(false)
  button2:SetCheck(false)
  local function SettingSlot(control, index)
    local itemSlot = UI.getChildControl(control, "Static_Item_Slot")
    local name = UI.getChildControl(control, "StaticText_Name")
    local desc = UI.getChildControl(control, "StaticText_Desc")
    local price = UI.getChildControl(control, "StaticText_Price")
    local priceUnit = UI.getChildControl(control, "StaticText_Point")
    local itemKey = ToClient_GetOthilitaDungeonShopItemKey(self.showItemList[index])
    local itemWrapper = getItemEnchantStaticStatus(itemKey)
    if nil ~= itemWrapper then
      name:SetText(itemWrapper:getName())
      desc:SetText(PAGetString(Defines.StringSheet_GAME, "NPCSHOP_SOLDOUT"))
      local getprice = ToClient_GetOthilitaDungeonShopItemPrice(self.showItemList[index])
      price:SetText(tostring(getprice))
      local slot = {}
      if 0 == index % 2 or 0 == index then
        SlotItem.reInclude(slot, "Left_Item_Icon_", 0, itemSlot, self._slotConfig)
      else
        SlotItem.reInclude(slot, "Right_Item_Icon_", 0, itemSlot, self._slotConfig)
      end
      slot:clearItem()
      itemSlot:SetIgnore(true)
      slot:setItemByStaticStatus(itemWrapper)
      control:addInputEvent("Mouse_LUp", "HandleEventLUp_ThornCastle_NpcShop_SelectItem(" .. index .. ")")
      control:addInputEvent("Mouse_RUp", "HandleEventRUp_ThornCastle_NpcShop_BuyItem(" .. index .. ")")
    else
      control:SetShow(false)
    end
  end
  if nil == itemIndex1 then
    button1:SetShow(false)
  else
    SettingSlot(button1, index)
  end
  if nil == itemIndex2 then
    button2:SetShow(false)
  else
    SettingSlot(button2, index + 1)
  end
end
function PaGlobal_ThornCastle_NpcShop_All:selectItem(index)
  if nil == Panel_ThornCastle_Shop then
    return
  end
  self._selectIndex = index
end
function PaGlobal_ThornCastle_NpcShop_All:buy()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  if nil == self._selectIndex then
    return
  end
  ToClient_OthilitaDungeonBuyItem(self.showItemList[self._selectIndex], toInt64(0, 1))
end
function PaGlobal_ThornCastle_NpcShop_All:buyNow(index)
  if nil == Panel_ThornCastle_Shop then
    return
  end
  ToClient_OthilitaDungeonBuyItem(self.showItemList[index], toInt64(0, 1))
end
function PaGlobal_ThornCastle_NpcShop_All:buyValueButton()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  if nil == self._selectIndex then
    return
  end
  local point = ToClient_OthilitaDungeonMyPoint()
  local getprice = ToClient_GetOthilitaDungeonShopItemPrice(self.showItemList[self._selectIndex])
  local MaxCount = point / getprice
  Panel_NumberPad_Show(true, toInt64(0, MaxCount), 0, PaGlobal_ThornCastle_NpcShop_All_BuyValue)
end
function PaGlobal_ThornCastle_NpcShop_All:buyValue(count)
  if nil == Panel_ThornCastle_Shop then
    return
  end
  if nil == self._selectIndex then
    return
  end
  if 0 == count then
    return
  end
  ToClient_OthilitaDungeonBuyItem(self.showItemList[self._selectIndex], count)
end
function PaGlobal_ThornCastle_NpcShop_All:validate()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  self._ui.stc_titleBG:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.list2_itemList:isValidate()
  self._ui.list2_content:isValidate()
  self._ui.btn_radiocontent:isValidate()
  self._ui.stc_itemSlot:isValidate()
  self._ui.btn_radiocontent2:isValidate()
  self._ui.stc_itemSlot2:isValidate()
  self._ui.stc_silver:isValidate()
  self._ui.btn_Inven:isValidate()
  self._ui.txt_unit:isValidate()
  self._ui.txt_point:isValidate()
  self._ui.btn_buy:isValidate()
end
