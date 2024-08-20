local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
Panel_ProductNote:SetShow(false, false)
Panel_ProductNote:ActiveMouseEventEffect(true)
Panel_ProductNote:setGlassBackground(true)
Panel_ProductNote:RegisterShowEventFunc(true, "Panel_ProductNote_ShowAni()")
Panel_ProductNote:RegisterShowEventFunc(false, "Panel_ProductNote_HideAni()")
Panel_ProductNote:ignorePadSnapMoveToOtherPanel()
function Panel_ProductNote_ShowAni()
  UIAni.fadeInSCR_Down(Panel_ProductNote)
  local aniInfo1 = Panel_ProductNote:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_ProductNote:GetSizeX() / 2
  aniInfo1.AxisY = Panel_ProductNote:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_ProductNote:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_ProductNote:GetSizeX() / 2
  aniInfo2.AxisY = Panel_ProductNote:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function Panel_ProductNote_HideAni()
  Panel_ProductNote:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_ProductNote, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
local _titleBar = UI.getChildControl(Panel_ProductNote, "StaticText_TitleBg")
local _static_KeyguideBG = UI.getChildControl(Panel_ProductNote, "Static_KeyguideBG")
local _productWeb, sizeX, sizeY, panelSizeX, panelSizeY, urlSizeX, urlSizeY
function PaGlobal_ProductNote_Resize()
  sizeX = panelSizeX - 30
  sizeY = panelSizeY - 30 - _titleBar:GetSizeY()
  urlSizeX = sizeX
  urlSizeY = sizeY
  local startPosX = 15
  local startPosY = 90
  Panel_ProductNote:SetSize(panelSizeX, panelSizeY)
  _productWeb:SetShow(true)
  _productWeb:SetPosX(startPosX)
  _productWeb:SetPosY(startPosY)
  _productWeb:SetSize(sizeX, sizeY)
  _productWeb:ComputePos()
  local keyGuideText = UI.getChildControl(_static_KeyguideBG, "StaticText_B_ConsoleUI")
  if 80 < keyGuideText:GetTextSizeX() then
    _static_KeyguideBG:SetSpanSize(-keyGuideText:GetTextSizeX(), 5)
  end
end
function Panel_ProductNote_Initialize()
  _productWeb = UI.createControl(__ePAUIControl_WebControl, Panel_ProductNote, "WebControl_ProductNote")
  panelSizeX = Panel_ProductNote:GetSizeX()
  panelSizeY = Panel_ProductNote:GetSizeY()
  PaGlobal_ProductNote_Resize()
  _productWeb:ResetUrl()
  Panel_ProductNote:registerPadEvent(__eConsoleUIPadEvent_LB, "Input_ProductNote_ToWebBanner(\"LB\")")
  Panel_ProductNote:registerPadEvent(__eConsoleUIPadEvent_RB, "Input_ProductNote_ToWebBanner(\"RB\")")
  Panel_ProductNote:registerPadEvent(__eConsoleUIPadEvent_A, "Input_ProductNote_ToWebBanner(\"A\")")
  Panel_ProductNote:registerPadEvent(__eConsoleUIPadEvent_Y, "Input_ProductNote_ToWebBanner(\"Y\")")
  Panel_ProductNote:registerPadEvent(__eConsoleUIPadEvent_X, "PaGlobalFunc_ProductNote_Search_Open()")
  Panel_ProductNote:registerPadEvent(__eConsoleUIPadEvent_LT, "Input_ProductNote_ToWebBanner(\"LT\")")
  Panel_ProductNote:registerPadEvent(__eConsoleUIPadEvent_RT, "Input_ProductNote_ToWebBanner(\"RT\")")
  Panel_ProductNote:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "Input_ProductNote_ToWebBanner(\"D_LEFT\")")
  Panel_ProductNote:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "Input_ProductNote_ToWebBanner(\"D_RIGHT\")")
  Panel_ProductNote:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "Input_ProductNote_ToWebBanner(\"D_UP\")")
  Panel_ProductNote:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "Input_ProductNote_ToWebBanner(\"D_DOWN\")")
  Panel_ProductNote:registerPadEvent(__eConsoleUIPadEvent_LSClick, "Input_ProductNote_ToWebBanner(\"LS_CLICK\")")
  Panel_ProductNote:registerPadEvent(__eConsoleUIPadEvent_RSClick, "Input_ProductNote_ToWebBanner(\"RS_CLICK\")")
end
Panel_ProductNote_Initialize()
function Panel_ProductNote_ShowToggle()
  if false == _ContentsGroup_RenewUI_ProductNote then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_NOTUSE"))
    return
  end
  local isShow = Panel_ProductNote:IsShow()
  if ToClient_IsConferenceMode() then
    return
  end
  if isShow == true then
    FGlobal_ClearCandidate()
    _productWeb:ResetUrl()
    audioPostEvent_SystemUi(13, 5)
    _AudioPostEvent_SystemUiForXBOX(13, 5)
    Panel_ProductNote:SetShow(false, false)
    ClearFocusEdit()
    return false
  else
    audioPostEvent_SystemUi(13, 6)
    _AudioPostEvent_SystemUiForXBOX(13, 6)
    Panel_ProductNote:SetShow(true, true)
    FGlobal_SetCandidate()
    local url = ""
    if true == _ContentsGroup_ConsoleIntegration then
      local platform = "XB"
      if __ePlatformType_PS == ToClient_getGamePlatformType() then
        platform = "PS"
      end
      url = "coui://UI_Data/UI_Html/Window/ProductNote/ProductNote_CategoryItemList.html?" .. "platform=" .. platform
    else
      url = "coui://UI_Data/UI_Html/Window/ProductNote/ProductNote_CategoryItemList.html?nodeProduct"
    end
    _productWeb:SetUrl(sizeX, sizeY, url)
    _productWeb:SetIME(true)
    return true
  end
  return true
end
function Panel_ProductNoteClose()
end
function ProductNote_Item_ShowToggle(itemKey)
  if false == _ContentsGroup_RenewUI_ProductNote then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_NOTUSE"))
    return
  end
  if ToClient_IsConferenceMode() then
    return
  end
  if isShow == true then
    FGlobal_ClearCandidate()
    _productWeb:ResetUrl()
    audioPostEvent_SystemUi(13, 5)
    _AudioPostEvent_SystemUiForXBOX(13, 5)
    Panel_ProductNote:SetShow(false, false)
    if false == CheckChattingInput() then
      ClearFocusEdit()
    end
    if Panel_ProductNote:IsUISubApp() then
      Panel_ProductNote:CloseUISubApp()
    end
  else
    audioPostEvent_SystemUi(13, 6)
    _AudioPostEvent_SystemUiForXBOX(13, 6)
    Panel_ProductNote:SetShow(true, true)
    FGlobal_SetCandidate()
    local url = ""
    if true == _ContentsGroup_ConsoleIntegration then
      local platform = "XB"
      if __ePlatformType_PS == ToClient_getGamePlatformType() then
        platform = "PS"
      end
      url = "coui://UI_Data/UI_Html/Window/ProductNote/ProductNote_CategoryItemList.html?manufacture&" .. "platform=" .. platform .. "&" .. itemKey
    else
      url = "coui://UI_Data/UI_Html/Window/ProductNote/ProductNote_CategoryItemList.html?manufacture&" .. itemKey
    end
    _productWeb:SetUrl(sizeX, sizeY, url)
    _productWeb:SetIME(true)
  end
end
function Input_ProductNote_ToWebBanner(key)
  _productWeb:TriggerEvent("FromClient_GamePadInputForWebBanner", key)
end
function Panel_ProductNote_SearchEvent(keyword)
  if nil ~= _productWeb and nil ~= keyword then
    _productWeb:TriggerEvent("FromClient_ProductNote_Search", keyword)
  end
end
registerEvent("onScreenResize", "PaGlobal_ProductNote_Resize")
