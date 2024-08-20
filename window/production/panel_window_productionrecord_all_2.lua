function PaGlobalFunc_ProductionRecord_Open()
  if nil == Panel_Window_ProductionRecord_All then
    return
  end
  PaGlobal_ProductionRecord_All:prepareOpen()
end
function PaGlobalFunc_ProductionRecord_Close()
  if nil == Panel_Window_ProductionRecord_All then
    return
  end
  PaGlobal_ProductionRecord_All:prepareClose()
end
function PaGlobalFunc_ProductionRecord_ChangeReplayName(replayName)
  if nil == Panel_Window_ProductionRecord_All then
    return
  end
  PaGlobal_ProductionRecord_All:changeReplayName(replayName)
end
function HandleEventLUp_ProductionRecord_EndRecord()
  if false == Panel_Window_ProductionRecord_All:GetShow() then
    return
  end
  ToClient_requestStopRecordReplay()
  PaGlobal_ProductionRecord_All:prepareClose()
end
function HandleEventLUp_ProductionRecord_Close()
  if false == Panel_Window_ProductionRecord_All:GetShow() then
    return
  end
  PaGlobal_ProductionRecord_All:prepareClose()
end
function FromClient_ProductionRecord_OnScreenResize()
  if false == Panel_Window_ProductionRecord_All:GetShow() then
    return
  end
  PaGlobal_ProductionRecord_All._ui.btn_close:ComputePos()
  PaGlobal_ProductionRecord_All._ui.txt_recordName:ComputePos()
  PaGlobal_ProductionRecord_All._ui.txt_recordLength:ComputePos()
  PaGlobal_ProductionRecord_All._ui.btn_endRecord:ComputePos()
end
function FromClient_ProductionRecord_ChangeReplayLength(replayLength)
  if false == Panel_Window_ProductionRecord_All:GetShow() then
    return
  end
  PaGlobal_ProductionRecord_All:changeReplayLength(replayLength)
end
