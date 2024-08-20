function PaGlobal_ColorPalette_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_title = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_Title")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_title, "Button_Close")
  self._ui.stc_paletteBG = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_Palette_BG")
  self._ui.stc_palette = UI.getChildControl(self._ui.stc_paletteBG, "Static_Color0")
  self._ui.stc_paletteCursor = UI.getChildControl(self._ui.stc_palette, "Static_Cursor")
  self._ui.stc_brightBG = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_Bright_BG")
  self._ui.stc_bright = UI.getChildControl(self._ui.stc_brightBG, "Static_Color1")
  self._ui.stc_brightSlider = UI.getChildControl(self._ui.stc_brightBG, "Static_Slider")
  local stc_selectColorBG = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_Select_Color_BG")
  self._ui.stc_selectColor = UI.getChildControl(stc_selectColorBG, "Static_SelectColor")
  local stc_colorInfoBG = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_ColorInfo_Select")
  self._ui.txt_textInfoR = UI.getChildControl(stc_colorInfoBG, "StaticText_Info_R")
  self._ui.txt_textInfoG = UI.getChildControl(stc_colorInfoBG, "StaticText_Info_G")
  self._ui.txt_textInfoB = UI.getChildControl(stc_colorInfoBG, "StaticText_Info_B")
  local stc_editNumberBG = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_Edit_BG")
  self._ui.edit_numberR = UI.getChildControl(stc_editNumberBG, "Edit_R")
  self._ui.edit_numberG = UI.getChildControl(stc_editNumberBG, "Edit_G")
  self._ui.edit_numberB = UI.getChildControl(stc_editNumberBG, "Edit_B")
  self._ui.edit_numberR:SetNumberMode(true)
  self._ui.edit_numberG:SetNumberMode(true)
  self._ui.edit_numberB:SetNumberMode(true)
  self:createControl()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ColorPalette_All:createControl()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if self._config.brightLevelCount < 1 then
    return
  end
  local brightLevelYSize = self._ui.stc_bright:GetSizeY() / self._config.brightLevelCount
  for index = 0, self._config.brightLevelCount - 1 do
    self._ui.brightLevel[index] = UI.cloneControl(self._ui.stc_bright, self._ui.stc_brightBG, "Static_BrightLevel_" .. index)
    self._ui.brightLevel[index]:SetPosX(self._ui.stc_bright:GetPosX())
    self._ui.brightLevel[index]:SetPosY(self._ui.stc_bright:GetPosY() + brightLevelYSize * index)
    self._ui.brightLevel[index]:SetSize(self._ui.stc_bright:GetSizeX(), brightLevelYSize)
    self._ui.brightLevel[index]:SetIgnore(true)
  end
end
function PaGlobal_ColorPalette_All:registEventHandler()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_ColorPalette_All_ReSizePanel")
  registerEvent("FromClient_EventRGBInfoCleared", "FromClient_ColorPalette_All_EventRGBInfoCleared")
  registerEvent("FromClient_EventRGBHistoryApplied", "FromClient_ColorPalette_All_EventRGBHistoryApplied")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ColorPalette_All_Close()")
  self._ui.stc_palette:addInputEvent("Mouse_LPress", "HandleEventLPress_ColorPalette_All_PanelPressed(" .. self._palettePanelType.hueSaturation .. ")")
  self._ui.stc_palette:addInputEvent("Mouse_LUp", "HandleEventLUp_ColorPalette_All_PanelReleased(" .. self._palettePanelType.hueSaturation .. ")")
  self._ui.stc_paletteCursor:addInputEvent("Mouse_LPress", "HandleEventLPress_ColorPalette_All_PanelPressed(" .. self._palettePanelType.hueSaturation .. ")")
  self._ui.stc_paletteCursor:addInputEvent("Mouse_LUp", "HandleEventLUp_ColorPalette_All_PanelReleased(" .. self._palettePanelType.hueSaturation .. ")")
  self._ui.stc_bright:addInputEvent("Mouse_LPress", "HandleEventLPress_ColorPalette_All_PanelPressed(" .. self._palettePanelType.lightness .. ")")
  self._ui.stc_bright:addInputEvent("Mouse_LUp", "HandleEventLUp_ColorPalette_All_PanelReleased(" .. self._palettePanelType.lightness .. ")")
  self._ui.stc_brightSlider:addInputEvent("Mouse_LPress", "HandleEventLPress_ColorPalette_All_PanelPressed(" .. self._palettePanelType.lightness .. ")")
  self._ui.stc_brightSlider:addInputEvent("Mouse_LUp", "HandleEventLUp_ColorPalette_All_PanelReleased(" .. self._palettePanelType.lightness .. ")")
  self._ui.edit_numberR:RegistAllKeyEvent("FromClient_ColorPalette_All_EditBoxChanged(" .. self._rgbType.red .. ")")
  self._ui.edit_numberG:RegistAllKeyEvent("FromClient_ColorPalette_All_EditBoxChanged(" .. self._rgbType.green .. ")")
  self._ui.edit_numberB:RegistAllKeyEvent("FromClient_ColorPalette_All_EditBoxChanged(" .. self._rgbType.blue .. ")")
  self._ui.edit_numberR:RegistReturnKeyEvent("HandleEventKey_ColorPalette_All_ApplyDecoration(" .. self._rgbType.red .. ")")
  self._ui.edit_numberG:RegistReturnKeyEvent("HandleEventKey_ColorPalette_All_ApplyDecoration(" .. self._rgbType.green .. ")")
  self._ui.edit_numberB:RegistReturnKeyEvent("HandleEventKey_ColorPalette_All_ApplyDecoration(" .. self._rgbType.blue .. ")")
end
function PaGlobal_ColorPalette_All:clear()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  self._colorValue.hue = 180
  self._colorValue.saturation = 0.5
  self._colorValue.bright = 0.5
  self._colorValue.red = 255
  self._colorValue.green = 255
  self._colorValue.blue = 255
  self._ui.edit_numberR:SetEditText(0)
  self._ui.edit_numberG:SetEditText(0)
  self._ui.edit_numberB:SetEditText(0)
  self._callerInfo.classType = nil
  self._callerInfo.paramType = nil
  self._callerInfo.paramIndex = nil
  self._lastAppliedRGBPerPartList = {}
  self._isPanelPressed = false
  self._isRGBChanged = false
end
function PaGlobal_ColorPalette_All:prepareOpen(classType, paramType, paramIndex)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if false == self._initialize then
    self:initialize()
  end
  self:clear()
  self:setDecorationPart(classType, paramType, paramIndex)
  self:update()
  PaGlobal_ColorPalette_All:open()
end
function PaGlobal_ColorPalette_All:open()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  Panel_Window_ColorPalette_All:SetShow(true)
end
function PaGlobal_ColorPalette_All:prepareClose()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if true == self._isRGBChanged then
    self:addDecorationHistory()
  end
  self:clear()
  PaGlobal_ColorPalette_All:close()
end
function PaGlobal_ColorPalette_All:close()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  Panel_Window_ColorPalette_All:SetShow(false)
end
function PaGlobal_ColorPalette_All:updateRGBText()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  self._ui.txt_textInfoR:SetText("R : " .. self._colorValue.red)
  self._ui.txt_textInfoG:SetText("G : " .. self._colorValue.green)
  self._ui.txt_textInfoB:SetText("B : " .. self._colorValue.blue)
  self._ui.edit_numberR:SetEditText(self._colorValue.red)
  self._ui.edit_numberG:SetEditText(self._colorValue.green)
  self._ui.edit_numberB:SetEditText(self._colorValue.blue)
end
function PaGlobal_ColorPalette_All:updateCursor()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  self._ui.stc_paletteCursor:SetPosX(self._ui.stc_palette:GetSizeX() * (self._colorValue.hue / 360) - self._ui.stc_paletteCursor:GetSizeX() / 2)
  self._ui.stc_paletteCursor:SetPosY(self._ui.stc_palette:GetSizeY() * (1 - self._colorValue.saturation) - self._ui.stc_paletteCursor:GetSizeY() / 2)
  self._ui.stc_brightSlider:SetPosY(self._ui.stc_bright:GetSizeY() * (1 - self._colorValue.bright) - self._ui.stc_brightSlider:GetSizeY() / 2 + self._ui.stc_bright:GetPosY())
end
function PaGlobal_ColorPalette_All:updatePaletteColor()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if 1 < self._config.brightLevelCount then
    local brightLevelSize = 1 / (self._config.brightLevelCount - 1)
    for index = 0, self._config.brightLevelCount - 1 do
      local red, green, blue = self:hslToRgb(self._colorValue.hue, self._colorValue.saturation, brightLevelSize * (self._config.brightLevelCount - 1 - index))
      self._ui.brightLevel[index]:SetColor(self:rgbToDword(red, green, blue))
    end
  end
  self._ui.stc_selectColor:SetColor(self:rgbToDword(self._colorValue.red, self._colorValue.green, self._colorValue.blue))
end
function PaGlobal_ColorPalette_All:update()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  self:updatePaletteColor()
  self:updateRGBText()
  self:updateCursor()
end
function PaGlobal_ColorPalette_All:validate()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  self._ui.btn_close:isValidate()
  self._ui.stc_title:isValidate()
  self._ui.stc_paletteBG:isValidate()
  self._ui.stc_brightBG:isValidate()
  self._ui.stc_palette:isValidate()
  self._ui.stc_bright:isValidate()
  self._ui.stc_paletteCursor:isValidate()
  self._ui.stc_brightSlider:isValidate()
  self._ui.txt_textInfoR:isValidate()
  self._ui.txt_textInfoG:isValidate()
  self._ui.txt_textInfoB:isValidate()
  self._ui.edit_numberR:isValidate()
  self._ui.edit_numberG:isValidate()
  self._ui.edit_numberB:isValidate()
end
function PaGlobal_ColorPalette_All:panelPressed(panelType)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  local isMouseOut = false
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local panelPosX = 0
  local panelSizeX = 0
  local panelPosY = 0
  local panelSizeY = 0
  local relativePosX = 0
  local relativePosY = 0
  local targetPanel
  if self._palettePanelType.hueSaturation == panelType then
    targetPanel = self._ui.stc_palette
  elseif self._palettePanelType.lightness == panelType then
    targetPanel = self._ui.stc_bright
  end
  panelPosX = targetPanel:GetParentPosX()
  panelSizeX = targetPanel:GetSizeX()
  panelPosY = targetPanel:GetParentPosY()
  panelSizeY = targetPanel:GetSizeY()
  if mousePosX < panelPosX then
    relativePosX = 0
    isMouseOut = true
  elseif mousePosX > panelPosX + panelSizeX then
    relativePosX = panelSizeX
    isMouseOut = true
  else
    relativePosX = mousePosX - panelPosX
  end
  if mousePosY < panelPosY then
    relativePosY = 0
    isMouseOut = true
  elseif mousePosY > panelPosY + panelSizeY then
    relativePosY = panelSizeY
    isMouseOut = true
  else
    relativePosY = mousePosY - panelPosY
  end
  if false == self._isPanelPressed then
    self._isPanelPressed = true
    local gap = 10
    targetPanel:SetEnableArea(-gap, -gap, panelSizeX + gap, panelSizeY + gap)
  end
  if true == isMouseOut then
    ToClient_setMousePosition(panelPosX + relativePosX, panelPosY + relativePosY)
  end
  if self._palettePanelType.hueSaturation == panelType then
    self._colorValue.hue = relativePosX / panelSizeX * 360
    self._colorValue.saturation = 1 - relativePosY / panelSizeY
  elseif self._palettePanelType.lightness == panelType then
    self._colorValue.bright = 1 - relativePosY / panelSizeY
  end
  self._colorValue.red, self._colorValue.green, self._colorValue.blue = self:hslToRgb(self._colorValue.hue, self._colorValue.saturation, self._colorValue.bright)
  self:setRGBToCharacter()
  self:update()
end
function PaGlobal_ColorPalette_All:panelReleased(panelType)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if true == self._isPanelPressed then
    self:addDecorationHistory()
    local targetPanel
    if self._palettePanelType.hueSaturation == panelType then
      self._ui.stc_palette:SetEnableArea(0, 0, self._ui.stc_palette:GetSizeX(), self._ui.stc_palette:GetSizeY())
    elseif self._palettePanelType.lightness == panelType then
      self._ui.stc_bright:SetEnableArea(0, 0, self._ui.stc_bright:GetSizeX(), self._ui.stc_bright:GetSizeY())
    end
    self._isPanelPressed = false
  end
end
function PaGlobal_ColorPalette_All:hslToRgb(hue, saturation, lightness)
  local c = (1 - math.abs(2 * lightness - 1)) * saturation
  local x = c * (1 - math.abs(hue / 60 % 2 - 1))
  local m = lightness - c / 2
  local red = 0
  local green = 0
  local blue = 0
  local hueArea = math.floor(hue / 60)
  if 0 == hueArea then
    red = c
    green = x
    blue = 0
  elseif 1 == hueArea then
    red = x
    green = c
    blue = 0
  elseif 2 == hueArea then
    red = 0
    green = c
    blue = x
  elseif 3 == hueArea then
    red = 0
    green = x
    blue = c
  elseif 4 == hueArea then
    red = x
    green = 0
    blue = c
  else
    red = c
    green = 0
    blue = x
  end
  red = math.floor((red + m) * 255 + 0.5)
  green = math.floor((green + m) * 255 + 0.5)
  blue = math.floor((blue + m) * 255 + 0.5)
  return red, green, blue
end
function PaGlobal_ColorPalette_All:rgbToHsl(red, green, blue)
  local r_ = red / 255
  local g_ = green / 255
  local b_ = blue / 255
  cMax = math.max(r_, g_, b_)
  cMin = math.min(r_, g_, b_)
  delta = cMax - cMin
  local bright = (cMax + cMin) / 2
  local saturation
  if 0 == delta then
    saturation = 0
  else
    saturation = delta / (1 - math.abs(2 * bright - 1))
  end
  local hue
  if cMax == cMin then
    hue = 0
  elseif r_ == cMax then
    hue = 60 * ((g_ - b_) / delta % 6)
  elseif g_ == cMax then
    hue = 60 * ((b_ - r_) / delta + 2)
  else
    hue = 60 * ((g_ - b_) / delta + 4)
  end
  return hue, saturation, bright
end
function PaGlobal_ColorPalette_All:rgbToDword(red, green, blue)
  local color = 255
  color = color * 256
  color = color + red
  color = color * 256
  color = color + green
  color = color * 256
  color = color + blue
  return color
end
function PaGlobal_ColorPalette_All:dwordToRGB(colorInfo)
  local blue = colorInfo % 256
  colorInfo = (colorInfo - blue) / 256
  local green = colorInfo % 256
  colorInfo = (colorInfo - green) / 256
  local red = colorInfo % 256
  return red, green, blue
end
function PaGlobal_ColorPalette_All:editBoxChanged(colorType)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if PaGlobal_ColorPalette_All._rgbType.red == colorType then
    self._colorValue.red = self:overflowCheck(tonumber(self._ui.edit_numberR:GetEditText()))
  elseif PaGlobal_ColorPalette_All._rgbType.green == colorType then
    self._colorValue.green = self:overflowCheck(tonumber(self._ui.edit_numberG:GetEditText()))
  else
    self._colorValue.blue = self:overflowCheck(tonumber(self._ui.edit_numberB:GetEditText()))
  end
  self._colorValue.hue, self._colorValue.saturation, self._colorValue.bright = self:rgbToHsl(self._colorValue.red, self._colorValue.green, self._colorValue.blue)
  self:setRGBToCharacter()
  self:update()
end
function PaGlobal_ColorPalette_All:overflowCheck(number)
  if nil == number or number < 0 then
    return 0
  elseif number > 255 then
    return 255
  else
    return number
  end
end
function PaGlobal_ColorPalette_All:setDecorationPart(classType, paramType, paramIndex)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if nil == self._lastAppliedRGBPerPartList[paramIndex] then
    local partInformation = {}
    partInformation[self._rgbType.red] = self._config.notUsedYet
    partInformation[self._rgbType.green] = self._config.notUsedYet
    partInformation[self._rgbType.blue] = self._config.notUsedYet
    self._lastAppliedRGBPerPartList[paramIndex] = partInformation
  end
  self._callerInfo.classType = classType
  self._callerInfo.paramType = paramType
  self._callerInfo.paramIndex = paramIndex
end
function PaGlobal_ColorPalette_All:checkRGBInfoDifferentWithLastHistory()
  if nil == Panel_Window_ColorPalette_All then
    return false
  end
  if nil == self._callerInfo.paramIndex then
    return false
  end
  if self._colorValue.red ~= self._lastAppliedRGBPerPartList[self._callerInfo.paramIndex][self._rgbType.red] or self._colorValue.green ~= self._lastAppliedRGBPerPartList[self._callerInfo.paramIndex][self._rgbType.green] or self._colorValue.blue ~= self._lastAppliedRGBPerPartList[self._callerInfo.paramIndex][self._rgbType.blue] then
    self._isRGBChanged = true
  else
    self._isRGBChanged = false
  end
  return self._isRGBChanged
end
function PaGlobal_ColorPalette_All:setRGBToCharacter()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if nil == setParamByRGB then
    return
  end
  if nil == self._callerInfo.paramIndex then
    return
  end
  setParamByRGB(self._callerInfo.classType, self._callerInfo.paramType, self._callerInfo.paramIndex, self:rgbToDword(self._colorValue.red, self._colorValue.green, self._colorValue.blue))
end
function PaGlobal_ColorPalette_All:addDecorationHistory()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if nil == add_CurrentHistory then
    return
  end
  if nil == self._callerInfo.paramIndex then
    return
  end
  if false == self:checkRGBInfoDifferentWithLastHistory() then
    return
  end
  self._isRGBChanged = false
  self._lastAppliedRGBPerPartList[self._callerInfo.paramIndex][self._rgbType.red] = self._colorValue.red
  self._lastAppliedRGBPerPartList[self._callerInfo.paramIndex][self._rgbType.green] = self._colorValue.green
  self._lastAppliedRGBPerPartList[self._callerInfo.paramIndex][self._rgbType.blue] = self._colorValue.blue
  add_CurrentHistory()
end
function PaGlobal_ColorPalette_All:lastAppliedRGBInformationClear()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if nil == self._callerInfo.paramIndex then
    return
  end
  self._isRGBChanged = false
  self._lastAppliedRGBPerPartList[self._callerInfo.paramIndex][self._rgbType.red] = self._config.notUsedYet
  self._lastAppliedRGBPerPartList[self._callerInfo.paramIndex][self._rgbType.green] = self._config.notUsedYet
  self._lastAppliedRGBPerPartList[self._callerInfo.paramIndex][self._rgbType.blue] = self._config.notUsedYet
end
function PaGlobal_ColorPalette_All:applyEditBoxRGBToCharacter(colorType)
  if true == PaGlobal_ColorPalette_All:checkRGBInfoDifferentWithLastHistory() then
    PaGlobal_ColorPalette_All:setRGBToCharacter()
    PaGlobal_ColorPalette_All:addDecorationHistory()
  end
end
function PaGlobal_ColorPalette_All:rgbHistoryApplied(paramIndex, colorInfo)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if nil == self._callerInfo.paramIndex then
    return
  end
  if nil == paramIndex then
    return
  end
  local red, green, blue = self:dwordToRGB(colorInfo)
  self._isRGBChanged = false
  self._lastAppliedRGBPerPartList[paramIndex][self._rgbType.red] = red
  self._lastAppliedRGBPerPartList[paramIndex][self._rgbType.green] = green
  self._lastAppliedRGBPerPartList[paramIndex][self._rgbType.blue] = blue
  if paramIndex == self._callerInfo.paramIndex then
    self._colorValue.red = red
    self._colorValue.green = green
    self._colorValue.blue = blue
    self._colorValue.hue, self._colorValue.saturation, self._colorValue.bright = self:rgbToHsl(self._colorValue.red, self._colorValue.green, self._colorValue.blue)
    self:update()
  end
end
