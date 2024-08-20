function PaGlobal_Dye_Palette_All:initialize()
  if true == PaGlobal_Dye_Palette_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_TitleArea = UI.getChildControl(Panel_Window_Dye_Palette_All, "Static_TitleArea")
  self._ui_pc.btn_Close = UI.getChildControl(stc_TitleArea, "Button_Exit")
  self._ui_pc.btn_Help = UI.getChildControl(stc_TitleArea, "Button_Help")
  local stc_RadioBG = UI.getChildControl(Panel_Window_Dye_Palette_All, "Static_RadioBG")
  self._ui.btn_TabList[self._TAB_TYPE.ALL] = UI.getChildControl(stc_RadioBG, "RadioButton_All")
  self._ui.btn_TabList[self._TAB_TYPE.MINE] = UI.getChildControl(stc_RadioBG, "RadioButton_Mine")
  self._ui.btn_TabList[self._TAB_TYPE.MIX] = UI.getChildControl(stc_RadioBG, "RadioButton_Mix")
  local stc_Line = UI.getChildControl(stc_RadioBG, "Static_UnderLine")
  self._ui.stc_Line = UI.getChildControl(stc_Line, "Static_SelectBar")
  self._ui.stc_All_Mine_BG = UI.getChildControl(Panel_Window_Dye_Palette_All, "Static_All_N_Mine_BG")
  self._ui.stc_ScrollArea = UI.getChildControl(self._ui.stc_All_Mine_BG, "Static_ColorList_ScrollArea")
  local stc_SubTab_AllMine = UI.getChildControl(self._ui.stc_All_Mine_BG, "Static_SubTab_AllMine")
  self._ui.txt_SelectedMaterialName = UI.getChildControl(stc_SubTab_AllMine, "StaticText_SelectMaterial_Name_All")
  for idx = 0, self._materialCount - 1 do
    self._materialName[idx] = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_MATERIAL_" .. tostring(idx))
    self._rdo_Material[idx] = UI.getChildControl(stc_SubTab_AllMine, "RadioButton_Material_" .. tostring(idx))
    self._rdo_Material[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_Dye_Palette_All_SelectCategory( " .. tostring(idx) .. " )")
    self._rdo_Material[idx]:addInputEvent("Mouse_On", "HandleEventLUp_Dye_Palette_All_CategoryTooltip( true , " .. tostring(idx) .. " )")
    self._rdo_Material[idx]:addInputEvent("Mouse_Out", "HandleEventLUp_Dye_Palette_All_CategoryTooltip( false , " .. tostring(idx) .. " )")
  end
  self._ui.stc_slotBG = UI.getChildControl(self._ui.stc_ScrollArea, "Static_ColorBG")
  for slotRowsIdx = 0, self.config.maxSlotRowsCount - 1 do
    self.slot[slotRowsIdx] = {}
    for slotColsIdx = 0, self.config.maxSlotColsCount - 1 do
      self.slot[slotRowsIdx][slotColsIdx] = {}
      local slot = self.slot[slotRowsIdx][slotColsIdx]
      slot.bg = UI.createAndCopyBasePropertyControl(self._ui.stc_ScrollArea, "Static_ColorBG", self._ui.stc_ScrollArea, "DyePaletteSlotBG_" .. slotColsIdx .. "_" .. slotRowsIdx)
      slot.color = UI.createAndCopyBasePropertyControl(self._ui.stc_slotBG, "Static_Color", slot.bg, "DyePaletteSlot_Color_" .. slotColsIdx .. "_" .. slotRowsIdx)
      slot.count = UI.createAndCopyBasePropertyControl(self._ui.stc_slotBG, "StaticText_Count", slot.bg, "DyePaletteSlot_Count_" .. slotColsIdx .. "_" .. slotRowsIdx)
      slot.btn = UI.createAndCopyBasePropertyControl(self._ui.stc_slotBG, "RadioButton_Select", slot.bg, "DyePaletteSlot_ColorBtn_" .. slotColsIdx .. "_" .. slotRowsIdx)
      local slotPosX = (slot.bg:GetSizeX() + self.config.cellSpan) * slotColsIdx + self.config.startPosX
      local slotPosY = (slot.bg:GetSizeY() + self.config.cellSpan) * slotRowsIdx + self.config.startPosY
      slot.color:SetAlphaIgnore(true)
      slot.bg:SetPosXY(slotPosX, slotPosY)
      slot.color:SetPosXY(0, 0)
      slot.count:SetPosXY(0, 35)
      slot.btn:SetPosXY(0, 0)
      if 0 == slotRowsIdx then
        slot.bg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "InputScroll_Dye_Palette_All(true)")
      end
      if self.config.maxSlotRowsCount - 1 == slotRowsIdx then
        slot.bg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "InputScroll_Dye_Palette_All(false)")
      end
      slot.btn:addInputEvent("Mouse_UpScroll", "InputScroll_Dye_Palette_All( true )")
      slot.btn:addInputEvent("Mouse_DownScroll", "InputScroll_Dye_Palette_All( false )")
    end
  end
  local stc_AmplueArea = UI.getChildControl(self._ui.stc_All_Mine_BG, "Static_AmplueArea")
  local stc_AmplueBG = UI.getChildControl(stc_AmplueArea, "Static_AmplueColor_BG")
  self._ui.stc_SelectedAmpule = UI.getChildControl(stc_AmplueBG, "Static_AmplueColor")
  self._ui.txt_SelectedAmpuleName = UI.getChildControl(stc_AmplueArea, "StaticText_NoneSelectedColor")
  self._ui_pc.btn_Withdraw = UI.getChildControl(stc_AmplueArea, "Button_Amplus")
  self._ui.stc_SelectedAmpule:SetAlphaIgnore(true)
  self._ui.scroll = UI.getChildControl(self._ui.stc_ScrollArea, "Scroll_ScrollColor")
  self._ui.scrollBtn = UI.getChildControl(self._ui.scroll, "Scroll_1_CtrlButton")
  self._ui.stc_Mix_BG = UI.getChildControl(Panel_Window_Dye_Palette_All, "Static_MixPalette")
  local stc_MixBG = UI.getChildControl(self._ui.stc_Mix_BG, "Static_MixBG")
  local stc_MixInfoBG = UI.getChildControl(self._ui.stc_Mix_BG, "Static_MixInfoBG")
  for index = 0, self._mixSlotCount - 1 do
    local createdSlot = {}
    local bg = UI.getChildControl(stc_MixBG, "Static_Icon0" .. index + 1)
    SlotItem.new(createdSlot, "ItemIconSlot" .. index, 0, bg, self._slotConfig)
    createdSlot:createChild()
    createdSlot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Dye_Palette_All_ColorMixSlot(" .. index .. ")")
    createdSlot.icon:addInputEvent("Mouse_On", "HandleEventOn_Dye_Palette_All_ColorMix_ShowTooltip(" .. index .. ")")
    createdSlot.icon:addInputEvent("Mouse_Out", "HandleEventOn_Dye_Palette_All_ColorMix_HideTooltip()")
    if index ~= self._mixSlotCount - 1 then
      createdSlot.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_Dye_Palette_All_ColorMixDropHandler(" .. index .. ")")
    end
    createdSlot.icon:SetVerticalMiddle()
    createdSlot.icon:SetHorizonCenter()
    createdSlot.icon:SetShow(false)
    self._ui.stc_slotList[index] = createdSlot
  end
  self._ui.txt_MixInfo = UI.getChildControl(stc_MixInfoBG, "StaticText_MixInfo")
  self._ui.txt_MixInfo:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_MixInfo:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COLORBALANCE_DESC"))
  self._ui_pc.btn_MixColor = UI.getChildControl(self._ui.stc_Mix_BG, "Button_Mix")
  self._ui_console.stc_Console_KeyGuide = UI.getChildControl(Panel_Window_Dye_Palette_All, "Static_Console_KeyGuide")
  local stc_Main_KeyGuide = UI.getChildControl(self._ui_console.stc_Console_KeyGuide, "Static_Main_KeyGuide")
  self._ui_console.stc_KeyGuideLB = UI.getChildControl(stc_Main_KeyGuide, "Static_LB")
  self._ui_console.stc_KeyGuideRB = UI.getChildControl(stc_Main_KeyGuide, "Static_RB")
  local stc_Palette_KeyGuide = UI.getChildControl(self._ui_console.stc_Console_KeyGuide, "Static_Palette_KeyGuide")
  self._ui_console.stc_KeyGuideLT = UI.getChildControl(stc_Palette_KeyGuide, "Static_LT")
  self._ui_console.stc_KeyGuideRT = UI.getChildControl(stc_Palette_KeyGuide, "Static_RT")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(self._ui_console.stc_Console_KeyGuide, "Static_KeyGuideBG")
  self._ui_console.txt_KeyGuidePaletteA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Palette_Y")
  self._ui_console.txt_KeyGuideMixA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Mix_Y")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_B")
  self:changePlatform()
  PaGlobal_Dye_Palette_All:registEventHandler()
  PaGlobal_Dye_Palette_All:validate()
  PaGlobal_Dye_Palette_All._initialize = true
end
function PaGlobal_Dye_Palette_All:registEventHandler()
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  if self._isConsole then
    Panel_Window_Dye_Palette_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLUp_Dye_Palette_All_SelectConsoleTab(" .. -1 .. ")")
    Panel_Window_Dye_Palette_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLUp_Dye_Palette_All_SelectConsoleTab(" .. 1 .. ")")
    Panel_Window_Dye_Palette_All:registerPadEvent(__eConsoleUIPadEvent_LT, "HandleEventLUp_Dye_Palette_All_SelectConsoleCategory(" .. -1 .. ")")
    Panel_Window_Dye_Palette_All:registerPadEvent(__eConsoleUIPadEvent_RT, "HandleEventLUp_Dye_Palette_All_SelectConsoleCategory(" .. 1 .. ")")
  else
    self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_Dye_Palette_All_Close()")
    self._ui_pc.btn_Help:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Dye\" )")
    self._ui.stc_ScrollArea:addInputEvent("Mouse_UpScroll", "InputScroll_Dye_Palette_All( true )")
    self._ui.stc_ScrollArea:addInputEvent("Mouse_DownScroll", "InputScroll_Dye_Palette_All( false )")
    self._ui.scroll:addInputEvent("Mouse_LUp", "HandleEventLUp_Dye_Palette_All_Palette_All_Scroll()")
    self._ui.scrollBtn:addInputEvent("Mouse_LPress", "HandleEventLUp_Dye_Palette_All_Palette_All_Scroll()")
    for index = 0, #self._ui.btn_TabList do
      self._ui.btn_TabList[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_Dye_Palette_All_SelectTab(" .. index .. ")")
    end
    self._ui_pc.btn_Withdraw:addInputEvent("Mouse_LUp", "HandleEventLUp_Dye_Palette_All_WithdrawColor()")
    self._ui_pc.btn_MixColor:addInputEvent("Mouse_LUp", "HandleEventLUp_Dye_Palette_All_MixColor()")
  end
  registerEvent("FromClient_UpdateDyeingPalette", "FromClient_Dye_Palette_All_PaletteUpdate")
  registerEvent("FromClient_ColorBalance_SlotUpdate", "FromClient_Dye_Palette_All_MixSlotUpdate")
end
function PaGlobal_Dye_Palette_All:prepareOpen(isPalette)
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  if false == _ContentsGroup_NewUI_AlchemyFigureHead_All then
    if nil ~= Panel_AlchemyFigureHead and Panel_AlchemyFigureHead:GetShow() then
      FGlobal_AlchemyFigureHead_Close()
    end
  elseif nil ~= Panel_AlchemyFigureHead_All and Panel_AlchemyFigureHead_All:GetShow() then
    PaGlobal_AlchemyFigureHead_All_Close()
  end
  if true == _ContentsGroup_NewUI_AlchemyStone_All then
    if nil ~= Panel_Window_AlchemyStone_All and true == Panel_Window_AlchemyStone_All:GetShow() then
      PaGlobalFunc_AlchemyStone_All_Close()
    end
  elseif nil ~= Panel_AlchemyStone and true == Panel_AlchemyStone:GetShow() then
    FGlobal_AlchemyStone_Close()
  end
  if not _ContentsGroup_RenewUI_Manufacture then
    if false == _ContentsGroup_NewUI_Manufacture_All then
      if true == Panel_Manufacture:GetShow() then
        Manufacture_Close()
      end
    elseif true == Panel_Window_Manufacture_All:GetShow() then
      PaGlobalFunc_Manufacture_All_Close()
    end
  end
  if not _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      if Panel_Window_Equipment_All:GetShow() then
        PaGlobalFunc_Equipment_All_Close(false)
      end
    elseif Panel_Equipment:GetShow() then
      EquipmentWindow_Close()
    end
  end
  if true == _ContentsGroup_FamilyInventory and false == Panel_Window_Dye_Palette_All:GetShow() then
    PaGlobalFunc_Inventory_All_familyInventoryButtonActive(false)
  end
  local invenPosX = 0
  local invenPosY = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    if true == Panel_Window_Inventory_All:IsUISubApp() then
      invenPosX = Panel_Window_Inventory_All:GetScreenParentPosX()
      invenPosY = Panel_Window_Inventory_All:GetScreenParentPosY()
    else
      invenPosX = Panel_Window_Inventory_All:GetPosX()
      invenPosY = Panel_Window_Inventory_All:GetPosY()
    end
  elseif true == Panel_Window_Inventory:IsUISubApp() then
    invenPosX = Panel_Window_Inventory:GetScreenParentPosX()
    invenPosY = Panel_Window_Inventory:GetScreenParentPosY()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
    invenPosY = Panel_Window_Inventory:GetPosY()
  end
  Panel_Window_Dye_Palette_All:SetPosX(invenPosX - Panel_Window_Dye_Palette_All:GetSizeX())
  Panel_Window_Dye_Palette_All:SetPosY(invenPosY)
  if true == _ContentsGroup_NewUI_Inventory_All then
    if Panel_Window_Inventory_All:IsUISubApp() then
      Panel_Window_Dye_Palette_All:OpenUISubApp()
    end
    if false == Panel_Window_Inventory_All:GetShow() then
      InventoryWindow_Show(false, true)
    end
  else
    if Panel_Window_Inventory:IsUISubApp() then
      Panel_Window_Dye_Palette_All:OpenUISubApp()
    end
    if false == Panel_Window_Inventory:GetShow() then
      PaGlobalFunc_InventoryInfo_Open(2, false)
    end
  end
  self.config.selectedTabIdx = self._TAB_TYPE.ALL
  if false == isPalette then
    self.config.selectedTabIdx = self._TAB_TYPE.MIX
  end
  if true == self._isConsole then
    PaGlobal_Dye_Palette_All:selectConsoleTab(0)
    PaGlobal_Dye_Palette_All:selectConsoleCategory(0)
  else
    PaGlobal_Dye_Palette_All:selectTab(self.config.selectedTabIdx)
    PaGlobal_Dye_Palette_All:selectCategory(0)
  end
  PaGlobal_Dye_Palette_All:open()
end
function PaGlobal_Dye_Palette_All:open()
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  Panel_Window_Dye_Palette_All:SetShow(true)
end
function PaGlobal_Dye_Palette_All:prepareClose()
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  Panel_Window_Dye_Palette_All:CloseUISubApp()
  local isInvenOpen = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    isInvenOpen = Panel_Window_Inventory_All:GetShow()
  else
    isInvenOpen = Panel_Window_Inventory:GetShow()
  end
  if false == _ContentsGroup_RenewUI_InventoryEquip and true == isInvenOpen then
    if true == _ContentsGroup_NewUI_Equipment_All then
      if false == Panel_Window_Equipment_All:GetShow() then
        PaGlobalFunc_Equipment_All_Open()
      end
    elseif false == Panel_Equipment:GetShow() then
      Panel_Equipment:SetShow(true)
    end
  end
  if true == _ContentsGroup_FamilyInventory and true == Panel_Window_Dye_Palette_All:GetShow() then
    PaGlobalFunc_Inventory_All_familyInventoryButtonActive(true)
  end
  self.config.selectedTabIdx = self._TAB_TYPE.ALL
  self.config.selectedCategoryIdx = 0
  self.config.scrollStartIdx = 0
  self.config.selectedColorIdx = nil
  self._ui.scroll:SetControlPos(0)
  if true == self._isConsole then
    InventoryWindow_Close()
  end
  PaGlobal_Dye_Palette_All:close()
end
function PaGlobal_Dye_Palette_All:close()
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  Panel_Window_Dye_Palette_All:SetShow(false)
end
function PaGlobal_Dye_Palette_All:validate()
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  self._ui_pc.btn_Close:isValidate()
  self._ui_pc.btn_Help:isValidate()
  self._ui.stc_Line:isValidate()
  self._ui.txt_SelectedMaterialName:isValidate()
  self._ui.stc_All_Mine_BG:isValidate()
  self._ui.stc_slotBG:isValidate()
  self._ui.stc_Mix_BG:isValidate()
  self._ui.txt_MixInfo:isValidate()
  self._ui_pc.btn_MixColor:isValidate()
  self._ui.stc_SelectedAmpule:isValidate()
  self._ui.txt_SelectedAmpuleName:isValidate()
  self._ui_pc.btn_Withdraw:isValidate()
  self._ui.scroll:isValidate()
  self._ui.scrollBtn:isValidate()
end
function PaGlobal_Dye_Palette_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_Dye_Palette_All:selectTab(tabType)
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  if nil == tabType then
    return
  end
  self.config.selectedTabIdx = tabType
  self.config.selectedCategoryIdx = 0
  self.config.scrollStartIdx = 0
  self.config.selectedColorIdx = nil
  self._ui.scroll:SetControlPos(0)
  if self._TAB_TYPE.ALL == tabType or self._TAB_TYPE.MINE == tabType then
    Inventory_SetFunctor(PaGlobal_Dye_Palette_All_SetInvenFilter, PaGlobal_Dye_Palette_All_SetInvenRclick, nil, nil)
    self:paletteUpdate()
  elseif self._TAB_TYPE.MIX == tabType then
    Inventory_SetFunctor(PaGlobal_Dye_Palette_All_SetInvenFilter, PaGlobal_Dye_Palette_ColorMix_All_SetInvenRclick, nil, nil)
    self:mixUpdate()
  end
end
function PaGlobal_Dye_Palette_All:selectConsoleTab(varIndex)
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  if nil == varIndex then
    return
  end
  TooltipSimple_Hide()
  self.config.selectedTabIdx = self.config.selectedTabIdx + varIndex
  if self.config.selectedTabIdx < self._TAB_TYPE.ALL then
    self.config.selectedTabIdx = self._TAB_TYPE.MIX
  elseif self._TAB_TYPE.COUNT <= self.config.selectedTabIdx then
    self.config.selectedTabIdx = self._TAB_TYPE.ALL
  end
  self.config.selectedCategoryIdx = 0
  self.config.scrollStartIdx = 0
  self.config.selectedColorIdx = nil
  self._ui.scroll:SetControlPos(0)
  local tabType = self.config.selectedTabIdx
  if true == self._isConsole then
    if self._TAB_TYPE.ALL == tabType or self._TAB_TYPE.MINE == tabType then
      self._ui_console.txt_KeyGuidePaletteA:SetShow(true)
      self._ui_console.txt_KeyGuideMixA:SetShow(false)
      self._ui_console.stc_KeyGuideLT:SetShow(true)
      self._ui_console.stc_KeyGuideRT:SetShow(true)
      Panel_Window_Dye_Palette_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Dye_Palette_All_WithdrawColor()")
      local keyguides = {
        self._ui_console.txt_KeyGuidePaletteA,
        self._ui_console.txt_KeyGuideB
      }
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
      Inventory_SetFunctor(PaGlobal_Dye_Palette_All_SetInvenFilter, PaGlobal_Dye_Palette_All_SetInvenRclick, nil, nil)
      self:paletteUpdate()
    elseif self._TAB_TYPE.MIX == tabType then
      if true == _ContentsGroup_NewUI_Inventory_All then
        ToClient_padSnapSetTargetPanel(Panel_Window_Inventory_All)
      else
        ToClient_padSnapSetTargetPanel(Panel_Window_Inventory)
      end
      self._ui_console.txt_KeyGuidePaletteA:SetShow(false)
      self._ui_console.txt_KeyGuideMixA:SetShow(true)
      self._ui_console.stc_KeyGuideLT:SetShow(false)
      self._ui_console.stc_KeyGuideRT:SetShow(false)
      Panel_Window_Dye_Palette_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Dye_Palette_All_MixColor()")
      self._keyguides = {
        self._ui_console.txt_KeyGuideMixA,
        self._ui_console.txt_KeyGuideB
      }
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
      Inventory_SetFunctor(PaGlobal_Dye_Palette_All_SetInvenFilter, PaGlobal_Dye_Palette_ColorMix_All_SetInvenRclick, nil, nil)
      self:mixUpdate()
    end
  end
end
function PaGlobal_Dye_Palette_All:selectCategory(categoryIdx)
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  if nil == categoryIdx then
    return
  end
  if self._TAB_TYPE.MIX == self.config.selectedTabIdx then
    return
  end
  self.config.selectedCategoryIdx = categoryIdx
  self.config.scrollStartIdx = 0
  self.config.selectedColorIdx = nil
  self._ui.scroll:SetControlPos(0)
  self:setMaterialName(categoryIdx)
  self:paletteUpdate()
end
function PaGlobal_Dye_Palette_All:selectConsoleCategory(varIndex)
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  if nil == varIndex then
    return
  end
  if self._TAB_TYPE.MIX == self.config.selectedTabIdx then
    return
  end
  self.config.selectedCategoryIdx = self.config.selectedCategoryIdx + varIndex
  if self.config.selectedCategoryIdx < 0 then
    self.config.selectedCategoryIdx = self._materialCount - 1
  elseif self._materialCount <= self.config.selectedCategoryIdx then
    self.config.selectedCategoryIdx = 0
  end
  self.config.scrollStartIdx = 0
  self.config.selectedColorIdx = nil
  self._ui.scroll:SetControlPos(0)
  self:setMaterialName(self.config.selectedCategoryIdx)
  self:paletteUpdate()
end
function PaGlobal_Dye_Palette_All:selectColor(colorIdx)
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  if nil == colorIdx then
    return
  end
  self.config.selectedColorIdx = colorIdx
  local tab = self.config.selectedTabIdx
  local category = self.config.selectedCategoryIdx
  local showType = self._TAB_TYPE.ALL == self.config.selectedTabIdx
  local colorIdx = self.config.selectedColorIdx
  local DyeingPaletteCategoryInfo = ToClient_requestGetPaletteCategoryInfo(category, showType)
  if nil ~= DyeingPaletteCategoryInfo then
    local colorValue = DyeingPaletteCategoryInfo:getColor(colorIdx)
    local itemEnchantKey = DyeingPaletteCategoryInfo:getItemEnchantKey(colorIdx)
    local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
    if nil ~= itemEnchantSSW then
      local itemEnchantSS = itemEnchantSSW:get()
      local itemName = getItemName(itemEnchantSS)
      self._ui.stc_SelectedAmpule:SetColor(colorValue)
      self._ui.txt_SelectedAmpuleName:SetText(itemName)
      UI.setLimitTextAndAddTooltip(self._ui.txt_SelectedAmpuleName, "", itemName)
    end
  end
  self._ui.btn_TabList[tab]:SetCheck(true)
  if true == PaGlobal_NumberPad_All_GetShow() then
    Panel_NumberPad_Close()
  end
end
function PaGlobal_Dye_Palette_All:paletteUpdate()
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  self._ui.stc_All_Mine_BG:SetShow(true)
  self._ui.stc_Mix_BG:SetShow(false)
  for index = 0, #self._ui.btn_TabList do
    self._ui.btn_TabList[index]:SetCheck(false)
  end
  self._ui.btn_TabList[self.config.selectedTabIdx]:SetCheck(true)
  self._ui.stc_Line:SetPosX(self._ui.btn_TabList[self.config.selectedTabIdx]:GetPosX() - 15)
  local isShowAll = self._TAB_TYPE.ALL == self.config.selectedTabIdx
  local category = self.config.selectedCategoryIdx
  self:setMaterialName(category)
  for idx = 0, self._materialCount - 1 do
    self._rdo_Material[idx]:SetCheck(idx == category)
  end
  self:paletteClearSlot()
  local DyeingPaletteCategoryInfo = ToClient_requestGetPaletteCategoryInfo(category, isShowAll)
  if nil ~= DyeingPaletteCategoryInfo then
    local colorCount = DyeingPaletteCategoryInfo:getListSize()
    self.config.colorTotalRows = math.ceil(colorCount / self.config.maxSlotColsCount)
    local uiIndex = 0
    for slotRowsIdx = 0, self.config.maxSlotRowsCount - 1 do
      for slotColsIdx = 0, self.config.maxSlotColsCount - 1 do
        local slot = self.slot[slotRowsIdx][slotColsIdx]
        local colorIdx = uiIndex + self.config.scrollStartIdx * self.config.maxSlotColsCount
        if colorCount > colorIdx then
          local colorValue = DyeingPaletteCategoryInfo:getColor(colorIdx)
          local itemEnchantKey = DyeingPaletteCategoryInfo:getItemEnchantKey(colorIdx)
          local isDyeUI = false
          local ampuleCount = DyeingPaletteCategoryInfo:getCount(colorIdx, isDyeUI)
          slot.count:SetText(tostring(ampuleCount))
          self:changeSlotTexture(true, slotRowsIdx, slotColsIdx)
          slot.color:SetColor(colorValue)
          slot.count:SetShow(true)
          if colorIdx == self.config.selectedColorIdx then
            slot.btn:SetCheck(true)
          end
          slot.bg:SetIgnore(false)
          slot.btn:SetIgnore(false)
          slot.btn:addInputEvent("Mouse_LUp", "HandleEventLUp_Dye_Palette_All_SelectColor( " .. colorIdx .. " )")
          slot.btn:addInputEvent("Mouse_On", "HandleEventLUp_Dye_Palette_All_ColorToolTip( true, " .. itemEnchantKey .. ", " .. slotRowsIdx .. ", " .. slotColsIdx .. " )")
          slot.btn:addInputEvent("Mouse_Out", "HandleEventLUp_Dye_Palette_All_ColorToolTip( false, " .. itemEnchantKey .. ", " .. slotRowsIdx .. ", " .. slotColsIdx .. " )")
          uiIndex = uiIndex + 1
        end
      end
    end
    local function setSelectColor_nil()
      self._ui.stc_SelectedAmpule:SetColor(16777215)
      self._ui.txt_SelectedAmpuleName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_PLZ_SELECT_COLOR"))
      UI.setLimitTextAndAddTooltip(self._ui.txt_SelectedAmpuleName, "", PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_PLZ_SELECT_COLOR"))
    end
    local selectedColorIdx = self.config.selectedColorIdx
    if nil ~= selectedColorIdx then
      local colorValue = DyeingPaletteCategoryInfo:getColor(selectedColorIdx)
      local itemEnchantKey = DyeingPaletteCategoryInfo:getItemEnchantKey(selectedColorIdx)
      local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
      if nil ~= itemEnchantSSW then
        local itemEnchantSS = itemEnchantSSW:get()
        local itemName = getItemName(itemEnchantSS)
        self._ui.stc_SelectedAmpule:SetColor(colorValue)
        self._ui.txt_SelectedAmpuleName:SetText(itemName)
        UI.setLimitTextAndAddTooltip(self._ui.txt_SelectedAmpuleName, "", itemName)
      else
        setSelectColor_nil()
      end
    else
      setSelectColor_nil()
    end
    UIScroll.SetButtonSize(self._ui.scroll, self.config.maxSlotRowsCount, self.config.colorTotalRows)
  else
    self._ui.stc_SelectedAmpule:SetColor(16777215)
    self._ui.txt_SelectedAmpuleName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_PLZ_SELECT_COLOR"))
    UI.setLimitTextAndAddTooltip(self._ui.txt_SelectedAmpuleName, "", PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_PLZ_SELECT_COLOR"))
    UIScroll.SetButtonSize(self._ui.scroll, self.config.maxSlotRowsCount, 0)
    self._ui.scroll:SetControlPos(0)
  end
end
function PaGlobal_Dye_Palette_All:mixUpdate()
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  self._ui.stc_Mix_BG:SetShow(true)
  self._ui.stc_All_Mine_BG:SetShow(false)
  for index = 0, #self._ui.btn_TabList do
    self._ui.btn_TabList[index]:SetCheck(false)
  end
  self._ui.btn_TabList[self.config.selectedTabIdx]:SetCheck(true)
  self._ui.stc_Line:SetPosX(self._ui.btn_TabList[self.config.selectedTabIdx]:GetPosX() - 15)
  self:mixColorClearSlot()
end
function PaGlobal_Dye_Palette_All:paletteClearSlot()
  for slotRowsIdx = 0, self.config.maxSlotRowsCount - 1 do
    for slotColsIdx = 0, self.config.maxSlotColsCount - 1 do
      local slot = self.slot[slotRowsIdx][slotColsIdx]
      local clearColor = 16777215
      self:changeSlotTexture(false, slotRowsIdx, slotColsIdx)
      slot.color:SetColor(clearColor)
      slot.count:SetText("0")
      slot.count:SetShow(false)
      slot.btn:SetCheck(false)
      slot.btn:SetIgnore(true)
      slot.bg:SetIgnore(self._isConsole)
      slot.btn:addInputEvent("Mouse_LUp", "")
      slot.btn:addInputEvent("Mouse_On", "")
      slot.btn:addInputEvent("Mouse_Out", "")
    end
  end
end
function PaGlobal_Dye_Palette_All:mixColorClearSlot()
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  for index = 0, self._mixSlotCount - 1 do
    self._ui.stc_slotList[index]:clearItem()
    self._ui.stc_slotList[index].icon:SetShow(false)
  end
end
function PaGlobal_Dye_Palette_All:changeSlotTexture(isFill, rowsIdx, colsIdx)
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  if nil == isFill or nil == rowsIdx or nil == colsIdx then
    return
  end
  local slot = self.slot[rowsIdx][colsIdx].color
  local x1, y1, x2, y2
  if true == isFill then
    x1, y1, x2, y2 = 55, 162, 99, 206
  else
    x1, y1, x2, y2 = 55, 209, 99, 253
  end
  slot:ChangeTextureInfoName("new_ui_common_forlua/default/Default_Buttons_02.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(slot, x1, y1, x2, y2)
  slot:getBaseTexture():setUV(x1, y1, x2, y2)
  slot:setRenderTexture(slot:getBaseTexture())
end
function PaGlobal_Dye_Palette_All:setMaterialName(categoryIdx)
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  if nil == categoryIdx then
    return
  end
  local materialString = self._materialName[categoryIdx]
  local materialName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PALETTE_MATERIALNAME", "name", materialString)
  self._ui.txt_SelectedMaterialName:SetText(materialName)
end
function PaGlobal_Dye_Palette_All:paletteScroll(isScrollUp)
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  local prevIdx = self.config.scrollStartIdx
  self.config.scrollStartIdx = UIScroll.ScrollEvent(self._ui.scroll, isScrollUp, self.config.maxSlotRowsCount, self.config.colorTotalRows, self.config.scrollStartIdx, 1)
  self:paletteUpdate()
end
function PaGlobal_Dye_Palette_All:withdrawColor()
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  local isShowAll = self._TAB_TYPE.ALL == self.config.selectedTabIdx
  local categoryIndex = self.config.selectedCategoryIdx
  local colorIndex = self.config.selectedColorIdx
  if nil == colorIndex then
    return
  end
  local DyeingPaletteCategoryInfo = ToClient_requestGetPaletteCategoryInfo(categoryIndex, isShowAll)
  local itemEnchantKey = DyeingPaletteCategoryInfo:getItemEnchantKey(colorIndex)
  local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  if nil == itemEnchantSSW then
    return
  end
  local itemEnchantSS = itemEnchantSSW:get()
  local itemName = getItemName(itemEnchantSS)
  local itemCount = DyeingPaletteCategoryInfo:getCount(colorIndex, false)
  local function confirmMessageBox(itemCount)
    if nil == itemCount then
      return
    end
    local function doExportPalette()
      ToClient_requestChangeDyeingPaletteToItem(categoryIndex, colorIndex, itemCount, isShowAll)
    end
    local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
    local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_PALETTE_SURE_GET_THIS_AMPLUE", "itemName", itemName, "itemCount", tostring(itemCount))
    local messageBoxData = {
      title = messageTitle,
      content = messageBoxMemo,
      functionYes = doExportPalette,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
  if itemCount > toInt64(0, 1) then
    Panel_NumberPad_Show(true, itemCount, 0, confirmMessageBox)
  else
    confirmMessageBox(itemCount)
  end
end
function PaGlobal_Dye_Palette_All:mixColor()
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  local slotList = self._ui.stc_slotList
  if nil == slotList[0].itemWhereType or nil == slotList[1].itemWhereType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_COLORBALENCE_COMBINEDYEITEM"))
    return
  end
  ToClient_CombineDyeItem(slotList[0].itemWhereType, slotList[0].slotNo, slotList[1].itemWhereType, slotList[1].slotNo)
end
function PaGlobal_Dye_Palette_All:mixColorUpdate(itemWhereType, itemSlotNo)
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  if nil == itemWhereType or nil == itemSlotNo then
    return
  end
  local itemWrapper
  local _slotList = self._ui.stc_slotList
  for index = 0, self._mixSlotCount - 1 do
    itemWrapper = getInventoryItemByType(_slotList[index].itemWhereType, _slotList[index].slotNo)
    if nil ~= itemWrapper then
      _slotList[index]:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemWrapper:get():getCount_s64())
    else
      _slotList[index].icon:SetShow(false)
      _slotList[index]:clearItem()
    end
  end
  itemWrapper = getInventoryItemByType(itemWhereType, itemSlotNo)
  if nil ~= itemWrapper then
    _slotList[2]:setItemByStaticStatus(itemWrapper:getStaticStatus(), 1)
    _slotList[2].icon:SetShow(true)
    _slotList[2].slotNo = itemSlotNo
    _slotList[2].itemWhereType = itemWhereType
    if nil ~= Panel_Window_Inventory_All and Panel_Window_Inventory_All:GetShow() then
      Inventory_updateSlotData(true)
    end
    if nil ~= Panel_Dye_ReNew and Panel_Dye_ReNew:GetShow() then
      FGlobal_Panel_DyeReNew_updateColorAmpuleList()
    end
  end
end
function PaGlobal_Dye_Palette_All:colorMixSlotRClick(index)
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  if nil == index then
    return
  end
  local _slotList = self._ui.stc_slotList
  _slotList[index].icon:SetShow(false)
  _slotList[index]:clearItem()
  _slotList[index].itemWhereType = nil
  _slotList[index].slotNo = nil
  local tooltipPanel
  if true == _ContentsGroup_NewUI_Tooltip_All then
    tooltipPanel = Panel_Widget_Tooltip_Item_All
  else
    tooltipPanel = Panel_Tooltip_Item
  end
  if tooltipPanel:GetShow() then
    HandleEventOn_Dye_Palette_All_ColorMix_HideTooltip()
  end
end
function PaGlobal_Dye_Palette_All:colorMixDropHandler(index)
  if nil == Panel_Window_Dye_Palette_All then
    return
  end
  if nil == index then
    return
  end
  if nil == DragManager.dragStartPanel then
    return
  end
  local fromSlotNo = DragManager.dragSlotInfo
  local inventoryPanel
  if true == _ContentsGroup_NewUI_Inventory_All then
    inventoryPanel = Panel_Window_Inventory_All
  else
    inventoryPanel = Panel_Window_Inventory
  end
  if inventoryPanel == DragManager.dragStartPanel then
    local itemWrapper = getInventoryItemByType(DragManager.dragWhereTypeInfo, DragManager.dragSlotInfo)
    if nil == itemWrapper then
      return
    end
    local _slotList = self._ui.stc_slotList
    _slotList[index]:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemWrapper:get():getCount_s64())
    _slotList[index].icon:SetShow(true)
    _slotList[index].slotNo = DragManaiger.dragSlotInfo
    _slotList[index].itemWhereType = DragManager.dragWhereTypeInfo
    _slotList[2].icon:SetShow(false)
    _slotList[2]:clearItem()
    DragManager:clearInfo()
  end
  return
end
