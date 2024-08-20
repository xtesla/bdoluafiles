function HandleEventLUp_SetSailControl()
  if true == PaGlobal_SailControl._isFoldable then
    local isSpread = ToClient_GetRideShipSpread()
    ToClient_SetSailSpread(not isSpread)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_CANT_FOLDSAIL"))
  end
end
function HandleEventOn_SetSailControlTooltip(isSpread)
  if nil == isSpread then
    isSpread = ToClient_GetRideShipSpread()
  end
  if true == isSpread then
    local title = PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_EXPAND")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_EXPAND_DESC")
    TooltipSimple_Show(PaGlobal_SailControl._ui.btn_SailControl, title, desc)
  else
    local title = PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_FOLD")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_FOLD_DESC")
    TooltipSimple_Show(PaGlobal_SailControl._ui.btn_SailControl, title, desc)
  end
end
function FromClient_ToTargetKeyGuideOnOff(isToTargetExist)
  if nil == Panel_Widget_AttackWayCorrection_KeyGuide then
    return
  end
  Panel_Widget_AttackWayCorrection_KeyGuide:SetShow(isToTargetExist)
end
