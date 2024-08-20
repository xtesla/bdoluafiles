function FromClient_startCutSceneGroupCamera()
  local self = PaGlobal_CutSceneScript
  self:prepareOpen()
end
function PaGlobalFunc_CutSceneScript_Awake()
end
function PaGlobal_CutSceneScript_UpdatePerFrame(deltaTime)
  local self = PaGlobal_CutSceneScript
  local diffTick = getTickCount32() - self._tickCount
  local scriptWrapper = ToClient_groupCameraScriptWrapper(self._scriptCurrentIdx)
  local stopUpdate = false
  if nil ~= scriptWrapper then
    if diffTick > scriptWrapper:getTickCount() then
      local txt_desc = scriptWrapper:getDescription()
      local txt_audioFileName = scriptWrapper:getAudioFileName()
      self._ui._txt_desc:SetText(txt_desc)
      ToClient_startDialogVoice(txt_audioFileName)
      self._scriptCurrentIdx = self._scriptCurrentIdx + 1
    end
  else
    stopUpdate = true
  end
  if true == stopUpdate then
    Panel_Window_CutSceneScript:ClearUpdateLuaFunc()
  end
end
