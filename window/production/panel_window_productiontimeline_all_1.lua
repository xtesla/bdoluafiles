function PaGlobal_ProductionTimeline:initialize()
  if true == PaGlobal_ProductionTimeline._initialize then
    return
  end
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_Production
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, PaGlobal_ProductionTimeline_Close)
  self._ui.stc_panelBG = UI.getChildControl(Panel_Window_ProductionTimeline_All, "Static_PanelBG")
  self._ui.txt_title = UI.getChildControl(Panel_Window_ProductionTimeline_All, "Static_TitleArea")
  self._ui.check_popup = UI.getChildControl(self._ui.txt_title, "CheckButton_PopUp")
  self._ui.btn_close = UI.getChildControl(self._ui.txt_title, "Button_Replay_Close")
  self._ui.check_popup:SetCheck(false)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ProductionTimeline:registEventHandler()
  if nil == Panel_Window_ProductionTimeline_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_ProductionTimeline_ReSizePanel")
  self._ui.check_popup:addInputEvent("Mouse_LUp", "HandleEventLUp_ProductionTimeline_All_CheckPopupUI()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ProductionTimeline:prepareClose()")
end
function PaGlobal_ProductionTimeline:prepareOpen()
  if nil == Panel_Window_ProductionTimeline_All then
    return
  end
  Panel_Window_ProductionTimeline_All:SetIgnore(false)
  PaGlobal_ProductionTimeline:open()
end
function PaGlobal_ProductionTimeline:open()
  if nil == Panel_Window_ProductionTimeline_All then
    return
  end
  Panel_Window_ProductionTimeline_All:SetShow(true)
end
function PaGlobal_ProductionTimeline:prepareClose()
  if nil == Panel_Window_ProductionTimeline_All then
    return
  end
  ToClient_groupCameraInfoClose()
  Panel_Window_ProductionTimeline_All:SetIgnore(true)
  PaGlobal_ProductionTimeline:close()
end
function PaGlobal_ProductionTimeline:close()
  if nil == Panel_Window_ProductionTimeline_All then
    return
  end
  Panel_Window_ProductionTimeline_All:SetShow(false)
end
function PaGlobal_ProductionTimeline:update()
  if nil == Panel_Window_ProductionTimeline_All then
    return
  end
end
function PaGlobal_ProductionTimeline:validate()
  if nil == Panel_Window_ProductionTimeline_All then
    return
  end
  self._ui.stc_panelBG:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.check_popup:isValidate()
  self._ui.btn_close:isValidate()
end
function HandleEventLUp_ProductionTimeline_All_CheckPopupUI()
  if nil == Panel_Window_ProductionTimeline_All then
    return
  end
  if true == PaGlobal_ProductionTimeline._ui.check_popup:IsCheck() then
    Panel_Window_ProductionTimeline_All:OpenUISubApp()
  else
    Panel_Window_ProductionTimeline_All:CloseUISubApp()
  end
end
