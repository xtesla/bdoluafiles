function PaGlobalFunc_ProductionCamera_Open()
  if nil == Panel_Window_ProductionCamera_All then
    return
  end
  PaGlobal_ProductionCamera_All:prepareOpen()
end
function PaGlobalFunc_ProductionCamera_Close()
  if nil == Panel_Window_ProductionCamera_All then
    return
  end
  PaGlobal_ProductionCamera_All:prepareClose()
end
function PaGlobalFunc_ProductionCamera_Close_Temp()
end
function HandleEventLUp_ProductionCamera_ClearEdit()
  if false == Panel_Window_ProductionCamera_All:GetShow() then
    return
  end
  local self = PaGlobal_ProductionCamera_All
  self._ui.edit_GroupName:SetEditText("")
  self._ui.edit_GroupName:SetText("")
  SetFocusEdit(PaGlobal_ProductionCamera_All._ui.edit_GroupName)
end
function HandleEventLUp_ProductionCamera_OpenCameraInfo()
  if false == Panel_Window_ProductionCamera_All:GetShow() then
    return
  end
  local self = PaGlobal_ProductionCamera_All
  local groupName = self._ui.edit_GroupName:GetEditText()
  ToClient_groupCameraInfoOpen(groupName)
  PaGlobal_ProductionModify_ChangeCurrentCameraGroupName(groupName)
  PaGlobalFunc_ProductionCamera_Close()
end
function HandleEventLUp_ProductionCamera_Close()
  if false == Panel_Window_ProductionCamera_All:GetShow() then
    return
  end
  PaGlobal_ProductionCamera_All:prepareClose()
end
function FromClient_ChangeProductionMode(isEnter)
  if nil == isEnter then
    return
  end
  local self = PaGlobal_ProductionCamera_All
  if true == isEnter then
    SetUIMode(Defines.UIMode.eUIMode_ProductionModify)
    self._renderMode:set()
  else
    SetUIMode(Defines.UIMode.eUIMode_Default)
    self._renderMode:reset()
  end
end
function FromClient_ProductionCamera_GroupOpen()
  if nil == Panel_Window_ProductionCamera_All then
    return
  end
  PaGlobal_ProductionCamera_All:prepareOpen()
end
function FromClient_ProductionCamera_OnScreenResize()
  if false == Panel_Window_ProductionCamera_All:GetShow() then
    return
  end
  PaGlobal_ProductionCamera_All._ui.stc_TitleBg:ComputePos()
  PaGlobal_ProductionCamera_All._ui.txt_Title:ComputePos()
  PaGlobal_ProductionCamera_All._ui.stc_SubBg:ComputePos()
  PaGlobal_ProductionCamera_All._ui.btn_Confirm:ComputePos()
  PaGlobal_ProductionCamera_All._ui.btn_Cancel:ComputePos()
  PaGlobal_ProductionCamera_All._ui.edit_GroupName:ComputePos()
end
