local UI_UIType = CppEnums.PAGameUIType
local EmergencySkillKey = 6029313
Panel_SkillCoolTimeQuickSlot:SetShow(false)
PaGlobal_SkillCoolTimeQuickSlot = {
  _panelPool = {},
  _config = {maxPanelCount = 20},
  _slotConfig_Skill = {
    createIcon = true,
    createEffect = true,
    createFG = false,
    createFGDisabled = false,
    createLevel = false,
    createLearnButton = false,
    createCooltime = true,
    createCooltimeText = true,
    template = {effect}
  },
  _skillCoolTimeQuickSlot_PanelID = {
    [0] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_0,
    [1] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_1,
    [2] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_2,
    [3] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_3,
    [4] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_4,
    [5] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_5,
    [6] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_6,
    [7] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_7,
    [8] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_8,
    [9] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_9,
    [10] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_10,
    [11] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_11,
    [12] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_12,
    [13] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_13,
    [14] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_14,
    [15] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_15,
    [16] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_16,
    [17] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_17,
    [18] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_18,
    [19] = UI_UIType.PAGameUIPanel_SkillCoolTimeQuickSlot_19
  },
  _skillCoolTimeQuickSlot_PanelList = {}
}
function PaGlobal_SkillCoolTimeQuickSlot:init()
  if true == _ContentsGroup_UISkillGroupTreeLayOut then
    PaGlobal_SkillCoolTimeQuickSlot._slotConfig_Skill.createEffect = false
  elseif false == _ContentsGroup_RenewUI_Skill then
    PaGlobal_SkillCoolTimeQuickSlot._slotConfig_Skill.template.effect = UI.getChildControl(Panel_Window_Skill, "Static_Icon_Skill_Effect")
  else
    PaGlobal_SkillCoolTimeQuickSlot._slotConfig_Skill.template.effect = PaGlobalFunc_Skill_GetEffectControl()
  end
  for panelIdx = 0, self._config.maxPanelCount - 1 do
    self._panelPool[panelIdx] = {}
    local slot = self._panelPool[panelIdx]
    local panel = UI.createPanel("Panel_SkillCoolTimeQuickSlot_" .. tostring(panelIdx), Defines.UIGroup.PAGameUIGroup_MainUI)
    slot.Panel = panel
    slot.Panel:SetSize(50, 50)
    slot.Panel:SetIgnore(true)
    slot.Panel:SetShow(false)
    slot.PanelPosX = slot.Panel:GetPosX()
    slot.PanelPosY = slot.Panel:GetPosY()
    slot.SlotBG = UI.createAndCopyBasePropertyControl(Panel_SkillCoolTimeQuickSlot, "Static_SlotBG", slot.Panel, "SkillCoolTimeQuickSlot_" .. panelIdx .. "_SlotBG")
    slot.SkillToggle = UI.createAndCopyBasePropertyControl(Panel_SkillCoolTimeQuickSlot, "Static_SkillToggle", slot.Panel, "SkillCoolTimeQuickSlot_" .. panelIdx .. "_SkillToggle")
    slot.SkillToggle:SetShow(false)
    local skillSlot = {}
    SlotSkill.new(skillSlot, panelIdx, slot.SlotBG, self._slotConfig_Skill)
    skillSlot.icon:SetPosX(1)
    skillSlot.icon:SetPosY(1)
    slot.skill = skillSlot
  end
  PaGlobal_SkillCoolTimeQuickSlot:updateQuickSlot()
end
function PaGlobal_SkillCoolTimeQuickSlot:updateQuickSlot()
  for panelIdx = 0, self._config.maxPanelCount - 1 do
    local slotKey = panelIdx
    local skillNo = ToClient_getSkillCoolTimeSlot(slotKey)
    local slot = self._panelPool[panelIdx]
    slot.skill:clearSkill()
    slot.SkillToggle:SetShow(false)
    if 0 == skillNo then
      slot.skill.icon:SetIgnore(true)
    else
      self:updateSkill(panelIdx, skillNo)
      slot.skill.icon:SetIgnore(true)
      if isToggleSkillbySkillKey(skillNo) then
        if checkToggleSkillState(skillNo) then
          slot.SkillToggle:SetShow(true)
        else
          slot.SkillToggle:SetShow(false)
        end
      end
    end
  end
end
function PaGlobal_SkillCoolTimeQuickSlot:updateSkill(panelIdx, skillNo)
  local slot = self._panelPool[panelIdx]
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  slot.skill:setSkillTypeStatic(skillTypeStaticWrapper)
  slot.skill.icon:SetIgnore(true)
end
function PaGlobal_SkillCoolTimeQuickSlot:settingPos(updateByServer)
  local self = PaGlobal_SkillCoolTimeQuickSlot
  for panelIdx = 0, self._config.maxPanelCount - 1 do
    local slot = self._panelPool[panelIdx]
    local relativePosX = ToClient_GetUiInfo(self._skillCoolTimeQuickSlot_PanelID[panelIdx], 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
    local relativePosY = ToClient_GetUiInfo(self._skillCoolTimeQuickSlot_PanelID[panelIdx], 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
    if relativePosX == -1 and relativePosY == -1 then
      local initPosX = getScreenSizeX() * 0.25 + slot.Panel:GetSizeX() * (panelIdx % 2)
      local initPosY = getScreenSizeY() * 0.29 + slot.Panel:GetSizeY() * math.floor(panelIdx / 2)
      slot.Panel:SetPosX(initPosX)
      slot.Panel:SetPosY(initPosY)
    elseif relativePosX == 0 and relativePosY == 0 then
      slot.Panel:SetPosX(getScreenSizeX() * 0.25 + slot.Panel:GetSizeX() * (panelIdx % 2))
      slot.Panel:SetPosY(getScreenSizeY() * 0.29 + slot.Panel:GetSizeY() * math.floor(panelIdx / 2))
    else
      slot.Panel:SetRelativePosX(relativePosX)
      slot.Panel:SetRelativePosY(relativePosY)
      slot.Panel:SetPosX(PaGlobalFunc_CalcPositionByRelativePos(getScreenSizeX() * relativePosX - slot.Panel:GetSizeX() / 2))
      slot.Panel:SetPosY(PaGlobalFunc_CalcPositionByRelativePos(getScreenSizeY() * relativePosY - slot.Panel:GetSizeY() / 2))
    end
    if updateByServer then
      changePositionBySever(slot.Panel, self._skillCoolTimeQuickSlot_PanelID[panelIdx], true, false, false)
    end
    FGlobal_InitPanelRelativePos(slot.Panel, initPosX, initPosY)
    FGlobal_PanelRepostionbyScreenOut(slot.Panel)
  end
end
local onEffectTime = 0
function FGlobal_SkillCoolTimeQuickSlot_UpdatePerFrame(fDeltaTime)
  local self = PaGlobal_SkillCoolTimeQuickSlot
  if fDeltaTime <= 0 then
    return
  end
  onEffectTime = onEffectTime + fDeltaTime
  for panelIdx = 0, self._config.maxPanelCount - 1 do
    local slotKey = panelIdx
    local skillNo = ToClient_getSkillCoolTimeSlot(slotKey)
    local slot = self._panelPool[panelIdx]
    if slot.Panel:GetShow() then
      local skillStaticWrapper = getSkillStaticStatus(skillNo, 1)
      if nil ~= skillStaticWrapper then
        if skillStaticWrapper:isUsableSkill() then
          slot.skill.icon:SetMonoTone(false)
        else
          slot.skill.icon:SetMonoTone(true)
        end
        local remainTime = ToClient_getSkillCooltimebySkillNo(skillNo)
        local isEmmergencySkill = false
        if 0 == remainTime and EmergencySkillKey == skillStaticWrapper:getKey() then
          local selfPlayer = getSelfPlayer()
          if nil ~= selfPlayer then
            remainTime = Int64toInt32(selfPlayer:get():getEmergencyAvoidReusable()) / 1000
            isEmmergencySkill = true
          end
        end
        local skillReuseTime = skillStaticWrapper:get()._reuseCycle / 1000
        local realRemainTime = remainTime * skillReuseTime
        local intRemainTime = realRemainTime - realRemainTime % 1 + 1
        if remainTime > 0 then
          local updateCoolTimeValue = remainTime
          if true == isEmmergencySkill then
            updateCoolTimeValue = remainTime / skillReuseTime
          end
          slot.skill.cooltime:UpdateCoolTime(updateCoolTimeValue)
          slot.skill.cooltime:SetShow(true)
          if true == isEmmergencySkill then
            realRemainTime = remainTime
            intRemainTime = remainTime
          end
          slot.skill.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
          if skillReuseTime >= intRemainTime then
            slot.skill.cooltimeText:SetShow(true)
          else
            slot.skill.cooltimeText:SetShow(false)
          end
        elseif slot.skill.cooltime:GetShow() then
          slot.skill.cooltime:SetShow(false)
          slot.skill.cooltimeText:SetShow(false)
          local skillSlotPosX = slot.skill.cooltime:GetParentPosX()
          local skillSlotPosY = slot.skill.cooltime:GetParentPosY()
          Panel_CoolTime_Effect_Slot:SetShow(true, true)
          Panel_CoolTime_Effect_Slot:SetIgnore(true)
          Panel_CoolTime_Effect_Slot:AddEffect("fUI_Skill_Cooltime01", false, 2.5, 7)
          Panel_CoolTime_Effect_Slot:SetPosX(skillSlotPosX - 7)
          Panel_CoolTime_Effect_Slot:SetPosY(skillSlotPosY - 8)
        end
      end
    end
  end
  if onEffectTime > 3 then
    onEffectTime = 0
  end
end
function FromClient_SkillCoolTimeQuickSlot_SettingPos()
  PaGlobal_SkillCoolTimeQuickSlot:settingPos(true)
end
function FromClient_SkillCoolTimeQuickSlot_DecreaseSkillCooltime(skillNo)
  for panelIdx = 0, PaGlobal_SkillCoolTimeQuickSlot._config.maxPanelCount - 1 do
    local slotSkillNo = ToClient_getSkillCoolTimeSlot(panelIdx)
    if skillNo == slotSkillNo then
      local slot = PaGlobal_SkillCoolTimeQuickSlot._panelPool[panelIdx]
      if nil ~= slot and nil ~= slot.skill.cooltimeText then
        slot.skill.cooltimeText:EraseAllEffect()
        slot.skill.cooltimeText:AddEffect("fUI_SkillCoolTime_01A", false, 0, 0)
        break
      end
    end
  end
end
function FromClient_SkillCoolTimeQuickSlot_DecreaseAllSkillCooltime(exceptSkillNo)
  for panelIdx = 0, PaGlobal_SkillCoolTimeQuickSlot._config.maxPanelCount - 1 do
    local slotSkillNo = ToClient_getSkillCoolTimeSlot(panelIdx)
    if exceptSkillNo ~= slotSkillNo then
      local slot = PaGlobal_SkillCoolTimeQuickSlot._panelPool[panelIdx]
      if nil ~= slot and true == slot.Panel:GetShow() and nil ~= slot.skill and nil ~= slot.skill.cooltimeText then
        local skillStaticWrapper = getSkillStaticStatus(slotSkillNo, 1)
        if nil ~= skillStaticWrapper and false == skillStaticWrapper:isExceptCoolTime() and EmergencySkillKey ~= skillStaticWrapper:getKey() then
          slot.skill.cooltimeText:EraseAllEffect()
          slot.skill.cooltimeText:AddEffect("fUI_SkillCoolTime_01A", false, 0, 0)
        end
      end
    end
  end
end
PaGlobal_SkillCoolTimeQuickSlot:init()
registerEvent("onScreenResize", "FromClient_SkillCoolTimeQuickSlot_SettingPos")
registerEvent("FromClient_ApplyUISettingPanelInfo", "FromClient_SkillCoolTimeQuickSlot_SettingPos")
registerEvent("FromClient_RenderModeChangeState", "FromClient_SkillCoolTimeQuickSlot_SettingPos")
registerEvent("FromClient_DecreaseSkillCooltime", "FromClient_SkillCoolTimeQuickSlot_DecreaseSkillCooltime")
registerEvent("FromClient_DecreaseAllSkillCooltime", "FromClient_SkillCoolTimeQuickSlot_DecreaseAllSkillCooltime")
