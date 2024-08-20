function PaGlobal_BarterInfoRefresh:init()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_keyGuideBG:SetShow(true == self._isConsole)
  self._ui._keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_A_ConsoleUI")
  self._ui._keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_B_ConsoleUI")
  local keyGuide = {
    self._ui._keyGuide_A,
    self._ui._keyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  if true == self._isConsole then
    Panel_Window_Barter_Refresh:registerPadEvent(__eConsoleUIPadEvent_B, "PaGlobal_BarterInfoRefresh:close()")
    Panel_Window_Barter_Refresh:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_BarterInfoRefresh:requestRefreshBarterInfo()")
    Panel_Window_Barter_Refresh:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "PaGlobal_BarterInfoRefresh:addIndex(-1)")
    Panel_Window_Barter_Refresh:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "PaGlobal_BarterInfoRefresh:addIndex(1)")
    Panel_Window_Barter_Refresh:ignorePadSnapMoveToOtherPanel()
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoRefresh:close()")
    self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoRefresh:close()")
    self._ui._btn_apply:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoRefresh:requestRefreshBarterInfo()")
  end
  self._ui._btn_close:SetShow(false == self._isConsole)
  self._ui._btn_cancel:SetShow(false == self._isConsole)
  self._ui._btn_apply:SetShow(false == self._isConsole)
  self._ui._rdo_group = Array.new()
  for ii = 0, self._config._btn_count - 1 do
    local control
    control = UI.getChildControl(Panel_Window_Barter_Refresh, "RadioButton_Refresh_" .. tostring(ii + 1))
    control:SetShow(true == _ContentsGroup_BarterMaterialReset or ii < 3)
    control:SetCheck(false)
    control:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoRefresh:selectIndex(" .. ii .. ")")
    local txtDesc = UI.getChildControl(control, "StaticText_Money")
    txtDesc:SetTextMode(__eTextMode_AutoWrap)
    txtDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTERINFO_RESETBUTTON_TYPE_" .. tostring(ii + 1) .. "_DESC"))
    if 2 ~= ii then
      local txtPoint = UI.getChildControl(control, "StaticText_PointValue")
      txtPoint:SetSpanSize(control:GetTextSizeX() + 23, 20)
    end
    self._ui._rdo_group[ii] = control
  end
  if false == _ContentsGroup_BarterMaterialReset then
    local diffSize = 260
    self._ui._rdo_group[2]:SetSpanSize(10, 320)
    Panel_Window_Barter_Refresh:SetSize(Panel_Window_Barter_Refresh:GetSizeX(), Panel_Window_Barter_Refresh:GetSizeY() - diffSize)
    Panel_Window_Barter_Refresh:SetPosY(Panel_Window_Barter_Refresh:GetPosY() - diffSize)
    local staticBG = UI.getChildControl(Panel_Window_Barter_Refresh, "Static_Bg")
    staticBG:SetSize(staticBG:GetSizeX(), staticBG:GetSizeY() - diffSize)
    Panel_Window_Barter_Refresh:ComputePosAllChild()
  end
  self:resizePanel()
end
function PaGlobal_BarterInfoRefresh:resizePanel()
  local panelSizeX = Panel_Window_Barter_Refresh:GetSizeX()
  local panelSizeY = Panel_Window_Barter_Refresh:GetSizeY()
  local btnSizeY = self._ui._btn_apply:GetSizeY()
  if true == self._isConsole then
    Panel_Window_Barter_Refresh:SetSize(panelSizeX, panelSizeY - btnSizeY)
  else
    Panel_Window_Barter_Refresh:SetSize(panelSizeX, panelSizeY)
  end
  self._ui._stc_keyGuideBG:SetPosY(Panel_Window_Barter_Refresh:GetSizeY())
  Panel_Window_Barter_Refresh:ComputePos()
end
function PaGlobal_BarterInfoRefresh:clear()
  self._selectIndex = nil
  for ii = 0, #self._ui._rdo_group do
    self._ui._rdo_group[ii]:SetCheck(false)
    self._ui._rdo_group[ii]:SetMonoTone(false)
  end
end
function PaGlobal_BarterInfoRefresh:open()
  if false == _ContentsGroup_Barter then
    return
  end
  self:clear()
  for ii = 0, 4 do
    self._ui._rdo_group[ii]:SetMonoTone(false == ToClient_isCanChangeBarterList(ii))
    if 2 ~= ii then
      local radioText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTERINFO_RESETBUTTON_TYPE_" .. tostring(ii + 1))
      local remainCount = 0
      if 0 == ii or 1 == ii then
        remainCount = ToClient_getMaxSeedChangeCountByBarterType(0) - ToClient_getSeedChangeCountByBarterType(0)
      else
        remainCount = ToClient_getMaxSeedChangeCountByBarterType(1) - ToClient_getSeedChangeCountByBarterType(1)
      end
      local needPoint = ToClient_getBarterResetNeedPoint(ii)
      local textValue
      if remainCount > 0 and needPoint > 0 then
        textValue = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_BARTERINFO_RESETBUTTON_COUNT", "value", needPoint)
      else
        textValue = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTERINFO_RESETBUTTON_FINISH")
      end
      local txtPointValue = UI.getChildControl(self._ui._rdo_group[ii], "StaticText_PointValue")
      if nil ~= txtPointValue then
        txtPointValue:SetText(textValue)
      end
    end
  end
  self:selectIndex(0)
  if true == ToClient_WorldMapIsShow() then
    WorldMapPopupManager:push(Panel_Window_Barter_Refresh, true)
  else
    Panel_Window_Barter_Refresh:SetShow(true)
  end
  local txt_refresh = ""
  if true == ToClient_isEnableChangeBarterSeed() then
    txt_refresh = PAGetString(Defines.StringSheet_GAME, "LUA_BARTERREFRESH_REFRESHNOW")
  else
    local resetCoolTime = ToClient_changeBarterInfoRemainSec()
    txt_refresh = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REMAIN_TIME_LIST_RENEWAL") .. " " .. convertStringFromDatetimeAll(resetCoolTime)
  end
  self._ui._txt_refreshTime:SetText(txt_refresh)
end
function PaGlobal_BarterInfoRefresh:close()
  if true == ToClient_WorldMapIsShow() then
    WorldMapPopupManager:popWantPanel(Panel_Window_Barter_Refresh)
  else
    Panel_Window_Barter_Refresh:SetShow(false)
  end
end
function PaGlobal_BarterInfoRefresh:addIndex(value)
  if false == self._isConsole then
    return
  end
  local index = 0
  if 1 == self._selectIndex and 1 == value then
    index = 3
  elseif 4 == self._selectIndex and 1 == value then
    index = 2
  elseif 2 == self._selectIndex and 1 == value then
    return
  elseif 2 == self._selectIndex and -1 == value then
    index = 4
  elseif 3 == self._selectIndex and -1 == value then
    index = 1
  else
    index = self._selectIndex + value
    if index < 0 then
      index = 0
    elseif index >= self._config._btn_count then
      index = self._config._btn_count - 1
    end
  end
  for ii = 0, self._config._btn_count - 1 do
    self._ui._rdo_group[ii]:SetCheck(false)
  end
  self:selectIndex(index)
end
function PaGlobal_BarterInfoRefresh:selectIndex(index)
  self._selectIndex = index
  self._ui._rdo_group[index]:SetCheck(true)
  if true == self._isConsole then
    ToClient_padSnapChangeToTarget(self._ui._rdo_group[index])
  end
end
function PaGlobal_BarterInfoRefresh:requestRefreshBarterInfo()
  if 2 == self._selectIndex then
    PaGlobal_BarterInfoSearch_RequestChangeBarterList()
    return
  end
  local needPoint = ToClient_getBarterResetNeedPoint(self._selectIndex)
  local remainCount = 0
  if 0 == self._selectIndex or 1 == self._selectIndex then
    remainCount = ToClient_getMaxSeedChangeCountByBarterType(0) - ToClient_getSeedChangeCountByBarterType(0)
  else
    remainCount = ToClient_getMaxSeedChangeCountByBarterType(1) - ToClient_getSeedChangeCountByBarterType(1)
  end
  if remainCount <= 0 or needPoint <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoBarterSeedChangeCountIsNull"))
    return
  end
  local maxSeedChangeCount = ToClient_getMaxChangeSeedCountForDay()
  local remainSeedChangeCount = maxSeedChangeCount - ToClient_getChangeSeedCountForDay()
  if needPoint > remainSeedChangeCount then
    remainCount = 0
  end
  local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTERRESET_INFO_00", "point", needPoint, "remaincount", remainCount)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = PaGlobal_BarterInfoSearch_RequestChangeBarterList,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
