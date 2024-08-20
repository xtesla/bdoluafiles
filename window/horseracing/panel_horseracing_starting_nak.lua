PaGlobal_HorseRacing_StartNak = {_currentCount = 0, _closeCount = 5}
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseRacing_StartNak")
function FromClient_HorseRacing_StartNak()
  PaGlobal_HorseRacing_StartNak:initialize()
end
function PaGlobal_HorseRacing_StartNak:initialize()
end
function PaGlobal_HorseRacing_StartNak:open()
  Panel_HorceRacing_StartNak:SetShow(true)
end
function PaGlobal_HorseRacing_StartNak:close()
  Panel_HorceRacing_StartNak:SetShow(false)
end
function FromClient_HorseRacing_StartNak_Open()
  chatting_sendMessage("", PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_NAKMSG_START"), CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  PaGlobal_HorseRacing_StartNak._currentCount = 0
  PaGlobal_HorseRacing_StartNak:open()
  Panel_HorceRacing_StartNak:RegisterUpdateFunc("FromClient_HorseRacing_StartNak_UpdatePerFrame")
end
function FromClient_HorseRacing_StartNak_UpdatePerFrame(deltaTime)
  PaGlobal_HorseRacing_StartNak._currentCount = PaGlobal_HorseRacing_StartNak._currentCount + deltaTime
  if PaGlobal_HorseRacing_StartNak._closeCount <= PaGlobal_HorseRacing_StartNak._currentCount then
    Panel_HorceRacing_StartNak:ClearUpdateLuaFunc()
    PaGlobal_HorseRacing_StartNak:close()
  end
end
