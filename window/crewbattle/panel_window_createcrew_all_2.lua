function PaGlobalFunc_CreateCrew_All_Open()
  PaGlobal_CreateCrew_All:prepareOpen()
end
function PaGlobalFunc_CreateCrew_All_Close()
  PaGlobal_CreateCrew_All:prepareClose()
end
function HandleEventLUp_CreateCrew_All_OpenCrewName()
  if nil ~= PaGlobalFunc_CrewName_All_Open then
    PaGlobalFunc_CrewName_All_Open()
  end
end
function FromClient_CreateCrew_All_Resize()
  if nil == Panel_Window_CreateCrew_All then
    return
  end
  Panel_Window_CreateCrew_All:ComputePosAllChild()
end
function FromClient_CreateCrew_All_ResponseCreateCrew(crewName)
  local message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_SYSMSG_CREATE", "crewName", tostring(crewName))
  Proc_ShowMessage_Ack(message)
  PaGlobalFunc_CreateCrew_All_Close()
end
