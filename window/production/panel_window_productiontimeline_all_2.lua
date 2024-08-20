function PaGlobal_ProductionTimeline_Open()
  if nil == PaGlobal_ProductionTimeline then
    return
  end
  PaGlobal_ProductionTimeline:prepareOpen()
end
function PaGlobal_ProductionTimeline_Close()
  if nil == PaGlobal_ProductionTimeline then
    return
  end
  PaGlobal_ProductionTimeline:prepareClose()
end
function PaGlobal_ProductionTimeline_ShowAni()
  if nil == Panel_Window_ProductionTimeline_All then
    return
  end
end
function PaGlobal_ProductionTimeline_HideAni()
  if nil == Panel_Window_ProductionTimeline_All then
    return
  end
end
function FromClient_ProductionTimeline_ReSizePanel()
  PaGlobal_ProductionTimeline._ui.stc_panelBG:ComputePos()
  PaGlobal_ProductionTimeline._ui.txt_title:ComputePos()
  PaGlobal_ProductionTimeline._ui.check_popup:ComputePos()
  PaGlobal_ProductionTimeline._ui.btn_close:ComputePos()
end
