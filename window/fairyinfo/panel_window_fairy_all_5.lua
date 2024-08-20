function PaGlobal_FairySkill_All:initialize()
  if true == PaGlobal_FairySkill_All._initialize then
    return
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_FairySkill_All, "Static_TitleBG")
  self._ui.stc_TitleName = UI.getChildControl(self._ui.stc_TitleBG, "StaticText_Title_Name")
  self._ui_pc.btn_Close_Top_pc = UI.getChildControl(self._ui.stc_TitleBG, "Button_Win_Close_PC")
  self._ui.stc_MainBG = UI.getChildControl(Panel_Window_FairySkill_All, "Static_MainBG")
  self._ui.list2_Skill = UI.getChildControl(self._ui.stc_MainBG, "List2_1")
  self._ui_pc.btn_Close_Bottom_pc = UI.getChildControl(Panel_Window_FairySkill_All, "Button_Close_PC")
  self._ui_console.stc_KeyGuide_B = UI.getChildControl(Panel_Window_FairySkill_All, "StaticText_KeyGuide_Console")
  self._ui._btn_Question_pc = UI.getChildControl(self._ui.stc_TitleBG, "Button_Question")
  self._ui._stc_BottomDescBG = UI.getChildControl(Panel_Window_FairySkill_All, "Static_BottomDescBG")
  self._ui._txt_RateDesc = UI.getChildControl(self._ui._stc_BottomDescBG, "StaticText_Desc")
  self._ui_console._stc_KeyGuide_ConsoleUI = UI.getChildControl(Panel_Window_FairySkill_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console._txt_B_ConsoleUI = UI.getChildControl(self._ui_console._stc_KeyGuide_ConsoleUI, "StaticText_B_ConsoleUI")
  self._ui_console._txt_Y_ConsoleUI = UI.getChildControl(self._ui_console._stc_KeyGuide_ConsoleUI, "StaticText_Y_ConsoleUI")
  self._defaultPanelSizeY = Panel_Window_FairySkill_All:GetSizeY()
  self._defaultPcCloseBtnPosY = self._ui_pc.btn_Close_Bottom_pc:GetPosY()
  self._defaultKeyGuidePosY = self._ui_console._stc_KeyGuide_ConsoleUI:GetPosY()
  self._defaultBottomDescBGSizeY = self._ui._stc_BottomDescBG:GetSizeY()
  PaGlobal_FairySkill_All:SetUiSetting()
  PaGlobal_FairySkill_All:registEventHandler()
  PaGlobal_FairySkill_All:validate()
  PaGlobal_FairySkill_All._initialize = true
end
function PaGlobal_FairySkill_All:SetUiSetting()
  if nil == Panel_Window_FairySkill_All then
    return
  end
  for _, value in pairs(self._ui_pc) do
    value:SetShow(not _ContentsGroup_UsePadSnapping)
  end
  for _, value in pairs(self._ui_console) do
    value:SetShow(_ContentsGroup_UsePadSnapping)
  end
  if true == _ContentsGroup_FairySkillChangeRateView and true == _ContentsGroup_UsePadSnapping then
    Panel_Window_FairySkill_All:SetSize(Panel_Window_FairySkill_All:GetSizeX(), Panel_Window_FairySkill_All:GetSizeY() - self._ui_console.stc_KeyGuide_B:GetSizeY())
    self._ui_console.stc_KeyGuide_B:SetShow(false)
    self._ui_console._stc_KeyGuide_ConsoleUI:SetPosY(self._ui_console._stc_KeyGuide_ConsoleUI:GetPosY() - self._ui_console.stc_KeyGuide_B:GetSizeY())
    self._ui._btn_Question_pc:SetShow(false)
    local keyGuides = {
      self._ui_console._txt_Y_ConsoleUI,
      self._ui_console._txt_B_ConsoleUI
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console._stc_KeyGuide_ConsoleUI, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  elseif false == _ContentsGroup_FairySkillChangeRateView and true == _ContentsGroup_UsePadSnapping then
    self._ui_console._stc_KeyGuide_ConsoleUI:SetShow(false)
    self._ui_console.stc_KeyGuide_B:SetShow(false)
    self._ui_console._txt_B_ConsoleUI:SetShow(true)
    self._ui_console._txt_Y_ConsoleUI:SetShow(false)
    self._ui._btn_Question_pc:SetShow(false)
  end
end
function PaGlobal_FairySkill_All:setAlignKeyGuide()
  if nil == Panel_Window_FairySkill_All then
    return
  end
  if true == _ContentsGroup_FairySkillChangeRateView then
    local descStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRYRATE_BOTTOM_DESC")
    self._ui._txt_RateDesc:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_RateDesc:SetText(descStr)
    self._ui._txt_RateDesc:SetSize(self._ui._txt_RateDesc:GetSizeX(), self._ui._txt_RateDesc:GetTextSizeY() + 10)
    self._ui._stc_BottomDescBG:SetSize(self._ui._stc_BottomDescBG:GetSizeX(), self._ui._txt_RateDesc:GetTextSizeY() + 30)
    local moveValue = 0
    local gap = 0
    if true == PaGlobal_FairyInfo_All._isShowSkillRate then
      moveValue = self._ui._txt_RateDesc:GetTextSizeY() - self._defaultBottomDescBGSizeY
      gap = 30
    else
      moveValue = self._defaultBottomDescBGSizeY * -1
      gap = 10
    end
    if false == _ContentsGroup_UsePadSnapping then
      Panel_Window_FairySkill_All:SetSize(Panel_Window_FairySkill_All:GetSizeX(), self._defaultPanelSizeY + moveValue + gap)
      self._ui_pc.btn_Close_Bottom_pc:SetPosY(self._defaultPcCloseBtnPosY + moveValue + gap)
    else
      Panel_Window_FairySkill_All:SetSize(Panel_Window_FairySkill_All:GetSizeX(), self._defaultPanelSizeY + moveValue - self._ui_console.stc_KeyGuide_B:GetSizeY() + gap)
      self._ui_console._stc_KeyGuide_ConsoleUI:SetPosY(self._defaultKeyGuidePosY + moveValue - self._ui_console.stc_KeyGuide_B:GetSizeY() + gap)
    end
  else
    local moveValue = self._ui._stc_BottomDescBG:GetSizeY() * -1
    if false == _ContentsGroup_UsePadSnapping then
      Panel_Window_FairySkill_All:SetSize(Panel_Window_FairySkill_All:GetSizeX(), self._defaultPanelSizeY + moveValue)
      self._ui_pc.btn_Close_Bottom_pc:SetPosY(self._defaultPcCloseBtnPosY + moveValue)
    else
      Panel_Window_FairySkill_All:SetSize(Panel_Window_FairySkill_All:GetSizeX(), self._defaultPanelSizeY + moveValue - self._ui_console.stc_KeyGuide_B:GetSizeY())
      self._ui_console._stc_KeyGuide_ConsoleUI:SetPosY(self._defaultKeyGuidePosY + moveValue - self._ui_console.stc_KeyGuide_B:GetSizeY())
    end
  end
  local keyGuides = {
    self._ui_console._txt_Y_ConsoleUI,
    self._ui_console._txt_B_ConsoleUI
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console._stc_KeyGuide_ConsoleUI, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_FairySkill_All:registEventHandler()
  if nil == Panel_Window_FairySkill_All then
    return
  end
  self._ui.list2_Skill:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_FairySkill_CreateList_All")
  self._ui.list2_Skill:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui_pc.btn_Close_Top_pc:addInputEvent("Mouse_LUp", "PaGlobalFunc_FairySkill_Close_All()")
  self._ui_pc.btn_Close_Bottom_pc:addInputEvent("Mouse_LUp", "PaGlobalFunc_FairySkill_Close_All()")
  self._ui._btn_Question_pc:addInputEvent("Mouse_LUp", "InputMLUp_FairySkill_Window_FairyRateDesc_Open()")
  self._ui._btn_Question_pc:addInputEvent("Mouse_On", "InputMOnOut_FairySkill_Window_FairyRateDesc_ShowToolTip(" .. tostring(true) .. ")")
  self._ui._btn_Question_pc:addInputEvent("Mouse_Out", "InputMOnOut_FairySkill_Window_FairyRateDesc_ShowToolTip(" .. tostring(false) .. ")")
  if true == _ContentsGroup_FairySkillChangeRateView and true == _ContentsGroup_UsePadSnapping and nil ~= Panel_Window_FairyRateDesc then
    Panel_Window_FairySkill_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "InputMLUp_FairySkill_Window_FairyRateDesc_Open()")
  end
  registerEvent("FromClient_Fairy_Update", "FromClient_FairySkill_Update")
end
function PaGlobal_FairySkill_All:prepareOpen(isAllSkillShow)
  if nil == Panel_Window_FairySkill_All then
    return
  end
  self._isAllSkillShow = isAllSkillShow
  if true == isAllSkillShow then
    Panel_Window_FairySkill_All:SetPosX(Panel_Window_FairyChangeSkill_All:GetPosX() - Panel_Window_FairySkill_All:GetSizeX() - 5)
    Panel_Window_FairySkill_All:SetPosY(Panel_Window_FairyChangeSkill_All:GetPosY())
    self._ui.stc_TitleName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FIARYSKILLCHANGE_VIEWSKILL"))
    self:update_AllSkillShow(true)
  else
    self._ui.stc_TitleName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_SHOW_SKILL_LIST"))
    PaGlobal_FairyPanel_ALL_Close()
    self:update(true)
  end
  self._ui._btn_Question_pc:SetShow(false)
  self._ui._stc_BottomDescBG:SetShow(false)
  if true == _ContentsGroup_UsePadSnapping then
    self._ui_console._txt_Y_ConsoleUI:SetShow(false)
  end
  PaGlobal_FairyInfo_All._isShowSkillRate = false
  self:setAlignKeyGuide()
  PaGlobal_FairySkill_All:open()
end
function PaGlobal_FairySkill_All:prepareOpenRateView()
  if nil == Panel_Window_FairySkill_All then
    return
  end
  if false == _ContentsGroup_FairySkillChangeRateView then
    return
  end
  Panel_Window_FairySkill_All:SetPosX(Panel_Window_FairyChangeSkill_All:GetPosX() - Panel_Window_FairySkill_All:GetSizeX() - 5)
  Panel_Window_FairySkill_All:SetPosY(Panel_Window_FairyChangeSkill_All:GetPosY())
  local titleStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRYRATE_VIEW_TITLE")
  self._ui.stc_TitleName:SetText(titleStr)
  self:update_AllSkillShow(true)
  if false == _ContentsGroup_UsePadSnapping then
    self._ui._btn_Question_pc:SetShow(true)
  else
    self._ui_console._txt_Y_ConsoleUI:SetShow(true)
  end
  self._ui._stc_BottomDescBG:SetShow(true)
  self:setAlignKeyGuide()
  PaGlobal_FairySkill_All:open()
end
function PaGlobal_FairySkill_All:open()
  if nil == Panel_Window_FairySkill_All then
    return
  end
  Panel_Window_FairySkill_All:SetShow(true)
end
function PaGlobal_FairySkill_All:prepareClose()
  if nil == Panel_Window_FairySkill_All then
    return
  end
  PaGlobal_FairyInfo_All._isShowSkillRate = false
  PaGlobal_FairySkill_All:close()
end
function PaGlobal_FairySkill_All:close()
  if nil == Panel_Window_FairySkill_All then
    return
  end
  Panel_Window_FairySkill_All:SetShow(false)
end
function PaGlobal_FairySkill_All:update(isScroll)
  if nil == Panel_Window_FairySkill_All then
    return
  end
  local unSealCount = ToClient_getFairyUnsealedList()
  local isUnseal = false
  if unSealCount > 0 then
    isUnseal = true
  end
  if true == isUnseal then
    pcFairyData = ToClient_getFairyUnsealedDataByIndex(0)
  else
    pcFairyData = ToClient_getFairySealedDataByIndex(0)
  end
  if nil == pcFairyData then
    return
  end
  self.exceptGroupkey = {}
  local LearnableSkillList = {}
  local LearnableSkillSortList = {}
  local skillCount = PaGloblFunc_FairyInfo_GetFairySkillCount_All()
  local petStaticStatus = pcFairyData:getPetStaticStatus()
  for ii = 0, skillCount - 1 do
    if true == ToClient_Fairy_GetIsLearnableFairySkillByIndex(petStaticStatus, ii) then
      LearnableSkillList[ii] = true
    end
  end
  for key, value in pairs(LearnableSkillList) do
    if true == pcFairyData:isFairyEquipSkillLearned(key) then
      LearnableSkillList[key] = nil
      local equipGroupkey = ToClient_Fairy_GetGroupKeyByIndex(key)
      if -1 ~= equipGroupkey then
        self.exceptGroupkey[equipGroupkey] = true
      end
    else
      table.insert(LearnableSkillSortList, key)
    end
  end
  local sortFunc = function(a, b)
    return a < b
  end
  table.sort(LearnableSkillSortList, sortFunc)
  local toIndex = 0
  local scrollvalue = 0
  local vscroll = self._ui.list2_Skill:GetVScroll()
  local hscroll = self._ui.list2_Skill:GetHScroll()
  if not isScroll then
    toIndex = self._ui.list2_Skill:getCurrenttoIndex()
    if false == self._ui.list2_Skill:IsIgnoreVerticalScroll() then
      scrollvalue = vscroll:GetControlPos()
    end
  end
  self._ui.stc_skillIcons = {}
  self._ui.list2_Skill:getElementManager():clearKey()
  for key, value in pairs(LearnableSkillSortList) do
    local equipGroupkey = ToClient_Fairy_GetGroupKeyByIndex(value)
    if not self.exceptGroupkey[equipGroupkey] then
      self._ui.list2_Skill:getElementManager():pushKey(value)
    end
  end
  for key, value in pairs(LearnableSkillSortList) do
    local equipGroupkey = ToClient_Fairy_GetGroupKeyByIndex(value)
    if self.exceptGroupkey[equipGroupkey] then
      self._ui.list2_Skill:getElementManager():pushKey(value)
    end
  end
  if not isScroll then
    self._ui.list2_Skill:setCurrenttoIndex(toIndex)
    if false == self._ui.list2_Skill:IsIgnoreVerticalScroll() then
      vscroll:SetControlPos(scrollvalue)
    end
  end
end
function PaGlobal_FairySkill_All:update_AllSkillShow(isScroll)
  if nil == Panel_Window_FairySkill_All then
    return
  end
  local unSealCount = ToClient_getFairyUnsealedList()
  local isUnseal = false
  if unSealCount > 0 then
    isUnseal = true
  end
  if true == isUnseal then
    pcFairyData = ToClient_getFairyUnsealedDataByIndex(0)
  else
    pcFairyData = ToClient_getFairySealedDataByIndex(0)
  end
  if nil == pcFairyData then
    return
  end
  if nil == Panel_Window_FairySkill_All then
    return
  end
  local unSealCount = ToClient_getFairyUnsealedList()
  local isUnseal = false
  if unSealCount > 0 then
    isUnseal = true
  end
  if true == isUnseal then
    pcFairyData = ToClient_getFairyUnsealedDataByIndex(0)
  else
    pcFairyData = ToClient_getFairySealedDataByIndex(0)
  end
  if nil == pcFairyData then
    return
  end
  if true == PaGlobal_FairyInfo_All._isShowSkillRate and true == _ContentsGroup_FairySkillChangeRateView then
    local changeAbleSkillList = {}
    local changeAbleSkillSortList = {}
    local skillCount = PaGloblFunc_FairyInfo_GetFairySkillCount_All()
    local petStaticStatus = pcFairyData:getPetStaticStatus()
    for ii = 0, skillCount - 1 do
      local rate = ToClient_GetLeanableFairySkillRate(ii)
      if 0 ~= rate then
        changeAbleSkillList[ii] = rate
      end
    end
    for key, value in pairs(changeAbleSkillList) do
      table.insert(changeAbleSkillSortList, key)
    end
    local sortFunc = function(a, b)
      return a < b
    end
    table.sort(changeAbleSkillSortList, sortFunc)
    self._ui.list2_Skill:getElementManager():clearKey()
    for key, value in pairs(changeAbleSkillSortList) do
      self._ui.list2_Skill:getElementManager():pushKey(value)
    end
  else
    local LearnableSkillList = {}
    local LearnableSkillSortList = {}
    local skillCount = PaGloblFunc_FairyInfo_GetFairySkillCount_All()
    local petStaticStatus = pcFairyData:getPetStaticStatus()
    for ii = 0, skillCount - 1 do
      if true == ToClient_Fairy_GetIsLearnableFairySkillByIndex(petStaticStatus, ii) then
        LearnableSkillList[ii] = true
      end
    end
    for key, value in pairs(LearnableSkillList) do
      table.insert(LearnableSkillSortList, key)
    end
    local sortFunc = function(a, b)
      return a < b
    end
    table.sort(LearnableSkillSortList, sortFunc)
    self._ui.list2_Skill:getElementManager():clearKey()
    for key, value in pairs(LearnableSkillSortList) do
      self._ui.list2_Skill:getElementManager():pushKey(value)
    end
  end
end
function PaGlobal_FairySkill_All:validate()
  if nil == Panel_Window_FairySkill_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui.stc_TitleName:isValidate()
  self._ui_pc.btn_Close_Top_pc:isValidate()
  self._ui.stc_MainBG:isValidate()
  self._ui.list2_Skill:isValidate()
  self._ui_pc.btn_Close_Bottom_pc:isValidate()
  self._ui_console.stc_KeyGuide_B:isValidate()
  self._ui._btn_Question_pc:isValidate()
  self._ui._stc_BottomDescBG:isValidate()
  self._ui_console._stc_KeyGuide_ConsoleUI:isValidate()
  self._ui_console._txt_B_ConsoleUI:isValidate()
  self._ui_console._txt_Y_ConsoleUI:isValidate()
end
function PaGlobal_FairySkill_All:getShow()
  if nil == Panel_Window_FairySkill_All then
    return
  end
  return Panel_Window_FaIryTierUpgrade_All:GetShow()
end
function PaGlobal_FairySkill_All:SetPos()
  if nil == Panel_Window_FairySkill_All then
    return
  end
  Panel_Window_FairySkill_All:ComputePos()
end
function PaGlobal_FairySkill_CreateList_All(control, key)
  if nil == Panel_Window_FairySkill_All then
    return
  end
  local _static_SkillIcon1 = UI.getChildControl(control, "Static_SkillIcon")
  local _static_MasterIcon1 = UI.getChildControl(_static_SkillIcon1, "Static_MasterIcon")
  local _staticText_SkillName1 = UI.getChildControl(control, "StaticText_SkillName")
  local _staticText_SkillDesc1 = UI.getChildControl(control, "StaticText_SkillDesc")
  local _staticText_SkillRate = UI.getChildControl(control, "Static_1")
  local _staticText_SkillRateText = UI.getChildControl(control, "StaticText_1")
  local skillkey = tonumber(tostring(key))
  local isExistEqualGroupSkill = false
  local equipGroupkey = ToClient_Fairy_GetGroupKeyByIndex(skillkey)
  if -1 ~= equipGroupkey and PaGlobal_FairySkill_All.exceptGroupkey[equipGroupkey] then
    isExistEqualGroupSkill = true
  end
  local skillSSW = ToClient_Fairy_EquipSkillWrraper(skillkey)
  if nil == skillSSW then
    return
  end
  local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
  _static_SkillIcon1:ChangeTextureInfoName("Icon/" .. skillTypeSSW:getIconPath())
  if false == _ContentsGroup_UsePadSnapping then
    _static_SkillIcon1:SetIgnore(true)
    control:addInputEvent("Mouse_On", "InputMOn_FairySkill_ShowTooltip(true, " .. skillkey .. ")")
    control:addInputEvent("Mouse_Out", "InputMOn_FairySkill_ShowTooltip(false)")
  else
    _static_SkillIcon1:addInputEvent("Mouse_On", "InputMOn_FairySkill_ShowTooltip(true, " .. skillkey .. ")")
    _static_SkillIcon1:addInputEvent("Mouse_Out", "InputMOn_FairySkill_ShowTooltip(false)")
  end
  _staticText_SkillDesc1:SetTextMode(__eTextMode_LimitText)
  _staticText_SkillName1:SetTextMode(__eTextMode_LimitText)
  _staticText_SkillDesc1:SetText(skillTypeSSW:getDescription())
  _staticText_SkillName1:SetText(skillTypeSSW:getName())
  _static_MasterIcon1:SetShow(Toclient_FairySkill_IsMaxLevel(PaGlobal_FairyInfo_GetFairyKey_All(), skillkey))
  if true == PaGlobal_FairySkill_All._isAllSkillShow then
    PaGlobal_FairySkill_All._ui.stc_skillIcons[skillkey] = _static_SkillIcon1
    _static_SkillIcon1:SetMonoTone(false)
    _staticText_SkillDesc1:SetFontColor(Defines.Color.C_FF9397A7)
    _staticText_SkillName1:SetFontColor(Defines.Color.C_FFEDEDEE)
  else
    _static_SkillIcon1:SetMonoTone(isExistEqualGroupSkill)
    PaGlobal_FairySkill_All._ui.stc_skillIcons[skillkey] = _static_SkillIcon1
    if true == isExistEqualGroupSkill then
      _staticText_SkillDesc1:SetFontColor(Defines.Color.C_FF525B6D)
      _staticText_SkillName1:SetFontColor(Defines.Color.C_FF525B6D)
    else
      _staticText_SkillDesc1:SetFontColor(Defines.Color.C_FF9397A7)
      _staticText_SkillName1:SetFontColor(Defines.Color.C_FFEDEDEE)
    end
  end
  if true == PaGlobal_FairyInfo_All._isShowSkillRate and true == _ContentsGroup_FairySkillChangeRateView then
    local rate = 0
    rate = ToClient_GetLeanableFairySkillRate(skillkey)
    if 0 ~= rate then
      _staticText_SkillRate:SetShow(true)
      _staticText_SkillRateText:SetShow(true)
      _staticText_SkillRateText:SetText(string.format("%.2f", rate) .. "%")
    else
      _staticText_SkillRate:SetShow(false)
      _staticText_SkillRateText:SetShow(false)
    end
  else
    _staticText_SkillRate:SetShow(false)
    _staticText_SkillRateText:SetShow(false)
  end
end
function PaGlobal_FairySkill_All:ShowTooltip(isShow, skillkey)
  if nil == Panel_Window_FairySkill_All then
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local skillSSW = ToClient_Fairy_EquipSkillWrraper(skillkey)
  if nil == skillSSW then
    return
  end
  local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
  if true == Toclient_FairySkill_IsMaxLevel(PaGlobal_FairyInfo_GetFairyKey_All(), skillkey) then
    TooltipSimple_Show(self._ui.stc_skillIcons[skillkey], skillTypeSSW:getName(), skillTypeSSW:getDescription() .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_SKILLTOOLTIP_MASTERSKILL"))
  else
    TooltipSimple_Show(self._ui.stc_skillIcons[skillkey], skillTypeSSW:getName(), skillTypeSSW:getDescription())
  end
end
