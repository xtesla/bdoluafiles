function PaGlobal_ChangeSeasonCharacter_All_Open()
  if nil == Panel_Window_ChangeSeasonCharacter_All then
    return
  end
  PaGlobal_ChangeSeasonCharacter_All:prepareOpen()
end
function PaGlobal_ChangeSeasonCharacter_All_Close()
  if nil == Panel_Window_ChangeSeasonCharacter_All then
    return
  end
  PaGlobal_ChangeSeasonCharacter_All:prepareClose()
end
function HandleEventLUp_ChangeSeasonCharacter_All_ChangeConfirm()
  if -1 == PaGlobal_ChangeSeasonCharacter_All._selectedCharacterIndex then
    return
  end
  local characterData = getCharacterDataByIndex(PaGlobal_ChangeSeasonCharacter_All._selectedCharacterIndex)
  local characterName = getCharacterName(characterData)
  local ChangeSeasonCharacter = function()
    ToClient_RequestChangeSeasonCharacter(PaGlobal_ChangeSeasonCharacter_All._selectedCharacterIndex, false)
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEASON_CHARACTERTAG_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SEASON_CHARACTERTAG_CHANGECONFIRM", "name", characterName),
    functionYes = ChangeSeasonCharacter,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ChangeSeasonCharacter_All_ClickCharacterList(charIndex)
  PaGlobal_ChangeSeasonCharacter_All._selectedCharacterIndex = charIndex
  PaGlobal_ChangeSeasonCharacter_All:update()
end
function HandleEventScroll_ChangeSeasonCharacter_All_ScrollEvent(isUp)
  PaGlobal_ChangeSeasonCharacter_All._pageIndex = UIScroll.ScrollEvent(PaGlobal_ChangeSeasonCharacter_All._ui.scroll_charList, isUp, 1, math.ceil(PaGlobal_ChangeSeasonCharacter_All._maxCharacterCount / 6), PaGlobal_ChangeSeasonCharacter_All._pageIndex, 1)
  PaGlobal_ChangeSeasonCharacter_All:updateCharacterList()
end
function FromClient_ChangeSeasonCharacter_All_OnScreenResize()
  if nil == Panel_Window_ChangeSeasonCharacter_All then
    return
  end
  Panel_Window_ChangeSeasonCharacter_All:ComputePos()
end
function FromClient_ChangeSeasonCharacter_All_ChangeSuccess()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_CHARACTERTAG_SUCCESSCHANGE"))
  PaGlobal_ChangeSeasonCharacter_All_Close()
  if nil ~= InventoryWindow_Close then
    InventoryWindow_Close()
  end
end
