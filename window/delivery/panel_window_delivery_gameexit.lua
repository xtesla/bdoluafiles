local deliveryForGameExit = {
  _buttonClose = UI.getChildControl(Panel_Window_DeliveryForGameExit, "Button_Close"),
  _buttonGetOn = UI.getChildControl(Panel_Window_DeliveryForGameExit, "Button_GetOn"),
  _comboBoxDest = UI.getChildControl(Panel_Window_DeliveryForGameExit, "Combobox_Destination"),
  _comboBoxSwapCharacter = UI.getChildControl(Panel_Window_DeliveryForGameExit, "Combobox_Character"),
  _panelBg = UI.getChildControl(Panel_Window_DeliveryForGameExit, "Static_Sample_Background"),
  _bg = UI.getChildControl(Panel_Window_DeliveryForGameExit, "Static_BG"),
  _staticText_NoticeMsg = UI.getChildControl(Panel_Window_DeliveryForGameExit, "StaticText_NoticeText"),
  _staticText_NoticeAlert = nil,
  _keyguideBg = UI.getChildControl(Panel_Window_DeliveryForGameExit, "Static_KeyGuideBg_ConsoleUI"),
  _selectDestinationWaypointKey = -1,
  _selectDestCarriageKey = -1,
  _selectCharacterIndex = -1,
  _selectCharacterIndexPos = -1,
  _changingCharacter = false,
  _isConsole = _ContentsGroup_UsePadSnapping
}
function deliveryForGameExit:PanelResize_ByFontSize()
  self._staticText_NoticeAlert:SetTextMode(__eTextMode_AutoWrap)
  self._staticText_NoticeAlert:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DELIVERYFORGAMEEXIT_ALERT"))
  self._bg:SetSize(self._bg:GetSizeX(), self._staticText_NoticeAlert:GetTextSizeY() + 50)
  self._staticText_NoticeAlert:ComputePos()
  self._staticText_NoticeAlert:SetTextSpan(0, (self._staticText_NoticeAlert:GetSizeY() - self._staticText_NoticeAlert:GetTextSizeY()) * 0.5)
  if false == self._isConsole then
    Panel_Window_DeliveryForGameExit:SetSize(Panel_Window_DeliveryForGameExit:GetSizeX(), self._bg:GetPosY() + self._bg:GetSizeY() + 90)
  else
    Panel_Window_DeliveryForGameExit:SetSize(Panel_Window_DeliveryForGameExit:GetSizeX(), self._bg:GetPosY() + self._bg:GetSizeY())
    self._keyguideBg:ComputePos()
  end
  self._panelBg:SetSize(Panel_Window_DeliveryForGameExit:GetSizeX(), Panel_Window_DeliveryForGameExit:GetSizeY())
  self._buttonGetOn:ComputePos()
end
local changeDelayTime = -1
function delivery_GameExit_UpdatePerFrame(deltaTime)
  if changeDelayTime > 0 then
    changeDelayTime = changeDelayTime - deltaTime
    local remainTime = math.floor(changeDelayTime)
    if prevTime ~= remainTime then
      if remainTime < 0 then
        remainTime = 0
      end
      prevTime = remainTime
      deliveryForGameExit._staticText_NoticeMsg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "Lua_deliveryPerson_ChangeMsg", "changeTime", tostring(remainTime)))
      if 0 >= prevTime then
        changeDelayTime = -1
        deliveryForGameExit._staticText_NoticeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_deliveryPerson_GoChange"))
      end
    end
  end
end
function setPlayerDeliveryDelayTime(delayTime)
  if false == Panel_Window_DeliveryForGameExit:GetShow() then
    return
  end
  deliveryForGameExit._buttonGetOn:SetShow(false)
  deliveryForGameExit._staticText_NoticeMsg:SetShow(true)
  deliveryForGameExit._staticText_NoticeAlert:SetShow(false)
  if 0 == delayTime then
    deliveryForGameExit._staticText_NoticeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_deliveryPerson_GoChange"))
  else
    deliveryForGameExit._staticText_NoticeMsg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "Lua_deliveryPerson_ChangeMsg", "changeTime", tostring(delayTime)))
  end
  changeDelayTime = delayTime
end
function deliveryForGameExit.fillData()
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return false
  end
  if true == selfProxy:get():isTradingPvpable() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_deliveryPerson_TradingPvPAble"))
    return false
  end
  if toInt64(0, 0) < selfProxy:get():getInventory():getTradeItemCount() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_deliveryPerson_HaveTradeItem"))
    return false
  end
  local characterNo_64 = toInt64(0, 0)
  characterNo_64 = selfProxy:getCharacterNo_64()
  deliveryForGameExit._comboBoxDest:DeleteAllItem()
  local deliveryPersonInfoList = ToClient_DeliveryPersonInfo()
  local deliverySize = deliveryPersonInfoList:size()
  if deliverySize < 0 then
    return
  end
  for kk = 0, deliverySize - 1 do
    local deliveryPersonInfo = deliveryPersonInfoList:atPointer(kk)
    local destinationRegionInfo = deliveryPersonInfo:getRegionInfo()
    local regionInfoWrapper = getRegionInfoWrapper(destinationRegionInfo._regionKey:get())
    deliveryForGameExit._comboBoxDest:AddItem(regionInfoWrapper:getAreaName())
  end
  deliveryForGameExit._comboBoxSwapCharacter:DeleteAllItem()
  local count = getCharacterDataCount()
  for idx = 0, count - 1 do
    local characterData = getCharacterDataByIndex(idx)
    if nil == characterData then
      break
    end
    if characterNo_64 ~= characterData._characterNo_s64 then
      local strLevel = string.format("%d", characterData._level)
      local characterNameLv = PAGetStringParam2(Defines.StringSheet_GAME, "CHARACTER_SELECT_LV", "character_name", getCharacterName(characterData), "character_level", strLevel)
      deliveryForGameExit._comboBoxSwapCharacter:AddItem(characterNameLv)
    else
      deliveryForGameExit._selectCharacterIndexPos = idx
    end
  end
  return true
end
function deliveryForGameExit.resetData()
  deliveryForGameExit._selectDestinationWaypointKey = -1
  deliveryForGameExit._selectDestCarriageKey = -1
  deliveryForGameExit._selectCharacterIndex = -1
  deliveryForGameExit._comboBoxDest:CloseListbox()
  deliveryForGameExit._comboBoxSwapCharacter:CloseListbox()
  deliveryForGameExit._comboBoxDest:SetText(PAGetString(Defines.StringSheet_RESOURCE, "DELIVERY_PERSON_SELECT_DESTINATION"))
  deliveryForGameExit._comboBoxSwapCharacter:SetText(PAGetString(Defines.StringSheet_RESOURCE, "DELIVERY_PERSON_SELECT_CHANRACTER"))
end
function FGlobal_DeliveryForGameExit_Show(show)
  if true == show then
    local rv = deliveryForGameExit.fillData()
    if false == rv then
      return
    end
  else
    if not deliveryForGameExit._changingCharacter then
      deliveryForGameExit.resetData()
    end
    deliveryForGameExit._staticText_NoticeMsg:SetShow(false)
    deliveryForGameExit._staticText_NoticeAlert:SetShow(true)
  end
  Panel_Window_DeliveryForGameExit:SetShow(show)
end
function click_DeliveryForGameExit_Close()
  if -1 ~= changeDelayTime then
    sendGameDelayExitCancel()
  end
  changeDelayTime = -1
  FGlobal_DeliveryForGameExit_Show(false)
  deliveryForGameExit._buttonGetOn:SetShow(true)
end
function click_DeliveryForGameExit_GetOn()
  if -1 == deliveryForGameExit._selectDestinationWaypointKey then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_deliveryPerson_NotDestination"))
    return
  end
  if -1 == deliveryForGameExit._selectCharacterIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_deliveryPerson_SelectCharacter"))
    return
  end
  local characterData = getCharacterDataByIndex(deliveryForGameExit._selectCharacterIndex)
  if nil == characterData then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == _ContentsGroup_SeasonContents then
    if true == ToClient_isSeasonChannel() and characterData._characterSeasonType ~= __eCharacterSeasonType_Season then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_CANNOT_ACCESS"))
      return
    end
  elseif true == _ContentsGroup_PreSeason and characterData._characterSeasonType == __eCharacterSeasonType_Season then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_CANNOT_PLAY")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local classType = getCharacterClassType(characterData)
  if ToClient_IsCustomizeOnlyClass(classType) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERY_PERSON_NOTCHANGE"))
    return
  end
  if selfPlayer:get():getLevel() < 5 then
    NotifyDisplay(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_DONT_CHAGECHARACTER", "iLevel", 4))
    return
  end
  local removeTime = getCharacterDataRemoveTime(deliveryForGameExit._selectCharacterIndex)
  if nil ~= removeTime then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "GAMEEXIT_TEXT_CHARACTER_DELETE"))
    return
  end
  if true == ToClient_CheckDuelCharacterInPrison(deliveryForGameExit._selectCharacterIndex) then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERTAG_PRISON_CANT_LOGIN"))
    return
  end
  local duelCharacterIndex = ToClient_GetMyDuelCharacterIndex()
  if -1 ~= duelCharacterIndex then
    NotifyDisplay(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoTagCharacterCantDelivaryPC"))
    return
  end
  local preText = ""
  local serverUtc64 = getServerUtc64()
  if 0 ~= characterData._arrivalRegionKey:get() and serverUtc64 < characterData._arrivalTime then
    preText = PAGetString(Defines.StringSheet_GAME, "Lua_deliveryPerson_SelectPcDelivery2") .. "\n"
  end
  local messageContent = preText .. PAGetStringParam2(Defines.StringSheet_RESOURCE, "DELIVERY_PERSON_READY_CHK", "now_character", getSelfPlayer():getName(), "change_character", getCharacterName(getCharacterDataByIndex(deliveryForGameExit._selectCharacterIndex)))
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "Lua_deliveryPerson_Information"),
    content = messageContent,
    functionYes = DeliveryForGameExit_YouSure,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function DeliveryForGameExit_YouSure()
  deliveryPerson_SendReserve(deliveryForGameExit._selectDestinationWaypointKey)
  deliveryForGameExit._changingCharacter = true
  if true == deliveryForGameExit._isConsole then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
      isLoading = true,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function deliveryForGameExit:alignKeyGuides()
  if true == deliveryForGameExit._isConsole then
    local keyGuides = {
      deliveryForGameExit._static_keyguideY,
      deliveryForGameExit._static_keyguideA,
      deliveryForGameExit._static_keyguideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, deliveryForGameExit._keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function click_DeliveryForGameExit_Dest()
  if true == deliveryForGameExit._isConsole and 0 == deliveryForGameExit._comboBoxDest:GetListSize() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_DELIVERY_NO_DESTINATION"))
    return
  end
  deliveryForGameExit._comboBoxDest:ToggleListbox()
end
function click_DeliveryForGameExit_DestList()
  local destSelectIndex = deliveryForGameExit._comboBoxDest:GetSelectIndex()
  if -1 == destSelectIndex then
    return
  end
  local deliveryPersonInfoList = ToClient_DeliveryPersonInfo()
  local deliveryPersonInfo = deliveryPersonInfoList:atPointer(destSelectIndex)
  local destRegionInfo = deliveryPersonInfo:getRegionInfo()
  deliveryForGameExit._selectDestinationWaypointKey = destRegionInfo._regionKey:get()
end
function on_DeliveryForGameExit_DestList()
  local onSelectIndex = deliveryForGameExit._comboBoxDest:GetSelectIndex()
  if -1 == onSelectIndex then
    return
  end
end
function click_DeliveryForGameExit_SwapCharacter()
  deliveryForGameExit._comboBoxSwapCharacter:ToggleListbox()
end
function click_DeliveryForGameExit_SwapCharacterList()
  local characterSelectIndex = deliveryForGameExit._comboBoxSwapCharacter:GetSelectIndex()
  if characterSelectIndex >= deliveryForGameExit._selectCharacterIndexPos then
    characterSelectIndex = characterSelectIndex + 1
  end
  deliveryForGameExit._selectCharacterIndex = characterSelectIndex
end
function deliveryForGameExitChangeCharacter()
  if -1 == deliveryForGameExit._selectCharacterIndex then
    return
  end
  local rv = swapCharacter_Select(deliveryForGameExit._selectCharacterIndex, true)
  if false == rv then
    return
  end
  deliveryForGameExit._changingCharacter = false
  deliveryForGameExit.resetData()
end
local function initialize()
  deliveryForGameExit._buttonClose:addInputEvent("Mouse_LUp", "click_DeliveryForGameExit_Close()")
  deliveryForGameExit._buttonGetOn:addInputEvent("Mouse_LUp", "click_DeliveryForGameExit_GetOn()")
  deliveryForGameExit._comboBoxDest:setListTextHorizonCenter()
  deliveryForGameExit._comboBoxDest:addInputEvent("Mouse_LUp", "click_DeliveryForGameExit_Dest()")
  deliveryForGameExit._comboBoxDest:GetListControl():AddSelectEvent("click_DeliveryForGameExit_DestList()")
  deliveryForGameExit._comboBoxSwapCharacter:setListTextHorizonCenter()
  deliveryForGameExit._comboBoxSwapCharacter:addInputEvent("Mouse_LUp", "click_DeliveryForGameExit_SwapCharacter()")
  deliveryForGameExit._comboBoxSwapCharacter:GetListControl():AddSelectEvent("click_DeliveryForGameExit_SwapCharacterList()")
  registerEvent("EventDeliveryForPersonChangeCharacter", "deliveryForGameExitChangeCharacter()")
  registerEvent("EventGameExitDelayTime", "setPlayerDeliveryDelayTime")
  Panel_Window_DeliveryForGameExit:RegisterUpdateFunc("delivery_GameExit_UpdatePerFrame")
  deliveryForGameExit._staticText_NoticeAlert = UI.getChildControl(deliveryForGameExit._bg, "StaticText_Alert")
  deliveryForGameExit._static_keyguideA = UI.getChildControl(deliveryForGameExit._keyguideBg, "Radiobutton_A_ConsoleUI")
  deliveryForGameExit._static_keyguideY = UI.getChildControl(deliveryForGameExit._keyguideBg, "Radiobutton_Y_ConsoleUI")
  deliveryForGameExit._static_keyguideB = UI.getChildControl(deliveryForGameExit._keyguideBg, "Radiobutton_B_ConsoleUI")
  if true == deliveryForGameExit._isConsole then
    deliveryForGameExit._buttonClose:SetShow(false)
    deliveryForGameExit._buttonGetOn:SetShow(false)
    Panel_Window_DeliveryForGameExit:ignorePadSnapMoveToOtherPanel()
    Panel_Window_DeliveryForGameExit:registerPadEvent(__eConsoleUIPadEvent_Y, "click_DeliveryForGameExit_GetOn()")
    deliveryForGameExit:alignKeyGuides()
  end
end
initialize()
deliveryForGameExit:PanelResize_ByFontSize()
