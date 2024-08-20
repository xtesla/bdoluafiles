function PaGlobal_ServantSummonBoss_Open()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  if false == PaGlobal_ServantSummonBoss._initialize then
    return
  end
  PaGlobal_ServantSummonBoss:prepareOpen()
end
function PaGlobal_ServantSummonBoss_Close()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  PaGlobal_ServantSummonBoss:prepareClose()
end
function PaGlobal_ServantSummonBoss_GetShow()
  if nil == Panel_Widget_ServantSummonBoss then
    return false
  end
  return Panel_Widget_ServantSummonBoss:GetShow()
end
function FromClient_ServantSummonBoss_RenderModeChangeState(prevRenderModeList, nextRenderModeList)
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  PaGlobal_ServantSummonBoss_Open()
end
function FromClient_ServantSummonBoss_EventSelfPlayerCarrierChanged(vehicleActorKeyRaw)
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  if nil == actorKeyRaw then
    return
  end
  local vehicleProxy = getVehicleActor(actorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  local isHideHorseHP
  for index = 1, #PaGlobal_ServantSummonBoss._bossInfo do
    if PaGlobal_ServantSummonBoss._bossInfo[index]._actorkey == actorKeyRaw then
      isHideHorseHP = PaGlobal_ServantSummonBoss._bossInfo[index]._isHideServantHP
    end
  end
  if CppEnums.VehicleType.Type_BossMonster == vehicleType or nil ~= isHideHorseHP and true == isHideHorseHP then
    if nil ~= Panel_HorseHp and true == Panel_HorseHp:GetShow() then
      HorseHP_Close()
    end
    if nil ~= Panel_HorseMp and true == Panel_HorseMp:GetShow() then
      HorseMP_Close()
    end
    PaGlobal_ServantSummonBoss_Open()
    return
  end
  local characterActorProxyWrapper = getCharacterActor(vehicleActorKeyRaw)
  if nil == characterActorProxyWrapper then
    PaGlobal_ServantSummonBoss_Close()
    return
  end
end
function FromClient_ServantSummonBoss_EventSelfServantUpdate()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  PaGlobal_ServantSummonBoss:update()
end
function HandleEventOn_ServantSummonBoss_HpBar()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  PaGlobal_ServantSummonBoss._ui._txt_hp:SetShow(true)
end
function HandleEventOut_ServantSummonBoss_HpBar()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  PaGlobal_ServantSummonBoss._ui._txt_hp:SetShow(false)
end
function FromClient_ServantSummonBoss_EventSelfPlayerRideOn()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  PaGlobal_ServantSummonBoss_Open()
end
function FromClient_ServantSummonBoss_EventSelfPlayerRideOff()
  if nil == Panel_Widget_ServantSummonBoss then
    return
  end
  PaGlobal_ServantSummonBoss_Close()
end
function FromAction_ServantSummonBoss_StackRemoveCrio()
  PaGlobal_ServantSummonBoss:updateCrioStack(PaGlobal_ServantSummonBoss._eStack.non)
end
function FromAction_ServantSummonBoss_Stack1Crio()
  PaGlobal_ServantSummonBoss:updateCrioStack(PaGlobal_ServantSummonBoss._eStack.stack1)
end
function FromAction_ServantSummonBoss_Stack2Crio()
  PaGlobal_ServantSummonBoss:updateCrioStack(PaGlobal_ServantSummonBoss._eStack.stack2)
end
function FromAction_ServantSummonBoss_Stack3Crio()
  PaGlobal_ServantSummonBoss:updateCrioStack(PaGlobal_ServantSummonBoss._eStack.stack3)
end
function FromAction_ServantSummonBoss_CrioStackActive()
  PaGlobal_ServantSummonBoss._ui._stc_stackGroup_crio:SetShow(true)
end
function FromAction_ServantSummonBoss_CrioStackDisable()
  PaGlobal_ServantSummonBoss._ui._stc_stackGroup_crio:SetShow(false)
end
function FromAction_ServantSummonBoss_StackRemovePapu()
  PaGlobal_ServantSummonBoss:updatePapuStack(PaGlobal_ServantSummonBoss._eStack.non)
end
function FromAction_ServantSummonBoss_Stack1Papu()
  PaGlobal_ServantSummonBoss:updatePapuStack(PaGlobal_ServantSummonBoss._eStack.stack1)
end
function FromAction_ServantSummonBoss_Stack2Papu()
  PaGlobal_ServantSummonBoss:updatePapuStack(PaGlobal_ServantSummonBoss._eStack.stack2)
end
function FromAction_ServantSummonBoss_Stack3Papu()
  PaGlobal_ServantSummonBoss:updatePapuStack(PaGlobal_ServantSummonBoss._eStack.stack3)
end
function FromAction_ServantSummonBoss_PapuStackActive()
  PaGlobal_ServantSummonBoss._ui._stc_stackGroup_papu:SetShow(true)
end
function FromAction_ServantSummonBoss_PapuStackDisable()
  PaGlobal_ServantSummonBoss._ui._stc_stackGroup_papu:SetShow(false)
end
