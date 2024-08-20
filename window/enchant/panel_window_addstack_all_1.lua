function PaGlobal_AddStack_All:initialize()
  if true == PaGlobal_AddStack_All._initialize then
    return
  end
  PaGlobal_AddStack_All._ui._stc_TitleBar = UI.getChildControl(Panel_Window_AddStack_All, "Static_TitleBar")
  PaGlobal_AddStack_All._ui._stc_CloseIcon = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_TitleBar, "Static_CloseIcon")
  PaGlobal_AddStack_All._ui._stc_mainBG = UI.getChildControl(Panel_Window_AddStack_All, "Static_MainBG_Stack_Normal")
  PaGlobal_AddStack_All._ui._stc_ItemList = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_mainBG, "Static_ItemList")
  PaGlobal_AddStack_All._ui._btn_StoneWeapon = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ItemList, "RadioButton_Stone_Weapon")
  PaGlobal_AddStack_All._ui._stc_StoneWeaponName = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_StoneWeapon, "StaticText_EquipName")
  PaGlobal_AddStack_All._ui._stc_StoneWeaponCount = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_StoneWeapon, "StaticText_EquipSlotText")
  PaGlobal_AddStack_All._ui._stc_StoneWeaponSelect = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_StoneWeapon, "Button_Select")
  PaGlobal_AddStack_All._ui._stc_StoneWeaponIconBg = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_StoneWeapon, "Static_EquipListSlotBg")
  PaGlobal_AddStack_All._ui._stc_StoneWeaponIcon = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_StoneWeaponIconBg, "Static_EquipListSlot")
  PaGlobal_AddStack_All._ui._btn_StoneArmo = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ItemList, "RadioButton_Stone_Armor")
  PaGlobal_AddStack_All._ui._stc_StoneArmoName = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_StoneArmo, "StaticText_EquipName")
  PaGlobal_AddStack_All._ui._stc_StoneArmoCount = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_StoneArmo, "StaticText_EquipSlotText")
  PaGlobal_AddStack_All._ui._stc_StoneArmoSelect = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_StoneArmo, "Button_Select")
  PaGlobal_AddStack_All._ui._stc_StoneArmoIconBg = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_StoneArmo, "Static_EquipListSlotBg")
  PaGlobal_AddStack_All._ui._stc_StoneArmoIcon = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_StoneArmoIconBg, "Static_EquipListSlot")
  PaGlobal_AddStack_All._ui._btn_ValksScroll = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ItemList, "RadioButton_Stone_Scroll")
  PaGlobal_AddStack_All._ui._stc_ValksScrollSName = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_ValksScroll, "StaticText_EquipName")
  PaGlobal_AddStack_All._ui._stc_ValksScrollCount = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_ValksScroll, "StaticText_EquipSlotText")
  PaGlobal_AddStack_All._ui._stc_ValksScrollSelect = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_ValksScroll, "Button_Select")
  PaGlobal_AddStack_All._ui._stc_ValksScrollIconBg = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_ValksScroll, "Static_EquipListSlotBg")
  PaGlobal_AddStack_All._ui._stc_ValksScrollIcon = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ValksScrollIconBg, "Static_EquipListSlot")
  PaGlobal_AddStack_All._ui._stc_ItemListConsume = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_mainBG, "Static_ItemList_Consume")
  PaGlobal_AddStack_All._ui._btn_Consume = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ItemListConsume, "RadioButton_Stone_Weapon")
  PaGlobal_AddStack_All._ui._stc_ConsumeItemName = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_Consume, "StaticText_EquipName")
  PaGlobal_AddStack_All._ui._stc_ConsumeItemCount = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_Consume, "StaticText_EquipSlotText")
  PaGlobal_AddStack_All._ui._stc_ConsumeSelect = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_Consume, "Button_Select")
  PaGlobal_AddStack_All._ui._stc_ConsumeIconBg = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_Consume, "Static_EquipListSlotBg")
  PaGlobal_AddStack_All._ui._stc_ConsumeIcon = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ConsumeIconBg, "Static_EquipListSlot")
  PaGlobal_AddStack_All._ui._stc_mainValksBG = UI.getChildControl(Panel_Window_AddStack_All, "Static_MainBG_Stack_Valks")
  PaGlobal_AddStack_All._ui._stc_ItemListValks = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_mainValksBG, "Static_ItemList")
  PaGlobal_AddStack_All._ui._btn_ValksNormal = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ItemListValks, "RadioButton_Valks_Normal")
  PaGlobal_AddStack_All._ui._stc_ValksName = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_ValksNormal, "StaticText_EquipName")
  PaGlobal_AddStack_All._ui._stc_ValksCount = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_ValksNormal, "StaticText_EquipSlotText")
  PaGlobal_AddStack_All._ui._stc_Valksselect = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_ValksNormal, "Button_Select")
  PaGlobal_AddStack_All._ui._stc_ValksIconBg = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_ValksNormal, "Static_EquipListSlotBg")
  PaGlobal_AddStack_All._ui._stc_ValksIcon = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ValksIconBg, "Static_EquipListSlot")
  PaGlobal_AddStack_All._ui._btn_ValksEvent = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ItemListValks, "RadioButton_Valks_Event")
  PaGlobal_AddStack_All._ui._stc_ValksEventName = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_ValksEvent, "StaticText_EquipName")
  PaGlobal_AddStack_All._ui._stc_ValksEventCount = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_ValksEvent, "StaticText_EquipSlotText")
  PaGlobal_AddStack_All._ui._stc_ValksEventSelect = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_ValksEvent, "Button_Select")
  PaGlobal_AddStack_All._ui._stc_ValksEventIconBg = UI.getChildControl(PaGlobal_AddStack_All._ui._btn_ValksEvent, "Static_EquipListSlotBg")
  PaGlobal_AddStack_All._ui._stc_ValksEventIcon = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ValksEventIconBg, "Static_EquipListSlot")
  PaGlobal_AddStack_All._ui._stc_valueBG = UI.getChildControl(Panel_Window_AddStack_All, "Static_AddValue")
  PaGlobal_AddStack_All._ui._stc_valueDesc = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_valueBG, "StaticText_Desc")
  PaGlobal_AddStack_All._ui._stc_stackValue = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_valueBG, "StaticText_Stack_Value")
  PaGlobal_AddStack_All._ui._stc_stackRate = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_valueBG, "StaticText_Stack_Rate")
  PaGlobal_AddStack_All._ui._stc_consumeRateBG = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_valueBG, "Static_Rate_Consume")
  PaGlobal_AddStack_All._ui._stc_consumeRate = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_consumeRateBG, "StaticText_Rate")
  PaGlobal_AddStack_All._ui._stc_ApplyBG = UI.getChildControl(Panel_Window_AddStack_All, "Static_Button")
  PaGlobal_AddStack_All._ui._btn_Apply = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ApplyBG, "Button_EnchantButton")
  PaGlobal_AddStack_All._ui._stc_ApplyConsole = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ApplyBG, "StaticText_EnchantButton_C")
  PaGlobal_AddStack_All._ui._stc_keyGuideBG = UI.getChildControl(Panel_Window_AddStack_All, "Static_ConsoleKeyGuide")
  PaGlobal_AddStack_All._ui._stc_keyGuideA = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_keyGuideBG, "StaticText_SelectButton_C")
  PaGlobal_AddStack_All._ui._stc_keyGuideB = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_keyGuideBG, "StaticText_CancelButton_C")
  PaGlobal_AddStack_All._ui._stc_keyGuideX = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_keyGuideBG, "StaticText_DetailButton_C")
  PaGlobal_AddStack_All._ui._keyGuideList = {
    PaGlobal_AddStack_All._ui._stc_keyGuideX,
    PaGlobal_AddStack_All._ui._stc_keyGuideA,
    PaGlobal_AddStack_All._ui._stc_keyGuideB
  }
  PaGlobal_AddStack_All._ui._stc_subSelectBG = UI.getChildControl(Panel_Window_AddStack_All, "Static_Sub_SelectStack")
  PaGlobal_AddStack_All._ui._stc_titleBG = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_subSelectBG, "Static_Sub_TitleBar")
  PaGlobal_AddStack_All._ui._stc_title = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_titleBG, "StaticText_1")
  PaGlobal_AddStack_All._ui._btn_selectListClose = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_titleBG, "Button_Close")
  PaGlobal_AddStack_All._ui._list2_selectList = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_subSelectBG, "List2_2")
  local listContetns = UI.getChildControl(PaGlobal_AddStack_All._ui._list2_selectList, "List2_2_Content")
  local itemButtonControl = UI.getChildControl(listContetns, "RadioButton_1")
  local itemSlotControl = UI.getChildControl(itemButtonControl, "Static_EquipListSlotBg")
  local slot = {}
  SlotItem.new(slot, "SelectListSlotIcon_" .. 0, 0, itemSlotControl, PaGlobal_AddStack_All._INVENTORY_SLOT_CONFIG)
  slot:createChild()
  slot.empty = true
  slot:clearItem()
  slot.border:SetSize(itemSlotControl:GetSizeX(), itemSlotControl:GetSizeY())
  self:clearControlText()
  self._ui._stc_mainValksBG:SetShow(false)
  self._ui._stc_subSelectBG:SetShow(false)
  self._ui._stc_ItemListConsume:SetShow(_ContentsGroup_EatStackEnchant)
  self._itemTypeControlList = {
    [self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON] = PaGlobal_AddStack_All._ui._btn_StoneWeapon,
    [self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO] = PaGlobal_AddStack_All._ui._btn_StoneArmo,
    [self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL] = PaGlobal_AddStack_All._ui._btn_ValksScroll,
    [self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME] = PaGlobal_AddStack_All._ui._btn_Consume
  }
  self._OriginPanelSizeY = Panel_Window_AddStack_All:GetSizeY()
  PaGlobal_AddStack_All:makeToolTipDummyIcon()
  PaGlobal_AddStack_All:registEventHandler()
  PaGlobal_AddStack_All:validate()
  if true == _ContentsGroup_UsePadSnapping then
    for key, control in pairs(self._itemTypeControlList) do
      if nil ~= key and nil ~= control then
        local text = UI.getChildControl(control, "StaticText_EquipSlotText")
        local button = UI.getChildControl(control, "Button_Select")
        button:SetShow(false)
        local originalSpanSize = text:GetSpanSize()
        text:SetSize(text:GetSizeX() + button:GetSizeX(), text:GetSizeY())
        text:SetSpanSize(originalSpanSize.x - button:GetSizeX(), originalSpanSize.y)
      end
    end
    local originalSpanSize = self._ui._stc_ValksCount:GetSpanSize()
    local buttonSize = self._ui._stc_Valksselect:GetSizeX()
    self._ui._stc_Valksselect:SetShow(false)
    self._ui._stc_ValksEventSelect:SetShow(false)
    self._ui._stc_ValksCount:SetSize(self._ui._stc_ValksCount:GetSizeX() + buttonSize, self._ui._stc_ValksCount:GetSizeY())
    self._ui._stc_ValksEventCount:SetSize(self._ui._stc_ValksEventCount:GetSizeX() + buttonSize, self._ui._stc_ValksEventCount:GetSizeY())
    self._ui._stc_ValksCount:SetSpanSize(originalSpanSize.x - buttonSize, originalSpanSize.y)
    self._ui._stc_ValksEventCount:SetSpanSize(originalSpanSize.x - buttonSize, originalSpanSize.y)
  end
  self._ui._stc_valueDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_valueDesc:SetText(self._ui._stc_valueDesc:GetText())
  self._ui._stc_StoneWeaponName:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_StoneWeaponName:SetText(self._ui._stc_StoneWeaponName:GetText())
  self._ui._stc_StoneArmoName:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_StoneArmoName:SetText(self._ui._stc_StoneArmoName:GetText())
  self._ui._stc_ValksScrollSName:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_ValksScrollSName:SetText(self._ui._stc_ValksScrollSName:GetText())
  self._ui._stc_ConsumeItemName:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_ConsumeItemName:SetText(self._ui._stc_ConsumeItemName:GetText())
  self._ui._stc_ValksName:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_ValksName:SetText(self._ui._stc_ValksName:GetText())
  self._ui._stc_ValksEventName:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_ValksEventName:SetText(self._ui._stc_ValksEventName:GetText())
  self._ui._stc_StoneWeaponCount:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_StoneWeaponCount:SetText(self._ui._stc_valueDesc:GetText())
  self._ui._stc_StoneArmoCount:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_StoneArmoCount:SetText(self._ui._stc_valueDesc:GetText())
  self._ui._stc_ValksScrollCount:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_ValksScrollCount:SetText(self._ui._stc_valueDesc:GetText())
  self._ui._stc_ConsumeItemCount:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_ConsumeItemCount:SetText(self._ui._stc_valueDesc:GetText())
  self._ui._stc_ValksCount:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_ValksCount:SetText(self._ui._stc_valueDesc:GetText())
  self._ui._stc_ValksEventCount:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_ValksEventCount:SetText(self._ui._stc_valueDesc:GetText())
  PaGlobal_AddStack_All._initialize = true
end
function PaGlobal_AddStack_All:makeToolTipDummyIcon()
  if nil == Panel_Window_AddStack_All then
    return
  end
  self._ui._stc_ValksIconDummy = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ItemListValks, "Static_ValksIconDummy")
  self._ui._stc_ValksEventIconDummy = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ItemListValks, "Static_ValksEventIconDummy")
  self._ui._stc_StoneWeaponIconDummy = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ItemList, "Static_StoneWeaponIconDummy")
  self._ui._stc_StoneArmoIconDummy = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ItemList, "Static_StoneArmoIconDummy")
  self._ui._stc_ValksScrollIconDummy = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ItemList, "Static_ValksScrollIconDummy")
  self._ui._stc_ConsumeIconDummy = UI.getChildControl(PaGlobal_AddStack_All._ui._stc_ItemListConsume, "Static_ConsumeIconDummy")
  self._ui._stc_ValksIconDummy:SetMonoTone(true)
  self._ui._stc_ValksEventIconDummy:SetMonoTone(true)
  self._ui._stc_StoneWeaponIconDummy:SetMonoTone(true)
  self._ui._stc_StoneArmoIconDummy:SetMonoTone(true)
  self._ui._stc_ValksScrollIconDummy:SetMonoTone(true)
  self._ui._stc_ConsumeIconDummy:SetMonoTone(true)
  self._ui._stc_ValksIconDummy:SetShow(false)
  self._ui._stc_ValksEventIconDummy:SetShow(false)
  self._ui._stc_StoneWeaponIconDummy:SetShow(false)
  self._ui._stc_StoneArmoIconDummy:SetShow(false)
  self._ui._stc_ValksScrollIconDummy:SetShow(false)
  self._ui._stc_ConsumeIconDummy:SetShow(false)
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._stc_ValksIconDummy:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS) .. ",true)")
    self._ui._stc_ValksEventIconDummy:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT) .. ",true)")
    self._ui._stc_StoneWeaponIconDummy:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON) .. ",true)")
    self._ui._stc_StoneArmoIconDummy:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO) .. ",true)")
    self._ui._stc_ValksScrollIconDummy:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL) .. ",true)")
    self._ui._stc_ConsumeIconDummy:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME) .. ",true)")
  else
    self._ui._stc_ValksIconDummy:addInputEvent("Mouse_On", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS) .. ",true)")
    self._ui._stc_ValksEventIconDummy:addInputEvent("Mouse_On", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT) .. ",true)")
    self._ui._stc_StoneWeaponIconDummy:addInputEvent("Mouse_On", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON) .. ",true)")
    self._ui._stc_StoneArmoIconDummy:addInputEvent("Mouse_On", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO) .. ",true)")
    self._ui._stc_ValksScrollIconDummy:addInputEvent("Mouse_On", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL) .. ",true)")
    self._ui._stc_ConsumeIconDummy:addInputEvent("Mouse_On", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME) .. ",true)")
  end
  self._ui._stc_ValksIconDummy:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS) .. ",false)")
  self._ui._stc_ValksEventIconDummy:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT) .. ",false)")
  self._ui._stc_StoneWeaponIconDummy:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON) .. ",false)")
  self._ui._stc_StoneArmoIconDummy:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO) .. ",false)")
  self._ui._stc_ValksScrollIconDummy:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL) .. ",false)")
  self._ui._stc_ConsumeIconDummy:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME) .. ",false)")
  self._ui._stc_StoneWeaponIconDummy:addInputEvent("Mouse_LUp", " HandleEventLUp_AddStack_All_CheckAndShowFailCountMessageBox()")
  self._ui._stc_StoneArmoIconDummy:addInputEvent("Mouse_LUp", " HandleEventLUp_AddStack_All_CheckAndShowFailCountMessageBox()")
  self._ui._stc_ValksScrollIconDummy:addInputEvent("Mouse_LUp", " HandleEventLUp_AddStack_All_CheckAndShowFailCountMessageBox()")
end
function PaGlobal_AddStack_All:registEventHandler()
  if nil == Panel_Window_AddStack_All then
    return
  end
  self._ui._list2_selectList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_AddStack_All_UpdateSelectList")
  self._ui._list2_selectList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._stc_CloseIcon:addInputEvent("Mouse_LUp", " PaGloabl_AddStack_All_close()")
  self._ui._btn_selectListClose:addInputEvent("Mouse_LUp", " PaGloabl_AddStack_All_CloseSelectList()")
  self._ui._btn_Apply:addInputEvent("Mouse_LUp", "PaGlobal_AddStack_All_ApplyStack()")
  self._ui._btn_ValksNormal:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS) .. ")")
  self._ui._btn_ValksEvent:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT) .. ")")
  self._ui._btn_StoneWeapon:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON) .. ")")
  self._ui._btn_StoneArmo:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO) .. ")")
  self._ui._btn_ValksScroll:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL) .. ")")
  self._ui._btn_Consume:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME) .. ")")
  self._ui._stc_StoneWeaponSelect:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON) .. ")")
  self._ui._stc_StoneArmoSelect:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO) .. ")")
  self._ui._stc_ValksScrollSelect:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL) .. ")")
  self._ui._stc_ConsumeSelect:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME) .. ")")
  self._ui._stc_Valksselect:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS) .. ")")
  self._ui._stc_ValksEventSelect:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT) .. ")")
  self._ui._stc_ItemList:addInputEvent("Mouse_LUp", " HandleEventLUp_AddStack_All_CheckAndShowFailCountMessageBox()")
  self._ui._stc_mainValksBG:addInputEvent("Mouse_LUp", " PaGlobal_AddStack_All_ShowNoUseValksNakMessage()")
  self._ui._stc_ValksIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS) .. ")")
  self._ui._stc_ValksEventIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT) .. ")")
  self._ui._stc_StoneWeaponIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON) .. ")")
  self._ui._stc_StoneArmoIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO) .. ")")
  self._ui._stc_ValksScrollIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL) .. ")")
  self._ui._stc_ConsumeIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_ClickedItem(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME) .. ")")
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Window_AddStack_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_AddStack_All_ApplyStack()")
    self._ui._btn_ValksNormal:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS) .. ",true)")
    self._ui._btn_ValksEvent:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT) .. ",true)")
    self._ui._btn_StoneWeapon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON) .. ",true)")
    self._ui._btn_StoneArmo:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO) .. ",true)")
    self._ui._btn_ValksScroll:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL) .. ",true)")
    self._ui._btn_Consume:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME) .. ",true)")
    self._ui._btn_ValksNormal:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS) .. ",false)")
    self._ui._btn_ValksEvent:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT) .. ",false)")
    self._ui._btn_StoneWeapon:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON) .. ",false)")
    self._ui._btn_StoneArmo:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO) .. ",false)")
    self._ui._btn_ValksScroll:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL) .. ",false)")
    self._ui._btn_Consume:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME) .. ",false)")
    self._ui._stc_CloseIcon:SetShow(false)
    self._ui._btn_selectListClose:SetShow(false)
  else
    self._ui._stc_ValksIcon:addInputEvent("Mouse_On", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS) .. ",true)")
    self._ui._stc_ValksEventIcon:addInputEvent("Mouse_On", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT) .. ",true)")
    self._ui._stc_StoneWeaponIcon:addInputEvent("Mouse_On", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON) .. ",true)")
    self._ui._stc_StoneArmoIcon:addInputEvent("Mouse_On", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO) .. ",true)")
    self._ui._stc_ValksScrollIcon:addInputEvent("Mouse_On", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL) .. ",true)")
    self._ui._stc_ConsumeIcon:addInputEvent("Mouse_On", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME) .. ",true)")
    self._ui._stc_ValksIcon:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS) .. ",false)")
    self._ui._stc_ValksEventIcon:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT) .. ",false)")
    self._ui._stc_StoneWeaponIcon:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON) .. ",false)")
    self._ui._stc_StoneArmoIcon:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO) .. ",false)")
    self._ui._stc_ValksScrollIcon:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL) .. ",false)")
    self._ui._stc_ConsumeIcon:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowItemDetail(" .. tostring(self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME) .. ",false)")
  end
end
function PaGlobal_AddStack_All:prepareOpen(bgType)
  if nil == Panel_Window_AddStack_All then
    return
  end
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if false == _ContentsGroup_EnchantRenewer then
    return
  end
  self:setApplyButton()
  self:clearCurrentSelectItem()
  if true == Panel_Window_AddStack_All:GetShow() then
    self:prepareClose()
  end
  if bgType == PaGlobal_AddStack_All._BG_TYPE._BG_VALKS then
    if self:getValksUsableCount() <= 0 and nil ~= PaGlobal_AddStack_All_ShowNoUseValksNakMessage then
      PaGlobal_AddStack_All_ShowNoUseValksNakMessage()
      return
    end
    PaGlobal_AddStack_All._ui._stc_mainValksBG:SetShow(true)
    PaGlobal_AddStack_All._ui._stc_mainBG:SetShow(false)
  else
    PaGlobal_AddStack_All._ui._stc_mainValksBG:SetShow(false)
    PaGlobal_AddStack_All._ui._stc_mainBG:SetShow(true)
  end
  PaGlobal_AddStack_All:update()
  PaGlobal_AddStack_All:resizePanel(bgType)
  PaGlobal_AddStack_All:SetPanelPosOnEnchantPanel()
  PaGlobal_AddStack_All:switchConsoleUI()
  PaGlobal_AddStack_All:open()
end
function PaGlobal_AddStack_All:switchConsoleUI()
  if nil == Panel_Window_AddStack_All then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  self._ui._btn_Apply:SetShow(not _ContentsGroup_UsePadSnapping)
  self._ui._stc_ApplyConsole:SetShow(_ContentsGroup_UsePadSnapping)
  self:setKeyGuideAlign()
end
function PaGlobal_AddStack_All:setKeyGuideAlign()
  if nil == Panel_Window_AddStack_All then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._ui._keyGuideList, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_AddStack_All:SetPanelPosOnEnchantPanel()
  if nil == Panel_Window_AddStack_All then
    return
  end
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  local posXPadding = 15
  local posX = Panel_Window_StackExtraction_All:GetPosX() + Panel_Window_StackExtraction_All:GetSizeX() + posXPadding
  local posY = Panel_Window_StackExtraction_All:GetPosY()
  local panelEndPosX = posX + Panel_Window_AddStack_All:GetSizeX() + (PaGlobal_AddStack_All._ui._stc_subSelectBG:GetSizeX() - posXPadding)
  if panelEndPosX > getScreenSizeX() then
    posX = math.max(posXPadding, Panel_Window_StackExtraction_All:GetPosX() - Panel_Window_AddStack_All:GetSizeX() - posXPadding)
  end
  Panel_Window_AddStack_All:SetPosX(posX)
  Panel_Window_AddStack_All:SetPosY(posY)
end
function PaGlobal_AddStack_All:resizePanel(bgType)
  if nil == Panel_Window_AddStack_All then
    return
  end
  if bgType == PaGlobal_AddStack_All._BG_TYPE._BG_VALKS then
    local sizeDiff = PaGlobal_AddStack_All._ui._stc_mainBG:GetSizeY() - PaGlobal_AddStack_All._ui._stc_mainValksBG:GetSizeY()
    Panel_Window_AddStack_All:SetSize(Panel_Window_AddStack_All:GetSizeX(), self._OriginPanelSizeY - sizeDiff)
  else
    Panel_Window_AddStack_All:SetSize(Panel_Window_AddStack_All:GetSizeX(), self._OriginPanelSizeY)
  end
  Panel_Window_AddStack_All:ComputePosAllChild()
end
function PaGlobal_AddStack_All:prepareOpenSelectList(itemType)
  if nil == Panel_Window_AddStack_All then
    return
  end
  self:selectItemType(itemType)
  if self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON ~= self._currentItemType and self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO ~= self._currentItemType and self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL ~= self._currentItemType and self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME ~= self._currentItemType then
    return
  end
  self:updateSelectList()
  Panel_Window_AddStack_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  PaGlobal_AddStack_All._ui._stc_subSelectBG:SetShow(true)
end
function PaGlobal_AddStack_All:open()
  if nil == Panel_Window_AddStack_All then
    return
  end
  Panel_Window_AddStack_All:SetShow(true)
end
function PaGlobal_AddStack_All:prepareClose()
  if nil == Panel_Window_AddStack_All then
    return
  end
  PaGlobal_AddStack_All:clearCurrentSelectItem()
  PaGlobal_AddStack_All:clearControlText()
  PaGlobal_AddStack_All:prepareCloseSelectList()
  PaGlobal_AddStack_All:close()
  if true == _ContentsGroup_UsePadSnapping then
    ToClient_padSnapSetTargetPanel(Panel_Window_StackExtraction_All)
  end
end
function PaGlobal_AddStack_All:close()
  if nil == Panel_Window_AddStack_All then
    return
  end
  Panel_Window_AddStack_All:SetShow(false)
end
function PaGlobal_AddStack_All:prepareCloseSelectList()
  if nil == Panel_Window_AddStack_All then
    return
  end
  self._ui._list2_selectList:getElementManager():clearKey()
  Panel_Window_AddStack_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  PaGlobal_AddStack_All._ui._stc_subSelectBG:SetShow(false)
end
function PaGlobal_AddStack_All:update()
  if nil == Panel_Window_AddStack_All then
    return
  end
  self:updateItemCount()
  self:setItemButton()
end
function PaGlobal_AddStack_All:updateItemCount()
  if nil == Panel_Window_AddStack_All then
    return
  end
  local valksEventItemKey = self._STACK_ITEM_KEY[self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT]
  local valksItemkey = self._STACK_ITEM_KEY[self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS]
  local weaponStoneItemKey = self._STACK_ITEM_KEY[self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON]
  local armoStoneItemKey = self._STACK_ITEM_KEY[self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO]
  local countString = ""
  local WeaponitemCount = self:getItemCount(CppEnums.ItemWhereType.eInventory, weaponStoneItemKey)
  countString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DIALOG_EXCHANGE_HAVECOUNT", "count", tostring(WeaponitemCount))
  self._ui._stc_StoneWeaponCount:SetText(countString)
  local ArmoitemCount = self:getItemCount(CppEnums.ItemWhereType.eInventory, armoStoneItemKey)
  countString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DIALOG_EXCHANGE_HAVECOUNT", "count", tostring(ArmoitemCount))
  self._ui._stc_StoneArmoCount:SetText(countString)
  local valksScrollCount = self:getValksScrollCount()
  countString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENCHANT_MYSCROLL_COUNT", "count", tostring(valksScrollCount))
  self._ui._stc_ValksScrollCount:SetText(countString)
  local consumeItemCount = self:getConsumeItemCount()
  countString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENCHANT_MYSCROLL_COUNT", "count", tostring(consumeItemCount))
  self._ui._stc_ConsumeItemCount:SetText(countString)
  local valksEventItemCount = self:getItemCount(CppEnums.ItemWhereType.eInventory, valksEventItemKey)
  countString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DIALOG_EXCHANGE_HAVECOUNT", "count", tostring(valksEventItemCount))
  self._ui._stc_ValksEventCount:SetText(countString)
  local valksItemCount = self:getItemCount(CppEnums.ItemWhereType.eCashInventory, valksItemkey)
  countString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DIALOG_EXCHANGE_HAVECOUNT", "count", tostring(valksItemCount))
  self._ui._stc_ValksCount:SetText(countString)
end
function PaGlobal_AddStack_All:updateSelectList()
  if nil == Panel_Window_AddStack_All then
    return
  end
  local titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_ADD_BLACK_WEAPON_SELECT")
  if true == _ContentsGroup_UsePadSnapping then
    self._listSnappingUpdate = true
  end
  self._ui._list2_selectList:getElementManager():clearKey()
  if self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON == self._currentItemType then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_ADD_BLACK_WEAPON_SELECT")
    self:updateSelectList_BlackStone(self._currentItemKey)
  elseif self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO == self._currentItemType then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_ADD_BLACK_ARMOR_SELECT")
    self:updateSelectList_BlackStone(self._currentItemKey)
  elseif self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL == self._currentItemType then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_ADD_VALKS_SCROLL_SELECT")
    self:updateSelectList_Valks_Scroll()
  elseif self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME == self._currentItemType then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_ADD_CONSUME_SELECT")
    self:updateSelectList_Consume()
  end
  self._ui._stc_title:SetText(titleString)
end
function PaGlobal_AddStack_All:updateSelectList_BlackStone(itemKey)
  if nil == Panel_Window_AddStack_All then
    return
  end
  local itemToFailCountSSW = getItemToFailCountStaticStatus(ItemEnchantKey(itemKey, 0))
  if nil == itemToFailCountSSW then
    return
  end
  local blackStoneOrderList = {}
  for index = 0, itemToFailCountSSW:getSize() - 1 do
    local stackCount = itemToFailCountSSW:getStackCount(index)
    local blackStoneOrderData = {_listKey = index, _stackCount = stackCount}
    table.insert(blackStoneOrderList, blackStoneOrderData)
  end
  local sortFunc = function(a, b)
    return a._stackCount > b._stackCount
  end
  table.sort(blackStoneOrderList, sortFunc)
  for key, data in pairs(blackStoneOrderList) do
    if nil ~= data then
      self._ui._list2_selectList:getElementManager():pushKey(toInt64(0, data._listKey))
    end
  end
end
function PaGlobal_AddStack_All:updateSelectList_Valks_Scroll()
  if nil == Panel_Window_AddStack_All then
    return
  end
  local valksScrollOrderList = {}
  local useStartSlot = inventorySlotNoUserStart()
  local inventorysize = ToClient_InventoryGetSize(CppEnums.ItemWhereType.eCashInventory)
  for slotNo = useStartSlot, inventorysize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, slotNo)
    if nil ~= itemWrapper and false == itemWrapper:empty() then
      local itemStaticStatus = itemWrapper:getStaticStatus()
      if nil ~= itemStaticStatus and CppEnums.ContentsEventType.ContentsType_ConvertEnchantFailItemToCount == itemStaticStatus:getContentsEventType() then
        local itemKey = itemWrapper:get():getKey():getItemKey()
        local stackCount = ToClient_GetConvertEnchantFailCountByKey(ItemEnchantKey(itemKey, 0))
        local valksScrollOrderData = {_listKey = itemKey, _stackCount = stackCount}
        table.insert(valksScrollOrderList, valksScrollOrderData)
      end
    end
  end
  local sortFunc = function(a, b)
    return a._stackCount > b._stackCount
  end
  table.sort(valksScrollOrderList, sortFunc)
  for key, data in pairs(valksScrollOrderList) do
    if nil ~= data then
      self._ui._list2_selectList:getElementManager():pushKey(toInt64(0, data._listKey))
    end
  end
end
function PaGlobal_AddStack_All:updateSelectList_Consume()
  if nil == Panel_Window_AddStack_All then
    return
  end
  local ConsumeOrderList = {}
  local useStartSlot = inventorySlotNoUserStart()
  local inventorysize = ToClient_InventoryGetSize(CppEnums.ItemWhereType.eInventory)
  for slotNo = useStartSlot, inventorysize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
    if nil ~= PaGlobalFunc_SpiritEnchant_All_FilterForDarkPredationItem and false == PaGlobalFunc_SpiritEnchant_All_FilterForDarkPredationItem(slotNo, true, CppEnums.ItemWhereType.eInventory) and false == PaGlobal_AddStack_All:IsSourceItem(slotNo, CppEnums.ItemWhereType.eInventory) then
      local stackCount = PaGlobal_AddStack_All:getConsumeStackCount(CppEnums.ItemWhereType.eInventory, slotNo)
      local ConsumeOrderData = {_listKey = slotNo, _stackCount = stackCount}
      table.insert(ConsumeOrderList, ConsumeOrderData)
    end
  end
  local sortFunc = function(a, b)
    return a._stackCount > b._stackCount
  end
  table.sort(ConsumeOrderList, sortFunc)
  for key, data in pairs(ConsumeOrderList) do
    if nil ~= data then
      self._ui._list2_selectList:getElementManager():pushKey(toInt64(0, data._listKey))
    end
  end
end
function PaGlobal_AddStack_All:IsSourceItem(slotNo, itemWhereType)
  if nil == Panel_Window_AddStack_All then
    return false
  end
  local enchantInfo = getEnchantInformation()
  if nil == enchantInfo then
    return false
  end
  local sourceItemSlotNo = enchantInfo:ToClient_getSourceItemSlotNo()
  if __eTInventorySlotNoUndefined == sourceItemSlotNo then
    return false
  end
  local sourceItemWhereType = enchantInfo:ToClient_getSourceItemWhereType()
  if CppEnums.ItemWhereType.eCount == sourceItemWhereType then
    _PA_ASSERT(false, "\234\176\149\237\153\148 \235\140\128\236\131\129 \236\149\132\236\157\180\237\133\156\236\157\152 SlotNo\234\176\128 \236\161\180\236\158\172\237\149\152\235\138\148\235\141\176 WhereType\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184 \235\176\148\235\158\141\235\139\136\235\139\164!")
    return false
  end
  if sourceItemSlotNo == slotNo and sourceItemWhereType == itemWhereType then
    return true
  end
  return false
end
function PaGlobal_AddStack_All:ApplyStack()
  if nil == Panel_Window_AddStack_All then
    return
  end
  if false == _ContentsGroup_EnchantRenewer then
    return
  end
  if false == self:checkDataSet() then
    return
  end
  self:setApplyButton()
  if self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON == self._currentItemType or self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO == self._currentItemType or self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL == self._currentItemType then
    self:Apply_BlackStone(self._currentItemType)
  elseif self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS == self._currentItemType or self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT == self._currentItemType then
    self:Apply_Valks(self._currentItemType)
  elseif self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME == self._currentItemType then
    self:Apply_Consume()
  end
end
function PaGlobal_AddStack_All:Apply_BlackStone(itemType)
  if nil == Panel_Window_AddStack_All then
    return
  end
  local function doItemUse()
    ToClient_ConvertEnchantFailItemToCount(self._currentItemWhereType, self._currentItemSlotNo, toInt64(0, self._currentItemCount))
    self:prepareClose()
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local failCount = selfPlayer:getEnchantFailCount()
  local inventory = self:getSelfInventory(self._currentItemWhereType)
  if nil == inventory then
    return
  end
  self._currentItemSlotNo = inventory:getSlot(ItemEnchantKey(self._currentItemKey, 0))
  local itemWrapper = getInventoryItemByType(self._currentItemWhereType, self._currentItemSlotNo)
  if nil == itemWrapper then
    return
  end
  if failCount > 0 then
    if nil ~= PaGlobal_AddStack_All_ShowMessageBoxForFailCountCheck then
      PaGlobal_AddStack_All_ShowMessageBoxForFailCountCheck()
    end
  else
    local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_3", "failCount", failCount, "itemName", itemWrapper:getStaticStatus():getName())
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_4"),
      content = messageBoxMemo,
      functionYes = doItemUse,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobal_AddStack_All:Apply_Valks(itemType)
  if nil == Panel_Window_AddStack_All then
    return
  end
  local itemWhereType = self._ITEM_WHERETYPE[itemType]
  local inventory = self:getSelfInventory(itemWhereType)
  if nil == inventory then
    return
  end
  local slotNo = inventory:getSlot(ItemEnchantKey(self._currentItemKey))
  for itemCount = 1, self._currentItemCount do
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_UseItemTargetSelf(itemWhereType, slotNo, 0)
    else
      Inventory_UseItemTargetSelf(itemWhereType, slotNo, 0)
    end
  end
  self:prepareClose()
end
function PaGlobal_AddStack_All:Apply_Consume()
  if nil == Panel_Window_AddStack_All then
    return
  end
  if false == _ContentsGroup_EatStackEnchant then
    return
  end
  PaGlobal_AddStack_All:setConsumeStack()
  local enchantInfo = getEnchantInformation()
  local failCount = enchantInfo:ToClient_getFailCount()
  local getEnchantValue = ToClient_getEnchantFailCountStackResult(self._currentItemWhereType, self._currentItemSlotNo)
  local rate = Int64toInt32(ToClient_getEnchantFailCountRateResult(self._currentItemWhereType, self._currentItemSlotNo))
  local msgTitle = ""
  local msgStr = ""
  local messageBoxData
  local function EatEnchant_ForMessageBox()
    local consumeValue = ToClient_getEnchantFailCountStackResult(self._currentItemWhereType, self._currentItemSlotNo)
    local consumeRate = Int64toInt32(ToClient_getEnchantFailCountRateResult(self._currentItemWhereType, self._currentItemSlotNo))
    if nil ~= PaGlobal_SpiritEnchant_All_SetDarkPredationValue then
      if consumeRate <= 0 then
        consumeRate = 100
      end
      PaGlobal_SpiritEnchant_All_SetDarkPredationValue(consumeRate, consumeValue)
    end
    ToClient_Inventory_feedItem(self._currentItemWhereType, self._currentItemSlotNo)
    self:prepareClose()
  end
  if failCount == getEnchantValue then
    msgTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EATENCHANT_BUTTON_GETSTACK")
    msgStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EATENCHANT_STACK_MSGBOX", "percent", string.format("%.2f", rate / CppDefine.e1Percent))
  else
    msgTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RADIOBTNTITLE_3_EATENCHANT")
    msgStr = PAGetString(Defines.StringSheet_GAME, "LUA_EATENCHANT_MSGBOXTEXT")
  end
  messageBoxData = {
    title = msgTitle,
    content = msgStr,
    functionYes = EatEnchant_ForMessageBox,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_AddStack_All:selectItemType(itemType)
  if nil == Panel_Window_AddStack_All then
    return
  end
  if itemType >= self._STACK_ITEM_TYPE._COUNT then
    return
  end
  self._currentItemType = itemType
  self:setStackItemKey(self._currentItemType)
end
function PaGlobal_AddStack_All:setStackItemKey(itemType)
  if nil == Panel_Window_AddStack_All then
    return
  end
  self._currentItemKey = 0
  if nil == self._STACK_ITEM_KEY[itemType] then
    return
  end
  self._currentItemKey = self._STACK_ITEM_KEY[itemType]
end
function PaGlobal_AddStack_All:setConsumeStack()
  if nil == Panel_Window_AddStack_All then
    return
  end
  local currentConsumeRate = Int64toInt32(ToClient_getEnchantFailCountRateResult(self._currentItemWhereType, self._currentItemSlotNo))
  local currentComsumeStackCount = self:getConsumeStackCount(self._currentItemWhereType, self._currentItemSlotNo)
  if currentConsumeRate > 0 then
    self._ui._stc_consumeRate:SetText(string.format("%.2f", currentConsumeRate / CppDefine.e1Percent) .. "%")
  else
    self._ui._stc_consumeRate:SetText("100%")
  end
  self:setStackRate(currentComsumeStackCount, 0)
  self._ui._stc_consumeRateBG:SetShow(true)
  self._ui._stc_consumeRate:SetShow(true)
end
function PaGlobal_AddStack_All:getSelfInventory(whereType)
  if nil == Panel_Window_AddStack_All then
    return nil
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return nil
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return nil
  end
  return selfPlayer:getInventoryByType(whereType)
end
function PaGlobal_AddStack_All:getValksScrollCount()
  if nil == Panel_Window_AddStack_All then
    return 0
  end
  local valksScrollCount = 0
  local inventory = self:getSelfInventory(CppEnums.ItemWhereType.eCashInventory)
  if nil == inventory then
    return 0
  end
  local useStartSlot = inventorySlotNoUserStart()
  local inventorysize = ToClient_InventoryGetSize(CppEnums.ItemWhereType.eCashInventory)
  for slotNo = useStartSlot, inventorysize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, slotNo)
    if nil ~= itemWrapper and false == itemWrapper:empty() then
      local itemStaticStatus = itemWrapper:getStaticStatus()
      if nil ~= itemStaticStatus and CppEnums.ContentsEventType.ContentsType_ConvertEnchantFailItemToCount == itemStaticStatus:getContentsEventType() then
        valksScrollCount = valksScrollCount + 1
      end
    end
  end
  return valksScrollCount
end
function PaGlobal_AddStack_All:getConsumeItemCount()
  if nil == Panel_Window_AddStack_All then
    return 0
  end
  local consumeItemCount = 0
  local useStartSlot = inventorySlotNoUserStart()
  local inventorysize = ToClient_InventoryGetSize(CppEnums.ItemWhereType.eInventory)
  for slotNo = useStartSlot, inventorysize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
    if nil ~= PaGlobalFunc_SpiritEnchant_All_FilterForBookExtraction and false == PaGlobalFunc_SpiritEnchant_All_FilterForDarkPredationItem(slotNo, true, CppEnums.ItemWhereType.eInventory) and false == PaGlobal_AddStack_All:IsSourceItem(slotNo, CppEnums.ItemWhereType.eInventory) then
      consumeItemCount = consumeItemCount + 1
    end
  end
  return consumeItemCount
end
function PaGlobal_AddStack_All:getConsumeStackCount(whereType, slotNo)
  if nil == Panel_Window_AddStack_All then
    return 0
  end
  local enchantInfo = getEnchantInformation()
  if nil == enchantInfo then
    return
  end
  local currentFailCount = enchantInfo:ToClient_getFailCount()
  local currentConsumeValue = ToClient_getEnchantFailCountStackResult(whereType, slotNo)
  local stackCount = currentConsumeValue - currentFailCount
  if currentFailCount == currentConsumeValue then
    stackCount = 1
  end
  return stackCount
end
function PaGlobal_AddStack_All:getAdditionalEnchantRate(stackCount, valksCount)
  if nil == Panel_Window_AddStack_All then
    return 0
  end
  local currentRate = ToClient_getEnchantSuccessRate(false, false, __eEnchantFailCountSlotNo_Undefined, 0, 0)
  local addedRate = ToClient_getEnchantSuccessRate(false, false, __eEnchantFailCountSlotNo_Undefined, stackCount, valksCount)
  return addedRate - currentRate
end
function PaGlobal_AddStack_All:getItemCount(itemWhereType, itemKey)
  if nil == Panel_Window_AddStack_All then
    return 0
  end
  local inventory = self:getSelfInventory(itemWhereType)
  if nil == inventory then
    return 0
  end
  return Int64toInt32(inventory:getItemCount_s64(ItemEnchantKey(itemKey, 0)))
end
function PaGlobal_AddStack_All:getValksUsableCount(isEventValks)
  if nil == Panel_Window_AddStack_All then
    return 0
  end
  local enchantInfo = getEnchantInformation()
  if nil == enchantInfo then
    _PA_ASSERT(false, "EnchantInfo \234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
    return 0
  end
  local valksUsableMaxCount = ToClient_GetValksSealUsableCount()
  local valksLimitExceed = enchantInfo:ToClient_getValksLimitExceed()
  local currentValksCount = enchantInfo:ToClient_getValksCount()
  local currentUsableValksCount = math.max(0, valksUsableMaxCount + valksLimitExceed - currentValksCount)
  currentUsableValksCount = math.min(valksUsableMaxCount + valksLimitExceed, currentUsableValksCount)
  return currentUsableValksCount
end
function PaGlobal_AddStack_All:clearCurrentSelectItem()
  if nil == Panel_Window_AddStack_All then
    return
  end
  PaGlobal_AddStack_All._currentItemKey = 0
  PaGlobal_AddStack_All._currentItemCount = 0
  PaGlobal_AddStack_All._currentItemSlotNo = 0
  PaGlobal_AddStack_All._currentWhereType = 0
  PaGlobal_AddStack_All._currentItemType = PaGlobal_AddStack_All._STACK_ITEM_TYPE._COUNT
end
function PaGlobal_AddStack_All:clearControlText()
  if nil == Panel_Window_AddStack_All then
    return
  end
  PaGlobal_AddStack_All._ui._stc_stackValue:SetText("+" .. tostring(0))
  PaGlobal_AddStack_All._ui._stc_stackRate:SetText("(0.00%)")
  PaGlobal_AddStack_All._ui._stc_stackValue:SetShow(true)
  PaGlobal_AddStack_All._ui._stc_stackRate:SetShow(false)
  PaGlobal_AddStack_All._ui._stc_consumeRateBG:SetShow(false)
  self._ui._stc_consumeRate:SetText("0.00%")
end
function PaGlobal_AddStack_All:checkDataSet()
  if nil == Panel_Window_AddStack_All then
    return false
  end
  if self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS == self._currentItemType then
    if nil ~= self._currentItemKey and 0 ~= self._currentItemKey and 0 < self._currentItemCount then
      return true
    end
  elseif self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT == self._currentItemType then
    if nil ~= self._currentItemKey and 0 ~= self._currentItemKey and 0 < self._currentItemCount then
      return true
    end
  elseif self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON == self._currentItemType then
    if nil ~= self._currentItemKey and 0 ~= self._currentItemKey and 0 < self._currentItemCount then
      return true
    end
  elseif self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO == self._currentItemType then
    if nil ~= self._currentItemKey and 0 ~= self._currentItemKey and 0 < self._currentItemCount then
      return true
    end
  elseif self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL == self._currentItemType then
    if nil ~= self._currentItemKey and 0 ~= self._currentItemKey and 0 < self._currentItemCount then
      return true
    end
  elseif self._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME == self._currentItemType and nil ~= self._currentItemSlotNo and 0 ~= self._currentItemSlotNo and __eTInventorySlotNoUndefined ~= self._currentItemSlotNo then
    return true
  end
  return false
end
function PaGlobal_AddStack_All:setItemButton()
  if nil == Panel_Window_AddStack_All then
    return
  end
  self._ui._btn_StoneWeapon:SetIgnore(true)
  self._ui._stc_StoneWeaponSelect:SetIgnore(true)
  self._ui._btn_StoneArmo:SetIgnore(true)
  self._ui._stc_StoneArmoSelect:SetIgnore(true)
  self._ui._btn_ValksScroll:SetIgnore(true)
  self._ui._stc_ValksScrollSelect:SetIgnore(true)
  self._ui._btn_Consume:SetIgnore(true)
  self._ui._btn_ValksNormal:SetIgnore(true)
  self._ui._stc_Valksselect:SetIgnore(true)
  self._ui._btn_ValksEvent:SetIgnore(true)
  self._ui._stc_ValksEventSelect:SetIgnore(true)
  self._ui._btn_StoneWeapon:SetMonoTone(true)
  self._ui._stc_StoneWeaponSelect:SetMonoTone(true)
  self._ui._btn_StoneArmo:SetMonoTone(true)
  self._ui._stc_StoneArmoSelect:SetMonoTone(true)
  self._ui._btn_ValksScroll:SetMonoTone(true)
  self._ui._stc_ValksScrollSelect:SetMonoTone(true)
  self._ui._btn_Consume:SetMonoTone(true)
  self._ui._btn_ValksNormal:SetMonoTone(true)
  self._ui._stc_Valksselect:SetMonoTone(true)
  self._ui._btn_ValksEvent:SetMonoTone(true)
  self._ui._stc_ValksEventSelect:SetMonoTone(true)
  self._ui._stc_ValksIcon:SetIgnore(true)
  self._ui._stc_ValksEventIcon:SetIgnore(true)
  self._ui._stc_StoneWeaponIcon:SetIgnore(true)
  self._ui._stc_StoneArmoIcon:SetIgnore(true)
  self._ui._stc_ValksScrollIcon:SetIgnore(true)
  self._ui._stc_ConsumeIcon:SetIgnore(true)
  self._ui._btn_StoneWeapon:SetCheck(false)
  self._ui._btn_StoneArmo:SetCheck(false)
  self._ui._btn_ValksScroll:SetCheck(false)
  self._ui._btn_Consume:SetCheck(false)
  self._ui._btn_ValksNormal:SetCheck(false)
  self._ui._btn_ValksEvent:SetCheck(false)
  self._ui._stc_StoneWeaponIconBg:SetIgnore(true)
  self._ui._stc_StoneArmoIconBg:SetIgnore(true)
  self._ui._stc_ConsumeIconBg:SetIgnore(true)
  self._ui._stc_ValksScrollIconBg:SetIgnore(true)
  self._ui._stc_ValksIconBg:SetIgnore(true)
  self._ui._stc_ValksEventIconBg:SetIgnore(true)
  self._ui._stc_ValksIconDummy:SetShow(true)
  self._ui._stc_ValksEventIconDummy:SetShow(true)
  self._ui._stc_StoneWeaponIconDummy:SetShow(true)
  self._ui._stc_StoneArmoIconDummy:SetShow(true)
  self._ui._stc_ValksScrollIconDummy:SetShow(true)
  self._ui._stc_ConsumeIconDummy:SetShow(true)
  local valksEventItemKey = self._STACK_ITEM_KEY[self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT]
  local valksItemkey = self._STACK_ITEM_KEY[self._STACK_ITEM_TYPE._ITEM_TYPE_VALKS]
  local weaponStoneItemKey = self._STACK_ITEM_KEY[self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON]
  local armoStoneItemKey = self._STACK_ITEM_KEY[self._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO]
  local countString = ""
  local enchantInfo = getEnchantInformation()
  if nil == enchantInfo then
    return
  end
  local currentFailCount = enchantInfo:ToClient_getFailCount()
  if 0 == currentFailCount then
    local WeaponitemCount = self:getItemCount(CppEnums.ItemWhereType.eInventory, weaponStoneItemKey)
    if WeaponitemCount > 0 then
      self._ui._btn_StoneWeapon:SetIgnore(false)
      self._ui._btn_StoneWeapon:SetMonoTone(false)
      self._ui._stc_StoneWeaponSelect:SetIgnore(false)
      self._ui._stc_StoneWeaponSelect:SetMonoTone(false)
      self._ui._stc_StoneWeaponIcon:SetIgnore(false)
      self._ui._stc_StoneWeaponIconBg:SetIgnore(false)
      self._ui._stc_StoneWeaponIconDummy:SetShow(false)
    end
    local ArmoitemCount = self:getItemCount(CppEnums.ItemWhereType.eInventory, armoStoneItemKey)
    if ArmoitemCount > 0 then
      self._ui._btn_StoneArmo:SetIgnore(false)
      self._ui._btn_StoneArmo:SetMonoTone(false)
      self._ui._stc_StoneArmoSelect:SetIgnore(false)
      self._ui._stc_StoneArmoSelect:SetMonoTone(false)
      self._ui._stc_StoneArmoIcon:SetIgnore(false)
      self._ui._stc_StoneArmoIconBg:SetIgnore(false)
      self._ui._stc_StoneArmoIconDummy:SetShow(false)
    end
    local valksScrollCount = self:getValksScrollCount()
    if valksScrollCount > 0 then
      self._ui._btn_ValksScroll:SetIgnore(false)
      self._ui._btn_ValksScroll:SetMonoTone(false)
      self._ui._stc_ValksScrollSelect:SetIgnore(false)
      self._ui._stc_ValksScrollSelect:SetMonoTone(false)
      self._ui._stc_ValksScrollIcon:SetIgnore(false)
      self._ui._stc_ValksScrollIconBg:SetIgnore(false)
      self._ui._stc_ValksScrollIconDummy:SetShow(false)
    end
  end
  if 0 == currentFailCount then
    self._ui._stc_ItemList:SetIgnore(true)
  else
    self._ui._stc_ItemList:SetIgnore(false)
  end
  local consumeItemCount = self:getConsumeItemCount()
  if consumeItemCount > 0 then
    self._ui._btn_Consume:SetIgnore(false)
    self._ui._btn_Consume:SetMonoTone(false)
    self._ui._stc_ConsumeSelect:SetIgnore(false)
    self._ui._stc_ConsumeSelect:SetMonoTone(false)
    self._ui._stc_ConsumeIcon:SetIgnore(false)
    self._ui._stc_ConsumeIconBg:SetIgnore(false)
    self._ui._stc_ConsumeIconDummy:SetShow(false)
  end
  if 0 < self:getValksUsableCount() then
    local valksEventItemCount = self:getItemCount(CppEnums.ItemWhereType.eInventory, valksEventItemKey)
    if valksEventItemCount > 0 then
      self._ui._btn_ValksEvent:SetIgnore(false)
      self._ui._btn_ValksEvent:SetMonoTone(false)
      self._ui._stc_ValksEventSelect:SetIgnore(false)
      self._ui._stc_ValksEventSelect:SetMonoTone(false)
      self._ui._stc_ValksEventIcon:SetIgnore(false)
      self._ui._stc_ValksEventIconBg:SetIgnore(false)
      self._ui._stc_ValksEventIconDummy:SetShow(false)
    end
    local valksItemCount = self:getItemCount(CppEnums.ItemWhereType.eCashInventory, valksItemkey)
    if valksItemCount > 0 then
      self._ui._btn_ValksNormal:SetIgnore(false)
      self._ui._btn_ValksNormal:SetMonoTone(false)
      self._ui._stc_Valksselect:SetIgnore(false)
      self._ui._stc_Valksselect:SetMonoTone(false)
      self._ui._stc_ValksIcon:SetIgnore(false)
      self._ui._stc_ValksIconBg:SetIgnore(false)
      self._ui._stc_ValksIconDummy:SetShow(false)
    end
    if false == self._ui._btn_ValksNormal:IsIgnore() then
      self._ui._btn_ValksNormal:SetCheck(true)
    elseif false == self._ui._btn_ValksEvent:IsIgnore() then
      self._ui._btn_ValksEvent:SetCheck(true)
    end
  end
end
function PaGlobal_AddStack_All:setApplyButton()
  if nil == Panel_Window_AddStack_All then
    return
  end
  if false == PaGlobal_AddStack_All:checkDataSet() then
    self._ui._btn_Apply:SetIgnore(true)
    self._ui._btn_Apply:SetMonoTone(true)
    self._ui._stc_ApplyConsole:SetMonoTone(true)
  else
    self._ui._btn_Apply:SetIgnore(false)
    self._ui._btn_Apply:SetMonoTone(false)
    self._ui._stc_ApplyConsole:SetMonoTone(false)
  end
end
function PaGlobal_AddStack_All:setCheckItemButton(itemType)
  if nil == Panel_Window_AddStack_All then
    return
  end
  for key, control in pairs(self._itemTypeControlList) do
    if nil ~= key and nil ~= control then
      if key == itemType then
        control:SetCheck(true)
        control:SetMonoTone(false)
      else
        control:SetCheck(false)
        control:SetMonoTone(true)
      end
    end
  end
end
function PaGlobal_AddStack_All:setStackRate(stackCount, valksCount)
  if nil == Panel_Window_AddStack_All then
    return
  end
  local rate = self:getAdditionalEnchantRate(stackCount, valksCount)
  local rateToString = string.format("%.2f", rate / CppDefine.e100Percent * 100)
  if "0.00" == rateToString then
    self._ui._stc_stackRate:SetShow(false)
  else
    self._ui._stc_stackRate:SetShow(true)
  end
  self._ui._stc_stackRate:SetText("(" .. rateToString .. "%)")
  if stackCount > 0 then
    self._ui._stc_stackValue:SetShow(true)
  else
    self._ui._stc_stackValue:SetShow(false)
  end
  self._ui._stc_stackValue:SetText("+" .. tostring(stackCount))
end
function PaGlobal_AddStack_All:validate()
  if nil == Panel_Window_AddStack_All then
    return
  end
  PaGlobal_AddStack_All._ui._stc_TitleBar:isValidate()
  PaGlobal_AddStack_All._ui._stc_CloseIcon:isValidate()
  PaGlobal_AddStack_All._ui._stc_mainBG:isValidate()
  PaGlobal_AddStack_All._ui._stc_ItemList:isValidate()
  PaGlobal_AddStack_All._ui._btn_StoneWeapon:isValidate()
  PaGlobal_AddStack_All._ui._stc_StoneWeaponName:isValidate()
  PaGlobal_AddStack_All._ui._stc_StoneWeaponCount:isValidate()
  PaGlobal_AddStack_All._ui._stc_StoneWeaponSelect:isValidate()
  PaGlobal_AddStack_All._ui._btn_StoneArmo:isValidate()
  PaGlobal_AddStack_All._ui._stc_StoneArmoName:isValidate()
  PaGlobal_AddStack_All._ui._stc_StoneArmoCount:isValidate()
  PaGlobal_AddStack_All._ui._stc_StoneArmoSelect:isValidate()
  PaGlobal_AddStack_All._ui._btn_ValksScroll:isValidate()
  PaGlobal_AddStack_All._ui._stc_ValksScrollSName:isValidate()
  PaGlobal_AddStack_All._ui._stc_ValksScrollCount:isValidate()
  PaGlobal_AddStack_All._ui._stc_ValksScrollSelect:isValidate()
  PaGlobal_AddStack_All._ui._stc_ItemListConsume:isValidate()
  PaGlobal_AddStack_All._ui._btn_Consume:isValidate()
  PaGlobal_AddStack_All._ui._stc_ConsumeItemName:isValidate()
  PaGlobal_AddStack_All._ui._stc_ConsumeItemCount:isValidate()
  PaGlobal_AddStack_All._ui._stc_ConsumeSelect:isValidate()
  PaGlobal_AddStack_All._ui._stc_mainValksBG:isValidate()
  PaGlobal_AddStack_All._ui._stc_ItemListValks:isValidate()
  PaGlobal_AddStack_All._ui._btn_ValksNormal:isValidate()
  PaGlobal_AddStack_All._ui._stc_ValksName:isValidate()
  PaGlobal_AddStack_All._ui._stc_ValksCount:isValidate()
  PaGlobal_AddStack_All._ui._stc_Valksselect:isValidate()
  PaGlobal_AddStack_All._ui._btn_ValksEvent:isValidate()
  PaGlobal_AddStack_All._ui._stc_ValksEventName:isValidate()
  PaGlobal_AddStack_All._ui._stc_ValksEventCount:isValidate()
  PaGlobal_AddStack_All._ui._stc_ValksEventSelect:isValidate()
  PaGlobal_AddStack_All._ui._stc_valueBG:isValidate()
  PaGlobal_AddStack_All._ui._stc_stackValue:isValidate()
  PaGlobal_AddStack_All._ui._stc_stackRate:isValidate()
  PaGlobal_AddStack_All._ui._stc_consumeRateBG:isValidate()
  PaGlobal_AddStack_All._ui._stc_consumeRate:isValidate()
  PaGlobal_AddStack_All._ui._stc_ApplyBG:isValidate()
  PaGlobal_AddStack_All._ui._btn_Apply:isValidate()
  PaGlobal_AddStack_All._ui._stc_subSelectBG:isValidate()
  PaGlobal_AddStack_All._ui._stc_titleBG:isValidate()
  PaGlobal_AddStack_All._ui._stc_title:isValidate()
  PaGlobal_AddStack_All._ui._btn_selectListClose:isValidate()
  PaGlobal_AddStack_All._ui._list2_selectList:isValidate()
  PaGlobal_AddStack_All._ui._stc_ValksIconDummy:isValidate()
  PaGlobal_AddStack_All._ui._stc_ValksEventIconDummy:isValidate()
  PaGlobal_AddStack_All._ui._stc_StoneWeaponIconDummy:isValidate()
  PaGlobal_AddStack_All._ui._stc_StoneArmoIconDummy:isValidate()
  PaGlobal_AddStack_All._ui._stc_ValksScrollIconDummy:isValidate()
  PaGlobal_AddStack_All._ui._stc_ConsumeIconDummy:isValidate()
end
