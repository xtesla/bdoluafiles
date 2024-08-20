function PaGlobal_Window_Wanted_Set:initialize()
  if true == PaGlobal_Window_Wanted_Set._initialize then
    return
  end
  self._ui._stc_mainBg = UI.getChildControl(Panel_Window_Wanted_Set, "Static_MainArea")
  self._ui._stc_titleBg = UI.getChildControl(Panel_Window_Wanted_Set, "Static_TitleArea")
  self._ui._btn_Close = UI.getChildControl(self._ui._stc_titleBg, "Button_Close")
  self._ui._edit_Count = UI.getChildControl(self._ui._stc_mainBg, "Edit_Wanted_Count")
  self._ui._edit_Cost = UI.getChildControl(self._ui._stc_mainBg, "Edit_Wanted_Money")
  self._ui._btn_Wanted = UI.getChildControl(self._ui._stc_mainBg, "Button_Wanted")
  self._ui._stc_DescBg = UI.getChildControl(self._ui._stc_mainBg, "Static_DescEdge")
  self._ui._stc_Desc = UI.getChildControl(self._ui._stc_DescBg, "StaticText_Desc")
  self._ui._std_DescMinMoney = UI.getChildControl(self._ui._stc_mainBg, "StaticText_MinMoney")
  self._ui._stc_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_Desc:SetText(self._ui._stc_Desc:GetText())
  self._ui._std_DescMinMoney:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_COP_WANTED_MINMONEY", "money", makeDotMoney(self._MINWANTEDCOST)))
  self._ui._edit_Count:SetMaxInput(2)
  self._ui._edit_Cost:SetMaxInput(15)
  PaGlobal_Window_Wanted_Set:registEventHandler()
  PaGlobal_Window_Wanted_Set:validate()
  PaGlobal_Window_Wanted_Set._initialize = true
end
function PaGlobal_Window_Wanted_Set:registEventHandler()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  self._ui._btn_Wanted:addInputEvent("Mouse_LUp", "HandleEventLUp_Window_Wanted_Set_RequestWanted()")
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGloabl_Window_Wanted_Set_Close()")
  self._ui._edit_Count:addInputEvent("Mouse_LUp", "HandleEventLUp_Window_Wanted_Set_ClearEditCount()")
  self._ui._edit_Cost:addInputEvent("Mouse_LUp", "HandleEventLUp_Window_Wanted_Set_ClearEditCost()")
  self._ui._edit_Count:RegistAllKeyEvent("PaGlobal_Window_Wanted_Set:checkMaxCount()")
  self._ui._edit_Cost:RegistAllKeyEvent("PaGlobal_Window_Wanted_Set:convertDotMoney()")
  self._ui._edit_Cost:RegistReturnKeyEvent("PaGlobal_Window_Wanted_Set:checkMinCost()")
end
function PaGlobal_Window_Wanted_Set:checkMaxCount()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  if nil == self._ui._edit_Count then
    return
  end
  local editText = self._ui._edit_Count:GetEditText()
  local countString = self._ui._edit_Count:GetEditText()
  if "" == countString or nil == countString then
    return
  end
  local convertCount = tonumber(countString)
  if nil == convertCount then
    convertCount = 1
  end
  convertCount = math.max(1, math.min(convertCount, PaGlobal_Window_Wanted_Set._MAXWANTEDCOUNT))
  self._ui._edit_Count:SetEditText(tostring(convertCount))
end
function PaGlobal_Window_Wanted_Set:checkMinCost()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  local costString = self._ui._edit_Cost:GetEditText()
  if nil ~= costString then
    costString = string.gsub(costString, ",", "")
  end
  local convertCost = tonumber64u(costString)
  if nil == convertCost then
    convertCost = self._MINWANTEDCOST
  end
  if convertCost < self._MINWANTEDCOST then
    convertCost = self._MINWANTEDCOST
  elseif convertCost > self._MAXWANTEDCOST then
    convertCost = self._MAXWANTEDCOST
  end
  self._ui._edit_Cost:SetEditText(makeDotMoney(convertCost))
end
function PaGlobal_Window_Wanted_Set:convertDotMoney()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  local costString = self._ui._edit_Cost:GetEditText()
  if nil ~= costString then
    costString = string.gsub(costString, ",", "")
  end
  local convertCost = tonumber64u(costString)
  if nil == convertCost then
    convertCost = self._MINWANTEDCOST
  end
  self._ui._edit_Cost:SetEditText(makeDotMoney(convertCost))
end
function PaGlobal_Window_Wanted_Set:prepareOpen(characterNo, killerName, deadTime)
  if nil == Panel_Window_Wanted_Set then
    return
  end
  Panel_Window_Wanted_Set:ComputePos()
  PaGlobal_Window_Wanted_Set:dataClear()
  PaGlobal_Window_Wanted_Set:setCurrentValueString()
  PaGlobal_Window_Wanted_Set._wantedCharacterNo = characterNo
  PaGlobal_Window_Wanted_Set._wantedName = killerName
  PaGlobal_Window_Wanted_Set._deadTime = deadTime
  PaGlobal_Window_Wanted_Set:open()
end
function PaGlobal_Window_Wanted_Set:open()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  Panel_Window_Wanted_Set:SetShow(true)
end
function PaGlobal_Window_Wanted_Set:dataClear()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  self._wantedCharacterNo = toInt64(0, 0)
  self._wantedName = ""
  self._wantedCount = 0
  self._wantedCost = toUint64(0, 0)
  self._deadTime = toInt64(0, 0)
  self._currentWantedString = ""
  self._totalCost = toUint64(0, 0)
  ClearFocusEdit()
  local stringWantedCount = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WANTED_COUNT")
  local stringWantedCost = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WANTED_MONEY")
  self._ui._edit_Count:SetEditText(stringWantedCount)
  self._ui._edit_Cost:SetEditText(stringWantedCost)
end
function PaGlobal_Window_Wanted_Set:prepareClose()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  PaGlobal_Window_Wanted_Set:close()
end
function PaGlobal_Window_Wanted_Set:close()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  Panel_Window_Wanted_Set:SetShow(false)
end
function PaGlobal_Window_Wanted_Set:update()
  if nil == Panel_Window_Wanted_Set then
    return
  end
end
function PaGlobal_Window_Wanted_Set:validate()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  self._ui._stc_mainBg:isValidate()
  self._ui._stc_titleBg:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._edit_Count:isValidate()
  self._ui._edit_Cost:isValidate()
  self._ui._btn_Wanted:isValidate()
  self._ui._stc_DescBg:isValidate()
  self._ui._stc_Desc:isValidate()
end
function PaGlobal_Window_Wanted_Set:setCurrentValueString()
  if nil == Panel_Window_Wanted_Set then
    return
  end
  local name = PaGlobal_Window_Wanted_Set._wantedName
  local count = PaGlobal_Window_Wanted_Set._wantedCount
  local cost = PaGlobal_Window_Wanted_Set._wantedCost
  self._currentWantedString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WANTED_TOP_VIEW_TXT", "name", name, "money", makeDotMoney(cost), "deathCount", tostring(count))
end
