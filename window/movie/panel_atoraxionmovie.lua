PaGlobal_AtoraxionMovie = {
  _ui = {_stc_IntroMovie = nil},
  _atoraxionMapData = {
    [__eInstanceAtoraxion_Hadum] = {
      _itemKey = 757204,
      _itemContentType = __eContentsType_AtoraxionHadumEnter,
      _binkPath = nil,
      _webPath = nil
    },
    [__eInstanceAtoraxion_Normal] = {
      _itemKey = 757164,
      _itemContentType = __eContentsType_AtoraxionNormalEnter,
      _binkPath = nil,
      _webPath = nil
    },
    [__eInstanceAtoraxionSea_Hadum] = {
      _itemKey = 757280,
      _itemContentType = __eContentsType_AtoraxionSeaHadumEnter,
      _binkPath = "UI_Movie/Bink/Atoraxion/Atoraxion_PT2_Boss.bk2",
      _webPath = "UI_Movie/Atoraxion_PT2_Boss.webm"
    },
    [__eInstanceAtoraxionSea_Normal] = {
      _itemKey = 757272,
      _itemContentType = __eContentsType_AtoraxionSeaNormalEnter,
      _binkPath = "UI_Movie/Bink/Atoraxion/Atoraxion_PT2_Boss.bk2",
      _webPath = "UI_Movie/Atoraxion_PT2_Boss.webm"
    }
  },
  _currentMapKey = nil,
  _initialize = false
}
registerEvent("FromClient_AtoraxionMovieInit", "FromClient_AtoraxionMovie_PlayWithInit")
function FromClient_AtoraxionMovie_PlayWithInit(mapKey)
  if false == _ContentsGroup_AtoraxionSea then
    return
  end
  PaGlobal_AtoraxionMovie:playWithInitialize(mapKey)
end
function PaGlobal_AtoraxionMovie:playWithInitialize(mapKey)
  if nil == Panel_AtoraxionMovie or true == Panel_AtoraxionMovie:GetShow() then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  if true == isSwapCharacter() or false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_AtoraxionBoss) then
    return
  end
  self._currentMapKey = mapKey
  if nil == self._currentMapKey then
    return
  end
  local mapData = self._atoraxionMapData[self._currentMapKey]
  if nil == mapData then
    return
  end
  local moviePath
  if true == _ContentsGroup_UseInGameVideoContent then
    moviePath = mapData._binkPath
  else
    moviePath = mapData._webPath
  end
  if nil == moviePath then
    return
  end
  local hasItem = doHaveContentsItem(mapData._itemContentType, 0, false)
  if nil == hasItem or false == hasItem then
    return
  end
  PaGlobal_AtoraxionMovie:registerEvent()
  if nil == self._ui._stc_IntroMovie then
    if true == _ContentsGroup_UseInGameVideoContent then
      self._ui._stc_IntroMovie = UI.createControl(__ePAUIControl_VideoContent, Panel_AtoraxionMovie, "VideoControl_AtoraxionMovie")
    else
      self._ui._stc_IntroMovie = UI.createControl(__ePAUIControl_WebControl, Panel_AtoraxionMovie, "WebControl_AtoraxionMovie")
    end
    if true == _ContentsGroup_UseInGameVideoContent then
      self._ui._stc_IntroMovie:createVideoView(moviePath, getResolutionSizeX(), getResolutionSizeY(), false, true)
    else
      self._ui._stc_IntroMovie:SetUrl(getResolutionSizeX(), getResolutionSizeY(), moviePath)
    end
  elseif true == _ContentsGroup_UseInGameVideoContent then
    PaGlobal_AtoraxionMovie:playBink()
  else
    PaGlobal_AtoraxionMovie:playWebm()
  end
  ToClient_SetFalseCharacterViewMode()
  PaGlobal_AtoraxionMovie:open()
  FromClient_AtoraxionMovie_Resize()
  setMoviePlayMode(true)
end
function PaGlobal_AtoraxionMovie:registerEvent()
  registerEvent("ToClient_EndGuideMovie", "FromClient_AtoraxionMovie_EndIntroMovie")
  registerEvent("onScreenResize", "FromClient_AtoraxionMovie_Resize")
end
function PaGlobal_AtoraxionMovie:close()
  Panel_AtoraxionMovie:SetShow(false)
end
function PaGlobal_AtoraxionMovie:open()
  Panel_AtoraxionMovie:SetShow(true)
end
function PaGlobal_AtoraxionMovie:playWebm()
  if nil == self._ui._stc_IntroMovie then
    return
  end
  if nil == self._currentMapKey then
    return
  end
  local mapData = self._atoraxionMapData[self._currentMapKey]
  if nil == mapData then
    return
  end
  if nil == mapData._webPath then
    return
  end
  self._ui._stc_IntroMovie:TriggerEvent("PlayMovie", mapData._webPath)
  setMoviePlayMode(true)
end
function PaGlobal_AtoraxionMovie:playBink()
  if nil == self._ui._stc_IntroMovie then
    return
  end
  if nil == self._currentMapKey then
    return
  end
  local mapData = self._atoraxionMapData[self._currentMapKey]
  if nil == mapData then
    return
  end
  if nil == mapData._binkPath then
    return
  end
  self._ui._stc_IntroMovie:playVideoView(mapData._binkPath, false, true)
  setMoviePlayMode(true)
end
function FromClient_AtoraxionMovie_Resize()
  if nil == Panel_AtoraxionMovie or false == Panel_AtoraxionMovie:GetShow() then
    return
  end
  if nil == PaGlobal_AtoraxionMovie._ui._stc_IntroMovie then
    return
  end
  local uiScale = getGlobalScale()
  local sizeX = getResolutionSizeX()
  local sizeY = getResolutionSizeY()
  sizeX = sizeX / uiScale
  sizeY = sizeY / uiScale
  local movieSizeX = sizeX
  local movieSizeY = sizeX * 9 / 16
  local posX = 0
  local posY = 0
  if sizeY >= movieSizeY then
    posY = (sizeY - movieSizeY) / 2
  else
    movieSizeX = sizeY * 16 / 9
    movieSizeY = sizeY
    posX = (sizeX - movieSizeX) / 2
  end
  Panel_AtoraxionMovie:SetPosX(0)
  Panel_AtoraxionMovie:SetPosY(0)
  Panel_AtoraxionMovie:SetSize(sizeX, sizeY)
  PaGlobal_AtoraxionMovie._ui._stc_IntroMovie:SetIgnore(false)
  if false == _ContentsGroup_UseInGameVideoContent then
    PaGlobal_AtoraxionMovie._ui._stc_IntroMovie:SetPosX(posX)
    PaGlobal_AtoraxionMovie._ui._stc_IntroMovie:SetPosY(posY)
    PaGlobal_AtoraxionMovie._ui._stc_IntroMovie:SetSize(movieSizeX, movieSizeY)
  else
    local tempPosX = (getOriginScreenSizeX() - movieSizeX) * 0.5
    local tempPosY = (getOriginScreenSizeY() - movieSizeY) * 0.5
    PaGlobal_AtoraxionMovie._ui._stc_IntroMovie:SetPosX(tempPosX)
    PaGlobal_AtoraxionMovie._ui._stc_IntroMovie:SetPosY(tempPosY)
    PaGlobal_AtoraxionMovie._ui._stc_IntroMovie:SetSize(movieSizeX, movieSizeY)
  end
end
function PaGlobalFunc_AtoraxionMovie_Close()
  if nil == Panel_AtoraxionMovie or false == Panel_AtoraxionMovie:GetShow() then
    return
  end
  if nil ~= self._ui._stc_IntroMovie then
    if true == _ContentsGroup_UseInGameVideoContent then
      self._ui._stc_IntroMovie:resetVideoView()
    else
      self._ui._stc_IntroMovie:TriggerEvent("StopMovie", "")
      self._ui._stc_IntroMovie:ResetUrl()
    end
    unregisterEvent("ToClient_EndGuideMovie", "FromClient_AtoraxionMovie_EndIntroMovie")
  end
  PaGlobal_AtoraxionMovie:close()
  SetUIMode(Defines.UIMode.eUIMode_Default)
  setMoviePlayMode(false)
end
function FromClient_AtoraxionMovie_EndIntroMovie(param)
  if nil == Panel_AtoraxionMovie then
    return
  end
  if param == 1 then
    if false == _ContentsGroup_UseInGameVideoContent then
      PaGlobal_AtoraxionMovie:playWebm()
    else
      PaGlobal_AtoraxionMovie:playBink()
    end
  elseif param == 2 and Panel_AtoraxionMovie:GetShow() then
    setMoviePlayMode(false)
    toClient_FadeIn(1)
    PaGlobalFunc_AtoraxionMovie_Close()
  end
end
