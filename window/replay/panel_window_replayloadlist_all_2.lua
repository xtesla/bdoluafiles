function PaGlobal_ReplayLoadList_Open()
  if nil == Panel_Window_ReplayLoadList_All then
    return
  end
  PaGlobal_ReplayLoadList:prepareOpen()
end
function PaGlobal_ReplayLoadList_Close()
  if nil == Panel_Window_ReplayLoadList_All then
    return
  end
  PaGlobal_ReplayLoadList:prepareClose()
end
function PaGlobal_ReplayLoadList_GetShow()
  if nil == Panel_Window_ReplayLoadList_All then
    return
  end
  return PaGlobal_ReplayLoadList:GetShow()
end
function PaGlobal_ReplayLoadList_ReplayLoadTest()
  ToClient_ReplayLoadTest()
end
function PaGlobal_ReplayLoadList_CreateControlList2(content, index)
  local key = Int64toInt32(index)
  local wrapper = ToClient_getLoadReplayDataWrapper(key)
  if nil == wrapper then
    return
  end
  local txt_replayName = UI.getChildControl(content, "StaticText_ReplayName")
  local txt_replayLength = UI.getChildControl(content, "StaticText_ReplayLength")
  local btn_select = UI.getChildControl(content, "Button_Select")
  txt_replayName:SetText(wrapper:getReplayName())
  txt_replayLength:SetText(wrapper:getLength())
  btn_select:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify_ChangePlayReplayNameByIndex(" .. key .. ")")
end
function PaGlobal_ReplayLoadList_Refresh()
  if nil == Panel_Window_ReplayLoadList_All then
    return
  end
  PaGlobal_ReplayLoadList:refresh()
end
function HandleEventLUp_ReplayLoadList_Select()
  if nil == Panel_Window_ReplayLoadList_All then
    return
  end
end
