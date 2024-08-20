function PaGlobal_Window_Wanted_Set_Open(characterNo, killerName, deadTime)
  if nil == Panel_Window_Wanted_Set then
    return
  end
  if false == _ContentsGroup_sheriff then
    return
  end
  PaGlobal_Window_Wanted_Set:prepareOpen(characterNo, killerName, deadTime)
end
function PaGloabl_Window_Wanted_Set_Close()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  PaGlobal_Window_Wanted_Set:dataClear()
  PaGlobal_Window_Wanted_Set:prepareClose()
end
function HandleEventLUp_Window_Wanted_Set_RequestWanted()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  local countString = PaGlobal_Window_Wanted_Set._ui._edit_Count:GetEditText()
  local costString = PaGlobal_Window_Wanted_Set._ui._edit_Cost:GetEditText()
  local convertCount = tonumber(countString)
  if nil == convertCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_REQUIRE_WANTEDSET"))
    return
  end
  if convertCount > PaGlobal_Window_Wanted_Set._MAXWANTEDCOUNT then
    convertCount = PaGlobal_Window_Wanted_Set._MAXWANTEDCOUNT
  end
  if nil ~= costString then
    costString = string.gsub(costString, ",", "")
  end
  local convertCost = tonumber64u(costString)
  if nil == convertCost then
    convertCost = PaGlobal_Window_Wanted_Set._MINWANTEDCOST
  else
  end
  if convertCost < PaGlobal_Window_Wanted_Set._MINWANTEDCOST then
    convertCost = PaGlobal_Window_Wanted_Set._MINWANTEDCOST
    PaGlobal_Window_Wanted_Set._ui._edit_Cost:SetEditText(makeDotMoney(convertCost))
  elseif convertCost > PaGlobal_Window_Wanted_Set._MAXWANTEDCOST then
    convertCost = PaGlobal_Window_Wanted_Set._MAXWANTEDCOST
    PaGlobal_Window_Wanted_Set._ui._edit_Cost:SetEditText(makeDotMoney(convertCost))
  end
  PaGlobal_Window_Wanted_Set._wantedCost = convertCost
  PaGlobal_Window_Wanted_Set._totalCost = PaGlobal_Window_Wanted_Set._wantedCost * toUint64(0, convertCount)
  PaGlobal_Window_Wanted_Set._wantedCount = convertCount
  PaGlobal_Window_Wanted_Set:setCurrentValueString()
  local yesFunc = function()
    ToClient_requestWanted(PaGlobal_Window_Wanted_Set._wantedCount, PaGlobal_Window_Wanted_Set._wantedCharacterNo, PaGlobal_Window_Wanted_Set._totalCost, PaGlobal_Window_Wanted_Set._deadTime, tostring(PaGlobal_Window_Wanted_Set._wantedName))
    PaGloabl_Window_Wanted_Set_Close()
    if nil ~= PaGloabl_Window_Wanted_Close then
      PaGloabl_Window_Wanted_Close()
    end
  end
  local messageboxData = {
    title = "",
    content = PaGlobal_Window_Wanted_Set._currentWantedString,
    functionYes = yesFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_Window_Wanted_Set_ClearEditCount()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  PaGlobal_Window_Wanted_Set._ui._edit_Count:SetEditText("")
end
function HandleEventLUp_Window_Wanted_Set_ClearEditCost()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  PaGlobal_Window_Wanted_Set:checkMinCost()
end
