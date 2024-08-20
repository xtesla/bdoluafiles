function PaGlobal_SkillPreset_applyConfirmSkillPreset(slotNo)
  if nil == Panel_Window_SkillPreset then
    return
  end
  local remainTime = ToClient_getSkillPresetRemainTime()
  local minute = toInt64(0, 60)
  local zero = Defines.s64_const.s64_0
  local tempContent = ""
  if nil == remainTime then
    remainTime = 0
  end
  if zero < remainTime / minute then
    remainTime = remainTime / minute
    tempContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILLPRESET_CHANGE_SET_TIME_MINUTE", "time", tostring(remainTime))
  elseif remainTime ~= zero and remainTime / minute == zero then
    tempContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILLPRESET_CHANGE_SET_TIME_SECOND", "time", tostring(remainTime))
  else
    PaGlobal_SkillPreset_selectButton(slotNo)
    PaGlobal_SkillPreset:applyConfirmMessageBox()
    return
  end
  if zero < remainTime then
    local messageData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = tempContent,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageData)
  end
end
function PaGlobal_SkillPreset_lockPresetBuy()
  if nil == Panel_Window_SkillPreset then
    return
  end
  local tmpFunction
  local maxBaseSlotCount = ToClient_getSkillPresetSlotMaxCount()
  local maxCashSlotCount = ToClient_getSkillPresetCashSlotMaxCount()
  if maxCashSlotCount <= 0 then
    tmpFunction = MessageBox_Empty_function
  else
    tmpFunction = PaGlobal_SkillPreset_ConfirmMessageBox
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILLPRESET_LOCK_MESSAGEBOX", "count", maxBaseSlotCount),
    functionApply = tmpFunction,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
function PaGlobal_SkillPreset_ConfirmMessageBox()
  PaGlobal_SkillPreset:confirmMessageBox()
end
function HandleMOver_SkillWindow_SkillPresetLockToolTip(isShow, index)
  if nil == Panel_Window_SkillPreset then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_SkillGroup then
    return
  end
  PaGlobal_SkillGroup:skillpresetLockToolTipShow(isShow, index)
  PaGlobal_SkillGroup:AlignkeyGuide(4)
end
function PaGlobal_SkillPreset_saveSkillPresetConfirm()
  if nil == Panel_Window_SkillPreset then
    return
  end
  PaGlobal_SkillPreset:saveSkillPresetConfirm()
end
function PaGlobal_SkillPreset_saveSkillPreset()
  if nil == Panel_Window_SkillPreset then
    return
  end
  PaGlobal_SkillPreset:saveSkillPreset()
end
function PaGlobal_SkillPreset_selectButton(slotNo)
  if nil == Panel_Window_SkillPreset then
    return
  end
  PaGlobal_SkillPreset:selectButton(slotNo)
end
function PaGlobal_SkillPreset_applySkillPreset()
  if nil == Panel_Window_SkillPreset then
    return
  end
  PaGlobal_SkillPreset:applySkillPreset()
end
function PaGlobal_SkillPreset_Close()
  if nil == Panel_Window_SkillPreset then
    return
  end
  PaGlobal_SkillPreset:prepareClose()
end
function PaGlobal_SkillPreset_Open(count)
  if nil == Panel_Window_SkillPreset then
    return
  end
  if count <= 0 then
    return
  end
  PaGlobal_SkillPreset:prepareOpen(count)
end
function PaGlobal_SkillPreset_ButtonSetting(count)
  PaGlobal_SkillPreset:buttonSetting(count)
end
function PaGlobal_SkillPreset_TextureSetting(slotNo)
  PaGlobal_SkillPreset:textureSetting(slotNo)
end
function PaGlobal_SkillPreset_saveSkillPresetConfirmByAwakenGuide()
  if nil == Panel_Window_SkillPreset then
    return
  end
  local changeAwaken = function()
    PaGlobal_SkillPreset_saveSkillPreset()
    if nil ~= PaGlobalFunc_SkillGroup_SelectType_SelectTree then
      if nil ~= PaGlobalFunc_SkillGroup_SetAwakenGuide then
        PaGlobalFunc_SkillGroup_SetAwakenGuide(true)
      end
      PaGlobalFunc_SkillGroup_SelectType_SelectTree(__eSkillTypeParam_Awaken, true)
    end
  end
  local presetOpenSlotCount = ToClient_getSkillPresetSlotCount()
  for ii = 0, presetOpenSlotCount - 1 do
    local isEmpty = Toclient_getSkillPresetSlotEmpty(ii)
    if true == isEmpty then
      PaGlobal_SkillPreset._selectSlot = ii
      changeAwaken()
      return
    end
  end
  if presetOpenSlotCount > 0 then
    PaGlobal_SkillPreset._selectSlot = 0
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_ALEADY_CONFIRM"),
      functionYes = changeAwaken,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
