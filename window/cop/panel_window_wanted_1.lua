function PaGlobal_Window_Wanted:initialize()
  if true == PaGlobal_Window_Wanted._initialize then
    return
  end
  self._ui._stc_TitleBg = UI.getChildControl(Panel_Window_Wanted, "Static_TitleArea")
  self._ui._btn_Close = UI.getChildControl(self._ui._stc_TitleBg, "Button_Close")
  self._ui._stc_listBg = UI.getChildControl(Panel_Window_Wanted, "Static_ListArea")
  self._ui._list2_Wanted = UI.getChildControl(self._ui._stc_listBg, "List2_List")
  self._ui._scroll_listWanted = UI.getChildControl(self._ui._list2_Wanted, "List2_1_VerticalScroll")
  PaGlobal_Window_Wanted:registEventHandler()
  PaGlobal_Window_Wanted:validate()
  PaGlobal_Window_Wanted._initialize = true
end
function PaGlobal_Window_Wanted:registEventHandler()
  if nil == Panel_Window_Wanted then
    return
  end
  self._ui._list2_Wanted:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_Window_Wanted_List2UpdateWanted")
  self._ui._list2_Wanted:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGloabl_Window_Wanted_Close()")
  registerEvent("FromClient_UpdateWantedList", "FromClient_UpdateWantedList")
  registerEvent("FromClient_UpdateBadPlayerList", "FromClient_UpdateWantedList")
end
function PaGlobal_Window_Wanted:prepareOpen()
  if nil == Panel_Window_Wanted then
    return
  end
  Panel_Window_Wanted:ComputePos()
  self._badPlayerInfo = {}
  ToClient_requestBadPlayerList()
  PaGlobal_Window_Wanted:open()
end
function PaGlobal_Window_Wanted:open()
  if nil == Panel_Window_Wanted then
    return
  end
  Panel_Window_Wanted:SetShow(true)
end
function PaGlobal_Window_Wanted:prepareClose()
  if nil == Panel_Window_Wanted then
    return
  end
  PaGlobal_Window_Wanted:close()
end
function PaGlobal_Window_Wanted:close()
  if nil == Panel_Window_Wanted then
    return
  end
  Panel_Window_Wanted:SetShow(false)
end
function PaGlobal_Window_Wanted:update()
  if nil == Panel_Window_Wanted then
    return
  end
  PaGlobal_Window_Wanted:updateWantedListData()
end
function PaGlobal_Window_Wanted:updateWantedListData()
  if nil == Panel_Window_Wanted then
    return
  end
  self._badPlayerInfo = {}
  self._ui._list2_Wanted:getElementManager():clearKey()
  local wantedListCount = ToClient_getBadPlayerListSize()
  for ii = 0, wantedListCount - 1 do
    self._ui._list2_Wanted:getElementManager():pushKey(toInt64(0, ii))
  end
end
function PaGlobal_Window_Wanted:validate()
  if nil == Panel_Window_Wanted then
    return
  end
  self._ui._stc_TitleBg:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._stc_listBg:isValidate()
  self._ui._list2_Wanted:isValidate()
  self._ui._scroll_listWanted:isValidate()
end
