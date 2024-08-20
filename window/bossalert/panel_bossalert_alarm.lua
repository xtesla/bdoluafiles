Panel_BossAlertV2:SetShow(false)
local PaGlobal_BossAlert = {
  _ui = {
    _bg = UI.getChildControl(Panel_BossAlertV2, "Static_Bg"),
    _date = UI.getChildControl(Panel_BossAlertV2, "StaticText_Date"),
    _desc = UI.getChildControl(Panel_BossAlertV2, "StaticText_Desc"),
    _itemSlotBg = UI.getChildControl(Panel_BossAlertV2, "Static_Slot_IconBG"),
    _itemSlot = UI.getChildControl(Panel_BossAlertV2, "Static_Slot_Icon"),
    _closeIcon = UI.getChildControl(Panel_BossAlertV2, "Button_Win_Close")
  },
  _aniTime = 0,
  _maxTime = 10,
  _lastMaxTime = 600,
  _lastMinute = 0,
  _beforeDescSpanY = 0,
  updateTime = 0
}
function PaGlobal_BossAlert:Init()
  self._ui._desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._date:SetTextMode(__eTextMode_AutoWrap)
  self._beforeDescSpanY = self._ui._desc:GetSpanSize().y
  if false == _ContentsGroup_NewUI_BossAlert_SettingV2_All then
    self._ui._bg:addInputEvent("Mouse_LUp", "PaGlobal_BossAlertSet_Show()")
  else
    self._ui._bg:addInputEvent("Mouse_LUp", "PaGlobal_BossAlert_NewAlarmClose()")
  end
  self._ui._closeIcon:addInputEvent("Mouse_LUp", "PaGlobal_BossAlert_NewAlarmClose()")
  Panel_BossAlertV2:RegisterUpdateFunc("UpdateFunc_checkBossAlramAnimation")
  if true == ToClient_isConsole() or true == ToClient_isUsePadSnapping() then
    self._ui._closeIcon:SetShow(false)
    self._ui._bg:SetIgnore(true)
    Panel_BossAlertV2:SetIgnore(true)
  end
end
function PaGlobal_BossAlert:ShowAni()
  local posY = 45
  if Panel_ItemMarket_NewAlarm:GetShow() then
    if true == _ContentsGroup_RemasterUI_Main_Alert and FGlobal_AlertMsgBg_ShowCheck() then
      posY = 205
    else
      posY = 130
    end
  elseif true == _ContentsGroup_RemasterUI_Main_Alert and FGlobal_AlertMsgBg_ShowCheck() then
    posY = 120
  end
  local alarmMoveAni1 = Panel_BossAlertV2:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  alarmMoveAni1:SetStartPosition(getScreenSizeX() + 10, getScreenSizeY() - Panel_BossAlertV2:GetSizeY() - posY)
  alarmMoveAni1:SetEndPosition(getScreenSizeX() - Panel_BossAlertV2:GetSizeX() - 5, getScreenSizeY() - Panel_BossAlertV2:GetSizeY() - posY)
  alarmMoveAni1.IsChangeChild = true
  Panel_BossAlertV2:CalcUIAniPos(alarmMoveAni1)
  alarmMoveAni1:SetDisableWhileAni(true)
  audioPostEvent_SystemUi(19, 50)
  _AudioPostEvent_SystemUiForXBOX(19, 50)
end
function PaGlobal_BossAlert:HideAni()
  local alarmMoveAni2 = Panel_BossAlertV2:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  alarmMoveAni2:SetStartPosition(Panel_BossAlertV2:GetPosX(), Panel_BossAlertV2:GetPosY())
  alarmMoveAni2:SetEndPosition(getScreenSizeX() + 10, Panel_BossAlertV2:GetPosY())
  alarmMoveAni2.IsChangeChild = true
  Panel_BossAlertV2:CalcUIAniPos(alarmMoveAni2)
  alarmMoveAni2:SetDisableWhileAni(true)
  alarmMoveAni2:SetHideAtEnd(true)
  alarmMoveAni2:SetDisableWhileAni(true)
  Panel_Tooltip_Item_hideTooltip()
end
function FGlobal_BossAlertMsg_ResetPos(alertShow, marketAlertShow, alertType)
  if not Panel_BossAlertV2:GetShow() then
    return
  end
  local posY, startTime, endTime = 45, 0, 0.1
  if marketAlertShow then
    if alertShow then
      posY = 205
    else
      posY = 130
    end
  elseif alertShow then
    posY = 120
  end
  if 0 == alertType then
    if not alertShow then
      startTime, endTime = 0.3, 0.4
    end
  elseif 1 == alertType then
    if not marketAlertShow then
      startTime, endTime = 0.3, 0.4
    end
  else
    return
  end
  local alarmMoveAni3 = Panel_BossAlertV2:addMoveAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  alarmMoveAni3:SetStartPosition(Panel_BossAlertV2:GetPosX(), Panel_BossAlertV2:GetPosY())
  alarmMoveAni3:SetEndPosition(Panel_BossAlertV2:GetPosX(), getScreenSizeY() - Panel_BossAlertV2:GetSizeY() - posY)
  alarmMoveAni3.IsChangeChild = true
  Panel_BossAlertV2:CalcUIAniPos(alarmMoveAni3)
  alarmMoveAni3:SetDisableWhileAni(true)
end
local inconunt = 0
function PaGlobal_BossAlert_NewAlarmShow(deltaTime)
  if false == _ContentsGroup_NewUI_BossAlert_SettingV2_All then
    if false == PaGlobal_BossAlertSet_GetIsShowBossAlert() then
      return
    end
  elseif false == PaGlobal_BossAlert_SettingV2_All_GetIsShowBossAlert() then
    return
  end
  local self = PaGlobal_BossAlert
  self.updateTime = self.updateTime + deltaTime
  if self.updateTime < 60 then
    return
  end
  if false == _ContentsGroup_NewUI_BossAlert_SettingV2_All then
    PaGlobal_BossAlertSet_ReturnTimeAfterAlertEnd()
  else
    PaGlobal_BossAlert_SettingV2_All_ReturnTimeAfterAlertEnd()
  end
  self.updateTime = 0
  local bossTime = 0
  local bossName = ""
  local lastMinute = 0
  if false == _ContentsGroup_UseDataBossAlert then
    if false == _ContentsGroup_NewUI_BossAlert_SettingV2_All then
      bossTime, bossName, lastMinute = PaGlobal_BossAlertSet_ReturnTimeBeforeAlert()
    else
      bossTime, bossName, lastMinute = PaGlobal_BossAlert_SettingV2_All_ReturnTimeBeforeAlert()
    end
  else
    local count = ToClient_getBossAlertCount()
    if 0 == count then
      return
    end
    for ii = 1, count do
      local characterKey = ToClient_getAlertBossKeyByIndex(ii - 1)
      local characterWarpper = getCharacterStaticStatusWarpper(characterKey)
      if nil == characterWarpper then
        return
      end
      if 1 ~= ii then
        bossName = bossName .. ", " .. characterWarpper:getName()
      else
        bossName = characterWarpper:getName()
      end
    end
    lastMinute = ToClient_getAlertBossTime()
    if false == PaGlobal_BossAlert_SettingV2_All_CheckAlertSetting(lastMinute) then
      return
    end
    bossTime = PAGetString(Defines.StringSheet_GAME, "LUA_BOSSALERT_SETTING_BEFORE" .. lastMinute)
  end
  if "unknown" == bossTime or "" == bossName then
    return
  end
  local paTime = ToClient_GetServerLocalTime()
  local isYear = tostring(paTime:GetYear())
  local isMonth = tostring(paTime:GetMonth())
  local isDay = tostring(paTime:GetDay())
  local isHour = tostring(paTime:GetHour())
  if 0 == paTime:GetHour() then
    isHour = "00"
  end
  local isMinute = tostring(paTime:GetMinute())
  if 0 == paTime:GetMinute() then
    isMinute = "00"
  end
  self._lastMinute = lastMinute
  if 0 == lastMinute then
    self._ui._date:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BOSSALERT_ALARM_NAME", "bossName", tostring(bossName)))
  else
    local timeString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BOSSALERT_ALARM_NAME_TIME", "bossName", tostring(bossName), "bossTime", tostring(bossTime))
    self._ui._date:SetText(timeString)
  end
  local curTimeString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_BOSSALERT_ALARM_DATE", "year", tostring(isYear), "month", tostring(isMonth), "day", tostring(isDay)) .. " " .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BOSSALERT_ALARM_TIME", "hour", tostring(isHour), "minute", tostring(isMinute))
  if true == ToClient_isConsole() then
    curTimeString = curTimeString .. " (UTC)"
  end
  self._ui._desc:SetText(curTimeString)
  if true == self._ui._date:IsAutoWrapText() then
    self._ui._desc:SetSpanSize(self._ui._desc:GetSpanSize().x, self._beforeDescSpanY + self._ui._desc:GetSizeY())
  else
    self._ui._desc:SetSpanSize(self._ui._desc:GetSpanSize().x, self._beforeDescSpanY)
  end
  if false == Panel_BossAlertV2:GetShow() then
    Panel_BossAlertV2:SetShow(true)
    self._aniTime = 0
    self:ShowAni()
  end
end
function PaGlobal_BossAlert_TooltipShow()
  local self = PaGlobal_BossAlert
end
function PaGlobal_BossAlert_TooltipHide()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_BossAlert_NewAlarmClose()
  PaGlobal_BossAlert:HideAni()
end
function UpdateFunc_checkBossAlramAnimation(deltaTime)
  local self = PaGlobal_BossAlert
  if false == _ContentsGroup_NewUI_BossAlert_SettingV2_All then
    if PaGlobal_BossAlertSet_ReturnKeep() then
      self.updateTime = 0
      if 0 == PaGlobal_BossAlert._lastMinute then
        PaGlobal_BossAlert_CheckTimeForHide(deltaTime, PaGlobal_BossAlert._lastMaxTime)
      end
      return
    end
  elseif PaGlobal_BossAlert_SettingV2_All_ReturnKeep() then
    if 0 == PaGlobal_BossAlert._lastMinute then
      PaGlobal_BossAlert_CheckTimeForHide(deltaTime, PaGlobal_BossAlert._lastMaxTime)
    end
    return
  end
  PaGlobal_BossAlert_CheckTimeForHide(deltaTime, PaGlobal_BossAlert._maxTime)
end
function PaGlobal_BossAlert_CheckTimeForHide(deltaTime, maxTime)
  local self = PaGlobal_BossAlert
  self._aniTime = self._aniTime + deltaTime
  if maxTime < self._aniTime then
    self:HideAni()
    self._aniTime = 0
    self.updateTime = 0
  end
end
PaGlobal_BossAlert:Init()
