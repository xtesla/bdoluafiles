function PaGlobal_ReinforceSkill_All:initialize()
  if true == PaGlobal_ReinforceSkill_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_ReinforceSkill_All, "Static_Title")
  self._ui.btn_Help = UI.getChildControl(self._ui.stc_titleBg, "Button_Help")
  self._ui.btn_Help:SetShow(false)
  self._ui.btn_Help:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelSkillAwaken\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._ui.btn_Help, "\"PanelSkillAwaken\"")
  self._ui.btn_Exit = UI.getChildControl(self._ui.stc_titleBg, "Button_Exit")
  self._ui.btn_Exit:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_ReinforceSkill_All_Close()")
  self._ui.btn_Exit:SetShow(not self._isConsole)
  self._ui.stc_NormalSkillBG = UI.getChildControl(Panel_Window_ReinforceSkill_All, "Static_NormalSkillBG")
  self._ui.txt_NormalSkill = UI.getChildControl(self._ui.stc_NormalSkillBG, "StaticText_NormalSkill")
  self._ui.stc_NormalSkillList = UI.getChildControl(self._ui.stc_NormalSkillBG, "Static_NormalSkill_List")
  self._ui.stc_SpecialSkillBg = UI.getChildControl(Panel_Window_ReinforceSkill_All, "Static_SpecialSkillBG")
  self._ui.txt_SpecialSkill = UI.getChildControl(self._ui.stc_SpecialSkillBg, "StaticText_SpecialSkill")
  self._ui.stc_SpecialSkillList = UI.getChildControl(self._ui.stc_SpecialSkillBg, "Static_SpecialSkill_List")
  self._ui.txt_NoSkill = UI.getChildControl(self._ui.stc_SpecialSkillBg, "StaticText_NoSkill")
  self._ui.stc_InfoBg = UI.getChildControl(Panel_Window_ReinforceSkill_All, "Static_InfoBG")
  self._ui.txt_Info = UI.getChildControl(self._ui.stc_InfoBg, "StaticText_Info")
  self._ui_console.stc_keyGuideBg = UI.getChildControl(Panel_Window_ReinforceSkill_All, "Static_KeyGuideBg_ConsoleUI")
  self._ui_console.stc_keyGuideSelect = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Select")
  self._ui_console.stc_keyGuideClose = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Close")
  self._ui_console.stc_keyGuideReinforce = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Reinforce")
  self._ui_console.stc_keyGuideDetail = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Detail")
  PaGlobal_ReinforceSkill_All:validate()
  PaGlobal_ReinforceSkill_All:registEventHandler()
  PaGlobal_ReinforceSkill_All:NormalSlotInit()
  PaGlobal_ReinforceSkill_All:specialSlotInit()
  PaGlobal_ReinforceSkill_All:setNotice()
  Panel_Window_ReinforceSkill_All:ComputePos()
  PaGlobal_ReinforceSkill_All._initialize = true
end
function PaGlobal_ReinforceSkill_All:setNotice()
  local padding = 30
  local panelSizeY = Panel_Window_ReinforceSkill_All:GetSizeY() - self._ui.stc_InfoBg:GetSizeY()
  self._ui.txt_Info:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Info:SetText(self._ui.txt_Info:GetText())
  self._ui.txt_Info:SetSize(self._ui.txt_Info:GetSizeX(), self._ui.txt_Info:GetTextSizeY())
  self._ui.stc_InfoBg:SetSize(self._ui.stc_InfoBg:GetSizeX(), self._ui.txt_Info:GetSizeY() + padding)
  panelSizeY = panelSizeY + self._ui.stc_InfoBg:GetSizeY()
  Panel_Window_ReinforceSkill_All:SetSize(Panel_Window_ReinforceSkill_All:GetSizeX(), panelSizeY)
  self._ui.stc_InfoBg:ComputePos()
  self._ui.txt_Info:ComputePos()
  self._ui_console.stc_keyGuideBg:ComputePos()
end
function PaGlobal_ReinforceSkill_All:NormalSlotInit()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  if true == _ContentsGroup_TotalSkillReininforce and false == isGameTypeKR2() then
    self._reinforceNormalSkillViewCount = 6
  else
    self._reinforceNormalSkillViewCount = 3
    Panel_Window_ReinforceSkill_All:SetSize(Panel_Window_ReinforceSkill_All:GetSizeX(), 845)
    self._ui.stc_NormalSkillBG:SetSize(self._ui.stc_NormalSkillBG:GetSizeX(), 330)
    self._ui.stc_InfoBg:SetSize(self._ui.stc_InfoBg:GetSizeX(), 95)
    self._ui.stc_InfoBg:SetSpanSize(self._ui.stc_InfoBg:GetSpanSize().x, 739)
    self._ui.txt_NormalSkill:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_NORMAL"))
  end
  local isClassType = selfPlayerWrapper:getClassType()
  local normalSkillBasePosY = self._ui.stc_NormalSkillList:GetSpanSize().y
  local normalSkillBgSizeY = self._ui.stc_NormalSkillList:GetSizeY()
  local normalSkillGapY = 8
  for index = 0, self._reinforceNormalSkillViewCount - 1 do
    self._reinforceNormalSkillControl[index] = {}
    self._reinforceNormalSkillControl[index]._skillBg = UI.cloneControl(self._ui.stc_NormalSkillList, self._ui.stc_NormalSkillBG, "ReinforceNormalSkill_Bg_" .. index)
    local SpanY = normalSkillBasePosY + (normalSkillBgSizeY + normalSkillGapY) * index
    self._reinforceNormalSkillControl[index]._skillBg:SetSpanSize(self._reinforceNormalSkillControl[index]._skillBg:GetSpanSize().x, SpanY)
    self._reinforceNormalSkillControl[index]._skillSlotBg = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillBg, "Static_SkillSlotBG")
    self._reinforceNormalSkillControl[index]._skillIconBg = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillSlotBg, "Static_SkillIconBG")
    self._reinforceNormalSkillControl[index]._skillIcon = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillSlotBg, "Static_SkillIcon")
    self._reinforceNormalSkillControl[index]._skillIcon:SetIgnore(false)
    self._reinforceNormalSkillControl[index]._skillChangeBtn = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillSlotBg, "Button_SkillChangeButton")
    self._reinforceNormalSkillControl[index]._skillChangeIcon = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillChangeBtn, "Static_ChangeIcon")
    self._reinforceNormalSkillControl[index]._skillActiveBtn = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillBg, "Button_NorBtn_Active")
    self._reinforceNormalSkillControl[index]._skillActiveBtnChange = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillActiveBtn, "Static_Change")
    self._reinforceNormalSkillControl[index]._skillActiveBtnUnLock = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillActiveBtn, "Static_UnLockIcon")
    self._reinforceNormalSkillControl[index]._skillNoneActiveBtn = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillBg, "Button_NorBtn_None")
    self._reinforceNormalSkillControl[index]._skillNoneActiveLock = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillNoneActiveBtn, "Static_LockIcon")
    self._reinforceNormalSkillControl[index]._skillName = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillBg, "StaticText_NorSkill_Title")
    self._reinforceNormalSkillControl[index]._skillDesc = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillName, "StaticText_NorSkill_Info")
    self._reinforceNormalSkillControl[index]._skillDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
    self._reinforceNormalSkillControl[index]._skillDesc:setLineCountByLimitAutoWrap(2)
    self._reinforceNormalSkillControl[index]._skillTitle = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillBg, "StaticText_NorSkillEff_Title")
    self._reinforceNormalSkillControl[index]._skillAttrDesc1 = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillTitle, "StaticText_NorSkillEff01")
    self._reinforceNormalSkillControl[index]._skillAttrDesc1:SetTextMode(__eTextMode_LimitText)
    self._reinforceNormalSkillControl[index]._skillAttrDesc2 = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillTitle, "StaticText_NorSkillEff02")
    self._reinforceNormalSkillControl[index]._skillAttrDesc2:SetTextMode(__eTextMode_LimitText)
    self._reinforceNormalSkillControl[index]._skillActiveText = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillBg, "StaticText_NorSkillActive")
    self._reinforceNormalSkillControl[index]._skillActiveInfoText = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillActiveText, "StaticText_NorSkillActive_Info")
    self._reinforceNormalSkillControl[index]._skillNoneActiveText = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillBg, "StaticText_NorSkillNoneActive")
    self._reinforceNormalSkillControl[index]._skillEffect = UI.getChildControl(self._reinforceNormalSkillControl[index]._skillBg, "Static_NorSkill_Effect")
  end
  self._ui.stc_NormalSkillList:SetShow(false)
end
function PaGlobal_ReinforceSkill_All:specialSlotInit()
  if nil == getSelfPlayer() then
    return
  end
  local isClassType = getSelfPlayer():getClassType()
  local specialSkillBasePosY = self._ui.stc_SpecialSkillList:GetSpanSize().y
  local specialSkillBgSizeY = self._ui.stc_SpecialSkillList:GetSizeY()
  local specialSkillGapY = 8
  if true == _ContentsGroup_TotalSkillReininforce then
    self._ui.stc_SpecialSkillBg:SetShow(false)
  else
    self._ui.stc_SpecialSkillBg:SetShow(true)
  end
  if true == isGameTypeKR2() then
    self._ui.stc_SpecialSkillBg:SetShow(false)
    Panel_Window_ReinforceSkill_All:SetSize(Panel_Window_ReinforceSkill_All:GetSizeX(), Panel_Window_ReinforceSkill_All:GetSizeY() - self._ui.stc_SpecialSkillBg:GetSizeY())
    self._ui.stc_InfoBg:SetSpanSize(self._ui.stc_InfoBg:GetSpanSize().x, self._ui.stc_InfoBg:GetSpanSize().y - self._ui.stc_SpecialSkillBg:GetSizeY())
  end
  for index = 0, self._reinforceSpecialSkillViewCount - 1 do
    self._reinforceSpecialSkillControl[index] = {}
    self._reinforceSpecialSkillControl[index]._skillBg = UI.cloneControl(self._ui.stc_SpecialSkillList, self._ui.stc_SpecialSkillBg, "ReinforceSpecialkill_Bg_" .. index)
    local SpanY = specialSkillBasePosY + (specialSkillBgSizeY + specialSkillGapY) * index
    self._reinforceSpecialSkillControl[index]._skillBg:SetSpanSize(self._reinforceSpecialSkillControl[index]._skillBg:GetSpanSize().x, SpanY)
    self._reinforceSpecialSkillControl[index]._skillSlotBg = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillBg, "Static_SpeSkillSlotBG")
    self._reinforceSpecialSkillControl[index]._skillIconBg = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillSlotBg, "Static_SpeSkillIconBG")
    self._reinforceSpecialSkillControl[index]._skillIcon = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillSlotBg, "Static_SpeSkillIcon")
    self._reinforceSpecialSkillControl[index]._skillIcon:SetIgnore(false)
    self._reinforceSpecialSkillControl[index]._skillChangeBtn = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillSlotBg, "Button_SpecialSkillChangeButton")
    self._reinforceSpecialSkillControl[index]._skillChange = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillChangeBtn, "Static_SpecialSkillChangeIcon")
    self._reinforceSpecialSkillControl[index]._skillActiveBtn = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillBg, "Button_SpeBtn_Active")
    self._reinforceSpecialSkillControl[index]._skillActiveBtnChange = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillActiveBtn, "Static_SpeChange")
    self._reinforceSpecialSkillControl[index]._skillActiveBtnUnLock = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillActiveBtn, "Static_SpeUnLockIcon")
    self._reinforceSpecialSkillControl[index]._skillNoneActiveBtn = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillBg, "Button_SpeBtn_None")
    self._reinforceSpecialSkillControl[index]._skillNoneActiveLock = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillNoneActiveBtn, "Static_SpeLockIcon")
    self._reinforceSpecialSkillControl[index]._skillName = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillBg, "StaticText_SpeSkill_Title")
    self._reinforceSpecialSkillControl[index]._skillDesc = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillName, "StaticText_SpeSkill_Info")
    self._reinforceSpecialSkillControl[index]._skillDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
    self._reinforceSpecialSkillControl[index]._skillTitle = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillBg, "StaticText_SpeSkillEff_Title")
    self._reinforceSpecialSkillControl[index]._skillAttrDesc1 = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillTitle, "StaticText_SpeSkillEff01")
    self._reinforceSpecialSkillControl[index]._skillAttrDesc1:SetTextMode(__eTextMode_LimitText)
    self._reinforceSpecialSkillControl[index]._skillAttrDesc2 = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillTitle, "StaticText_SpeSkillEff02")
    self._reinforceSpecialSkillControl[index]._skillAttrDesc2:SetTextMode(__eTextMode_LimitText)
    self._reinforceSpecialSkillControl[index]._skillActiveText = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillBg, "StaticText_SpeSkillActive")
    self._reinforceSpecialSkillControl[index]._skillActiveInfoText = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillActiveText, "StaticText_SpeSkillActive_Info")
    self._reinforceSpecialSkillControl[index]._skillNoneActiveText = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillBg, "StaticText_SpeSkillNoneActive")
    self._reinforceSpecialSkillControl[index]._skillEffect = UI.getChildControl(self._reinforceSpecialSkillControl[index]._skillBg, "Static_SpeSkill_Effect")
    if false == self._isConsole then
      self._reinforceSpecialSkillControl[index]._skillBg:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_EffectOff()")
    end
  end
  self._ui.stc_SpecialSkillList:SetShow(false)
  if isClassType == __eClassType_ShyWaman then
    self._ui.txt_SpecialSkill:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_AWAKEN_BYSHY"))
  else
    self._ui.txt_SpecialSkill:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_AWAKEN"))
  end
end
function PaGlobal_ReinforceSkill_All:registEventHandler()
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  Panel_Window_ReinforceSkill_All:SetShow(false, false)
  Panel_Window_ReinforceSkill_All:setMaskingChild(true)
  Panel_Window_ReinforceSkill_All:setGlassBackground(true)
  registerEvent("EventShowAwakenSkill", "PaGlobalFunc_PaGlobal_ReinforceSkill_All_Open")
  registerEvent("FromClient_SkillAwakeningPlayerStart", "FromClient_ReinforceSkill_All_SkillAwakeningPlayerStart")
  registerEvent("FromClient_SkillAwakeningPlayerEnd", "FromClient_ReinforceSkill_All_SkillAwakeningPlayerEnd")
end
function PaGlobal_ReinforceSkill_All:prepareOpen()
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  if not ToClient_IsContentsGroupOpen("203") then
    return
  end
  PaGlobal_ReinforceSkill_All:update()
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_SubPanelSetShow(false)
  end
  HandleEventOn_PaGlobal_ReinforceSkill_All_SetCurrentSkill(false)
  PaGlobal_ReinforceSkill_All:open()
  self._ui_console.stc_keyGuideBg:SetShow(self._isConsole)
end
function PaGlobal_ReinforceSkill_All:open()
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  Panel_Window_ReinforceSkill_All:SetShow(true, true)
end
function PaGlobal_ReinforceSkill_All:prepareClose()
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  if not ToClient_IsContentsGroupOpen("203") then
    return
  end
  TooltipSimple_Hide()
  Panel_SkillTooltip_Hide()
  self._ui_console.stc_keyGuideBg:SetShow(false)
  self:offEffect()
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  end
  PaGlobal_ReinforceSkill_All:close()
end
function PaGlobal_ReinforceSkill_All:close()
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  Panel_Window_ReinforceSkill_All:SetShow(false, true)
end
function PaGlobal_ReinforceSkill_All:updateNew()
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local playerSkillType = ToClient_GetCurrentPlayerSkillType()
  if nil == playerSkillType then
    return
  end
  local curClassType = selfPlayerWrapper:getClassType()
  local skillTypeParam = ToClient_GetSelfPlayerSkillType()
  if __eSkillTypeParam_Inherit == skillTypeParam then
    self._ui.txt_SpecialSkill:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_SUCCESSION"))
  elseif curClassType == __eClassType_ShyWaman then
    self._ui.txt_SpecialSkill:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_AWAKEN_BYSHY"))
  else
    self._ui.txt_SpecialSkill:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_AWAKEN"))
  end
  local selfPlayerLevel = selfPlayer:getLevel()
  local reinforcableSkillCount = 0
  if selfPlayerLevel < 50 then
    reinforcableSkillCount = 0
  elseif selfPlayerLevel < 52 then
    reinforcableSkillCount = 1
  elseif selfPlayerLevel < 54 then
    reinforcableSkillCount = 2
  elseif selfPlayerLevel < 56 then
    reinforcableSkillCount = 3
  elseif selfPlayerLevel < 58 then
    reinforcableSkillCount = 4
  elseif selfPlayerLevel < 60 then
    reinforcableSkillCount = 5
  else
    reinforcableSkillCount = 6
  end
  local reinforceSkillCount = ToClient_GetReAwakeningListCount()
  local reinforceSkillIndex = 0
  local effectSlotIndex = 0
  for index = 0, self._reinforceMaxSkillViewCount - 1 do
    local isNormal = true
    local skillSlot = self._reinforceNormalSkillControl[index]
    if index > self._reinforceNormalSkillViewCount then
      isNormal = false
    end
    if nil ~= skillSlot then
      skillSlot._skillBg:addInputEvent("Mouse_LUp", "")
      skillSlot._skillBg:addInputEvent("Mouse_On", "")
      skillSlot._skillBg:addInputEvent("Mouse_Out", "")
      skillSlot._skillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Hide()")
      skillSlot._skillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
      if false == self._isConsole then
        skillSlot._skillBg:SetIgnore(true)
      end
      skillSlot._skillBg:SetShow(true)
      local skillSSW
      if reinforceSkillCount > reinforceSkillIndex then
        skillSSW = ToClient_GetReAwakeningListAt(reinforceSkillIndex)
      end
      if nil ~= skillSSW then
        local skillNo = skillSSW:getSkillNo()
        local skillName = skillSSW:getName()
        if nil ~= skillName then
          skillSlot._skillName:SetText(skillName)
          skillSlot._skillName:SetShow(true)
        end
        local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
        if nil ~= skillTypeSSW then
          local skillDescription = skillTypeSSW:getDescription()
          if nil ~= skillDescription then
            skillSlot._skillDesc:SetText(skillDescription)
            skillSlot._skillDesc:SetShow(true)
          end
          skillSlot._skillIcon:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
          if false == self._isConsole then
            skillSlot._skillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"SkillAwakenSet\")")
            skillSlot._skillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
          else
            skillSlot._skillBg:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_SetCurrentSkill(true," .. index .. "," .. playerSkillType .. "," .. skillNo .. "," .. reinforceSkillIndex .. ")")
          end
        end
        skillSlot._skillIcon:SetShow(true)
        skillSlot._skillAttrDesc1:SetShow(true)
        skillSlot._skillAttrDesc2:SetShow(true)
        skillSlot._skillActiveBtn:SetShow(true)
        skillSlot._skillTitle:SetShow(true)
        skillSlot._skillActiveBtnChange:SetShow(true)
        skillSlot._skillActiveBtnUnLock:SetShow(false)
        skillSlot._skillNoneActiveBtn:SetShow(false)
        skillSlot._skillActiveText:SetShow(false)
        skillSlot._skillNoneActiveText:SetShow(false)
        self._ui.txt_NoSkill:SetShow(false)
        local optionCount = ToClient_GetAwakeningAbilityCount(skillNo)
        if 0 == optionCount then
          skillSlot._skillActiveBtn:SetShow(false)
          skillSlot._skillNoneActiveBtn:SetShow(true)
        elseif 1 == optionCount then
          local optionIndex = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
          skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex))
          skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ")")
          skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip()")
          skillSlot._skillAttrDesc2:SetText("")
          skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "")
          skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "")
        elseif 2 == optionCount then
          local optionIndex1 = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
          skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex1))
          skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ")")
          skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip()")
          local optionIndex2 = ToClient_GetAwakeningAbilityIndex(skillNo, 1)
          skillSlot._skillAttrDesc2:SetText(skillSSW:getSkillAwakenDescription(optionIndex2))
          skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 1 .. ", " .. index .. ")")
          skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip()")
        end
        skillSlot._skillActiveBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_Show(" .. playerSkillType .. ", " .. skillNo .. "," .. reinforceSkillIndex .. "," .. index .. ")")
        skillSlot._skillChangeBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_Change(" .. playerSkillType .. "," .. skillNo .. "," .. reinforceSkillIndex .. "," .. index .. ")")
        if false == self._isConsole then
          skillSlot._skillActiveBtn:addInputEvent("Mouse_On", "PaGlobal_ReinforceSkill_All:buttonToolTip(" .. 1 .. "," .. index .. ")")
          skillSlot._skillActiveBtn:addInputEvent("Mouse_Out", "PaGlobal_ReinforceSkill_All:buttonToolTip()")
          skillSlot._skillChangeBtn:addInputEvent("Mouse_On", "PaGlobal_ReinforceSkill_All:buttonToolTip(" .. 0 .. "," .. index .. ")")
          skillSlot._skillChangeBtn:addInputEvent("Mouse_Out", "PaGlobal_ReinforceSkill_All:buttonToolTip()")
        else
          skillSlot._skillBg:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_Change(" .. playerSkillType .. "," .. skillNo .. "," .. reinforceSkillIndex .. "," .. index .. ")")
        end
        skillSlot._skillChangeBtn:SetShow(true)
        effectSlotIndex = effectSlotIndex + 1
      else
        if nil ~= self._totalSkillReinforceAbleLevel[index] then
          skillSlot._skillActiveText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. " " .. self._totalSkillReinforceAbleLevel[index])
          skillSlot._skillNoneActiveText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. " " .. self._totalSkillReinforceAbleLevel[index])
        end
        skillSlot._skillIcon:SetShow(false)
        skillSlot._skillName:SetShow(false)
        skillSlot._skillTitle:SetShow(false)
        self._ui.txt_NoSkill:SetShow(false)
        if index < reinforcableSkillCount then
          skillSlot._skillBg:SetIgnore(false)
          skillSlot._skillBg:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_NewShow(" .. playerSkillType .. ", " .. effectSlotIndex .. ")")
          skillSlot._skillBg:addInputEvent("Mouse_On", "PaGlobal_ReinforceSkill_All:buttonToolTip()")
          skillSlot._skillBg:addInputEvent("Mouse_Out", "PaGlobal_ReinforceSkill_All:buttonToolTip()")
          if true == self._isConsole then
            skillSlot._skillBg:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_SetCurrentSkill(false," .. index .. ")")
          end
          skillSlot._skillActiveBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_NewShow(" .. playerSkillType .. ", " .. effectSlotIndex .. ")")
          skillSlot._skillActiveBtn:addInputEvent("Mouse_On", "PaGlobal_ReinforceSkill_All:buttonToolTip()")
          skillSlot._skillActiveBtn:addInputEvent("Mouse_Out", "PaGlobal_ReinforceSkill_All:buttonToolTip()")
          skillSlot._skillActiveBtn:SetShow(true)
          skillSlot._skillActiveInfoText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_ALL_1"))
          skillSlot._skillActiveInfoText:SetShow(true)
          skillSlot._skillActiveBtnChange:SetShow(false)
          skillSlot._skillActiveBtnUnLock:SetShow(true)
          skillSlot._skillNoneActiveBtn:SetShow(false)
          skillSlot._skillActiveText:SetShow(true)
          skillSlot._skillNoneActiveText:SetShow(false)
          skillSlot._skillChangeBtn:SetShow(false)
        else
          skillSlot._skillActiveInfoText:SetShow(false)
          skillSlot._skillBg:SetIgnore(true)
          skillSlot._skillActiveBtn:SetShow(false)
          skillSlot._skillNoneActiveBtn:SetShow(true)
          skillSlot._skillActiveText:SetShow(false)
          skillSlot._skillNoneActiveText:SetShow(true)
          skillSlot._skillChangeBtn:SetShow(false)
        end
      end
      reinforceSkillIndex = reinforceSkillIndex + 1
    end
  end
end
function PaGlobal_ReinforceSkill_All:update()
  if true == _ContentsGroup_TotalSkillReininforce then
    self:updateNew()
    return
  end
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  local selfPlayerLevel = getSelfPlayer():get():getLevel()
  local isClassType = getSelfPlayer():getClassType()
  local reinforceSkillCount = 0
  local reinforcableSkillCount = 0
  local reinforceSpecialSkillCount = 0
  if selfPlayerLevel < 50 then
    reinforcableSkillCount = 0
  elseif selfPlayerLevel < 52 then
    reinforcableSkillCount = 1
  elseif selfPlayerLevel < 54 then
    reinforcableSkillCount = 2
  else
    reinforcableSkillCount = 3
  end
  if selfPlayerLevel < 56 then
    reinforceSpecialSkillCount = 0
  elseif selfPlayerLevel < 58 then
    reinforceSpecialSkillCount = 1
  elseif selfPlayerLevel < 60 then
    reinforceSpecialSkillCount = 2
  else
    reinforceSpecialSkillCount = 3
  end
  local skillTypeParam = ToClient_GetSelfPlayerSkillType()
  if __eSkillTypeParam_Inherit == skillTypeParam then
    self._ui.txt_SpecialSkill:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_SUCCESSION"))
  elseif isClassType == __eClassType_ShyWaman then
    self._ui.txt_SpecialSkill:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_AWAKEN_BYSHY"))
  else
    self._ui.txt_SpecialSkill:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_AWAKEN"))
  end
  local normalSkill_ReinforceCount = ToClient_GetSkillAwakeningCount()
  local specialSkill_ReinforceCount = ToClient_GetWeaponSkillAwakeningCount()
  local successionSkill_ReinforceCount = ToClient_GetSuccessionSkillAwakeningCount()
  local normalSkill_ReinforceIndex, awakenSkill_ReinforceIndex = 0, 0
  local reinforceSkillIndex = -1
  for index = 0, self._reinforceNormalSkillViewCount - 1 do
    local skillSlot = self._reinforceNormalSkillControl[index]
    skillSlot._skillBg:SetIgnore(true)
    skillSlot._skillBg:addInputEvent("Mouse_LUp", "")
    skillSlot._skillBg:addInputEvent("Mouse_On", "")
    skillSlot._skillBg:addInputEvent("Mouse_Out", "")
    skillSlot._skillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Hide()")
    skillSlot._skillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
    if index < normalSkill_ReinforceCount then
      skillSlot._skillBg:SetShow(true)
      local reinforceSkillCount = ToClient_GetReAwakeningListCount()
      local skillSSW
      for sIndex = 0, reinforceSkillCount - 1 do
        skillSSW = ToClient_GetReAwakeningListAt(sIndex)
        local awakeningType = skillSSW:getSkillAwakenBranchType()
        if __eSkillTypeParam_Normal == awakeningType and sIndex > reinforceSkillIndex then
          reinforceSkillIndex = sIndex
          break
        end
      end
      if nil ~= skillSSW then
        local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
        local skillNo = skillSSW:getSkillNo()
        skillSlot._skillName:SetText(skillSSW:getName())
        skillSlot._skillDesc:SetText(skillTypeSSW:getDescription())
        skillSlot._skillIcon:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
        if skillSlot._skillDesc:IsLimitText() then
          skillSlot._skillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"SkillAwakenSet\")")
          skillSlot._skillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
        end
        local optionCount = ToClient_GetAwakeningAbilityCount(skillNo)
        skillSlot._skillName:SetShow(true)
        skillSlot._skillDesc:SetShow(true)
        skillSlot._skillIcon:SetShow(true)
        skillSlot._skillAttrDesc1:SetShow(true)
        skillSlot._skillAttrDesc2:SetShow(true)
        skillSlot._skillActiveBtn:SetShow(true)
        skillSlot._skillTitle:SetShow(true)
        skillSlot._skillActiveBtnChange:SetShow(true)
        skillSlot._skillActiveBtnUnLock:SetShow(false)
        skillSlot._skillNoneActiveBtn:SetShow(false)
        skillSlot._skillActiveText:SetShow(false)
        skillSlot._skillNoneActiveText:SetShow(false)
        if 1 == optionCount then
          local optionIndex = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
          skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex))
          skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ", true )")
          skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip()")
          skillSlot._skillAttrDesc2:SetText("")
          skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "")
          skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "")
        elseif 2 == optionCount then
          local optionIndex1 = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
          local optionIndex2 = ToClient_GetAwakeningAbilityIndex(skillNo, 1)
          skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex1))
          skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ", true )")
          skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip()")
          skillSlot._skillAttrDesc2:SetText(skillSSW:getSkillAwakenDescription(optionIndex2))
          skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 1 .. ", " .. index .. ", true )")
          skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip()")
        else
          skillSlot._skillActiveBtn:SetShow(false)
          skillSlot._skillNoneActiveBtn:SetShow(true)
        end
        skillSlot._skillActiveBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_NoramlActiveButtonTooltip(" .. 1 .. ", " .. index .. ")")
        skillSlot._skillActiveBtn:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_NoramlActiveButtonTooltip()")
        skillSlot._skillActiveBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_Show(" .. 0 .. ", " .. skillNo .. ", " .. reinforceSkillIndex .. ", " .. index .. ")")
        skillSlot._skillChangeBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_NoramlActiveButtonTooltip(" .. 0 .. ", " .. index .. ")")
        skillSlot._skillChangeBtn:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_NoramlActiveButtonTooltip()")
        skillSlot._skillChangeBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_Change(" .. 0 .. "," .. skillNo .. "," .. reinforceSkillIndex .. ", " .. index .. ")")
        skillSlot._skillChangeBtn:SetShow(true)
      end
    else
      skillSlot._skillActiveText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. " " .. self._normalSkillReinforceAbleLevel[index])
      skillSlot._skillNoneActiveText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. " " .. self._normalSkillReinforceAbleLevel[index])
      skillSlot._skillActiveInfoText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_NORMAL_1"))
      skillSlot._skillName:SetShow(false)
      skillSlot._skillTitle:SetShow(false)
      if reinforcableSkillCount > index then
        skillSlot._skillBg:SetIgnore(false)
        skillSlot._skillBg:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_NewShow(" .. 0 .. ", " .. index .. ")")
        skillSlot._skillBg:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_NoramlActiveButtonTooltip()")
        skillSlot._skillBg:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_NoramlActiveButtonTooltip()")
        skillSlot._skillActiveBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_NewShow(" .. 0 .. ", " .. index .. ")")
        skillSlot._skillActiveBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_NoramlActiveButtonTooltip()")
        skillSlot._skillActiveBtn:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_NoramlActiveButtonTooltip()")
        skillSlot._skillActiveBtnChange:SetShow(false)
        skillSlot._skillActiveBtnUnLock:SetShow(true)
        skillSlot._skillActiveBtn:SetShow(true)
        skillSlot._skillNoneActiveBtn:SetShow(false)
        skillSlot._skillActiveText:SetShow(true)
        skillSlot._skillActiveInfoText:SetShow(true)
        skillSlot._skillNoneActiveText:SetShow(false)
        skillSlot._skillChangeBtn:SetShow(false)
      else
        skillSlot._skillBg:SetIgnore(true)
        skillSlot._skillActiveBtn:SetShow(false)
        skillSlot._skillNoneActiveBtn:SetShow(true)
        skillSlot._skillActiveText:SetShow(false)
        skillSlot._skillActiveInfoText:SetShow(false)
        skillSlot._skillNoneActiveText:SetShow(true)
        skillSlot._skillChangeBtn:SetShow(false)
      end
    end
    if index == self._reinforceNormalSkillViewCount - 1 then
      reinforceSkillIndex = -1
    end
  end
  for index = 0, self._reinforceSpecialSkillViewCount - 1 do
    local skillSlot = self._reinforceSpecialSkillControl[index]
    skillSlot._skillBg:SetIgnore(true)
    skillSlot._skillBg:addInputEvent("Mouse_LUp", "")
    skillSlot._skillBg:addInputEvent("Mouse_On", "")
    skillSlot._skillBg:addInputEvent("Mouse_Out", "")
    skillSlot._skillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Hide()")
    skillSlot._skillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
    if __eSkillTypeParam_Normal == skillTypeParam or __eSkillTypeParam_Awaken == skillTypeParam then
      if index < specialSkill_ReinforceCount then
        skillSlot._skillBg:SetShow(true)
        local reinforceSkillcount = ToClient_GetReAwakeningListCount()
        local skillSSW
        for sIndex = 0, reinforceSkillcount - 1 do
          skillSSW = ToClient_GetReAwakeningListAt(sIndex)
          local awakeningType = skillSSW:getSkillAwakenBranchType()
          if __eSkillTypeParam_Awaken == awakeningType and sIndex > reinforceSkillIndex then
            reinforceSkillIndex = sIndex
            break
          end
        end
        if nil ~= skillSSW then
          local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
          local skillNo = skillSSW:getSkillNo()
          skillSlot._skillName:SetText(skillSSW:getName())
          skillSlot._skillDesc:SetText(skillTypeSSW:getDescription())
          skillSlot._skillIcon:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
          if skillSlot._skillDesc:IsLimitText() then
            skillSlot._skillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"SkillAwakenSet\")")
            skillSlot._skillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
          end
          local optionCount = ToClient_GetAwakeningAbilityCount(skillNo)
          skillSlot._skillName:SetShow(true)
          skillSlot._skillDesc:SetShow(true)
          skillSlot._skillIcon:SetShow(true)
          skillSlot._skillAttrDesc1:SetShow(true)
          skillSlot._skillAttrDesc2:SetShow(true)
          skillSlot._skillActiveBtn:SetShow(true)
          skillSlot._skillTitle:SetShow(true)
          skillSlot._skillActiveBtnChange:SetShow(true)
          skillSlot._skillActiveBtnUnLock:SetShow(false)
          skillSlot._skillNoneActiveBtn:SetShow(false)
          skillSlot._skillActiveText:SetShow(false)
          skillSlot._skillNoneActiveText:SetShow(false)
          self._ui.txt_NoSkill:SetShow(false)
          if 1 == optionCount then
            local optionIndex = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
            skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex))
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ", false )")
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip()")
            skillSlot._skillAttrDesc2:SetText("")
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "")
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "")
          elseif 2 == optionCount then
            local optionIndex1 = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
            local optionIndex2 = ToClient_GetAwakeningAbilityIndex(skillNo, 1)
            skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex1))
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ", false )")
            skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip()")
            skillSlot._skillAttrDesc2:SetText(skillSSW:getSkillAwakenDescription(optionIndex2))
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 1 .. ", " .. index .. ", false )")
            skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip()")
          else
            skillSlot._skillActiveBtn:SetShow(false)
            skillSlot._skillNoneActiveBtn:SetShow(true)
          end
          skillSlot._skillActiveBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_Show(" .. 1 .. ", " .. skillNo .. ", " .. reinforceSkillIndex .. ", " .. index .. ")")
          skillSlot._skillActiveBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip(" .. 1 .. ", " .. index .. ")")
          skillSlot._skillActiveBtn:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip()")
          skillSlot._skillChangeBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_Change(" .. 1 .. ", " .. skillNo .. ", " .. reinforceSkillIndex .. ", " .. index .. ")")
          skillSlot._skillChangeBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip(" .. 0 .. ", " .. index .. ")")
          skillSlot._skillChangeBtn:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip()")
          skillSlot._skillChangeBtn:SetShow(true)
        end
      else
        skillSlot._skillActiveText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. " " .. self._specialSkillReinforceAbleLevel[index])
        skillSlot._skillNoneActiveText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. " " .. self._specialSkillReinforceAbleLevel[index])
        skillSlot._skillActiveInfoText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_AWAKEN_1"))
        if isClassType == __eClassType_ShyWaman then
          self._ui.txt_NoSkill:SetShow(true)
          skillSlot._skillBg:SetShow(false)
        else
          self._ui.txt_NoSkill:SetShow(false)
        end
        skillSlot._skillIcon:SetShow(false)
        skillSlot._skillName:SetShow(false)
        skillSlot._skillTitle:SetShow(false)
        if reinforceSpecialSkillCount > index then
          skillSlot._skillBg:SetIgnore(false)
          skillSlot._skillBg:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_NewShow(" .. 1 .. ", " .. index .. ")")
          skillSlot._skillBg:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip()")
          skillSlot._skillBg:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip()")
          skillSlot._skillActiveBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_NewShow(" .. 1 .. ", " .. index .. ")")
          skillSlot._skillActiveBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip()")
          skillSlot._skillActiveBtn:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip()")
          skillSlot._skillActiveBtn:SetShow(true)
          skillSlot._skillNoneActiveBtn:SetShow(false)
          skillSlot._skillActiveText:SetShow(true)
          skillSlot._skillActiveInfoText:SetShow(true)
          skillSlot._skillNoneActiveText:SetShow(false)
          skillSlot._skillActiveBtnChange:SetShow(false)
          skillSlot._skillActiveBtnUnLock:SetShow(true)
          skillSlot._skillChangeBtn:SetShow(false)
        else
          skillSlot._skillBg:SetIgnore(true)
          skillSlot._skillActiveBtn:SetShow(false)
          skillSlot._skillNoneActiveBtn:SetShow(true)
          skillSlot._skillActiveText:SetShow(false)
          skillSlot._skillActiveInfoText:SetShow(false)
          skillSlot._skillNoneActiveText:SetShow(true)
          skillSlot._skillChangeBtn:SetShow(false)
        end
      end
    elseif index < successionSkill_ReinforceCount then
      skillSlot._skillBg:SetShow(true)
      skillSlot._skillBg:SetIgnore(true)
      local reinforceSkillcount = ToClient_GetReAwakeningListCount()
      local skillSSW
      local dupCounter = 0
      for sIndex = 0, reinforceSkillcount - 1 do
        skillSSW = ToClient_GetReAwakeningListAt(sIndex)
        if nil ~= skillSSW then
          local awakeningType = skillSSW:getSkillAwakenBranchType()
          local skillNo = skillSSW:getSkillNo()
          if __eSkillTypeParam_Normal == awakeningType then
            if normalSkill_ReinforceCount == dupCounter then
              if reinforceSkillIndex < sIndex then
                reinforceSkillIndex = sIndex
                break
              end
            else
              dupCounter = dupCounter + 1
            end
          elseif __eSkillTypeParam_Inherit == awakeningType and sIndex > reinforceSkillIndex then
            reinforceSkillIndex = sIndex
            break
          end
        end
      end
      if nil ~= skillSSW then
        local skillNo = skillSSW:getSkillNo()
        local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
        skillSlot._skillName:SetText(skillSSW:getName())
        skillSlot._skillDesc:SetText(skillTypeSSW:getDescription())
        skillSlot._skillIcon:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
        if skillSlot._skillDesc:IsLimitText() then
          skillSlot._skillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"SkillAwakenSet\")")
          skillSlot._skillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
        end
        local optionCount = ToClient_GetAwakeningAbilityCount(skillNo)
        skillSlot._skillName:SetShow(true)
        skillSlot._skillDesc:SetShow(true)
        skillSlot._skillIcon:SetShow(true)
        skillSlot._skillAttrDesc1:SetShow(true)
        skillSlot._skillAttrDesc2:SetShow(true)
        skillSlot._skillActiveBtn:SetShow(true)
        skillSlot._skillTitle:SetShow(true)
        skillSlot._skillActiveBtnChange:SetShow(true)
        skillSlot._skillActiveBtnUnLock:SetShow(false)
        skillSlot._skillNoneActiveBtn:SetShow(false)
        skillSlot._skillActiveText:SetShow(false)
        skillSlot._skillNoneActiveText:SetShow(false)
        self._ui.txt_NoSkill:SetShow(false)
        if 1 == optionCount then
          local optionIndex = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
          skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex))
          skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ", false )")
          skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip()")
          skillSlot._skillAttrDesc2:SetText("")
          skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "")
          skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "")
        elseif 2 == optionCount then
          local optionIndex1 = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
          local optionIndex2 = ToClient_GetAwakeningAbilityIndex(skillNo, 1)
          skillSlot._skillAttrDesc1:SetText(skillSSW:getSkillAwakenDescription(optionIndex1))
          skillSlot._skillAttrDesc1:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 0 .. ", " .. index .. ", false )")
          skillSlot._skillAttrDesc1:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip()")
          skillSlot._skillAttrDesc2:SetText(skillSSW:getSkillAwakenDescription(optionIndex2))
          skillSlot._skillAttrDesc2:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip(" .. reinforceSkillIndex .. ", " .. skillNo .. ", " .. 1 .. ", " .. index .. ", false )")
          skillSlot._skillAttrDesc2:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_DescTooltip()")
        else
          skillSlot._skillActiveBtn:SetShow(false)
          skillSlot._skillNoneActiveBtn:SetShow(true)
        end
        skillSlot._skillActiveBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_Show(" .. __eSkillTypeParam_Inherit .. "," .. skillNo .. "," .. reinforceSkillIndex .. ", " .. index .. ")")
        skillSlot._skillActiveBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip(" .. 1 .. ", " .. index .. ")")
        skillSlot._skillActiveBtn:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip()")
        skillSlot._skillChangeBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_Change(" .. __eSkillTypeParam_Inherit .. ", " .. skillNo .. ", " .. reinforceSkillIndex .. ", " .. index .. ")")
        skillSlot._skillChangeBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip(" .. 0 .. ", " .. index .. ")")
        skillSlot._skillChangeBtn:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip()")
        skillSlot._skillChangeBtn:SetShow(true)
      end
    else
      skillSlot._skillActiveText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. " " .. self._specialSkillReinforceAbleLevel[index])
      skillSlot._skillNoneActiveText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. " " .. self._specialSkillReinforceAbleLevel[index])
      skillSlot._skillActiveInfoText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_SUCCESSION_1"))
      if isClassType == __eClassType_ShyWaman then
        self._ui.txt_NoSkill:SetShow(true)
        skillSlot._skillBg:SetShow(false)
      else
        self._ui.txt_NoSkill:SetShow(false)
      end
      skillSlot._skillIcon:SetShow(false)
      skillSlot._skillName:SetShow(false)
      skillSlot._skillDesc:SetShow(false)
      skillSlot._skillTitle:SetShow(false)
      skillSlot._skillAttrDesc1:SetShow(false)
      skillSlot._skillAttrDesc2:SetShow(false)
      if reinforceSpecialSkillCount > index then
        skillSlot._skillBg:SetIgnore(false)
        skillSlot._skillBg:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_NewShow(" .. __eSkillTypeParam_Inherit .. ", " .. index .. ")")
        skillSlot._skillBg:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip()")
        skillSlot._skillBg:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip()")
        skillSlot._skillActiveBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_SkillReinforce_All_NewShow(" .. __eSkillTypeParam_Inherit .. "," .. index .. ")")
        skillSlot._skillActiveBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip()")
        skillSlot._skillActiveBtn:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_ReinforceSkill_All_SpecialActiveButtonTooltip()")
        skillSlot._skillActiveBtn:SetShow(true)
        skillSlot._skillNoneActiveBtn:SetShow(false)
        skillSlot._skillActiveText:SetShow(true)
        skillSlot._skillActiveInfoText:SetShow(true)
        skillSlot._skillNoneActiveText:SetShow(false)
        skillSlot._skillActiveBtnChange:SetShow(false)
        skillSlot._skillActiveBtnUnLock:SetShow(true)
        skillSlot._skillChangeBtn:SetShow(false)
      else
        skillSlot._skillBg:SetIgnore(true)
        skillSlot._skillActiveBtn:SetShow(false)
        skillSlot._skillNoneActiveBtn:SetShow(true)
        skillSlot._skillActiveText:SetShow(false)
        skillSlot._skillActiveInfoText:SetShow(false)
        skillSlot._skillNoneActiveText:SetShow(true)
        skillSlot._skillChangeBtn:SetShow(false)
      end
    end
  end
end
function PaGlobal_ReinforceSkill_All:validate()
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.btn_Help:isValidate()
  self._ui.btn_Exit:isValidate()
  self._ui.stc_NormalSkillBG:isValidate()
  self._ui.txt_NormalSkill:isValidate()
  self._ui.stc_NormalSkillList:isValidate()
  self._ui.stc_SpecialSkillBg:isValidate()
  self._ui.txt_SpecialSkill:isValidate()
  self._ui.stc_SpecialSkillList:isValidate()
  self._ui.txt_NoSkill:isValidate()
  self._ui.stc_InfoBg:isValidate()
  self._ui.txt_Info:isValidate()
  self._ui_console.stc_keyGuideBg:isValidate()
  self._ui_console.stc_keyGuideSelect:isValidate()
  self._ui_console.stc_keyGuideClose:isValidate()
  self._ui_console.stc_keyGuideReinforce:isValidate()
  self._ui_console.stc_keyGuideDetail:isValidate()
end
function PaGlobal_ReinforceSkill_All:descToolTip(reinforceIndex, skillNo, uiIndex, index, isNormal)
  if nil == index then
    TooltipSimple_Hide()
    return
  end
  local control
  local name = ""
  local optionIndex = ToClient_GetAwakeningAbilityIndex(skillNo, uiIndex)
  local skillSSW = ToClient_GetReAwakeningListAt(reinforceIndex)
  if nil ~= skillSSW then
    name = skillSSW:getSkillAwakenDescription(optionIndex)
  end
  if 0 == uiIndex then
    if true == _ContentsGroup_TotalSkillReininforce then
      control = self._reinforceNormalSkillControl[index]._skillAttrDesc1
    elseif true == isNormal then
      control = self._reinforceNormalSkillControl[index]._skillAttrDesc1
    else
      control = self._reinforceSpecialSkillControl[index]._skillAttrDesc1
    end
  elseif true == _ContentsGroup_TotalSkillReininforce then
    control = self._reinforceNormalSkillControl[index]._skillAttrDesc2
  elseif true == isNormal then
    control = self._reinforceNormalSkillControl[index]._skillAttrDesc2
  else
    control = self._reinforceSpecialSkillControl[index]._skillAttrDesc2
  end
  TooltipSimple_Show(control, name)
end
function PaGlobal_ReinforceSkill_All:buttonToolTip(btnType, index, isNormal)
  if nil == btnType then
    TooltipSimple_Hide()
    return
  end
  local control
  local name = ""
  if true == _ContentsGroup_TotalSkillReininforce then
    control = self._reinforceNormalSkillControl[index]._skillActiveBtn
    if 0 == btnType then
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_CHANGESKILL")
    else
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_CHANGEOPTION")
    end
  elseif 0 == btnType then
    if true == isNormal then
      control = self._reinforceNormalSkillControl[index]._skillActiveBtn
    else
      control = self._reinforceSpecialSkillControl[index]._skillActiveBtn
    end
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_CHANGESKILL")
  elseif 1 == btnType then
    if true == isNormal then
      control = self._reinforceNormalSkillControl[index]._skillActiveBtn
    else
      control = self._reinforceSpecialSkillControl[index]._skillActiveBtn
    end
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_CHANGEOPTION")
  end
  TooltipSimple_Show(control, name)
end
function PaGlobal_ReinforceSkill_All:offEffect()
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  if true == _ContentsGroup_TotalSkillReininforce then
    for localindex = 0, self._reinforceMaxSkillViewCount - 1 do
      if nil ~= self._reinforceNormalSkillControl[localindex] then
        self._reinforceNormalSkillControl[localindex]._skillEffect:EraseAllEffect()
        if false == self._isConsole then
          self._reinforceNormalSkillControl[localindex]._skillBg:SetIgnore(true)
        end
        self._reinforceNormalSkillControl[localindex]._skillBg:setRenderTexture(self._reinforceNormalSkillControl[localindex]._skillBg:getBaseTexture())
      end
    end
  else
    for localindex = 0, self._reinforceNormalSkillViewCount - 1 do
      if nil ~= self._reinforceNormalSkillControl[localindex] then
        self._reinforceNormalSkillControl[localindex]._skillEffect:EraseAllEffect()
        if false == self._isConsole then
          self._reinforceNormalSkillControl[localindex]._skillBg:SetIgnore(true)
        end
        self._reinforceNormalSkillControl[localindex]._skillBg:setRenderTexture(self._reinforceNormalSkillControl[localindex]._skillBg:getBaseTexture())
      end
    end
    for localindex = 0, self._reinforceSpecialSkillViewCount - 1 do
      if nil ~= self._reinforceSpecialSkillControl[localindex] then
        self._reinforceSpecialSkillControl[localindex]._skillEffect:EraseAllEffect()
        if false == self._isConsole then
          self._reinforceSpecialSkillControl[localindex]._skillBg:SetIgnore(true)
        end
        self._reinforceSpecialSkillControl[localindex]._skillBg:setRenderTexture(self._reinforceSpecialSkillControl[localindex]._skillBg:getBaseTexture())
      end
    end
  end
  self:update()
end
function PaGlobal_ReinforceSkill_All:setEffect(skillType, index)
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  self:offEffect()
  if true == _ContentsGroup_TotalSkillReininforce then
    if nil == self._reinforceNormalSkillControl[index] then
      return
    end
    self._reinforceNormalSkillControl[index]._skillEffect:AddEffect("fUI_ReinforceSkill_01A", false, 0, 0)
    self._reinforceNormalSkillControl[index]._skillBg:SetIgnore(false)
    if false == self._isConsole then
      self._reinforceNormalSkillControl[index]._skillBg:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_EffectOff()")
    else
      self._effectIndex = index
    end
    return
  end
  local changeIndex = -1
  if 0 == skillType then
    local normalSkill_ReinforceCount = ToClient_GetSkillAwakeningCount()
    if index > normalSkill_ReinforceCount - 1 then
      changeIndex = normalSkill_ReinforceCount - 1
    else
      changeIndex = index
    end
    if nil == self._reinforceNormalSkillControl[changeIndex] then
      return
    end
    self._reinforceNormalSkillControl[changeIndex]._skillEffect:AddEffect("fUI_ReinforceSkill_01A", false, 0, 0)
    self._reinforceNormalSkillControl[changeIndex]._skillBg:SetIgnore(false)
    if false == self._isConsole then
      self._reinforceNormalSkillControl[changeIndex]._skillBg:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_EffectOff()")
    else
      self._effectIndex = changeIndex
    end
  elseif 1 == skillType then
    local awakenSkill_ReinforceCount = ToClient_GetWeaponSkillAwakeningCount()
    if index > awakenSkill_ReinforceCount - 1 then
      changeIndex = awakenSkill_ReinforceCount - 1
    else
      changeIndex = index
    end
    if nil == self._reinforceSpecialSkillControl[changeIndex] then
      return
    end
    self._reinforceSpecialSkillControl[changeIndex]._skillEffect:AddEffect("fUI_ReinforceSkill_01A", false, 0, 0)
    self._reinforceSpecialSkillControl[changeIndex]._skillBg:SetIgnore(false)
    if false == self._isConsole then
      self._reinforceSpecialSkillControl[changeIndex]._skillBg:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_EffectOff()")
    else
      self._effectIndex = changeIndex
    end
  else
    local normalSkill_ReinforceCount = ToClient_GetSkillAwakeningCount()
    local successionSkill_ReinforceCount = ToClient_GetSuccessionSkillAwakeningCount()
    if normalSkill_ReinforceCount <= self._reinforceNormalSkillViewCount and successionSkill_ReinforceCount <= 0 then
      changeIndex = normalSkill_ReinforceCount - 1
      if nil == self._reinforceNormalSkillControl[changeIndex] then
        return
      end
      self._reinforceNormalSkillControl[changeIndex]._skillEffect:AddEffect("fUI_ReinforceSkill_01A", false, 0, 0)
      self._reinforceNormalSkillControl[changeIndex]._skillBg:SetIgnore(false)
      if false == self._isConsole then
        self._reinforceNormalSkillControl[changeIndex]._skillBg:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_EffectOff()")
      else
        self._effectIndex = changeIndex
      end
    else
      if index > successionSkill_ReinforceCount - 1 then
        changeIndex = successionSkill_ReinforceCount - 1
      else
        changeIndex = index
      end
      if nil == self._reinforceSpecialSkillControl[changeIndex] then
        return
      end
      self._reinforceSpecialSkillControl[changeIndex]._skillEffect:AddEffect("fUI_ReinforceSkill_01A", false, 0, 0)
      self._reinforceSpecialSkillControl[changeIndex]._skillBg:SetIgnore(false)
      if false == self._isConsole then
        self._reinforceSpecialSkillControl[changeIndex]._skillBg:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_ReinforceSkill_All_EffectOff()")
      else
        self._effectIndex = changeIndex
      end
    end
  end
end
function PaGlobal_ReinforceSkill_All:setCurrentButtonData(isEnableSkill, index, playerSkillType, skillNo, reinforceSkillIndex)
  if nil == Panel_Window_ReinforceSkill_All then
    return
  end
  if false == _ContentsGroup_TotalSkillReininforce then
    return
  end
  if false == self._isConsole then
    return
  end
  TooltipSimple_Hide()
  Panel_Window_ReinforceSkill_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  Panel_Window_ReinforceSkill_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  local keyGuides = {}
  self._ui_console.stc_keyGuideSelect:SetShow(true)
  self._ui_console.stc_keyGuideClose:SetShow(true)
  if true == isEnableSkill then
    if nil == index or nil == playerSkillType or nil == skillNo or nil == reinforceSkillIndex then
      return
    end
    Panel_Window_ReinforceSkill_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEvent_PaGlobal_ReinforceSkill_All_SetSkillTooltip(" .. skillNo .. ")")
    Panel_Window_ReinforceSkill_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_PaGlobal_SkillReinforce_All_Show(" .. playerSkillType .. ", " .. skillNo .. "," .. reinforceSkillIndex .. "," .. index .. ")")
    self._ui_console.stc_keyGuideReinforce:SetShow(true)
    self._ui_console.stc_keyGuideDetail:SetShow(true)
    keyGuides = {
      self._ui_console.stc_keyGuideDetail,
      self._ui_console.stc_keyGuideReinforce,
      self._ui_console.stc_keyGuideSelect,
      self._ui_console.stc_keyGuideClose
    }
  else
    self._ui_console.stc_keyGuideReinforce:SetShow(false)
    self._ui_console.stc_keyGuideDetail:SetShow(false)
    keyGuides = {
      self._ui_console.stc_keyGuideSelect,
      self._ui_console.stc_keyGuideClose
    }
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  if -1 ~= self._effectIndex and self._effectIndex == index then
    HandleEventOn_PaGlobal_ReinforceSkill_All_EffectOff()
    self._effectIndex = -1
  end
end
