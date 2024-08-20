function HandleEventLUp_ContentsName_updateAppleList()
  if nil == Panel_Window_Warcall_Castle then
    return
  end
end
function PaGlobal_Warcall_Castle_Open()
  if nil == Panel_Window_Warcall_Castle then
    return
  end
  if nil == PaGlobal_Warcall_Castle then
    return
  end
  PaGlobal_Warcall_Castle:prepareOpen()
end
function PaGlobal_Warcall_Castle_Close()
  if nil == Panel_Window_Warcall_Castle then
    return
  end
  if nil == PaGlobal_Warcall_Castle then
    return
  end
  PaGlobal_Warcall_Castle:prepareClose()
end
function PaGlobal_Warcall_Castle_List2Update(content, key)
  if nil == PaGlobal_Warcall_Castle then
    return
  end
  PaGlobal_Warcall_Castle:list2Update(content, key)
end
registerEvent("FromClient_openWarCallSelectRegion", "PaGlobal_Warcall_Castle_Open")
