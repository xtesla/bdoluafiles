function PaGlobal_ThornCastle_Enter:initialize()
  if true == PaGlobal_ThornCastle_Enter._initialize then
    return
  end
  self._ui._joinMessageBox._confirmBtn = UI.getChildControl(Panel_Widget_ThornCastle_Enter, "Button_Confirm")
  self._ui._joinMessageBox._cancelBtn = UI.getChildControl(Panel_Widget_ThornCastle_Enter, "Button_Cancel")
  self._ui._matchingBox._cancelBtn = UI.getChildControl(Panel_Widget_ThornCastle_Matching, "Button_Cancel")
  PaGlobal_ThornCastle_Enter:validate()
  PaGlobal_ThornCastle_Enter:registEventHandler()
  PaGlobal_ThornCastle_Enter._initialize = true
  if true == ToClient_IsInstanceRandomMatching() and __eInstanceContentsType_OthilitaDungeon == ToClient_getInstanceRandomMatchingContentsType() then
    PaGlobal_ThornCastle_Enter:prepareOpenMatchingBox()
  end
end
function PaGlobal_ThornCastle_Enter:prepareOpenJoinMessageBox()
  if nil == Panel_Widget_ThornCastle_Enter then
    return
  end
  PaGlobal_ThornCastle_Enter:openJoinMessageBox()
end
function PaGlobal_ThornCastle_Enter:openJoinMessageBox()
  if nil == Panel_Widget_ThornCastle_Enter then
    return
  end
  local contentsString = PAGetString(Defines.StringSheet_GAME, "LUA_THORNCASTLE_ENTER_DESC")
  if true == _ContentsGroup_othilitaRandomMatching then
    contentsString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_THORNCASTLE_ENTER_DESC")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_THORNCASTLE_ENTER_TITLE"),
    content = contentsString,
    functionYes = HandleEventLUp_Widget_ThornCastle_Enter_Join_Othilita,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "top")
end
function PaGlobal_ThornCastle_Enter:prepareOpenDisJoinMessageBox()
  if nil == Panel_Widget_ThornCastle_Enter then
    return
  end
  PaGlobal_ThornCastle_Enter:openDisJoinMessageBox()
end
function PaGlobal_ThornCastle_Enter:openDisJoinMessageBox()
  if nil == Panel_Widget_ThornCastle_Enter then
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_THORNCASTLE_EXIT_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_THORNCASTLE_EXIT_DESC"),
    functionYes = ToClient_InstanceOthilitaDisJoin,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "top")
end
function PaGlobal_ThornCastle_Enter:prepareOpenMatchingBox()
  if nil == Panel_Widget_ThornCastle_Matching then
    return
  end
  Panel_Widget_ThornCastle_Matching:ComputePos()
  PaGlobal_ThornCastle_Enter:openMatchingBox()
end
function PaGlobal_ThornCastle_Enter:openMatchingBox()
  if nil == Panel_Widget_ThornCastle_Matching then
    return
  end
  if false == _ContentsGroup_othilitaRandomMatching then
    return
  end
  Panel_Widget_ThornCastle_Matching:SetShow(true)
end
function PaGlobal_ThornCastle_Enter:prepareCloseJoinMessageBox()
  if nil == Panel_Widget_ThornCastle_Enter then
    return
  end
  self:closeJoinMessageBox()
end
function PaGlobal_ThornCastle_Enter:closeJoinMessageBox()
  if nil == Panel_Widget_ThornCastle_Enter then
    return
  end
  Panel_Widget_ThornCastle_Enter:SetShow(false)
end
function PaGlobal_ThornCastle_Enter:prepareCloseMatchingBox()
  if nil == Panel_Widget_ThornCastle_Matching then
    return
  end
  local partyMemberCount = RequestParty_getPartyMemberCount()
  if partyMemberCount < 1 then
    ToClient_CancelInstanceOthilitaRandomParty()
  end
  PaGlobal_ThornCastle_Enter:closeMatchingBox()
end
function PaGlobal_ThornCastle_Enter:closeMatchingBox()
  if nil == Panel_Widget_ThornCastle_Matching then
    return
  end
  Panel_Widget_ThornCastle_Matching:SetShow(false)
end
function PaGlobal_ThornCastle_Enter:requestJoinRandomMatching()
  local partyMemberCount = RequestParty_getPartyMemberCount()
  if partyMemberCount > 0 then
    ToClient_InstanceContentsJoin(4, 0)
  else
    ToClient_InstanceContentsJoin(4, 1)
    self:openMatchingBox()
  end
end
function PaGlobal_ThornCastle_Enter:validate()
  if nil == Panel_Widget_ThornCastle_Enter or nil == Panel_Widget_ThornCastle_Matching then
    return
  end
  self._ui._joinMessageBox._confirmBtn:isValidate()
  self._ui._joinMessageBox._cancelBtn:isValidate()
  self._ui._matchingBox._cancelBtn:isValidate()
end
function PaGlobal_ThornCastle_Enter:registEventHandler()
  if nil == Panel_Widget_ThornCastle_Enter or nil == Panel_Widget_ThornCastle_Matching then
    return
  end
  self._ui._joinMessageBox._confirmBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_ThornCastle_Enter_Join_Othilita()")
  self._ui._joinMessageBox._cancelBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_ThornCastle_Enter_Cancel()")
  self._ui._matchingBox._cancelBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_ThornCastle_Enter_Matching_Cancel()")
end
