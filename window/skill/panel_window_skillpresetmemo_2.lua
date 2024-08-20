function PaGlobalFunc_SkillPresetMemo_Open(slotNo)
  PaGloabal_SkillPresetMemo:prepareOpen(slotNo)
end
function PaGlobalFunc_SkillPresetMemo_Close()
  PaGloabal_SkillPresetMemo:prepareClose()
end
function FromClient_SetSkillPresetMemo(slotNo)
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET" .. tostring(PaGloabal_SkillPresetMemo._selectSlotNo + 1) .. "_SAVE_ACK"))
  HandleEventLUp_SkillPresetMemo_Close()
end
function HandleEventLUp_SkillPresetMemo_Close()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  PaGlobalFunc_SkillPresetMemo_Close()
end
function HandleEventLUp_SkillPresetMemo_EditText()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  SetFocusEdit(PaGloabal_SkillPresetMemo._ui.edit_memo)
end
function HandleEventLUp_SkillPresetMemo_Save()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  if nil == PaGloabal_SkillPresetMemo._selectSlotNo then
    return
  end
  local saveStr = PaGloabal_SkillPresetMemo._ui.edit_memo:GetEditText()
  if "" == saveStr or nil == saveStr or " " == saveStr or string.len(saveStr) <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_INSERTCONTENT"))
    return
  end
  local function ApplyPresetMemo()
    ToClient_setSkillPresetMemo(PaGloabal_SkillPresetMemo._selectSlotNo, saveStr)
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLPRESET_NAME_DESC_MSG", "num", tostring(PaGloabal_SkillPresetMemo._selectSlotNo + 1), "name", saveStr),
    functionYes = ApplyPresetMemo,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
  ClearFocusEdit()
  CheckChattingInput()
end
function HandleEventLUp_SkillPresetMemo_Reset()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  if nil == PaGloabal_SkillPresetMemo._selectSlotNo then
    return
  end
  local saveStr = PaGloabal_SkillPresetMemo._ui.edit_memo:GetEditText()
  if "" == saveStr or nil == saveStr or string.len(saveStr) <= 0 then
    return
  end
  local ResetPresetMemo = function()
    ToClient_resetSkillPresetMemo(PaGloabal_SkillPresetMemo._selectSlotNo)
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_NAME_DELETE_ACK"))
    PaGloabal_SkillPresetMemo._ui.edit_memo:SetEditText("", true)
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLPRESET_NAME_DELETE_MSG", "name", saveStr, "num", tostring(PaGloabal_SkillPresetMemo._selectSlotNo + 1)),
    functionYes = ResetPresetMemo,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
  ClearFocusEdit()
end
function HandlePadEvent_SkillPresetMemo_EndVirtualKey(str)
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  ClearFocusEdit()
  PaGloabal_SkillPresetMemo._ui.edit_memo:SetEditText(str, true)
end
function PaGlobalFunc_SkillPresetMemo_IsSetMemo(slotNo)
  local memo = ToClient_getSkillPresetMemo(slotNo)
  if "" == memo or nil == memo or " " == memo or string.len(memo) <= 0 then
    return false, ""
  end
  return true, memo
end
