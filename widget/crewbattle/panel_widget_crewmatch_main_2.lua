function FromClient_responseCrewMatchInformation()
  local self = PaGlobal_CrewMatch_Main
  self:prepareOpen()
end
function FromClient_showCrewMatchCountDown()
  PaGlobal_Widget_CrewMatch_StartCount(ToClient_getProtectedRemainTime())
end
function FromClient_responseCrewMatchKillPlayer(killerTeam, killerUserNo, victimUserNo, killerName)
  local self = PaGlobal_CrewMatch_Main
  for ii = 0, __eCrewMatchTeam_Count - 1 do
    local point = ToClient_getCrewMatchTeamPoint(ii)
    self._group[ii]._txt_killCount:SetText(tostring(point))
  end
  PaGlobal_CrewMatch_ScoreTab_Update()
end
function FromClient_responseCrewMatchResult(winTeam)
  PaGlobal_CrewMatch_ScoreTab_Open()
end
function FromClient_responseCrewMatchCurrentState(currentState)
  if __eCrewMatchState_Ready == currentState then
    PaGlobal_Widget_CrewMatch_StartCount(10)
  end
end
function FromClient_responseCrewMatchLogInOut(userNo, isLogin, userNickName, team)
  PaGlobal_CrewMatch_ScoreTab_Update()
end
function FromClient_responseCrewSetMainObject()
  local self = PaGlobal_CrewMatch_Main
  self:updateMainObjHp()
end
function PaGlobal_CrewMain_UpdatePerFrame()
  local self = PaGlobal_CrewMatch_Main
  local currentState = ToClient_getCrewMatchCurrentState()
  local remainTime = 0
  if __eCrewMatchState_Wait == currentState then
    remainTime = ToClient_getCrewMatchMaxTime()
  elseif __eCrewMatchState_Ready == currentState then
  elseif __eCrewMatchState_Playing == currentState then
    remainTime = ToClient_getCrewMatchRemainTime()
  else
    Panel_Widget_CrewMatch_Main:ClearUpdateLuaFunc()
    return
  end
  self._ui._txt_time:SetText(convertSecondsToClockTime(remainTime))
  self:updateMainObjHp()
end
function PaGlobal_CrewMain_LeaveCrewMatch()
  local self = PaGlobal_CrewMatch_Main
  if false == _ContentsGroup_CrewMatch then
    return
  end
  if false == self._initialize then
    return
  end
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eeInstanceContentsType_CrewMatch) then
    return
  end
  local exit_Instance = function()
    ToClient_UnJoinInstanceFieldForAll()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_CREWMATCH_EXIT"),
    functionYes = exit_Instance,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
