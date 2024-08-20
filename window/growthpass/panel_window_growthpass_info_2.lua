function PaGlobalFunc_GrowPath_Info_Close()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_GrowthPass_Info:prepareClose()
end
function PaGlobalFunc_GrowPath_Info_Show(questInfoWrapper, questInfoControl, isForceShow)
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  PaGlobal_GrowthPass_Info:prepareOpen(questInfoWrapper, questInfoControl, isForceShow)
end
function PaGlobalFunc_GrowthPass_Info_OnClickedQuestionRewardIcon(questGroup, questId)
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  local questState = ToClient_getGrowthPassQuestState(questGroup, questId)
  if questState ~= __eGrowthPass_QuestState_Complete then
    return
  end
  ToClient_requestClearGrowthPassQuest(questGroup, questId)
  PaGlobal_GrowthPass_Info._ui._btn_reward:SetMonoTone(true)
end
function PaGlobal_GrowthPass_Info_ShowItemTooptip(rewardItemKeyRaw, isShow)
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  if true == isShow then
    local rewardItemKey = ItemEnchantKey(rewardItemKeyRaw)
    local rewardItemSSW = getItemEnchantStaticStatus(rewardItemKey)
    if nil == rewardItemSSW then
      return
    end
    Panel_Tooltip_Item_Show(rewardItemSSW, PaGlobal_GrowthPass_Info._ui._itemSlot.icon, true, false)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_GrowthPass_Info_GetShow()
  if nil == Panel_Window_GrowthPass_Info then
    return false
  end
  return Panel_Window_GrowthPass_Info:GetShow()
end
