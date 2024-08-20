function PaGloabal_SkillPresetMemo:initialize()
  if true == PaGloabal_SkillPresetMemo._initialize or nil == Panel_Window_SkillPresetMemo then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_SkillPresetMemo, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleBg, "StaticText_TItle")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_SkillPresetMemo, "Static_MainArea")
  self._ui.btn_save = UI.getChildControl(self._ui.stc_mainBg, "Button_Write")
  self._ui.btn_reset = UI.getChildControl(self._ui.stc_mainBg, "Button_Reset")
  self._ui.edit_memo = UI.getChildControl(self._ui.stc_mainBg, "Edit_NoticeSquare")
  self._ui.stc_keyGuideBg = UI.getChildControl(Panel_Window_SkillPresetMemo, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_keyGuide_A = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_A_ConsoleUI")
  self._ui.stc_keyGuide_B = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_B_ConsoleUI")
  self._ui.stc_keyGuide_X = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_X_ConsoleUI")
  self._ui.stc_keyGuide_Y = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  self._isConsole = _ContentsGroup_RenewUI
  PaGloabal_SkillPresetMemo:validate()
  PaGloabal_SkillPresetMemo:registEventHandler()
  PaGloabal_SkillPresetMemo:swichPlatform(self._isConsole)
  PaGloabal_SkillPresetMemo._initialize = true
end
function PaGloabal_SkillPresetMemo:swichPlatform(isConsole)
  if true == isConsole then
    self._ui.btn_close:SetShow(false)
    self._ui.btn_save:SetShow(false)
    self._ui.btn_reset:SetShow(false)
    self._ui.stc_keyGuideBg:SetShow(true)
    Panel_Window_SkillPresetMemo:SetSize(Panel_Window_SkillPresetMemo:GetSizeX(), Panel_Window_SkillPresetMemo:GetSizeY() - self._ui.btn_save:GetSizeY() - 10)
  else
    self._ui.btn_close:SetShow(true)
    self._ui.btn_save:SetShow(true)
    self._ui.btn_reset:SetShow(true)
    self._ui.stc_keyGuideBg:SetShow(false)
  end
end
function PaGloabal_SkillPresetMemo:prepareOpen(slotNo)
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  if nil == slotNo or "" == slotNo then
    return
  end
  if true == Toclient_getSkillPresetSlotEmpty(slotNo) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPERSET_NAME_NONSAVE_NAME"))
    return
  end
  self._selectSlotNo = slotNo
  self._ui.txt_title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILLPRESET_NAME_TITLE", "num", tostring(slotNo + 1)))
  PaGloabal_SkillPresetMemo:open()
  PaGloabal_SkillPresetMemo:update()
  PaGloabal_SkillPresetMemo:resize()
end
function PaGloabal_SkillPresetMemo:open()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  Panel_Window_SkillPresetMemo:SetShow(true)
end
function PaGloabal_SkillPresetMemo:prepareClose()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  self._selectSlotNo = nil
  PaGloabal_SkillPresetMemo:close()
end
function PaGloabal_SkillPresetMemo:close()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  Panel_Window_SkillPresetMemo:SetShow(false)
end
function PaGloabal_SkillPresetMemo:update()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  if nil == self._selectSlotNo then
    self._ui.edit_memo:SetEditText("")
    return
  end
  local memoContent = ToClient_getSkillPresetMemo(self._selectSlotNo)
  self._ui.edit_memo:SetEditText(memoContent, false)
end
function PaGloabal_SkillPresetMemo:registEventHandler()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  if false == self._isConsole then
    self._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_SkillPresetMemo_Close()")
    self._ui.edit_memo:addInputEvent("Mouse_LUp", "HandleEventLUp_SkillPresetMemo_EditText()")
    self._ui.btn_save:addInputEvent("Mouse_LUp", "HandleEventLUp_SkillPresetMemo_Save()")
    self._ui.btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_SkillPresetMemo_Reset()")
    self._ui.edit_memo:RegistReturnKeyEvent("HandleEventLUp_SkillPresetMemo_Save()")
  else
    Panel_Window_SkillPresetMemo:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SkillPresetMemo_Save()")
    Panel_Window_SkillPresetMemo:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_SkillPresetMemo_EditText()")
    Panel_Window_SkillPresetMemo:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventLUp_SkillPresetMemo_Reset()")
    self._ui.edit_memo:setXboxVirtualKeyBoardEndEvent("HandlePadEvent_SkillPresetMemo_EndVirtualKey")
    Panel_Window_SkillPresetMemo:ignorePadSnapMoveToOtherPanelUpdate(true)
  end
  registerEvent("FromClient_SetSkillPresetMemo", "FromClient_SetSkillPresetMemo")
  self._ui.edit_memo:SetMaxInput(getGameServiceTypeSkillPresetNameLength())
end
function PaGloabal_SkillPresetMemo:validate()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_mainBg:isValidate()
  self._ui.btn_save:isValidate()
  self._ui.btn_reset:isValidate()
  self._ui.edit_memo:isValidate()
  self._ui.stc_keyGuideBg:isValidate()
  self._ui.stc_keyGuide_A:isValidate()
  self._ui.stc_keyGuide_B:isValidate()
  self._ui.stc_keyGuide_X:isValidate()
  self._ui.stc_keyGuide_Y:isValidate()
end
function PaGloabal_SkillPresetMemo:resize()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  if true == self._isConsole then
    local keyguide = {
      self._ui.stc_keyGuide_A,
      self._ui.stc_keyGuide_Y,
      self._ui.stc_keyGuide_X,
      self._ui.stc_keyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  self._ui.stc_keyGuideBg:ComputePos()
end
