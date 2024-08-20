function PaGlobal_FairyQuickItemSlot_All:initialize()
  if true == PaGlobal_FairyQuickItemSlot_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:initControlAll()
  self:setShowControl()
  self:setData()
  PaGlobal_FairyQuickItemSlot_All:registEventHandler()
  PaGlobal_FairyQuickItemSlot_All:validate()
  PaGlobal_FairyQuickItemSlot_All._initialize = true
end
function PaGlobal_FairyQuickItemSlot_All:initControlAll()
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_FairyQuickItemSlot_All, "Static_TitleBg")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_titleBG, "StaticText_Title")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Close_PCUI")
  self._ui.stc_blackBG = UI.getChildControl(Panel_Window_FairyQuickItemSlot_All, "Static_BG")
  self._ui.stc_slotArea = UI.getChildControl(Panel_Window_FairyQuickItemSlot_All, "Static_ItemSlotArea")
  self._ui.stc_slotTemplate = UI.getChildControl(self._ui.stc_slotArea, "Static_SlotBg_Template")
  self._ui.stc_descBG = UI.getChildControl(Panel_Window_FairyQuickItemSlot_All, "Static_DescBg")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descBG, "StaticText_Desc")
  self._ui.btn_useAll = UI.getChildControl(Panel_Window_FairyQuickItemSlot_All, "Button_UseAll_PCUI")
  self._ui.stc_keyGuideBG = UI.getChildControl(Panel_Window_FairyQuickItemSlot_All, "Static_KeyGuideBg_ConsoleUI")
  self._ui.stc_keyGuideY = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_Y_ConsoleUI")
  self._ui.stc_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui.stc_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_B_ConsoleUI")
end
function PaGlobal_FairyQuickItemSlot_All:setShowControl()
  if true == self._isConsole then
    self._ui.stc_keyGuideBG:SetShow(true)
    self._ui.btn_close:SetShow(false)
    self._ui.btn_useAll:SetShow(false)
  else
    self._ui.stc_keyGuideBG:SetShow(false)
    self._ui.btn_close:SetShow(true)
    self._ui.btn_useAll:SetShow(true)
  end
end
function PaGlobal_FairyQuickItemSlot_All:setData()
  self._ui.txt_Title:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Title:SetText("\236\154\148\236\160\149 \235\178\132\237\148\132\236\149\132\236\157\180\237\133\156 \236\138\172\235\161\175")
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  if true == self._isConsole then
    self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_CONSOLE_DESC"))
    self:setAlignKeyGuide()
  else
    self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_DESC"))
  end
  self._ui.stc_descBG:SetSize(self._ui.stc_descBG:GetSizeX(), self._ui.txt_desc:GetTextSizeY() + 10)
  local slotSizeX = self._ui.stc_slotTemplate:GetSizeX()
  local slotSizeY = self._ui.stc_slotTemplate:GetSizeY()
  local gap = 5
  local slotAreaSizeX = self._ui.stc_slotArea:GetSizeX()
  local startPosX = (slotAreaSizeX - slotSizeX * self._rowMaxSlotCount - gap * (self._rowMaxSlotCount - 1)) * 0.5
  for index = 0, self._slotMaxCount - 1 do
    self._slotBg[index] = UI.createControl(__ePAUIControl_Static, self._ui.stc_slotArea, "FairyQuickItemSlot_SlotBg_" .. index)
    CopyBaseProperty(self._ui.stc_slotTemplate, self._slotBg[index])
    local row = math.floor(index / self._rowMaxSlotCount)
    local col = index % self._rowMaxSlotCount
    self._slotBg[index]:SetPosX(startPosX + col * (slotSizeX + gap))
    self._slotBg[index]:SetPosY(startPosX + row * (slotSizeY + gap))
    self._slotBg[index]:SetShow(true)
    self._slot[index] = {}
    SlotItem.new(self._slot[index], "FairyQuickItemSlot_" .. index, index, self._slotBg[index], self._slotConfig)
    self._slot[index]:createChild()
    self._slot[index].icon:SetPosX(1)
    self._slot[index].icon:SetPosY(1)
  end
  local maxRow = math.ceil(self._slotMaxCount / self._rowMaxSlotCount)
  self._ui.stc_slotArea:SetSize(self._ui.stc_slotArea:GetSizeX(), slotSizeY * maxRow + gap * (maxRow - 1) + startPosX * 2)
  local bottomSize = 0
  if false == self._isConsole then
    bottomSize = self._ui.btn_useAll:GetSizeY() + 10
  end
  local panelSize = self._ui.stc_titleBG:GetSizeY() + self._ui.stc_slotArea:GetSizeY() + self._ui.stc_descBG:GetSizeY() + 30 + bottomSize
  Panel_Window_FairyQuickItemSlot_All:SetSize(Panel_Window_FairyQuickItemSlot_All:GetSizeX(), panelSize)
  self._ui.stc_blackBG:SetSize(self._ui.stc_blackBG:GetSizeX(), panelSize)
  self._ui.btn_useAll:ComputePos()
  self._ui.stc_descBG:ComputePos()
  if true == self._isConsole then
    self._ui.stc_descBG:SetSpanSize(self._ui.stc_descBG:GetSpanSize().x, 10)
    self:setAlignKeyGuide()
  end
end
function PaGlobal_FairyQuickItemSlot_All:setAlignKeyGuide()
  if false == self._isConsole then
    return
  end
  local keyGuides = {
    self._ui.stc_keyGuideY,
    self._ui.stc_keyGuideA,
    self._ui.stc_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_FairyQuickItemSlot_All:registEventHandler()
  if nil == Panel_Window_FairyQuickItemSlot_All then
    return
  end
  registerEvent("FromClient_RefreshFairyQuickItemSlot", "FromClient_FairyQuickItemSlot_All_RefreshFairyQuickItemSlot")
  registerEvent("FromClient_InventoryUpdate", "FromClient_FairyQuickItemSlot_All_RefreshFairyQuickItemSlot")
  if true == self._isConsole then
    Panel_Window_FairyQuickItemSlot_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_FairyQuickItemSlot_All_UseAllItem()")
  else
    self._ui.btn_useAll:addInputEvent("Mouse_LUp", "PaGlobalFunc_FairyQuickItemSlot_All_UseAllItem()")
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_FairyQuickItemSlot_All_Close()")
  end
end
function PaGlobal_FairyQuickItemSlot_All:prepareOpen()
  if nil == Panel_Window_FairyQuickItemSlot_All then
    return
  end
  Inventory_SetFunctor(PaGloablFunc_FairyQuickItemSlot_All_SetFilter, HandleEventRUp_FairyQuickItemSlot_All_InvenRClick, nil, nil)
  if false == self._isConsole then
    PaGlobal_FairyQuickItemSlot_All:setOpenPos()
  end
  PaGlobal_FairyQuickItemSlot_All:update()
  PaGlobal_FairyQuickItemSlot_All:open()
end
function PaGlobal_FairyQuickItemSlot_All:open()
  if nil == Panel_Window_FairyQuickItemSlot_All then
    return
  end
  Panel_Window_FairyQuickItemSlot_All:SetShow(true)
end
function PaGlobal_FairyQuickItemSlot_All:prepareClose()
  if nil == Panel_Window_FairyQuickItemSlot_All then
    return
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  if true == self._isConsole then
    PaGlobalFunc_FloatingTooltip_Close()
  end
  PaGlobal_FairyQuickItemSlot_All:close()
end
function PaGlobal_FairyQuickItemSlot_All:close()
  if nil == Panel_Window_FairyQuickItemSlot_All then
    return
  end
  Panel_Window_FairyQuickItemSlot_All:SetShow(false)
end
function PaGlobal_FairyQuickItemSlot_All:setOpenPos()
  if true == _ContentsGroup_NewUI_Inventory_All then
    Panel_Window_FairyQuickItemSlot_All:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Window_FairyQuickItemSlot_All:GetSizeX() - 5)
    Panel_Window_FairyQuickItemSlot_All:SetPosY(Panel_Window_Inventory_All:GetPosY() + 80)
  else
    Panel_Window_FairyQuickItemSlot_All:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_FairyQuickItemSlot_All:GetSizeX() - 5)
    Panel_Window_FairyQuickItemSlot_All:SetPosY(Panel_Window_Inventory:GetPosY() + 80)
  end
end
function PaGlobal_FairyQuickItemSlot_All:update()
  if nil == Panel_Window_FairyQuickItemSlot_All then
    return
  end
  self._emptySlotIndex = -1
  for index = 0, self._slotMaxCount - 1 do
    local itemKey = ToClient_GetFairyQuickItemKey(index)
    local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if nil ~= itemStatic then
      local itemCount = ToClient_GetFairyQuickItemCount(index)
      self._slot[index]:setItemByStaticStatus(itemStatic, itemCount)
      if 0 == itemCount then
        self._slot[index].icon:SetMonoTone(true)
      else
        self._slot[index].icon:SetMonoTone(false)
      end
      if true == self._isConsole then
        self._slot[index].icon:addInputEvent("Mouse_LUp", "HandleEventRUp_FairyQuickItemSlot_All_SlotRClick(" .. index .. ")")
        self._slotBg[index]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_FairyQuickItemSlot_All_ShowItemTooltip(true, " .. index .. ", " .. tostring(itemKey) .. ")")
      else
        self._slot[index].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_FairyQuickItemSlot_All_SlotRClick(" .. index .. ")")
        self._slot[index].icon:addInputEvent("Mouse_On", "PaGlobalFunc_FairyQuickItemSlot_All_ShowItemTooltip(true, " .. index .. ", " .. tostring(itemKey) .. ")")
        self._slot[index].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_FairyQuickItemSlot_All_ShowItemTooltip(false)")
      end
    else
      if -1 == self._emptySlotIndex then
        self._emptySlotIndex = index
      end
      self._slot[index]:clearItem()
      if true == self._isConsole then
        self._slot[index].icon:removeInputEvent("Mouse_LUp")
        self._slotBg[index]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      else
        self._slot[index].icon:removeInputEvent("Mouse_RUp")
        self._slot[index].icon:addInputEvent("Mouse_On", "")
        self._slot[index].icon:addInputEvent("Mouse_Out", "")
      end
    end
  end
end
function PaGlobal_FairyQuickItemSlot_All:validate()
  if nil == Panel_Window_FairyQuickItemSlot_All then
    return
  end
  self._ui.stc_titleBG:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_blackBG:isValidate()
  self._ui.stc_slotArea:isValidate()
  self._ui.stc_slotTemplate:isValidate()
  self._ui.stc_descBG:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.btn_useAll:isValidate()
  self._ui.stc_keyGuideBG:isValidate()
  self._ui.stc_keyGuideY:isValidate()
  self._ui.stc_keyGuideA:isValidate()
  self._ui.stc_keyGuideB:isValidate()
end
