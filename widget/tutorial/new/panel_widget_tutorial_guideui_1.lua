function PaGlobal_Widget_Tutorial_GuideUI:initialize()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:createBlackSpirit()
  self:createEffectList()
  self:createWhiteBGList()
  self:createBlackBGList()
  self:validate()
  self:registerEvent()
  self:resizePanel()
  Panel_Widget_Tutorial_GuideUI:SetChildIndex(self._ui._stc_blackSpritInfo.parent, 9999)
  self._initialize = true
end
function PaGlobal_Widget_Tutorial_GuideUI:initClear()
  self._ui._stc_blackSpritInfo:SetShow(false)
  self._ui._stc_image:SetShow(false)
  self:clearEffectList()
  self:hideAllBlackBG()
end
function PaGlobal_Widget_Tutorial_GuideUI:destroyClear()
  self:clearEffectList()
  self:hideAllBlackBG()
end
function PaGlobal_Widget_Tutorial_GuideUI:clearEffectList()
  self._effectInfo:clear()
end
function PaGlobal_Widget_Tutorial_GuideUI:hideAllBlackBG()
  for _, control in pairs(self._blackBGList) do
    control:SetShow(false)
  end
end
function PaGlobal_Widget_Tutorial_GuideUI:hideAllWhiteBG()
  for _, control in pairs(self._whiteBGList) do
    control:SetShow(false)
  end
end
function PaGlobal_Widget_Tutorial_GuideUI:prepareOpen()
  self:open()
end
function PaGlobal_Widget_Tutorial_GuideUI:open()
  if false == self._initialize then
    return
  end
  if false == _ContentsGroup_NewTutorial then
    return
  end
  local progressingWrapper = ToClient_getProgressingTutorialWrapper()
  if nil == progressingWrapper then
    return
  end
  if true == progressingWrapper:isComplete() then
    return
  end
  local key = progressingWrapper:getKey()
  local tutorialSSW = ToClient_getTutorialStaticStatusWrapper(key)
  if nil == tutorialSSW then
    return
  end
  self:initClear()
  self:startEvent(tutorialSSW)
  self:updateDescPosition(tutorialSSW)
  SetUIMode(Defines.UIMode.eUIMode_Tutorial)
  Panel_Widget_Tutorial_GuideUI:RegisterUpdateFunc("PaGlobalFunc_Widget_Tutorial_GuideUI_Update")
  Panel_Widget_Tutorial_GuideUI:SetShow(true)
  if true == progressingWrapper:isNotInput() then
    ToClient_uiManagerSetUIConvertableState(CppEnums.UIConvertableType.eUIConvertableType_always, true)
    ToClient_uiManagerSetConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_UiModeNotInput)
  else
    ToClient_uiManagerSetUIConvertableState(CppEnums.UIConvertableType.eUIConvertableType_always, false)
    ToClient_uiManagerSetConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_UiMode)
  end
end
function PaGlobal_Widget_Tutorial_GuideUI:prepareClose()
  self:close()
end
function PaGlobal_Widget_Tutorial_GuideUI:close()
  SetUIMode(Defines.UIMode.eUIMode_Default)
  Panel_Widget_Tutorial_GuideUI:ClearUpdateLuaFunc()
  Panel_Widget_Tutorial_GuideUI:SetShow(false)
end
function PaGlobal_Widget_Tutorial_GuideUI:validate()
  self._ui._stc_image:isValidate()
end
function PaGlobal_Widget_Tutorial_GuideUI:registerEvent()
  self._ui._btn_skip:addInputEvent("Mouse_LUp", "PaGlobal_Widget_Tutorial_GuideUI:doSkip()")
  registerEvent("FromClient_changePanelSetShow", "FromClient_changePanelSetShow")
  registerEvent("FromClient_uiBaseInputEventType", "FromClient_uiBaseInputEventType")
  registerEvent("FromClient_updateProgressingTutorial", "FromClient_updateProgressingTutorial")
  registerEvent("FromClient_initProgressingTutorial", "FromClient_initProgressingTutorial")
  registerEvent("FromClient_clearProgressingTutorial", "FromClient_clearProgressingTutorial")
end
function PaGlobal_Widget_Tutorial_GuideUI:update()
end
function PaGlobal_Widget_Tutorial_GuideUI:complete(key)
  local index = key:getIndex()
  local nextKey = TutorialKey(key:getType(), index + 1)
  local nextWrapper = ToClient_getTutorialStaticStatusWrapper(nextKey)
  self:destroyClear()
  if nil ~= nextWrapper then
    ToClient_setProgressingTutorial(nextKey:getType(), nextKey:getIndex())
  else
    ToClient_requestCompleteTutorial()
  end
end
function PaGlobal_Widget_Tutorial_GuideUI:resizePanel()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  Panel_Widget_Tutorial_GuideUI:SetSize(screenSizeX, screenSizeY)
  Panel_Widget_Tutorial_GuideUI:ComputePosAllChild()
end
function PaGlobal_Widget_Tutorial_GuideUI:createBlackSpirit()
  local blackSpritInfo = {
    parent = nil,
    stc_bg = nil,
    txt_title = nil,
    txt_desc = nil,
    txt_next = nil
  }
  function blackSpritInfo:SetShow(isShow)
    blackSpritInfo.parent:SetShow(isShow)
  end
  function blackSpritInfo:SetTitle(txt)
    blackSpritInfo.txt_title:SetText(tostring(txt))
  end
  function blackSpritInfo:SetDesc(txt)
    blackSpritInfo.txt_desc:SetText(tostring(txt))
    local sizeX = blackSpritInfo.txt_desc:GetTextSizeX()
    blackSpritInfo.stc_bg:SetSize(sizeX + 200, blackSpritInfo.stc_bg:GetSizeY())
    blackSpritInfo.stc_bg:ComputePosAllChild()
  end
  local parent = UI.getChildControl(Panel_Widget_Tutorial_GuideUI, "Static_Desc")
  local stc_bg = UI.getChildControl(parent, "Static_BG")
  local txt_title = UI.getChildControl(stc_bg, "StaticText_Title")
  local txt_desc = UI.getChildControl(stc_bg, "StaticText_Desc")
  local txt_next = UI.getChildControl(stc_bg, "StaticText_Next")
  parent:SetIgnoreChild(true)
  parent:isValidate()
  stc_bg:isValidate()
  txt_title:isValidate()
  txt_desc:isValidate()
  txt_next:isValidate()
  blackSpritInfo.parent = parent
  blackSpritInfo.stc_bg = stc_bg
  blackSpritInfo.txt_title = txt_title
  blackSpritInfo.txt_desc = txt_desc
  blackSpritInfo.txt_next = txt_next
  self._ui._stc_blackSpritInfo = blackSpritInfo
  self._ui._btn_skip = UI.getChildControl(parent, "Button_Skip")
  self._ui._btn_skip:isValidate()
  self._ui._btn_skip:SetIgnore(false)
end
function PaGlobal_Widget_Tutorial_GuideUI:createEffectList()
  local baseControl = UI.getChildControl(Panel_PadSnapTargetEffect, "Static_SnapHighlight")
  local info = {
    control = nil,
    targetControl = nil,
    isLoop = true,
    sinCurveTheta = 0,
    speed = 2
  }
  function info:isDefined()
    if nil ~= self.targetControl then
      if true == self.targetControl:GetParentPanel():GetShow() then
        return true
      else
        self.control:SetShow(false)
        return false
      end
    end
    return false
  end
  function info:clear()
    self.control:SetShow(false)
    self.sinCurveTheta = 0
    if nil ~= self.targetControl then
      self.targetControl:ToggleMouseEventEffect(false)
      self.targetControl:ActiveMouseEventEffect(false)
    end
    self.targetControl = nil
  end
  function info:setTargetControl(control)
    self:clear()
    if nil ~= control then
      control:ToggleMouseEventEffect(true)
      control:ActiveMouseEventEffect(true)
      self.targetControl = control
    end
  end
  function info:update(deltaTime)
    if false == self:isDefined() then
      return
    end
    local value = math.sin(self.sinCurveTheta)
    local adjustedValue = value * 15
    self.control:SetSize(self.targetControl:GetSizeX() + 9 + adjustedValue * 2, self.targetControl:GetSizeY() + 9 + adjustedValue * 2)
    self.control:SetPosX(self.targetControl:GetParentPosX() - 4 - adjustedValue)
    self.control:SetPosY(self.targetControl:GetParentPosY() - 4 - adjustedValue)
    self.control:SetAlpha(1 - value)
    self.sinCurveTheta = self.sinCurveTheta + deltaTime * self.speed
    self.control:SetShow(true)
    if math.pi * 0.5 < self.sinCurveTheta then
      if true == self.isLoop then
        self.sinCurveTheta = 0
      else
        self:clear()
      end
    end
  end
  local control = UI.cloneControl(baseControl, Panel_Widget_Tutorial_GuideUI, "EffectControl_" .. tostring(ii))
  control:isValidate()
  info.control = control
  self._effectInfo = info
end
function PaGlobal_Widget_Tutorial_GuideUI:createBlackBGList()
  local baseControl = UI.getChildControl(Panel_Widget_Tutorial_GuideUI, "Static_BackImage_Grid")
  baseControl:SetShow(false)
  for key, _ in pairs(self._blackBGList) do
    local control = UI.cloneControl(baseControl, Panel_Widget_Tutorial_GuideUI, "BlackBG_" .. tostring(key))
    control:isValidate()
    control:SetIgnore(false)
    self._blackBGList[key] = control
  end
  UI.deleteControl(baseControl)
end
function PaGlobal_Widget_Tutorial_GuideUI:createWhiteBGList()
  local baseControl = UI.getChildControl(Panel_Widget_Tutorial_GuideUI, "Static_WhiteBG_Grid")
  baseControl:SetShow(false)
  for key, _ in pairs(self._whiteBGList) do
    local control = UI.cloneControl(baseControl, Panel_Widget_Tutorial_GuideUI, "WhiteBG_" .. tostring(key))
    control:isValidate()
    control:SetIgnore(false)
    self._whiteBGList[key] = control
  end
  UI.deleteControl(baseControl)
end
function PaGlobal_Widget_Tutorial_GuideUI:startEvent(tutorialSSW)
  _PA_ASSERT(nil ~= tutorialSSW, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
  for ii = 0, tutorialSSW:getStartEventCount() - 1 do
    local eventKey = tutorialSSW:getStartEventKey(ii)
    self:startEvent__XXX(eventKey)
  end
end
function PaGlobal_Widget_Tutorial_GuideUI:startEvent__XXX(eventKey)
  if false == eventKey:isDefined() then
    return
  end
  local startEventSSW = ToClient_getTutorialStartEventStaticStatusWrapper(eventKey)
  if nil == startEventSSW then
    return
  end
  local findControl
  local itemEnchantKey = startEventSSW:getItemEnchantKey()
  local itemName = ""
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if nil ~= itemSSW then
    itemName = itemSSW:getName()
  end
  if false == self._isConsole then
    PaGlobal_Inventory_All._ui.edit_search:SetEditText(itemName)
    PaGlobal_Inventory_All:searchItem()
    local slot = PaGlobal_Inventory_All._findResultSlots[1]
    if nil ~= slot then
      findControl = slot.icon
    end
  else
  end
  _PA_LOG("\235\176\149\234\183\156\235\130\152", "findControl = " .. tostring(findControl) .. ", eventKey = " .. tostring(eventKey:get()))
  local useBlackBG = startEventSSW:getUseBlackBG()
  local useWhiteBG = startEventSSW:getUseWhiteBG()
  local snappingEffectOn = startEventSSW:getSnappingEffectOn()
  ToClient_tutorialStartEventDoLua(eventKey)
  if true == useBlackBG then
    local panelID = startEventSSW:getBlackPanel()
    local childID = startEventSSW:getBlackChildControl()
    local findIndex = startEventSSW:getBlackChildControlIndex()
    local offset = startEventSSW:getBlackOffset()
    local panel = ToClient_getPanelByKey(panelID)
    local pos = float2(0, 0)
    local size = float2(0, 0)
    local isShow = true
    if nil ~= panel then
      local control
      if 0 == childID then
        control = panel
      else
        control = panel:FindControlByIndex(childID, findIndex)
      end
      if nil ~= control then
        pos.x = control:GetParentPosX()
        pos.y = control:GetParentPosY()
        size.x = control:GetSizeX()
        size.y = control:GetSizeY()
        isShow = false
      end
    end
    self:updateBlackBG__XXX(pos, size, offset, isShow)
  end
  if true == useWhiteBG then
    local pos = float2(0, 0)
    local size = float2(0, 0)
    local offset = startEventSSW:getWhiteOffset()
    local isIgnore = startEventSSW:getWhiteIgnore()
    if nil ~= findControl then
      pos.x = findControl:GetParentPosX()
      pos.y = findControl:GetParentPosY()
      size.x = findControl:GetSizeX()
      size.y = findControl:GetSizeY()
    else
      local panelID = startEventSSW:getWhitePanel()
      local childID = startEventSSW:getWhiteChildControl()
      local childIndex = startEventSSW:getWhiteChildControlIndex()
      local panel = ToClient_getPanelByKey(panelID)
      if nil ~= panel then
        local control
        if 0 == childID then
          control = panel
        else
          control = panel:FindControlByIndex(childID, findIndex)
        end
        if nil ~= control then
          pos.x = control:GetParentPosX()
          pos.y = control:GetParentPosY()
          size.x = control:GetSizeX()
          size.y = control:GetSizeY()
          findControl = control
        end
      end
    end
    local isShow = isIgnore == false
    self:updateWhiteBG__XXX(pos, size, offset, isShow)
  end
  if nil ~= findControl and true == snappingEffectOn then
    self._effectInfo:setTargetControl(findControl)
  end
end
function PaGlobal_Widget_Tutorial_GuideUI:updateBlackBG__XXX(pos, size, offset, isShow)
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local initPosX = pos.x - offset.x
  local initPosY = pos.y - offset.y
  local width = size.x + offset.x * 2
  local height = size.y + offset.y * 2
  self._blackBGList.LT:SetPosX(0)
  self._blackBGList.LT:SetPosY(0)
  self._blackBGList.LT:SetSize(initPosX, initPosY)
  self._blackBGList.LT:SetShow(true)
  self._blackBGList.CT:SetPosX(initPosX)
  self._blackBGList.CT:SetPosY(0)
  self._blackBGList.CT:SetSize(width, initPosY)
  self._blackBGList.CT:SetShow(true)
  self._blackBGList.RT:SetPosX(initPosX + width)
  self._blackBGList.RT:SetPosY(0)
  self._blackBGList.RT:SetSize(screenSizeX - (initPosX + width), initPosY)
  self._blackBGList.RT:SetShow(true)
  self._blackBGList.RC:SetPosX(initPosX + width)
  self._blackBGList.RC:SetPosY(initPosY)
  self._blackBGList.RC:SetSize(screenSizeX - (initPosX + width), height)
  self._blackBGList.RC:SetShow(true)
  self._blackBGList.RB:SetPosX(initPosX + width)
  self._blackBGList.RB:SetPosY(initPosY + height)
  self._blackBGList.RB:SetSize(screenSizeX - (initPosX + width), screenSizeY - (initPosY + height))
  self._blackBGList.RB:SetShow(true)
  self._blackBGList.CB:SetPosX(initPosX)
  self._blackBGList.CB:SetPosY(initPosY + height)
  self._blackBGList.CB:SetSize(width, screenSizeY - (initPosY + height))
  self._blackBGList.CB:SetShow(true)
  self._blackBGList.LB:SetPosX(0)
  self._blackBGList.LB:SetPosY(initPosY + height)
  self._blackBGList.LB:SetSize(initPosX, screenSizeY - (initPosY + height))
  self._blackBGList.LB:SetShow(true)
  self._blackBGList.LC:SetPosX(0)
  self._blackBGList.LC:SetPosY(initPosY)
  self._blackBGList.LC:SetSize(initPosX, height)
  self._blackBGList.LC:SetShow(true)
  self._blackBGList.CC:SetPosX(initPosX)
  self._blackBGList.CC:SetPosY(initPosY)
  self._blackBGList.CC:SetSize(width, height)
  self._blackBGList.CC:SetShow(isShow)
end
function PaGlobal_Widget_Tutorial_GuideUI:updateWhiteBG__XXX(pos, size, offset, isShow)
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local initPosX = pos.x - offset.x
  local initPosY = pos.y - offset.y
  local width = size.x + offset.x * 2
  local height = size.y + offset.y * 2
  self._whiteBGList.LT:SetPosX(0)
  self._whiteBGList.LT:SetPosY(0)
  self._whiteBGList.LT:SetSize(initPosX, initPosY)
  self._whiteBGList.LT:SetShow(true)
  self._whiteBGList.CT:SetPosX(initPosX)
  self._whiteBGList.CT:SetPosY(0)
  self._whiteBGList.CT:SetSize(width, initPosY)
  self._whiteBGList.CT:SetShow(true)
  self._whiteBGList.RT:SetPosX(initPosX + width)
  self._whiteBGList.RT:SetPosY(0)
  self._whiteBGList.RT:SetSize(screenSizeX - (initPosX + width), initPosY)
  self._whiteBGList.RT:SetShow(true)
  self._whiteBGList.RC:SetPosX(initPosX + width)
  self._whiteBGList.RC:SetPosY(initPosY)
  self._whiteBGList.RC:SetSize(screenSizeX - (initPosX + width), height)
  self._whiteBGList.RC:SetShow(true)
  self._whiteBGList.RB:SetPosX(initPosX + width)
  self._whiteBGList.RB:SetPosY(initPosY + height)
  self._whiteBGList.RB:SetSize(screenSizeX - (initPosX + width), screenSizeY - (initPosY + height))
  self._whiteBGList.RB:SetShow(true)
  self._whiteBGList.CB:SetPosX(initPosX)
  self._whiteBGList.CB:SetPosY(initPosY + height)
  self._whiteBGList.CB:SetSize(width, screenSizeY - (initPosY + height))
  self._whiteBGList.CB:SetShow(true)
  self._whiteBGList.LB:SetPosX(0)
  self._whiteBGList.LB:SetPosY(initPosY + height)
  self._whiteBGList.LB:SetSize(initPosX, screenSizeY - (initPosY + height))
  self._whiteBGList.LB:SetShow(true)
  self._whiteBGList.LC:SetPosX(0)
  self._whiteBGList.LC:SetPosY(initPosY)
  self._whiteBGList.LC:SetSize(initPosX, height)
  self._whiteBGList.LC:SetShow(true)
  self._whiteBGList.CC:SetPosX(initPosX)
  self._whiteBGList.CC:SetPosY(initPosY)
  self._whiteBGList.CC:SetSize(width, height)
  self._whiteBGList.CC:SetShow(isShow)
end
function PaGlobal_Widget_Tutorial_GuideUI:updateDescPosition(tutorialSSW)
  _PA_ASSERT(nil ~= tutorialSSW, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
  self._ui._stc_blackSpritInfo:SetTitle(tutorialSSW:getTitle())
  self._ui._stc_blackSpritInfo:SetDesc(tutorialSSW:getDesc())
  local control = self._ui._stc_blackSpritInfo.parent
  local pan = tutorialSSW:getPan()
  local pos = tutorialSSW:getPos()
  local result = float2(0, 0)
  local panel = ToClient_getPanelByKey(tutorialSSW:getBasePosPanelID())
  if nil ~= panel then
    if true == tutorialSSW:isAttr(__eTutorialAttrPos_Center) then
      result.x = pan.x + (panel:getSizeX() - control:GetSizeX()) * 0.5
    elseif true == tutorialSSW:isAttr(__eTutorialAttrPos_Right) then
      result.x = -pan.x + (panel:getSizeX() - control:GetSizeX())
    elseif true == tutorialSSW:isAttr(__eTutorialAttrPos_Left) then
      result.x = pan.x
    else
      result.x = panel:GetPosX() + pos.x
    end
    if true == tutorialSSW:isAttr(__eTutorialAttrPos_Middle) then
      result.y = pan.y + (panel:getSizeY() - control:GetSizeY()) * 0.5
    elseif true == tutorialSSW:isAttr(__eTutorialAttrPos_Bottom) then
      result.y = -pan.y + (panel:getSizeY() - control:GetSizeY())
    elseif true == tutorialSSW:isAttr(__eTutorialAttrPos_Top) then
      result.y = pan.y
    else
      result.y = panel:GetPosY() + pos.y
    end
  else
    if true == tutorialSSW:isAttr(__eTutorialAttrPos_Center) then
      result.x = pan.x + (getScreenSizeX() - control:GetSizeX()) * 0.5
    elseif true == tutorialSSW:isAttr(__eTutorialAttrPos_Right) then
      result.x = -pan.x + (getScreenSizeX() - control:GetSizeX())
    elseif true == tutorialSSW:isAttr(__eTutorialAttrPos_Left) then
      result.x = pan.x
    else
      result.x = pos.x
    end
    if true == tutorialSSW:isAttr(__eTutorialAttrPos_Middle) then
      result.y = pan.y + (getScreenSizeY() - control:GetSizeY()) * 0.5
    elseif true == tutorialSSW:isAttr(__eTutorialAttrPos_Bottom) then
      result.y = -pan.y + (getScreenSizeY() - control:GetSizeY())
    elseif true == tutorialSSW:isAttr(__eTutorialAttrPos_Top) then
      result.y = pan.y
    else
      result.y = pos.y
    end
  end
  control:SetPosX(result.x)
  control:SetPosY(result.y)
  control:SetShow(true)
  local imagePath = tutorialSSW:getImagePath()
  if "" ~= imagePath then
    self._ui._stc_image:SetPosX(result.x)
    self._ui._stc_image:SetPosY(result.y + control:GetSizeY() + 5)
    self._ui._stc_image:ChangeTextureInfoName(imagePath)
    self._ui._stc_image:SetShow(true)
  else
    self._ui._stc_image:SetShow(false)
  end
  self._ui._btn_skip:SetShow(tutorialSSW:isUseSkip())
end
function PaGlobal_Widget_Tutorial_GuideUI:isKeyDown_Once()
  if true == self._isConsole then
    for key, value in pairs(self._joyPadKey) do
      if true == isPadDown(value) then
        return value
      end
    end
  else
    for key, value in pairs(CppEnums.VirtualKeyCode) do
      if true == isKeyDown_Once(value) then
        return value
      end
    end
  end
  return nil
end
function PaGlobal_Widget_Tutorial_GuideUI:doSkip()
  ToClient_requestCompleteTutorial()
end
