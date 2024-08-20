PaGlobal_HorseRacing_CountDown = {
  _ui = {
    stc_CountNumTable = {},
    stc_Go = nil,
    stc_GaugeBg = nil,
    stc_Gauge = nil
  },
  _eTOTALCOUNT = 10,
  _isConsole = false,
  _initialize = false,
  _currentTime = 1,
  _currentNumber = 10
}
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseRacing_CountDown_Init")
function FromClient_HorseRacing_CountDown_Init()
  PaGlobal_HorseRacing_CountDown:initialize()
end
function PaGlobal_HorseRacing_CountDown:initialize()
  if true == PaGlobal_HorseRacing_CountDown._initialize or nil == Panel_HorseRacing_CountDown then
    return
  end
  self._ui.stc_GaugeBg = UI.getChildControl(Panel_HorseRacing_CountDown, "Static_GaugeBG")
  self._ui.stc_CountNumTable = Array.new()
  local stc_Num = UI.getChildControl(self._ui.stc_GaugeBg, "Static_Num")
  for idx = 1, self._eTOTALCOUNT - 1 do
    local stcCount = UI.getChildControl(stc_Num, "Static_Num0" .. tostring(idx))
    if nil ~= stcCount then
      stcCount:SetShow(false)
      self._ui.stc_CountNumTable:push_back(stcCount)
    end
  end
  local stcCount = UI.getChildControl(stc_Num, "Static_Num10")
  self._ui.stc_CountNumTable:push_back(stcCount)
  self._ui.stc_Gauge = UI.getChildControl(self._ui.stc_GaugeBg, "CircularProgress_Gauge")
  self._ui.stc_Go = UI.getChildControl(stc_Num, "Static_GO")
  self._isConsole = _ContentsGroup_RenewUI
  PaGlobal_HorseRacing_CountDown:validate()
  PaGlobal_HorseRacing_CountDown:registEventHandler()
  Panel_HorseRacing_CountDown._initialize = true
end
function PaGlobal_HorseRacing_CountDown:registEventHandler()
  if nil == Panel_HorseRacing_CountDown then
    return
  end
  registerEvent("FromClient_HorseRacing_UpdateAck", "FromClient_HorseRacing_CountDown_Update")
end
function PaGlobal_HorseRacing_CountDown:clear()
  self._currentNumber = 10
  self._currentTime = 1
  self._ui.stc_Go:SetShow(false)
  PaGlobal_HorseRacing_CountDown:showNum(10, true)
  PaGlobal_HorseRacing_CountDown:setProgress(100)
end
function PaGlobal_HorseRacing_CountDown:prepareOpen()
  if nil == Panel_HorseRacing_CountDown then
    return
  end
  PaGlobal_HorseRacing_CountDown:open()
  PaGlobal_HorseRacing_CountDown:clear()
  Panel_HorseRacing_CountDown:ComputePos()
end
function PaGlobal_HorseRacing_CountDown:open()
  if nil == Panel_HorseRacing_CountDown then
    return
  end
  self._ui.stc_Gauge:SetShow(true)
  Panel_HorseRacing_CountDown:SetShow(true)
end
function PaGlobal_HorseRacing_CountDown:prepareClose()
  if nil == Panel_HorseRacing_CountDown then
    return
  end
  Panel_HorseRacing_CountDown:ClearUpdateLuaFunc()
  PaGlobal_HorseRacing_CountDown:close()
end
function PaGlobal_HorseRacing_CountDown:close()
  Panel_HorseRacing_CountDown:SetShow(false)
end
function PaGlobal_HorseRacing_CountDown:validate()
end
function PaGlobal_HorseRacing_CountDown:showNum(number, isShow)
  if nil == self._ui.stc_CountNumTable or nil == self._ui.stc_CountNumTable[number] then
    return
  end
  if 10 == number then
    audioPostEvent_SystemUi(17, 14)
  end
  self._ui.stc_CountNumTable[number]:SetShow(isShow)
end
function PaGlobal_HorseRacing_CountDown:setProgress(rate)
  if rate < 0 or nil == rate then
    return
  end
  self._ui.stc_Gauge:SetProgressRate(rate)
end
function FromClient_HorseRacing_CountDown_Update(state)
  if __eHorseRacing_Play == state then
    PaGlobal_HorseRacing_CountDown:clear()
    PaGlobal_HorseRacing_CountDown:prepareOpen()
    Panel_HorseRacing_CountDown:RegisterUpdateFunc("PaGlobalFunc_HorseRacing_CountDown_UpdatePerFrame")
  end
end
function PaGlobalFunc_HorseRacing_CountDown_UpdatePerFrame(deltaTime)
  if nil == Panel_HorseRacing_CountDown or false == Panel_HorseRacing_CountDown:GetShow() then
    return
  end
  local self = PaGlobal_HorseRacing_CountDown
  self._currentTime = self._currentTime - deltaTime
  PaGlobal_HorseRacing_CountDown:setProgress(self._currentTime * 100)
  if self._currentTime <= 0 then
    PaGlobal_HorseRacing_CountDown:showNum(self._currentNumber, false)
    self._currentNumber = self._currentNumber - 1
    PaGlobal_HorseRacing_CountDown:showNum(self._currentNumber, true)
    PaGlobal_HorseRacing_CountDown:setProgress(100)
    if true == self._ui.stc_Go:GetShow() then
      PaGlobal_HorseRacing_CountDown:prepareClose()
    end
    if 0 >= self._currentNumber then
      self._ui.stc_Go:SetShow(true)
      self._ui.stc_Gauge:SetShow(false)
    end
    self._currentTime = 1
  end
end
