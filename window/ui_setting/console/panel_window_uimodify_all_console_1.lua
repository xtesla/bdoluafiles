function PaGlobal_UIModify:initialize()
  if true == PaGlobal_UIModify._initialize then
    return
  end
  self._ui.stc_subBG = UI.getChildControl(Panel_Window_UIModify_All_Console, "Static_SubBG")
  self._ui.list2_panelList = UI.getChildControl(self._ui.stc_subBG, "List2_UIEdit")
  self._ui.stc_keyGuideBG = UI.getChildControl(self._ui.stc_subBG, "Static_KeyGuide_ConsoleUI")
  self._ui.txt_keyGuideLSClick = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_KeyGuide_LSClick_ConsoleUI")
  self._ui.txt_keyGuideY = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_KeyGuide_Y_ConsoleUI")
  self._ui.txt_keyGuideX = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_KeyGuide_X_ConsoleUI")
  self._ui.txt_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_KeyGuide_A_ConsoleUI")
  self._ui.txt_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_KeyGuide_B_ConsoleUI")
  self._ui.txt_keyGuideLTX = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_KeyGuideLTX")
  self._ui.txt_keyGuideRS = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_KeyGuideRS")
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_UISetting
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, FGlobal_UiSet_Close)
  self._ui.txt_keyGuideLSClick:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_SELECT_ALL"))
  PaGlobal_UIModify:initializePanelPool()
  PaGlobal_UIModify:setAlignKeyGuide(self._keyGuideType.Default)
  PaGlobal_UIModify:registEventHandler()
  PaGlobal_UIModify:validate()
  self._initialize = true
end
function PaGlobal_UIModify:setAlignKeyGuide(keyGuideType)
  local keyGuides = {}
  if self._keyGuideType.Default == keyGuideType then
    keyGuides = {
      self._ui.txt_keyGuideLSClick,
      self._ui.txt_keyGuideLTX,
      self._ui.txt_keyGuideY,
      self._ui.txt_keyGuideX,
      self._ui.txt_keyGuideA,
      self._ui.txt_keyGuideB
    }
    self._ui.txt_keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SELECT"))
    self._ui.txt_keyGuideB:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CLOSE"))
    self._ui.txt_keyGuideRS:SetShow(false)
    self._ui.txt_keyGuideLSClick:SetShow(true)
    self._ui.txt_keyGuideA:SetShow(true)
    self._ui.txt_keyGuideX:SetShow(true)
  elseif self._keyGuideType.MoveUI == keyGuideType then
    if false == self._isMoveUIMode then
      return
    end
    keyGuides = {
      self._ui.txt_keyGuideRS,
      self._ui.txt_keyGuideY,
      self._ui.txt_keyGuideB
    }
    if true == self._isFixPanelPos then
      self._ui.txt_keyGuideY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_UI_SETTING_BTN_SAVE"))
      self._ui.txt_keyGuideRS:SetShow(false)
    else
      self._ui.txt_keyGuideY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CUSTOMIZATION_TEXTUREMENU_STCTXT_FIXED"))
      self._ui.txt_keyGuideRS:SetShow(true)
    end
    self._ui.txt_keyGuideB:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_KEYGUIDE_CANCEL"))
    self._ui.txt_keyGuideLSClick:SetShow(false)
    self._ui.txt_keyGuideLTX:SetShow(false)
    self._ui.txt_keyGuideA:SetShow(false)
    self._ui.txt_keyGuideX:SetShow(false)
  else
    return
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_UIModify:initializePanelPool()
  if 0 == self._panelCount then
    return
  end
  self._panelPoolBG = UI.createPanelAndSetPanelRenderMode("Panel_modifyPool", Defines.UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_UISetting
  }))
  if nil == self._panelPoolBG then
    return
  end
  self._panelPoolBG:SetAlpha(0)
  self._panelPoolBG:SetIgnore(true)
  for idx = 1, self._panelCount do
    local originalControl = self._panel[idx].control
    if nil ~= originalControl then
      local slot = {}
      slot.control = UI.createAndCopyBasePropertyControl(Panel_Window_UIModify_All_Console, "StaticText_Able", self._panelPoolBG, "txt_createControl_" .. idx)
      slot.control:SetIgnore(true)
      slot.control:SetShow(true)
      slot.control:SetSize(originalControl:GetSizeX(), originalControl:GetSizeY())
      slot.control:SetPosX(originalControl:GetPosX())
      slot.control:SetPosY(originalControl:GetPosY())
      slot.close = UI.createAndCopyBasePropertyControl(Panel_Window_UIModify_All_Console, "Button_ShowToggle", slot.control, "btn_createClose_" .. idx)
      slot.close:SetShow(true)
      slot.close:SetPosX(slot.control:GetSizeX() - slot.close:GetSizeX() - 3)
      slot.close:SetPosY(3)
      slot.close:SetCheck(originalControl:GetShow())
      self._panelPool[idx] = slot
      if true == self._panel[idx].showFixed then
        self._panel[idx].isShow = true
        slot.close:SetShow(false)
      else
        self._panel[idx].isShow = self._panel[idx].control:GetShow()
        slot.close:SetShow(true)
      end
      if true == self._panel[idx].isShow then
        slot.control:SetText(self._panel[idx].name)
      else
        slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_OFF", "name", self._panel[idx].name))
      end
      local stateValue = 1
      if true == self._panel[idx].isShow then
        stateValue = 2
      end
      self:changePanelBGTexture(idx, stateValue)
      if 0 < ToClient_GetUiInfo(self._panel[idx].index, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved) then
        local relativePosX = ToClient_GetUiInfo(self._panel[idx].index, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
        local relativePosY = ToClient_GetUiInfo(self._panel[idx].index, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
        if relativePosX == -1 or relativePosY == -1 then
          if 0 < originalControl:GetRelativePosX() or 0 < originalControl:GetRelativePosY() then
            self._panel[idx].isChange = true
          else
            self._panel[idx].isChange = false
          end
        elseif relativePosX > 0 or relativePosY > 0 then
          self._panel[idx].isChange = true
        end
        if self._panel[idx].posFixed == true then
          self._panel[idx].isChange = false
          Panel_Window_UIModify_All_Console:SetChildIndex(slot.control, 0)
        end
        originalControl:SetRelativePosX(relativePosX)
        originalControl:SetRelativePosY(relativePosY)
        slot.control:SetRelativePosX(relativePosX)
        slot.control:SetRelativePosY(relativePosY)
      end
    end
  end
end
function PaGlobal_UIModify:registEventHandler()
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  registerEvent("FromClient_getUiSettingPanelInfo", "FromClient_getUiSettingPanelInfo")
  registerEvent("onScreenResize", "FromClient_UISetting_Resize")
  self._ui.list2_panelList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_UISetting_ListControlCreate")
  self._ui.list2_panelList:createChildContent(__ePAUIList2ElementManagerType_List)
  Panel_Window_UIModify_All_Console:registerPadEvent(__eConsoleUIPadEvent_LSClick, "HandleClicked_UiSet_SelectAll()")
  Panel_Window_UIModify_All_Console:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleClicked_UiSet_ConfirmSetting(false)")
  Panel_Window_UIModify_All_Console:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleClicked_Reset_UiSetting_Msg()")
end
function PaGlobal_UIModify:prepareOpen()
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  if nil == getSelfPlayer() or nil == getSelfPlayer():get() then
    return
  end
  if false == isGameTypeGT() and false == isGameServiceTypeDev() and false == IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NOTCURRENTACTION_ACK"))
    return
  end
  local levelLimit = 7
  if levelLimit > getSelfPlayer():get():getLevel() then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_LEVELLIMIT_ACK", "level", levelLimit))
    return
  end
  self._beforeUiMode = GetUIMode()
  close_force_WindowPanelList()
  ToClient_SaveUiInfo(false)
  if true == _ContentsGroup_RemasterUI_Radar then
    FGlobal_ResetTimeBar()
  end
  if nil ~= FGlobal_WebHelper_ForceClose then
    FGlobal_WebHelper_ForceClose()
  end
  if nil ~= Panel_ProductNote and true == Panel_ProductNote:GetShow() then
    Panel_ProductNote_ShowToggle()
  end
  self:UiSet_Panel_ShowValueUpdate()
  SetUIMode(Defines.UIMode.eUIMode_UiSetting)
  self._renderMode:set()
  Panel_Window_UIModify_All_Console:RegisterUpdateFunc("PaGlobal_UISetting_UpdateFunc")
  PaGlobal_UIModify:update()
  PaGlobal_UIModify:open()
end
function PaGlobal_UIModify:open()
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  Panel_Window_UIModify_All_Console:SetShow(true)
  self._panelPoolBG:SetShow(true)
end
function PaGlobal_UIModify:prepareClose()
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  if false == Panel_Window_UIModify_All_Console:IsShow() then
    return
  end
  if true == _ContentsGroup_RemasterUI_Radar then
    PaGlobalFunc_Radar_Resize()
  end
  SetUIMode(Defines.UIMode.eUIMode_Default)
  self._renderMode:reset()
  if true == self._isMenu then
    Panel_Menu_ShowToggle()
  elseif false == _ContentsGroup_UISkillGroupTreeLayOut then
    Panel_Window_Skill:SetShow(true, true)
  else
    SetUIMode(self._beforeUiMode)
  end
  Panel_Window_UIModify_All_Console:ClearUpdateLuaFunc()
  PaGlobal_UIModify:close()
end
function PaGlobal_UIModify:close()
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  Panel_Window_UIModify_All_Console:SetShow(false)
  self._panelPoolBG:SetShow(false)
end
function PaGlobal_UIModify:update()
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  FromClient_UISetting_Resize()
  self:updatePanelPool()
end
function PaGlobal_UIModify:resetPanelPoolPos()
  for idx = 1, self._panelCount do
    local slot = self._panelPool[idx]
    if nil ~= slot and nil ~= slot.control then
      local originalControl = self._panel[idx].control
      if nil ~= originalControl then
        slot.control:SetPosX(originalControl:GetPosX())
        slot.control:SetPosY(originalControl:GetPosY())
        if idx == self._panelID.LeftIcon then
          local mainStatusSlot = self._panelPool[self._panelID.MainStatusRemaster]
          if nil ~= mainStatusSlot and true == self._panel[self._panelID.MainStatusRemaster].isShow then
            slot.control:SetPosX(mainStatusSlot.control:GetPosX() + mainStatusSlot.control:GetSizeX() + 25)
          else
            slot.control:SetPosX(10)
          end
        end
      end
    end
  end
end
function PaGlobal_UIModify:updatePanelPool()
  local currentScreenSize = {
    x = getOriginScreenSizeX(),
    y = getOriginScreenSizeY()
  }
  for idx = 1, self._panelCount do
    local slot = self._panelPool[idx]
    if nil ~= slot and nil ~= slot.control then
      slot.control:SetScale(1, 1)
      slot.control:SetShow(true)
      slot.close:SetScale(1, 1)
      if false == self._panel[idx].showFixed then
        slot.close:SetShow(true)
      else
        slot.close:SetShow(false)
      end
      local originalControl = self._panel[idx].control
      if nil ~= originalControl then
        slot.control:SetPosX(originalControl:GetPosX())
        slot.control:SetPosY(originalControl:GetPosY())
        slot.control:SetSize(originalControl:GetSizeX(), originalControl:GetSizeY())
        local rateX = originalControl:GetPosX() + originalControl:GetSizeX() / 2
        local rateY = originalControl:GetPosY() + originalControl:GetSizeY() / 2
        slot.control:SetRelativePosX(rateX / currentScreenSize.x)
        slot.control:SetRelativePosY(rateY / currentScreenSize.y)
        slot.close:SetPosX(slot.control:GetSizeX() - slot.close:GetSizeX() - 3)
        slot.close:SetPosY(3)
        slot.close:SetCheck(self._panel[idx].isShow)
        if idx == self._panelID.LeftIcon then
          local mainStatusSlot = self._panelPool[self._panelID.MainStatusRemaster]
          if nil ~= mainStatusSlot and true == self._panel[self._panelID.MainStatusRemaster].isShow then
            slot.control:SetPosX(mainStatusSlot.control:GetPosX() + mainStatusSlot.control:GetSizeX() + 25)
          else
            slot.control:SetPosX(10)
          end
        end
      end
      if slot.control:GetSizeX() < slot.control:GetTextSizeX() then
        slot.control:SetTextMode(__eTextMode_LimitText)
        slot.control:SetText(slot.control:GetText())
      end
      if true == self._panel[idx].isShow then
        if true == self._panel[idx].posFixed then
          slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_IMPOSSIBLE", "name", self._panel[idx].name))
          self:changePanelBGTexture(idx, 3)
        else
          slot.control:SetText(self._panel[idx].name)
          self:changePanelBGTexture(idx, 2)
        end
      else
        slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_OFF", "name", self._panel[idx].name))
        self:changePanelBGTexture(idx, 1)
      end
      if idx == self._panelID.SkillCommand and nil ~= FGlobal_IsChecked_SkillCommand then
        local isCheckSkillCommand = FGlobal_IsChecked_SkillCommand()
        local skillCommandDesc = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_21")
        if true == isCheckSkillCommand then
          self:changePanelBGTexture(idx, 2)
          slot.control:SetText(skillCommandDesc)
        else
          slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_OFF", "name", skillCommandDesc))
          self:changePanelBGTexture(idx, 1)
        end
        slot.close:SetCheck(isCheckSkillCommand)
        self._panel[idx].isShow = isCheckSkillCommand
      end
    end
  end
  self._ui.list2_panelList:getElementManager():clearKey()
  for idx = 1, self._panelCount do
    self._ui.list2_panelList:getElementManager():pushKey(toInt64(0, idx))
  end
end
function PaGlobal_UIModify:updatePanelBGTexture()
  for idx = 1, self._panelCount do
    local slot = self._panelPool[idx]
    if nil ~= slot and nil ~= slot.control then
      if true == self._panel[idx].isShow then
        if true == self._panel[idx].posFixed then
          slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_IMPOSSIBLE", "name", self._panel[idx].name))
          self:changePanelBGTexture(idx, 3)
        else
          slot.control:SetText(self._panel[idx].name)
          self:changePanelBGTexture(idx, 2)
        end
      else
        slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_OFF", "name", self._panel[idx].name))
        self:changePanelBGTexture(idx, 1)
      end
    end
    if idx == self._panelID.SkillCommand then
      local skillCommandDesc = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_21")
      if true == self._panel[idx].isShow then
        slot.control:SetText(skillCommandDesc)
      else
        slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_OFF", "name", skillCommandDesc))
      end
    end
  end
  for idx = 1, self._panelCount do
    self._ui.list2_panelList:requestUpdateByKey(toInt64(0, idx))
  end
end
function PaGlobal_UIModify:changePanelBGTexture(idx, state)
  local panel = self._panelPool[idx]
  if nil == panel then
    return
  end
  local control = panel.control
  if nil == control then
    return
  end
  control:ChangeTextureInfoName("combine/etc/combine_etc_uicontrolpanel.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, self._BG_Texture[state][1], self._BG_Texture[state][2], self._BG_Texture[state][3], self._BG_Texture[state][4])
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_UIModify:changeMoveUIModePanelColor(index, state)
  local panel = self._panelPool[index]
  local control = panel.control
  if nil == control then
    return
  end
  if true == state then
    self:changePanelBGTexture(index, 2)
    control:SetColor(Defines.Color.C_FFC1FFC2)
  else
    local panelInfo = self._panel[index]
    if true == panelInfo.isShow then
      self:changePanelBGTexture(index, 2)
    else
      self:changePanelBGTexture(index, 1)
    end
    control:SetColor(Defines.Color.C_FFFFFFFF)
  end
end
function PaGlobal_UIModify:changeListControlIgnore(state)
  for idx = 1, self._panelCount do
    local control = self._ui.list2_panelList:GetContentByKey(idx)
    if nil == control then
      return
    end
    local checkButton = UI.getChildControl(control, "CheckButton_PanelName")
    if nil == checkButton then
      return
    end
    checkButton:SetIgnore(state)
  end
end
function PaGlobal_UIModify:UiSet_Panel_ShowValueUpdate()
  for idx = 1, self._panelCount do
    if nil ~= self._panel[idx] then
      if true == self._panel[idx].showFixed then
        self._panel[idx].isShow = true
      else
        self._panel[idx].isShow = self._panel[idx].control:GetShow()
      end
    end
  end
end
function PaGlobal_UIModify:validate()
  if nil == Panel_Window_UIModify_All_Console then
    return
  end
  self._ui.stc_subBG:isValidate()
  self._ui.list2_panelList:isValidate()
  self._ui.stc_keyGuideBG:isValidate()
  self._ui.txt_keyGuideLSClick:isValidate()
  self._ui.txt_keyGuideLTX:isValidate()
  self._ui.txt_keyGuideRS:isValidate()
  self._ui.txt_keyGuideY:isValidate()
  self._ui.txt_keyGuideX:isValidate()
  self._ui.txt_keyGuideA:isValidate()
  self._ui.txt_keyGuideB:isValidate()
  for idx = 1, self._panelCount do
    self._panel[idx].control:isValidate()
    self._panelPool[idx].control:isValidate()
  end
end
function PaGlobal_UIModify:confrimSetting_Sub()
  local panelControl = self._panel
  local panelID = self._panelID
  local currentScreenSize = {
    x = getOriginScreenSizeX(),
    y = getOriginScreenSizeY()
  }
  for idx = 1, self._panelCount do
    local panel = self._panelPool[idx]
    if nil == panel then
      return
    end
    local slot = panel.control
    if nil ~= slot then
      local controlPosX = slot:GetPosX()
      local controlPosY = slot:GetPosY()
      local rateX = 0
      local rateY = 0
      rateX = controlPosX + slot:GetSizeX() / 2
      rateY = controlPosY + slot:GetSizeY() / 2
      if panelControl[idx].isChange == false then
        panelControl[idx].control:SetRelativePosX(0)
        panelControl[idx].control:SetRelativePosY(0)
        slot:SetRelativePosX(0)
        slot:SetRelativePosY(0)
      else
        panelControl[idx].control:SetRelativePosX(rateX / currentScreenSize.x)
        panelControl[idx].control:SetRelativePosY(rateY / currentScreenSize.y)
        slot:SetRelativePosX(rateX / currentScreenSize.x)
        slot:SetRelativePosY(rateY / currentScreenSize.y)
      end
      if idx == panelID.SkillCommand then
        setShowSkillCmd(panelControl[idx].isShow)
        if nil ~= FGlobalFunc_GameOption_SetSkillCommand then
          FGlobalFunc_GameOption_SetSkillCommand(panelControl[idx].isShow)
        end
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
        if nil ~= FGlobal_SkillCommand_Show then
          FGlobal_SkillCommand_Show(panelControl[idx].isShow)
        end
      end
      panelControl[idx].control:SetShow(panelControl[idx].isShow)
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
        whereUseItemDirectionPosition()
      end
    end
  end
  ToClient_SaveUiInfo(true)
end
function PaGlobal_UIModify:getUiSettingPanelInfo(poolIndex, posX, posY, isShow, chatWindowIndex, relativePosX, relativePosY)
  if nil == self._panel[poolIndex] then
    return
  end
  if nil == self._panelPool[poolIndex] then
    return
  end
  if self._panel[poolIndex].posFixed == false then
    self._panelPool[poolIndex].control:SetPosX(posX)
    self._panelPool[poolIndex].control:SetPosY(posY)
    self._panelPool[poolIndex].control:SetRelativePosX(relativePosX)
    self._panelPool[poolIndex].control:SetRelativePosY(relativePosY)
  end
  self._panel[poolIndex].isChange = true
  self._panel[poolIndex].control:SetShow(isShow)
end
