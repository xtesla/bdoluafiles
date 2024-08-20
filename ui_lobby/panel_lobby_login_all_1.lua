function PaGlobal_Login_All:initialize()
  if true == PaGlobal_Login_All._initialize then
    return
  end
  self._ui._stc_webUI = UI.getChildControl(Panel_Lobby_Login_All, "Static_WebParent")
  self._isNormalBI = isGameTypeSA() or isGameTypeKR2() or isGameTypeKorea()
  if false == self._isNormalBI then
    self._ui._stc_bi = UI.getChildControl(Panel_Lobby_Login_All, "Static_BI_Global")
  else
    self._ui._stc_bi = UI.getChildControl(Panel_Lobby_Login_All, "Static_BI")
  end
  self._ui._stc_bi:SetShow(true)
  self._ui._btn_login = UI.getChildControl(Panel_Lobby_Login_All, "Button_Login")
  self._ui._btn_exit = UI.getChildControl(Panel_Lobby_Login_All, "Button_Exit")
  self._ui._btn_option = UI.getChildControl(Panel_Lobby_Login_All, "Button_GameOption_Login")
  self._ui._btn_changeAccount = UI.getChildControl(Panel_Lobby_Login_All, "Button_ChangeAccount")
  self._ui._edit_id = UI.getChildControl(Panel_Lobby_Login_All, "Edit_ID")
  self._ui._txt_inputID = UI.getChildControl(Panel_Lobby_Login_All, "StaticText_InputTxt")
  self._ui._stc_blackLine = UI.getChildControl(Panel_Lobby_Login_All, "Static_Blackline_down")
  self._ui._stc_pearlabyssCI = UI.getChildControl(Panel_Lobby_Login_All, "Static_CI")
  self._ui._stc_daumCI = UI.getChildControl(Panel_Lobby_Login_All, "Static_DaumCI")
  self._isConsole = isGameServiceTypeConsole()
  if false == isLoginIDShow() then
    self._ui._edit_id:SetShow(false)
    self._ui._txt_inputID:SetShow(false)
  else
    self._ui._edit_id:SetShow(true)
    self._ui._txt_inputID:SetShow(true)
    self._ui._edit_id:SetEditText(getLoginID())
  end
  if true == self._isConsole then
    self._ui._btn_option:SetShow(false)
  else
    self._ui._btn_changeAccount:SetShow(false)
  end
  if true == ToClient_isPS4() then
    self._ui._btn_changeAccount:SetShow(false)
    self._ui._btn_exit:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DEADMESSAGE_BACK"))
  end
  if true == ToClient_IsContentsGroupOpen("7") then
    self._movieURL = {
      "coui://UI_Movie/O_01.webm",
      "coui://UI_Movie/O_02.webm",
      "coui://UI_Movie/O_03.webm"
    }
    self._movieLength = {
      8000,
      7000,
      5000
    }
    self._moviePath = {
      "UI_Movie/O_01.bk2",
      "UI_Movie/O_02.bk2",
      "UI_Movie/O_03.bk2"
    }
  end
  if true == _ContentsGroup_AtoraxionSea and false == isGameTypeKR2() then
    self._movieURL = {
      "coui://UI_Movie/login_01.webm",
      "coui://UI_Movie/login_02.webm",
      "coui://UI_Movie/login_03.webm"
    }
    if true == ToClient_isConsole() then
      self._movieLength = {9000, 9000}
    else
      self._movieLength = {8000, 8000}
    end
    self._moviePath = {
      "UI_Movie/login_01.bk2",
      "UI_Movie/login_02.bk2",
      "UI_Movie/login_03.bk2"
    }
    self._movieOrder = {
      1,
      2,
      3
    }
  end
  self._currentMovieIndex = 1
  self:shuffleOrder(self._movieOrder)
  if true == isGameTypeKR2() then
    self:initLoginImage()
  else
    self:initLoginMovie()
  end
  setPresentLock(true)
  PaGlobal_Login_All:registEventHandler()
  PaGlobal_Login_All:validate()
  PaGlobal_Login_All:prepareOpen()
  PaGlobal_Login_All:onScreenResize()
  PaGlobal_Login_All._initialize = true
end
function PaGlobal_Login_All:registEventHandler()
  if nil == Panel_Lobby_Login_All then
    return
  end
  self._ui._btn_login:addInputEvent("Mouse_LUp", "HandleEventLUp_Login_All_LoginStart()")
  self._ui._btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_Login_All_GameExit()")
  self._ui._btn_changeAccount:addInputEvent("Mouse_LUp", "HandleEventLUp_Login_All_ChangeAccount()")
  self._ui._btn_option:addInputEvent("Mouse_LUp", "HandleEventLUp_Login_All_GameOption()")
  registerEvent("ToClient_EndGuideMovie", "FromClient_Login_All_OnMovieEvent")
  registerEvent("onScreenResize", "FromClient_Login_All_onScreenResize")
  if true == self._isConsole then
    registerEvent("FromClient_ClickToLogin", "FromClient_Login_All_ClickToLogin")
  end
  if true == isGameTypeKR2() then
    Panel_Lobby_Login_All:RegisterUpdateFunc("PaGlobal_Login_All_Update")
  end
end
function PaGlobal_Login_All:prepareOpen()
  if nil == Panel_Lobby_Login_All then
    return
  end
  PaGlobal_Login_All:open()
end
function PaGlobal_Login_All:open()
  if nil == Panel_Lobby_Login_All then
    return
  end
  Panel_Lobby_Login_All:SetShow(true)
end
function PaGlobal_Login_All:prepareClose()
  if nil == Panel_Lobby_Login_All then
    return
  end
  PaGlobal_Login_All:close()
end
function PaGlobal_Login_All:close()
  if nil == Panel_Lobby_Login_All then
    return
  end
  Panel_Lobby_Login_All:SetShow(false)
end
function PaGlobal_Login_All:update()
  if nil == Panel_Lobby_Login_All then
    return
  end
end
function PaGlobal_Login_All:validate()
  if nil == Panel_Lobby_Login_All then
    return
  end
  self._ui._stc_webUI:isValidate()
  self._ui._stc_bi:isValidate()
  self._ui._btn_login:isValidate()
  self._ui._btn_exit:isValidate()
  self._ui._btn_option:isValidate()
  self._ui._btn_changeAccount:isValidate()
  self._ui._edit_id:isValidate()
  self._ui._txt_inputID:isValidate()
  self._ui._stc_blackLine:isValidate()
  self._ui._stc_pearlabyssCI:isValidate()
  self._ui._stc_daumCI:isValidate()
end
function PaGlobal_Login_All:initLoginImage()
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  local baseLink = "New_UI_Common_forLua/Window/Lobby/"
  local imageCount = 6
  local imageIndex = 1
  local tempBg = UI.getChildControl(Panel_Lobby_Login_All, "bgBase_1")
  for index = 1, imageCount do
    local targetControl = UI.createControl(__ePAUIControl_Static, Panel_Lobby_Login_All, "Static_Bg_" .. imageIndex)
    CopyBaseProperty(tempBg, targetControl)
    targetControl:ChangeTextureInfoName(baseLink .. "bgCalpeon_" .. index .. ".dds")
    targetControl:SetSize(screenX, screenY)
    targetControl:SetPosX(0)
    targetControl:SetPosY(0)
    targetControl:SetAlpha(0)
    Panel_Lobby_Login_All:SetChildIndex(targetControl, 0)
    self._imageBG[imageIndex] = targetControl
    endIndex = imageIndex
    imageIndex = imageIndex + 1
  end
  self._imageBG[self._currentMovieIndex]:SetShow(true, true)
  self._imageBG[self._currentMovieIndex]:SetAlpha(1)
end
function PaGlobal_Login_All:initLoginMovie()
  if nil == self._ui._vedeo_loginMovie then
    if true == _ContentsGroup_UseVideoContent then
      self._ui._vedeo_loginMovie = UI.createControl(__ePAUIControl_VideoContent, self._ui._stc_webUI, "Static_BgMovie")
    else
      self._ui._vedeo_loginMovie = UI.createControl(__ePAUIControl_WebControl, self._ui._stc_webUI, "Static_BgMovie")
    end
  end
  if self._isConsole then
    Panel_Lobby_Login_All:SetSize(getScreenSizeX(), getScreenSizeY())
    Panel_Lobby_Login_All:SetHorizonCenter()
    Panel_Lobby_Login_All:SetVerticalMiddle()
    self._ui._stc_webUI:SetHorizonCenter()
    self._ui._stc_webUI:SetVerticalMiddle()
    self._ui._vedeo_loginMovie:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
    self._ui._vedeo_loginMovie:SetHorizonCenter()
    self._ui._vedeo_loginMovie:SetVerticalMiddle()
  else
    local uiScale = getGlobalScale()
    local sizeX = getResolutionSizeX()
    local sizeY = getResolutionSizeY()
    sizeX = sizeX / uiScale
    sizeY = sizeY / uiScale
    local movieSizeX = sizeX
    local movieSizeY = sizeX * 1080 / 1920
    local posX = 0
    local posY = 0
    if sizeY >= movieSizeY then
      posY = (sizeY - movieSizeY) * 0.5
    else
      movieSizeX = sizeY * 1920 / 1080
      movieSizeY = sizeY
      posX = (sizeX - movieSizeX) * 0.5
    end
    Panel_Lobby_Login_All:SetPosX(0)
    Panel_Lobby_Login_All:SetPosY(0)
    Panel_Lobby_Login_All:SetSize(sizeX, sizeY)
    local marginX = movieSizeX * 0.013
    local marginY = movieSizeY * 0.013
    if false == _ContentsGroup_UseVideoContent then
      self._ui._vedeo_loginMovie:SetPosX(posX - marginX * 0.5)
      self._ui._vedeo_loginMovie:SetPosY(posY - marginY * 0.5)
      self._ui._vedeo_loginMovie:SetSize(movieSizeX + marginX, movieSizeY + marginY)
    else
      self._ui._stc_webUI:SetPosY(0)
      self._ui._stc_webUI:SetPosX(0)
      self._ui._vedeo_loginMovie:SetSize(movieSizeX, movieSizeY)
    end
  end
  if true == _ContentsGroup_UseVideoContent then
    self._ui._vedeo_loginMovie:createVideoView(self._moviePath[self._movieOrder[self._currentMovieIndex]], getResolutionSizeX(), getResolutionSizeY(), false, true)
  else
    self._ui._vedeo_loginMovie:SetUrl(1920, 1080, "coui://UI_Data/UI_Html/LobbyBG_Movie.html")
  end
end
function PaGlobal_Login_All:shuffleOrder(table)
  if nil == table or nil == #table then
    return
  end
  if #table <= 1 then
    return
  end
  for ii = 1, #table do
    local temp = table[ii]
    local posToShuffle = getRandomValue(1, #table)
    table[ii] = table[posToShuffle]
    table[posToShuffle] = temp
  end
end
function PaGlobal_Login_All:onMovieEvent(param)
  if 1 == param then
    if true == _ContentsGroup_UseVideoContent then
      return
    end
    if nil ~= self._ui._vedeo_loginMovie then
      self._ui._vedeo_loginMovie:TriggerEvent("PlayMovie", self._movieURL[self._movieOrder[self._currentMovieIndex]])
    end
  elseif 2 == param then
    self._currentMovieIndex = self._currentMovieIndex + 1
    if nil == self._movieOrder[self._currentMovieIndex] then
      local count = #self._movieOrder
      self._currentMovieIndex = getRandomValue(1, count)
    end
    if true == _ContentsGroup_UseVideoContent then
      self._ui._vedeo_loginMovie:playVideoView(self._moviePath[self._movieOrder[self._currentMovieIndex]], false, true)
    else
      self._ui._vedeo_loginMovie:TriggerEvent("PlayMovie", self._movieURL[self._movieOrder[self._currentMovieIndex]])
    end
  end
end
function PaGlobal_Login_All:onScreenResize()
  if self._isConsole then
    Panel_Lobby_Login_All:SetSize(getScreenSizeX(), getScreenSizeY())
    Panel_Lobby_Login_All:SetSpanSize(0, 0)
    Panel_Lobby_Login_All:SetHorizonCenter()
    Panel_Lobby_Login_All:SetVerticalMiddle()
    if nil ~= self._ui._vedeo_loginMovie then
      self._ui._vedeo_loginMovie:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
      self._ui._vedeo_loginMovie:SetSpanSize(0, 0)
      self._ui._vedeo_loginMovie:SetHorizonCenter()
      self._ui._vedeo_loginMovie:SetVerticalMiddle()
    end
  else
    local uiScale = getGlobalScale()
    local sizeX = getResolutionSizeX()
    local sizeY = getResolutionSizeY()
    sizeX = sizeX / uiScale
    sizeY = sizeY / uiScale
    local movieSizeX = sizeX
    local movieSizeY = sizeX * 1080 / 1920
    local posX = 0
    local posY = 0
    if sizeY >= movieSizeY then
      posY = (sizeY - movieSizeY) * 0.5
    else
      movieSizeX = sizeY * 1920 / 1080
      movieSizeY = sizeY
      posX = (sizeX - movieSizeX) * 0.5
    end
    Panel_Lobby_Login_All:SetPosX(0)
    Panel_Lobby_Login_All:SetPosY(0)
    Panel_Lobby_Login_All:SetSize(sizeX, sizeY)
    local marginX = movieSizeX * 0.013
    local marginY = movieSizeY * 0.013
    if nil ~= self._ui._vedeo_loginMovie then
      if false == _ContentsGroup_UseVideoContent then
        self._ui._vedeo_loginMovie:SetPosX(posX - marginX * 0.5)
        self._ui._vedeo_loginMovie:SetPosY(posY - marginY * 0.5)
        self._ui._vedeo_loginMovie:SetSize(movieSizeX + marginX, movieSizeY + marginY)
      else
        local tempPosX = (getOriginScreenSizeX() - movieSizeX) * 0.5
        local tempPosY = (getOriginScreenSizeY() - movieSizeY) * 0.5
        self._ui._stc_webUI:SetPosX(tempPosX)
        self._ui._stc_webUI:SetPosY(tempPosY)
        self._ui._vedeo_loginMovie:SetSize(movieSizeX, movieSizeY)
        self._ui._vedeo_loginMovie:setVideoSize(getResolutionSizeX(), getResolutionSizeY())
      end
    end
  end
  self._ui._btn_login:ComputePos()
  self._ui._btn_exit:ComputePos()
  self._ui._btn_option:ComputePos()
  self._ui._btn_changeAccount:ComputePos()
  self._ui._edit_id:ComputePos()
  self._ui._txt_inputID:ComputePos()
  self._ui._stc_blackLine:SetShow(false)
  if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeGT() or isGameTypeTR() or isGameTypeTH() or isGameTypeID() or true == self._isConsole or isGameTypeRussia() or isGameTypeJapan() or isGameTypeEnglish() then
    self._ui._stc_daumCI:SetShow(false)
    if false == self._isConsole then
      self._ui._stc_pearlabyssCI:SetSpanSize(10, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_pearlabyssCI:GetSizeY()) * 0.5)
    else
      local getConsoleUIOffset = ToClient_GetConsoleUIOffset()
      if getConsoleUIOffset > 0 then
        local uiOffsetX = getOriginScreenSizeX() * ToClient_GetConsoleUIOffset()
        local uiOffsetY = getOriginScreenSizeY() * ToClient_GetConsoleUIOffset()
        self._ui._stc_pearlabyssCI:SetSpanSize(Panel_Lobby_Login_All:GetPosX() + uiOffsetX, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_pearlabyssCI:GetSizeY()) * 0.5 + uiOffsetY)
      else
        self._ui._stc_pearlabyssCI:SetSpanSize(Panel_Lobby_Login_All:GetPosX() + 40, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_pearlabyssCI:GetSizeY()) * 0.5)
      end
    end
  elseif isGameTypeSA() then
    self._ui._stc_daumCI:SetSize(136, 50)
    self._ui._stc_daumCI:ChangeTextureInfoName("new_ui_common_forlua/window/lobby/login_CI_Daum.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_daumCI, 0, 0, 136, 50)
    self._ui._stc_daumCI:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_daumCI:setRenderTexture(self._ui._stc_daumCI:getBaseTexture())
    self._ui._stc_pearlabyssCI:SetSpanSize(self._ui._stc_daumCI:GetSizeX() + 30, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_pearlabyssCI:GetSizeY()) * 0.5)
  elseif isGameTypeKR2() then
    self._ui._stc_daumCI:SetSize(95, 53)
    self._ui._stc_daumCI:ChangeTextureInfoName("new_ui_common_forlua/window/lobby/login_CI_Daum.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_daumCI, 0, 0, 95, 53)
    self._ui._stc_daumCI:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_daumCI:setRenderTexture(self._ui._stc_daumCI:getBaseTexture())
    self._ui._stc_pearlabyssCI:SetSpanSize(self._ui._stc_daumCI:GetSizeX() + 30, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_pearlabyssCI:GetSizeY()) * 0.5)
  else
    self._ui._stc_daumCI:SetSize(144, 26)
    self._ui._stc_daumCI:ChangeTextureInfoName("new_ui_common_forlua/window/lobby/login_CI_Daum.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_daumCI, 0, 0, 144, 26)
    self._ui._stc_daumCI:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_daumCI:setRenderTexture(self._ui._stc_daumCI:getBaseTexture())
    self._ui._stc_pearlabyssCI:SetSpanSize(self._ui._stc_daumCI:GetSizeX() + 30, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_pearlabyssCI:GetSizeY()) * 0.5)
  end
  self._ui._stc_daumCI:SetSpanSize(20, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_daumCI:GetSizeY()) * 0.5)
  self._ui._stc_bi:ComputePos()
  self._ui._stc_pearlabyssCI:ComputePos()
  self._ui._stc_daumCI:ComputePos()
  self._ui._stc_blackLine:ComputePos()
  self._ui._stc_bi:SetPosY(getScreenSizeY() * 0.14)
  if self._isConsole then
    self._ui._stc_pearlabyssCI:SetSpanSize(30, 12)
  end
  PaGlobal_CheckGamerTag()
end
function PaGlobal_Login_All:enterLogin()
  connectToGame(self._ui._edit_id:GetEditText(), "\234\178\128\236\157\128\236\160\132\236\130\172\235\185\132\235\178\136")
end
function PaGlobal_Login_All:updateButtonDisable(isDisable)
  if true == isDisable then
    self._ui._btn_login:SetEnable(false)
    self._ui._btn_login:SetMonoTone(true)
    self._ui._btn_login:SetIgnore(true)
    self._ui._btn_exit:SetEnable(false)
    self._ui._btn_exit:SetMonoTone(true)
    self._ui._btn_exit:SetIgnore(true)
    self._ui._btn_option:SetEnable(false)
    self._ui._btn_option:SetMonoTone(true)
    self._ui._btn_option:SetIgnore(true)
    self._ui._btn_changeAccount:SetEnable(false)
    self._ui._btn_changeAccount:SetMonoTone(true)
    self._ui._btn_changeAccount:SetIgnore(true)
  else
    self._ui._btn_login:SetEnable(true)
    self._ui._btn_login:SetMonoTone(false)
    self._ui._btn_login:SetIgnore(false)
    self._ui._btn_exit:SetEnable(true)
    self._ui._btn_exit:SetMonoTone(false)
    self._ui._btn_exit:SetIgnore(false)
    self._ui._btn_option:SetEnable(true)
    self._ui._btn_option:SetMonoTone(false)
    self._ui._btn_option:SetIgnore(false)
    self._ui._btn_changeAccount:SetEnable(true)
    self._ui._btn_changeAccount:SetMonoTone(false)
    self._ui._btn_changeAccount:SetIgnore(false)
  end
end
function PaGlobal_Login_All_Update(deltaTime)
  local startUV = 0.1
  local endUV = startUV + 0.04
  local startUV2 = 0.9
  local endUV2 = startUV2 + 0.04
  PaGlobal_Login_All._imageUpdateTime = PaGlobal_Login_All._imageUpdateTime - deltaTime
  if PaGlobal_Login_All._imageUpdateTime <= 0 then
    PaGlobal_Login_All._imageUpdateTime = 15
    if true == PaGlobal_Login_All._isScope then
      PaGlobal_Login_All._isScope = false
      local FadeMaskAni = PaGlobal_Login_All._imageBG[PaGlobal_Login_All._currentImageIndex]:addTextureUVAnimation(0, 15, 0)
      FadeMaskAni:SetStartUV(startUV, startUV, 0)
      FadeMaskAni:SetEndUV(endUV, startUV, 0)
      FadeMaskAni:SetStartUV(startUV2, startUV, 1)
      FadeMaskAni:SetEndUV(endUV2, startUV, 1)
      FadeMaskAni:SetStartUV(startUV, startUV2, 2)
      FadeMaskAni:SetEndUV(endUV, startUV2, 2)
      FadeMaskAni:SetStartUV(startUV2, startUV2, 3)
      FadeMaskAni:SetEndUV(endUV2, startUV2, 3)
    else
      PaGlobal_Login_All._isScope = true
      local FadeMaskAni = PaGlobal_Login_All._imageBG[PaGlobal_Login_All._currentImageIndex]:addTextureUVAnimation(0, 15, 0)
      FadeMaskAni:SetEndUV(startUV, startUV, 0)
      FadeMaskAni:SetStartUV(endUV, startUV, 0)
      FadeMaskAni:SetEndUV(startUV2, startUV, 1)
      FadeMaskAni:SetStartUV(endUV2, startUV, 1)
      FadeMaskAni:SetEndUV(startUV, startUV2, 2)
      FadeMaskAni:SetStartUV(endUV, startUV2, 2)
      FadeMaskAni:SetEndUV(startUV2, startUV2, 3)
      FadeMaskAni:SetStartUV(endUV2, startUV2, 3)
      local fadeColor = PaGlobal_Login_All._imageBG[PaGlobal_Login_All._currentImageIndex]:addColorAnimation(15, 17, 0)
      fadeColor:SetStartColor(Defines.Color.C_FFFFFFFF)
      fadeColor:SetEndColor(Defines.Color.C_00FFFFFF)
      PaGlobal_Login_All._currentImageIndex = PaGlobal_Login_All._currentImageIndex + 1
      if #PaGlobal_Login_All._imageBG < PaGlobal_Login_All._currentImageIndex then
        PaGlobal_Login_All._currentImageIndex = 1
      end
      local baseTexture = PaGlobal_Login_All._imageBG[PaGlobal_Login_All._currentImageIndex]:getBaseTexture()
      baseTexture:setUV(startUV, startUV, startUV2, startUV2)
      PaGlobal_Login_All._imageBG[PaGlobal_Login_All._currentImageIndex]:setRenderTexture(baseTexture)
      local fadeColor2 = PaGlobal_Login_All._imageBG[PaGlobal_Login_All._currentImageIndex]:addColorAnimation(12, 15, 0)
      fadeColor2:SetStartColor(Defines.Color.C_00FFFFFF)
      fadeColor2:SetEndColor(Defines.Color.C_FFFFFFFF)
    end
  end
end
