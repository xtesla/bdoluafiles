Panel_Tooltip_Skill_Servant:SetShow(false)
local PaGlobal_Tooltip_Servant = {
  _ui = {
    _txt_SkillName = UI.getChildControl(Panel_Tooltip_Skill_Servant, "Tooltip_Skill_Name"),
    _stc_SkillIcon = UI.getChildControl(Panel_Tooltip_Skill_Servant, "Tooltip_Skill_Icon"),
    _txt_SkillCommandDesc = UI.getChildControl(Panel_Tooltip_Skill_Servant, "StaticText_Description_Value"),
    _txt_SkillDesc = UI.getChildControl(Panel_Tooltip_Skill_Servant, "StaticText_2"),
    _txt_StallionSkillTitle = UI.getChildControl(Panel_Tooltip_Skill_Servant, "StaticText_StallionSkill_Title"),
    _txt_StallionSkillDesc = UI.getChildControl(Panel_Tooltip_Skill_Servant, "StaticText_StallionSkill_Desc"),
    _txt_SkillCondition_Title = UI.getChildControl(Panel_Tooltip_Skill_Servant, "StaticText_Condition_Title"),
    _txt_SkillCondition_Value = UI.getChildControl(Panel_Tooltip_Skill_Servant, "StaticText_Condition_Value"),
    _stc_DescBG = UI.getChildControl(Panel_Tooltip_Skill_Servant, "Static_DescBG")
  },
  slotData = {}
}
function PaGlobal_Tooltip_Servant:Init()
  self._ui._txt_SkillName:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_SkillCommandDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_SkillDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_SkillCondition_Value:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_StallionSkillTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_StallionSkillTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STALLIONSKILL_TOOLTIP_TITLE"))
  self._ui._txt_StallionSkillDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_StallionSkillDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STALLIONSKILL_TOOLTIP_DESC"))
end
function PaGlobal_Tooltip_Servant:Open(skillInfo, slot, isSlotIcon, isShowStallionSkillTooltip)
  if nil == skillInfo then
    return
  end
  local skillWrapper = skillInfo
  if nil ~= skillWrapper then
    local skillIcon = skillWrapper:getIconPath()
    local skillName = skillWrapper:getName()
    local skillCommandDesc = skillWrapper:getDescription()
    local skillDesc = skillWrapper:getDescription2()
    local skillCondition = skillWrapper:getConditionDescription()
    self._ui._stc_SkillIcon:ChangeTextureInfoName("Icon/" .. skillIcon)
    self._ui._txt_SkillName:SetText(skillName)
    self._ui._txt_SkillCommandDesc:SetText(skillCommandDesc)
    self._ui._txt_SkillDesc:SetSize(self._ui._txt_SkillCommandDesc:GetSizeX(), self._ui._txt_SkillDesc:GetSizeY())
    self._ui._txt_SkillDesc:SetText(skillDesc)
    self._ui._txt_SkillDesc:SetPosXY(self._ui._txt_SkillCommandDesc:GetPosX(), self._ui._txt_SkillCommandDesc:GetPosY() + self._ui._txt_SkillCommandDesc:GetTextSizeY())
    self._ui._txt_SkillDesc:SetTextHorizonLeft()
    self._ui._txt_SkillDesc:SetTextVerticalTop()
    self._ui._txt_SkillDesc:SetShow(true)
    local stallionSkillTextSizeY = 0
    local skillConditionPosY = self._ui._txt_SkillDesc:GetPosY() + self._ui._txt_SkillDesc:GetTextSizeY() + 10
    if nil ~= isShowStallionSkillTooltip and true == isShowStallionSkillTooltip then
      self._ui._txt_StallionSkillTitle:SetShow(true)
      self._ui._txt_StallionSkillTitle:SetPosY(skillConditionPosY + 10)
      stallionSkillTextSizeY = self._ui._txt_StallionSkillTitle:GetTextSizeY() + 10
      self._ui._txt_StallionSkillDesc:SetShow(true)
      self._ui._txt_StallionSkillDesc:SetPosY(self._ui._txt_StallionSkillTitle:GetPosY() + self._ui._txt_StallionSkillTitle:GetTextSizeY() + 20)
      skillConditionPosY = self._ui._txt_StallionSkillDesc:GetPosY() + self._ui._txt_StallionSkillDesc:GetTextSizeY() + 10
      stallionSkillTextSizeY = stallionSkillTextSizeY + self._ui._txt_StallionSkillDesc:GetTextSizeY() + 30
    else
      self._ui._txt_StallionSkillTitle:SetShow(false)
      self._ui._txt_StallionSkillDesc:SetShow(false)
    end
    if "" ~= skillCondition then
      self._ui._txt_SkillCondition_Title:SetShow(true)
      self._ui._txt_SkillCondition_Title:SetText("<PAColor0xFFEEEEEE>" .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TOOLTIP_NEED_BEFORE_RUN_SKILL") .. "<PAOldColor>")
      self._ui._txt_SkillCondition_Title:SetPosY(skillConditionPosY)
      self._ui._txt_SkillCondition_Value:SetShow(true)
      self._ui._txt_SkillCondition_Value:SetText(skillCondition)
      self._ui._txt_SkillCondition_Value:SetPosY(self._ui._txt_SkillCondition_Title:GetPosY() + self._ui._txt_SkillCondition_Title:GetTextSizeY() + 10)
      self._ui._stc_DescBG:SetSize(self._ui._stc_DescBG:GetSizeX(), self._ui._txt_SkillCommandDesc:GetTextSizeY() + self._ui._txt_SkillDesc:GetTextSizeY() + self._ui._txt_SkillCondition_Title:GetTextSizeY() + self._ui._txt_SkillCondition_Value:GetTextSizeY() + stallionSkillTextSizeY + 40)
    else
      self._ui._txt_SkillCondition_Title:SetShow(false)
      self._ui._txt_SkillCondition_Value:SetShow(false)
      self._ui._stc_DescBG:SetSize(self._ui._stc_DescBG:GetSizeX(), self._ui._txt_SkillCommandDesc:GetTextSizeY() + self._ui._txt_SkillDesc:GetTextSizeY() + stallionSkillTextSizeY + 20)
    end
  end
  Panel_Tooltip_Skill_Servant:SetSize(Panel_Tooltip_Skill_Servant:GetSizeX(), self._ui._stc_DescBG:GetPosY() + self._ui._stc_DescBG:GetSizeY() + 5)
  if self:isServantInfoGetShow() then
    if true == isSlotIcon then
      Panel_Tooltip_Skill_Servant:SetPosX(slot.icon:GetParentPosX() + slot.icon:GetSizeX() + 10)
      Panel_Tooltip_Skill_Servant:SetPosY(slot.icon:GetParentPosY())
    else
      Panel_Tooltip_Skill_Servant:SetPosX(slot:GetParentPosX() + slot:GetSizeX() + 10)
      Panel_Tooltip_Skill_Servant:SetPosY(slot:GetParentPosY())
    end
  elseif true == isSlotIcon then
    Panel_Tooltip_Skill_Servant:SetPosX(slot.icon:GetParentPosX() - Panel_Tooltip_Skill_Servant:GetSizeX() - 10)
    Panel_Tooltip_Skill_Servant:SetPosY(slot.icon:GetParentPosY())
  else
    Panel_Tooltip_Skill_Servant:SetPosX(slot:GetParentPosX() + slot:GetSizeX() + 10)
    Panel_Tooltip_Skill_Servant:SetPosY(slot:GetParentPosY())
  end
  Panel_Tooltip_Skill_Servant:SetShow(true)
end
function PaGlobal_Tooltip_Servant:isServantInfoGetShow()
  if true == _ContentsGroup_NewUI_ServantInfo_All then
    return PaGlobal_VehicleInfo_All_GetPanelShow()
  else
    return Panel_Window_ServantInfo:GetShow()
  end
end
function PaGlobal_Tooltip_Servant_SetPos(posX, posY)
  if nil == Panel_Tooltip_Skill_Servant or false == Panel_Tooltip_Skill_Servant:GetShow() then
    return
  end
  if nil ~= posX then
    Panel_Tooltip_Skill_Servant:SetPosX(posX)
  end
  if nil ~= posY then
    Panel_Tooltip_Skill_Servant:SetPosY(posY)
  end
end
function PaGlobal_Tooltip_Servant:Close()
  Panel_Tooltip_Skill_Servant:SetShow(false)
end
function PaGlobal_Tooltip_Servant_Open(actorKeyRaw, slot, isSlotIcon, isShowStallionSkillTooltip)
  PaGlobal_Tooltip_Servant:Open(actorKeyRaw, slot, isSlotIcon, isShowStallionSkillTooltip)
end
function PaGlobal_Tooltip_Servant_Close()
  PaGlobal_Tooltip_Servant:Close()
end
PaGlobal_Tooltip_Servant:Init()
