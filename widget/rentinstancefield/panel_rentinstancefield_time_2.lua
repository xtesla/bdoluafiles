function PaGlobal_RentInstanceField_Time_UpdatePerFrame(deltaTime)
  local self = PaGlobal_RentInstanceField_Time
  self._toTime = self._toTime + deltaTime
  if self._toTime - self._fromTime < 1 then
    return
  end
  self._fromTime = self._toTime
  self._ui._txt_remainTime:SetText(convertStringFromDatetimeAll(ToClient_getInstanceFieldRemainTime()))
end
function PaGlobal_RentInstanceField_Time_Open()
  PaGlobal_RentInstanceField_Time:prepareOpen()
end
