PaGlobal_HorseRacing_WaitNak = {
  _ui = {_txt_Desc = nil},
  _currentCount = 0,
  _closeCount = 5,
  _string_waitingRemain = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_NAKMSG_WAITINGEND"),
  _string_waitingOver = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_NAKMSG_FINDHORSE"),
  _string_30sec = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_NAKMSG_WAITING"),
  _string_notEnough = PAGetString(Defines.StringSheet_GAME, "LUA_HORSERACING_ROOMFAIL_WARNING"),
  _string_kickOut = PAGetString(Defines.StringSheet_GAME, "LUA_HORSERACING_KICK_WARNING")
}
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseRacing_WaitNak")
function FromClient_HorseRacing_WaitNak()
  PaGlobal_HorseRacing_WaitNak:initialize()
end
function PaGlobal_HorseRacing_WaitNak:initialize()
  self._ui._txt_Desc = UI.getChildControl(Panel_HorceRacing_WaitingNak, "MultilineText_WaitingTXT")
  registerEvent("FromClient_HorseRacing_NoticeAck", "FromClient_HorseRacing_WaitNak_PrepraeNotice")
  registerEvent("FromClient_HorseRacing_NoticeKickOut", "FromClient_HorseRacing_WaitNak_NoticeKickOut")
end
function PaGlobal_HorseRacing_WaitNak:validate()
  self._ui._txt_Desc:isValidate()
end
function PaGlobal_HorseRacing_WaitNak:prepareOpen()
  PaGlobal_HorseRacing_WaitNak._currentCount = 0
  PaGlobal_HorseRacing_WaitNak:open()
  Panel_HorceRacing_WaitingNak:RegisterUpdateFunc("FromClient_HorseRacing_WaitNak_UpdatePerFrame")
end
function PaGlobal_HorseRacing_WaitNak:open()
  Panel_HorceRacing_WaitingNak:SetShow(true)
end
function PaGlobal_HorseRacing_WaitNak:close()
  Panel_HorceRacing_WaitingNak:SetShow(false)
end
function FromClient_HorseRacing_WaitNak_PrepraeNotice(noticeType)
  if __eHorseRaceNoticeType_WaitingRemain == noticeType then
    PaGlobal_HorseRacing_WaitNak._ui._txt_Desc:SetText(PaGlobal_HorseRacing_WaitNak._string_waitingRemain)
    chatting_sendMessage("", tostring(PaGlobal_HorseRacing_WaitNak._string_waitingRemain), CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  elseif __eHorseRaceNoticeType_WaitingOver == noticeType then
    PaGlobal_HorseRacing_WaitNak._ui._txt_Desc:SetText(PaGlobal_HorseRacing_WaitNak._string_waitingOver)
    chatting_sendMessage("", tostring(PaGlobal_HorseRacing_WaitNak._string_waitingOver), CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    audioPostEvent_SystemUi(17, 13)
  elseif __eHorseRaceNoticeType_StartUntil30 == noticeType then
    PaGlobal_HorseRacing_WaitNak._ui._txt_Desc:SetText(PaGlobal_HorseRacing_WaitNak._string_30sec)
    chatting_sendMessage("", tostring(PaGlobal_HorseRacing_WaitNak._string_30sec), CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  elseif __eHorseRaceNoticeType_RoomReset == noticeType then
    PaGlobal_HorseRacing_WaitNak._ui._txt_Desc:SetText(PaGlobal_HorseRacing_WaitNak._string_notEnough)
    chatting_sendMessage("", tostring(PaGlobal_HorseRacing_WaitNak._string_notEnough), CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  end
  PaGlobal_HorseRacing_WaitNak:prepareOpen()
end
function FromClient_HorseRacing_WaitNak_NoticeKickOut()
  PaGlobal_HorseRacing_WaitNak._ui._txt_Desc:SetText(PaGlobal_HorseRacing_WaitNak._string_kickOut)
  chatting_sendMessage("", tostring(PaGlobal_HorseRacing_WaitNak._string_kickOut), CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  PaGlobal_HorseRacing_WaitNak:prepareOpen()
end
function PaGlobalFunc_HorseRacing_WaitNak_Open()
  PaGlobal_HorseRacing_WaitNak._ui._txt_Desc:SetText(PaGlobal_HorseRacing_WaitNak._string_3min)
  chatting_sendMessage("", tostring(PaGlobal_HorseRacing_WaitNak._string_3min), CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  PaGlobal_HorseRacing_WaitNak:prepareOpen()
end
function FromClient_HorseRacing_WaitNak_UpdatePerFrame(deltaTime)
  PaGlobal_HorseRacing_WaitNak._currentCount = PaGlobal_HorseRacing_WaitNak._currentCount + deltaTime
  if PaGlobal_HorseRacing_WaitNak._closeCount <= PaGlobal_HorseRacing_WaitNak._currentCount then
    Panel_HorceRacing_WaitingNak:ClearUpdateLuaFunc()
    PaGlobal_HorseRacing_WaitNak:close()
  end
end
