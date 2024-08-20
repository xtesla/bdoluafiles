local UIMode = Defines.UIMode
local IM = CppEnums.EProcessorInputMode
PaGlobal_ChangeNickName_All = {
  _ui = {
    stc_blockBg = nil,
    stc_TitleBg = nil,
    stc_SubBg = nil,
    stc_Illust = nil,
    txt_characterName = nil,
    txt_familyName = nil,
    btn_Apply = nil,
    btn_Cancel = nil,
    btn_Duplication_pc = nil,
    edit_Nickname = nil,
    txt_Title = nil,
    txt_Desc = nil,
    txt_ConditionDesc = nil,
    stc_Bottom_Keyguides = nil,
    stc_KeyGuide_X = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil,
    stc_KeyGuide_Y = nil
  },
  _originSpanSize = {
    txt_ConditionDesc = 0,
    edit_Nickname = 0,
    btn_Duplication_pc = 0
  },
  _originEditNameSizeX = 0,
  _isValidChangeName = false,
  _checkedValidChangeName = "",
  _itemType = 0,
  _isConsole = false,
  _elapsedTime = 0,
  _updatetime = 0.2,
  _isChangeNickName = false,
  _forceSetMode = false
}
local changeNameType = {
  _characterName = 0,
  _guildName = 1,
  _nickName = 2,
  _quickChangeNickName = 3
}
function PaGlobal_ChangeNickName_All_Init()
  PaGlobal_ChangeNickName_All:initailze()
end
registerEvent("FromClient_luaLoadComplete", "PaGlobal_ChangeNickName_All_Init")
function PaGlobal_ChangeNickName_All:initailze()
  if true == PaGlobal_ChangeNickName_All._initialize then
    return
  end
  self._ui.stc_blockBg = UI.getChildControl(Panel_Change_Nickname_All, "Static_BlockBg")
  self._ui.stc_TitleBg = UI.getChildControl(Panel_Change_Nickname_All, "Static_TitleBg")
  self._ui.stc_SubBg = UI.getChildControl(Panel_Change_Nickname_All, "Static_SubFrame")
  self._ui.stc_Illust = UI.getChildControl(Panel_Change_Nickname_All, "Static_Illust")
  self._ui.txt_characterName = UI.getChildControl(self._ui.stc_Illust, "StaticText_CharacterName")
  self._ui.txt_familyName = UI.getChildControl(self._ui.stc_Illust, "StaticText_AccountName")
  self._ui.btn_Apply = UI.getChildControl(Panel_Change_Nickname_All, "Button_Apply_PCUI")
  self._ui.btn_Cancel = UI.getChildControl(Panel_Change_Nickname_All, "Button_Cancel_PCUI")
  self._ui.btn_Duplication_pc = UI.getChildControl(Panel_Change_Nickname_All, "Button_Duplication")
  self._ui.edit_Nickname = UI.getChildControl(Panel_Change_Nickname_All, "Edit_Nickname")
  self._originEditNameSizeX = self._ui.edit_Nickname:GetSizeX()
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_TitleBg, "Static_Text_Title_Import")
  self._ui.txt_Desc = UI.getChildControl(Panel_Change_Nickname_All, "StaticText_ChangeNameDesc")
  self._ui.txt_ConditionDesc = UI.getChildControl(Panel_Change_Nickname_All, "StaticText_ChangeNameCondition")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.edit_Nickname, "Static_X_ConsoleUI")
  self._ui.stc_Bottom_Keyguides = UI.getChildControl(Panel_Change_Nickname_All, "Static_BottomBg_ConsoleUI")
  self._ui.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_Bottom_Keyguides, "StaticText_Y_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_Bottom_Keyguides, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_Bottom_Keyguides, "StaticText_B_ConsoleUI")
  self._ui.stc_bottomBg = UI.getChildControl(Panel_Change_Nickname_All, "Static_BottomBg")
  self._ui.stc_blackSpirit = UI.getChildControl(self._ui.stc_bottomBg, "Static_BlackSpiritEffect")
  self._ui.stc_guideBubblePos = UI.getChildControl(self._ui.stc_bottomBg, "Static_GuideBubblePos")
  self._ui.stc_guideBubble = UI.getChildControl(self._ui.stc_guideBubblePos, "Static_GuideBubble")
  self._ui.stc_guideBubbleDesc = UI.getChildControl(self._ui.stc_guideBubble, "StaticText_Desc")
  self._ui.stc_guideBubbleDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_bottomBg:SetShow(false)
  self._ui.stc_guideBubbleDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_BLACKSPIRIT_ASK"))
  local descX = self._ui.stc_guideBubbleDesc:GetTextSizeX()
  local descY = self._ui.stc_guideBubbleDesc:GetTextSizeY()
  self._ui.stc_guideBubble:SetSize(descX + 30, descY + 30)
  self._ui.stc_guideBubble:ComputePos()
  self._ui.stc_guideBubbleDesc:ComputePos()
  self._originSpanSize.txt_ConditionDesc = self._ui.txt_ConditionDesc:GetSpanSize().y
  self._originSpanSize.edit_Nickname = self._ui.edit_Nickname:GetSpanSize().y
  self._originSpanSize.btn_Duplication_pc = self._ui.btn_Duplication_pc:GetSpanSize().y
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._isChangeNickName = false
  self._forceSetMode = false
  PaGlobal_ChangeNickName_All:validate()
  PaGlobal_ChangeNickName_All:SwitchPlatform(self._isConsole)
  PaGlobal_ChangeNickName_All:registEventHandler(self._isConsole)
  PaGlobal_ChangeNickName_All._initialize = true
end
function PaGlobal_ChangeNickName_All:validate()
  if true == PaGlobal_ChangeNickName_All._initialize then
    return
  end
  self._ui.stc_blockBg:isValidate()
  self._ui.stc_TitleBg:isValidate()
  self._ui.stc_SubBg:isValidate()
  self._ui.stc_Illust:isValidate()
  self._ui.btn_Apply:isValidate()
  self._ui.btn_Cancel:isValidate()
  self._ui.btn_Duplication_pc:isValidate()
  self._ui.edit_Nickname:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.txt_ConditionDesc:isValidate()
  self._ui.stc_Bottom_Keyguides:isValidate()
  self._ui.stc_KeyGuide_X:isValidate()
  self._ui.stc_KeyGuide_Y:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
end
function PaGlobal_ChangeNickName_All:SwitchPlatform(isConsole)
  self._ui.stc_Bottom_Keyguides:SetShow(isConsole)
  self._ui.stc_KeyGuide_B:SetShow(isConsole)
  self._ui.stc_KeyGuide_X:SetShow(isConsole)
  self._ui.stc_KeyGuide_Y:SetShow(isConsole)
  self._ui.stc_KeyGuide_A:SetShow(isConsole)
  self._ui.btn_Apply:SetShow(not isConsole)
  self._ui.btn_Cancel:SetShow(not isConsole)
  self._ui.btn_Duplication_pc:SetShow(not isConsole)
  local keyGuides = {
    self._ui.stc_KeyGuide_Y,
    self._ui.stc_KeyGuide_A,
    self._ui.stc_KeyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_Bottom_Keyguides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_ChangeNickName_All:refreshUiSize(isConsole)
end
function PaGlobal_ChangeNickName_All:refreshUiSize(isConsole)
  if true == isConsole then
    self._ui.edit_Nickname:SetSize(self._originEditNameSizeX + 150, self._ui.edit_Nickname:GetSizeY())
    self._ui.stc_KeyGuide_X:ComputePos()
  else
    self._ui.edit_Nickname:SetSize(self._originEditNameSizeX, self._ui.edit_Nickname:GetSizeY())
  end
  self._ui.edit_Nickname:ComputePos()
end
function PaGlobal_ChangeNickName_All:registEventHandler(isConsole)
  self._ui.edit_Nickname:SetMaxInput(getGameServiceTypeUserNickNameLength())
  registerEvent("FromClient_ShowChangeNickname", "FromClient_ChangeNickname_All_ShowCheck")
  registerEvent("FromClient_ChangeName", "FromClient_ChangeNickname_All_ChangeSuccess")
  registerEvent("onScreenResize", "FromClient_ChangeNickname_All_OnScreenResize")
  registerEvent("FromClient_notifyChangeNameResult", "FromClient_ChangeNickname_All_NotifyChangeNameResult")
  registerEvent("FromCient_CompleteForceFamilyNameSetLevelCondition", "FromCient_CompleteForceFamilyNameSetLevelCondition")
  Panel_Change_Nickname_All:RegisterUpdateFunc("PaGlobal_ChangeNickName_All_UpdateFamilyNamePerFrame")
  if true == isConsole then
    Panel_Change_Nickname_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ChangeNickNameAll_CheckOverlap()")
    Panel_Change_Nickname_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ChangeNickNameAll_ChangeNickName()")
    Panel_Change_Nickname_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_ChangeNickNameAll_ClearEdit()")
    self._ui.edit_Nickname:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_ChangeNickNameAll_ChangeNickName_Console")
    self._ui.edit_Nickname:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ChangeNickNameAll_ChangeNickName()")
  else
    self._ui.edit_Nickname:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeNickNameAll_ClearEdit()")
    self._ui.btn_Apply:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeNickNameAll_ChangeNickName()")
    self._ui.btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeNickNameAll_Close()")
    self._ui.btn_Duplication_pc:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeNickNameAll_CheckOverlap()")
  end
end
function PaGlobal_ChangeNickName_All:prepareOpen()
  if true == PaGlobal_ChangeNickName_All._isConsole then
    ToClient_padSnapChangeToTarget(self._ui.stc_KeyGuide_A)
  end
  self._ui.edit_Nickname:SetEditText("")
  self._isValidChangeName = false
  self._checkedValidChangeName = ""
  PaGlobal_ChangeNickName_All:refreshUiSize(self._isConsole)
  PaGlobal_ChangeNickName_All:open()
  FromClient_ChangeNickname_All_OnScreenResize()
end
function PaGlobal_ChangeNickName_All:open()
  Panel_Change_Nickname_All:SetShow(true)
end
function PaGlobal_ChangeNickName_All:prepareClose()
  if true == _forceSetMode then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TEMPFAMILYNAME_MSG"))
    return
  end
  self._ui.edit_Nickname:SetEditText("")
  PaGlobal_ChangeNickName_All._itemType = 0
  ClearFocusEdit()
  CheckChattingInput()
  PaGlobal_ChangeNickName_All:close()
end
function PaGlobal_ChangeNickName_All:close()
  Panel_Change_Nickname_All:SetShow(false)
end
function PaGlobal_ChangeNickName_All_UpdateFamilyNamePerFrame(deltaTime)
  local self = PaGlobal_ChangeNickName_All
  local nameType = self._itemType
  if changeNameType._quickChangeNickName ~= nameType then
    return
  end
  self._elapsedTime = self._elapsedTime + deltaTime
  if self._elapsedTime < self._updatetime then
    return
  end
  self._elapsedTime = 0
  local currentStr = self._ui.edit_Nickname:GetEditText()
  self._ui.txt_familyName:SetText(currentStr)
end
function HandleEventLUp_ChangeNickNameAll_Close()
  if false == Panel_Change_Nickname_All:GetShow() then
    return
  end
  PaGlobal_ChangeNickName_All:prepareClose()
end
function HandleEventPadPress_ChangeNickNameAll_Close()
  if false == Panel_Change_Nickname_All:GetShow() or false == PaGlobal_ChangeNickName_All._isConsole then
    return
  end
  PaGlobal_ChangeNickName_All:prepareClose()
end
function HandleEventLUp_ChangeNickNameAll_ClearEdit()
  if false == Panel_Change_Nickname_All:GetShow() then
    return
  end
  PaGlobal_ChangeNickName_All._ui.edit_Nickname:SetMaxInput(getGameServiceTypeUserNickNameLength())
  SetFocusEdit(PaGlobal_ChangeNickName_All._ui.edit_Nickname)
end
function PaGlobalFunc_ChangeNickNameAll_ChangeNickName_Console(str)
  if getGameServiceTypeUserNickNameLength() < string.len(str) then
    str = string.sub(str, 1, getGameServiceTypeUserNickNameLength())
  end
  PaGlobal_ChangeNickName_All._ui.edit_Nickname:SetEditText(str)
  ClearFocusEdit()
  HandleEventLUp_ChangeNickNameAll_ChangeNickName()
end
function HandleEventLUp_ChangeNickNameAll_ChangeNickName()
  if false == Panel_Change_Nickname_All:GetShow() then
    return
  end
  local userInput = PaGlobal_ChangeNickName_All._ui.edit_Nickname:GetEditText()
  if nil == userInput or "" == userInput then
    return
  end
  local _nameType = PaGlobal_ChangeNickName_All._itemType
  local msgTitle = ""
  if changeNameType._characterName == _nameType then
    msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_TITLE_CHARACTER")
  elseif changeNameType._guildName == _nameType then
    msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_TITLE_GUILD")
  elseif changeNameType._nickName == _nameType then
    msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_TITLE_FAMILY")
  elseif changeNameType._quickChangeNickName == _nameType then
    msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_TITLE_FAMILY")
  end
  if false == PaGlobal_ChangeNickName_All._isValidChangeName or userInput ~= PaGlobal_ChangeNickName_All._checkedValidChangeName then
    local messageBoxData = {
      title = msgTitle,
      content = PAGetString(Defines.StringSheet_GAME, "LUA_DUPLICATIONNAME_CHECK_ALARM"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    PaGlobal_ChangeNickName_All._isValidChangeName = false
    PaGlobal_ChangeNickName_All._checkedValidChangeName = ""
    return
  end
  if true == PaGlobal_ChangeNickName_All._isConsole then
    ClearFocusEdit()
  end
  local function toClient_ChangeName()
    if changeNameType._characterName == _nameType then
      ToClient_RequestChangeCharacterName(userInput)
      PaGlobal_ChangeNickName_All._isChangeNickName = false
    elseif changeNameType._guildName == _nameType then
      ToClient_RequestChangeGuildName(userInput)
      PaGlobal_ChangeNickName_All._isChangeNickName = false
    elseif changeNameType._nickName == _nameType then
      ToClient_ChangeNickName(userInput)
      PaGlobal_ChangeNickName_All._isChangeNickName = true
    elseif changeNameType._quickChangeNickName == _nameType then
      ToClient_QuickChangeUserNickName(userInput)
      PaGlobal_ChangeNickName_All._isChangeNickName = true
    end
    _forceSetMode = false
    HandleEventLUp_ChangeNickNameAll_Close()
  end
  local messageBoxMemo = ""
  local msgTitle = ""
  if changeNameType._characterName == _nameType then
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAMECHANGE_DESC_CHARACTER", "name", userInput)
  elseif changeNameType._guildName == _nameType then
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAMECHANGE_DESC_GUILD", "name", userInput)
  elseif changeNameType._nickName == _nameType then
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAMECHANGE_DESC_FAMILY", "name", userInput)
  elseif changeNameType._quickChangeNickName == _nameType then
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAMECHANGE_CONFIRM_SUB_DESC", "name", userInput)
  end
  local messageBoxData = {
    title = msgTitle,
    content = messageBoxMemo,
    functionYes = toClient_ChangeName,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if false == PaGlobal_ChangeNickName_All._isConsole then
    MessageBox.showMessageBox(messageBoxData, nil, nil, false)
  else
    MessageBox.showMessageBox(messageBoxData)
  end
end
function HandleEventLUp_ChangeNickNameAll_CheckOverlap()
  if false == Panel_Change_Nickname_All:GetShow() then
    return
  end
  local userInput = PaGlobal_ChangeNickName_All._ui.edit_Nickname:GetEditText()
  if nil == userInput or "" == userInput then
    return
  end
  if true == PaGlobal_ChangeNickName_All._isConsole then
    ClearFocusEdit()
  end
  local nameType = -1
  if 3 == PaGlobal_ChangeNickName_All._itemType then
    nameType = 2
  else
    nameType = PaGlobal_ChangeNickName_All._itemType
  end
  ToClient_CheckOverlapChangeName(userInput, nameType, false)
end
function FromClient_ChangeNickname_All_ChangeSuccess()
  if 2 == PaGlobal_ChangeNickName_All._itemType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_15"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_1"))
  end
end
function FromClient_ChangeNickname_All_ShowCheck(param)
  if changeNameType._nickName == param then
    local isAppled = PaGlobal_ChangeNickName_All_CheckAppliedNickNameChange()
    if false == isAppled then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDCHANGENICKNAME")
      local messageBoxData = {
        title = "",
        content = messageBoxMemo,
        functionYes = PaGlobal_ChangeNickName_All_OpenQuickNameChange,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
      return
    end
  end
  FromClient_ChangeNickname_All_Show(param)
end
function FromClient_ChangeNickname_All_Show(param)
  if true == Panel_Change_Nickname_All:GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_2"))
    return
  end
  PaGlobal_ChangeNickName_All._itemType = param
  local txt_Desc = PaGlobal_ChangeNickName_All._ui.txt_Desc
  local txt_Condition = PaGlobal_ChangeNickName_All._ui.txt_ConditionDesc
  local title = PaGlobal_ChangeNickName_All._ui.txt_Title
  local subBg = PaGlobal_ChangeNickName_All._ui.stc_SubBg
  local titleBg = PaGlobal_ChangeNickName_All._ui.stc_TitleBg
  local illust = PaGlobal_ChangeNickName_All._ui.stc_Illust
  local editText = PaGlobal_ChangeNickName_All._ui.edit_Nickname
  local btn_Duplication_pc = PaGlobal_ChangeNickName_All._ui.btn_Duplication_pc
  txt_Condition:SetTextMode(__eTextMode_AutoWrap)
  txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_ChangeNickName_All._ui.stc_bottomBg:SetShow(false)
  if changeNameType._characterName == param then
    title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_3"))
    txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_4"))
    local defaultNameChangeText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAMECHANGE_5_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypeCharacterNameLength()))
    local isNameChangeText = defaultNameChangeText
    if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeRussia() or isGameTypeID() or isGameTypeTR() or isGameTypeJapan() or isGameTypeEnglish() then
      isNameChangeText = defaultNameChangeText .. [[


<PAColor0xFFF26A6A>]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING") .. "<PAOldColor>"
    else
      isNameChangeText = defaultNameChangeText
    end
    txt_Condition:SetText(isNameChangeText)
  elseif changeNameType._guildName == param then
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    if false == isGuildMaster then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_6"))
      return
    end
    title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_7"))
    txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_8"))
    local defaultNameChangeText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAMECHANGE_9_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypeGuildNameLength()))
    local isNameChangeText = defaultNameChangeText
    if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeRussia() or isGameTypeID() or isGameTypeTR() or isGameTypeJapan() or isGameTypeEnglish() then
      isNameChangeText = defaultNameChangeText .. [[


<PAColor0xFFF26A6A>]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING") .. "<PAOldColor>"
    else
      isNameChangeText = defaultNameChangeText
    end
    txt_Condition:SetText(isNameChangeText)
  elseif changeNameType._nickName == param then
    if false == PaGlobal_ChangeNickName_All_CheckAndOpenQuickNameChange() then
      return
    end
    title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHANGE_NICKNAME_TITLE"))
    txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NICKNAME_NOTIFY_1"))
    local defaultNameChangeText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NICKNAME_NOTIFY_3_WARING_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypeUserNickNameLength()))
    local isNameChangeText = defaultNameChangeText
    if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeRussia() or isGameTypeID() or isGameTypeTR() or isGameTypeJapan() or isGameTypeEnglish() then
      isNameChangeText = defaultNameChangeText .. [[


<PAColor0xFFF26A6A>]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING") .. "<PAOldColor>"
    else
      isNameChangeText = defaultNameChangeText
    end
    txt_Condition:SetText(isNameChangeText)
  elseif changeNameType._quickChangeNickName == param then
    local selfPlayer = getSelfPlayer()
    if nil ~= selfPlayer then
      local characterName = selfPlayer:getOriginalName()
      if nil ~= characterName and "" ~= characterName then
        PaGlobal_ChangeNickName_All._ui.txt_characterName:SetText(characterName)
      end
    end
    PaGlobal_ChangeNickName_All._ui.stc_blackSpirit:EraseAllEffect()
    PaGlobal_ChangeNickName_All._ui.stc_blackSpirit:AddEffect("fN_DarkSpirit_Gage_01C", true, 0, 0)
    title:SetText("")
    txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_4_INSTEP"))
    local defaultNameChangeText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAMECHANGE_5_INSTEP", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypeUserNickNameLength()))
    local isNameChangeText = defaultNameChangeText
    if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeRussia() or isGameTypeID() or isGameTypeTR() or isGameTypeJapan() or isGameTypeEnglish() then
      isNameChangeText = defaultNameChangeText .. [[


<PAColor0xFFF26A6A>]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING") .. "<PAOldColor>"
    else
      isNameChangeText = defaultNameChangeText
    end
    txt_Condition:SetText(isNameChangeText)
    PaGlobal_ChangeNickName_All._ui.stc_bottomBg:SetShow(true)
  end
  if false == self._isConsole then
    SetFocusEdit(PaGlobal_ChangeNickName_All._ui.edit_Nickname)
  end
  local textSizeY = txt_Desc:GetTextSizeY() + txt_Condition:GetTextSizeY()
  local offsetSizeY = 0
  if true == PaGlobal_ChangeNickName_All._isConsole then
    local consoleOffsetY = 100
    offsetSizeY = math.max(illust:GetSizeY(), textSizeY + consoleOffsetY)
    subBg:SetSize(subBg:GetSizeX(), offsetSizeY)
    Panel_Change_Nickname_All:SetSize(Panel_Change_Nickname_All:GetSizeX(), titleBg:GetSizeY() + offsetSizeY)
    local btnSizeY = PaGlobal_ChangeNickName_All._ui.btn_Apply:GetSizeY() + 20
    txt_Condition:SetSpanSize(txt_Condition:GetSpanSize().x, PaGlobal_ChangeNickName_All._originSpanSize.txt_ConditionDesc - btnSizeY)
    editText:SetSpanSize(editText:GetSpanSize().x, PaGlobal_ChangeNickName_All._originSpanSize.edit_Nickname - btnSizeY)
    btn_Duplication_pc:SetSpanSize(btn_Duplication_pc:GetSpanSize().x, PaGlobal_ChangeNickName_All._originSpanSize.btn_Duplication_pc - btnSizeY)
    InventoryWindow_Close()
  else
    local pcOffsetY = 170
    offsetSizeY = math.max(illust:GetSizeY(), textSizeY + pcOffsetY)
    subBg:SetSize(subBg:GetSizeX(), offsetSizeY)
    Panel_Change_Nickname_All:SetSize(Panel_Change_Nickname_All:GetSizeX(), titleBg:GetSizeY() + offsetSizeY)
  end
  FromClient_ChangeNickname_All_OnScreenResize()
  PaGlobal_ChangeNickName_All:prepareOpen()
end
function FromClient_ChangeNickname_All_OnScreenResize()
  if false == Panel_Change_Nickname_All:GetShow() then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  PaGlobal_ChangeNickName_All._ui.stc_blockBg:SetSize(screenSizeX + 500, screenSizeY + 500)
  PaGlobal_ChangeNickName_All._ui.stc_blockBg:SetSpanSize(0, 0)
  PaGlobal_ChangeNickName_All._ui.stc_blockBg:ComputePos()
  PaGlobal_ChangeNickName_All._ui.txt_Title:ComputePos()
  PaGlobal_ChangeNickName_All._ui.stc_SubBg:ComputePos()
  PaGlobal_ChangeNickName_All._ui.txt_Desc:ComputePos()
  PaGlobal_ChangeNickName_All._ui.txt_ConditionDesc:ComputePos()
  PaGlobal_ChangeNickName_All._ui.stc_TitleBg:ComputePos()
  PaGlobal_ChangeNickName_All._ui.stc_Illust:ComputePos()
  PaGlobal_ChangeNickName_All._ui.stc_blockBg:ComputePos()
  PaGlobal_ChangeNickName_All._ui.btn_Apply:ComputePos()
  PaGlobal_ChangeNickName_All._ui.btn_Cancel:ComputePos()
  PaGlobal_ChangeNickName_All._ui.stc_Bottom_Keyguides:ComputePos()
  PaGlobal_ChangeNickName_All._ui.edit_Nickname:ComputePos()
  PaGlobal_ChangeNickName_All._ui.btn_Duplication_pc:ComputePos()
end
function FromClient_ChangeNickname_All_NotifyChangeNameResult(type, isCreate, isPossible)
  if true == isCreate then
    return
  end
  local messageBoxMemo = ""
  local msgTitle = ""
  if 0 == type then
    msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_TITLE_CHARACTER")
  elseif 1 == type then
    msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_TITLE_GUILD")
  elseif 2 == type then
    msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_TITLE_FAMILY")
  elseif 3 == type then
    msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_TITLE_FAMILY")
  end
  if true == isPossible then
    PaGlobal_ChangeNickName_All._isValidChangeName = true
    PaGlobal_ChangeNickName_All._checkedValidChangeName = PaGlobal_ChangeNickName_All._ui.edit_Nickname:GetEditText()
  else
    PaGlobal_ChangeNickName_All._isValidChangeName = false
    PaGlobal_ChangeNickName_All._checkedValidChangeName = ""
  end
  if true == isCreate then
    if true == isPossible then
      messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DUPLICATIONNAME_CREATE_POSSIBLE")
    else
      messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DUPLICATIONNAME_CREATE_IMPOSSIBLE")
    end
  elseif true == isPossible then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DUPLICATIONNAME_CHANGE_POSSIBLE")
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DUPLICATIONNAME_CHANGE_IMPOSSIBLE")
  end
  local messageBoxData = {
    title = msgTitle,
    content = messageBoxMemo,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if false == PaGlobal_ChangeNickName_All._isConsole then
    MessageBox.showMessageBox(messageBoxData, nil, nil, false)
  else
    MessageBox.showMessageBox(messageBoxData)
  end
end
function FromCient_CompleteForceFamilyNameSetLevelCondition()
  if nil == Panel_Change_Nickname_All or nil == PaGlobal_ChangeNickName_All then
    return false
  end
  local isApplied = PaGlobal_ChangeNickName_All_CheckAppliedNickNameChange()
  if false == isApplied then
    _forceSetMode = true
    PaGlobal_ChangeNickName_All_OpenQuickNameChange()
  end
end
function PaGlobal_ChangeNickName_All_CheckAppliedNickNameChange()
  if nil == Panel_Change_Nickname_All then
    return false
  end
  local selfProxyWrapper = getSelfPlayer()
  if nil == selfProxyWrapper then
    return false
  end
  local isAppliedNickNameChange = selfProxyWrapper:isAppliedNickNameChange()
  if false == isAppliedNickNameChange then
    return false
  end
  return true
end
function PaGlobal_ChangeNickName_All_OpenQuickNameChange()
  if nil == Panel_Change_Nickname_All then
    return
  end
  local quickChangeNickNameType = 3
  if nil ~= FromClient_ChangeNickname_All_Show then
    FromClient_ChangeNickname_All_Show(quickChangeNickNameType)
  end
end
function PaGlobal_ChangeNickName_All_CheckAndOpenQuickNameChange()
  if nil == Panel_Change_Nickname_All then
    return false
  end
  local isApplied = PaGlobal_ChangeNickName_All_CheckAppliedNickNameChange()
  if false == isApplied then
    PaGlobal_ChangeNickName_All_OpenQuickNameChange()
  end
  return isApplied
end
