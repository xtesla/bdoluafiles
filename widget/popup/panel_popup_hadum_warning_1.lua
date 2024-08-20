function PaGlobal_Popup_HadumWarning:initialize()
  if true == PaGlobal_Popup_HadumWarning._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.btn_Yes = UI.getChildControl(Panel_Popup_Hadum_Warning, "Button_Yes")
  self._ui.btn_No = UI.getChildControl(Panel_Popup_Hadum_Warning, "Button_No")
  local stc_InfoArea = UI.getChildControl(Panel_Popup_Hadum_Warning, "Static_InfoArea")
  local txt_Info = UI.getChildControl(stc_InfoArea, "MultilineText_InfoDesc")
  local panelSizeY = Panel_Popup_Hadum_Warning:GetSizeY() - stc_InfoArea:GetSizeY()
  txt_Info:SetTextMode(__eTextMode_AutoWrap)
  txt_Info:SetText(txt_Info:GetText())
  txt_Info:SetSize(txt_Info:GetSizeX(), txt_Info:GetTextSizeY())
  stc_InfoArea:SetSize(stc_InfoArea:GetSizeX(), txt_Info:GetSizeY() + 10)
  panelSizeY = panelSizeY + stc_InfoArea:GetSizeY()
  Panel_Popup_Hadum_Warning:SetSize(Panel_Popup_Hadum_Warning:GetSizeX(), panelSizeY)
  stc_InfoArea:ComputePos()
  txt_Info:ComputePos()
  self._ui.btn_Yes:ComputePos()
  self._ui.btn_No:ComputePos()
  Panel_Popup_Hadum_Warning:ComputePos()
  PaGlobal_Popup_HadumWarning:registEventHandler()
  PaGlobal_Popup_HadumWarning:validate()
  PaGlobal_Popup_HadumWarning._initialize = true
end
function PaGlobal_Popup_HadumWarning:registEventHandler()
  if nil == Panel_Popup_Hadum_Warning then
    return
  end
  self._ui.btn_Yes:addInputEvent("Mouse_LUp", "HandleEventLUp_HadumWarning_EnterServer()")
  self._ui.btn_No:addInputEvent("Mouse_LUp", "PaGlobal_Popup_HadumWarning_Close()")
  if true == self._isConsole then
    Panel_Popup_Hadum_Warning:ignorePadSnapMoveToOtherPanel()
  end
end
function PaGlobal_Popup_HadumWarning:prepareOpen()
  if nil == Panel_Popup_Hadum_Warning then
    return
  end
  PaGlobal_Popup_HadumWarning:open()
end
function PaGlobal_Popup_HadumWarning:open()
  if nil == Panel_Popup_Hadum_Warning then
    return
  end
  Panel_Popup_Hadum_Warning:SetShow(true)
end
function PaGlobal_Popup_HadumWarning:prepareClose()
  if nil == Panel_Popup_Hadum_Warning then
    return
  end
  PaGlobal_Popup_HadumWarning:close()
end
function PaGlobal_Popup_HadumWarning:close()
  if nil == Panel_Popup_Hadum_Warning then
    return
  end
  Panel_Popup_Hadum_Warning:SetShow(false)
end
function PaGlobal_Popup_HadumWarning:update()
  if nil == Panel_Popup_Hadum_Warning then
    return
  end
end
function PaGlobal_Popup_HadumWarning:validate()
  if nil == Panel_Popup_Hadum_Warning then
    return
  end
  self._ui.btn_Yes:isValidate()
  self._ui.btn_No:isValidate()
end
