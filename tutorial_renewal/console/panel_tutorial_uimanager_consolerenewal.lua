registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_TutorialUiManager")
registerEvent("onScreenResize", "FromClient_TutorialScreenReposition")
registerEvent("EventSelfPlayerLevelUp", "FromClient_EventSelfPlayerLevelUp_TutorialUiManager")
PaGlobal_TutorialUiManager = {
  _uiList = {
    _uiBlackSpirit = nil,
    _uiHeadlineMessage = nil,
    _uiMasking = nil,
    _uiSmallSpirit = nil,
    _uiGuideButton = nil
  }
}
function PaGlobal_TutorialUiManager:initialize()
  self._uiList._uiBlackSpirit = PaGlobal_TutorialUiBlackSpirit
  self._uiList._uiBlackSpirit:initialize()
  self._uiList._uiHeadlineMessage = PaGlobal_TutorialUiHeadlineMessage
  self._uiList._uiHeadlineMessage:initialize()
  self._uiList._uiMasking = PaGlobal_TutorialUiMasking
  self._uiList._uiSmallSpirit = PaGlobal_TutorialUiSmallBlackSpirit
  self._uiList._uiGuideButton = PaGlobal_TutorialUiGuideButton
  Panel_Tutorial_Renew:RegisterShowEventFunc(true, "PaGlobalFunc_Tutorial_ShowAni()")
  Panel_Tutorial_Renew:RegisterShowEventFunc(false, "PaGlobalFunc_Tutorial_HideAni()")
  PaGlobal_TutorialManager:handleTutorialUiManagerInitialize()
end
function PaGlobalFunc_Tutorial_ShowAni()
  PaGlobal_TutorialUiManager:showAni()
end
function PaGlobalFunc_Tutorial_HideAni()
  PaGlobal_TutorialUiManager:hideAni()
end
function PaGlobal_TutorialUiManager:showAni()
  Panel_Tutorial_Renew:ResetVertexAni()
  Panel_Tutorial_Renew:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  local aniInfo = Panel_Tutorial_Renew:addColorAnimation(0, 0.75, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
end
function PaGlobal_TutorialUiManager:hideAni()
  Panel_Tutorial_Renew:ResetVertexAni()
  Panel_Tutorial_Renew:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo = Panel_Tutorial_Renew:addColorAnimation(0, 1.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo.IsChangeChild = true
  aniInfo:SetHideAtEnd(true)
  aniInfo:SetDisableWhileAni(true)
end
function PaGlobal_TutorialUiManager:loadAllUiSavedInfo()
  self:setShowAllDefaultUi(true)
  self:setUiSavedInfo()
end
function FromClient_TutorialScreenReposition()
  PaGlobal_TutorialUiManager:repositionScreen()
end
function PaGlobal_TutorialUiManager:repositionScreen()
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  Panel_Tutorial_Renew:SetSize(scrX, scrY)
  UI.getChildControl(Panel_Tutorial_Renew, "Static_BottomBg"):SetSize(scrX, 204 * (scrY / 1080))
  Panel_Tutorial_Renew:SetPosX(0)
  Panel_Tutorial_Renew:SetPosY(0)
  for key, value in pairs(self._uiList) do
    for _, vv in pairs(value._ui) do
      vv:ComputePos()
    end
  end
end
function PaGlobal_TutorialUiManager:closeAllWindow()
  if check_ShowWindow() then
    close_WindowPanelList()
  elseif false == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_MainDialog_Hide()
  else
    PaGlobalFunc_DialogMain_All_Close()
  end
end
function PaGlobal_TutorialUiManager:restoreAllUiByUserSetting()
  local isTutorialSkip = 1 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eTutorialSkip)
  if CheckTutorialEnd() or isTutorialSkip then
    self:loadAllUiSavedInfo()
  end
  self:setShowAllDefaultUi(true)
end
function PaGlobal_TutorialUiManager:setUiSavedInfo()
  local uiPanelInfo = {
    [Panel_MainStatus_Remaster] = CppEnums.PAGameUIType.PAGameUIPanel_MainStatusRemaster,
    [Panel_PersonalIcon_Left] = CppEnums.PAGameUIType.PAGameUIPanel_LeftIcon,
    [Panel_Window_Servant] = CppEnums.PAGameUIType.PAGameUIPanel_ConsoleServantIcon,
    [Panel_TimeBar] = CppEnums.PAGameUIType.PAGameUIPanel_TimeBar,
    [Panel_Radar] = CppEnums.PAGameUIType.PAGameUIPanel_RadarMap,
    [Panel_MainQuest] = CppEnums.PAGameUIType.PAGameUIPanel_MainQuest,
    [Panel_Widget_ChattingViewer_Renew] = CppEnums.PAGameUIType.PAGameUIPanel_ConsoleChattingViewer,
    [Panel_SkillCooltime] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTime,
    [Panel_AppliedBuffList] = CppEnums.PAGameUIType.PAGameUIPanel_AppliedBuffList,
    [Panel_Widget_QuickMenu] = CppEnums.PAGameUIType.PAGameUIPanel_ConsoleQuickMenu,
    [Panel_WhereUseItemDirection] = CppEnums.PAGameUIType.PAGameUIPanel_ConsoleItemCountingWidget,
    [Panel_SkillCommand] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand
  }
  for control, value in pairs(uiPanelInfo) do
    local showValue = ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow)
    if -1 ~= showValue then
      if nil == control then
        UI.ASSERT_NAME(false, "tutorialManager. ui\237\142\184\236\167\145 \236\132\184\237\140\133\237\149\160 panel\236\157\180 nil\236\158\133\235\139\136\235\139\164.", "\236\154\176\236\160\149\235\172\180")
        return
      end
      local isShow = true
      if 0 == showValue then
        isShow = false
      end
      control:SetShow(isShow)
      if CppEnums.PAGameUIType.Panel_MainQuest == value then
        Panel_LatestQuest:SetShow(isShow)
      elseif CppEnums.PAGameUIType.PAGameUIPanel_MainStatusRemaster == value or CppEnums.PAGameUIType.PAGameUIPanel_LeftIcon == value then
        PackageIconPosition()
      elseif CppEnums.PAGameUIType.PAGameUIPanel_ConsoleServantIcon == value then
        PaGlobalFunc_TopIcon_ShowAll(isShow)
      end
      if 0 < ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved) then
        local relativePosX = ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
        local relativePosY = ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
        control:SetRelativePosX(relativePosX)
        control:SetRelativePosY(relativePosY)
      end
    end
  end
end
function PaGlobal_TutorialUiManager:setShowAllDefaultUi(isShow)
  if false == isShow then
  elseif true == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_ConsoleKeyGuide_On()
    PaGlobalFunc_ChattingViewer_On()
    PaGlobal_ConsoleQuickMenu:widgetOpen(true)
    PaGlobal_ConsoleQuickMenu:setWidget()
  end
end
function PaGlobal_TutorialUiManager:hideAllTutorialUi()
  for _, v in pairs(self._uiList) do
    for __, control in pairs(v._ui) do
      control:SetShow(false)
    end
  end
end
function FromClient_luaLoadComplete_TutorialUiManager()
  PaGlobal_TutorialUiManager:initialize()
end
function FromClient_EventSelfPlayerLevelUp_TutorialUiManager()
  if CheckTutorialEnd() then
    PaGlobal_TutorialUiManager:restoreAllUiByUserSetting()
  end
end
function PaGlobal_TutorialUiManager:getUiBlackSpirit()
  return self._uiList._uiBlackSpirit
end
function PaGlobal_TutorialUiManager:getUiHeadlineMessage()
  return self._uiList._uiHeadlineMessage
end
function PaGlobal_TutorialUiManager:getUiMasking()
  return self._uiList._uiMasking
end
function PaGlobal_TutorialUiManager:getUiSmallBlackSpirit()
  return self._uiList._uiSmallSpirit
end
function PaGlobal_TutorialUiManager:getUiGuideButton()
  return self._uiList._uiGuideButton
end
