function PaGlobal_Widget_HotDeal_All:initialize()
  if nil == Panel_Widget_HotDeal_All or true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._btn_deal = UI.getChildControl(Panel_Widget_HotDeal_All, "Button_Deal")
  self._ui._stc_image = UI.getChildControl(Panel_Widget_HotDeal_All, "Static_Image")
  self._ui._txt_title = UI.getChildControl(Panel_Widget_HotDeal_All, "StaticText_Title")
  self._ui._stc_timeBg = UI.getChildControl(Panel_Widget_HotDeal_All, "Static_Time_BG")
  self._ui._txt_time = UI.getChildControl(self._ui._stc_timeBg, "StaticText_Time")
  self._ui._stc_clockIcon = UI.getChildControl(self._ui._stc_timeBg, "Static_Clock_Icon")
  self:validate()
  self:registEventHandler()
  self:clear()
  if true == self:update() then
    self:prepareOpen()
  end
  self._initialize = true
end
function PaGlobal_Widget_HotDeal_All:registEventHandler()
  if nil == Panel_Widget_HotDeal_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Widget_HotDeal_All_OnResize")
  registerEvent("FromClient_ChangeHotDealUIOpen", "FromClient_Widget_HotDeal_All_SetNpcPosition")
  registerEvent("FromClient_updateLimitedSalesProduct", "FromClient_Widget_HotDeal_All_Update")
  self._ui._stc_image:addInputEvent("Mouse_RUp", "HandleEventRUp_Widget_HotDeal_All_updateNavigation()")
end
function PaGlobal_Widget_HotDeal_All:prepareOpen()
  if nil == Panel_Widget_HotDeal_All or true == Panel_Widget_HotDeal_All:GetShow() then
    return
  end
  if false == _ContentsGroup_HotDeal_All then
    return
  end
  self:clear()
  self:resize()
  Panel_Widget_HotDeal_All:RegisterUpdateFunc("PaGlobal_Widget_HotDeal_All_UpdatePerFrame")
  self:open()
end
function PaGlobal_Widget_HotDeal_All:open()
  if nil == Panel_Widget_HotDeal_All then
    return
  end
  Panel_Widget_HotDeal_All:SetShow(true)
end
function PaGlobal_Widget_HotDeal_All:prepareClose()
  if nil == Panel_Widget_HotDeal_All or false == Panel_Widget_HotDeal_All:GetShow() then
    return
  end
  self:clear()
  self:close()
end
function PaGlobal_Widget_HotDeal_All:close()
  if nil == Panel_Widget_HotDeal_All then
    return
  end
  Panel_Widget_HotDeal_All:SetShow(false)
end
function PaGlobal_Widget_HotDeal_All:clear()
  if nil ~= Panel_Widget_HotDeal_All then
    Panel_Widget_HotDeal_All:ClearUpdateLuaFunc()
  end
  self._curUpdateTime = 0
  self._curEffectTime = self._maxEffectTime
  self._isTimeTextRedColor = false
  self._lastReminedTime = 0
  self._ui._stc_image:EraseAllEffect()
end
function PaGlobal_Widget_HotDeal_All:update()
  if nil == Panel_Widget_HotDeal_All then
    return false
  end
  local limitedSalesProductCount = ToClient_getLimitedSalesProductCount()
  if limitedSalesProductCount <= 0 then
    return false
  end
  local limitedSalesProduct = ToClient_getStartLimitedSalesProduct()
  if nil == limitedSalesProduct then
    return false
  end
  local currentTime = getServerUtc64()
  local startTime = limitedSalesProduct:getSalesStartPeriodDate()
  local endTime = limitedSalesProduct:getSalesEndPeriodDate()
  if currentTime < startTime or currentTime >= endTime then
    return false
  end
  self._salesStartTime = startTime
  self._salesEndTime = endTime
  self:updateReminedTime()
  return true
end
function PaGlobal_Widget_HotDeal_All:updateReminedTime()
  local currentTime = getServerUtc64()
  local reminedTime = Int64toInt32(self._salesEndTime - currentTime)
  if reminedTime > 0 then
    local hour = reminedTime / 3600
    local min = reminedTime % 3600 / 60
    local sec = reminedTime % 3600 % 60
    local timeText = tostring(math.floor(hour / 10)) .. tostring(math.floor(hour % 10)) .. ":" .. tostring(math.floor(min / 10)) .. tostring(math.floor(min % 10)) .. ":" .. tostring(math.floor(sec / 10)) .. tostring(math.floor(sec % 10))
    if reminedTime < 60 then
      if self._lastReminedTime ~= reminedTime then
        self._isTimeTextRedColor = false
        self._curEffectTime = 0
        self._lastReminedTime = reminedTime
      elseif true == self._isTimeTextRedColor then
        timeText = "<PAColor0xffb82929>" .. timeText .. "<PAOldColor>"
      end
    else
      self._isTimeTextRedColor = false
    end
    self._ui._txt_time:SetText(timeText)
  else
    self._ui._txt_time:SetText("00:00:00")
    PaGlobalFunc_Widget_HotDeal_All_Close()
  end
  return reminedTime
end
function PaGlobal_Widget_HotDeal_All:resize()
  if nil == Panel_Widget_HotDeal_All then
    return
  end
  local radarGapX = 0
  if nil ~= FGlobal_Panel_Radar_GetSizeX then
    radarGapX = FGlobal_Panel_Radar_GetSizeX()
  end
  Panel_Widget_HotDeal_All:SetPosX(getScreenSizeX() - Panel_Widget_HotDeal_All:GetSizeX() - radarGapX - 15)
  local tempPanelGapY = 180
  Panel_Widget_HotDeal_All:SetPosY(tempPanelGapY)
end
function PaGlobal_Widget_HotDeal_All:validate()
  if nil == Panel_Widget_HotDeal_All then
    return
  end
  self._ui._btn_deal:isValidate()
  self._ui._stc_image:isValidate()
  self._ui._txt_title:isValidate()
  self._ui._stc_timeBg:isValidate()
  self._ui._txt_time:isValidate()
  self._ui._stc_clockIcon:isValidate()
end
