function InputEventMLUp_GuildSkill_All_SkillTooltip(skillNo)
  if PaGlobal_GuildSkill_All._isConsole then
    PaGlobal_GuildSkill_All._ui.frame_GuildSkill:UpdateContentScroll()
  end
  PaGlobal_GuildSkill_All:updateToolTip(skillNo)
  PaGlobal_GuildSkill_All.skillNoSlot[skillNo].icon:EraseAllEffect()
end
function InputEventMOn_GuildSkill_All_ShowSkillTooltip(skillNo, SlotType, isShow)
  if _ContentsGroup_RenewUI_Tooltip then
    return
  end
  if false == isShow then
    Panel_SkillTooltip_Hide()
    return
  end
  Panel_SkillTooltip_Show(skillNo, false, SlotType)
  PaGlobal_GuildSkill_All.skillNoSlot[skillNo].icon:EraseAllEffect()
end
function InputEventLUp_GuildSkill_All_UseSkill(skillNo)
  ToClient_RequestUseGuildSkill(skillNo)
end
function InputEventLUp_GuildSkill_All_LearnSkill(skillNo)
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local isRightLearnSkill = PaGlobalFunc_GuildSkill_All_RightCheck(__eGuildRightType_LearnGuildSkill)
  if false == isRightLearnSkill then
    return
  end
  local accumulateTax_s32 = Int64toInt32(myGuildInfo:getAccumulateTax())
  local accumulateCost_s32 = Int64toInt32(myGuildInfo:getAccumulateGuildHouseCost())
  if accumulateTax_s32 > 0 or accumulateCost_s32 > 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_RECRUITMENT_TAXFIRST"))
    return
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil == skillLevelInfo then
    return
  end
  if false == skillLevelInfo._learnable then
    return
  end
  local function doLearnGuildSkill()
    local isSuccess = ToClient_RequestLearnGuildSkill(skillNo)
    audioPostEvent_SystemUi(0, 0)
    _AudioPostEvent_SystemUiForXBOX(50, 0)
    if isSuccess then
      PaGlobal_GuildSkill_All.skillNoSlot[skillNo].icon:AddEffect("UI_NewSkill01", false, 0, 0)
      PaGlobal_GuildSkill_All.skillNoSlot[skillNo].icon:AddEffect("fUI_NewSkill01", false, 0, 0)
      if true == PaGlobal_GuildSkill_All._isConsole then
        InputEventMOn_GuildSkill_All_SetKeyGuideA(skillNo)
      end
    end
    return
  end
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_RECRUITMENT_SKILLSTUDY")
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = doLearnGuildSkill,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "middle")
end
function InputEventMOn_GuildSkill_All_SetKeyGuideA(skillNo)
  if false == PaGlobal_GuildSkill_All._isConsole then
    return
  end
  local isUseableSkill = false
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil ~= skillLevelInfo then
    local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
    if nil ~= skillTypeStaticWrapper then
      isUseableSkill = not skillLevelInfo._learnable and skillLevelInfo._usable and skillTypeStaticWrapper:get():isActiveSkill()
    end
  end
  local isRightLearnSkill = PaGlobalFunc_GuildSkill_All_RightCheck(__eGuildRightType_LearnGuildSkill)
  if PaGlobal_GuildSkill_All.skillNoSlot[skillNo].learnButton:GetShow() and true == isRightLearnSkill then
    PaGlobal_GuildMain_All:setKeyguideTextWithShow(true, __eConsoleUIPadEvent_A, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENABLESKILL_LEARNSKILL_BTN"))
  elseif true == isUseableSkill then
    PaGlobal_GuildMain_All:setKeyguideTextWithShow(true, __eConsoleUIPadEvent_A, PAGetString(Defines.StringSheet_GAME, "LUA_ANSWERSKILL_MESSAGEBOX_TITLE"))
  else
    PaGlobal_GuildMain_All:setKeyguideTextWithShow(false, __eConsoleUIPadEvent_A)
  end
  PaGlobal_GuildSkill_All:updateTargetScroll(skillNo)
end
function PaGlobalFunc_Guild_Skill_All_UpdateTab()
  PaGlobal_GuildSkill_All:openTab()
end
function PaGlobalFunc_Guild_Skill_All_Update()
  PaGlobal_GuildSkill_All:update()
end
function PaGlobalFunc_GuildSkill_All_RightCheck(eRightType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  local function OriginalCheck()
    local isGuildMaster = selfPlayer:get():isGuildMaster()
    if false == isGuildMaster then
      return false
    end
    return true
  end
  if false == _ContentsGroup_GuildRightInfo then
    return OriginalCheck()
  end
  local isDefineRightType = ToClient_IsDefineGuildRightType(eRightType)
  if false == isDefineRightType then
    return OriginalCheck()
  end
  return ToClient_IsCheckGuildRightType(eRightType)
end
function PaGlobalFunc_GuildSkill_All_CoolTimeUpdatePerFrame(deltaTime)
  PaGlobal_GuildSkill_All._effectTime = PaGlobal_GuildSkill_All._effectTime + deltaTime
  if PaGlobal_GuildSkill_All._effectMaxTime < PaGlobal_GuildSkill_All._effectTime then
    PaGlobal_GuildSkill_All._effectTime = 0
    for skillNo, slot in pairs(PaGlobal_GuildSkill_All.slots) do
      PaGlobal_GuildSkill_All:updateGuildSkillCoolTime(skillNo)
    end
  end
end
function HandleEventLUp_GuildSkill_StartDrag(skillNo)
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil ~= skillLevelInfo and nil ~= skillTypeStaticWrapper then
    DragManager:setDragInfo(Panel_GuildSkill_All, nil, skillLevelInfo._skillKey:get(), "Icon/" .. skillTypeStaticWrapper:getIconPath(), SkillGroup_GroundClick, nil)
  end
end
