function PaGlobalFunc_SkillGroup_SelectType_Open(playerClassType, selectTreeType, skillNo)
  PaGlobal_SkillGroup._ui._btn_modify:SetCheck(false)
  PaGlobal_SkillGroup:updateEditMode(false)
  PaGlobal_SkillGroup_SelectType:setClass(playerClassType, selectTreeType, skillNo)
  PaGlobal_SkillGroup_SelectType:show()
end
function PaGlobalFunc_SkillGroup_SelectType_Close()
  if true == PaGlobal_SkillGroup_SelectType._isAwakenGuide then
    return
  end
  PaGlobal_SkillGroup_SelectType:close()
end
function PaGlobalFunc_SkillGroup_SelectType_SelectTree(selectTreeType, isAwakenGuide)
  if nil == Panel_Window_SkillGroup_SelectType then
    return
  end
  PaGlobal_SkillGroup_SelectType:selectTree(selectTreeType, isAwakenGuide)
end
function PaGlobalFunc_SkillGroup_SelectType_ToggleSkillTooltip(skillNo)
  if true == Panel_SkillTooltip_GetShow() then
    Panel_SkillTooltip_Hide()
  else
    Panel_SkillTooltip_Show(skillNo, false, "SelectTypeBox")
    Panel_SkillTooltip_SetPosition_ForConsole(PaGlobal_SkillGroup_SelectType._ui._stc_skillSlot, "SelectTypeBox")
  end
end
function HandleEventLUp_SkillGroup_SelectType_StartDrag(skillNo)
  if Defines.UIMode.eUIMode_NpcDialog == GetUIMode() then
    return
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  PaGlobal_SkillGroup._isDraggingFromTree = true
  if nil ~= skillLevelInfo and nil ~= skillTypeStaticWrapper then
    DragManager:setDragInfo(Panel_Window_SkillGroup, nil, skillLevelInfo._skillKey:get(), "Icon/" .. skillTypeStaticWrapper:getIconPath(), SkillGroup_GroundClick, nil)
    if false == PaGlobal_SkillGroup._isEditMode then
      PaGlobal_SkillGroup:HandleEventLUp_EditMode()
    end
  end
  PaGlobalFunc_SkillGroup_SelectType_Close()
end
function HandleEventLUp_SkillGroup_SelectType_AwakenGuideComplete()
  PaGlobal_SkillGroup_SelectType._isAwakenGuide = false
  PaGlobalFunc_SkillGroup_SelectType_Close()
  if nil ~= HandleMLUp_SkillWindow_OpenForLearn then
    HandleMLUp_SkillWindow_OpenForLearn(2)
  end
end
