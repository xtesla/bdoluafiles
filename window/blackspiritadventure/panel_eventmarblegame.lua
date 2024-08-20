local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local isEventMarbleGame = _ContentsGroup_EventMarbleGame
local isPopUpContentsEnable = ToClient_IsContentsGroupOpen("240")
PaGlobal_EventMarbleGame = {
  _Web = nil,
  _ui = {
    _stc_title = nil,
    _btn_Refresh = nil,
    _btn_Question = nil,
    _chk_popUp = nil
  },
  _webSizeX = 918,
  _webSizeY = 655
}
function EventMarbleGame_ShowAni()
  if nil == Panel_Window_EventMarbleGame then
    return
  end
  audioPostEvent_SystemUi(1, 0)
  audioPostEvent_SystemUi(11, 90)
  _AudioPostEvent_SystemUiForXBOX(1, 0)
  _AudioPostEvent_SystemUiForXBOX(11, 90)
  UIAni.fadeInSCR_Down(Panel_Window_EventMarbleGame)
  local aniInfo1 = Panel_Window_EventMarbleGame:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.2)
  aniInfo1.AxisX = Panel_Window_EventMarbleGame:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_EventMarbleGame:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_EventMarbleGame:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.2)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_EventMarbleGame:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_EventMarbleGame:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function EventMarbleGame_HideAni()
  if nil == Panel_Window_EventMarbleGame then
    return
  end
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_Window_EventMarbleGame:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_EventMarbleGame, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_EventMarbleGame:initialize()
  if nil == Panel_Window_EventMarbleGame then
    return
  end
  self._Web = UI.createControl(__ePAUIControl_WebControl, Panel_Window_EventMarbleGame, "WebControl_EventMarbleGame_WebLink")
  self._ui._stc_title = UI.getChildControl(Panel_Window_EventMarbleGame, "StaticText_TitleArea")
  self._ui._btn_Refresh = UI.getChildControl(self._ui._stc_title, "Button_Refresh")
  self._ui._btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  self._ui._btn_Close = UI.getChildControl(self._ui._stc_title, "Button_Win_Close")
  self._ui._btn_Close:SetShow(true)
  self._ui._btn_Question = UI.getChildControl(self._ui._stc_title, "Button_Question")
  self._ui._btn_Question:SetShow(false)
  self._ui._chk_popUp = UI.getChildControl(self._ui._stc_title, "CheckButton_PopUp")
  self._ui._chk_popUp:SetShow(isPopUpContentsEnable)
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btn_Close:SetShow(false)
    self._webSizeY = self._webSizeY + 50
    Panel_Window_EventMarbleGame:SetSize(Panel_Window_EventMarbleGame:GetSizeX(), Panel_Window_EventMarbleGame:GetSizeY() + 50)
    Panel_Window_EventMarbleGame:ComputePos()
  end
  self._Web:SetShow(true)
  self._Web:SetSize(self._webSizeX, self._webSizeY)
  self._Web:SetHorizonCenter()
  self._Web:SetVerticalTop()
  self._Web:SetSpanSize(0, 60)
  self._Web:ComputePos()
  self._Web:ResetUrl()
  self:registerEventHandler()
end
function PaGlobal_EventMarbleGame:registerEventHandler()
  if nil == Panel_Window_EventMarbleGame then
    return
  end
  Panel_Window_EventMarbleGame:SetShow(false)
  Panel_Window_EventMarbleGame:setMaskingChild(true)
  Panel_Window_EventMarbleGame:setGlassBackground(true)
  Panel_Window_EventMarbleGame:SetDragAll(true)
  Panel_Window_EventMarbleGame:RegisterShowEventFunc(true, "EventMarbleGame_ShowAni()")
  Panel_Window_EventMarbleGame:RegisterShowEventFunc(false, "EventMarbleGame_HideAni()")
  Panel_Window_EventMarbleGame:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "Input_EventMarbleGame_ToWebBanner(\"LB\")")
  Panel_Window_EventMarbleGame:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "Input_EventMarbleGame_ToWebBanner(\"RB\")")
  Panel_Window_EventMarbleGame:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "Input_EventMarbleGame_ToWebBanner(\"D_UP\")")
  Panel_Window_EventMarbleGame:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "Input_EventMarbleGame_ToWebBanner(\"D_DOWN\")")
  Panel_Window_EventMarbleGame:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "Input_EventMarbleGame_ToWebBanner(\"D_LEFT\")")
  Panel_Window_EventMarbleGame:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "Input_EventMarbleGame_ToWebBanner(\"D_RIGHT\")")
  Panel_Window_EventMarbleGame:registerPadEvent(__eConsoleUIPadEvent_Up_A, "Input_EventMarbleGame_ToWebBanner(\"A\")")
  Panel_Window_EventMarbleGame:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "Input_EventMarbleGame_ToWebBanner(\"Y\")")
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_Refresh)
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "EventMarbleGameAd_Hide()")
  self._ui._chk_popUp:addInputEvent("Mouse_LUp", "HandleClicked_EventMarbleGame_PopUp()")
  self._ui._chk_popUp:addInputEvent("Mouse_On", "EventMarbleGame_PopUp_ShowIconToolTip( true )")
  self._ui._chk_popUp:addInputEvent("Mouse_Out", "EventMarbleGame_PopUp_ShowIconToolTip( false )")
end
function PaGlobal_EventMarbleGame:show(cooltimeOff)
  if nil == Panel_Window_EventMarbleGame then
    return
  end
  if isEventMarbleGame then
    Panel_Window_EventMarbleGame:SetShow(true, true)
    Panel_Window_EventMarbleGame:SetPosX(getScreenSizeX() / 2 - Panel_Window_EventMarbleGame:GetSizeX() / 2)
    Panel_Window_EventMarbleGame:SetPosY(getScreenSizeY() / 2 - Panel_Window_EventMarbleGame:GetSizeY() / 2)
  else
    return
  end
  local myUserNo = getSelfPlayer():get():getUserNo()
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local bAdventureWebUrl = PaGlobal_URL_Check(worldNo)
  if nil ~= bAdventureWebUrl then
    local url = bAdventureWebUrl .. "/MarbleGame/EventStart?userNo=" .. tostring(myUserNo) .. "&certKey=" .. tostring(cryptKey)
    self._Web:SetUrl(self._webSizeX, self._webSizeY, url)
  end
end
function EventMarbleGameAd_Hide()
  if nil == Panel_Window_EventMarbleGame then
    return
  end
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_Window_EventMarbleGame:SetShow(false, false)
  Panel_Window_EventMarbleGame:CloseUISubApp()
  PaGlobal_EventMarbleGame._ui._chk_popUp:SetCheck(false)
  PaGlobal_EventMarbleGame._Web:ResetUrl()
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  end
end
function FGlobal_EventMarbleGame_Open()
  PaGlobal_EventMarbleGame:show(false)
end
function EventMarbleGame_PopUp_ShowIconToolTip(isShow)
  if isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if PaGlobal_EventMarbleGame._ui._chk_popUp:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(PaGlobal_EventMarbleGame._ui._chk_popUp, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleClicked_EventMarbleGame_PopUp()
  if nil == Panel_Window_EventMarbleGame then
    return
  end
  if PaGlobal_EventMarbleGame._ui._chk_popUp:IsCheck() then
    Panel_Window_EventMarbleGame:OpenUISubApp()
  else
    Panel_Window_EventMarbleGame:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function FromClient_resetCoherentUIForEventMarbleGame()
  if nil ~= Panel_Window_EventMarbleGame and false == Panel_Window_EventMarbleGame:GetShow() then
    return
  end
  TooltipSimple_Hide()
  EventMarbleGameAd_Hide()
end
function FromClient_EventMarbleGame_Initialize()
  PaGlobal_EventMarbleGame:initialize()
end
function Input_EventMarbleGame_ToWebBanner(key)
  _PA_LOG("\237\151\136\236\158\172\236\132\157", "key : " .. tostring(key))
  PaGlobal_EventMarbleGame._Web:TriggerEvent("FromClient_GamePadInputForWebBanner", key)
end
registerEvent("FromClient_luaLoadComplete", "FromClient_EventMarbleGame_Initialize")
registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForEventMarbleGame")
