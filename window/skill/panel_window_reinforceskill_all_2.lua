function PaGlobalFunc_PaGlobal_ReinforceSkill_All_Open()
  PaGlobal_ReinforceSkill_All:prepareOpen()
end
function PaGlobalFunc_PaGlobal_ReinforceSkill_All_Close()
  PaGlobal_ReinforceSkill_All:prepareClose()
end
function HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip(reinforceIndex, skillNo, uiIndex, index, isNormal)
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  PaGlobal_ReinforceSkill_All:descToolTip(reinforceIndex, skillNo, uiIndex, index, isNormal)
end
function HandleEventOn_PaGlobal_ReinforceSkill_All_EffectOff()
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  PaGlobal_ReinforceSkill_All:offEffect()
end
function HandleEventOn_PaGlobal_ReinforceSkill_All_NoramlActiveButtonTooltip(btnType, index)
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  PaGlobal_ReinforceSkill_All:buttonToolTip(btnType, index, true)
end
function HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip(btnType, index)
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  PaGlobal_ReinforceSkill_All:buttonToolTip(btnType, index, false)
end
function HandleEventOn_PaGlobal_ReinforceSkill_All_SetCurrentSkill(isEnableSkill, index, playerSkillType, skillNo, reinforceSkillIndex)
  PaGlobal_ReinforceSkill_All:setCurrentButtonData(isEnableSkill, index, playerSkillType, skillNo, reinforceSkillIndex)
end
function HandlePadEvent_PaGlobal_ReinforceSkill_All_SetSkillTooltip(skillNo)
  TooltipSimple_Hide()
  if nil ~= Panel_SkillTooltip_GetShow and true == Panel_SkillTooltip_GetShow() then
    Panel_SkillTooltip_Hide()
  else
    if nil == skillNo then
      Panel_SkillTooltip_Hide()
      return
    end
    Panel_SkillTooltip_Show(skillNo, false, "SkillAwakenSet")
  end
end
function PaGlobal_ReinforceSkill_All_SetEffect(skillType, index)
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  PaGlobal_ReinforceSkill_All:setEffect(skillType, index)
end
function PaGloabl_ReinforceSkill_All_ShowAni()
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Window_ReinforceSkill_All)
  local aniInfo1 = Panel_Window_ReinforceSkill_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_ReinforceSkill_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_ReinforceSkill_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_ReinforceSkill_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_ReinforceSkill_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_ReinforceSkill_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGloabl_ReinforceSkill_All_HideAni()
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  Panel_Window_ReinforceSkill_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_ReinforceSkill_All:addColorAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function FromClient_ReinforceSkill_All_SkillAwakeningPlayerStart()
  if false == Panel_Window_ReinforceSkill_All:GetShow() and false == Panel_SkillReinforce_All:GetShow() then
    PaGlobalFunc_PaGlobal_ReinforceSkill_All_Open()
  end
end
function FromClient_ReinforceSkill_All_SkillAwakeningPlayerEnd()
  if true == Panel_Window_ReinforceSkill_All:GetShow() then
    PaGlobalFunc_PaGlobal_ReinforceSkill_All_Close()
  end
  if true == Panel_SkillReinforce_All:GetShow() then
    PaGlobalFunc_PaGlobal_SkillReinforce_All_Close()
  end
end
function PaGlobalFunc_ReinforceSkill_All_IsSkillAwakeningPlayer()
  local actor = interaction_getInteractable()
  if nil == actor then
    return false
  end
  if false == actor:get() then
    return false
  end
  if false == actor:get():isPlayer() then
    return false
  end
  local isAwakenPlayer = Interaction_isSetInteractableFragLua(actor, CppEnums.InteractionType.InteractionType_SkillAwakenPlayer)
  return isAwakenPlayer
end
