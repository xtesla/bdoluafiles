function PaGlobal_RentInstanceField_Option:initialize()
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBG, "Button_Close")
  self._ui._list2_userList = UI.getChildControl(self._ui._stc_mainBG, "List2_1")
  self._ui._txt_empty = UI.getChildControl(self._ui._stc_mainBG, "StaticText_Nobody")
  self:validate()
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_RentInstanceField_Option:clear()
  self._userInfoList = {}
  self._hostUserNo = getSelfPlayer():get():getUserNo()
end
function PaGlobal_RentInstanceField_Option:prepareOpen()
  self:open()
end
function PaGlobal_RentInstanceField_Option:open()
  if false == self._initialize then
    return
  end
  if false == _ContentsGroup_RentInstanceField then
    return
  end
  self:clear()
  self:updateList()
  Panel_RentInstanceField_Option:SetShow(true)
end
function PaGlobal_RentInstanceField_Option:prepareClose()
  self:close()
end
function PaGlobal_RentInstanceField_Option:close()
  Panel_RentInstanceField_Option:SetShow(false)
end
function PaGlobal_RentInstanceField_Option:validate()
  self._ui._stc_titleBG:isValidate()
  self._ui._stc_mainBG:isValidate()
  self._ui._btn_invite:isValidate()
  self._ui._btn_cancel:isValidate()
  self._ui._btn_close:isValidate()
end
function PaGlobal_RentInstanceField_Option:registerEvent()
  self._ui._btn_invite:addInputEvent("Mouse_LUp", "PaGlobal_RentInstanceField_Option:invite()")
  self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_RentInstanceField_Option:prepareClose()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_RentInstanceField_Option:prepareClose()")
  self._ui._list2_userList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_RentInstanceField_Option_List2Update")
  self._ui._list2_userList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_updateRentInstanceFieldPassList", "FromClient_updateRentInstanceFieldPassList")
end
function PaGlobal_RentInstanceField_Option:invite()
  PaGlobal_Invite_All:prepareOpen(PaGlobal_Invite_All._type.RentInstanceField)
end
function PaGlobal_RentInstanceField_Option:kick(index)
  local slot = self._userInfoList[index]
  if nil == slot then
    return
  end
  ToClient_requestKickUserInRentInstanceField(slot.userNo)
end
function PaGlobal_RentInstanceField_Option:updateList()
  local passedList = ToClient_getPassedRentInstanceFieldUserList()
  if nil == passedList then
    return
  end
  local passCount = 0
  self._ui._list2_userList:getElementManager():clearKey()
  for ii = 0, #passedList do
    local slot = {userNo = nil, userNickName = nil}
    local info = passedList[ii]
    slot.userNo = info:getUserNo()
    slot.userNickName = info:getUserNickName()
    if self._hostUserNo ~= slot.userNo then
      self._userInfoList[ii] = slot
      self._ui._list2_userList:getElementManager():pushKey(ii)
      passCount = passCount + 1
    end
  end
  self._ui._txt_empty:SetShow(0 == passCount)
end
