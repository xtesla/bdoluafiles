local _panel = Panel_Customizing_InputName
_panel:ignorePadSnapMoveToOtherPanel()
local Customization_InputNameInfo = {
  _ui = {
    _edit_InputName = UI.getChildControl(_panel, "Edit_InputName"),
    _stc_InnerBG = UI.getChildControl(_panel, "Static_Inner"),
    _static_KeyGuideBg = UI.getChildControl(_panel, "Static_BottomGroup_ConsoleUI"),
    _statictext_Desc = UI.getChildControl(_panel, "StaticText_Desc1"),
    _chk_season = UI.getChildControl(_panel, "CheckButton_Season")
  },
  _checkValidInputName = false,
  _lastCheckedInputName = "",
  _defaultEditText = "",
  _defaultPanelSizeY = 410,
  _defaultInnerSizeY = 250,
  _createSync = true
}
function PaGlobalFunc_Customization_InputName_SetCreateSync(isSync)
  local self = Customization_InputNameInfo
  self._createSync = isSync
end
function PaGlobalFunc_Customization_InputName_Confirm(str)
  local self = Customization_InputNameInfo
  if false == self._createSync then
    return
  end
  if false == self._checkValidInputName or self._lastCheckedInputName ~= self._ui._edit_InputName:GetEditText() then
    local messageBoxData = {
      title = msgTitle,
      content = PAGetString(Defines.StringSheet_GAME, "LUA_DUPLICATIONNAME_CHECK_ALARM"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    self._checkValidInputName = false
    self._lastCheckedInputName = ""
    return
  end
  ClearFocusEdit()
  local nameStr = str
  if nil == nameStr then
    nameStr = self._ui._edit_InputName:GetEditText()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  PaGlobalFunc_ClassSelect_CharacterCreate(nameStr)
end
function PaGlobalFunc_Customization_InputName_CheckDuplicate()
  local self = Customization_InputNameInfo
  if nil == self or false == Panel_Customizing_InputName:GetShow() or false == self._createSync then
    return
  end
  local userInput = self._ui._edit_InputName:GetEditText()
  if nil == userInput or "" == userInput then
    return
  end
  ToClient_CheckOverlapChangeName(userInput, 0, true)
end
function FromClient_DuplicatedInputName_Result(type, isCreate, isPossible)
  if false == isCreate then
    return
  end
  local self = Customization_InputNameInfo
  if nil == self or false == Panel_Customizing_InputName:GetShow() or false == self._createSync then
    return
  end
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_TITLE_CHARACTER")
  local messageBoxMemo = ""
  if true == isPossible then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DUPLICATIONNAME_CREATE_POSSIBLE")
    self._checkValidInputName = true
    self._lastCheckedInputName = self._ui._edit_InputName:GetEditText()
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DUPLICATIONNAME_CREATE_IMPOSSIBLE")
    self._checkValidInputName = false
    self._lastCheckedInputName = ""
  end
  local messageBoxData = {
    title = msgTitle,
    content = messageBoxMemo,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function Customization_InputNameInfo:Initialize()
  self:InitControl()
  self:InitEvent()
  self:InitRegister()
  self:InitString()
  self._defaultPanelSizeY = _panel:GetSizeY()
  self._defaultInnerSizeY = self._ui._stc_InnerBG:GetSizeY()
  self._ui._edit_InputName:SetMaxInput(getGameServiceTypeCharacterNameLength())
  self:SetPanel()
end
function Customization_InputNameInfo:SetPanel()
  local canMakeSeasonCharacter = PaGlobalFunc_Customization_InputName_CanMakeSeasonCharacter()
  if 120 < self._ui._statictext_Desc:GetTextSizeY() then
    local addSizeY = self._ui._statictext_Desc:GetTextSizeY() - 120
    if true == canMakeSeasonCharacter then
      self._ui._chk_season:SetPosY(self._ui._statictext_Desc:GetPosY() + self._ui._statictext_Desc:GetTextSizeY() + 10)
      addSizeY = addSizeY + self._ui._chk_season:GetSizeY() + 10
    end
    _panel:SetSize(_panel:GetSizeX(), self._defaultPanelSizeY + addSizeY)
    self._ui._stc_InnerBG:SetSize(self._ui._stc_InnerBG:GetSizeX(), self._defaultInnerSizeY + addSizeY)
    _panel:ComputePosAllChild()
  end
  if true == canMakeSeasonCharacter then
    self._ui._chk_season:SetShow(true)
    self._ui._button_Season:SetShow(true)
  else
    self._ui._chk_season:SetShow(false)
    self._ui._button_Season:SetShow(false)
  end
  local keyGuides = {
    self._ui._button_Season,
    self._ui._button_Duplicate,
    self._ui._button_Confirm,
    self._ui._button_Cancel
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._static_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_CENTER)
  if true == canMakeSeasonCharacter and self._ui._button_Season:GetPosX() < 0 then
    self._ui._button_Season:SetVerticalTop()
    self._ui._button_Duplicate:SetVerticalTop()
    self._ui._button_Confirm:SetVerticalTop()
    self._ui._button_Cancel:SetVerticalTop()
    local keyGuide = {
      self._ui._button_Duplicate,
      self._ui._button_Confirm,
      self._ui._button_Cancel
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._static_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_CENTER)
    local centerPos = self._ui._static_KeyGuideBg:GetSizeX() * 0.5
    local keyGuideSizeX = self._ui._button_Season:GetSizeX() + self._ui._button_Season:GetTextSizeX() + 10
    local keyGuideSizeY = self._ui._button_Season:GetSizeY()
    self._ui._button_Season:SetPosX(centerPos - keyGuideSizeX * 0.5)
    self._ui._button_Season:SetPosY(keyGuideSizeY + 10)
    _panel:SetSize(_panel:GetSizeX(), _panel:GetSizeY() + 20)
  else
    if true == canMakeSeasonCharacter then
      self._ui._button_Season:SetVerticalMiddle()
    end
    self._ui._button_Duplicate:SetVerticalMiddle()
    self._ui._button_Confirm:SetVerticalMiddle()
    self._ui._button_Cancel:SetVerticalMiddle()
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._static_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_CENTER)
  end
end
function Customization_InputNameInfo:InitControl()
  self._ui._button_Season = UI.getChildControl(self._ui._static_KeyGuideBg, "Button_Season_ConsoleUI")
  self._ui._button_Duplicate = UI.getChildControl(self._ui._static_KeyGuideBg, "StaticText_LS_ConsoleUI")
  self._ui._button_Confirm = UI.getChildControl(self._ui._static_KeyGuideBg, "Button_OK_ConsoleUI")
  self._ui._button_Cancel = UI.getChildControl(self._ui._static_KeyGuideBg, "Button_NO_ConsoleUI")
end
function Customization_InputNameInfo:InitEvent()
  self._ui._button_Duplicate:addInputEvent("Mouse_LUp", "PaGlobalFunc_Customization_InputName_CheckDuplicate()")
  self._ui._button_Confirm:addInputEvent("Mouse_LUp", "PaGlobalFunc_Customization_InputName_Confirm()")
  self._ui._button_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_Customization_InputName_Close()")
  _panel:registerPadEvent(__eConsoleUIPadEvent_LSClick, "PaGlobalFunc_Customization_InputName_CheckDuplicate()")
  _panel:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_Customization_InputName_Confirm()")
  _panel:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_Customization_InputName_SetFocus()")
  if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
    _panel:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_Customization_InputName_CheckSeasonCharacter()")
  end
  self._ui._edit_InputName:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_Customization_InputName_KeyboardEnd")
  self._ui._edit_InputName:RegistReturnKeyEvent("PaGlobalFunc_Customization_InputName_Confirm()")
  PaGlobal_registerPanelOnBlackBackground(_panel)
end
function Customization_InputNameInfo:InitRegister()
  registerEvent("FromClient_CreateCharacterFail", "PaGlobalFunc_FromClient_Customization_InputName_CreateCharacterFail")
  registerEvent("FromClient_notifyChangeNameResult", "FromClient_DuplicatedInputName_Result")
end
function Customization_InputNameInfo:InitString()
  self._defaultEditText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CUSTOMIZATION_INPUTNAME_EDITTEXT", "maxLength", getGameServiceTypeCharacterNameLength())
  self._ui._statictext_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._statictext_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHANGENAME_CONSOLE_TEXTBIND"))
end
function PaGlobalFunc_FromClient_Customization_InputName_CreateCharacterFail()
  PaGlobalFunc_Customization_InputName_SetCreateSync(true)
end
function PaGlobalFunc_Customization_InputName_KeyboardEnd(str)
  local self = Customization_InputNameInfo
  if getGameServiceTypeCharacterNameLength() < getWstringLength(str) then
    str = getMaxSliceString(getGameServiceTypeCharacterNameLength())
  end
  self._ui._edit_InputName:SetEditText(str)
  ClearFocusEdit()
  self._ui._edit_InputName:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_Customization_InputName_SetFocus()")
end
function PaGlobalFunc_Customization_InputName_SetFocus()
  local self = Customization_InputNameInfo
  if false == self._createSync then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  self._ui._edit_InputName:SetEditText("")
  SetFocusEdit(self._ui._edit_InputName)
end
function PaGlobalFunc_FromClient_Customization_InputName_luaLoadComplete()
  local self = Customization_InputNameInfo
  self:Initialize()
end
function PaGlobalFunc_Customization_InputName_ForcedClose()
  ClearFocusEdit()
  PaGlobalFunc_Customization_InputName_SetCreateSync(true)
  PaGlobalFunc_Customization_SetCloseFunc(nil)
  PaGlobalFunc_Customization_SetBackEvent()
  PaGlobalFunc_Customization_InputName_SetShow(false, false)
end
function PaGlobalFunc_Customization_InputName_Close(clearStr)
  local self = Customization_InputNameInfo
  if false == PaGlobalFunc_Customization_InputName_GetShow() then
    return false
  end
  if true == self._ui._edit_InputName:GetFocusEdit() then
    ClearFocusEdit()
    return false
  end
  PaGlobalFunc_Customization_InputName_SetCreateSync(true)
  if nil == clearStr or true == clearStr then
    self._ui._edit_InputName:SetEditText("")
  end
  PaGlobalFunc_Customization_SetCloseFunc(nil)
  PaGlobalFunc_Customization_SetBackEvent()
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  PaGlobalFunc_Customization_InputName_SetShow(false, false)
  return true
end
function PaGlobalFunc_Customization_InputName_Open(clearStr)
  local self = Customization_InputNameInfo
  if nil == clearStr or true == clearStr then
    self._ui._edit_InputName:SetEditText("")
    self._ui._edit_InputName:SetText(self._defaultEditText)
  end
  if true == PaGlobalFunc_Customization_InputName_GetShow() then
    return
  end
  self._checkValidInputName = false
  self._lastCheckedInputName = ""
  ToClient_padSnapChangeToTarget(self._ui._button_Confirm)
  self:SetPanel()
  if true == self._ui._chk_season:GetShow() then
    self._ui._chk_season:SetCheck(true)
  end
  PaGlobalFunc_Customization_SetCloseFunc(PaGlobalFunc_Customization_InputName_Close)
  PaGlobalFunc_Customization_SetBackEvent("PaGlobalFunc_Customization_InputName_Close()")
  _AudioPostEvent_SystemUiForXBOX(8, 14)
  PaGlobalFunc_Customization_InputName_SetShow(true, false)
end
function PaGlobalFunc_Customization_InputName_SetShow(isShow, isAni)
  Panel_Customizing_InputName:SetShow(isShow, isAni)
end
function PaGlobalFunc_Customization_InputName_GetShow()
  return Panel_Customizing_InputName:GetShow()
end
function PaGlobalFunc_Customization_InputName_CheckSeasonCharacter()
  if false == _ContentsGroup_SeasonContents and false == _ContentsGroup_PreSeason then
    return
  end
  local self = Customization_InputNameInfo
  local currentChecked = self._ui._chk_season:IsCheck()
  self._ui._chk_season:SetCheck(not currentChecked)
end
function PaGlobalFunc_Customization_InputName_GetSeasonCharacterChecked()
  return Customization_InputNameInfo._ui._chk_season:IsCheck()
end
function PaGlobalFunc_Customization_InputName_CanMakeSeasonCharacter()
  if nil ~= FGlobal_getIsSpecialCharacter and true == FGlobal_getIsSpecialCharacter() then
    return false
  end
  if nil ~= PaGlobalFunc_CharacterSelect_All_CanMakeSeason and false == PaGlobalFunc_CharacterSelect_All_CanMakeSeason() then
    return false
  end
  return true
end
PaGlobalFunc_FromClient_Customization_InputName_luaLoadComplete()
