PaGlobal_HorseRacing_Waiting = {
  _ui = {
    stc_InfoBox = nil,
    stc_PlayerCount = nil,
    stc_txtArea = nil,
    stc_infoESCDesc = nil
  },
  _waitForStartDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_WAITING_INFO_05"),
  _minPlayerDesc = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_WAITING_INFO_06", "MinUser", 0),
  _maxPlayerDesc = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_WAITING_INFO_07", "MaxUser", 0),
  _PenaltyDesc = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_WAITING_INFO_03", "time", 0),
  _autoKickDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_WAITING_INFO_01"),
  _returnTrackDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_WAITING_INFO_08"),
  _ui_PrepareWaiting = {txt_playerCount = nil},
  _currentTime = 0,
  _elapsedTime = 0,
  _initialize = false,
  _WATINGTIME = 0,
  _noticeTime = 60,
  _maxPlayer = 0,
  _minPlayer = 0
}
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseRacing_Waiting_Init")
function FromClient_HorseRacing_Waiting_Init()
  PaGlobal_HorseRacing_Waiting:initialize()
end
function PaGlobal_HorseRacing_Waiting:initialize()
  if true == PaGlobal_HorseRacing_Waiting._initialize or nil == Panel_HorseRacing_Waiting then
    return
  end
  self._ui.stc_OverLine = UI.getChildControl(Panel_HorseRacing_Waiting, "Static_OverLine")
  self._ui.stc_PlayerCount = UI.getChildControl(self._ui.stc_OverLine, "StaticText_PeopleCount")
  self._ui.stc_InfoBox = UI.getChildControl(Panel_HorseRacing_Waiting, "Static_InfoBox")
  self._ui.stc_txtArea = UI.getChildControl(self._ui.stc_InfoBox, "Static_TextArea")
  self._ui.stc_infoESCDesc = UI.getChildControl(self._ui.stc_InfoBox, "StaticText_Info_ESC")
  self._WATINGTIME = ToClient_getHorseRacingWaitingTime()
  self._maxPlayer = ToClient_getHorseRacingMinPlayer()
  self._minPlayer = ToClient_getHorseRacingMaxPlayer()
  self._PenaltyDesc = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_WAITING_INFO_03", "time", ToClient_getHorseRacingMaxPenaltyTime())
  local stc_OverLine2 = UI.getChildControl(Panel_HorseRacing_Waiting2, "Static_OverLine")
  self._ui_PrepareWaiting.txt_playerCount = UI.getChildControl(stc_OverLine2, "StaticText_PeopleCount")
  PaGlobal_HorseRacing_Waiting:validate()
  PaGlobal_HorseRacing_Waiting:registEventHandler()
  PaGlobal_HorseRacing_Waiting._initialize = true
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    local state = ToClient_getHorseRacingState()
    if __eHorseRacing_WaitTime == state or __eHorseRacing_PrepareTime == state then
      PaGlobal_HorseRacing_Waiting:prepareOpen()
    end
  end
end
function PaGlobal_HorseRacing_Waiting:registEventHandler()
  if nil == Panel_HorseRacing_Waiting then
    return
  end
  registerEvent("FromClient_HorseRacing_JoinAck", "FromClient_HorseRacingWaiting_Open")
  registerEvent("FromClient_HorseRacing_NoticeAck", "FromClient_HorseRacingWaiting_NoticeAck")
  registerEvent("FromClient_HorseRacing_OtherPlayerJoin", "FromClient_HorseRacingWaiting_Update")
  registerEvent("FromClient_HorseRacing_UpdateAck", "FromClient_HorseRacingWaiting_UpdateAck")
end
function PaGlobal_HorseRacing_Waiting:prepareOpen()
  if nil == Panel_HorseRacing_Waiting then
    return
  end
  local playerCount = ToClient_getHorseRacingPlayerCount()
  local state = ToClient_getHorseRacingState()
  if __eHorseRacing_WaitTime == state then
    Panel_HorseRacing_Waiting:SetShow(true)
    Panel_HorseRacing_Waiting2:SetShow(false)
    Panel_HorseRacing_WaitingCheck:SetShow(true)
  elseif __eHorseRacing_PrepareTime == state then
    self._ui_PrepareWaiting.txt_playerCount:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_HORSERACING_WAITING_COUNT", "recent", playerCount, "max", PaGlobal_HorseRacing_Waiting._maxPlayer))
    Panel_HorseRacing_Waiting:SetShow(false)
    Panel_HorseRacing_Waiting2:SetShow(true)
    Panel_HorseRacing_WaitingCheck:SetShow(false)
  else
    Panel_HorseRacing_Waiting:SetShow(false)
    Panel_HorseRacing_Waiting2:SetShow(false)
    Panel_HorseRacing_WaitingCheck:SetShow(false)
  end
  self._ui.stc_PlayerCount:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_HORSERACING_WAITING_COUNT", "recent", playerCount, "max", PaGlobal_HorseRacing_Waiting._maxPlayer))
  self._currentTime = 0
  self._elapsedTime = 0
  self._ui.stc_PlayerCount:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_HORSERACING_WAITING_COUNT", "recent", playerCount, "max", PaGlobal_HorseRacing_Waiting._maxPlayer))
  self._minPlayerDesc = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_WAITING_INFO_06", "MinUser", ToClient_getHorseRacingMinPlayer())
  self._maxPlayerDesc = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_WAITING_INFO_07", "MaxUser", ToClient_getHorseRacingMaxPlayer())
  local totalText = self._waitForStartDesc .. [[


]] .. self._minPlayerDesc .. [[


]] .. self._maxPlayerDesc .. [[


]] .. self._PenaltyDesc .. [[


]] .. self._autoKickDesc .. [[


]] .. self._returnTrackDesc .. [[


]]
  self._ui.stc_txtArea:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_txtArea:SetText(totalText)
  local panSize = 15
  local totalTextSize = self._ui.stc_txtArea:GetSizeY() + self._ui.stc_infoESCDesc:GetSizeY() + panSize
  self._ui.stc_InfoBox:SetSize(self._ui.stc_InfoBox:GetSizeX(), totalTextSize)
  Panel_HorseRacing_Waiting:SetSize(Panel_HorseRacing_Waiting:GetSizeX(), self._ui.stc_OverLine:GetSizeY() + self._ui.stc_InfoBox:GetSizeY())
  self._ui.stc_infoESCDesc:ComputePos()
  PaGlobal_HorseRacing_Waiting:open()
  Panel_HorseRacing_Waiting:ComputePos()
end
function PaGlobal_HorseRacing_Waiting:open()
  if nil == Panel_HorseRacing_Waiting then
    return
  end
end
function PaGlobal_HorseRacing_Waiting:prepareClose()
  if nil == Panel_HorseRacing_Waiting then
    return
  end
  Panel_HorseRacing_Waiting:ClearUpdateLuaFunc()
  PaGlobal_HorseRacing_Waiting:close()
end
function PaGlobal_HorseRacing_Waiting:close()
  if nil == Panel_HorseRacing_Waiting or nil == Panel_HorseRacing_Waiting2 then
    return
  end
  Panel_HorseRacing_Waiting:SetShow(false)
  Panel_HorseRacing_Waiting2:SetShow(false)
  Panel_HorseRacing_WaitingCheck:SetShow(false)
end
function PaGlobal_HorseRacing_Waiting:validate()
  if nil == Panel_HorseRacing_Waiting then
    return
  end
  self._ui.stc_InfoBox:isValidate()
  self._ui.stc_PlayerCount:isValidate()
end
function FromClient_HorseRacingWaiting_Open()
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    return
  end
  PaGlobal_HorseRacing_Waiting:prepareOpen()
end
function FromClient_HorseRacingWaiting_NoticeAck(noticeType)
  if __eHorseRaceNoticeType_WaitingOver == noticeType then
    PaGlobal_HorseRacing_Waiting:prepareClose()
  end
end
function FromClient_HorseRacingWaiting_Close()
  local exit_Instance = function()
    ToClient_UnJoinInstanceFieldForAll()
    PaGlobal_HorseRacing_Waiting:prepareClose()
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) and __eHorseRacing_WaitTime == ToClient_getHorseRacingState() then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_HORSERACE_EXIT_WARNING"),
      functionYes = exit_Instance,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function FromClient_HorseRacingWaiting_Update(playerCount)
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    return
  end
  if nil == Panel_HorseRacing_Waiting or nil == Panel_HorseRacing_Waiting2 or nil == Panel_HorseRacing_WaitingCheck then
    return
  end
  local state = ToClient_getHorseRacingState()
  if __eHorseRacing_WaitTime == state or __eHorseRacing_PrepareTime == state then
    if playerCount < ToClient_getHorseRacingMinPlayer() then
      Panel_HorseRacing_Waiting:ClearUpdateLuaFunc()
      PaGlobal_HorseRacing_Waiting._currentTime = 0
      PaGlobal_HorseRacing_Waiting._elapsedTime = 0
      Panel_HorseRacing_Waiting:RegisterUpdateFunc("PaGlobal_HorseRacing_Waiting_PerframeForWaiting")
    end
    PaGlobal_HorseRacing_Waiting:prepareOpen()
  end
end
function PaGlobal_HorseRacing_Waiting_PerframeForWaiting(deltaTime)
  PaGlobal_HorseRacing_Waiting._currentTime = PaGlobal_HorseRacing_Waiting._currentTime + deltaTime
  if PaGlobal_HorseRacing_Waiting._currentTime >= 1 then
    PaGlobal_HorseRacing_Waiting._currentTime = 0
    PaGlobal_HorseRacing_Waiting._elapsedTime = PaGlobal_HorseRacing_Waiting._elapsedTime + 1
  end
  if PaGlobal_HorseRacing_Waiting._WATINGTIME - PaGlobal_HorseRacing_Waiting._elapsedTime <= PaGlobal_HorseRacing_Waiting._noticeTime then
    FromClient_HorseRacing_WaitNak_PrepraeNotice(0, __eHorseRaceNoticeType_WaitingRemain)
    PaGlobal_HorseRacing_Waiting._currentTime = 0
    PaGlobal_HorseRacing_Waiting._elapsedTime = 0
    Panel_HorseRacing_Waiting:ClearUpdateLuaFunc()
  end
end
function FromClient_HorseRacingWaiting_UpdateAck(state)
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    return
  end
  if nil == Panel_HorseRacing_Waiting or nil == Panel_HorseRacing_Waiting2 or nil == Panel_HorseRacing_WaitingCheck then
    return
  end
  if __eHorseRacing_WaitTime == state or __eHorseRacing_PrepareTime == state then
    PaGlobal_HorseRacing_Waiting:prepareOpen()
  else
    PaGlobal_HorseRacing_Waiting:prepareClose()
  end
end
