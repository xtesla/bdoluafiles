function PaGlobal_Invite_All:initialize()
  if true == PaGlobal_Invite_All._initialize then
    return
  end
  self._ui.txt_title = UI.getChildControl(Panel_Window_Invite_All, "StaticText_Title")
  self._ui.btn_close = UI.getChildControl(Panel_Window_Invite_All, "Button_Close")
  self._ui.txt_desc = UI.getChildControl(Panel_Window_Invite_All, "StaticText_NameDesc")
  self._ui.stc_subBG = UI.getChildControl(Panel_Window_Invite_All, "Static_SubBg")
  self._ui.chk_familyName = UI.getChildControl(Panel_Window_Invite_All, "CheckButton_IsUserNickName_PCUI")
  self._ui.rdo_familyName = UI.getChildControl(Panel_Window_Invite_All, "RadioButton_UserName_ConsoleUI")
  self._ui.rdo_characterName = UI.getChildControl(Panel_Window_Invite_All, "RadioButton_CharName_ConsoleUI")
  self._ui.edit_name = UI.getChildControl(Panel_Window_Invite_All, "Edit_Name")
  self._ui.btn_confirm = UI.getChildControl(Panel_Window_Invite_All, "Button_Confirm_PCUI")
  self._ui.btn_cancel = UI.getChildControl(Panel_Window_Invite_All, "Button_Cancel_PCUI")
  self._ui.stc_keyGuideLB = UI.getChildControl(Panel_Window_Invite_All, "Static_LB_ConsoleUI")
  self._ui.stc_keyGuideRB = UI.getChildControl(Panel_Window_Invite_All, "Static_RB_ConsoleUI")
  self._ui.stc_keyGuideX = UI.getChildControl(Panel_Window_Invite_All, "StaticText_EditNameKeyGuide_ConsoleUI")
  self._ui.stc_keyGuideBG = UI.getChildControl(Panel_Window_Invite_All, "Static_KeyGuideBG")
  self._ui.stc_KeyGuideA = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_Apply")
  self._ui.stc_KeyGuideB = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_Cancel")
  self._ui.edit_name:SetMaxInput(getGameServiceTypeUserNickNameLength())
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:setConsoleUI()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Invite_All:setConsoleUI()
  if true == self._isConsole then
    self._ui.btn_close:SetShow(false)
    self._ui.chk_familyName:SetShow(false)
    self._ui.btn_confirm:SetShow(false)
    self._ui.btn_cancel:SetShow(false)
    Panel_Window_Invite_All:SetSize(Panel_Window_Invite_All:GetSizeX(), Panel_Window_Invite_All:GetSizeY() - 40)
    self._ui.stc_subBG:SetSize(self._ui.stc_subBG:GetSizeX(), self._ui.stc_subBG:GetSizeY() - 40)
    Panel_Window_Invite_All:ComputePos()
    self._ui.stc_keyGuideBG:ComputePos()
    self:updateTab()
    self:setAlignKeyGuide()
  else
    self._ui.rdo_familyName:SetShow(false)
    self._ui.rdo_characterName:SetShow(false)
    self._ui.stc_keyGuideLB:SetShow(false)
    self._ui.stc_keyGuideRB:SetShow(false)
    self._ui.stc_keyGuideX:SetShow(false)
    self._ui.stc_keyGuideBG:SetShow(false)
    self._ui.chk_familyName:SetCheck(self._isFamilyName)
  end
end
function PaGlobal_Invite_All:setAlignKeyGuide()
  local keyGuides = {
    self._ui.stc_KeyGuideA,
    self._ui.stc_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Invite_All:registEventHandler()
  if nil == Panel_Window_Invite_All then
    return
  end
  Panel_Window_Invite_All:ignorePadSnapMoveToOtherPanel()
  registerEvent("onScreenResize", "FromClient_Invite_All_Resize")
  if true == self._isConsole then
    if true == _ContentsGroup_RenewUI then
      self._ui.edit_name:setXboxVirtualKeyBoardEndEvent("PaGlobal_Invite_All_VirtualKeyEnd")
    else
      self._ui.edit_name:RegistReturnKeyEvent("PaGlobal_Invite_All_SendInvite()")
    end
    Panel_Window_Invite_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Invite_All_SetFocusEdit()")
    Panel_Window_Invite_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Invite_All_SendInvite()")
    Panel_Window_Invite_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_Invite_All_ChangeNicknameMode()")
    Panel_Window_Invite_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_Invite_All_ChangeNicknameMode()")
  else
    self._ui.edit_name:RegistReturnKeyEvent("PaGlobal_Invite_All_SendInvite()")
    self._ui.chk_familyName:addInputEvent("Mouse_LUp", "PaGlobal_Invite_All_ChangeNicknameMode()")
    self._ui.btn_confirm:addInputEvent("Mouse_LUp", "PaGlobal_Invite_All_SendInvite()")
    self._ui.btn_cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_Invite_All_Close()")
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Invite_All_Close()")
  end
end
function PaGlobal_Invite_All:prepareOpen(type)
  if nil == Panel_Window_Invite_All then
    return
  end
  if true == Panel_Window_Invite_All:GetShow() then
    return
  end
  if false == self._isConsole then
    PaGlobal_Invite_All_SetFocusEdit()
  end
  UI.ASSERT_NAME(2 == self._type.Count, "\236\131\136\235\161\156\236\154\180 \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\154\176\236\160\149\235\172\180")
  if self._type.Crew == type and false == _ContentsGroup_CrewMatch then
    return
  else
    if self._type.RentInstanceField == type and false == _ContentsGroup_RentInstanceField then
      return
    else
    end
  end
  self._openType = type
  self._ui.edit_name:SetEditText("", true)
  self:updateTab()
  PaGlobal_Invite_All:open()
end
function PaGlobal_Invite_All:open()
  if nil == Panel_Window_Invite_All then
    return
  end
  Panel_Window_Invite_All:SetShow(true)
end
function PaGlobal_Invite_All:prepareClose()
  if nil == Panel_Window_Invite_All then
    return
  end
  if false == Panel_Window_Invite_All:GetShow() then
    return
  end
  self._openType = self._type.Count
  ClearFocusEdit()
  PaGlobal_Invite_All:close()
end
function PaGlobal_Invite_All:close()
  if nil == Panel_Window_Invite_All then
    return
  end
  Panel_Window_Invite_All:SetShow(false)
end
function PaGlobal_Invite_All:updateTab()
  UI.ASSERT_NAME(2 == self._type.Count, "\236\131\136\235\161\156\236\154\180 \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\154\176\236\160\149\235\172\180")
  local titleText = ""
  local characterDesc = ""
  local familyDesc = ""
  if self._type.Crew == self._openType then
    titleText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CREW_INVITE_TITLE")
    characterDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CREW_INVITE_CHARACTER")
    familyDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CREW_INVITE_FAMILY")
  elseif self._type.RentInstanceField == self._openType then
    titleText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PERSONALSERVER_OPTION_TITLE")
    characterDesc = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALSERVER_INVITE_DESC_CHARACTERNAME")
    familyDesc = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALSERVER_INVITE_DESC_FAMILLYNAME")
  end
  if "" == titleText or "" == characterDesc or "" == familyDesc then
    UI.ASSERT_NAME(false, "\236\138\164\237\138\184\235\167\129 \237\153\149\236\157\184 \237\149\132\236\154\148", "\236\154\176\236\160\149\235\172\180")
  end
  if false == self._isFamilyName then
    self._ui.rdo_familyName:SetFontColor(Defines.Color.C_FF585453)
    self._ui.rdo_characterName:SetFontColor(Defines.Color.C_FFFFEDD4)
    self._ui.chk_familyName:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_BTN_CHARACTERNAME"))
    self._ui.txt_desc:SetText(characterDesc)
  else
    self._ui.rdo_familyName:SetFontColor(Defines.Color.C_FFFFEDD4)
    self._ui.rdo_characterName:SetFontColor(Defines.Color.C_FF585453)
    self._ui.chk_familyName:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_BTN_NICKNAME"))
    self._ui.txt_desc:SetText(familyDesc)
  end
  self._ui.txt_title:SetText(titleText)
  self._ui.chk_familyName:SetEnableArea(0, 0, self._ui.chk_familyName:GetSizeX() + self._ui.chk_familyName:GetTextSizeX() + 10, self._ui.chk_familyName:GetSizeY())
end
function PaGlobal_Invite_All:validate()
  if nil == Panel_Window_Invite_All then
    return
  end
  self._ui.btn_close:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.stc_subBG:isValidate()
  self._ui.chk_familyName:isValidate()
  self._ui.rdo_familyName:isValidate()
  self._ui.rdo_characterName:isValidate()
  self._ui.edit_name:isValidate()
  self._ui.btn_confirm:isValidate()
  self._ui.btn_cancel:isValidate()
  self._ui.stc_keyGuideLB:isValidate()
  self._ui.stc_keyGuideRB:isValidate()
  self._ui.stc_keyGuideX:isValidate()
  self._ui.stc_keyGuideBG:isValidate()
  self._ui.stc_KeyGuideA:isValidate()
  self._ui.stc_KeyGuideB:isValidate()
end
