function PaGlobal_Guild_InviteList:initialize()
  if true == PaGlobal_Guild_InviteList._initialize then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Guild_InviteList, "Static_TitleArea_Import")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Close")
  self._ui.stc_listArea = UI.getChildControl(Panel_Guild_InviteList, "Static_ListArea")
  self._ui.stc_list2 = UI.getChildControl(self._ui.stc_listArea, "List2_1")
  PaGlobal_Guild_InviteList:registEventHandler()
  PaGlobal_Guild_InviteList:validate()
  PaGlobal_Guild_InviteList._initialize = true
end
function PaGlobal_Guild_InviteList:registEventHandler()
  if nil == Panel_Guild_InviteList then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Guild_InviteList_Close()")
  self._ui.stc_list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Guild_InviteList_Create")
  self._ui.stc_list2:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_Guild_InviteList:prepareOpen()
  if nil == Panel_Guild_InviteList then
    return
  end
  self:update()
  PaGlobal_Guild_InviteList:open()
end
function PaGlobal_Guild_InviteList:open()
  if nil == Panel_Guild_InviteList then
    return
  end
  Panel_Guild_InviteList:SetShow(true)
end
function PaGlobal_Guild_InviteList:prepareClose()
  if nil == Panel_Guild_InviteList then
    return
  end
  PaGlobal_Guild_InviteList:close()
end
function PaGlobal_Guild_InviteList:close()
  if nil == Panel_Guild_InviteList then
    return
  end
  Panel_Guild_InviteList:SetShow(false)
end
function PaGlobal_Guild_InviteList:update()
  if nil == Panel_Guild_InviteList then
    return
  end
  self._ui.stc_list2:getElementManager():clearKey()
  local listSize = ToClient_getSimpleGuildInviteInfoSize()
  for key = 0, listSize - 1 do
    self._ui.stc_list2:getElementManager():pushKey(toInt64(0, key))
  end
end
function PaGlobal_Guild_InviteList:validate()
  if nil == Panel_Guild_InviteList then
    return
  end
  self._ui.stc_titleArea:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_listArea:isValidate()
  self._ui.stc_list2:isValidate()
end
