function PaGlobal_House_InstallationMode_KeyGuide_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_commandBg = UI.getChildControl(Panel_House_InstallationMode_KeyGuide_All, "Static_CommandBG")
  self._keyGuideBgList = {
    [self._eKeyType.ROTATE_LEFT] = UI.getChildControl(self._ui._stc_commandBg, "Static_Rotate_Left_BG"),
    [self._eKeyType.ROTATE_RIGHT] = UI.getChildControl(self._ui._stc_commandBg, "Static_Rotate_Right_BG"),
    [self._eKeyType.SLOW_ROTATE_LEFT] = UI.getChildControl(self._ui._stc_commandBg, "Static_Slow_Rotate_Left_BG"),
    [self._eKeyType.SLOW_ROTATE_RIGHT] = UI.getChildControl(self._ui._stc_commandBg, "Static_Slow_Rotate_Right_BG"),
    [self._eKeyType.WHEEL] = UI.getChildControl(self._ui._stc_commandBg, "Static_Wheel_BG"),
    [self._eKeyType.SPEED_WHEEL] = UI.getChildControl(self._ui._stc_commandBg, "Static_Speed_Wheel_BG"),
    [self._eKeyType.CAMERA_UP] = UI.getChildControl(self._ui._stc_commandBg, "Static_Camera_Up_BG"),
    [self._eKeyType.CAMERA_DOWN] = UI.getChildControl(self._ui._stc_commandBg, "Static_Camera_Down_BG"),
    [self._eKeyType.INSTALL] = UI.getChildControl(self._ui._stc_commandBg, "Static_Install_BG"),
    [self._eKeyType.INSTALL_CANCEL] = UI.getChildControl(self._ui._stc_commandBg, "Static_InstallCancel_BG")
  }
  self._ui._txt_speedWheelDesc = UI.getChildControl(self._keyGuideBgList[self._eKeyType.SPEED_WHEEL], "StaticText_KeyDesc")
  self._ui._stc_showCommandBg = UI.getChildControl(Panel_House_InstallationMode_KeyGuide_All, "Static_ShowCommandBG")
  self._ui._btn_showCommand = UI.getChildControl(self._ui._stc_showCommandBg, "Button_ShowCommand")
  self:registEventHandler()
  self:validate()
  self._basePanelSizeX = Panel_House_InstallationMode_KeyGuide_All:GetSizeX()
  self._baseCommandBgSizeX = self._ui._stc_commandBg:GetSizeX()
  self._baseKeyPosY = self._keyGuideBgList[self._eKeyType.ROTATE_LEFT]:GetPosY()
  self._initialize = true
end
function PaGlobal_House_InstallationMode_KeyGuide_All:registEventHandler()
  if nil == Panel_House_InstallationMode_KeyGuide_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_House_Installation_All_Resize")
  registerEvent("FromClient_ChangeHousingInstallMode", "FromClient_House_InstallationMode_KeyGuide_All_ChangeInstallMode")
  self._ui._btn_showCommand:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationMode_KeyGuide_All_CommandShowToggle()")
end
function PaGlobal_House_InstallationMode_KeyGuide_All:resize()
  if nil == Panel_House_InstallationMode_KeyGuide_All then
    return
  end
  local keyTextSizeGapX = 0
  local showKeyCount = 0
  for index = 1, self._eKeyType.COUNT - 1 do
    if true == self._keyGuideBgList[index]:GetShow() then
      self._keyGuideBgList[index]:SetPosY(self._baseKeyPosY + self._baseKeyPosYGap * showKeyCount)
      local keyDesc = UI.getChildControl(self._keyGuideBgList[index], "StaticText_KeyDesc")
      if nil ~= keyDesc then
        local sizeGapX = keyDesc:GetTextSizeX() - keyDesc:GetSizeX()
        if sizeGapX > 0 and keyTextSizeGapX < sizeGapX then
          keyTextSizeGapX = sizeGapX
        end
      end
      showKeyCount = showKeyCount + 1
    end
  end
  self._ui._stc_commandBg:SetSize(self._baseCommandBgSizeX + keyTextSizeGapX, self._baseKeyPosYGap * showKeyCount + 15)
  if true == self._ui._btn_showCommand:IsCheck() then
    Panel_House_InstallationMode_KeyGuide_All:SetSize(self._basePanelSizeX + keyTextSizeGapX, self._ui._stc_commandBg:GetSizeY() + 25)
  else
    Panel_House_InstallationMode_KeyGuide_All:SetSize(self._ui._stc_showCommandBg:GetSizeX(), self._ui._stc_showCommandBg:GetSizeY())
  end
  self._ui._stc_showCommandBg:ComputePos()
end
function PaGlobal_House_InstallationMode_KeyGuide_All:prepareOpen()
  if nil == Panel_House_InstallationMode_KeyGuide_All then
    return
  end
  if true == self._isConsole then
    return
  end
  if true == housing_isBuildMode() then
    return
  end
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    return
  end
  local houseSS = houseWrapper:getStaticStatusWrapper()
  if nil == houseSS then
    return
  end
  local houseObjectSS = houseSS:getObjectStaticStatus()
  if nil == houseObjectSS then
    return
  end
  if false == houseObjectSS:isFixedHouse() and false == houseObjectSS:isInnRoom() and false == houseObjectSS:isMansionLand() then
    return
  end
  local isKeyGuideShow = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eInstallationModeKeyGuideShow)
  self._ui._btn_showCommand:SetCheck(isKeyGuideShow)
  self._ui._stc_commandBg:SetShow(isKeyGuideShow)
  self:updateKeyGuide()
  PaGlobal_House_InstallationMode_KeyGuide_All:open()
end
function PaGlobal_House_InstallationMode_KeyGuide_All:open()
  if nil == Panel_House_InstallationMode_KeyGuide_All then
    return
  end
  Panel_House_InstallationMode_KeyGuide_All:SetShow(true)
end
function PaGlobal_House_InstallationMode_KeyGuide_All:prepareClose()
  if nil == Panel_House_InstallationMode_KeyGuide_All then
    return
  end
  PaGlobal_House_InstallationMode_KeyGuide_All:close()
end
function PaGlobal_House_InstallationMode_KeyGuide_All:close()
  if nil == Panel_House_InstallationMode_KeyGuide_All then
    return
  end
  Panel_House_InstallationMode_KeyGuide_All:SetShow(false)
end
function PaGlobal_House_InstallationMode_KeyGuide_All:updateKeyGuide()
  if nil == Panel_House_InstallationMode_KeyGuide_All then
    return
  end
  for index = 1, self._eKeyType.COUNT - 1 do
    self._keyGuideBgList[index]:SetShow(false)
  end
  local characterStaticWrapper = housing_getCreatedCharacterStaticWrapper()
  if nil == characterStaticWrapper then
    return
  end
  local objectStaticWrapper = characterStaticWrapper:getObjectStaticStatus()
  if nil == objectStaticWrapper then
    return
  end
  local installType = CppEnums.InstallationType
  local installationType = objectStaticWrapper:getInstallationType()
  if installationType >= installType.TypeCount then
    return
  end
  local isRotateKey = false
  local isWheelKey = false
  local isSettingKey = false
  if installType.eType_Chandelier == installationType then
    isRotateKey = true
    if self._eModeState.detail == self._curModeState then
      isWheelKey = true
      self._ui._txt_speedWheelDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLATIONMODE_HEIGHT_ADJUSTMENT_SPEED"))
    elseif self._eModeState.watingConfirm == self._curModeState then
      isSettingKey = true
    end
  elseif installType.eType_Curtain == installationType or installType.eType_Curtain_Tied == installationType then
    if self._eModeState.detail == self._curModeState then
      isWheelKey = true
      self._ui._txt_speedWheelDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLATIONMODE_CURTAINSIZE_ADJUSTMENT"))
    elseif self._eModeState.watingConfirm == self._curModeState then
      isSettingKey = true
    end
  elseif true == objectStaticWrapper:isInstallableOnWall() or installType.eType_WallPaper == installationType or installType.eType_FloorMaterial == installationType or installType.eType_Shelf == installationType or installType.eType_FirePlace == installationType then
    if self._eModeState.watingConfirm == self._curModeState then
      isSettingKey = true
    end
  else
    isRotateKey = true
    if self._eModeState.translation ~= self._curModeState then
      isSettingKey = true
    end
  end
  if true == ToClient_VisitHouseIsMansion() then
    self._keyGuideBgList[self._eKeyType.CAMERA_UP]:SetShow(true)
    self._keyGuideBgList[self._eKeyType.CAMERA_DOWN]:SetShow(true)
  else
    self._keyGuideBgList[self._eKeyType.CAMERA_UP]:SetShow(false)
    self._keyGuideBgList[self._eKeyType.CAMERA_DOWN]:SetShow(false)
  end
  if true == isRotateKey then
    self._keyGuideBgList[self._eKeyType.ROTATE_LEFT]:SetShow(true)
    self._keyGuideBgList[self._eKeyType.ROTATE_RIGHT]:SetShow(true)
    self._keyGuideBgList[self._eKeyType.SLOW_ROTATE_LEFT]:SetShow(true)
    self._keyGuideBgList[self._eKeyType.SLOW_ROTATE_RIGHT]:SetShow(true)
  end
  if true == isWheelKey then
    self._keyGuideBgList[self._eKeyType.WHEEL]:SetShow(true)
    self._keyGuideBgList[self._eKeyType.SPEED_WHEEL]:SetShow(true)
  end
  if true == isSettingKey then
    self._keyGuideBgList[self._eKeyType.INSTALL]:SetShow(true)
  end
  self._keyGuideBgList[self._eKeyType.INSTALL_CANCEL]:SetShow(true)
  self:resize()
end
function PaGlobal_House_InstallationMode_KeyGuide_All:validate()
  if nil == Panel_House_InstallationMode_KeyGuide_All then
    return
  end
  self._ui._stc_commandBg:isValidate()
  for index = 1, self._eKeyType.COUNT - 1 do
    self._keyGuideBgList[index]:isValidate()
  end
  self._ui._txt_speedWheelDesc:isValidate()
  self._ui._stc_showCommandBg:isValidate()
  self._ui._btn_showCommand:isValidate()
end
