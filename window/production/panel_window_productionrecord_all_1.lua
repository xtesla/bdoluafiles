function PaGlobal_ProductionRecord_All:initailze()
  if true == PaGlobal_ProductionRecord_All._initialize then
    return
  end
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_Production
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, PaGlobalFunc_ProductionRecord_Close)
  local titleBg = UI.getChildControl(Panel_Window_ProductionRecord_All, "Static_TitleBg")
  self._ui.btn_close = UI.getChildControl(titleBg, "Button_Close")
  local subFrame = UI.getChildControl(Panel_Window_ProductionRecord_All, "Static_SubFrame")
  self._ui.txt_recordName = UI.getChildControl(subFrame, "StaticText_RecordName")
  self._ui.txt_recordLength = UI.getChildControl(subFrame, "StaticText_RecordLength")
  self._ui.btn_endRecord = UI.getChildControl(subFrame, "Button_EndRecord")
  PaGlobal_ProductionRecord_All:validate()
  PaGlobal_ProductionRecord_All:registEventHandler()
  PaGlobal_ProductionRecord_All._initialize = true
end
function PaGlobal_ProductionRecord_All:validate()
  if true == PaGlobal_ProductionRecord_All._initialize then
    return
  end
  self._ui.btn_close:isValidate()
  self._ui.txt_recordName:isValidate()
  self._ui.txt_recordLength:isValidate()
  self._ui.btn_endRecord:isValidate()
end
function PaGlobal_ProductionRecord_All:registEventHandler()
  registerEvent("onScreenResize", "FromClient_ProductionRecord_OnScreenResize")
  registerEvent("FromClient_LoadReplay", "FromClient_ProductionRecord_ChangeReplayLength")
  registerEvent("FromClient_CloseProductionRecrod", "PaGlobalFunc_ProductionRecord_Close")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ProductionRecord_All:prepareClose()")
  self._ui.btn_endRecord:addInputEvent("Mouse_LUp", "HandleEventLUp_ProductionRecord_EndRecord()")
end
function PaGlobal_ProductionRecord_All:prepareOpen()
  PaGlobal_ProductionRecord_All:open()
  FromClient_ProductionRecord_OnScreenResize()
end
function PaGlobal_ProductionRecord_All:open()
  Panel_Window_ProductionRecord_All:SetShow(true)
end
function PaGlobal_ProductionRecord_All:prepareClose()
  self._ui.txt_recordName:SetText("")
  PaGlobal_ProductionRecord_All:close()
end
function PaGlobal_ProductionRecord_All:close()
  Panel_Window_ProductionRecord_All:SetShow(false)
end
function PaGlobal_ProductionRecord_All:changeReplayName(replayName)
  if nil == replayName then
    return
  end
  self._ui.txt_recordName:SetText(replayName)
end
function PaGlobal_ProductionRecord_All:changeReplayLength(replayLength)
  if nil == replayLength then
    return
  end
  local convertReplayLength = Uint64toUint32(replayLength / toUint64(0, 1000))
  local length = convertSecondsToClockTime(convertReplayLength)
  self._ui.txt_recordLength:SetText(length)
end
