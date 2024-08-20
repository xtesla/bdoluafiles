function PaGlobal_WorkerManagerChangeName_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_blockBg = UI.getChildControl(Panel_Window_WorkerManagerChangeName_All, "Static_BlockBg")
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_WorkerManagerChangeName_All, "Static_TitleBg")
  self._ui.stc_subFrame = UI.getChildControl(Panel_Window_WorkerManagerChangeName_All, "Static_SubFrame")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui.edit_nickname = UI.getChildControl(Panel_Window_WorkerManagerChangeName_All, "Edit_Nickname")
  self._ui.btn_apply = UI.getChildControl(Panel_Window_WorkerManagerChangeName_All, "Button_Apply_PCUI")
  self._ui.btn_reset = UI.getChildControl(Panel_Window_WorkerManagerChangeName_All, "Button_Cancel_PCUI")
  self._ui.stc_descBg = UI.getChildControl(Panel_Window_WorkerManagerChangeName_All, "Static_DescBG")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descBg, "StaticText_ChangeNameDesc")
  self._ui.stc_keyGuideBg = UI.getChildControl(Panel_Window_WorkerManagerChangeName_All, "Static_BottomBg_ConsoleUI")
  self._ui.stc_keyGuideY = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  self._ui.stc_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_A_ConsoleUI")
  self._ui.stc_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_B_ConsoleUI")
  self._ui.stc_keyGuideX = UI.getChildControl(self._ui.edit_nickname, "Static_X_ConsoleUI")
  self._ui.edit_nickname:SetMaxInput(getGameServiceTypeServantNameLength())
  Panel_Window_WorkerManagerChangeName_All:ignorePadSnapMoveToOtherPanel()
  self:setConsoleUI()
  self:setPanelSize()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_WorkerManagerChangeName_All:setPanelSize()
  local gap = 10
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
  self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  self._ui.stc_descBg:SetSize(self._ui.stc_descBg:GetSizeX(), self._ui.txt_desc:GetTextSizeY() + gap)
  local modifySizeY = self._ui.btn_apply:GetSizeY() + gap
  local panelDefaultSizeY = self._ui.stc_titleBg:GetSizeY() + self._ui.edit_nickname:GetSizeY() + gap * 2
  local panelSizeY = panelDefaultSizeY
  if true == self._isConsole then
    panelSizeY = panelDefaultSizeY + self._ui.stc_descBg:GetSizeY() + gap
  else
    panelSizeY = panelDefaultSizeY + self._ui.stc_descBg:GetSizeY() + modifySizeY + gap
  end
  Panel_Window_WorkerManagerChangeName_All:SetSize(Panel_Window_WorkerManagerChangeName_All:GetSizeX(), panelSizeY)
  self._ui.stc_subFrame:SetSize(self._ui.stc_subFrame:GetSizeX(), panelSizeY - self._ui.stc_titleBg:GetSizeY())
  self._ui.stc_descBg:ComputePos()
  self._ui.stc_keyGuideBg:ComputePos()
end
function PaGlobal_WorkerManagerChangeName_All:setConsoleUI()
  if nil == Panel_Window_WorkerManagerChangeName_All then
    return
  end
  if true == self._isConsole then
    self._ui.btn_close:SetShow(false)
    self._ui.btn_apply:SetShow(false)
    self._ui.btn_reset:SetShow(false)
    self._ui.stc_keyGuideX:SetShow(true)
    self._ui.stc_keyGuideBg:SetShow(true)
    self:alignKeyGuide()
  else
    self._ui.btn_close:SetShow(true)
    self._ui.btn_apply:SetShow(true)
    self._ui.btn_reset:SetShow(true)
    self._ui.stc_keyGuideBg:SetShow(false)
  end
end
function PaGlobal_WorkerManagerChangeName_All:alignKeyGuide()
  local keyGuideTable = {
    self._ui.stc_keyGuideY,
    self._ui.stc_keyGuideA,
    self._ui.stc_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideTable, self._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_WorkerManagerChangeName_All:registEventHandler()
  if nil == Panel_Window_WorkerManagerChangeName_All then
    return
  end
  registerEvent("onScreenResize", "PaGlobalFunc_WorkerManagerChangeName_All_Resize")
  registerEvent("FromClient_WorkerNameChangeSuccess", "FromClient_WorkerManagerChangeName_All_ChangeSuccess")
  registerEvent("FromClient_WorkerNameResetSuccess", "FromClient_WorkerManagerChangeName_All_ResetSuccess")
  if true == self._isConsole then
    Panel_Window_WorkerManagerChangeName_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_WorkerManagerChangeName_All_SetFocusEdit()")
    Panel_Window_WorkerManagerChangeName_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_WorkerManagerChangeName_All_Reset()")
    Panel_Window_WorkerManagerChangeName_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerManagerChangeName_All_Apply()")
    self._ui.edit_nickname:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_WorkerManagerChangeName_All_KeyBoardEnd")
  else
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorkerManagerChangeName_All_Close()")
    self._ui.edit_nickname:RegistReturnKeyEvent("HandleEventLUp_WorkerManagerChangeName_All_Apply()")
    self._ui.edit_nickname:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManagerChangeName_All_SetFocusEdit()")
    self._ui.btn_apply:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManagerChangeName_All_Apply()")
    self._ui.btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerManagerChangeName_All_Reset()")
  end
end
function PaGlobal_WorkerManagerChangeName_All:prepareOpen(workerIdx)
  if nil == Panel_Window_WorkerManagerChangeName_All then
    return
  end
  if nil == workerIdx then
    return
  end
  self._currentWorkerIdx = workerIdx
  self._ui.edit_nickname:SetEditText("")
  self:resize()
  self:open()
end
function PaGlobal_WorkerManagerChangeName_All:open()
  if nil == Panel_Window_WorkerManagerChangeName_All then
    return
  end
  Panel_Window_WorkerManagerChangeName_All:SetShow(true)
end
function PaGlobal_WorkerManagerChangeName_All:prepareClose()
  if nil == Panel_Window_WorkerManagerChangeName_All then
    return
  end
  self._currentWorkerIdx = nil
  self:close()
end
function PaGlobal_WorkerManagerChangeName_All:close()
  if nil == Panel_Window_WorkerManagerChangeName_All then
    return
  end
  Panel_Window_WorkerManagerChangeName_All:SetShow(false)
end
function PaGlobal_WorkerManagerChangeName_All:resize()
  self:setPanelSize()
  Panel_Window_WorkerManagerChangeName_All:ComputePos()
  self._ui.stc_blockBg:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  self._ui.stc_blockBg:ComputePos()
end
function PaGlobal_WorkerManagerChangeName_All:validate()
  if nil == Panel_Window_WorkerManagerChangeName_All then
    return
  end
  self._ui.stc_blockBg:isValidate()
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_subFrame:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.edit_nickname:isValidate()
  self._ui.btn_apply:isValidate()
  self._ui.btn_reset:isValidate()
  self._ui.stc_descBg:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.stc_keyGuideBg:isValidate()
  self._ui.stc_keyGuideY:isValidate()
  self._ui.stc_keyGuideA:isValidate()
  self._ui.stc_keyGuideB:isValidate()
  self._ui.stc_keyGuideX:isValidate()
end
