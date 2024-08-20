function PaGlobal_HorseRacing_Score_Open(state)
  if nil == Panel_HorseRacing_Score then
    return
  end
  if __eHorseRacing_Result ~= state then
    return
  end
  PaGlobal_HorseRacing_Score:prepareOpen()
end
function Panel_HorseRacing_Score_Close()
  if nil == Panel_HorseRacing_Score then
    return
  end
  PaGlobal_HorseRacing_Score:prepareClose()
end
function PaGlobal_HorseRacing_Score_ShowToolTip(isRank, index)
  local target = PaGlobal_HorseRacing_Score._ui.stc_rankerList[index]
  if false == isRank then
    target = PaGlobal_HorseRacing_Score._ui.stc_retireList[index]
  end
  if nil == target then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local wrapper = ToClient_getHorseRacingRankingByIndex(index - 1)
  if nil == wrapper then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemKey = wrapper:getRewardItemKey()
  local itemWrapper = getItemEnchantStaticStatus(itemKey)
  if nil == itemWrapper then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  Panel_Tooltip_Item_Show(itemWrapper, target.rewardIcon.icon, true, false)
end
function HandleEventLUp_HorseRacing_Score_Exit()
  if nil == Panel_HorseRacing_Score then
    return
  end
  ToClient_UnJoinInstanceFieldForAll()
end
function FromClient_HorseRacing_Score_ReSize()
  if nil == Panel_HorseRacing_Score then
    return
  end
  local screenY = getScreenSizeY()
  Panel_HorseRacing_Score:SetSize(Panel_HorseRacing_Score:GetSizeX(), screenY)
  Panel_HorseRacing_Score:ComputePosAllChild()
end
function FromClient_HorseRacing_Score_UpdateRankingAck()
  if nil == Panel_HorseRacing_Score then
    return
  end
  local state = ToClient_getHorseRacingState()
  PaGlobal_HorseRacing_Score_Open(state)
end
