function PaGlobal_SkillFilter_Open()
  if nil == Panel_Window_SkillFilter_All then
    return
  end
  PaGlobal_SkillFilter_All:prepareOpen()
end
function PaGlobal_SkillFilter_Close()
  if nil == Panel_Window_SkillFilter_All then
    return
  end
  PaGlobal_SkillFilter_All:prepareClose()
end
function PaGlobal_SkillFilter_Toggle()
  if nil == Panel_Window_SkillFilter_All then
    return
  end
  if true == Panel_Window_SkillFilter_All:GetShow() then
    PaGlobal_SkillFilter_All:prepareClose()
  else
    PaGlobal_SkillFilter_All:prepareOpen()
  end
end
function PaGlobal_SkillFilter_GetShow()
  if nil == Panel_Window_SkillFilter_All then
    return false
  end
  return Panel_Window_SkillFilter_All:GetShow()
end
function PaGlobal_SkillFilter_MouseLUpSelectFilter(key)
  if nil == Panel_Window_SkillFilter_All then
    return false
  end
  local self = PaGlobal_SkillFilter_All
  if key == self._selectFilterType then
    self._selectFilterType = 0
    local listContnet = self._ui._filterList:GetContentByKey(toInt64(0, key))
    local rdo = UI.getChildControl(listContnet, "RadioButton_1")
    rdo:SetCheck(false)
  else
    self._selectFilterType = key
  end
  PAGlobal_SkillGroupWindow_UpdateSkillFilter()
end
function PaGlobal_SkillFilter_ResetFilter()
  PaGlobal_SkillFilter_All._selectFilterType = 0
end
function PaGlobalFunc_SkillFilter_All_ListControlCreate(control, key)
  if nil == Panel_Window_SkillFilter_All then
    return
  end
  local self = PaGlobal_SkillFilter_All
  local rdo = UI.getChildControl(control, "RadioButton_1")
  local str_filter = UI.getChildControl(rdo, "StaticText_Icon")
  local stc_icon = UI.getChildControl(rdo, "Static_Icon")
  local key32 = Int64toInt32(key)
  if key32 == self._selectFilterType then
    rdo:SetCheck(true)
  else
    rdo:SetCheck(false)
  end
  rdo:addInputEvent("Mouse_LUp", "PaGlobal_SkillFilter_MouseLUpSelectFilter(" .. tostring(key32) .. ")")
  str_filter:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLFILTER_LIST_" .. key32))
  UI.setLimitTextAndAddTooltip(str_filter)
  if nil ~= self._skillCCTypeConfig._uv[key32] then
    stc_icon:SetShow(true)
    stc_icon:ChangeTextureInfoName(self._skillCCTypeConfig._iconPath)
    local x1, y1, x2, y2 = setTextureUV_Func(stc_icon, self._skillCCTypeConfig._uv[key32].x1, self._skillCCTypeConfig._uv[key32].y1, self._skillCCTypeConfig._uv[key32].x2, self._skillCCTypeConfig._uv[key32].y2)
    stc_icon:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_icon:setRenderTexture(stc_icon:getBaseTexture())
  else
    stc_icon:SetShow(false)
  end
end
function PaGlobalFunc_SkillFilter_All_isFilterSkill(skillSSW, skillNo)
  if nil == skillSSW then
    return false
  end
  local self = PaGlobal_SkillFilter_All
  if self._startCCIndex < self._selectFilterType and true == skillSSW:isSetSkillCCType(self._selectFilterType - self._startCCIndex - 1) then
    return true
  elseif 1 == self._selectFilterType then
    local blackSkillNo = skillSSW:getlinkBlackSkillNo()
    local blackSkillTypeSS = getSkillTypeStaticStatus(blackSkillNo)
    if nil ~= blackSkillTypeSS and blackSkillTypeSS:isValidLocalizing() and blackSkillTypeSS:isUsableClass() then
      return true
    end
  elseif 2 == self._selectFilterType and skillSSW:isActiveSkillHas() and false == skillSSW:isFusionSkill() then
    local activeSkillSS = getActiveSkillStatus(skillSSW)
    if nil ~= activeSkillSS then
      local awakeningDataCount = activeSkillSS:getSkillAwakenInfoCount() - 1
      local realCount = 0
      for idx = 0, awakeningDataCount do
        local skillInfo = activeSkillSS:getSkillAwakenInfo(idx)
        if "" ~= skillInfo then
          realCount = realCount + 1
        end
      end
      return realCount > 0
    end
  end
  return false
end
