function PaGlobal_CrewName_All:initialize()
  if true == PaGlobal_CrewName_All._initialize then
    return
  end
  self._ui.btn_close = UI.getChildControl(Panel_Window_CrewName_All, "Button_Close_PCUI")
  self._ui.stc_nameBg = UI.getChildControl(Panel_Window_CrewName_All, "Static_NameBg")
  self._ui.edit_crewName = UI.getChildControl(self._ui.stc_nameBg, "Edit_CrewName")
  self._ui.stc_keyGuideX = UI.getChildControl(self._ui.edit_crewName, "StaticText_X_ConsoleUI")
  self._ui.stc_textIcon = UI.getChildControl(self._ui.edit_crewName, "Static_TextIcon")
  self._ui.btn_checkDuplicate = UI.getChildControl(self._ui.stc_nameBg, "Button_Duplication")
  self._ui.stc_descBG = UI.getChildControl(self._ui.stc_nameBg, "StaticText_CrewBg")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descBG, "StaticText_CrewDesc")
  self._ui.btn_confirm = UI.getChildControl(Panel_Window_CrewName_All, "Button_Confirm_PCUI")
  self._ui.btn_cancel = UI.getChildControl(Panel_Window_CrewName_All, "Button_Cancel_PCUI")
  self._ui.stc_keyGuideBG = UI.getChildControl(Panel_Window_CrewName_All, "Static_BottomBg_ConsoleUI")
  self._ui.stc_KeyGuideY = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_Y_ConsoleUI")
  self._ui.stc_KeyGuideA = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuideB = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_B_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:setConsoleUI()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_CrewName_All:setConsoleUI()
  if true == self._isConsole then
    self._ui.stc_keyGuideBG:SetShow(true)
    self._ui.stc_keyGuideX:SetShow(true)
    self._ui.btn_close:SetShow(false)
    self._ui.btn_checkDuplicate:SetShow(false)
    self._ui.btn_confirm:SetShow(false)
    self._ui.btn_cancel:SetShow(false)
    self._ui.stc_textIcon:SetShow(false)
    self:setAlignKeyGuide()
    self._ui.edit_crewName:SetSize(Panel_Window_CrewName_All:GetSizeX() - 20, self._ui.edit_crewName:GetSizeY())
    self._ui.stc_keyGuideX:ComputePos()
  else
    self._ui.stc_keyGuideBG:SetShow(false)
    self._ui.stc_keyGuideX:SetShow(false)
    self._ui.btn_close:SetShow(true)
    self._ui.btn_checkDuplicate:SetShow(true)
    self._ui.btn_confirm:SetShow(true)
    self._ui.btn_cancel:SetShow(true)
    self._ui.stc_textIcon:SetShow(true)
  end
end
function PaGlobal_CrewName_All:setAlignKeyGuide()
  local keyGuides = {
    self._ui.stc_KeyGuideY,
    self._ui.stc_KeyGuideA,
    self._ui.stc_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_CrewName_All:setDesc()
  if nil == Panel_Window_CrewName_All then
    return
  end
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
  local prevSizeY = self._ui.stc_descBG:GetSizeY()
  self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  self._ui.stc_descBG:SetSize(self._ui.stc_descBG:GetSizeX(), self._ui.txt_desc:GetTextSizeY() + 20)
  local changeSizeY = self._ui.stc_descBG:GetSizeY() - prevSizeY
  self._ui.stc_nameBg:SetSize(self._ui.stc_nameBg:GetSizeX(), self._ui.stc_nameBg:GetSizeY() + changeSizeY)
  Panel_Window_CrewName_All:SetSize(Panel_Window_CrewName_All:GetSizeX(), Panel_Window_CrewName_All:GetSizeY() + changeSizeY)
  FromClient_CrewName_All_Resize()
end
function PaGlobal_CrewName_All:registEventHandler()
  if nil == Panel_Window_CrewName_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_CrewName_All_Resize")
  registerEvent("FromClient_notifyChangeNameResult", "FromClient_CrewName_All_NotifyChangeNameResult")
  registerEvent("FromClient_ResponseCreateCrew", "FromClient_CrewName_All_ResponseCreateCrew")
  if true == self._isConsole then
    Panel_Window_CrewName_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_CrewName_All_ClickedConfirm()")
    Panel_Window_CrewName_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_CrewName_All_SetFocus()")
    Panel_Window_CrewName_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_CrewName_All_CheckDuplication()")
    self._ui.edit_crewName:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_CrewName_All_VirtualKeyBoardEnd")
  else
    self._ui.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_CrewName_All_ClickedConfirm()")
    self._ui.btn_cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewName_All_Close()")
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewName_All_Close()")
    self._ui.btn_checkDuplicate:addInputEvent("Mouse_LUp", "HandleEventLUp_CrewName_All_CheckDuplication()")
  end
end
function PaGlobal_CrewName_All:prepareOpen()
  if nil == Panel_Window_CrewName_All then
    return
  end
  if false == _ContentsGroup_CrewMatch then
    return
  end
  if true == Panel_Window_CrewName_All:GetShow() then
    return
  end
  local crewWrapper = ToClient_GetMyCrewInfoWrapper()
  if nil ~= crewWrapper then
    return
  end
  if nil == PaGlobal_ChangeNickName_All_CheckAndOpenQuickNameChange then
    return
  end
  local isAppliedNickNameChange = PaGlobal_ChangeNickName_All_CheckAndOpenQuickNameChange()
  if false == isAppliedNickNameChange then
    return
  end
  self._isValidCrewName = false
  self._ui.edit_crewName:SetEditText("")
  self._ui.edit_crewName:SetMaxInput(getGameServiceTypeGuildNameLength())
  self:setDesc()
  PaGlobal_CrewName_All:open()
end
function PaGlobal_CrewName_All:open()
  if nil == Panel_Window_CrewName_All then
    return
  end
  Panel_Window_CrewName_All:SetShow(true)
end
function PaGlobal_CrewName_All:prepareClose()
  if nil == Panel_Window_CrewName_All then
    return
  end
  if false == Panel_Window_CrewName_All:GetShow() then
    return
  end
  PaGlobal_CrewName_All:close()
end
function PaGlobal_CrewName_All:close()
  if nil == Panel_Window_CrewName_All then
    return
  end
  Panel_Window_CrewName_All:SetShow(false)
end
function PaGlobal_CrewName_All:validate()
  if nil == Panel_Window_CrewName_All then
    return
  end
  self._ui.btn_close:isValidate()
  self._ui.stc_nameBg:isValidate()
  self._ui.edit_crewName:isValidate()
  self._ui.btn_checkDuplicate:isValidate()
  self._ui.stc_descBG:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.btn_confirm:isValidate()
  self._ui.btn_cancel:isValidate()
  self._ui.stc_keyGuideBG:isValidate()
  self._ui.stc_KeyGuideY:isValidate()
  self._ui.stc_KeyGuideA:isValidate()
  self._ui.stc_KeyGuideB:isValidate()
end
