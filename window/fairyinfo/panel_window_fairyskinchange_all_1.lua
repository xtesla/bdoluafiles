function PaGlobal_FairySkinChange_All:initialize()
  if true == PaGlobal_FairySkinChange_All._initialize then
    return
  end
  local slotCount = PaGlobal_FairySkinChange_All._config._slotCount
  for index = 1, slotCount do
    local slot = UI.getChildControl(Panel_Window_FairySkinChange_All, "Radiobutton_LookChange_Slot_" .. index)
    local slotImage = UI.getChildControl(slot, "Static_SkinImage")
    slot:SetEnable(true)
    self._ui.btn_LookChange_Slot[index] = {_slot = slot, _icon = slotImage}
  end
  Panel_Window_FairySkinChange_All:SetDragAll(true)
  self._ui.btn_LookChange = UI.getChildControl(Panel_Window_FairySkinChange_All, "Button_LookChange")
  self._ui._pc.btn_Win_Close = UI.getChildControl(self._ui.stc_TitleArea, "Button_Close")
  self._ui.stc_SkinSkillBG = UI.getChildControl(Panel_Window_FairySkinChange_All, "Static_FairySkinSelectBG")
  self._ui.stc_SkinSkill = UI.getChildControl(self._ui.stc_SkinSkillBG, "Static_SkinSkill")
  self._ui.txt_SkinSkillName = UI.getChildControl(self._ui.stc_SkinSkillBG, "StaticText_SkinSkillName")
  self._ui.txt_Info = UI.getChildControl(Panel_Window_FairySkinChange_All, "StaticText_Info")
  self._ui.stc_Select = UI.getChildControl(Panel_Window_FairySkinChange_All, "Static_Select")
  self.panelSizeY = Panel_Window_FairySkinChange_All:GetSizeY()
  self.txt_InfoPosY = self._ui.txt_Info:GetPosY()
  self.btn_LookChangePosY = self._ui.btn_LookChange:GetPosY()
  PaGlobal_FairySkinChange_All:SetUiSetting()
  PaGlobal_FairySkinChange_All:registEventHandler()
  PaGlobal_FairySkinChange_All:validate()
end
function PaGlobal_FairySkinChange_All:SetUiSetting()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  for _, value in pairs(self._ui._pc) do
    value:SetShow(not _ContentsGroup_UsePadSnapping)
  end
  for _, value in pairs(self._ui._console) do
    value:SetShow(_ContentsGroup_UsePadSnapping)
  end
end
function PaGlobal_FairySkinChange_All:registEventHandler()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  local slotCount = PaGlobal_FairySkinChange_All._config._slotCount
  for index = 1, slotCount do
    self._ui.btn_LookChange_Slot[index]._slot:addInputEvent("Mouse_LUp", "InputMLUp_FairySkinChange_SelectSlot_All(" .. index .. ")")
    self._ui.btn_LookChange_Slot[index]._icon:addInputEvent("Mouse_LUp", "InputMLUp_FairySkinChange_SelectSlot_All(" .. index .. ")")
  end
  self._ui.btn_LookChange:addInputEvent("Mouse_LUp", "InputMLUp_FairySkinChange_SelectConfirm()")
  self._ui._pc.btn_Win_Close:addInputEvent("Mouse_LUp", "PaGlobal_FairySkinChange_Close_All()")
  registerEvent("FromClient_FairyChangeLookResult", "FromClient_FairyChangeLookResult")
end
function PaGlobal_FairySkinChange_All:prepareOpen()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  if true == ToClient_checkIsUnsealFairy() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNeedSealFairy"))
    return
  end
  PaGlobal_FairyPanel_ALL_Close()
  PaGlobal_FairySkinChange_All:initData()
  PaGlobal_FairySkinChange_All:updateSlotData()
  PaGlobal_FairySkinChange_All:open()
end
function PaGlobal_FairySkinChange_All:open()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  Panel_Window_FairySkinChange_All:SetShow(true)
end
function PaGlobal_FairySkinChange_All:prepareClose()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  PaGlobal_FairySkinChange_All:close()
end
function PaGlobal_FairySkinChange_All:close()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  Panel_Window_FairySkinChange_All:SetShow(false)
end
function PaGlobal_FairySkinChange_All:validate()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  local slotCount = PaGlobal_FairySkinChange_All._config._slotCount
  self._ui.stc_TitleArea:isValidate()
  self._ui.stc_SkinSkill:isValidate()
  self._ui.txt_SkinSkillName:isValidate()
  self._ui.stc_SkinSkillBG:isValidate()
  self._ui.txt_Info:isValidate()
  self._ui.stc_Select:isValidate()
  for index = 1, slotCount do
    self._ui.btn_LookChange_Slot[index]._slot:isValidate()
    self._ui.btn_LookChange_Slot[index]._icon:isValidate()
  end
end
function PaGlobal_FairySkinChange_All:initData()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  self._isDefaultSkin = ToClient_getIsFairyDefaultLook()
  self._skinCount = ToClient_getFairyChangeLookListSize()
  self._currentPage = 0
  self._selectDataIndex = nil
  local slotCount = PaGlobal_FairySkinChange_All._config._slotCount
  for index = 1, slotCount do
    self._ui.btn_LookChange_Slot[index]._slot:SetCheck(false)
  end
  self._ui.stc_SkinSkillBG:SetShow(false)
  local skinSkillSizeY = self._ui.stc_SkinSkillBG:GetSizeY()
  self._ui.txt_Info:SetPosY(self.txt_InfoPosY - skinSkillSizeY)
  self._ui.btn_LookChange:SetPosY(self.btn_LookChangePosY - skinSkillSizeY)
  Panel_Window_FairySkinChange_All:SetSize(Panel_Window_FairySkinChange_All:GetSizeX(), self.panelSizeY - skinSkillSizeY)
  self._ui.stc_Select:SetShow(false)
end
function PaGlobal_FairySkinChange_All:updateSlotData()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  local viewIndex = 0
  local startIndex = 1
  if 0 == self._isDefaultSkin and 0 == self._currentPage then
    local iconPath = PaGlobal_FairySkinChange_All._config._defaultSkinPath
    if nil ~= iconPath then
      self._ui.btn_LookChange_Slot[1]._icon:ChangeTextureInfoNameDefault(iconPath)
      self._ui.btn_LookChange_Slot[1]._slot:SetShow(true)
      self._ui.btn_LookChange_Slot[1]._dataIndex = -1
      startIndex = startIndex + 1
      viewIndex = viewIndex + 1
    end
  end
  local slotCount = PaGlobal_FairySkinChange_All._config._slotCount
  local dataIndex = 0
  local currentIndex = ToClient_getCurrentFairyLookIndex()
  for index = startIndex, slotCount do
    if dataIndex >= self._skinCount then
      self._ui.btn_LookChange_Slot[index]._slot:SetShow(false)
    else
      local actionIndex = ToClient_getFairyChangeLookIndex(dataIndex)
      local lookData = ToClient_getFairyChangeLookElementByIndex(dataIndex)
      if nil ~= lookData and currentIndex ~= actionIndex then
        self._ui.btn_LookChange_Slot[index]._icon:ChangeTextureInfoNameDefault(lookData:getIconPath1())
        self._ui.btn_LookChange_Slot[index]._slot:SetShow(true)
        self._ui.btn_LookChange_Slot[index]._dataIndex = dataIndex
        local nextLookPosX = self._ui.btn_LookChange_Slot[1]._slot:GetSizeX() * viewIndex + 10 * viewIndex
        self._ui.btn_LookChange_Slot[index]._slot:SetPosX(self._ui.btn_LookChange_Slot[1]._slot:GetPosX() + nextLookPosX)
        viewIndex = viewIndex + 1
      else
        self._ui.btn_LookChange_Slot[index]._slot:SetShow(false)
      end
      dataIndex = dataIndex + 1
    end
  end
end
function PaGlobal_FairySkinChange_All:selectSlot(slotIndex)
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  if nil == self._ui.btn_LookChange_Slot[slotIndex] then
    return
  end
  local currentDataCount = self._skinCount
  if 0 == self._isDefaultSkin then
    currentDataCount = currentDataCount + 1
  end
  if nil == self._ui.btn_LookChange_Slot[slotIndex]._dataIndex then
    return
  end
  for index = 1, self._config._slotCount do
    self._ui.btn_LookChange_Slot[index]._slot:SetCheck(false)
  end
  self._ui.btn_LookChange_Slot[slotIndex]._slot:SetCheck(true)
  self._selectDataIndex = self._ui.btn_LookChange_Slot[slotIndex]._dataIndex
  self._ui.stc_Select:SetPosX(self._ui.btn_LookChange_Slot[slotIndex]._slot:GetPosX())
  self._ui.stc_Select:SetShow(true)
  local lookData = ToClient_getFairyChangeLookElementByIndex(self._selectDataIndex)
  if nil ~= lookData then
    if true == _ContentsGroup_FairyLookChangeSkill then
      local skillKey = lookData:getChangeLookSkillKey()
      if true == skillKey:isDefined() then
        self._ui.stc_SkinSkillBG:SetShow(true)
        local skinSkillSizeY = self._ui.stc_SkinSkillBG:GetSizeY()
        self._ui.txt_Info:SetPosY(self.txt_InfoPosY)
        self._ui.btn_LookChange:SetPosY(self.btn_LookChangePosY)
        Panel_Window_FairySkinChange_All:SetSize(Panel_Window_FairySkinChange_All:GetSizeX(), self.panelSizeY)
        local skillSSW = getSkillStaticStatus(skillKey:getSkillNo(), skillKey:getLevel())
        if nil ~= skillSSW then
          local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
          if nil ~= skillTypeSSW then
            local skillName = skillSSW:getName()
            if nil ~= skillName then
              local skillNameString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAIRY_CHANGELOOK_SELECT_SKILLNAME", "skillName", skillName)
              self._ui.txt_SkinSkillName:SetTextMode(__eTextMode_AutoWrap)
              self._ui.txt_SkinSkillName:SetText(skillNameString)
            else
              self._ui.txt_SkinSkillName:SetText("")
            end
          end
        end
      else
        self._ui.stc_SkinSkillBG:SetShow(false)
        local skinSkillSizeY = self._ui.stc_SkinSkillBG:GetSizeY()
        self._ui.txt_Info:SetPosY(self.txt_InfoPosY - skinSkillSizeY)
        self._ui.btn_LookChange:SetPosY(self.btn_LookChangePosY - skinSkillSizeY)
        Panel_Window_FairySkinChange_All:SetSize(Panel_Window_FairySkinChange_All:GetSizeX(), self.panelSizeY - skinSkillSizeY)
      end
    end
  else
    self._ui.stc_SkinSkillBG:SetShow(false)
    local skinSkillSizeY = self._ui.stc_SkinSkillBG:GetSizeY()
    self._ui.txt_Info:SetPosY(self.txt_InfoPosY - skinSkillSizeY)
    self._ui.btn_LookChange:SetPosY(self.btn_LookChangePosY - skinSkillSizeY)
    Panel_Window_FairySkinChange_All:SetSize(Panel_Window_FairySkinChange_All:GetSizeX(), self.panelSizeY - skinSkillSizeY)
  end
end
function PaGlobal_FairySkinChange_All:selectConfirm()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  if nil == self._selectDataIndex then
    return
  end
  local function ConfirmFairyLoockChange()
    ToClient_SelectFairyLookReq(self._selectDataIndex)
    PaGlobal_FairySkinChange_All:prepareClose()
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local actionIndex = ToClient_getFairyChangeLookIndex(self._selectDataIndex)
  local _content = ""
  if self.NoVoiceFairyAnctionIndex == actionIndex then
    _content = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_CHANGELOOK_INFO")
  else
    _content = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_CHANGELOOK_INFO_NORMAL")
  end
  local messageBoxData = {
    title = _title,
    content = _content,
    functionApply = ConfirmFairyLoockChange,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if false == _ContentsGroup_UsePadSnapping then
    MessageBox.showMessageBox(messageBoxData, nil, false, false)
  else
    MessageBox.showMessageBox(messageBoxData, nil, false, true)
  end
end
function PaGlobal_FairySkinChange_All:changeResult()
  if nil == Panel_Window_FairySkinChange_All then
    return
  end
  if true == Panel_Window_FairySkinChange_All:GetShow() then
    PaGlobal_FairySkinChange_All:prepareOpen()
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_LOOKCHANGED"))
  PaGlobalFunc_FairyInfo_UpdateFairyLook_ALL()
end
