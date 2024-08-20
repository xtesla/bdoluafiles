Panel_CoolTime_Effect:SetShow(false, false)
Panel_ArshaSkillCooltime:SetShow(true)
Panel_ArshaSkillCooltime:SetIgnore(true)
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local EmergencySkillKey = 6029313
Panel_CoolTime_Effect:RegisterShowEventFunc(true, "Arsha_SkillCoolTime_Effect_HideAni()")
function Arsha_SkillCoolTime_Effect_HideAni()
  Panel_CoolTime_Effect:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_OUT)
  local coolTime = Panel_CoolTime_Effect:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  coolTime:SetStartColor(UI_color.C_FFFFFFFF)
  coolTime:SetEndColor(UI_color.C_00FFFFFF)
  coolTime:SetStartIntensity(3)
  coolTime:SetEndIntensity(1)
  coolTime.IsChangeChild = true
  coolTime:SetHideAtEnd(true)
  coolTime:SetDisableWhileAni(true)
end
local arshaArshaSkillCooltime = {
  config = {
    slotGapX = 50,
    slotGapY = 50,
    screenPosX = 0.33,
    screenPosY = 0.42
  },
  slotConfig = {
    createIcon = true,
    createEffect = false,
    createFG = false,
    createFGDisabled = false,
    createLevel = false,
    createLearnButton = false,
    createCooltime = true,
    createCooltimeText = true
  },
  slots = {},
  _maxSlotCount = 40,
  redTeam_skillData = {},
  blueTeam_skillData = {}
}
function ArshaSkillCooltime_Init()
  local leftTeamPosX = 0
  local leftTeamPosY = 0
  local rightTeamPosX = 0
  local rightTeamPosY = 0
  if nil ~= Panel_Widget_Arsha_Party_All then
    local left_stc_mainBg = UI.getChildControl(Panel_Widget_Arsha_Party_All, "Static_LeftTeam")
    local left_stc_memberTemplate = UI.getChildControl(left_stc_mainBg, "Static_MemberArea")
    local right_stc_mainBg = UI.getChildControl(Panel_Widget_Arsha_Party_All, "Static_RightTeam")
    local right_stc_memberTemplate = UI.getChildControl(right_stc_mainBg, "Static_MemberArea")
    leftTeamPosX = left_stc_memberTemplate:GetPosX()
    leftTeamPosY = left_stc_memberTemplate:GetParentPosY() + left_stc_memberTemplate:GetSizeY()
    local screenSizeX = getOriginScreenSizeX()
    rightTeamPosX = screenSizeX
    rightTeamPosY = right_stc_memberTemplate:GetParentPosY() + right_stc_memberTemplate:GetSizeY()
  end
  local self = arshaArshaSkillCooltime
  for index = 0, self._maxSlotCount do
    local slot = {}
    SlotSkill.new(slot, index, Panel_ArshaSkillCooltime, self.slotConfig)
    slot.icon:SetIgnore(true)
    if index >= 20 then
      local screenSizeX = getOriginScreenSizeX()
      slot:setPos(rightTeamPosX - slot.icon:GetSizeX() * 1.5, rightTeamPosY + slot.icon:GetPosY() + (index - 20) * self.config.slotGapY)
      slot.skillName = UI.createAndCopyBasePropertyControl(Panel_ArshaSkillCooltime, "StaticText_RightTeam_UsedSkill", slot.icon, "UsedSkill_" .. index)
      slot.skillName:SetPosX(slot.skillName:GetPosX() - slot.icon:GetSizeX() / 10)
    else
      slot:setPos(leftTeamPosX + slot.icon:GetSizeX() / 2, leftTeamPosY + slot.icon:GetPosY() + index * self.config.slotGapY)
      slot.skillName = UI.createAndCopyBasePropertyControl(Panel_ArshaSkillCooltime, "StaticText_LeftTeam_UsedSkill", slot.icon, "UsedSkill_" .. index)
    end
    slot.skillName:SetShow(false)
    slot:clearSkill()
    self.slots[index] = slot
  end
end
Panel_ArshaSkillCooltime:SetShow(true)
local skillReuseTime
function ArshaSkillCooltime_Add(TSkillKey, TSkillNo, teamNo)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(TSkillNo)
  if nil == skillTypeStaticWrapper or true == skillTypeStaticWrapper:isGuildSkill() then
    return
  end
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(TSkillNo)
  if nil == skillTypeStaticWrapper or true == skillTypeStaticWrapper:isGuildSkill() then
    return
  end
  local self = arshaArshaSkillCooltime
  if 1 == teamNo then
    self.redTeam_skillData[TSkillKey] = {}
    self.redTeam_skillData[TSkillKey].remainTime = 0
    self.redTeam_skillData[TSkillKey].skillNo = TSkillNo
  else
    self.blueTeam_skillData[TSkillKey] = {}
    self.blueTeam_skillData[TSkillKey].remainTime = 0
    self.blueTeam_skillData[TSkillKey].skillNo = TSkillNo
  end
end
function ArshaSkillCooltime_OnResize()
  local self = arshaArshaSkillCooltime
  local sizeX = getOriginScreenSizeX()
  local sizeY = getOriginScreenSizeY()
  Panel_ArshaSkillCooltime:SetSize(sizeX, sizeY)
  Panel_ArshaSkillCooltime:ComputePos()
  FGlobal_PanelRepostionbyScreenOut(Panel_ArshaSkillCooltime)
end
function ArshaSkillCooltime_UpdatePerFrame(deltaTime)
  local isReplayMode = ToClient_IsPlayingReplay()
  if false == isReplayMode then
    return
  end
  local self = arshaArshaSkillCooltime
  for idx = 0, self._maxSlotCount do
    self.slots[idx].skillName:SetShow(false)
    self.slots[idx]:clearSkill()
  end
  for idx = 0, 1 do
    local skillKeyList = {}
    local slotCount = 0
    local teamNo = 1
    local skillData
    if idx == 0 then
      skillData = self.redTeam_skillData
    else
      skillData = self.blueTeam_skillData
      slotCount = 20
      teamNo = 2
    end
    for skillIdx = 1, #skillData do
      local slot = self.slots[slotCount]
      local skillKey = 0
      local skillNo = 0
      local attendActorKey = 0
      local remainTime = 0
      if nil ~= skillData[skillIdx] then
        skillKey = skillData[skillIdx].skillKey
        skillNo = skillData[skillIdx].skillNo
        attendActorKey = ToClient_getReplayAttendInfoByTeamNo(teamNo)
        remainTime = ToClient_getOtherSkillCooltimeForReplay(attendActorKey, skillKey)
      end
      if remainTime <= 0 then
        skillKeyList[#skillKeyList + 1] = skillIdx
      else
        local realRemainTime = 0
        local intRemainTime = 0
        local skillReuseTime = 0
        local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
        attendActorKey = ToClient_getReplayAttendInfoByTeamNo(teamNo)
        local level = ToClient_getOtherLearnedSkillLevelForReplay(attendActorKey, skillTypeStaticWrapper)
        local skillStaticWrapper = getSkillStaticStatus(skillNo, level)
        if nil ~= skillStaticWrapper then
          skillReuseTime = skillStaticWrapper:get()._reuseCycle / 1000
        end
        if nil ~= slot then
          slot.icon:SetShow(true)
          slot.skillName:SetShow(true)
          slot:setSkillTypeStatic(skillTypeStaticWrapper)
          slot.cooltime:UpdateCoolTime(remainTime)
          slot.cooltime:SetShow(true)
          realRemainTime = remainTime * skillReuseTime
          intRemainTime = realRemainTime - realRemainTime % 1 + 1
          slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
          if skillReuseTime >= intRemainTime then
            slot.cooltimeText:SetShow(true)
          else
            slot.cooltimeText:SetShow(false)
          end
          local skillName = skillStaticWrapper:getName()
          slot.skillName:SetText(skillName)
          slot.skillName:SetShow(true)
        end
        slotCount = slotCount + 1
      end
    end
    for _, key in pairs(skillKeyList) do
      skillData[key] = nil
    end
  end
end
function ArshaSkillCooltime_Reload()
end
function ArshaSkillCooltime_AllClear()
  local self = arshaArshaSkillCooltime
  for index = 0, self._maxSlotCount do
    self.slots[index]:clearSkill()
    self.slots[index].skillName:SetShow(false)
  end
end
function ArshaSkillCooltime_Update()
  local self = arshaArshaSkillCooltime
  for teamNo = 1, 2 do
    if 1 == teamNo then
      self.redTeam_skillData = {}
    else
      self.blueTeam_skillData = {}
    end
    local checkSkillKey = {}
    local skillCount = 1
    local size = ToClient_getReplayUseSkillDataInfoSizeByTeamNo(teamNo)
    for idx = 1, size do
      local useSkillData = ToClient_getReplayUseSkillDataInfoByIndex(teamNo, idx - 1)
      if nil ~= useSkillData then
        local TSkillKey = useSkillData:getSkillKey()
        local TSkillNo = useSkillData:getSkillNo()
        if nil == checkSkillKey[TSkillKey] then
          local skillTypeStaticWrapper = getSkillTypeStaticStatus(TSkillNo)
          if nil ~= skillTypeStaticWrapper and true ~= skillTypeStaticWrapper:isGuildSkill() then
            if 1 == teamNo then
              self.redTeam_skillData[skillCount] = {}
              self.redTeam_skillData[skillCount].remainTime = 0
              self.redTeam_skillData[skillCount].skillKey = TSkillKey
              self.redTeam_skillData[skillCount].skillNo = TSkillNo
            else
              self.blueTeam_skillData[skillCount] = {}
              self.blueTeam_skillData[skillCount].remainTime = 0
              self.blueTeam_skillData[skillCount].skillKey = TSkillKey
              self.blueTeam_skillData[skillCount].skillNo = TSkillNo
            end
            skillCount = skillCount + 1
            checkSkillKey[TSkillKey] = true
          end
        end
      end
    end
  end
end
function arshaArshaSkillCooltime:registEventHandler()
  Panel_ArshaSkillCooltime:RegisterUpdateFunc("ArshaSkillCooltime_UpdatePerFrame")
end
function arshaArshaSkillCooltime:registMessageHandler()
  registerEvent("FromClient_luaLoadComplete", "ArshaSkillCooltime_Init")
  registerEvent("FromClient_insertReplayArshaSkillSlot", "ArshaSkillCooltime_Add")
  registerEvent("onScreenResize", "ArshaSkillCooltime_OnResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "ArshaSkillCooltime_OnResize")
  registerEvent("EventlearnedSkill", "ArshaSkillCooltime_Reload")
  registerEvent("FromClient_EndReplay", "ArshaSkillCooltime_AllClear")
  registerEvent("FromClient_ClearReplayTeamUi", "ArshaSkillCooltime_AllClear")
  registerEvent("FromClient_updateReplayArshaSkillSlot", "ArshaSkillCooltime_Update")
end
ArshaSkillCooltime_Reload()
arshaArshaSkillCooltime:registEventHandler()
arshaArshaSkillCooltime:registMessageHandler()
registerEvent("FromClient_RenderModeChangeState", "ArshaSkillCooltime_OnResize")
