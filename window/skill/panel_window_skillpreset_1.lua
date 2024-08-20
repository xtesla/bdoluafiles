function PaGlobal_SkillPreset:initialize()
  if true == PaGlobal_SkillPreset._initialize then
    return
  end
  self._ui.stc_Block = UI.getChildControl(Panel_Window_SkillPreset, "Static_Block")
  self._ui.stc_BG = UI.getChildControl(Panel_Window_SkillPreset, "Static_BG")
  self._ui.stc_title = UI.getChildControl(Panel_Window_SkillPreset, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_title, "StaticText_Title")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_title, "Button_Win_Close")
  self._ui.btn_Close2 = UI.getChildControl(Panel_Window_SkillPreset, "Button_Close")
  self._ui.stc_Desc = UI.getChildControl(self._ui.stc_BG, "StaticText_Desc")
  self._ui.stc_Save = UI.getChildControl(Panel_Window_SkillPreset, "Button_Save")
  self._maxSlotCount = ToClient_getSkillPresetSlotMaxCount()
  for index = 0, self._maxSlotCount - 1 do
    self._ui.btn_Slot[index] = UI.getChildControl(self._ui.stc_BG, "RadioButton_" .. tostring(index + 1))
    self._ui.btn_Slot[index]:SetShow(false)
  end
  self._ui.stc_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLPRESET_DESC"))
  self._isConsole = _ContentsGroup_UsePadSnapping
  if true == self._isConsole then
    Panel_Window_SkillPreset:SetIgnore(false)
    self._ui.stc_keyGuideBG = UI.getChildControl(Panel_Window_SkillPreset, "Static_KeyGuide_ConsoleUI")
    self._ui.txt_keyGuideY = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_KeyGuide_Y_ConsoleUI")
    self._ui.txt_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_KeyGuide_A_ConsoleUI")
    self._ui.txt_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_KeyGuide_B_ConsoleUI")
  end
  self:setSize()
  self:setConsoleUI()
  PaGlobal_SkillPreset:registEventHandler()
  PaGlobal_SkillPreset:validate()
  PaGlobal_SkillPreset._initialize = true
end
function PaGlobal_SkillPreset:registEventHandler()
  if nil == Panel_Window_SkillPreset then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_SkillPreset_Close()")
  self._ui.btn_Close2:addInputEvent("Mouse_LUp", "PaGlobal_SkillPreset_Close()")
  for index = 0, self._maxSlotCount - 1 do
    self._ui.btn_Slot[index]:addInputEvent("Mouse_LUp", "PaGlobal_SkillPreset_selectButton(" .. index .. ")")
    self._ui.btn_Slot[index]:addInputEvent("Mouse_Out", "PaGlobal_SkillPreset_TextureSetting(" .. index .. ")")
  end
  self._ui.stc_Save:addInputEvent("Mouse_LUp", "PaGlobal_SkillPreset_saveSkillPresetConfirm()")
end
function PaGlobal_SkillPreset:setSize()
  local gap = 15
  self._ui.stc_BG:SetSize(self._ui.stc_BG:GetSizeX(), self._ui.stc_Desc:GetSpanSize().y + self._ui.stc_Desc:GetTextSizeY() + self._ui.btn_Slot[0]:GetSizeY() + gap * 2)
  for index = 0, self._maxSlotCount - 1 do
    if nil ~= self._ui.btn_Slot[index] then
      self._ui.btn_Slot[index]:ComputePos()
    end
  end
  if false == self._isConsole then
    local buttonGap = 10
    Panel_Window_SkillPreset:SetSize(Panel_Window_SkillPreset:GetSizeX(), self._ui.stc_title:GetSizeY() + self._ui.stc_BG:GetSizeY() + self._ui.stc_Save:GetSizeY() + buttonGap * 2)
    self._ui.stc_Save:ComputePos()
    self._ui.btn_Close2:ComputePos()
  else
    Panel_Window_SkillPreset:SetSize(Panel_Window_SkillPreset:GetSizeX(), self._ui.stc_title:GetSizeY() + self._ui.stc_BG:GetSizeY())
  end
end
function PaGlobal_SkillPreset:alignKeyGuide()
  if true == self._isConsole then
    local keyGuides = {
      self._ui.txt_keyGuideY,
      self._ui.txt_keyGuideA,
      self._ui.txt_keyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_SkillPreset:setConsoleUI()
  if true == self._isConsole then
    self._ui.btn_Close:SetShow(false)
    self._ui.stc_Save:SetShow(false)
    self._ui.btn_Close2:SetShow(false)
    Panel_Window_SkillPreset:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_SkillPreset_saveSkillPresetConfirm()")
    PaGlobal_SkillPreset:alignKeyGuide()
  end
end
function PaGlobal_SkillPreset:prepareOpen(count)
  if nil == Panel_Window_SkillPreset then
    return
  end
  if true == self._isConsole then
    Panel_Window_SkillPreset:ignorePadSnapMoveToOtherPanel()
  end
  PaGlobal_SkillPreset_ButtonSetting(count)
  PaGlobal_SkillPreset:open()
end
function PaGlobal_SkillPreset:open()
  if nil == Panel_Window_SkillPreset then
    return
  end
  self._selectSlot = -1
  self._ui.stc_Save:SetEnable(false)
  Panel_Window_SkillPreset:SetShow(true)
end
function PaGlobal_SkillPreset:prepareClose()
  if nil == Panel_Window_SkillPreset then
    return
  end
  self._selectSlot = -1
  self._ui.stc_Save:SetEnable(false)
  PaGlobal_SkillPreset:close()
end
function PaGlobal_SkillPreset:close()
  if nil == Panel_Window_SkillPreset then
    return
  end
  Panel_Window_SkillPreset:SetShow(false)
end
function PaGlobal_SkillPreset:update()
  if nil == Panel_Window_SkillPreset then
    return
  end
end
function PaGlobal_SkillPreset:validate()
  if nil == Panel_Window_SkillPreset then
    return
  end
  self._ui.stc_Block:isValidate()
  self._ui.stc_BG:isValidate()
  self._ui.stc_title:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_Desc:isValidate()
  self._ui.stc_Save:isValidate()
  self._ui.btn_Close2:isValidate()
  if true == self._isConsole then
    self._ui.stc_keyGuideBG:isValidate()
    self._ui.txt_keyGuideY:isValidate()
    self._ui.txt_keyGuideA:isValidate()
    self._ui.txt_keyGuideB:isValidate()
  end
end
function PaGlobal_SkillPreset:saveSkillPresetConfirm()
  if self._selectSlot < 0 then
    return
  end
  local isEmpty = Toclient_getSkillPresetSlotEmpty(self._selectSlot)
  if false == isEmpty then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_ALEADY_CONFIRM")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = messageBoxMemo,
      functionYes = PaGlobal_SkillPreset_saveSkillPreset,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    PaGlobal_SkillPreset_saveSkillPreset()
  end
end
function PaGlobal_SkillPreset:saveSkillPreset()
  if self._selectSlot < 0 then
    return
  end
  ToClient_requestSaveSkillPreset(self._selectSlot)
  self._selectSlot = -1
  PaGlobal_SkillPreset_Close()
end
function PaGlobal_SkillPreset:applySkillPreset()
  if self._selectSlot < 0 then
    return
  end
  ToClient_requestApplySkillPreset(self._selectSlot)
  self._selectSlot = -1
end
function PaGlobal_SkillPreset:selectButton(slotNo)
  self._selectSlot = slotNo
  self._ui.stc_Save:SetEnable(true)
end
function PaGlobal_SkillPreset:applyConfirmMessageBox()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_APPLY")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageBoxMemo,
    functionYes = PaGlobal_SkillPreset_applySkillPreset,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_SkillPreset:buttonSetting(count)
  local sizeX = self._ui.stc_BG:GetSizeX()
  local spanSizeX = 10
  local posX = self._ui.stc_BG:GetPosX()
  local centerBtnPos = posX + sizeX / 2 - spanSizeX
  local tmp = self._ui.btn_Slot[0]:GetSizeX() + spanSizeX
  for index = 0, count - 1 do
    if index >= self._maxSlotCount then
      return
    end
    self._ui.btn_Slot[index]:SetPosX(spanSizeX + centerBtnPos - tmp * (count / 2 - index))
    self._ui.btn_Slot[index]:SetShow(true)
    PaGlobal_SkillPreset:textureSetting(index)
  end
end
function PaGlobal_SkillPreset:textureSetting(slotNo)
  if slotNo >= self._maxSlotCount then
    return
  end
  if slotNo == self._selectSlot then
    return
  end
  local control = self._ui.btn_Slot[slotNo]
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_SkillPreset:confirmMessageBox()
  if true == self._isConsole then
    return
  end
  local maxBaseSlotCount = ToClient_getSkillPresetSlotMaxCount()
  local maxCashSlotCount = ToClient_getSkillPresetCashSlotMaxCount()
  local maxNonCashSlotCount = maxBaseSlotCount - maxCashSlotCount
  local currBaseSlotCount = ToClient_getSkillPresetSlotCount()
  local currCashSlotCount = ToClient_getSkillPresetCashSlotCount()
  local currNonCashSlotCount = currBaseSlotCount - currCashSlotCount
  if maxNonCashSlotCount > currNonCashSlotCount then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_BUY_CONFIRM")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = messageBoxMemo,
      functionYes = HandleMLUp_SkillWindow_SkillPresetEasyBuy,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif maxCashSlotCount > currCashSlotCount then
    HandleMLUp_SkillWindow_SkillPresetEasyBuy()
    return
  else
    return
  end
end
