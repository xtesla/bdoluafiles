function PaGlobal_RentInstanceField_Option_List2Update(content, key)
  local self = PaGlobal_RentInstanceField_Option
  local index = Int64toInt32(key)
  local slot = self._userInfoList[index]
  if nil == slot then
    return
  end
  local stc_slot = UI.getChildControl(content, "Static_Slot")
  local txt_userNickname = UI.getChildControl(stc_slot, "StaticText_PlayerName")
  local btn_kick = UI.getChildControl(stc_slot, "Button_Exile")
  txt_userNickname:SetText(slot.userNickName)
  if self._hostUserNo == slot.userNo then
    btn_kick:addInputEvent("Mouse_LUp", "")
    btn_kick:SetShow(false)
  else
    btn_kick:addInputEvent("Mouse_LUp", "PaGlobal_RentInstanceField_Option:kick(" .. tostring(index) .. ")")
    btn_kick:SetShow(true)
  end
end
function FromClient_updateRentInstanceFieldPassList()
  PaGlobal_RentInstanceField_Option:updateList()
end
