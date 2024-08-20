local PaGlobal_Production_Movie = {
  _ui = {stc_movie = nil},
  _currentProductionKey = nil,
  _currentMoviePath = nil,
  _currentSubTitlePath = nil
}
function PaGlobal_Production_Movie:initialize()
  if nil == Panel_Window_Production_Movie then
    return
  end
  if true == _ContentsGroup_UseInGameVideoContent then
    self._ui.stc_movie = UI.createControl(__ePAUIControl_VideoContent, Panel_Window_Production_Movie, "VideoControl_Movie")
  else
    self._ui.stc_movie = UI.createControl(__ePAUIControl_WebControl, Panel_Window_Production_Movie, "WebControl_Movie")
  end
  PaGlobal_Production_Movie_ReSizePanel()
  Panel_Window_Production_Movie:SetShow(false, false)
end
function PaGlobal_Production_Movie:startMovie(productionKey, moviePath, subTitlePath)
  if nil == self._ui.stc_movie then
    return
  end
  self._currentProductionKey = productionKey
  self._currentMoviePath = moviePath
  if nil == subTitlePath then
    self._currentSubTitlePath = ""
  else
    self._currentSubTitlePath = subTitlePath
  end
  if true == _ContentsGroup_UseInGameVideoContent then
    self._ui.stc_movie:createVideoView(self._currentMoviePath, getResolutionSizeX(), getResolutionSizeY(), false, true, self._currentSubTitlePath, true)
    self._ui.stc_movie:SetShow(false)
    ToClient_setProductionMovie_ForProductionOnly(productionKey, moviePath, self._ui.stc_movie)
  else
  end
  Panel_Window_Production_Movie:SetShow(true, false)
  setMoviePlayMode(true)
end
function PaGlobal_Production_Movie:startMovieWithoutProductionKey(moviePath, subTitlePath)
  if nil == self._ui.stc_movie then
    return
  end
  self._currentProductionKey = nil
  self._currentMoviePath = moviePath
  if nil == subTitlePath then
    self._currentSubTitlePath = ""
  else
    self._currentSubTitlePath = subTitlePath
  end
  if true == _ContentsGroup_UseInGameVideoContent then
    self._ui.stc_movie:createVideoView(self._currentMoviePath, getResolutionSizeX(), getResolutionSizeY(), false, true, self._currentSubTitlePath, true)
    self._ui.stc_movie:SetShow(false)
    ToClient_setProductionMovie(moviePath, self._ui.stc_movie)
  else
  end
  Panel_Window_Production_Movie:SetShow(true, false)
  setMoviePlayMode(true)
end
function PaGlobal_Production_Movie:endMovie()
  if nil == self._ui.stc_movie then
    return
  end
  if false == Panel_Window_Production_Movie:IsShow() then
    return
  end
  toClient_FadeIn(1)
  if nil ~= self._currentProductionKey then
    ToClient_EndProductionMovie()
  end
  if true == _ContentsGroup_UseInGameVideoContent then
    self._ui.stc_movie:resetVideoView()
  else
    self._ui.stc_movie:TriggerEvent("StopMovie", "")
    self._ui.stc_movie:ResetUrl()
  end
  Panel_Window_Production_Movie:SetShow(false, false)
  SetUIMode(Defines.UIMode.eUIMode_Default)
  setMoviePlayMode(false)
  self._currentMoviePath = nil
  self._currentProductionKey = nil
  self._currentSubTitlePath = nil
end
function FromClient_responseMovieParam(param)
  if param == 1 then
  elseif param == 2 then
    PaGlobal_Production_Movie:endMovie()
  end
end
registerEvent("FromClient_luaLoadComplete", "FromClient_ProductionMovieInit")
registerEvent("FromClient_startProductionMovie", "FromClient_startProductionMovie")
registerEvent("FromClient_startMovieWithoutProductionKey", "FromClient_startMovieWithoutProductionKey")
registerEvent("ToClient_EndGuideMovie", "FromClient_responseMovieParam")
registerEvent("onScreenResize", "PaGlobal_Production_Movie_ReSizePanel")
function FromClient_ProductionMovieInit()
  PaGlobal_Production_Movie:initialize()
end
function FromClient_startProductionMovie(productionKey, moviePath)
  if nil == Panel_Window_Production_Movie then
    return
  end
  Panel_Widget_NewTutorial_Key:SetShow(false)
  Panel_Widget_NewTutorial_Quest:SetShow(false)
  Panel_Widget_NewTutorial_SkillGuide:SetShow(false)
  PaGlobal_Production_Movie:startMovie(productionKey, moviePath)
end
function FromClient_startMovieWithoutProductionKey(moviePath)
  if nil == Panel_Window_Production_Movie then
    return
  end
  Panel_Widget_NewTutorial_Key:SetShow(false)
  Panel_Widget_NewTutorial_Quest:SetShow(false)
  Panel_Widget_NewTutorial_SkillGuide:SetShow(false)
  PaGlobal_Production_Movie:startMovieWithoutProductionKey(moviePath)
end
function PaGlobal_Production_Movie_EscClose()
  if nil == Panel_Window_Production_Movie then
    return
  end
  local self = PaGlobal_Production_Movie
  local function endMovie()
    self:endMovie()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "CUTSCENE_EXIT_MESSAGEBOX_MEMO"),
    functionYes = endMovie,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Production_Movie_ReSizePanel()
  local self = PaGlobal_Production_Movie
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
  Panel_Window_Production_Movie:SetPosX(0)
  Panel_Window_Production_Movie:SetPosY(0)
  Panel_Window_Production_Movie:SetSize(sizeX, sizeY)
  if nil ~= self._ui.stc_movie then
    self._ui.stc_movie:SetIgnore(false)
    self._ui.stc_movie:SetPosX(posX)
    self._ui.stc_movie:SetPosY(posY)
    self._ui.stc_movie:SetSize(movieSizeX, movieSizeY)
    if false == _ContentsGroup_UseInGameVideoContent then
      self._ui.stc_movie:SetPosX(posX)
      self._ui.stc_movie:SetPosY(posY)
      self._ui.stc_movie:SetSize(movieSizeX, movieSizeY)
    else
      local tempPosX = (getOriginScreenSizeX() - movieSizeX) * 0.5
      local tempPosY = (getOriginScreenSizeY() - movieSizeY) * 0.5
      self._ui.stc_movie:SetPosX(tempPosX)
      self._ui.stc_movie:SetPosY(tempPosY)
      self._ui.stc_movie:SetSize(movieSizeX, movieSizeY)
    end
  end
end
