function PaGlobal_Composition_All:initialize()
  if true == PaGlobal_Composition_All._initialize then
    return
  end
  Panel_Window_Composition_All:SetShow(false)
  Panel_Window_Composition_All:setGlassBackground(true)
  Panel_Window_Composition_All:ActiveMouseEventEffect(false)
  self._ui._txt_titleBar = UI.getChildControl(Panel_Window_Composition_All, "StaticText_Title")
  self._ui._stc_decoration = UI.getChildControl(self._ui._txt_titleBar, "Static_TitleDeco")
  self._ui._btn_close = UI.getChildControl(self._ui._txt_titleBar, "Button_Close")
  self._ui._btn_refresh = UI.getChildControl(self._ui._txt_titleBar, "Button_Refresh")
  self._ui._btn_small = UI.getChildControl(self._ui._txt_titleBar, "Button_Small")
  self._ui._btn_big = UI.getChildControl(self._ui._txt_titleBar, "Button_Big")
  self._ui._webControl = UI.createControl(__ePAUIControl_WebControl, Panel_Window_Composition_All, "WebControl_Composition_WebLink")
  self._ui._webControl:SetShow(true)
  self._ui._webControl:SetPosX(self._web_basicPos.x)
  self._ui._webControl:SetPosY(self._web_basicPos.y)
  self._ui._webControl:ResetUrl()
  self._ui._btn_refresh:SetShow(_ContentsGroup_ResetCoherent)
  self._web_size[self._eScreenMode.eScreenModeWindow] = {x = 1642, y = 842}
  self._ui._webControl:SetSize(self._web_size[self._eScreenMode.eScreenModeWindow].x, self._web_size[self._eScreenMode.eScreenModeWindow].y)
  self._fullScreenMode = self._eScreenMode.eScreenModeWindow
  self._panel_size[self._eScreenMode.eScreenModeWindow] = {x = 1664, y = 915}
  if false == _ContentsGroup_MusicAlbumFullScreenMode then
    self._ui._btn_refresh:SetSpanSize(self._ui._btn_big:GetSpanSize().x, self._ui._btn_refresh:GetSpanSize().y)
  end
  PaGlobal_Composition_All:registEventHandler()
  PaGlobal_Composition_All:validate()
  PaGlobal_Composition_All._initialize = true
end
function PaGlobal_Composition_All:registEventHandler()
  if nil == Panel_Window_Composition_All then
    return
  end
  registerEvent("FromClient_OpenMusicListLocalRepository", "FromClient_OpenMusicListLocalRepository")
  registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForComposition")
  Panel_Window_Composition_All:RegisterShowEventFunc(true, "PaGlobal_Composition_All_ShowAni()")
  Panel_Window_Composition_All:RegisterShowEventFunc(false, "PaGlobal_Composition_All_HideAni()")
  Panel_Window_Composition_All:RegisterUpdateFunc("PaGlobal_Composition_All_UpdatePerFrame")
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_refresh)
  self._ui._btn_small:addInputEvent("Mouse_LUp", "PaGlobal_Composition_All_SetFullMode(false)")
  self._ui._btn_small:addInputEvent("Mouse_On", "PaGlobal_Composition_All_SmallToolTip_Show(true)")
  self._ui._btn_small:addInputEvent("Mouse_Out", "PaGlobal_Composition_All_SmallToolTip_Show(false)")
  self._ui._btn_big:addInputEvent("Mouse_LUp", "PaGlobal_Composition_All_SetFullMode(true)")
  self._ui._btn_big:addInputEvent("Mouse_On", "PaGlobal_Composition_All_BigToolTip_Show(true)")
  self._ui._btn_big:addInputEvent("Mouse_Out", "PaGlobal_Composition_All_BigToolTip_Show(false)")
  self._ui._webControl:addInputEvent("Mouse_LUp", "HandleEventLUp_Composition_All_WepControlClick()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Composition_All_Close()")
end
function PaGlobal_Composition_All:prepareOpen(musicIndex)
  if nil == Panel_Window_Composition_All then
    return
  end
  if not ToClient_IsPopUpToggle() then
    return
  end
  if isGameTypeKR2() then
    return
  end
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
  self._updateTempSaveTime = 0
  if true == _ContentsGroup_MusicAlbumFullScreenMode then
    if self._fullScreenMode == self._eScreenMode.eScreenModeWindow then
      self._ui._btn_big:SetShow(true)
      self._ui._btn_small:SetShow(false)
    else
      self._ui._btn_big:SetShow(false)
      self._ui._btn_small:SetShow(true)
    end
  else
    self._ui._btn_big:SetShow(false)
    self._ui._btn_small:SetShow(false)
  end
  self:resize()
  self._musicIndex = musicIndex
  local url = ""
  if nil ~= self._musicIndex then
    url = self:getURLForEdit(self._musicIndex)
  else
    url = self:getURL()
  end
  self._ui._webControl:SetUrl(self._web_size[self._fullScreenMode].x, self._web_size[self._fullScreenMode].y, url, false, true)
  self._ui._webControl:SetIME(true)
  PaGlobal_Composition_All:open()
end
function PaGlobal_Composition_All:open()
  if nil == Panel_Window_Composition_All then
    return
  end
  Panel_Window_Composition_All:SetShow(true)
end
function PaGlobal_Composition_All:prepareClose()
  if nil == Panel_Window_Composition_All then
    return
  end
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  ToClient_StopMusic(false)
  self._musicIndex = nil
  TooltipSimple_Hide()
  self._ui._webControl:ResetUrl()
  PaGlobal_Composition_All:close()
end
function PaGlobal_Composition_All:close()
  if nil == Panel_Window_Composition_All then
    return
  end
  Panel_Window_Composition_All:SetShow(false)
end
function PaGlobal_Composition_All:setFullMode(isFull)
  if nil == Panel_Window_Composition_All then
    return
  end
  TooltipSimple_Hide()
  ToClient_StopMusic(false)
  if true == isFull then
    self._fullScreenMode = self._eScreenMode.eScreenModeFull
  else
    self._fullScreenMode = self._eScreenMode.eScreenModeWindow
  end
  if true == _ContentsGroup_MusicAlbumFullScreenMode then
    if self._fullScreenMode == self._eScreenMode.eScreenModeWindow then
      self._ui._btn_big:SetShow(true)
      self._ui._btn_small:SetShow(false)
    else
      self._ui._btn_big:SetShow(false)
      self._ui._btn_small:SetShow(true)
    end
  else
    self._ui._btn_big:SetShow(false)
    self._ui._btn_small:SetShow(false)
  end
  self:resize()
  self._ui._webControl:ResetUrl()
  local url = self:getURLForFullMode()
  self._ui._webControl:SetUrl(self._web_size[self._fullScreenMode].x, self._web_size[self._fullScreenMode].y, url, false, true)
  self._ui._webControl:SetIME(true)
end
function PaGlobal_Composition_All:update()
  if nil == Panel_Window_Composition_All then
    return
  end
end
function PaGlobal_Composition_All:validate()
  if nil == Panel_Window_Composition_All then
    return
  end
  self._ui._txt_titleBar:isValidate()
  self._ui._stc_decoration:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._btn_refresh:isValidate()
  self._ui._btn_small:isValidate()
  self._ui._btn_big:isValidate()
  self._ui._webControl:isValidate()
end
function PaGlobal_Composition_All:resize()
  if nil == Panel_Window_Composition_All then
    return
  end
  if self._eScreenMode.eScreenModeFull == self._fullScreenMode then
    self._panel_size[self._eScreenMode.eScreenModeFull] = {
      x = getScreenSizeX(),
      y = getScreenSizeY()
    }
    self._web_size[self._fullScreenMode] = {
      x = getScreenSizeX() - self._web_basicPos.x * 2,
      y = getScreenSizeY() - (self._web_basicPos.x + self._web_basicPos.y)
    }
  end
  self._ui._txt_titleBar:SetSize(self._panel_size[self._fullScreenMode].x, self._ui._txt_titleBar:GetSizeY())
  Panel_Window_Composition_All:SetSize(self._panel_size[self._fullScreenMode].x, self._panel_size[self._fullScreenMode].y)
  self._ui._webControl:SetPosX(self._web_basicPos.x)
  self._ui._webControl:SetPosY(self._web_basicPos.y)
  self._ui._webControl:SetSize(self._web_size[self._fullScreenMode].x, self._web_size[self._fullScreenMode].y)
  Panel_Window_Composition_All:SetPosX(getScreenSizeX() * 0.5 - Panel_Window_Composition_All:GetSizeX() * 0.5)
  Panel_Window_Composition_All:SetPosY(getScreenSizeY() * 0.5 - Panel_Window_Composition_All:GetSizeY() * 0.5)
  self._ui._stc_decoration:ComputePos()
  self._ui._btn_refresh:ComputePos()
  self._ui._btn_small:ComputePos()
  self._ui._btn_big:ComputePos()
  self._ui._btn_close:ComputePos()
end
function PaGlobal_Composition_All:getURL()
  if nil == getSelfPlayer() then
    return
  end
  local url = "coui://UI_DATA/UI_Html/Window/MusicComposition/Index.html"
  return url
end
function PaGlobal_Composition_All:getURLForEdit(musicIndex)
  if nil == getSelfPlayer() then
    return
  end
  local url = "coui://UI_DATA/UI_Html/Window/MusicComposition/Index.html"
  url = url .. "?musicIndex=" .. tostring(musicIndex)
  return url
end
function PaGlobal_Composition_All:getURLForFullMode()
  if nil == getSelfPlayer() then
    return
  end
  local url = "coui://UI_DATA/UI_Html/Window/MusicComposition/Index.html"
  if nil ~= self._musicIndex then
    url = url .. "?musicIndex=" .. tostring(self._musicIndex) .. "&refreshMode=true"
  else
    url = url .. "?refreshMode=true"
  end
  return url
end
