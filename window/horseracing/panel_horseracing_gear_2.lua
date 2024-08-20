function PaGlobal_HorseRacing_Gear_Open(vehicleActorKeyRaw)
  if nil == Panel_HorseRacing_Gear or nil == vehicleActorKeyRaw then
    return
  end
  PaGlobal_HorseRacing_Gear:prepareOpen(vehicleActorKeyRaw)
end
function PaGlobal_HorseRacing_Gear_Close()
  if nil == Panel_HorseRacing_Gear then
    return
  end
  PaGlobal_HorseRacing_Gear:prepareClose()
end
function PaGlobal_HorseRacing_Gear_GearPointOpen()
  if nil == Panel_HorseRacing_Gear then
    return
  end
  if nil == PaGlobal_HorseRacing_Gear._curLev or PaGlobal_HorseRacing_Gear._curLev < 1 then
    PaGlobal_HorseRacing_Gear._ui.stc_gearEffect:EraseAllEffect()
    PaGlobal_HorseRacing_Gear._ui.stc_gearPointer:SetShow(false)
    PaGlobal_HorseRacing_Gear._gearPointShowLev = 0
    return
  end
  PaGlobal_HorseRacing_Gear._ui.txt_mpKeyGuide:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_RACINGCTRL_F"))
  PaGlobal_HorseRacing_Gear._ui.txt_gearKeyGuide:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_RACINGCTRL_Q"))
  audioPostEvent_SystemUi(17, 10)
  PaGlobal_HorseRacing_Gear._ui.stc_gearEffect:AddEffect("fUI_Race_Horse_SpeedGauge_01A", false, 0, 0)
  PaGlobal_HorseRacing_Gear._ui.stc_gearPointer:SetShow(true)
  PaGlobal_HorseRacing_Gear._gearPointShowLev = PaGlobal_HorseRacing_Gear._curLev
end
function PaGlobal_HorseRacing_Gear_GearPointClose()
  if nil == Panel_HorseRacing_Gear then
    return
  end
  PaGlobal_HorseRacing_Gear._ui.stc_gearEffect:EraseAllEffect()
  if true == PaGlobal_HorseRacing_Gear._ui.stc_gearPointer:GetShow() then
    if PaGlobal_HorseRacing_Gear._gearPointShowLev < PaGlobal_HorseRacing_Gear._curLev then
      PaGlobal_HorseRacing_Gear._ui.stc_gearPointerEffect:EraseAllEffect()
      audioPostEvent_SystemUi(17, 11)
      PaGlobal_HorseRacing_Gear._ui.stc_gearPointerEffect:AddEffect("fUI_Race_Horse_SpeedGauge_01B", false, 0, 0)
    else
      audioPostEvent_SystemUi(17, 12)
    end
  end
  PaGlobal_HorseRacing_Gear._ui.stc_gearPointer:SetShow(false)
end
function PaGlobal_HorseRacing_Gear_UpdateGear(delta)
  local changeGear = ToClient_getCurrentServantGear()
  PaGlobal_HorseRacing_Gear:changedRacingHorseGear(changeGear)
end
function FromClient_HorseRacing_Gear_ReSizePanel()
  Panel_HorseRacing_Gear:ComputePosAllChild()
end
function FromClient_HorseRacing_Gear_CarrierChanged(vehicleActorKeyRaw)
  if nil == Panel_HorseRacing_Gear or nil == vehicleActorKeyRaw then
    return
  end
  local vehicleProxy = getVehicleActor(vehicleActorKeyRaw)
  if nil == vehicleProxy or CppEnums.VehicleType.Type_RaceHorse ~= vehicleProxy:get():getVehicleType() then
    return
  end
  PaGlobal_HorseRacing_Gear._vehicleActorKeyRaw = vehicleActorKeyRaw
  PaGlobal_HorseRacing_Gear:prepareOpen()
  FromClient_HorseRacing_Gear_ServantHpUpdate()
end
function FromClient_HorseRacing_Gear_ServantHpUpdate()
  if nil == Panel_HorseRacing_Gear or false == Panel_HorseRacing_Gear:GetShow() then
    return
  end
  local vehicleProxy = getVehicleActor(PaGlobal_HorseRacing_Gear._vehicleActorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  if CppEnums.VehicleType.Type_RaceHorse ~= vehicleType then
    return
  end
  PaGlobal_HorseRacing_Gear:updateHp(vehicleProxy)
end
function FromClient_HorseRacing_Gear_ServantMpUpdate()
  if nil == Panel_HorseRacing_Gear or false == Panel_HorseRacing_Gear:GetShow() then
    return
  end
  local vehicleProxy = getVehicleActor(PaGlobal_HorseRacing_Gear._vehicleActorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  if CppEnums.VehicleType.Type_RaceHorse ~= vehicleType then
    return
  end
  PaGlobal_HorseRacing_Gear:updateMp(vehicleProxy)
end
function FromClient_HorseRacing_Gear_ServantStatUpdate()
  if nil == Panel_HorseRacing_Gear or false == Panel_HorseRacing_Gear:GetShow() then
    return
  end
  local vehicleProxy = getVehicleActor(PaGlobal_HorseRacing_Gear._vehicleActorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  if CppEnums.VehicleType.Type_RaceHorse ~= vehicleType then
    return
  end
  PaGlobal_HorseRacing_Gear:updateStat()
end
function FromClient_HorseRacing_Gear_ServantUpdate()
  if nil == Panel_HorseRacing_Gear or false == Panel_HorseRacing_Gear:GetShow() then
    return
  end
  local vehicleProxy = getVehicleActor(PaGlobal_HorseRacing_Gear._vehicleActorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  if CppEnums.VehicleType.Type_RaceHorse ~= vehicleType then
    return
  end
  PaGlobal_HorseRacing_Gear:updateHp(vehicleProxy)
  PaGlobal_HorseRacing_Gear:updateStat()
end
