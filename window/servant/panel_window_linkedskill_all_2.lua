function EventHandler_LinkedSkill_SkillScroll(isScrollUp)
  local prevIdx = PaGlobal_LinkedSkill_All._skillStartIndex
  PaGlobal_LinkedSkill_All._skillStartIndex = UIScroll.ScrollEvent(PaGlobal_LinkedSkill_All._ui._scroll_skillScroll, isScrollUp, PaGlobal_LinkedSkill_All._skillConfig.count, PaGlobal_LinkedSkill_All._skillCount, PaGlobal_LinkedSkill_All._skillStartIndex, 1)
  PaGlobal_LinkedSkill_All:updateSkill()
  if prevIdx ~= PaGlobal_LinkedSkill_All._skillStartIndex then
    ToClient_padSnapIgnoreGroupMove()
    local lastSlotNo = PaGlobal_LinkedSkill_All._lastSlotNo
    if -1 ~= lastSlotNo then
      local slot = PaGlobal_LinkedSkill_All._skillSlot[lastSlotNo]
      if nil ~= slot and -1 ~= slot.skillIndex then
        HandleEventOut_LinkedSkill_SkillTooltip()
        HandleEventOn_LinkedSkill_SkillTooltip(lastSlotNo, slot.skillIndex)
      end
    end
  end
end
function HandleEventOn_LinkedSkill_EquipTooltip(slotNo)
  local servantInfo = PaGlobal_LinkedSkill_All:getServantInfo()
  if nil == servantInfo then
    return
  end
  if _ContentsGroup_UsePadSnapping then
    local itemWrapper = servantInfo:getEquipItem(slotNo)
    if nil ~= itemWrapper then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare, 0)
    end
  else
    local slot = PaGlobal_LinkedSkill_All._equipSlot[slotNo]
    Panel_Tooltip_Item_SetPosition(slotNo, slot, "LinkedHorseEquip")
    Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "LinkedHorseEquip", true)
  end
end
function HandleEventOut_LinkedSkill_EquipTooltip()
  Panel_Tooltip_Item_hideTooltip()
end
function HandleEventOn_LinkedSkill_SkillTooltip(slotNo, skillIdx)
  local carriageWrapper = getServantInfoFromActorKey(PaGlobal_LinkedSkill_All._actorKeyRaw)
  if nil == carriageWrapper then
    return
  end
  local servantInfo = stable_getServantFromOwnerServant(carriageWrapper:getServantNo(), PaGlobal_LinkedSkill_All._currentIndex)
  if nil == servantInfo then
    return
  end
  local skillWrapper = servantInfo:getSkill(skillIdx)
  if nil == skillWrapper then
    return
  end
  PaGlobal_LinkedSkill_All._lastSlotNo = slotNo
  local slotIcon = PaGlobal_LinkedSkill_All._skillSlot[slotNo]._stc_skillIcon
  if true == _ContentsGroup_NewUI_Tooltip_All then
    PaGlobal_Tooltip_Skill_Servant_All_Open(skillWrapper, slotIcon, false)
  else
    PaGlobal_Tooltip_Servant_Open(skillWrapper, slotIcon, false)
  end
end
function HandleEventOut_LinkedSkill_SkillTooltip()
  PaGlobal_LinkedSkill_All._lastSlotNo = -1
  if true == _ContentsGroup_NewUI_Tooltip_All then
    PaGlobal_Tooltip_Skill_Servant_All_Close()
  else
    PaGlobal_Tooltip_Servant_Close()
  end
end
function HandleEventOnOut_LinkedSkill_ShowStallionToolTip(isShow, slotNo)
  if false == isShow or nil == slotNo then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_LinkedSkill_All._skillSlot[slotNo] then
    return
  end
  local control = PaGlobal_LinkedSkill_All._skillSlot[slotNo]._stc_skillStallionIcon
  if nil == control then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STALLIONSKILL_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STALLIONSKILL_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
function PaGloabl_LinkedSkill_All_ShowAni()
  if nil == Panel_Window_LinkedSkill_All then
    return
  end
end
function PaGloabl_LinkedSkill_All_HideAni()
  if nil == Panel_Window_LinkedSkill_All then
    return
  end
end
function PaGloabl_LinkedSkill_All_Open(actorKeyRaw, index)
  PaGlobal_LinkedSkill_All:prepareOpen(actorKeyRaw, index)
end
function PaGlobal_LinkedSkill_All_Close()
  PaGlobal_LinkedSkill_All:prepareClose()
end
function PaGlobal_LinkedSkill_All_GetServantInfo()
  return PaGlobal_LinkedSkill_All:getServantInfo()
end
