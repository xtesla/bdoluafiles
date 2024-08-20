function PaGlobal_Inventory_All:initialize()
  if nil == Panel_Window_Inventory_All or true == PaGlobal_Inventory_All._initialize then
    return
  end
  PaGlobal_Inventory_All:controlInit()
  PaGlobal_Inventory_All:createSlot()
  PaGlobal_Inventory_All:setData()
  PaGlobal_Inventory_All:registerEventHandler()
  PaGlobal_Inventory_All:validate()
  PaGlobal_Inventory_All._initialize = true
end
function PaGlobal_Inventory_All:controlInit()
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_Inventory_All, "StaticText_Title")
  self._ui.check_popup = UI.getChildControl(self._ui.stc_titleBG, "CheckButton_PopUp")
  self._ui.btn_question = UI.getChildControl(self._ui.stc_titleBG, "Button_Question")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Win_Close")
  self._ui.stc_radioButtonBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_RadioButtonBg")
  self._ui.rdo_normalInven = UI.getChildControl(self._ui.stc_radioButtonBG, "RadioButton_NormalInventory")
  self._ui.rdo_pearlInven = UI.getChildControl(self._ui.stc_radioButtonBG, "RadioButton_CashInventory")
  if true == _ContentsGroup_changeFamilyInvenOpenAction then
    self._ui.rdo_familyInven = UI.getChildControl(self._ui.stc_radioButtonBG, "RadioButton_FamilyInventory")
  else
    self._ui.rdo_familyInven = UI.getChildControl(self._ui.stc_radioButtonBG, "Button_FamilyInventory")
  end
  self._ui.stc_pearlInvenEffect = UI.getChildControl(self._ui.rdo_pearlInven, "Static_New_Effect")
  self._ui.stc_selectbar = UI.getChildControl(self._ui.stc_radioButtonBG, "Static_SelectBar")
  self._ui.btn_olympicFilter = UI.getChildControl(self._ui.stc_radioButtonBG, "Button_CheckItem")
  self._ui.stc_topItemSortBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_TopItemSortBG")
  self._ui.check_itemSort = UI.getChildControl(self._ui.stc_topItemSortBG, "CheckButton_ItemSort")
  self._ui.txt_capacity = UI.getChildControl(self._ui.stc_topItemSortBG, "Static_Text_Capacity")
  local searchBG = UI.getChildControl(self._ui.stc_topItemSortBG, "Static_Search_BG")
  self._ui.edit_search = UI.getChildControl(searchBG, "Edit_SearchText_PCUI_Import")
  self._ui.btn_search = UI.getChildControl(searchBG, "Button_BtnSearch_PCUI")
  self._ui.txt_searchDefaultText = UI.getChildControl(searchBG, "StaticText_DefaultSearchText")
  self._ui.btn_searchReset = UI.getChildControl(searchBG, "Button_SearchReset")
  self._ui.stc_mainSlotBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_MainSlotBG")
  self._ui.scroll_inven = UI.getChildControl(self._ui.stc_mainSlotBG, "Scroll_CashInven")
  self._ui.stc_scrollArea = UI.getChildControl(Panel_Window_Inventory_All, "Scroll_Area")
  self._ui.template_slotBG = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_Slot_Temp")
  self._ui.template_slot = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_SlotBG_Temp")
  self._ui.template_lockSlot = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_LockSlot_Temp")
  self._ui.template_plusSlot = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_PlusSlot")
  self._ui.template_onlyPlus = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_OnlyPlus")
  self._ui.template_btnPuzzle = UI.getChildControl(Panel_Window_Inventory_All, "Button_Puzzle")
  self._ui.template_olympic = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_OlympicFilter")
  self._ui.stc_weightBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_Texture_Weight_Background")
  self._ui.btn_buyWeight = UI.getChildControl(self._ui.stc_weightBG, "Button_BuyWeight")
  self._ui.progress_weight = UI.getChildControl(self._ui.stc_weightBG, "Progress2_Weight")
  self._ui.progress_equipment = UI.getChildControl(self._ui.stc_weightBG, "Progress2_Equipment")
  self._ui.stc_weightIcon = UI.getChildControl(self._ui.stc_weightBG, "Static_WeightIcon")
  self._ui.txt_weightValue = UI.getChildControl(self._ui.stc_weightBG, "StaticText_Weight")
  self._ui.stc_weightTooltipBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_WeightHelp_BG")
  self._ui.txt_weightDesc = UI.getChildControl(Panel_Window_Inventory_All, "StaticText_Weight_Help")
  self._ui.txt_equipDesc = UI.getChildControl(Panel_Window_Inventory_All, "StaticText_Equip_Help")
  self._ui.txt_moneyDesc = UI.getChildControl(Panel_Window_Inventory_All, "StaticText_MoneyHelp")
  self._ui.stc_moneyBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_MoneyTypeBG")
  self._ui.stc_moneyIcon = UI.getChildControl(self._ui.stc_moneyBG, "Button_Money")
  self._ui.txt_moneyValue = UI.getChildControl(self._ui.stc_moneyBG, "Static_Text_Money")
  self._ui.stc_pearlIcon = UI.getChildControl(self._ui.stc_moneyBG, "Static_PearlIcon")
  self._ui.txt_pearlValue = UI.getChildControl(self._ui.stc_moneyBG, "StaticText_PearlValue")
  self._ui.stc_mileageIcon = UI.getChildControl(self._ui.stc_moneyBG, "Static_MileageIcon")
  self._ui.txt_mileageValue = UI.getChildControl(self._ui.stc_moneyBG, "StaticText_MileageValue")
  self._ui.stc_oceanIcon = UI.getChildControl(self._ui.stc_moneyBG, "Static_OceanIcon")
  self._ui.txt_oceanValue = UI.getChildControl(self._ui.stc_moneyBG, "StaticText_OceanValue")
  self._ui.stc_buttonBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_ButtonTypeBG")
  self._ui.btn_alchemyFigureHead = UI.getChildControl(self._ui.stc_buttonBG, "Button_AlchemyFigureHead")
  self._ui.btn_alchemyStone = UI.getChildControl(self._ui.stc_buttonBG, "Button_AlchemyStone")
  self._ui.btn_manufacture = UI.getChildControl(self._ui.stc_buttonBG, "Button_Manufacture")
  self._ui.btn_dyePalette = UI.getChildControl(self._ui.stc_buttonBG, "Button_Palette")
  self._ui.btn_openEquip = UI.getChildControl(self._ui.stc_buttonBG, "Button_OpenEquip")
  self._ui.btn_openEquip:SetShow(false)
  self._ui.btn_trash = UI.getChildControl(Panel_Window_Inventory_All, "Button_Trash")
  self._ui.btn_trash:SetColor(Defines.Color.C_FFFFFFFF)
  self._ui.btn_moveFamilyInven = UI.getChildControl(Panel_Window_Inventory_All, "Button_1")
  self._ui.txt_enchantNumber = UI.getChildControl(Panel_Window_Inventory_All, "Static_Text_Slot_Enchant_value")
  self._ui.stc_puzzleNotice = UI.getChildControl(Panel_Window_Inventory_All, "Static_Notice")
  self._ui.txt_puzzleNoticeText = UI.getChildControl(self._ui.stc_puzzleNotice, "StaticText_Notice")
  self._ui.stc_manufactureButtonBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_ManufactureButtonBG")
  self._ui.btn_manufactureOpen = UI.getChildControl(self._ui.stc_manufactureButtonBG, "Button_Manufacture")
  self._ui.btn_productNote = UI.getChildControl(self._ui.stc_manufactureButtonBG, "Button_Note")
  self._ui.stc_exchangeButtonBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_ExchangeButtonBG")
  self._ui.btn_waypoint = UI.getChildControl(self._ui.stc_exchangeButtonBG, "Button_WayPoint")
  self._ui.btn_widget = UI.getChildControl(self._ui.stc_exchangeButtonBG, "Button_Widget")
  self._ui.btn_sellEtcAll = UI.getChildControl(Panel_Window_Inventory_All, "Button_SellEtcAll")
  self._ui.btn_doItemMove = UI.getChildControl(Panel_Window_Inventory_All, "Button_AutoMove")
  self._ui.btn_setItemMove = UI.getChildControl(Panel_Window_Inventory_All, "Button_Set_AutoMove")
end
function PaGlobal_Inventory_All:createSlot()
  for ii = 0, self.config.slotCount - 1 do
    local slot = {}
    slot.empty = UI.createControl(__ePAUIControl_Static, Panel_Window_Inventory_All, "Inventory_Slot_Base_" .. ii)
    slot.lock = UI.createControl(__ePAUIControl_Static, Panel_Window_Inventory_All, "Inventory_Slot_Lock_" .. ii)
    slot.plus = UI.createControl(__ePAUIControl_Static, Panel_Window_Inventory_All, "Inventory_Slot_Plus_" .. ii)
    slot.onlyPlus = UI.createControl(__ePAUIControl_Static, Panel_Window_Inventory_All, "Inventory_Slot_OnlyPlus_" .. ii)
    slot.olympic = UI.createControl(__ePAUIControl_Static, Panel_Window_Inventory_All, "Inventory_Slot_OlympicFilter_" .. ii)
    CopyBaseProperty(self._ui.template_slot, slot.empty)
    CopyBaseProperty(self._ui.template_lockSlot, slot.lock)
    CopyBaseProperty(self._ui.template_plusSlot, slot.plus)
    CopyBaseProperty(self._ui.template_onlyPlus, slot.onlyPlus)
    CopyBaseProperty(self._ui.template_olympic, slot.olympic)
    UIScroll.InputEventByControl(slot.empty, "HandleEventScroll_Inventory_All_UpdateScroll")
    local row = math.floor(ii / self.config.slotCols)
    local col = ii % self.config.slotCols
    slot.empty:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
    slot.empty:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.lock:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
    slot.lock:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.plus:SetPosX(self.config.slotStartX + self.config.slotGapX * col - 4)
    slot.plus:SetPosY(self.config.slotStartY + self.config.slotGapY * row - 4)
    slot.onlyPlus:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
    slot.onlyPlus:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.olympic:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
    slot.olympic:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.empty:SetShow(false)
    slot.lock:SetShow(false)
    slot.plus:SetShow(false)
    slot.onlyPlus:SetShow(false)
    slot.olympic:SetShow(false)
    self._slotsBackground[ii] = slot
  end
  local useStartSlot = inventorySlotNoUserStart()
  for ii = 0, self.config.slotCount - 1 do
    local slotNo = ii + useStartSlot
    local slot = {}
    SlotItem.new(slot, "ItemIcon_" .. ii, ii, Panel_Window_Inventory_All, self.slotConfig)
    slot:createChild()
    slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Inventory_All_SlotRClick(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_LDown", "HandleEventLDown_Inventory_All_SlotLClick(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_DropHandler(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_PressMove", "HandleEventPressMove_Inventory_All_SlotDrag(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_IconTooltip(true, " .. ii .. ")")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_IconTooltip(false, " .. ii .. ")")
    UIScroll.InputEventByControl(slot.icon, "HandleEventScroll_Inventory_All_UpdateScroll")
    slot.icon:SetAutoDisableTime(0.2)
    local row = math.floor(ii / self.config.slotCols)
    local col = ii % self.config.slotCols
    slot.icon:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
    slot.icon:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.icon:SetEnableDragAndDrop(true)
    slot.isEmpty = true
    Panel_Tooltip_Item_SetPosition(ii, slot, "inventory")
    slot.background = UI.createControl(__ePAUIControl_Static, Panel_Window_Inventory_All, "Inventory_Slot_BG_" .. ii)
    CopyBaseProperty(self._ui.template_slotBG, slot.background)
    slot.background:SetSize(slot.icon:GetSizeX(), slot.icon:GetSizeY())
    slot.background:SetPosX(slot.icon:GetPosX())
    slot.background:SetPosY(slot.icon:GetPosY())
    slot.background:SetShow(false)
    slot.icon:SetSize(44, 44)
    slot.border:SetSize(44, 44)
    slot.border:SetPosX(0.5)
    slot.border:SetPosY(0.5)
    slot.cooltime:SetSize(44, 44)
    slot.cooltime:SetPosX(0)
    slot.cooltime:SetPosY(0)
    self.slots[ii] = slot
    local effectSlot = {}
    local puzzle = UI.createControl(__ePAUIControl_Button, slot.icon, "Puzzle_Control_" .. ii)
    CopyBaseProperty(self._ui.template_btnPuzzle, puzzle)
    puzzle:SetShow(false)
    puzzle:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_MakePuzzle(" .. ii .. ")")
    puzzle:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_PuzzleTooltip(true," .. ii .. ")")
    puzzle:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_PuzzleTooltip(false)")
    Panel_Window_Inventory_All:SetChildIndex(self._ui.stc_puzzleNotice, 9999)
    Panel_Window_Inventory_All:SetChildIndex(self.slots[ii].icon, 9998)
    effectSlot.isFirstItem = false
    effectSlot.puzzleControl = puzzle
    self.slotEtcData[ii] = effectSlot
  end
  for ii = 0, self.config.slotCount - 1 do
    local slot = self._slotsBackground[ii]
    Panel_Window_Inventory_All:SetChildIndex(slot.plus, 15099)
    Panel_Window_Inventory_All:SetChildIndex(slot.onlyPlus, 15100)
    Panel_Window_Inventory_All:SetChildIndex(slot.olympic, 15101)
  end
  for ii = 0, self.INVEN_MAX_SLOTNO do
    self.newItemData[ii] = nil
    self.newPearlItemData[ii] = nil
  end
  if FGlobal_IsCommercialService() then
    if isGameTypeGT() then
      self._ui.stc_pearlIcon:SetShow(false)
      self._ui.txt_pearlValue:SetShow(false)
      self._ui.stc_mileageIcon:SetShow(false)
      self._ui.txt_mileageValue:SetShow(false)
    else
      self._ui.stc_pearlIcon:SetShow(true)
      self._ui.txt_pearlValue:SetShow(true)
      self._ui.stc_mileageIcon:SetShow(true)
      self._ui.txt_mileageValue:SetShow(true)
    end
  elseif isGameTypeEnglish() then
    self._ui.stc_pearlIcon:SetShow(true)
    self._ui.txt_pearlValue:SetShow(true)
    self._ui.stc_mileageIcon:SetShow(true)
    self._ui.txt_mileageValue:SetShow(true)
  else
    self._ui.stc_pearlIcon:SetShow(false)
    self._ui.txt_pearlValue:SetShow(false)
    self._ui.stc_mileageIcon:SetShow(false)
    self._ui.txt_mileageValue:SetShow(false)
  end
  if isGameTypeGT() then
    self._ui.stc_pearlIcon:SetShow(false)
    self._ui.txt_pearlValue:SetShow(false)
    self._ui.stc_mileageIcon:SetShow(false)
    self._ui.txt_mileageValue:SetShow(false)
    if false == _ContentsGroup_OceanCurrent then
      self._ui.stc_oceanIcon:SetShow(false)
      self._ui.txt_oceanValue:SetShow(false)
    else
      self._ui.stc_oceanIcon:SetSpanSize(5, self._ui.stc_oceanIcon:GetSpanSize().y)
      self._ui.txt_oceanValue:SetSpanSize(40, 10)
      self._ui.txt_oceanValue:ComputePos()
    end
  end
  if true == isGameTypeKR2() then
    self._ui.stc_mileageIcon:SetShow(false)
    self._ui.txt_mileageValue:SetShow(false)
  end
  self._ui.btn_buyWeight:SetShow(_ContentsGroup_EasyBuy)
  self._ui.btn_doItemMove:SetShow(false)
  self._ui.btn_setItemMove:SetShow(false)
end
function PaGlobal_Inventory_All:setData()
  self.config.slotRows = self.config.slotCount / self.config.slotCols
  self._isItemLockContentsOpen = ToClient_IsContentsGroupOpen("219")
  self._defaultPosX = Panel_Window_Inventory_All:GetPosX()
  self._defaultPosY = Panel_Window_Inventory_All:GetPosY()
  self._defaultSizeY = Panel_Window_Inventory_All:GetSizeY()
  self._defaultTrashSpanY = self._ui.btn_trash:GetSpanSize().y
  self._defaultMoneySpanY = self._ui.stc_moneyBG:GetSpanSize().y
  self._defaultWeightSpanY = self._ui.stc_weightBG:GetSpanSize().y
  self._defaultWeightTooltipSizeY = self._ui.stc_weightTooltipBG:GetSizeY()
  self._ui.txt_enchantNumber:SetShow(false)
  self._ui.check_popup:SetShow(_ContentsGroup_PopUp)
  self._ui.btn_alchemyStone:SetShow(_ContentsGroup_AlchemyStone)
  self._ui.btn_alchemyFigureHead:SetShow(_ContentsGroup_AlchemyFigureHead)
  self._ui.check_itemSort:SetEnableArea(0, 0, self._ui.check_itemSort:GetSizeX() + self._ui.check_itemSort:GetTextSizeX() + 10, self._ui.check_itemSort:GetSizeY())
  self._ui.rdo_normalInven:SetCheck(true)
  Panel_Window_Inventory_All:SetChildIndex(self._ui.stc_manufactureButtonBG, 10000)
  Panel_Window_Inventory_All:SetChildIndex(self._ui.stc_exchangeButtonBG, 10000)
  PaGlobal_Inventory_All:changeMileageIcon()
  Panel_Inventory_CoolTime_Effect_Item_Slot:RegisterShowEventFunc(true, "PaGlobalFunc_ItemCoolTimeEffect_ShowAni()")
  self._normalInvenButtonSpanX = self._ui.rdo_normalInven:GetSpanSize().x
  self._pearlInvenButtonSpanX = self._ui.rdo_pearlInven:GetSpanSize().x
  if false == _ContentsGroup_FamilyInventory then
    self._ui.rdo_normalInven:SetSpanSize(self._normalInvenButtonSpanX + self._radioButtonSpanXGap, self._ui.rdo_normalInven:GetSpanSize().y)
    self._ui.rdo_pearlInven:SetSpanSize(self._pearlInvenButtonSpanX + self._radioButtonSpanXGap, self._ui.rdo_pearlInven:GetSpanSize().y)
    self._ui.rdo_familyInven:SetShow(false)
  else
    if CppEnums.ServiceResourceType.eServiceResourceType_TR == ToClient_getResourceType() then
      self._ui.rdo_normalInven:SetSpanSize(self._normalInvenButtonSpanX - 10, self._ui.rdo_normalInven:GetSpanSize().y)
      self._ui.rdo_familyInven:SetSpanSize(self._ui.rdo_normalInven:GetSpanSize().x * -1, self._ui.rdo_familyInven:GetSpanSize().y)
    end
    self._ui.rdo_familyInven:SetTextMode(__eTextMode_AutoWrap)
    self._ui.rdo_familyInven:SetText(self._ui.rdo_familyInven:GetText())
  end
  self._ui.btn_olympicFilter:SetShow(_ContentsGroup_Olympic)
end
function PaGlobal_Inventory_All:registerEventHandler()
  if nil == Panel_Window_Inventory_All then
    return
  end
  self._ui.check_popup:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_CheckPopUpUI()")
  self._ui.check_popup:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_PopupUITooltip(true)")
  self._ui.check_popup:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_PopupUITooltip(false)")
  self._ui.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowInventory\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._ui.btn_question, "\"PanelWindowInventory\"")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Inventory_All_Close()")
  self._ui.rdo_normalInven:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_SelectTab()")
  self._ui.rdo_pearlInven:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_SelectTab()")
  if true == _ContentsGroup_changeFamilyInvenOpenAction then
    self._ui.rdo_familyInven:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_SelectTab()")
  else
    self._ui.rdo_familyInven:addInputEvent("Mouse_LUp", "PaGlobal_FamilyInvnetory_Open()")
  end
  self._ui.btn_olympicFilter:addInputEvent("Mouse_LUp", "PaGlobalFunc_Inventory_All_ToggleOlympicFilterInventory()")
  self._ui.btn_olympicFilter:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_OlympicFilterTooltip(true)")
  self._ui.btn_olympicFilter:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_OlympicFilterTooltip(false)")
  self._ui.check_itemSort:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_SetSorted()")
  self._ui.txt_capacity:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_EasyBuyOpen( true )")
  self._ui.txt_capacity:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_CapacityTooltip( true )")
  self._ui.txt_capacity:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_CapacityTooltip( false )")
  if true == _ContentsGroup_changeFamilyInvenOpenAction then
    self._ui.btn_moveFamilyInven:addInputEvent("Mouse_LUp", "PaGlobalFunc_Inventory_All_ToggleFamilyInventory()")
  end
  UIScroll.InputEvent(self._ui.scroll_inven, "HandleEventScroll_Inventory_All_UpdateScroll")
  UIScroll.InputEventByControl(self._ui.stc_scrollArea, "HandleEventScroll_Inventory_All_UpdateScroll")
  self._ui.stc_weightIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_WeightTooltip( true )")
  self._ui.stc_weightIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_WeightTooltip( false )")
  self._ui.stc_weightBG:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_WeightTooltip( true )")
  self._ui.stc_weightBG:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_WeightTooltip( false )")
  self._ui.btn_buyWeight:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_EasyBuyOpen( false )")
  self._ui.btn_buyWeight:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BuyWeightTooltip(true)")
  self._ui.btn_buyWeight:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BuyWeightTooltip(false)")
  self._ui.stc_moneyIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_PopMoney()")
  self._ui.stc_moneyIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 0)")
  self._ui.stc_moneyIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 0)")
  self._ui.stc_pearlIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_OpenPearlShop()")
  self._ui.stc_pearlIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 1)")
  self._ui.stc_pearlIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 1)")
  self._ui.stc_mileageIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 2)")
  self._ui.stc_mileageIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 2)")
  self._ui.stc_oceanIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 3)")
  self._ui.stc_oceanIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 3)")
  self._ui.btn_alchemyFigureHead:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick( " .. 0 .. " )")
  self._ui.btn_alchemyFigureHead:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip( true, " .. 0 .. " )")
  self._ui.btn_alchemyFigureHead:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip( false, " .. 0 .. " )")
  self._ui.btn_alchemyStone:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick( " .. 1 .. " )")
  self._ui.btn_alchemyStone:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip( true, " .. 1 .. " )")
  self._ui.btn_alchemyStone:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip( false, " .. 1 .. " )")
  if true == _ContentsGroup_AlchemyStone then
    self._ui.btn_alchemyStone:setButtonShortcuts("PANEL_SIMPLESHORTCUT_ALCHEMY_RECHARGE")
  end
  self._ui.btn_manufacture:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick( " .. 2 .. " )")
  self._ui.btn_manufacture:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip( true, " .. 2 .. " )")
  self._ui.btn_manufacture:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip( false, " .. 2 .. " )")
  self._ui.btn_dyePalette:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick( " .. 3 .. " )")
  self._ui.btn_dyePalette:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip( true, " .. 3 .. " )")
  self._ui.btn_dyePalette:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip( false,  " .. 3 .. " )")
  self._ui.btn_openEquip:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_OpenEquipment()")
  self._ui.btn_trash:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_ItemDelete()")
  self._ui.btn_trash:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_TrashTooltip( true )")
  self._ui.btn_trash:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_TrashTooltip( false )")
  self._ui.btn_sellEtcAll:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_SellAllEtcItem()")
  self._ui.btn_doItemMove:addInputEvent("Mouse_LUp", "PaGlobal_Inventory_All:requestMoveItemsInventoryToWarehouse()")
  self._ui.btn_setItemMove:addInputEvent("Mouse_LUp", "PaGlobal_ItemMoveSet:prepareOpen()")
  self._ui.edit_search:addInputEvent("Mouse_LDown", "PaGlobal_Inventory_All:setFocusSearchText()")
  self._ui.edit_search:addInputEvent("Mouse_LUp", "PaGlobal_Inventory_All:setFocusSearchText()")
  self._ui.edit_search:RegistReturnKeyEvent("PaGlobal_Inventory_All:searchItem()")
  self._ui.btn_search:addInputEvent("Mouse_LUp", "PaGlobal_Inventory_All:searchItem()")
  self._ui.btn_searchReset:addInputEvent("Mouse_LUp", "PaGlobal_Inventory_All:clearSearch()")
  self._ui.btn_searchReset:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_SearchResetTooltip(true)")
  self._ui.btn_searchReset:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_SearchResetTooltip(false)")
  Panel_Window_Inventory_All:RegisterShowEventFunc(true, "PaGlobalFunc_Inventory_All_ShowAni()")
  Panel_Window_Inventory_All:RegisterShowEventFunc(false, "PaGlobalFunc_Inventory_All_HideAni()")
  Panel_Window_Inventory_All:RegisterUpdateFunc("PaGlobalFunc_Inventory_All_UpdatePerFrame")
  registerEvent("FromClient_cursorOnOffSignal", "FromClient_Inventory_All_CursorOnOffSignal")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_Inventory_All_RenderModeChange_FlushRestoreFunc")
  registerEvent("onScreenResize", "PaGlobalFunc_Inventory_All_OnScreenResize")
  registerEvent("FromClient_WeightChanged", "Invnetory_updateData")
  registerEvent("FromClient_InventoryUpdate", "FromClient_Inventory_All_UpdateSlotDataByAddItem")
  registerEvent("EventInventorySetShow", "PaGlobalFunc_Inventory_All_SetShow")
  registerEvent("EventInventorySetShowWithFilter", "FromClient_Inventory_All_SetShowWithFilter")
  registerEvent("EventAddItemToInventory", "FromClient_Inventory_All_AddItem")
  registerEvent("EventUnEquipItemToInventory", "FromClient_Inventory_All_UnequipItem")
  registerEvent("FromClient_UseItemAskFromOtherPlayer", "FromClient_Inventory_All_UseItemAskFromOtherPlayer")
  registerEvent("FromClient_FindExchangeItemNPC", "FromClient_Inventory_All_FindExchangeItemNPC")
  registerEvent("FromClient_InventoryUpdatebyAddItem", "FromClient_Inventory_All_UpdateSlotDataByAddItem")
  registerEvent("FromClient_UpdateInventoryBag", "FromClient_Inventory_All_UpdateSlotDataByAddItem")
  registerEvent("FromClient_OpenFamilyInventory", "FromClient_Inventory_All_OpenFamilyInventory")
end
function PaGlobal_Inventory_All:validate()
  if nil == Panel_Window_Inventory_All then
    return
  end
  self._ui.stc_titleBG:isValidate()
  self._ui.check_popup:isValidate()
  self._ui.btn_question:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.btn_sellEtcAll:isValidate()
  self._ui.btn_doItemMove:isValidate()
  self._ui.btn_setItemMove:isValidate()
end
function PaGlobal_Inventory_All:requestMoveItemsInventoryToWarehouse()
  local actorKeyRaw = PaGlobal_WareHouse_All._targetActorKeyRaw
  local moveItemCount = ToClient_requestMoveItemsInventoryToWarehouse(actorKeyRaw)
  if 0 == moveItemCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMOVESET_EMPTY"))
  else
    PaGlobal_ItemMoveSet._fromItemCount = moveItemCount
  end
end
function PaGlobal_Inventory_All:setIgnoreMoveItemButton(isIgnore)
  self._ui.btn_doItemMove:SetIgnore(isIgnore)
  self._ui.btn_setItemMove:SetIgnore(isIgnore)
  self._ui.btn_doItemMove:SetMonoTone(isIgnore)
  self._ui.btn_setItemMove:SetMonoTone(isIgnore)
end
