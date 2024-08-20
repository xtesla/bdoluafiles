PaGlobal_Servant_PremiumSkillRate = {
  _ui = {
    _stc_SkillListBg = nil,
    _list2_ServantSkill = nil,
    _keyguideBg = nil,
    _keyguide_A = nil,
    _keyguide_B = nil,
    _keyguide_Y = nil
  },
  _skillNameBaseSpanSizeX = 0,
  _keyguideArr = {},
  _selectSkillKey = 0,
  _selectSkillIndex = 0,
  _currentServantNo = nil,
  _sortedSlotNo = nil,
  _formIndex = nil,
  _isConsole = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Servant_PremiumSkillRate")
function FromClient_Servant_PremiumSkillRate()
  PaGlobal_Servant_PremiumSkillRate:initialize()
end
function PaGlobal_Servant_PremiumSkillRate:initialize()
  if nil == Panel_Dialog_Servant_PremiumLookChange then
    return
  end
  self._ui._stc_SkillListBg = UI.getChildControl(Panel_Dialog_Servant_PremiumLookChange, "Static_SkillListBg")
  self._ui._list2_ServantSkill = UI.getChildControl(self._ui._stc_SkillListBg, "List2_ServantSkill")
  self._ui._keyguideBg = UI.getChildControl(Panel_Dialog_Servant_PremiumLookChange, "Static_BottomBg_ConsoleUI")
  self._ui._keyguide_A = UI.getChildControl(self._ui._keyguideBg, "StaticText_A_ConsoleUI")
  self._ui._keyguide_B = UI.getChildControl(self._ui._keyguideBg, "StaticText_B_ConsoleUI")
  self._ui._keyguide_Y = UI.getChildControl(self._ui._keyguideBg, "StaticText_Y_ConsoleUI")
  self._ui._keyguideBg:SetShow(false)
  local tempContent = UI.getChildControl(self._ui._list2_ServantSkill, "List2_1_Content")
  local tempSkillName = UI.getChildControl(tempContent, "StaticText_SkillName")
  self._skillNameBaseSpanSizeX = tempSkillName:GetSpanSize().x
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:registerEvent()
  self:validate()
end
function PaGlobal_Servant_PremiumSkillRate:registerEvent()
  registerEvent("onScreenResize", "FromClient_Servant_PremiumSkillRate_OnScreenResize")
  self._ui._list2_ServantSkill:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_Servant_PremiumSkillRate_List2Update")
  self._ui._list2_ServantSkill:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_Servant_PremiumSkillRate:validate()
  self._ui._stc_SkillListBg:isValidate()
  self._ui._list2_ServantSkill:isValidate()
end
function PaGlobal_Servant_PremiumSkillRate:prepareOpen()
  if false == _ContentsGroup_ServantChangeFormSkillRate then
    return
  end
  local isRateCaculated = ToClient_isCalculatedServantSkillRate(self._currentServantNo, 0, 0, true)
  if false == isRateCaculated then
    return
  end
  self._ui._list2_ServantSkill:getElementManager():clearKey()
  FromClient_Servant_PremiumSkillRate_OnScreenResize()
  local totalCount = ToClient_getServantSkillChangeRateCount(self._currentServantNo, 0, 0, true)
  for skillIdx = 0, totalCount - 1 do
    self._ui._list2_ServantSkill:getElementManager():pushKey(toInt64(0, skillIdx))
    local skillKey = ToClient_getServantSkillChangeRateSkillKeyByIndex(self._currentServantNo, 0, 0, skillIdx, true)
  end
  if true == self._isConsole then
    Panel_Window_MessageBox_All:ignorePadSnapMoveToOtherPanelUpdate(false)
    Panel_Dialog_Servant_PremiumLookChange:ignorePadSnapMoveToOtherPanelUpdate(true)
  end
  PaGlobal_Servant_PremiumSkillRate:open()
end
function PaGlobal_Servant_PremiumSkillRate:open()
  Panel_Dialog_Servant_PremiumLookChange:SetShow(true)
end
function PaGlobal_Servant_PremiumSkillRate:prepareClose()
  self._currentServantNo = nil
  self._sortedSlotNo = nil
  self._formIndex = nil
  if true == self._isConsole then
    Panel_Window_MessageBox_All:ignorePadSnapMoveToOtherPanelUpdate(true)
    Panel_Dialog_Servant_PremiumLookChange:ignorePadSnapMoveToOtherPanelUpdate(false)
  end
  HandleEventLUp_Servant_PremiumSkillRate_SkillRateTooltip()
  PaGlobal_Servant_PremiumSkillRate:close()
end
function PaGlobal_Servant_PremiumSkillRate:close()
  Panel_Dialog_Servant_PremiumLookChange:SetShow(false)
end
function PaGlobalFunc_Servant_PremiumSkillRate_Open(servantNo, sortedSlotNo, formIndex)
  local servantInfo = stable_getServant(servantNo)
  if nil == servantInfo then
    return
  end
  PaGlobal_Servant_PremiumSkillRate._currentServantNo = servantNo
  PaGlobal_Servant_PremiumSkillRate._sortedSlotNo = sortedSlotNo
  PaGlobal_Servant_PremiumSkillRate._formIndex = formIndex
  PaGlobal_Servant_PremiumSkillRate:prepareOpen()
end
function PaGlobalFunc_Servant_PremiumSkillRate_Close()
  if true == Panel_Window_MessageBox_All:GetShow() then
    messageBox_CancelButtonUp()
  end
  PaGlobal_Servant_PremiumSkillRate:prepareClose()
end
function FromClient_Servant_PremiumSkillRate_List2Update(content, key)
  if nil == PaGlobal_Servant_PremiumSkillRate._currentServantNo then
    return
  end
  local servantInfo = stable_getServant(PaGlobal_Servant_PremiumSkillRate._currentServantNo)
  if nil == servantInfo then
    return
  end
  local key32 = Int64toInt32(key)
  local stc_SkillSlotBg = UI.getChildControl(content, "Static_SkillSlotBg")
  local unLearn_expBg = UI.getChildControl(content, "Static_SkillExpBg")
  local unLearn_circle_Prog2_Exp = UI.getChildControl(content, "CircularProgress_SkillExp")
  local unLearn_skillIcon = UI.getChildControl(content, "Static_SkillIcon")
  local unLearn_skillExpPercent = UI.getChildControl(content, "StaticText_SkillExpPercent")
  local unLearn_skillName = UI.getChildControl(content, "StaticText_SkillName")
  local unLearn_skillCommand = UI.getChildControl(content, "StaticText_SkillCommandValue")
  local unLearn_skillStallionIcon = UI.getChildControl(content, "Static_SkillStallionIcon")
  local stc_vertiLine = UI.getChildControl(content, "Static_VerticalLine1")
  local txt_changeRate = UI.getChildControl(content, "StaticText_Rate")
  stc_vertiLine:SetShow(false)
  txt_changeRate:SetShow(false)
  stc_SkillSlotBg:SetShow(false)
  unLearn_circle_Prog2_Exp:SetShow(false)
  unLearn_skillExpPercent:SetShow(false)
  unLearn_expBg:SetShow(false)
  unLearn_skillIcon:addInputEvent("Mouse_On", "")
  unLearn_skillIcon:addInputEvent("Mouse_Out", "")
  local skillKey = ToClient_getServantSkillChangeRateSkillKeyByIndex(PaGlobal_Servant_PremiumSkillRate._currentServantNo, 0, 0, key32, true)
  local skillWrapper = servantInfo:getSkillXXX(skillKey)
  if nil ~= skillWrapper then
    stc_SkillSlotBg:SetShow(true)
    unLearn_skillIcon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
    local isStallionSkill = servantInfo:isStallionSkill(skillWrapper:getKey())
    unLearn_skillStallionIcon:SetShow(isStallionSkill)
    local skillNameSpanSizeX = PaGlobal_Servant_PremiumSkillRate._skillNameBaseSpanSizeX
    if true == isStallionSkill then
      local gabX = 5
      skillNameSpanSizeX = skillNameSpanSizeX + unLearn_skillStallionIcon:GetSizeX() - gabX
      if false == PaGlobal_Servant_PremiumSkillRate._isConsole then
        unLearn_skillStallionIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Servant_PremiumSkillRate_ShowStallionToolTip(true)")
        unLearn_skillStallionIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Servant_PremiumSkillRate_ShowStallionToolTip(false)")
      end
    end
    unLearn_skillName:SetSpanSize(skillNameSpanSizeX, unLearn_skillName:GetSpanSize().y)
    unLearn_skillName:SetText(skillWrapper:getName())
    unLearn_skillCommand:SetTextMode(__eTextMode_AutoWrap)
    unLearn_skillCommand:SetText(skillWrapper:getDescription())
    if true == PaGlobal_Servant_PremiumSkillRate._isConsole then
      unLearn_skillIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Servant_PremiumSkillRate_ApplyPrimiumChange()")
      unLearn_skillIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Servant_PremiumSkillRate_SnappingSkill(true," .. key32 .. "," .. skillKey .. ")")
      unLearn_skillIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Servant_PremiumSkillRate_SnappingSkill(false)")
    else
      unLearn_skillIcon:addInputEvent("Mouse_On", "HandleEventLUp_Servant_PremiumSkillRate_SkillRateTooltip(" .. key32 .. "," .. skillKey .. "," .. PaGlobal_Servant_PremiumSkillRate._currentServantNo .. ")")
      unLearn_skillIcon:addInputEvent("Mouse_Out", "HandleEventLUp_Servant_PremiumSkillRate_SkillRateTooltip()")
    end
  end
  local rate = ToClient_getServantSkillChangeRate(PaGlobal_Servant_PremiumSkillRate._currentServantNo, 0, 0, skillKey, true)
  rate = rate * 100
  local calculratedRate = string.format("%.2f", rate) .. "%"
  txt_changeRate:SetText(calculratedRate)
  stc_vertiLine:SetShow(true)
  txt_changeRate:SetShow(true)
end
function FromClient_Servant_PremiumSkillRate_OnScreenResize()
  if nil == Panel_Dialog_Servant_PremiumLookChange then
    return
  end
  Panel_Dialog_Servant_PremiumLookChange:ComputePos()
  if true == PaGlobal_Servant_PremiumSkillRate._isConsole then
    PaGlobal_Servant_PremiumSkillRate._ui._keyguide_A:SetShow(false)
    PaGlobal_Servant_PremiumSkillRate._ui._keyguide_B:SetShow(false)
    PaGlobal_Servant_PremiumSkillRate._keyguideArr = {
      PaGlobal_Servant_PremiumSkillRate._ui._keyguide_Y,
      PaGlobal_Servant_PremiumSkillRate._ui._keyguide_A,
      PaGlobal_Servant_PremiumSkillRate._ui._keyguide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_Servant_PremiumSkillRate._keyguideArr, PaGlobal_Servant_PremiumSkillRate._ui._keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    PaGlobal_Servant_PremiumSkillRate._ui._keyguideBg:SetShow(true)
  end
  if nil ~= Panel_Window_MessageBox_All and true == Panel_Window_MessageBox_All:GetShow() then
    Panel_Dialog_Servant_PremiumLookChange:SetPosXY(Panel_Window_MessageBox_All:GetPosX() + Panel_Window_MessageBox_All:GetSizeX() + 15, Panel_Window_MessageBox_All:GetPosY())
  end
end
function HandleEventOnOut_Servant_PremiumSkillRate_ShowStallionToolTip(isShow)
  if false == isShow or nil == Panel_Dialog_Servant_PremiumLookChange then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STALLIONSKILL_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STALLIONSKILL_TOOLTIP_DESC")
  TooltipSimple_CommonShow(name, desc)
  TooltipSimple_Common_Pos(Panel_Dialog_Servant_PremiumLookChange:GetPosX() + Panel_Dialog_Servant_PremiumLookChange:GetSizeX(), Panel_Dialog_Servant_PremiumLookChange:GetPosY())
end
function HandleEventLUp_Servant_PremiumSkillRate_SkillRateTooltip(index, skillKey, currentServantNo)
  if nil == index or nil == skillKey then
    if true == _ContentsGroup_NewUI_Tooltip_All and nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
      PaGlobal_Tooltip_Skill_Servant_All_Close()
    elseif nil ~= PaGlobal_Tooltip_Servant_Close then
      PaGlobal_Tooltip_Servant_Close()
    end
    return
  end
  if nil == currentServantNo then
    return
  end
  if nil == skillKey then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local skillWrapper = servantInfo:getSkillXXX(skillKey)
  if nil == skillWrapper then
    return
  end
  local content = PaGlobal_Servant_PremiumSkillRate._ui._list2_ServantSkill:GetContentByKey(toInt64(0, index))
  if nil == content then
    return
  end
  local skillIcon = UI.getChildControl(content, "Static_SkillIcon")
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Open then
      PaGlobal_Tooltip_Skill_Servant_All_Open(skillWrapper, skillIcon, false)
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Open then
    local isShowStallionSkillTooltip = false
    if true == PaGlobal_Servant_PremiumSkillRate._isConsole then
      isShowStallionSkillTooltip = servantInfo:isStallionSkill(skillWrapper:getKey())
    end
    PaGlobal_Tooltip_Servant_Open(skillWrapper, skillIcon, false, isShowStallionSkillTooltip)
    if true == PaGlobal_Servant_PremiumSkillRate._isConsole and nil ~= Panel_Dialog_Servant_PremiumLookChange and nil ~= PaGlobal_Tooltip_Servant_SetPos then
      local posX = Panel_Dialog_Servant_PremiumLookChange:GetPosX() + Panel_Dialog_Servant_PremiumLookChange:GetSizeX()
      if nil ~= Panel_Tooltip_Skill_Servant then
        local screenSizeX = getScreenSizeX()
        local tooltipSizeX = Panel_Tooltip_Skill_Servant:GetSizeX()
        if screenSizeX <= posX + tooltipSizeX then
          posX = screenSizeX - tooltipSizeX
        end
      end
      PaGlobal_Tooltip_Servant_SetPos(posX, Panel_Dialog_Servant_PremiumLookChange:GetPosY())
    end
  end
end
function HandleEventLUp_Servant_PremiumSkillRate_ApplyPrimiumChange()
  if false == PaGlobal_Servant_PremiumSkillRate._isConsole then
    return
  end
  if nil == PaGlobal_Servant_PremiumSkillRate._sortedSlotNo or nil == PaGlobal_Servant_PremiumSkillRate._formIndex then
    PaGlobalFunc_Servant_PremiumSkillRate_Close()
    return
  end
  stable_changeForm(PaGlobal_Servant_PremiumSkillRate._sortedSlotNo, PaGlobal_Servant_PremiumSkillRate._formIndex, 1, true)
  PaGlobalFunc_ServantList_All_Update()
  PaGlobalFunc_ServantLookChange_All_Close()
  PaGlobalFunc_Servant_PremiumSkillRate_Close()
end
function HandleEventOnOut_Servant_PremiumSkillRate_SnappingSkill(isOn, key32, skillKey)
  if nil == Panel_Dialog_Servant_PremiumLookChange and false == Panel_Dialog_Servant_PremiumLookChange:GetShow() then
    return
  end
  if false == PaGlobal_Servant_PremiumSkillRate._isConsole then
    return
  end
  if nil == key32 or nil == skillKey or nil == isOn or false == isOn then
    HandleEventLUp_Servant_PremiumSkillRate_SkillRateTooltip()
    Panel_Dialog_Servant_PremiumLookChange:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    PaGlobal_Servant_PremiumSkillRate._ui._keyguideBg:SetShow(false)
  else
    PaGlobal_Servant_PremiumSkillRate._selectSkillKey = skillKey
    PaGlobal_Servant_PremiumSkillRate._selectSkillIndex = key32
    Panel_Dialog_Servant_PremiumLookChange:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventOnOut_Servant_PremiumSkillRate_ShowSkillTooltipByPad()")
    PaGlobal_Servant_PremiumSkillRate._ui._keyguideBg:SetShow(true)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_Servant_PremiumSkillRate._keyguideArr, PaGlobal_Servant_PremiumSkillRate._ui._keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function HandleEventOnOut_Servant_PremiumSkillRate_ShowSkillTooltipByPad()
  if false == PaGlobal_Servant_PremiumSkillRate._isConsole then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_GetShow and true == PaGlobal_Tooltip_Skill_Servant_All_GetShow() then
      HandleEventLUp_Servant_PremiumSkillRate_SkillRateTooltip()
    else
      HandleEventLUp_Servant_PremiumSkillRate_SkillRateTooltip(PaGlobal_Servant_PremiumSkillRate._selectSkillIndex, PaGlobal_Servant_PremiumSkillRate._selectSkillKey, PaGlobal_Servant_PremiumSkillRate._currentServantNo)
    end
  elseif nil ~= Panel_Tooltip_Skill_Servant and true == Panel_Tooltip_Skill_Servant:GetShow() then
    HandleEventLUp_Servant_PremiumSkillRate_SkillRateTooltip()
  else
    HandleEventLUp_Servant_PremiumSkillRate_SkillRateTooltip(PaGlobal_Servant_PremiumSkillRate._selectSkillIndex, PaGlobal_Servant_PremiumSkillRate._selectSkillKey, PaGlobal_Servant_PremiumSkillRate._currentServantNo)
  end
end
