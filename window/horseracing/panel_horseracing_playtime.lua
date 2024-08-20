PaGlobal_HorseRacing_PlayTime = {
  _ui = {
    stc_TimeCount = nil,
    txt_Time = nil,
    stc_retireBg = nil,
    txt_retire = nil,
    txt_retireTime = nil,
    txt_lapCount = nil,
    txt_maxLapCount = nil,
    stc_lapBg = nil,
    btn_escape = nil,
    circularProgress_escapeCoolTime = nil
  },
  _currentTime = 0,
  _elapsedTime = 0,
  _retireCount = 10,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseRacing_Time_Init")
function FromClient_HorseRacing_Time_Init()
  PaGlobal_HorseRacing_PlayTime:initialize()
end
function PaGlobal_HorseRacing_PlayTime:initialize()
  self._ui.stc_TimeCount = UI.getChildControl(Panel_HorseRacing_Time, "Static_TimeCount")
  self._ui.txt_Time = UI.getChildControl(self._ui.stc_TimeCount, "StaticText_TimeCount")
  self._ui.stc_retireBg = UI.getChildControl(self._ui.stc_TimeCount, "Static_GameOverBG")
  self._ui.txt_retire = UI.getChildControl(self._ui.stc_retireBg, "StaticText_Retire")
  self._ui.txt_retireTime = UI.getChildControl(self._ui.stc_retireBg, "StaticText_CountDown")
  self._ui.stc_TimeCount:SetShow(false)
  self._ui.stc_lapBg = UI.getChildControl(Panel_HorseRacing_Time, "Static_LapArea")
  self._ui.txt_lapCount = UI.getChildControl(self._ui.stc_lapBg, "StaticText_LapNow")
  self._ui.txt_maxLapCount = UI.getChildControl(self._ui.stc_lapBg, "StaticText_LapMax")
  local stc_buttonArea = UI.getChildControl(self._ui.stc_lapBg, "Static_ButtonArea")
  self._ui.btn_escape = UI.getChildControl(stc_buttonArea, "Static_Escape_Button")
  self._ui.circularProgress_escapeCoolTime = UI.getChildControl(self._ui.btn_escape, "CircularProgress_CoolTime")
  PaGlobal_HorseRacing_PlayTime:registEventHandler()
  PaGlobal_HorseRacing_PlayTime:validate()
  PaGlobal_HorseRacing_PlayTime._initialize = true
  local state = ToClient_getHorseRacingState()
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    if false == Panel_HorseRacing_Time:GetShow() then
      PaGlobal_HorseRacing_PlayTime:prepareOpen()
    end
    FromClient_HorseRacing_PlayTime_Update(state)
  end
end
function PaGlobal_HorseRacing_PlayTime:registEventHandler()
  if nil == Panel_HorseRacing_Time then
    return
  end
  registerEvent("FromClient_HorseRacing_UpdateAck", "FromClient_HorseRacing_PlayTime_Update")
  registerEvent("FromClient_HorseRacing_UpdateRankingList", "FromClient_HorseRacing_PlayTime_Finish")
  registerEvent("onScreenResize", "FromClinet_HorseRacing_PlayTime_OnScreenResize")
  registerEvent("FromClient_ResponseHorseRaceRescueCoolTime", "FromClient_HorseRacing_PlayTime_ResponseHorseRaceRescueCoolTime")
  self._ui.btn_escape:addInputEvent("Mouse_LUp", "HandleEventLUp_HorseRacing_RequestEscape()")
end
function PaGlobal_HorseRacing_PlayTime:prepareOpen()
  if nil == Panel_HorseRacing_Time then
    return
  end
  local remainPorgress = ToClient_GetHorseRaceRescueRemainProgress()
  if remainPorgress <= 0 then
    self._ui.circularProgress_escapeCoolTime:SetProgressRate(0)
  else
    self._ui.circularProgress_escapeCoolTime:SetProgressRate(remainPorgress * 100)
  end
  self._currentTime = 0
  self._retireCount = 10
  FromClinet_HorseRacing_PlayTime_OnScreenResize()
  PaGlobal_HorseRacing_PlayTime._ui.txt_Time:SetText("00:00:00")
  PaGlobal_HorseRacing_PlayTime:open()
  Panel_HorseRacing_Time:ComputePos()
  if nil ~= Panel_HorseRacing_Waiting and Panel_HorseRacing_Waiting:GetShow() then
    PaGlobal_HorseRacing_PlayTime:prepareClose()
  end
end
function PaGlobal_HorseRacing_PlayTime:open()
  if nil == Panel_HorseRacing_Time then
    return
  end
  Panel_HorseRacing_Time:SetShow(true)
end
function PaGlobal_HorseRacing_PlayTime:prepareClose()
  if nil == Panel_HorseRacing_Time then
    return
  end
  Panel_HorseRacing_Time:ClearUpdateLuaFunc()
  PaGlobal_HorseRacing_PlayTime:close()
end
function PaGlobal_HorseRacing_PlayTime:close()
  if nil == Panel_HorseRacing_Time then
    return
  end
  Panel_HorseRacing_Time:SetShow(false)
end
function PaGlobal_HorseRacing_PlayTime:validate()
  if nil == Panel_HorseRacing_Time then
    return
  end
  self._ui.stc_TimeCount:isValidate()
  self._ui.txt_Time:isValidate()
  self._ui.stc_retireBg:isValidate()
  self._ui.txt_retire:isValidate()
  self._ui.txt_retireTime:isValidate()
  self._ui.txt_lapCount:isValidate()
  self._ui.txt_maxLapCount:isValidate()
  self._ui.btn_escape:isValidate()
  self._ui.circularProgress_escapeCoolTime:isValidate()
end
function PaGlobal_HorseRacing_PlayTime:isResultFail()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return true
  end
  local selfPlayerWrapper = selfPlayer:get()
  if nil == selfPlayerWrapper then
    return true
  end
  local userNo = selfPlayerWrapper:getUserNo()
  local curPlayerCount = ToClient_getHorseRacingRankingCount()
  for ii = 1, curPlayerCount do
    local wrapper = ToClient_getHorseRacingRankingByIndex(ii - 1)
    if nil ~= wrapper and wrapper:getUserNo() == userNo then
      local raceTimeString = wrapper:getRaceFinishTime()
      if "" ~= raceTimeString and nil ~= raceTimeString then
        return false
      end
    end
  end
  return true
end
function PaGlobal_HorseRacing_PlayTime:isResultFailAndMyFinishTime()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return true, ""
  end
  local selfPlayerWrapper = selfPlayer:get()
  if nil == selfPlayerWrapper then
    return true, ""
  end
  local userNo = selfPlayerWrapper:getUserNo()
  local curPlayerCount = ToClient_getHorseRacingRankingCount()
  for ii = 1, curPlayerCount do
    local wrapper = ToClient_getHorseRacingRankingByIndex(ii - 1)
    if nil ~= wrapper and wrapper:getUserNo() == userNo then
      local raceTimeString = wrapper:getRaceFinishTime()
      if "" ~= raceTimeString and nil ~= raceTimeString then
        return false, raceTimeString
      end
    end
  end
  return true, ""
end
function PaGlobal_HorseRacing_PlayTime_PerframeForPlay(deltaTime)
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    return
  end
  local remainPorgress = ToClient_GetHorseRaceRescueRemainProgress()
  if remainPorgress <= 0 then
    PaGlobal_HorseRacing_PlayTime._ui.circularProgress_escapeCoolTime:SetProgressRate(0)
  else
    PaGlobal_HorseRacing_PlayTime._ui.circularProgress_escapeCoolTime:SetProgressRate(remainPorgress * 100)
  end
  local self = PaGlobal_HorseRacing_PlayTime
  self._currentTime = self._currentTime + deltaTime
  local retireCount = self._retireCount - ToClient_GetHorseRacingRetrieSecond()
  if self._currentTime >= 1 then
    self._currentTime = 0
    if __eHorseRacing_GoalLinePass == ToClient_getHorseRacingState() then
      if retireCount < 0 then
        Panel_HorseRacing_Time:ClearUpdateLuaFunc()
        PaGlobal_HorseRacing_PlayTime._ui.circularProgress_escapeCoolTime:SetProgressRate(0)
        return
      else
        self._ui.txt_retireTime:SetText(retireCount)
        audioPostEvent_SystemUi(17, 15)
      end
    end
  end
  local isResultFail, finishTimeString = self:isResultFailAndMyFinishTime()
  if false == isResultFail and nil ~= finishTimeString and "" ~= finishTimeString then
    self._ui.txt_Time:SetText(finishTimeString)
    return
  end
  local currentTime = ToClient_getHorseRacingCurrentTime()
  self._ui.txt_Time:SetText(currentTime)
end
function FromClient_HorseRacing_PlayTime_Update(state)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local myUserNo = selfPlayer:get():getUserNo()
  if __eHorseRacing_GoalLinePass == state or __eHorseRacing_Play == state then
    local isResultFail = PaGlobal_HorseRacing_PlayTime:isResultFail()
    if true == isResultFail then
      Panel_HorseRacing_Time:RegisterUpdateFunc("PaGlobal_HorseRacing_PlayTime_PerframeForPlay")
    end
    PaGlobal_HorseRacing_PlayTime._ui.txt_Time:SetText("00:00:00")
    PaGlobal_HorseRacing_PlayTime._ui.stc_TimeCount:SetShow(true)
    if false == PaGlobal_HorseRacing_PlayTime._ui.stc_lapBg:GetShow() then
      for idx = 1, ToClient_getHorseRacingPlayerCount() do
        local rankingInfo = ToClient_getHorseRacingRankingByIndex(idx - 1)
        if nil ~= rankingInfo and true == rankingInfo:isDefined() then
          local isMine = myUserNo == rankingInfo:getUserNo()
          if true == isMine then
            local lapCount = rankingInfo:getLapCount()
            PaGlobalFunc_HorseRacing_PlayTime_SetMyLapCount(lapCount)
          end
        end
      end
    end
  end
  if __eHorseRacing_GoalLinePass == state then
    if false == PaGlobal_HorseRacing_PlayTime._ui.stc_retireBg:GetShow() then
      PaGlobal_HorseRacing_PlayTime._ui.stc_retireBg:SetShow(true)
    end
    PaGlobal_HorseRacing_PlayTime._ui.txt_retireTime:SetShow(true)
    local retireCount = PaGlobal_HorseRacing_PlayTime._retireCount - ToClient_GetHorseRacingRetrieSecond()
    PaGlobal_HorseRacing_PlayTime._ui.txt_retireTime:SetText(retireCount)
  end
end
function PaGlobalFunc_HorseRacing_PlayTime_SetMyLapCount(lap)
  if nil == lap or false == Panel_HorseRacing_Time:GetShow() then
    return
  end
  local state = ToClient_getHorseRacingState()
  if __eHorseRacing_GoalLinePass ~= state and __eHorseRacing_Play ~= state then
    return
  end
  local maxCount = ToClient_getHorseRacingMaxLapCount()
  if false == PaGlobal_HorseRacing_PlayTime._ui.stc_lapBg:GetShow() then
    PaGlobal_HorseRacing_PlayTime._ui.txt_lapCount:SetText(0)
    PaGlobal_HorseRacing_PlayTime._ui.stc_lapBg:SetShow(true)
    PaGlobal_HorseRacing_PlayTime._ui.txt_maxLapCount:SetText(" / " .. tostring(maxCount))
    PaGlobal_HorseRacing_PlayTime._ui.btn_escape:AddEffect("fUI_BlackSpirit_Pass_Icon_Cast_01A", false, 0, 0)
  end
  if lap >= maxCount then
    return
  end
  if lap <= 0 then
    lap = 0
  end
  PaGlobal_HorseRacing_PlayTime._ui.txt_lapCount:SetText(lap + 1)
end
function PaGlobalFunc_HorseRacing_PlayTime_ClearUpdateFunc()
  Panel_HorseRacing_Time:ClearUpdateLuaFunc()
end
function HandleEventLUp_HorseRacing_RequestEscape()
  if false == Panel_HorseRacing_Time:GetShow() then
    return
  end
  local state = ToClient_getHorseRacingState()
  if __eHorseRacing_Play == state then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_deliveryPerson_GoChange"))
    ToClient_requestEscapeInHorseRacing()
  end
end
function FromClinet_HorseRacing_PlayTime_OnScreenResize()
  if nil == Panel_HorseRacing_Time then
    return
  end
  local screenSizeX = getOriginScreenSizeX()
  Panel_HorseRacing_Time:SetSize(screenSizeX, getOriginScreenSizeY())
  Panel_HorseRacing_Time:ComputePos()
  PaGlobal_HorseRacing_PlayTime._ui.stc_TimeCount:ComputePos()
end
function FromClient_HorseRacing_PlayTime_Finish()
  if nil == Panel_HorseRacing_Time then
    return
  end
  local state = ToClient_getHorseRacingState()
  if __eHorseRacing_Result ~= state then
    return
  end
  local self = PaGlobal_HorseRacing_PlayTime
  self._ui.txt_retire:SetShow(true)
  local resultText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_RESULT_FAIL")
  local isResultFail = self:isResultFail()
  if false == isResultFail then
    resultText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_RESULT_SUCCESS")
  else
    audioPostEvent_SystemUi(17, 3)
  end
  self._ui.txt_retire:SetText(resultText)
  self._ui.txt_retireTime:SetShow(false)
end
function PaGlobal_HorseRacing_PlayTime_RescueCoolTimeUpdatePerframe(deltaTime)
end
function FromClient_HorseRacing_PlayTime_ResponseHorseRaceRescueCoolTime()
end
