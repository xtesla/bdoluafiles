local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local preUIMode = Defines.UIMode.eUIMode_InGameCashShop
Panel_TermsofGameUse:SetShow(false, false)
Panel_TermsofGameUse:ActiveMouseEventEffect(true)
Panel_TermsofGameUse:setGlassBackground(true)
Panel_TermsofGameUse:RegisterShowEventFunc(true, "Panel_TermsofGameUse_ShowAni()")
Panel_TermsofGameUse:RegisterShowEventFunc(false, "Panel_TermsofGameUse_HideAni()")
function Panel_TermsofGameUse_ShowAni()
  UIAni.fadeInSCR_Down(Panel_TermsofGameUse)
  local aniInfo1 = Panel_TermsofGameUse:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_TermsofGameUse:GetSizeX() / 2
  aniInfo1.AxisY = Panel_TermsofGameUse:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_TermsofGameUse:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_TermsofGameUse:GetSizeX() / 2
  aniInfo2.AxisY = Panel_TermsofGameUse:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function Panel_TermsofGameUse_HideAni()
  Panel_TermsofGameUse:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_TermsofGameUse, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
local _stc_Title = UI.getChildControl(Panel_TermsofGameUse, "Static_TitleArea")
local _btn_Close = UI.getChildControl(_stc_Title, "Button_Close")
local _btn_Agree = UI.getChildControl(Panel_TermsofGameUse, "Button_Agree")
local _Web
local _stc_KeyGuideBg = UI.getChildControl(Panel_TermsofGameUse, "Static_KeyGuide")
local _stc_KeyGuideB = UI.getChildControl(_stc_KeyGuideBg, "StaticText_BButton")
local _stc_KeyGuideA = UI.getChildControl(_stc_KeyGuideBg, "StaticText_AButton")
function Panel_TermsofGameUse_Initialize()
  _Web = UI.createControl(__ePAUIControl_WebControl, Panel_TermsofGameUse, "WebControl_TermsofGameUse_WebLink")
  _Web:SetShow(true)
  _Web:SetSize(900, 586)
  _Web:SetHorizonCenter()
  _Web:SetVerticalTop()
  _Web:SetSpanSize(0, 60)
  _Web:ComputePos()
  _Web:ResetUrl()
end
Panel_TermsofGameUse_Initialize()
function FGlobal_TermsofGameUse_Open()
  local isTermsString = PAGetString(Defines.StringSheet_GAME, "LUA_TERMSOFGAMEUSE_URL_TW")
  if isGameTypeKorea() then
    if CppEnums.CountryType.KOR_ALPHA == getGameServiceType() then
      isTermsString = PAGetString(Defines.StringSheet_GAME, "LUA_TERMSOFGAMEUSE_DEV_URL")
    elseif CppEnums.CountryType.KOR_REAL == getGameServiceType() then
      isTermsString = PAGetString(Defines.StringSheet_GAME, "LUA_TERMSOFGAMEUSE_URL")
    end
  elseif isGameTypeTaiwan() then
    if CppEnums.CountryType.TW_ALPHA == getGameServiceType() then
      isTermsString = PAGetString(Defines.StringSheet_GAME, "LUA_TERMSOFGAMEUSE_URL_TW_ALPHA")
    elseif CppEnums.CountryType.TW_REAL == getGameServiceType() then
      isTermsString = PAGetString(Defines.StringSheet_GAME, "LUA_TERMSOFGAMEUSE_URL_TW")
    end
  elseif isGameTypeGT() then
    isTermsString = "https://game-portal.global-lab.playblackdesert.com/Policy/"
  elseif CppEnums.CountryType.RUS_ALPHA == getGameServiceType() then
    isTermsString = PAGetString(Defines.StringSheet_GAME, "LUA_TERMSOFGAMEUSE_URL_RUS_ALPHA")
  elseif CppEnums.CountryType.RUS_REAL == getGameServiceType() then
    isTermsString = PAGetString(Defines.StringSheet_GAME, "LUA_TERMSOFGAMEUSE_URL_RUS")
  elseif CppEnums.CountryType.JPN_ALPHA == getGameServiceType() then
    isTermsString = PAGetString(Defines.StringSheet_GAME, "LUA_TERMSOFGAMEUSE_URL_JP_ALPHA")
  elseif CppEnums.CountryType.JPN_REAL == getGameServiceType() then
    isTermsString = PAGetString(Defines.StringSheet_GAME, "LUA_TERMSOFGAMEUSE_URL_JP")
  else
    isTermsString = PAGetString(Defines.StringSheet_GAME, "LUA_TERMSOFGAMEUSE_URL")
  end
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
  Panel_TermsofGameUse:SetShow(true, true)
  FGlobal_TermsofGameUse_CheckAndSwitchPadUI()
  _Web:SetUrl(900, 586, isTermsString, false, false)
end
function TermsofGameUse_Close()
  _Web:ResetUrl()
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  Panel_TermsofGameUse:SetShow(false, false)
end
function HandleClicked_TermsofGameUse_Close()
  TermsofGameUse_Close()
end
function HandleClicked_TermsofGameUse_Next()
  TermsofGameUse_Close()
  if true == _ContentsGroup_NewUI_Login_All then
    PaGlobal_Login_All_LoginEnter()
  else
    FGlobal_Panel_Login_Enter()
  end
end
function FGlobal_HandleClicked_TermsofGameUse_Next()
  HandleClicked_TermsofGameUse_Next()
end
function FGlobal_TermsofGameUse_Close()
  TermsofGameUse_Close()
end
function FGlobal_TermsofGameUse_CheckAndSwitchPadUI()
  if nil == Panel_TermsofGameUse then
    return
  end
  if false == Panel_TermsofGameUse:GetShow() then
    return
  end
  local consoleKeyGuides = {_stc_KeyGuideB, _stc_KeyGuideA}
  if false == ToClient_isUsePadSnapping() then
    _btn_Agree:SetShow(true)
    _stc_KeyGuideBg:SetShow(false)
    _stc_KeyGuideB:SetShow(false)
    _stc_KeyGuideA:SetShow(false)
  else
    if false == ToClient_isConsole() and false == ToClient_IsPadContollerForPC() then
      _btn_Agree:SetShow(true)
      _stc_KeyGuideBg:SetShow(false)
      _stc_KeyGuideB:SetShow(false)
      _stc_KeyGuideA:SetShow(false)
      return
    end
    _btn_Agree:SetShow(false)
    _stc_KeyGuideBg:SetShow(true)
    _stc_KeyGuideB:SetShow(true)
    _stc_KeyGuideA:SetShow(true)
    Panel_TermsofGameUse:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleClicked_TermsofGameUse_Next()")
    Panel_TermsofGameUse:registerPadEvent(__eConsoleUIPadEvent_Up_B, "TermsofGameUse_Close()")
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(consoleKeyGuides, _stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
_btn_Close:addInputEvent("Mouse_LUp", "HandleClicked_TermsofGameUse_Close()")
_btn_Agree:addInputEvent("Mouse_LUp", "HandleClicked_TermsofGameUse_Next()")
