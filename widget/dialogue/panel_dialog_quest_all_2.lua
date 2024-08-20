function PaGlobalFunc_DialogQuest_All_Open()
  PaGlobal_DialogQuest_All:prepareOpen()
end
function PaGlobalFunc_DialogQuest_All_Close()
  PaGlobal_DialogQuest_All:prepareClose()
end
function HandleEventLUp_DialogQuest_All_QuestCancle()
  PaGlobalFunc_DialogQuest_All_Close()
  PaGlobalFunc_DialogMain_All_Close()
end
function HandleEventLUp_DialogQuest_All_SelectReward(selectIndex)
  PaGlobal_DialogQuest_All._selectIndex = selectIndex
  for index = 0, PaGlobal_DialogQuest_All._maxSelectSlotCount - 1 do
    PaGlobal_DialogQuest_All._uiBackSelectRewardCheck[index]:SetCheck(false)
    PaGlobal_DialogQuest_All._uiBackSelectRewardCheck[index]:EraseAllEffect()
    PaGlobal_DialogQuest_All._ui.stc_selectRewardList[index]:setRenderTexture(PaGlobal_DialogQuest_All._selectCheckBaseTexture)
  end
  PaGlobal_DialogQuest_All._uiBackSelectRewardCheck[selectIndex]:AddEffect("UI_Quest_Compensate_Loop", true, 0, 0)
  PaGlobal_DialogQuest_All._uiBackSelectRewardCheck[selectIndex]:SetCheck(true)
  PaGlobal_DialogQuest_All._ui.stc_selectRewardList[selectIndex]:setRenderTexture(PaGlobal_DialogQuest_All._selectCheckClickTexture)
  PaGlobal_DialogQuest_All._selectRewardItemName = PaGlobal_DialogQuest_All._selectRewardItemNameList[selectIndex]
  ReqeustDialog_selectReward(selectIndex)
end
function HandleEventEnter_DialogQuest_All_SelectConfirmReward()
  local _doConfirmYes = function()
    Dialog_clickDialogButtonReq(0)
    PaGlobalFunc_DialogQuest_All_ClearSelectRewardItemName()
  end
  if true == PaGlobal_DialogQuest_All._isComplete and 0 < PaGlobal_DialogQuest_All._selectRewardCount and (nil == PaGlobal_DialogQuest_All._selectIndex or -1 == PaGlobal_DialogQuest_All._selectIndex) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHALLENGE_YOUCANSELECTITEM"))
    PaGlobal_DialogQuest_All:remindRewardIconEffect()
    return
  end
  if false ~= PaGlobalFunc_DialogQuest_All_GetSelectedRewardItemName() and nil ~= PaGlobal_DialogQuest_All._selectIndex then
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NOTIFICATIONS_SELECTREWARD", "_selectRewardItemName", PaGlobal_DialogQuest_All._selectRewardItemName)
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = _doConfirmYes,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, "middle")
    return
  else
    Dialog_clickDialogButtonReq(0)
  end
end
function HandlePadEventY_DailogQuest_All_SelectConfirmReward()
  if nil ~= Panel_Dialog_Quest_All and true == Panel_Dialog_Quest_All:GetShow() then
    HandleEventEnter_DialogQuest_All_SelectConfirmReward()
    _AudioPostEvent_SystemUiForXBOX(50, 1)
  end
end
function HandlePadEventB_DailogQuest_All_OnPadB()
  if nil == Panel_Dialog_Quest_All then
    return false
  end
  if false == Panel_Dialog_Quest_All:GetShow() then
    return false
  end
  return true
end
function HandleEventOnOut_DialogQuest_All_RewardTooltip(type, show, questtype, index, key, value)
  local mainText, descText, control
  if "main" == questtype then
    control = PaGlobal_DialogQuest_All._listBaseRewardSlots[index].icon
  else
    control = PaGlobal_DialogQuest_All._listSelectRewardSlots[index].icon
  end
  if true == show and nil ~= control then
    if "Exp" == type then
      mainText = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_EXP")
    elseif "SkillExp" == type then
      mainText = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_SKILLEXP")
    elseif "ExpGrade" == type then
      mainText = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_EXP_GRADE")
    elseif "SkillExpGrade" == type then
      mainText = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_SKILLEXP_GRADE")
    elseif "ProductExp" == type then
      mainText = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_PRODUCTEXP")
    elseif "Intimacy" == type then
      local wrapper = ToClient_GetCharacterStaticStatusWrapper(key)
      local npcName = wrapper:getName()
      mainText = npcName .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_INTIMACY") .. " " .. value
    elseif "Knowledge" == type then
      local mentalCardSSW = ToClinet_getMentalCardStaticStatus(key)
      local mentalCardName = mentalCardSSW:getName()
      local mentalCardDesc = mentalCardSSW:getDesc()
      local mentalCardDescStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARD_TOOLTIP_KNOWLEDGE", "mentalCardName", mentalCardName, "mentalCardName2", mentalCardName)
      TooltipSimple_Show(control, "", mentalCardDescStr)
      return
    elseif "SeasonReward" == type then
      mainText = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_COMPLETE_SEASON")
      descText = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_COMPLETE_SEASON_DESC")
    elseif "ExploreExp" == type then
      mainText = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_EXPLOREEXP")
      descText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_EXPLOREEXP_DESC", "exploreExp", key)
    elseif "FamilyStat" == type then
      mainText = PaGlobalFunc_GetFamiltyStatRewardToolipText_Title()
      descText = PaGlobalFunc_GetFamiltyStatRewardToolipText_Desc(key, value)
    end
    TooltipSimple_Show(control, mainText, descText)
  else
    TooltipSimple_Hide()
    return
  end
end
function PaGlobalFunc_GetFamiltyStatRewardToolipText_Title()
  local mainText = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_FAMILYSTAT")
  return mainText
end
function PaGlobalFunc_GetFamiltyStatRewardToolipText_Desc(familyStatType, value)
  local descText = ""
  if __eFamilySpecialInfoPointType_Offence == familyStatType then
    descText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAMILYSTAT_ITEM_TOOLTIP_1", "value", value)
  elseif __eFamilySpecialInfoPointType_Defence == familyStatType then
    descText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAMILYSTAT_ITEM_TOOLTIP_0", "value", value)
  elseif __eFamilySpecialInfoPointType_Hp == familyStatType then
    descText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAMILYSTAT_ITEM_TOOLTIP_2", "value", value)
  end
  return descText
end
function PaGlobalFunc_GetFamilyStatRewardIconName(familyStatType)
  local iconName = ""
  if __eFamilySpecialInfoPointType_Offence == familyStatType then
    iconName = "Icon/New_Icon/04_PC_Skill/03_Buff/AttackedDamage_UP_All.dds"
  elseif __eFamilySpecialInfoPointType_Defence == familyStatType then
    iconName = "Icon/New_Icon/04_PC_Skill/03_Buff/DefenceUp.dds"
  elseif __eFamilySpecialInfoPointType_Hp == familyStatType then
    iconName = "Icon/New_Icon/04_PC_Skill/03_Buff/MaxHP_Up.dds"
  end
  return iconName
end
function PaGlobalFunc_GetRewardFamilyStatValue(baseRewardWrapper)
  if nil == baseRewardWrapper then
    return
  end
  local familyStatType = baseRewardWrapper:getFamilyStatType()
  local value = 0
  if __eFamilySpecialInfoPointType_Offence == familyStatType then
    value = baseRewardWrapper:getFamilyStatOffencePoint()
  elseif __eFamilySpecialInfoPointType_Defence == familyStatType then
    value = baseRewardWrapper:getFamilyStatDefencePoint()
  elseif __eFamilySpecialInfoPointType_Hp == familyStatType then
    value = baseRewardWrapper:getFamilyStatHp()
  end
  return value
end
function HandlePadEventX_DialogQuest_All_ItemTooltip(itemKey)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemStatic then
    return
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemStatic, Defines.TooltipTargetType.Item, 0)
end
function HandleRSticEvent_DialogQuest_All_MoveScroll(flag)
  if false == PaGlobal_DialogQuest_All._ui.frame_questMain:GetShow() then
    return
  end
  if 1 == flag then
    PaGlobal_DialogQuest_All._ui.frame_VScroll:ControlButtonUp()
  elseif -1 == flag then
    PaGlobal_DialogQuest_All._ui.frame_VScroll:ControlButtonDown()
  end
  PaGlobal_DialogQuest_All._ui.frame_questMain:UpdateContentScroll()
  PaGlobal_DialogQuest_All._ui.frame_questMain:UpdateContentPos()
end
function HandleEventOnOut_DialogQuest_All_SelectRewardCheck(isOn, index)
  if nil == Panel_Dialog_Quest_All then
    return
  end
  if nil == PaGlobal_DialogQuest_All._ui.stc_selectRewardList[index] then
    return
  end
  if index < 0 or index >= PaGlobal_DialogQuest_All._selectRewardCount then
    return
  end
  if true == isOn then
    if true == PaGlobal_DialogQuest_All._isComplete then
      HandleEventLUp_DialogQuest_All_SelectReward(index)
    end
  elseif nil ~= PaGlobal_DialogQuest_All._selectIndex then
    PaGlobal_DialogQuest_All._uiBackSelectRewardCheck[PaGlobal_DialogQuest_All._selectIndex]:AddEffect("UI_Quest_Compensate_Loop", true, 0, 0)
    PaGlobal_DialogQuest_All._uiBackSelectRewardCheck[PaGlobal_DialogQuest_All._selectIndex]:SetCheck(true)
    PaGlobal_DialogQuest_All._ui.stc_selectRewardList[PaGlobal_DialogQuest_All._selectIndex]:setRenderTexture(PaGlobal_DialogQuest_All._selectCheckClickTexture)
  end
end
function PaGlobalFunc_DialogQuest_All_SetRewardList()
  PaGlobal_DialogQuest_All:questDataUpdate()
end
function PaGlobalFunc_DialogQuest_All_DialogShowCheck()
  if 0 < PaGlobal_DialogQuest_All._baseRewardCount or 0 < PaGlobal_DialogQuest_All._selectRewardCount then
    return true
  else
    return false
  end
end
function PaGlobalFunc_DialogQuest_All_GetSelectedRewardItemName()
  if nil ~= PaGlobal_DialogQuest_All._selectRewardItemName then
    return PaGlobal_DialogQuest_All._selectRewardItemName
  else
    return false
  end
end
function PaGlobalFunc_DialogQuest_All_ClearSelectRewardItemName()
  PaGlobal_DialogQuest_All._selectRewardItemNameList = {}
  PaGlobal_DialogQuest_All._selectIndex = nil
end
function PaGlobalFunc_DialogQuest_All_GetSelectRewardPosition()
  local Position = {_PosX = 0, _PosY = 0}
  Position._PosX = PaGlobal_DialogQuest_All._uiBackSelectRewardCheck[0]:GetPosX() + Panel_Dialog_Quest_All:GetPosX() + PaGlobal_DialogQuest_All._uiBackSelectRewardCheck[0]:GetSizeX() / 2
  Position._PosY = PaGlobal_DialogQuest_All._uiBackSelectRewardCheck[0]:GetPosY() + Panel_Dialog_Quest_All:GetPosY() + PaGlobal_DialogQuest_All._uiBackSelectRewardCheck[0]:GetSizeY() / 2
  return Position
end
function PaGlobalFunc_DialogQuest_All_Refuse()
  if nil == Panel_Dialog_Quest_All then
    return
  end
  if true == PaGlobal_DialogQuest_All._isComplete then
    PaGlobalFunc_DialogQuest_All_Close()
    return
  end
  HandleEventLUp_DialogMain_All_QuestRefuse()
end
