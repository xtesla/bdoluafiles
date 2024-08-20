function PaGlobal_CreateCrew_All:initialize()
  if true == PaGlobal_CreateCrew_All._initialize then
    return
  end
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_CreateCrew_All, "StaticText_Title")
  self._ui.btn_question = UI.getChildControl(self._ui.stc_titleBG, "Button_Question_PCUI")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Close_PCUI")
  self._ui.stc_descBG = UI.getChildControl(Panel_Window_CreateCrew_All, "StaticText_SelectedTypeDescBG")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descBG, "StaticText_SelectedTypeDesc")
  self._ui.btn_confirm = UI.getChildControl(Panel_Window_CreateCrew_All, "Button_Confirm")
  self._ui.stc_keyGuideBG = UI.getChildControl(Panel_Window_CreateCrew_All, "Static_BottomBg_ConsoleUI")
  self._ui.stc_KeyGuideA = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_Create_ConsoleUI")
  self._ui.stc_KeyGuideB = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_Close_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:setConsoleUI()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_CreateCrew_All:setConsoleUI()
  if true == self._isConsole then
    self._ui.stc_keyGuideBG:SetShow(true)
    self._ui.btn_close:SetShow(false)
    self._ui.btn_confirm:SetShow(false)
    self:setAlignKeyGuide()
  else
    self._ui.stc_keyGuideBG:SetShow(false)
    self._ui.btn_close:SetShow(true)
    self._ui.btn_confirm:SetShow(true)
  end
  self._ui.btn_question:SetShow(false)
end
function PaGlobal_CreateCrew_All:setAlignKeyGuide()
  local keyGuides = {
    self._ui.stc_KeyGuideA,
    self._ui.stc_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_CreateCrew_All:setDesc()
  if nil == Panel_Window_CreateCrew_All then
    return
  end
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
  local prevSizeY = self._ui.stc_descBG:GetSizeY()
  self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  self._ui.stc_descBG:SetSize(self._ui.stc_descBG:GetSizeX(), self._ui.txt_desc:GetTextSizeY() + 20)
  local changeSizeY = self._ui.stc_descBG:GetSizeY() - prevSizeY
  Panel_Window_CreateCrew_All:SetSize(Panel_Window_CreateCrew_All:GetSizeX(), Panel_Window_CreateCrew_All:GetSizeY() + changeSizeY)
  FromClient_CreateCrew_All_Resize()
end
function PaGlobal_CreateCrew_All:registEventHandler()
  if nil == Panel_Window_CreateCrew_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_CreateCrew_All_Resize")
  registerEvent("FromClient_ResponseCreateCrew", "FromClient_CreateCrew_All_ResponseCreateCrew")
  if true == self._isConsole then
    Panel_Window_CreateCrew_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_CreateCrew_All_OpenCrewName()")
  else
    self._ui.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_CreateCrew_All_OpenCrewName()")
    self._ui.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelClan\" )")
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_CreateCrew_All_Close()")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui.btn_question, "\"PanelClan\"")
  end
end
function PaGlobal_CreateCrew_All:prepareOpen()
  if nil == Panel_Window_CreateCrew_All then
    return
  end
  if false == _ContentsGroup_CrewMatch then
    return
  end
  if true == Panel_Window_CreateCrew_All:GetShow() then
    return
  end
  local crewWrapper = ToClient_GetMyCrewInfoWrapper()
  if nil ~= crewWrapper then
    if true == self._isConsole then
      self._ui.stc_KeyGuideA:SetShow(false)
      self:setAlignKeyGuide()
      Panel_Window_CreateCrew_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    else
      self._ui.btn_confirm:SetMonoTone(true)
      self._ui.btn_confirm:SetEnable(false)
    end
  elseif true == self._isConsole then
    self._ui.stc_KeyGuideA:SetShow(true)
    self:setAlignKeyGuide()
    Panel_Window_CreateCrew_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_CreateCrew_All_OpenCrewName()")
  else
    self._ui.btn_confirm:SetMonoTone(false)
    self._ui.btn_confirm:SetEnable(true)
  end
  self:setDesc()
  PaGlobal_CreateCrew_All:open()
end
function PaGlobal_CreateCrew_All:open()
  if nil == Panel_Window_CreateCrew_All then
    return
  end
  Panel_Window_CreateCrew_All:SetShow(true)
end
function PaGlobal_CreateCrew_All:prepareClose()
  if nil == Panel_Window_CreateCrew_All then
    return
  end
  if false == Panel_Window_CreateCrew_All:GetShow() then
    return
  end
  PaGlobal_CreateCrew_All:close()
end
function PaGlobal_CreateCrew_All:close()
  if nil == Panel_Window_CreateCrew_All then
    return
  end
  Panel_Window_CreateCrew_All:SetShow(false)
end
function PaGlobal_CreateCrew_All:validate()
  if nil == Panel_Window_CreateCrew_All then
    return
  end
  self._ui.btn_close:isValidate()
  self._ui.stc_titleBG:isValidate()
  self._ui.btn_question:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_descBG:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.btn_confirm:isValidate()
  self._ui.stc_keyGuideBG:isValidate()
  self._ui.stc_KeyGuideA:isValidate()
  self._ui.stc_KeyGuideB:isValidate()
end
