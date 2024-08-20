function FGlobal_UiSet_Open(isMenu)
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  if nil == isMenu then
    PaGlobal_UIModify._isMenu = true
  else
    PaGlobal_UIModify._isMenu = isMenu
  end
  PaGlobal_UIModify:prepareOpen()
end
function FGlobal_UiSet_Close()
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  if true == PaGlobal_UIModify._isMoveUIMode then
    if true == PaGlobal_UIModify._isFixPanelPos then
      PaGlobal_UIModify._isFixPanelPos = false
      PaGlobal_UIModify:setAlignKeyGuide(PaGlobal_UIModify._keyGuideType.MoveUI)
      return
    end
    PaGlobal_UISetting_EndMoveUIMode(false)
    return
  end
  PaGlobal_UIModify:prepareClose()
end
function UiSet_update()
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  PaGlobal_UIModify:update()
end
function PaGlobal_UISetting_EndMoveUIMode(isSaved)
  if false == isSaved then
    PaGlobal_UIModify:resetPanelPoolPos()
  end
  local index = PaGlobal_UIModify._currentMoveIndex
  local panel = PaGlobal_UIModify._panel[index]
  PaGlobal_UIModify:changeMoveUIModePanelColor(index, false)
  if nil ~= panel then
    if false == panel.posFixed then
      PaGlobal_UIModify._ui.txt_keyGuideLTX:SetShow(true)
    else
      PaGlobal_UIModify._ui.txt_keyGuideLTX:SetShow(false)
    end
  end
  PaGlobal_UIModify:setAlignKeyGuide(PaGlobal_UIModify._keyGuideType.Default)
  PaGlobal_UIModify._isMoveUIMode = false
  PaGlobal_UIModify._isFixPanelPos = false
  PaGlobal_UIModify._currentMoveIndex = nil
  PaGlobal_UIModify:changeListControlIgnore(false)
  Panel_Window_UIModify_All_Console:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleClicked_UiSet_ConfirmSetting(false)")
  Panel_Window_UIModify_All_Console:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleClicked_Reset_UiSetting_Msg()")
  Panel_Window_UIModify_All_Console:registerPadEvent(__eConsoleUIPadEvent_LSClick, "HandleClicked_UiSet_SelectAll()")
end
function HandleEventLUp_UiSet_ControlShowToggle(idx)
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  local control = PaGlobal_UIModify._ui.list2_panelList:GetContentByKey(idx)
  if nil == control then
    return
  end
  local checkButton = UI.getChildControl(control, "CheckButton_PanelName")
  if nil == checkButton then
    return
  end
  if nil == PaGlobal_UIModify._panel[idx] then
    return
  end
  if nil ~= PaGlobal_UIModify._currentMoveIndex then
    checkButton:SetCheck(not checkButton:IsCheck())
    return
  end
  PaGlobal_UIModify._panel[idx].isShow = checkButton:IsCheck()
  PaGlobal_UIModify:updatePanelBGTexture()
end
function HandleClicked_UiSet_SelectAll()
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  PaGlobal_UIModify._selectAll = not PaGlobal_UIModify._selectAll
  for idx = 1, PaGlobal_UIModify._panelCount do
    if nil ~= PaGlobal_UIModify._panel[idx] then
      PaGlobal_UIModify._panel[idx].isShow = PaGlobal_UIModify._selectAll
    end
  end
  PaGlobal_UIModify:updatePanelBGTexture()
  if true == PaGlobal_UIModify._selectAll then
    PaGlobal_UIModify._ui.txt_keyGuideLSClick:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_CANCEL_ALL"))
  else
    PaGlobal_UIModify._ui.txt_keyGuideLSClick:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_SELECT_ALL"))
  end
  PaGlobal_UIModify:setAlignKeyGuide(PaGlobal_UIModify._keyGuideType.Default)
end
function HandleClicked_UiSet_ConfirmSetting(isShortcuts)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUiSetting_useMode, false, CppEnums.VariableStorageType.eVariableStorageType_User)
  PaGlobal_UIModify:confrimSetting_Sub()
  ToClient_CopyEditUiInfo()
  ToClient_saveUserCache()
  SetUIMode(Defines.UIMode.eUIMode_Default)
  PaGlobal_UIModify._renderMode:reset()
  FGlobal_UiSet_Close()
  if false == isShortcuts then
    if PaGlobal_UIModify._isMenu then
      Panel_Menu_ShowToggle()
    elseif false == _ContentsGroup_UISkillGroupTreeLayOut then
      Panel_Window_Skill:SetShow(true, true)
    end
  end
end
function HandleClicked_Reset_UiSetting_Msg()
  local reset_GameUI = function()
    local panelID = PaGlobal_UIModify._panelID
    local panelControl = PaGlobal_UIModify._panel
    if nil == panelID or nil == panelControl then
      return
    end
    local screenSizeX = getScreenSizeX()
    local screenSizeY = getScreenSizeY()
    SetUIMode(Defines.UIMode.eUIMode_Default)
    PaGlobal_UIModify._renderMode:reset()
    FGlobal_UiSet_Close()
    for idx = 1, PaGlobal_UIModify._panelCount do
      panelControl[idx].control:SetRelativePosX(0)
      panelControl[idx].control:SetRelativePosY(0)
      panelControl[idx].isChange = false
      panelControl[idx].isShow = true
      PaGlobal_UIModify:changePanelBGTexture(idx, 2)
      panelControl[idx].control:SetShow(true)
      if idx == panelID.MainQuest then
        Panel_LatestQuest:SetShow(panelControl[idx].isShow)
      elseif idx == panelID.MainStatusRemaster or idx == panelID.LeftIcon then
        PackageIconPosition()
      elseif idx == panelID.ServantIcon then
        PaGlobalFunc_TopIcon_ShowAll(panelControl[idx].isShow)
      elseif idx == panelID.ItemCountingWidget then
        if nil ~= whereUseItem_IsSetItemKey then
          panelControl[idx].control:SetShow(whereUseItem_IsSetItemKey())
        else
          panelControl[idx].control:SetShow(false)
        end
      elseif idx == panelID.SkillCommand then
        setShowSkillCmd(panelControl[idx].isShow)
        if nil ~= FGlobalFunc_GameOption_SetSkillCommand then
          FGlobalFunc_GameOption_SetSkillCommand(panelControl[idx].isShow)
        end
        if nil ~= FGlobal_SkillCommand_Show then
          FGlobal_SkillCommand_Show(panelControl[idx].isShow)
        end
      end
    end
    FGlobal_ResetRadarUI(true)
    if nil ~= PaGlobal_WorldMiniMap then
      PaGlobal_WorldMiniMap:resetPanelSize()
    end
    PaGlobalFunc_AppliedBuffList_ResetPosition()
    resetGameUI()
    ToClient_SaveUiInfo(true)
    ToClient_saveUserCache()
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_ALLINTERFACERESET_CONFIRM")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_ALLINTERFACERESET"),
    content = messageBoxMemo,
    functionYes = reset_GameUI,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLTX_UISetting_SetMoveUIMode(idx)
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  if true == PaGlobal_UIModify._isMoveUIMode then
    return
  end
  PaGlobal_UIModify._isMoveUIMode = true
  PaGlobal_UIModify._currentMoveIndex = idx
  PaGlobal_UIModify:changeMoveUIModePanelColor(idx, true)
  PaGlobal_UIModify:setAlignKeyGuide(PaGlobal_UIModify._keyGuideType.MoveUI)
  PaGlobal_UIModify:changeListControlIgnore(true)
  PaGlobal_UIModify._ui.list2_panelList:SetIgnore(true)
  Panel_Window_UIModify_All_Console:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_UISetting_SaveUIPos()")
  Panel_Window_UIModify_All_Console:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  Panel_Window_UIModify_All_Console:registerPadEvent(__eConsoleUIPadEvent_LSClick, "")
end
function HandleEventOn_UiSet_ChangeKeyGuide(idx)
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  if nil ~= PaGlobal_UIModify._currentMoveIndex then
    return
  end
  local panelData = PaGlobal_UIModify._panel[idx]
  if nil == panelData then
    return
  end
  if false == panelData.posFixed then
    PaGlobal_UIModify._ui.txt_keyGuideLTX:SetShow(true)
  else
    PaGlobal_UIModify._ui.txt_keyGuideLTX:SetShow(false)
  end
  PaGlobal_UIModify:setAlignKeyGuide(PaGlobal_UIModify._keyGuideType.Default)
end
function HandleEventLUp_UISetting_SaveUIPos()
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  if false == PaGlobal_UIModify._isMoveUIMode then
    return
  end
  if false == PaGlobal_UIModify._isFixPanelPos then
    PaGlobal_UIModify._isFixPanelPos = true
    PaGlobal_UIModify:setAlignKeyGuide(PaGlobal_UIModify._keyGuideType.MoveUI)
    return
  end
  local index = PaGlobal_UIModify._currentMoveIndex
  local panel = PaGlobal_UIModify._panelPool[index]
  if nil == panel then
    return
  end
  local slot = panel.control
  if nil == slot then
    return
  end
  local controlPos = float2()
  controlPos.x = slot:GetPosX()
  controlPos.y = slot:GetPosY()
  local controlShowToggle = panel.close:IsCheck()
  local currentScreenSize = {
    x = getOriginScreenSizeX(),
    y = getOriginScreenSizeY()
  }
  local relativePos = float2()
  relativePos.x = (slot:GetPosX() + slot:GetSizeX() / 2) / currentScreenSize.x
  relativePos.y = (slot:GetPosY() + slot:GetSizeY() / 2) / currentScreenSize.y
  ToClient_setUISettingPanelInfo(PaGlobal_UIModify._panel[index].index, controlPos.x, controlPos.y, controlShowToggle, 0, relativePos.x, relativePos.y)
  ToClient_getGameUIManagerWrapper():saveUISettingPresetInfo(0)
  local chatPanel = ToClient_getChattingPanel(0)
  local chatPanelSize = float2()
  chatPanelSize.x = chatPanel:getPanelSizeX()
  chatPanelSize.y = chatPanel:getPanelSizeY()
  ToClient_setUISettingChattingPanelInfo(0, 0, true, true, CppEnums.PAGameUIType.PAGameUIPanel_ConsoleChattingViewer, controlPos, controlShowToggle, relativePos, chatPanelSize)
  ToClient_setUISettingChattingOption(0, 0, false)
  ToClient_getGameUIManagerWrapper():saveUISettingChattingPresetInfo(0)
  for idx = 1, PaGlobal_UIModify._panelCount do
    ToClient_getUISettingPanelInfo(0, idx, PaGlobal_UIModify._panel[idx].index, 0)
  end
  PaGlobal_UISetting_EndMoveUIMode(true)
end
function PaGlobal_UISetting_ListControlCreate(content, key)
  local key32 = Int64toInt32(key)
  local checkButton = UI.getChildControl(content, "CheckButton_PanelName")
  if nil == checkButton then
    return
  end
  local panelData = PaGlobal_UIModify._panel[key32]
  if nil == panelData then
    return
  end
  checkButton:SetCheck(panelData.isShow)
  checkButton:SetText(panelData.name)
  if nil == PaGlobal_UIModify._currentMoveIndex then
    checkButton:addInputEvent("Mouse_On", "HandleEventOn_UiSet_ChangeKeyGuide( " .. key32 .. " )")
    checkButton:addInputEvent("Mouse_LUp", "HandleEventLUp_UiSet_ControlShowToggle( " .. key32 .. " )")
    if false == panelData.posFixed then
      checkButton:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLTX_UISetting_SetMoveUIMode(" .. key32 .. ")")
    end
  end
end
function PaGlobal_UISetting_UpdateFunc(deltaTime)
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  if false == PaGlobal_UIModify._isMoveUIMode then
    return
  end
  if true == PaGlobal_UIModify._isFixPanelPos then
    return
  end
  if nil == PaGlobal_UIModify._currentMoveIndex then
    return
  end
  local slot = PaGlobal_UIModify._panelPool[PaGlobal_UIModify._currentMoveIndex]
  if nil == slot or nil == slot.control then
    return
  end
  local uiOffset = ToClient_GetConsoleUIOffset()
  if nil == uiOffset then
    return
  end
  local currentScreenSize = {
    x = getOriginScreenSizeX(),
    y = getOriginScreenSizeY()
  }
  local gapX = currentScreenSize.x * uiOffset
  local gapY = currentScreenSize.y * uiOffset
  local speed = deltaTime * 300
  if isPadPressed(__eJoyPadInputType_RightStick_Up) then
    local result = slot.control:GetPosY() - speed
    if gapY <= result then
      slot.control:SetPosY(result)
    else
      slot.control:SetPosY(gapY)
    end
  end
  if isPadPressed(__eJoyPadInputType_RightStick_Down) then
    local result = slot.control:GetPosY() + speed
    local maxPosY = currentScreenSize.y - slot.control:GetSizeY() - gapY
    if result <= maxPosY then
      slot.control:SetPosY(result)
    else
      slot.control:SetPosY(maxPosY)
    end
  end
  if isPadPressed(__eJoyPadInputType_RightStick_Left) then
    local result = slot.control:GetPosX() - speed
    if gapX <= result then
      slot.control:SetPosX(result)
    else
      slot.control:SetPosX(gapX)
    end
  end
  if isPadPressed(__eJoyPadInputType_RightStick_Right) then
    local result = slot.control:GetPosX() + speed
    local maxPosX = currentScreenSize.x - slot.control:GetSizeX() - gapX
    if result <= maxPosX then
      slot.control:SetPosX(result)
    else
      slot.control:SetPosX(maxPosX)
    end
  end
end
function PaGlobalFunc_UiSet_GetSkillLogIsShow()
  if nil == PaGlobal_UIModify._panel[PaGlobal_UIModify._panelID.SkillLog] then
    return false
  end
  return PaGlobal_UIModify._panel[PaGlobal_UIModify._panelID.SkillLog].isShow
end
function FromClient_UISetting_Resize()
  local currentScreenSize = {
    x = getOriginScreenSizeX(),
    y = getOriginScreenSizeY()
  }
  PaGlobal_UIModify._panelPoolBG:SetSize(currentScreenSize.x, currentScreenSize.y)
  PaGlobal_UIModify._panelPoolBG:ComputePos()
  PaGlobal_UIModify._panelPoolBG:SetPosX(0)
  PaGlobal_UIModify._panelPoolBG:SetPosY(0)
  Panel_Window_UIModify_All_Console:ComputePos()
end
function FromClient_getUiSettingPanelInfo(panelIndex, posX, posY, isShow, chatWindowIndex, relativePosX, relativePosY)
  PaGlobal_UIModify:getUiSettingPanelInfo(panelIndex, posX, posY, isShow, chatWindowIndex, relativePosX, relativePosY)
end
function setChangeUiSettingRadarUI(panel, uiType)
  if nil == PaGlobal_UIModify._panel[PaGlobal_UIModify._panelID.Radar] then
    return
  end
  PaGlobal_UIModify._panel[PaGlobal_UIModify._panelID.Radar].control = panel
  PaGlobal_UIModify._panel[PaGlobal_UIModify._panelID.Radar].index = uiType
end
function PAGlobal_setIsChangePanelState(index, state, ischatPanel)
  if false == ischatPanel then
    for idx = 1, PaGlobal_UIModify._panelCount do
      if nil ~= PaGlobal_UIModify._panel[idx] and PaGlobal_UIModify._panel[idx].index == index then
        PaGlobal_UIModify._panel[idx].isChange = state
        return
      end
    end
  elseif nil ~= PaGlobal_UIModify._panel[index] then
    PaGlobal_UIModify._panel[index].isChange = state
  end
end
