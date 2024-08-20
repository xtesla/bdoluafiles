function PaGlobal_ServantSkillManagement_All:initialize()
  if nil == Panel_Dialog_ServantSkillManagement_All or true == self._initailize then
    return
  end
  self._ui._stc_TitleBg = UI.getChildControl(Panel_Dialog_ServantSkillManagement_All, "Static_TitleBg")
  self._ui._txt_TitleIcon = UI.getChildControl(self._ui._stc_TitleBg, "StaticText_TitleIcon")
  self._ui._btn_Close = UI.getChildControl(self._ui._stc_TitleBg, "Button_Close")
  self._ui._btn_Question = UI.getChildControl(self._ui._stc_TitleBg, "Button_Question")
  self._ui._stc_TabGroup = UI.getChildControl(Panel_Dialog_ServantSkillManagement_All, "Static_TabGroup")
  self._ui._rdo_LearnedSkill = UI.getChildControl(self._ui._stc_TabGroup, "RadioButton_LearnedSkill")
  self._ui._rdo_WishSkill = UI.getChildControl(self._ui._stc_TabGroup, "RadioButton_WishSkill")
  self._ui._stc_Line = UI.getChildControl(self._ui._stc_TabGroup, "Static_Line")
  self._ui._stc_SelectedLine = UI.getChildControl(self._ui._stc_TabGroup, "Static_SelectedLine")
  self._ui._stc_KeyGuides_LB = UI.getChildControl(self._ui._stc_TabGroup, "StaticText_LB_ConsoleUI")
  self._ui._stc_KeyGuides_RB = UI.getChildControl(self._ui._stc_TabGroup, "StaticText_RB_ConsoleUI")
  self._ui._stc_LearnSkillBg = UI.getChildControl(Panel_Dialog_ServantSkillManagement_All, "Static_LearnSkillBg")
  self._ui._list2_LearnSkill = UI.getChildControl(self._ui._stc_LearnSkillBg, "List2_LearnSkill")
  self._ui._list2_LearnSkill_Content = UI.getChildControl(self._ui._list2_LearnSkill, "List2_1_Content")
  self._ui._list2_LearnSkill_stc_SkillSlotBg = UI.getChildControl(self._ui._list2_LearnSkill_Content, "Static_SkillSlotBg")
  self._ui._list2_LearnSkill_stc_SkillExpBg = UI.getChildControl(self._ui._list2_LearnSkill_Content, "Static_SkillExpBg")
  self._ui._list2_LearnSkill_circularProg2_SkillExp = UI.getChildControl(self._ui._list2_LearnSkill_Content, "CircularProgress_SkillExp")
  self._ui._list2_LearnSkill_stc_SkillIcon = UI.getChildControl(self._ui._list2_LearnSkill_Content, "Static_SkillIcon")
  self._ui._list2_LearnSkill_txt_SkillExpPercent = UI.getChildControl(self._ui._list2_LearnSkill_Content, "StaticText_SkillExpPercent")
  self._ui._list2_LearnSkill_txt_SkillName = UI.getChildControl(self._ui._list2_LearnSkill_Content, "StaticText_SkillName")
  self._ui._list2_LearnSkill_txt_SkillCommand = UI.getChildControl(self._ui._list2_LearnSkill_Content, "StaticText_SkillCommandValue")
  self._ui._list2_LearnSkill_btn_Train_PC = UI.getChildControl(self._ui._list2_LearnSkill_Content, "Button_Train_PCUI")
  self._ui._list2_LearnSkill_btn_Delete_PC = UI.getChildControl(self._ui._list2_LearnSkill_Content, "Button_Delete_PCUI")
  self._ui._btn_TrainAll_PC = UI.getChildControl(self._ui._stc_LearnSkillBg, "Button_TrainAll_PCUI")
  self._ui._stc_Center_WishSKillBg = UI.getChildControl(Panel_Dialog_ServantSkillManagement_All, "Static_CenterWishSkillBg")
  self._ui._stc_Center_ContentBg = UI.getChildControl(self._ui._stc_Center_WishSKillBg, "Static_ContentBg")
  self._ui._txt_Center_PercentTitle = UI.getChildControl(self._ui._stc_Center_WishSKillBg, "StaticText_PercentTitle")
  self._ui._txt_Center_PercentValue = UI.getChildControl(self._ui._stc_Center_WishSKillBg, "StaticText_PercentValue")
  self._ui._txt_Center_DeleteSkillTitle = UI.getChildControl(self._ui._stc_Center_WishSKillBg, "StaticText_DeleteSkillTitle")
  self._ui._stc_Center_DeleteSkilBg = UI.getChildControl(self._ui._stc_Center_WishSKillBg, "Static_DeleteSkillBg")
  self._ui._stc_Delete_PlusIcon = UI.getChildControl(self._ui._stc_Center_DeleteSkilBg, "Static_PlusIcon")
  self._ui._stc_Delete_SkillExpBg = UI.getChildControl(self._ui._stc_Center_DeleteSkilBg, "Static_SkillExpBg")
  self._ui._stc_Delete_CircularProg2_SkillExp = UI.getChildControl(self._ui._stc_Center_DeleteSkilBg, "CircularProgress_SkillExp")
  self._ui._stc_Delete_SkillIcon = UI.getChildControl(self._ui._stc_Center_DeleteSkilBg, "Static_SkillIcon")
  self._ui._stc_Delete_SkillExpPercent = UI.getChildControl(self._ui._stc_Center_DeleteSkilBg, "StaticText_SkillExpPercent")
  self._ui._stc_Delete_SkillName = UI.getChildControl(self._ui._stc_Center_DeleteSkilBg, "StaticText_SkillName")
  self._ui._stc_Delete_SkillStallionIcon = UI.getChildControl(self._ui._stc_Center_DeleteSkilBg, "Static_SkillStallionIcon")
  self._ui._stc_Delete_SkillCommand = UI.getChildControl(self._ui._stc_Center_DeleteSkilBg, "StaticText_SkillCommandValue")
  self._ui._txt_WishSkillTitle = UI.getChildControl(self._ui._stc_Center_WishSKillBg, "StaticText_WishSkillTitle")
  self._ui._stc_WishSKillBg = UI.getChildControl(self._ui._stc_Center_WishSKillBg, "Static_WishSkillBg")
  self._ui._stc_PlusIcon = UI.getChildControl(self._ui._stc_WishSKillBg, "Static_PlusIcon")
  self._ui._stc_WishSkill_SkillExpBg = UI.getChildControl(self._ui._stc_WishSKillBg, "Static_SkillExpBg")
  self._ui._stc_WishSkill_CircularProg2_Exp = UI.getChildControl(self._ui._stc_WishSKillBg, "CircularProgress_SkillExp")
  self._ui._stc_WishSkill_SkillExpPercent = UI.getChildControl(self._ui._stc_WishSKillBg, "StaticText_SkillExpPercent")
  self._ui._stc_WishSkill_SkillIcon = UI.getChildControl(self._ui._stc_WishSKillBg, "Static_SkillIcon")
  self._ui._stc_WishSkill_SkillName = UI.getChildControl(self._ui._stc_WishSKillBg, "StaticText_SkillName")
  self._ui._stc_WishSkill_SkillStallionIcon = UI.getChildControl(self._ui._stc_WishSKillBg, "Static_SkillStallionIcon")
  self._ui._stc_WishSkill_SkillCommand = UI.getChildControl(self._ui._stc_WishSKillBg, "StaticText_SkillCommandValue")
  self._ui._stc_DescBg = UI.getChildControl(self._ui._stc_Center_WishSKillBg, "Static_DescBg")
  self._ui._txt_Desc = UI.getChildControl(self._ui._stc_DescBg, "StaticText_Desc")
  self._ui._btn_Change_PC = UI.getChildControl(self._ui._stc_Center_WishSKillBg, "Button_Change_PCUI")
  self._ui._stc_SkillListBg = UI.getChildControl(Panel_Dialog_ServantSkillManagement_All, "Static_SkillListBg")
  self._ui._stc_SkillListTitle = UI.getChildControl(self._ui._stc_SkillListBg, "Static_TitleArea")
  self._ui._btn_SkillRateQuestion = UI.getChildControl(self._ui._stc_SkillListTitle, "Button_Question")
  self._ui._btn_SkillRateQuestion:SetShow(false)
  self._ui._txt_SkillListTitle = UI.getChildControl(self._ui._stc_SkillListTitle, "StaticText_Title")
  self._ui._stc_SkillRateDesc = UI.getChildControl(self._ui._stc_SkillListBg, "Static_DescBg")
  self._ui._txt_SkillRateDesc = UI.getChildControl(self._ui._stc_SkillRateDesc, "StaticText_Desc")
  self._ui._list2_ServantSkill = UI.getChildControl(self._ui._stc_SkillListBg, "List2_ServantSkill")
  self._ui._list2_ServantSkill_Content = UI.getChildControl(self._ui._list2_ServantSkill, "List2_1_Content")
  self._ui._list2_ServantSkill_Content:SetShow(false)
  self._ui._list2_ServantSkill_SkillSlotBG = UI.getChildControl(self._ui._list2_ServantSkill_Content, "Static_SkillSlotBg")
  self._ui._list2_ServantSkill_SkillExpBg = UI.getChildControl(self._ui._list2_ServantSkill_Content, "Static_SkillExpBg")
  self._ui._list2_ServantSkill_CircurlarProg2Exp = UI.getChildControl(self._ui._list2_ServantSkill_Content, "CircularProgress_SkillExp")
  self._ui._list2_ServantSkill_SkillIcon = UI.getChildControl(self._ui._list2_ServantSkill_Content, "Static_SkillIcon")
  self._ui._list2_ServantSkill_SkillExpPercent = UI.getChildControl(self._ui._list2_ServantSkill_Content, "StaticText_SkillExpPercent")
  self._ui._list2_ServantSkill_SkillName = UI.getChildControl(self._ui._list2_ServantSkill_Content, "StaticText_SkillName")
  self._ui._list2_ServantSkill_SkillCommand = UI.getChildControl(self._ui._list2_ServantSkill_Content, "StaticText_SkillCommandValue")
  self._ui._stc_BottomBg_Console = UI.getChildControl(Panel_Dialog_ServantSkillManagement_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_BottomBg_Console, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_BottomBg_Console, "StaticText_B_ConsoleUI")
  self._ui._stc_KeyGuide_Y = UI.getChildControl(self._ui._stc_BottomBg_Console, "StaticText_Y_ConsoleUI")
  self._ui._stc_KeyGuide_X = UI.getChildControl(self._ui._stc_BottomBg_Console, "StaticText_X_ConsoleUI")
  self._ui._stc_KeyGuide_X:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSWCHAGNE_TITLE"))
  self._ui._stc_KeyGuide_X:SetShow(false)
  self._ui_stc_KeyGuide_Scroll = UI.getChildControl(self._ui._stc_BottomBg_Console, "StaticText_Move_ConsoleUI")
  self._rdoTab[1] = self._ui._rdo_LearnedSkill
  self._rdoTab[2] = self._ui._rdo_WishSkill
  self._ori_SkillRateDescY = self._ui._stc_SkillRateDesc:GetSizeY()
  self._ori_SkillListSizeY = self._ui._stc_SkillListBg:GetSizeY()
  self._ori_List2SizeY = self._ui._list2_ServantSkill:GetSizeY()
  self._ui._txt_SkillRateDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_SkillRateDesc:SetText(self._ui._txt_SkillRateDesc:GetText())
  if self._ui._txt_SkillRateDesc:GetSizeY() < self._ui._txt_SkillRateDesc:GetTextSizeY() + 5 then
    self._ui._txt_SkillRateDesc:SetSize(self._ui._txt_SkillRateDesc:GetSizeX(), self._ui._txt_SkillRateDesc:GetTextSizeY())
    self._ui._stc_SkillRateDesc:SetSize(self._ui._stc_SkillRateDesc:GetSizeX(), self._ui._txt_SkillRateDesc:GetTextSizeY() + 15)
    self._ui._stc_SkillListBg:SetSize(self._ui._stc_SkillListBg:GetSizeX(), self._ori_SkillListSizeY + (self._ui._stc_SkillRateDesc:GetSizeY() - self._ori_SkillRateDescY) + 5)
  end
  for idx = 1, #self._rdoTab do
    self._rdoTab[idx]:SetTextMode(__eTextMode_AutoWrap)
    self._rdoTab[idx]:SetText(self._rdoTab[idx]:GetText())
  end
  self._ui._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_Desc:SetText(self._ui._txt_Desc:GetText())
  self._ori_PanelY = Panel_Dialog_ServantSkillManagement_All:GetSizeY()
  self._ori_DescY = self._ui._stc_DescBg:GetSizeY()
  self._ori_WishBgY = self._ui._stc_Center_WishSKillBg:GetSizeY()
  self._learnedSkillNameBaseSpanSizeX = self._ui._list2_LearnSkill_txt_SkillName:GetSpanSize().x
  self._wishSkillNameBaseSpanSizeX = self._ui._stc_WishSkill_SkillName:GetSpanSize().x
  self._deleteSkillNameBaseSpanSizeX = self._ui._stc_Delete_SkillName:GetSpanSize().x
  self._unlearnedSkillNameBaseSpanSizeX = self._ui._list2_ServantSkill_SkillName:GetSpanSize().x
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ServantSkillManagement_All:validate()
  PaGlobal_ServantSkillManagement_All:isConsoleUI(self._isConsole)
  PaGlobal_ServantSkillManagement_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantSkillManagement_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantSkillManagement_All or false == self._initailize then
    return
  end
  registerEvent("onScreenResize", "FromClient_ServantSkillManagement_All_OnScreenResize")
  registerEvent("FromClient_ServantChangeSkill", "FromClient_ServantSkillManagement_All_SkillChangeFinish")
  registerEvent("FromClient_ForgetServantSkill", "FromClient_ServantSkillManagement_All_SkillDeleteFinish")
  self._ui._list2_LearnSkill:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ServantSkillManagement_All_List2_LeranedSKillUpdate")
  self._ui._list2_LearnSkill:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_ServantSkill:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ServantSkillManagement_All_List2_UnLeranedSKillUpdate")
  self._ui._list2_ServantSkill:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._stc_WishSKillBg:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_SkillChangeButtonClick(0)")
  self._ui._stc_Center_DeleteSkilBg:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_SkillChangeButtonClick(1)")
  if false == isConsole then
    Panel_Dialog_ServantSkillManagement_All:SetDragEnable(true)
    Panel_Dialog_ServantSkillManagement_All:SetDragAll(true)
    self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantSkillManagement_All_Close()")
    self._ui._btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowStableShop\" )")
    self._ui._btn_SkillRateQuestion:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_RateDescOpen()")
    self._ui._btn_SkillRateQuestion:addInputEvent("Mouse_On", "HandleEventLUp_ServantSkillManagement_All_RateTooltip(true)")
    self._ui._btn_SkillRateQuestion:addInputEvent("Mouse_Out", "HandleEventLUp_ServantSkillManagement_All_RateTooltip(false)")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui._btn_Question, "\"PanelWindowStableShop\"")
    self._ui._rdo_LearnedSkill:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_TabChange( 0 )")
    self._ui._rdo_WishSkill:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_TabChange( 1 )")
    self._ui._btn_TrainAll_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_TrainingSkillAll()")
    self._ui._btn_Change_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_SkillChange()")
    Panel_Dialog_ServantSkillManagement_All:SetDragEnable(true)
    Panel_Dialog_ServantSkillManagement_All:SetDragAll(true)
  else
    Panel_Dialog_ServantSkillManagement_All:ignorePadSnapMoveToOtherPanel()
    Panel_Dialog_ServantSkillManagement_All:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "HandleEventPadPress_ServantSkillManagement_All_TabChange_Console()")
    Panel_Dialog_ServantSkillManagement_All:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventPadPress_ServantSkillManagement_All_TabChange_Console()")
    Panel_Dialog_ServantSkillManagement_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEventPadScroll_ServantSkillManagement_All_list2Scroll(1)")
    Panel_Dialog_ServantSkillManagement_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEventPadScroll_ServantSkillManagement_All_list2Scroll(-1)")
  end
end
function PaGlobal_ServantSkillManagement_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantSkillManagement_All or false == self._initailize then
    return
  end
  self._ui._stc_BottomBg_Console:SetShow(isConsole)
  self._ui._stc_KeyGuides_LB:SetShow(isConsole)
  self._ui._stc_KeyGuides_RB:SetShow(isConsole)
  self._ui._btn_Change_PC:SetShow(not isConsole)
  self._ui._btn_TrainAll_PC:SetShow(not isConsole)
  self._ui._btn_Question:SetShow(not isConsole)
  self._ui._btn_Close:SetShow(not isConsole)
  PaGlobal_ServantSkillManagement_All:alignKeyGuide()
end
function PaGlobal_ServantSkillManagement_All:alignKeyGuide()
  if true == self._isConsole then
    self._ui._list2_LearnSkill_btn_Train_PC:SetSpanSize(self._ui._list2_LearnSkill_btn_Delete_PC:GetSpanSize().x, self._ui._list2_LearnSkill_btn_Train_PC:GetSpanSize().y)
    local keyguide = {
      self._ui_stc_KeyGuide_Scroll,
      self._ui._stc_KeyGuide_X,
      self._ui._stc_KeyGuide_Y,
      self._ui._stc_KeyGuide_A,
      self._ui._stc_KeyGuide_B
    }
    self._keyguides = keyguide
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui._stc_BottomBg_Console, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_ServantSkillManagement_All:prepareOpen()
  if nil == Panel_Dialog_ServantSkillManagement_All or true == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  PaGlobal_ServantSkillManagement_All:open()
  PaGlobal_ServantSkillManagement_All:resize()
  FromClient_ServantTransferList_All_OnScreenResize()
  PaGlobal_ServantSkillManagement_All:dataClear()
  self._isShowSkillChangeRate = false
  HandleEventLUp_ServantSkillManagement_All_TabChange(0)
end
function PaGlobal_ServantSkillManagement_All:open()
  if nil == Panel_Dialog_ServantSkillManagement_All or true == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  Panel_Dialog_ServantSkillManagement_All:SetShow(true)
end
function PaGlobal_ServantSkillManagement_All:resize()
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  local gap = 10
  local btnSize = self._ui._btn_Change_PC:GetSizeY() + 20
  Panel_Dialog_ServantSkillManagement_All:SetSize(Panel_Dialog_ServantSkillManagement_All:GetSizeX(), self._ori_PanelY)
  if self._tabType == self._eType.learn then
    if true == self._isConsole then
      Panel_Dialog_ServantSkillManagement_All:SetSize(Panel_Dialog_ServantSkillManagement_All:GetSizeX(), Panel_Dialog_ServantSkillManagement_All:GetSizeY() - btnSize)
      self._ui._stc_LearnSkillBg:SetSize(self._ui._stc_LearnSkillBg:GetSizeX(), self._ui._stc_LearnSkillBg:GetSizeY() - btnSize)
    end
  elseif self._tabType == self._eType.notLearn and self._ori_DescY < self._ui._txt_Desc:GetTextSizeY() + gap then
    local addSizeY = self._ui._txt_Desc:GetTextSizeY() + gap - self._ori_DescY
    self._ui._stc_DescBg:SetSize(self._ui._stc_DescBg:GetSizeX(), self._ori_DescY + addSizeY)
    self._ui._txt_Desc:ComputePos()
    if true == self._isConsole then
      addSizeY = addSizeY - btnSize
    end
    Panel_Dialog_ServantSkillManagement_All:SetSize(Panel_Dialog_ServantSkillManagement_All:GetSizeX(), self._ori_PanelY + addSizeY)
    self._ui._stc_Center_WishSKillBg:SetSize(self._ui._stc_Center_WishSKillBg:GetSizeX(), self._ori_WishBgY + addSizeY)
  end
  self._ui._stc_BottomBg_Console:SetPosY(Panel_Dialog_ServantSkillManagement_All:GetSizeY())
  self._ui._btn_Change_PC:ComputePos()
  self._ui._btn_TrainAll_PC:ComputePos()
  Panel_Dialog_ServantSkillManagement_All:ComputePos()
end
function PaGlobal_ServantSkillManagement_All:update(currentTab)
  if nil == Panel_Dialog_ServantSkillManagement_All or nil == self._currentServantInfo then
    return
  end
  if nil == self._currentServantInfo then
    return
  end
  local servantInfo = self._currentServantInfo
  local skillCount = 0
  if false == servantInfo:doHaveVehicleSkill() then
    return
  end
  skillCount = servantInfo:getSkillCount()
  if 0 == skillCount then
    return
  end
  self._ui._txt_Center_PercentValue:SetText("+" .. servantInfo:getSkillFailedCount())
  self._skillIdxTable = {}
  self._ui._list2_LearnSkill:getElementManager():clearKey()
  self._ui._list2_ServantSkill:getElementManager():clearKey()
  local uiCount = 1
  for skillIdx = 1, skillCount - 1 do
    if 0 == currentTab then
      if true == self._isContentsTrainingAllEnable then
        self._ui._btn_TrainAll_PC:SetShow(not self._isConsole)
      else
        self._ui._btn_TrainAll_PC:SetShow(false)
      end
      skillWrapper = servantInfo:getSkill(skillIdx)
      if nil ~= skillWrapper and false == skillWrapper:isTrainingSkill() then
        self._skillIdxTable[skillIdx] = skillIdx
        self._ui._list2_LearnSkill:getElementManager():pushKey(toInt64(0, skillIdx))
      end
    end
  end
end
function PaGlobal_ServantSkillManagement_All:updateList2_LearnedSKillTab(content, key)
  if nil == self._currentServantInfo or false == Panel_Dialog_ServantSkillManagement_All:GetShow() or nil == Panel_Dialog_ServantSkillManagement_All then
    return
  end
  local key32 = Int64toInt32(key)
  local stc_SkillSlotBg = UI.getChildControl(content, "Static_SkillSlotBg")
  local expBg = UI.getChildControl(content, "Static_SkillExpBg")
  local circle_Prog2_Exp = UI.getChildControl(content, "CircularProgress_SkillExp")
  local skillIcon = UI.getChildControl(content, "Static_SkillIcon")
  local skillExpPercent = UI.getChildControl(content, "StaticText_SkillExpPercent")
  local skillName = UI.getChildControl(content, "StaticText_SkillName")
  local skillCommand = UI.getChildControl(content, "StaticText_SkillCommandValue")
  local btn_Train_PC = UI.getChildControl(content, "Button_Train_PCUI")
  local btn_Delete_PC = UI.getChildControl(content, "Button_Delete_PCUI")
  local skillStallionIcon = UI.getChildControl(content, "Static_SkillStallionIcon")
  btn_Train_PC:SetShow(false)
  btn_Delete_PC:SetShow(false)
  local servantInfo = self._currentServantInfo
  if nil == servantInfo then
    content:SetShow(false)
    return
  else
    content:SetShow(true)
  end
  expBg:SetShow(false)
  local hasRentOwnerFlag = Defines.s64_const.s64_0 < servantInfo:getRentOwnerNo()
  local skillWrapper = servantInfo:getSkill(key32)
  local servantState = servantInfo:getStateType()
  if nil ~= skillWrapper and false == skillWrapper:isTrainingSkill() then
    skillIcon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
    skillIcon:addInputEvent("Mouse_On", "HandleEventLOn_ServantSkillManagement_All_Servant_Tooltip_Open(" .. key32 .. ")")
    skillIcon:addInputEvent("Mouse_Out", "HandleEventOut_ServantSkillManagement_All_SkillTooltipClose()")
    local isStallionSkill = servantInfo:isStallionSkill(skillWrapper:getKey())
    skillStallionIcon:SetShow(isStallionSkill)
    local skillNameSpanSizeX = self._learnedSkillNameBaseSpanSizeX
    if true == isStallionSkill then
      local gabX = 5
      skillNameSpanSizeX = skillNameSpanSizeX + skillStallionIcon:GetSizeX() - gabX
      if false == self._isConsole then
        skillStallionIcon:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSkillManagement_All_ShowStallionToolTipByLearnedSkillList(true," .. self._eStallionTooltipType.learnList .. "," .. key32 .. ")")
        skillStallionIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSkillManagement_All_ShowStallionToolTipByLearnedSkillList(false)")
      end
    end
    skillName:SetSpanSize(skillNameSpanSizeX, skillName:GetSpanSize().y)
    skillName:SetText(skillWrapper:getName())
    local expPercentTxt = servantInfo:getSkillExp(key32) / (skillWrapper:getMaxExp() / 100)
    circle_Prog2_Exp:SetShow(true)
    if expPercentTxt >= 100 then
      expPercentTxt = 100
    elseif true == self._isContentsTrainingEnable then
      if servantInfo:isSeized() or CppEnums.ServantStateType.Type_RegisterMarket == servantState or CppEnums.ServantStateType.Type_RegisterMating == servantState or CppEnums.ServantStateType.Type_Mating == servantState or servantInfo:isMatingComplete() or CppEnums.ServantStateType.Type_Coma == servantState or CppEnums.ServantStateType.Type_SkillTraining == servantState or servantInfo:isLink() then
        btn_Train_PC:SetShow(false)
      else
        btn_Train_PC:SetShow(false)
        if CppEnums.VehicleType.Type_Carriage ~= servantInfo:getVehicleType() then
          if true == hasRentOwnerFlag then
            btn_Train_PC:SetShow(false)
          else
            btn_Train_PC:SetShow(true)
          end
        end
      end
    end
    if servantInfo:isSkillLock(key32) then
      if servantInfo:getStateType() ~= CppEnums.ServantStateType.Type_SkillTraining then
      end
    else
      btn_Delete_PC:SetShow(false)
      if false == _ContentsGroup_RenewUI and not servantInfo:isSeized() and CppEnums.ServantStateType.Type_SkillTraining ~= servantInfo:getStateType() and CppEnums.VehicleType.Type_Carriage ~= servantInfo:getVehicleType() then
        if true == hasRentOwnerFlag then
          btn_Delete_PC:SetShow(false)
        else
          btn_Delete_PC:SetShow(false)
        end
        if true == servantInfo:isStallion() and true == servantInfo:isStallionSkill(key32) then
          btn_Delete_PC:SetShow(false)
        else
          btn_Delete_PC:SetShow(true)
        end
      end
    end
    expBg:SetShow(true)
    skillExpPercent:SetText(tonumber(string.format("%.0f", expPercentTxt)) .. "%")
    skillCommand:SetText(skillWrapper:getDescription())
    circle_Prog2_Exp:SetProgressRate(expPercentTxt)
    btn_Train_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_TrainingSkill(" .. key32 .. ")")
    btn_Delete_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_DeleteSkill(" .. key32 .. ")")
  end
end
function PaGlobal_ServantSkillManagement_All:updateList2_UnLearnSKill(content, key)
  if nil == self._currentServantInfo or false == Panel_Dialog_ServantSkillManagement_All:GetShow() or nil == Panel_Dialog_ServantSkillManagement_All then
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
  local stc_vertiLine = UI.getChildControl(content, "Static_VerticalLine1")
  local txt_changeRate = UI.getChildControl(content, "StaticText_Rate")
  local unLearn_skillStallionIcon = UI.getChildControl(content, "Static_SkillStallionIcon")
  stc_vertiLine:SetShow(false)
  stc_SkillSlotBg:SetCheck(false)
  txt_changeRate:SetShow(false)
  stc_SkillSlotBg:SetShow(false)
  stc_SkillSlotBg:SetMonoTone(false)
  unLearn_skillIcon:SetMonoTone(false)
  unLearn_skillName:SetMonoTone(false)
  unLearn_skillCommand:SetMonoTone(false)
  stc_SkillSlotBg:setNotImpactScrollEvent(true)
  stc_SkillSlotBg:addInputEvent("Mouse_LUp", "")
  unLearn_skillIcon:addInputEvent("Mouse_On", "")
  unLearn_skillIcon:addInputEvent("Mouse_Out", "")
  local servantInfo = self._currentServantInfo
  if nil == servantInfo then
    content:SetShow(false)
    return
  else
    content:SetShow(true)
  end
  local skillWrapper
  if false == self._isShowSkillChangeRate then
    if false == self._isClickedWishSkill then
      skillWrapper = servantInfo:getSkill(key32)
    else
      skillWrapper = servantInfo:getSkillXXX(key32)
    end
  end
  if false == self._isShowSkillChangeRate then
    if nil ~= skillWrapper and servantInfo:getStateType() ~= CppEnums.ServantStateType.Type_SkillTraining and false == skillWrapper:isTrainingSkill() then
      stc_SkillSlotBg:SetShow(true)
      unLearn_skillIcon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
      unLearn_skillIcon:addInputEvent("Mouse_On", "HandleEventLOn_ServantSkillManagement_All_Servant_Tooltip_Open(" .. key32 .. ")")
      unLearn_skillIcon:addInputEvent("Mouse_Out", "HandleEventOut_ServantSkillManagement_All_SkillTooltipClose()")
      local isStallionSkill = servantInfo:isStallionSkill(skillWrapper:getKey())
      unLearn_skillStallionIcon:SetShow(isStallionSkill)
      local skillNameSpanSizeX = self._unlearnedSkillNameBaseSpanSizeX
      if true == isStallionSkill then
        local gabX = 5
        skillNameSpanSizeX = skillNameSpanSizeX + unLearn_skillStallionIcon:GetSizeX() - gabX
        if false == self._isConsole then
          unLearn_skillStallionIcon:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSkillManagement_All_ShowStallionToolTipByLearnedSkillList(true," .. self._eStallionTooltipType.unLearnList .. "," .. key32 .. ")")
          unLearn_skillStallionIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSkillManagement_All_ShowStallionToolTipByLearnedSkillList(false)")
        end
      end
      unLearn_skillName:SetSpanSize(skillNameSpanSizeX, unLearn_skillName:GetSpanSize().y)
      unLearn_skillName:SetText(skillWrapper:getName())
      unLearn_skillCommand:SetTextMode(__eTextMode_AutoWrap)
      unLearn_skillCommand:SetText(skillWrapper:getDescription())
      if false == self._isClickedWishSkill then
        unLearn_circle_Prog2_Exp:SetShow(true)
        unLearn_skillExpPercent:SetShow(true)
        unLearn_expBg:SetShow(true)
        local expPercentTxt = servantInfo:getSkillExp(key32) / (skillWrapper:getMaxExp() / 100)
        if expPercentTxt >= 100 then
          expPercentTxt = 100
        end
        unLearn_skillExpPercent:SetText(tonumber(string.format("%.0f", expPercentTxt)) .. "%")
        unLearn_circle_Prog2_Exp:SetProgressRate(expPercentTxt)
        local isStallionWithStallionSkill = false
        if true == servantInfo:isStallion() and true == servantInfo:isStallionSkill(key32) then
          isStallionWithStallionSkill = true
        end
        stc_SkillSlotBg:SetMonoTone(isStallionWithStallionSkill)
        unLearn_skillIcon:SetMonoTone(isStallionWithStallionSkill)
        unLearn_skillName:SetMonoTone(isStallionWithStallionSkill)
        unLearn_skillCommand:SetMonoTone(isStallionWithStallionSkill)
        unLearn_skillIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_SkillListClick(" .. key32 .. ", false, " .. tostring(isStallionWithStallionSkill) .. ")")
        stc_SkillSlotBg:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_SkillListClick(" .. key32 .. ", false, " .. tostring(isStallionWithStallionSkill) .. ")")
      else
        unLearn_circle_Prog2_Exp:SetShow(false)
        unLearn_skillExpPercent:SetShow(false)
        unLearn_expBg:SetShow(false)
        unLearn_skillIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_SkillListClick(" .. key32 .. ", true, false)")
        stc_SkillSlotBg:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_SkillListClick(" .. key32 .. ", true, false)")
      end
    end
  else
    unLearn_circle_Prog2_Exp:SetShow(false)
    unLearn_skillExpPercent:SetShow(false)
    unLearn_expBg:SetShow(false)
    unLearn_skillIcon:addInputEvent("Mouse_LUp", "")
    stc_SkillSlotBg:addInputEvent("Mouse_LUp", "")
    local skillKey = ToClient_getServantSkillChangeRateSkillKeyByIndex(self._currentServantNo, self._currentChangeSkillIdx, self._currentWishSkillIdx, key32, false)
    local skillWrapper = servantInfo:getSkillXXX(skillKey)
    if nil ~= skillWrapper then
      stc_SkillSlotBg:SetShow(true)
      unLearn_skillIcon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
      unLearn_skillName:SetText(skillWrapper:getName())
      unLearn_skillCommand:SetTextMode(__eTextMode_AutoWrap)
      unLearn_skillCommand:SetText(skillWrapper:getDescription())
      unLearn_skillIcon:addInputEvent("Mouse_On", "HandleEventLUp_ServantSkillManagement_All_SkillRateTooltip(" .. key32 .. "," .. skillKey .. ")")
      unLearn_skillIcon:addInputEvent("Mouse_Out", "HandleEventOut_ServantSkillManagement_All_SkillTooltipClose()")
      unLearn_skillIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_ReCalculateSkill(" .. skillKey .. "," .. key32 .. ")")
      stc_SkillSlotBg:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSkillManagement_All_ReCalculateSkill(" .. skillKey .. "," .. key32 .. ")")
      local isStallionSkill = servantInfo:isStallionSkill(skillWrapper:getKey())
      unLearn_skillStallionIcon:SetShow(isStallionSkill)
      local skillNameSpanSizeX = self._unlearnedSkillNameBaseSpanSizeX
      if true == isStallionSkill then
        local gabX = 5
        skillNameSpanSizeX = skillNameSpanSizeX + unLearn_skillStallionIcon:GetSizeX() - gabX
        if false == self._isConsole then
          unLearn_skillStallionIcon:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSkillManagement_All_ShowStallionToolTipByLearnedSkillList(true," .. self._eStallionTooltipType.unLearnList .. "," .. key32 .. ")")
          unLearn_skillStallionIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSkillManagement_All_ShowStallionToolTipByLearnedSkillList(false)")
        end
      end
      unLearn_skillName:SetSpanSize(skillNameSpanSizeX, unLearn_skillName:GetSpanSize().y)
      if self._currentWishSkillIdx == skillKey then
        stc_SkillSlotBg:SetCheck(true)
      end
    end
    local rate = ToClient_getServantSkillChangeRate(self._currentServantNo, self._currentChangeSkillIdx, self._currentWishSkillIdx, skillKey, false)
    rate = rate * 100
    local calculratedRate = string.format("%.2f", rate) .. "%"
    txt_changeRate:SetText(calculratedRate)
    stc_vertiLine:SetShow(true)
    txt_changeRate:SetShow(true)
    if nil ~= self._skillRateListScrollIndex and nil ~= self._skillRateListScrollPos then
      self._ui._list2_ServantSkill:setCurrenttoIndex(self._skillRateListScrollIndex)
      self._ui._list2_ServantSkill:GetVScroll():SetControlPos(self._skillRateListScrollPos)
      self._skillRateListScrollPos = nil
      self._skillRateListScrollIndex = nil
    end
  end
end
function PaGlobal_ServantSkillManagement_All:updateWishskill(isWishSkill, isRefreshRate)
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  if nil == self._currentServantInfo then
    return
  end
  local servantInfo = self._currentServantInfo
  if nil == servantInfo then
    return
  end
  if true == isWishSkill then
    local skillWrapper = servantInfo:getSkillXXX(self._currentWishSkillIdx)
    if nil == skillWrapper then
      return
    end
    self._ui._stc_WishSkill_SkillIcon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
    if false == self._isConsole then
      self._ui._stc_WishSkill_SkillIcon:addInputEvent("Mouse_On", "HandleEventLOn_ServantSkillManagement_All_SkillChangeButton_Servant_Tooltip_Open(" .. self._currentWishSkillIdx .. ", " .. 1 .. ")")
      self._ui._stc_WishSkill_SkillIcon:addInputEvent("Mouse_Out", "HandleEventOut_ServantSkillManagement_All_SkillTooltipClose()")
    end
    local isStallionSkill = servantInfo:isStallionSkill(skillWrapper:getKey())
    self._ui._stc_WishSkill_SkillStallionIcon:SetShow(isStallionSkill)
    local skillNameSpanSizeX = self._wishSkillNameBaseSpanSizeX
    if true == isStallionSkill then
      local gabX = 5
      skillNameSpanSizeX = skillNameSpanSizeX + self._ui._stc_WishSkill_SkillStallionIcon:GetSizeX() - gabX
      if false == self._isConsole then
        self._ui._stc_WishSkill_SkillStallionIcon:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSkillManagement_All_ShowStallionToolTipByLearnedSkillList(true," .. self._eStallionTooltipType.wishSkill .. ")")
        self._ui._stc_WishSkill_SkillStallionIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSkillManagement_All_ShowStallionToolTipByLearnedSkillList(false)")
      end
    end
    self._ui._stc_WishSkill_SkillName:SetSpanSize(skillNameSpanSizeX, self._ui._stc_WishSkill_SkillName:GetSpanSize().y)
    self._ui._stc_WishSkill_SkillName:SetText(skillWrapper:getName())
    self._ui._stc_WishSkill_SkillCommand:SetText(skillWrapper:getDescription())
    self._ui._stc_WishSkill_SkillIcon:SetShow(true)
    self._ui._stc_WishSkill_SkillName:SetShow(true)
    self._ui._stc_WishSkill_SkillCommand:SetShow(true)
    self._ui._stc_PlusIcon:SetShow(false)
  else
    local skillWrapper = servantInfo:getSkill(self._currentChangeSkillIdx)
    if nil == skillWrapper then
      return
    end
    local expPercentTxt = servantInfo:getSkillExp(self._currentChangeSkillIdx) / (skillWrapper:getMaxExp() / 100)
    if expPercentTxt >= 100 then
      expPercentTxt = 100
    end
    self._ui._stc_Delete_SkillIcon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
    if false == self._isConsole then
      self._ui._stc_Delete_SkillIcon:addInputEvent("Mouse_On", "HandleEventLOn_ServantSkillManagement_All_SkillChangeButton_Servant_Tooltip_Open(" .. self._currentChangeSkillIdx .. ", " .. 0 .. ")")
      self._ui._stc_Delete_SkillIcon:addInputEvent("Mouse_Out", "HandleEventOut_ServantSkillManagement_All_SkillTooltipClose()")
    end
    self._ui._stc_Delete_SkillExpPercent:SetText(tonumber(string.format("%.0f", expPercentTxt)) .. "%")
    self._ui._stc_Delete_CircularProg2_SkillExp:SetProgressRate(expPercentTxt)
    local isStallionSkill = servantInfo:isStallionSkill(skillWrapper:getKey())
    self._ui._stc_Delete_SkillStallionIcon:SetShow(isStallionSkill)
    local skillNameSpanSizeX = self._deleteSkillNameBaseSpanSizeX
    if true == isStallionSkill then
      local gabX = 5
      skillNameSpanSizeX = skillNameSpanSizeX + self._ui._stc_Delete_SkillStallionIcon:GetSizeX() - gabX
      if false == self._isConsole then
        self._ui._stc_Delete_SkillStallionIcon:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSkillManagement_All_ShowStallionToolTipByLearnedSkillList(true," .. self._eStallionTooltipType.deleteSkill .. ")")
        self._ui._stc_Delete_SkillStallionIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSkillManagement_All_ShowStallionToolTipByLearnedSkillList(false)")
      end
    end
    self._ui._stc_Delete_SkillName:SetSpanSize(skillNameSpanSizeX, self._ui._stc_Delete_SkillName:GetSpanSize().y)
    self._ui._stc_Delete_SkillName:SetText(skillWrapper:getName())
    self._ui._stc_Delete_SkillCommand:SetText(skillWrapper:getDescription())
    self._ui._stc_Delete_PlusIcon:SetShow(false)
    self._ui._stc_Delete_SkillExpBg:SetShow(true)
    self._ui._stc_Delete_SkillIcon:SetShow(true)
    self._ui._stc_Delete_SkillExpPercent:SetShow(true)
    self._ui._stc_Delete_CircularProg2_SkillExp:SetShow(true)
    self._ui._stc_Delete_SkillName:SetShow(true)
    self._ui._stc_Delete_SkillCommand:SetShow(true)
  end
  self._isShowSkillChangeRate = false
  if true == _ContentsGroup_ServantSkillChangeRate then
    local wishSkillIdx = PaGlobal_ServantSkillManagement_All._currentWishSkillIdx
    local changingSkillIdx = PaGlobal_ServantSkillManagement_All._currentChangeSkillIdx
    if nil ~= wishSkillIdx and nil ~= changingSkillIdx then
      local wishSkillWrapper = servantInfo:getSkillXXX(wishSkillIdx)
      if nil == wishSkillWrapper then
        return
      end
      local changeSkillWrapper = servantInfo:getSkill(changingSkillIdx)
      if nil == changeSkillWrapper then
        return
      end
      local currentServantNo = self._currentServantNo
      local isRateCaculated = ToClient_isCalculatedServantSkillRate(currentServantNo, changingSkillIdx, wishSkillIdx, false)
      if true == isRateCaculated then
        self._ui._btn_SkillRateQuestion:SetShow(false == self._isConsole)
        self._ui._stc_KeyGuide_X:SetShow(true == self._isConsole)
        if true == self._isConsole then
          Panel_Dialog_ServantSkillManagement_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_ServantSkillManagement_All_RateDescOpen()")
          PaGlobal_ServantSkillManagement_All:alignKeyGuide()
        end
        self._isShowSkillChangeRate = true
        self._ui._stc_SkillRateDesc:SetShow(true)
        self._ui._stc_SkillListBg:SetShow(true)
        self._ui._stc_SkillListBg:SetSize(self._ui._stc_SkillListBg:GetSizeX(), self._ori_SkillListSizeY + (self._ui._stc_SkillRateDesc:GetSizeY() - self._ori_SkillRateDescY) + 5)
        self._ui._list2_ServantSkill:SetSize(self._ui._list2_ServantSkill:GetSizeX(), self._ori_List2SizeY)
        self._ui._txt_SkillListTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_SELECTSKILL_RATE"))
        if true == isRefreshRate then
          self._ui._list2_ServantSkill:requestUpdateVisible()
        else
          self._ui._list2_ServantSkill:getElementManager():clearKey()
          local totalCount = ToClient_getServantSkillChangeRateCount(currentServantNo, changingSkillIdx, wishSkillIdx, false)
          for skillIdx = 0, totalCount - 1 do
            self._ui._list2_ServantSkill:getElementManager():pushKey(toInt64(0, skillIdx))
          end
        end
      end
    end
  end
end
function PaGlobal_ServantSkillManagement_All:Servant_Tooltip_Open(key32)
  if nil == Panel_Dialog_ServantSkillManagement_All then
    return
  end
  local content, skillIcon
  if PaGlobal_ServantSkillManagement_All._eType.learn == PaGlobal_ServantSkillManagement_All._tabType then
    content = PaGlobal_ServantSkillManagement_All._ui._list2_LearnSkill:GetContentByKey(toInt64(0, key32))
  elseif PaGlobal_ServantSkillManagement_All._eType.notLearn == PaGlobal_ServantSkillManagement_All._tabType then
    content = PaGlobal_ServantSkillManagement_All._ui._list2_ServantSkill:GetContentByKey(toInt64(0, key32))
  end
  skillIcon = UI.getChildControl(content, "Static_SkillIcon")
  self:openTooltip(skillIcon, key32, false)
end
function PaGlobal_ServantSkillManagement_All:SkillChangeButton_Servant_Tooltip_Open(key32, buttonIdx)
  if nil == Panel_Dialog_ServantSkillManagement_All then
    return
  end
  local skillIcon
  if 0 == buttonIdx then
    skillIcon = PaGlobal_ServantSkillManagement_All._ui._stc_Delete_SkillIcon
  else
    skillIcon = PaGlobal_ServantSkillManagement_All._ui._stc_WishSkill_SkillIcon
  end
  self:openTooltip(skillIcon, key32, false)
end
function PaGlobal_ServantSkillManagement_All:openTooltip(content, key32, isSlotIcon)
  local skillWrapper
  local servantInfo = PaGlobal_ServantSkillManagement_All._currentServantInfo
  if nil == servantInfo then
    return
  end
  if true == servantInfo:isUseableSkill(key32) then
    skillWrapper = servantInfo:getSkill(key32)
  else
    skillWrapper = servantInfo:getSkillXXX(key32)
  end
  if nil == skillWrapper then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Open then
      PaGlobal_Tooltip_Skill_Servant_All_Open(skillWrapper, content, isSlotIcon)
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Open then
    local isShowStallionSkillTooltip = false
    if true == self._isConsole then
      isShowStallionSkillTooltip = servantInfo:isStallionSkill(skillWrapper:getKey())
    end
    PaGlobal_Tooltip_Servant_Open(skillWrapper, content, isSlotIcon, isShowStallionSkillTooltip)
  end
end
function PaGlobal_ServantSkillManagement_All:dataClear()
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  self._isClickedWishSkill = false
  self._currentWishSkillIdx = nil
  self._currentChangeSkillIdx = nil
  self._ui._stc_WishSkill_SkillIcon:SetShow(false)
  self._ui._stc_WishSkill_SkillName:SetShow(false)
  self._ui._stc_WishSkill_SkillCommand:SetShow(false)
  self._ui._stc_WishSkill_SkillExpBg:SetShow(false)
  self._ui._stc_WishSkill_CircularProg2_Exp:SetShow(false)
  self._ui._stc_WishSkill_SkillExpPercent:SetShow(false)
  self._ui._stc_WishSkill_SkillStallionIcon:SetShow(false)
  self._ui._stc_PlusIcon:SetShow(true)
  self._ui._stc_Delete_SkillExpBg:SetShow(false)
  self._ui._stc_Delete_CircularProg2_SkillExp:SetShow(false)
  self._ui._stc_Delete_SkillIcon:SetShow(false)
  self._ui._stc_Delete_SkillExpPercent:SetShow(false)
  self._ui._stc_Delete_SkillName:SetShow(false)
  self._ui._stc_Delete_SkillCommand:SetShow(false)
  self._ui._stc_Delete_SkillExpPercent:SetShow(false)
  self._ui._stc_Delete_PlusIcon:SetShow(true)
  self._ui._stc_Delete_SkillStallionIcon:SetShow(false)
  self._ui._stc_SkillListBg:SetShow(false)
end
function PaGlobal_ServantSkillManagement_All:prepareClose()
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  self._skillRateListScrollPos = nil
  self._skillRateListScrollIndex = nil
  HandleEventOut_ServantSkillManagement_All_SkillTooltipClose()
  PaGlobal_ServantSkillManagement_All:dataClear()
  PaGlobal_ServantSkillManagement_All:close()
end
function PaGlobal_ServantSkillManagement_All:close()
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  Panel_Dialog_ServantSkillManagement_All:SetShow(false)
end
function PaGlobal_ServantSkillManagement_All:validate()
  if nil == Panel_Dialog_ServantSkillManagement_All then
    return
  end
  self._ui._stc_TitleBg:isValidate()
  self._ui._txt_TitleIcon:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._btn_Question:isValidate()
  self._ui._stc_TabGroup:isValidate()
  self._ui._rdo_LearnedSkill:isValidate()
  self._ui._rdo_WishSkill:isValidate()
  self._ui._stc_Line:isValidate()
  self._ui._stc_SelectedLine:isValidate()
  self._ui._stc_KeyGuides_LB:isValidate()
  self._ui._stc_KeyGuides_RB:isValidate()
  self._ui._stc_LearnSkillBg:isValidate()
  self._ui._list2_LearnSkill:isValidate()
  self._ui._list2_LearnSkill_Content:isValidate()
  self._ui._list2_LearnSkill_stc_SkillSlotBg:isValidate()
  self._ui._list2_LearnSkill_stc_SkillExpBg:isValidate()
  self._ui._list2_LearnSkill_circularProg2_SkillExp:isValidate()
  self._ui._list2_LearnSkill_stc_SkillIcon:isValidate()
  self._ui._list2_LearnSkill_txt_SkillExpPercent:isValidate()
  self._ui._list2_LearnSkill_txt_SkillName:isValidate()
  self._ui._list2_LearnSkill_txt_SkillCommand:isValidate()
  self._ui._list2_LearnSkill_btn_Train_PC:isValidate()
  self._ui._list2_LearnSkill_btn_Delete_PC:isValidate()
  self._ui._btn_TrainAll_PC:isValidate()
  self._ui._stc_Center_WishSKillBg:isValidate()
  self._ui._stc_Center_ContentBg:isValidate()
  self._ui._txt_Center_PercentTitle:isValidate()
  self._ui._txt_Center_PercentValue:isValidate()
  self._ui._txt_Center_DeleteSkillTitle:isValidate()
  self._ui._stc_Center_DeleteSkilBg:isValidate()
  self._ui._stc_Delete_PlusIcon:isValidate()
  self._ui._stc_Delete_SkillExpBg:isValidate()
  self._ui._stc_Delete_CircularProg2_SkillExp:isValidate()
  self._ui._stc_Delete_SkillIcon:isValidate()
  self._ui._stc_Delete_SkillExpPercent:isValidate()
  self._ui._stc_Delete_SkillName:isValidate()
  self._ui._stc_Delete_SkillCommand:isValidate()
  self._ui._stc_Delete_SkillStallionIcon:isValidate()
  self._ui._txt_WishSkillTitle:isValidate()
  self._ui._stc_WishSKillBg:isValidate()
  self._ui._stc_PlusIcon:isValidate()
  self._ui._stc_WishSkill_SkillExpBg:isValidate()
  self._ui._stc_WishSkill_CircularProg2_Exp:isValidate()
  self._ui._stc_WishSkill_SkillIcon:isValidate()
  self._ui._stc_WishSkill_SkillExpPercent:isValidate()
  self._ui._stc_WishSkill_SkillName:isValidate()
  self._ui._stc_WishSkill_SkillStallionIcon:isValidate()
  self._ui._stc_WishSkill_SkillCommand:isValidate()
  self._ui._stc_SkillRateDesc:isValidate()
  self._ui._txt_SkillRateDesc:isValidate()
  self._ui._stc_DescBg:isValidate()
  self._ui._txt_Desc:isValidate()
  self._ui._stc_SkillListBg:isValidate()
  self._ui._stc_SkillListTitle:isValidate()
  self._ui._txt_SkillListTitle:isValidate()
  self._ui._list2_ServantSkill:isValidate()
  self._ui._list2_ServantSkill_Content:isValidate()
  self._ui._list2_ServantSkill_SkillSlotBG:isValidate()
  self._ui._list2_ServantSkill_SkillExpBg:isValidate()
  self._ui._list2_ServantSkill_CircurlarProg2Exp:isValidate()
  self._ui._list2_ServantSkill_SkillIcon:isValidate()
  self._ui._list2_ServantSkill_SkillExpPercent:isValidate()
  self._ui._list2_ServantSkill_SkillName:isValidate()
  self._ui._list2_ServantSkill_SkillCommand:isValidate()
  self._ui._stc_BottomBg_Console:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._ui._stc_KeyGuide_Y:isValidate()
  self._ui._stc_KeyGuide_X:isValidate()
  self._ui_stc_KeyGuide_Scroll:isValidate()
  self._initailize = true
end
