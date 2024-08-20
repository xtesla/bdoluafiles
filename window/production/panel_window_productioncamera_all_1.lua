function PaGlobal_ProductionCamera_All:initailze()
  if true == PaGlobal_ProductionCamera_All._initialize then
    return
  end
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_Production
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, PaGlobalFunc_ProductionCamera_Close)
  self._ui.stc_TitleBg = UI.getChildControl(Panel_Window_ProductionCamera_All, "Static_TitleBg")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_TitleBg, "Static_Text_Title_Import")
  self._ui.stc_SubBg = UI.getChildControl(Panel_Window_ProductionCamera_All, "Static_SubFrame")
  self._ui.edit_GroupName = UI.getChildControl(self._ui.stc_SubBg, "Edit_GroupName")
  self._ui.btn_Confirm = UI.getChildControl(self._ui.stc_SubBg, "Button_Confirm")
  self._ui.btn_Cancel = UI.getChildControl(self._ui.stc_SubBg, "Button_Cancel")
  PaGlobal_ProductionCamera_All:validate()
  PaGlobal_ProductionCamera_All:registEventHandler()
  PaGlobal_ProductionCamera_All._initialize = true
end
function PaGlobal_ProductionCamera_All:validate()
  if true == PaGlobal_ProductionCamera_All._initialize then
    return
  end
  self._ui.stc_TitleBg:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.stc_SubBg:isValidate()
  self._ui.btn_Confirm:isValidate()
  self._ui.btn_Cancel:isValidate()
  self._ui.edit_GroupName:isValidate()
end
function PaGlobal_ProductionCamera_All:registEventHandler()
  registerEvent("onScreenResize", "FromClient_ProductionCamera_OnScreenResize")
  registerEvent("FromClient_ProductionCamera_GroupOpen", "FromClient_ProductionCamera_GroupOpen()")
  registerEvent("FromClient_ChangeProductionMode", "FromClient_ChangeProductionMode()")
  self._ui.edit_GroupName:addInputEvent("Mouse_LUp", "HandleEventLUp_ProductionCamera_ClearEdit()")
  self._ui.btn_Confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_ProductionCamera_OpenCameraInfo()")
  self._ui.btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_ProductionCamera_Close()")
end
function PaGlobal_ProductionCamera_All:prepareOpen()
  self._ui.edit_GroupName:SetEditText("CameraVertextTest")
  SetFocusEdit(PaGlobal_ProductionCamera_All._ui.edit_GroupName)
  PaGlobal_ProductionCamera_All:open()
  FromClient_ProductionCamera_OnScreenResize()
end
function PaGlobal_ProductionCamera_All:open()
  Panel_Window_ProductionCamera_All:SetShow(true)
end
function PaGlobal_ProductionCamera_All:prepareClose()
  self._ui.edit_GroupName:SetEditText("")
  ClearFocusEdit()
  PaGlobal_ProductionCamera_All:close()
end
function PaGlobal_ProductionCamera_All:close()
  Panel_Window_ProductionCamera_All:SetShow(false)
end
