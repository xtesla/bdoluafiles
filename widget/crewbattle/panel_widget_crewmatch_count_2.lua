function FromClient_SA_Widget_Count_ReSizePanel()
  Panel_Widget_CrewMatch_Count:ComputePos()
  for ii = 1, 10 do
    PaGlobal_Widget_CrewMatch_Count._ui.stc_count[ii]:ComputePos()
  end
end
function PaGlobal_Widget_CrewMatch_StartCount(countTime)
  if nil == Panel_Widget_CrewMatch_Count then
    return
  end
  local self = PaGlobal_Widget_CrewMatch_Count
  if nil == countTime then
    self:prepareClose()
    return
  end
  for ii = 1, 10 do
    self._ui.stc_count[ii]:SetShow(false)
  end
  self._currentCount = countTime + 1
  self._updateCurrentTime = 0
  Panel_Widget_CrewMatch_Count:RegisterUpdateFunc("PaGlobal_Widget_CrewMatch_UpdatePerFrame")
  self:prepareOpen()
end
function PaGlobal_Widget_CrewMatch_UpdatePerFrame(deltaTime)
  if nil == Panel_Widget_CrewMatch_Count then
    return
  end
  if false == Panel_Widget_CrewMatch_Count:GetShow() then
    return
  end
  local self = PaGlobal_Widget_CrewMatch_Count
  self._updateCurrentTime = self._updateCurrentTime + deltaTime
  if self._updateCurrentTime < 1 then
    return
  end
  self._updateCurrentTime = 0
  local current = self._currentCount - 1
  if current <= 10 and current ~= self._currentCount then
    self._currentCount = current
    self:showCount(self._currentCount)
  end
  if 0 >= self._currentCount then
    self._currentCount = 0
    Panel_Widget_CrewMatch_Count:ClearUpdateLuaFunc()
    self:prepareClose()
    return
  end
end
