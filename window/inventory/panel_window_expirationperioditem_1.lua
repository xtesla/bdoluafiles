function PaGlobal_ExpirationPeriodItem:initialize()
  self._ui._list2_bg = UI.getChildControl(Panel_Window_ExpirationPeriodItem, "Static_BG")
  self._ui._list2_itemList = UI.getChildControl(self._ui._list2_bg, "List2_Scroll")
  self._ui._btn_TodayNotShow = UI.getChildControl(Panel_Window_ExpirationPeriodItem, "CheckButton_RefuseGo")
  self:validate()
  self:registerEvent()
  self._panelSizeX = Panel_Window_ExpirationPeriodItem:GetSizeX()
  self._panelSizeY = Panel_Window_ExpirationPeriodItem:GetSizeY()
  self._list2SizeX = self._ui._list2_bg:GetSizeX()
  self._list2SizeY = self._ui._list2_bg:GetSizeY()
  self._btnPosY = self._ui._btn_check:GetPosY()
  self._btnNotShowTodayPosY = self._ui._btn_TodayNotShow:GetPosY()
  self._initialize = true
end
function PaGlobal_ExpirationPeriodItem:clear()
end
function PaGlobal_ExpirationPeriodItem:prepareOpen()
  if false == self:showByToday() then
    return
  end
  self:open()
end
function PaGlobal_ExpirationPeriodItem:open()
  if false == self._initialize then
    return
  end
  self:clear()
  local cnt = ToClient_getExpirationPeriodItemCount()
  if cnt <= 0 then
    return
  end
  self:resizeUI(cnt)
  self._ui._list2_itemList:getElementManager():clearKey()
  for ii = 0, cnt - 1 do
    self._ui._list2_itemList:getElementManager():pushKey(ii)
  end
  Panel_Window_ExpirationPeriodItem:SetShow(true)
end
function PaGlobal_ExpirationPeriodItem:prepareClose()
  if true == self._ui._btn_TodayNotShow:IsCheck() then
    self:saveToday()
  end
  self:close()
end
function PaGlobal_ExpirationPeriodItem:close()
  Panel_Window_ExpirationPeriodItem:SetShow(false)
end
function PaGlobal_ExpirationPeriodItem:validate()
  self._ui._btn_close:isValidate()
  self._ui._btn_check:isValidate()
end
function PaGlobal_ExpirationPeriodItem:registerEvent()
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ExpirationPeriodItem:prepareClose()")
  self._ui._btn_check:addInputEvent("Mouse_LUp", "PaGlobal_ExpirationPeriodItem:prepareClose()")
  self._ui._list2_itemList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ExpirationPeriodItem_List2Update")
  self._ui._list2_itemList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_UpdateNotifyExpirationPeriodItemList", "FromClient_UpdateNotifyExpirationPeriodItemList")
end
function PaGlobal_ExpirationPeriodItem:resizeUI(cnt)
  if cnt <= 1 then
    return
  end
  local maxCnt = 5
  local addSizeY = 0
  if cnt > maxCnt then
    addSizeY = self._list2SizeY * (maxCnt - 1)
  else
    addSizeY = self._list2SizeY * (cnt - 1)
  end
  Panel_Window_ExpirationPeriodItem:SetSize(self._panelSizeX, self._panelSizeY + addSizeY)
  self._ui._list2_bg:SetSize(self._list2SizeX, self._list2SizeY + addSizeY)
  self._ui._list2_itemList:SetSize(self._list2SizeX, self._list2SizeY + addSizeY)
  self._ui._btn_TodayNotShow:SetPosY(self._btnNotShowTodayPosY + addSizeY)
  self._ui._btn_check:SetPosY(self._btnPosY + addSizeY)
  self._ui._list2_itemList:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_ExpirationPeriodItem:saveToday()
  if nil == Panel_Window_ExpirationPeriodItem then
    return
  end
  local _year = ToClient_GetThisYear()
  local _month = ToClient_GetThisMonth()
  local _day = ToClient_GetToday()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListTime(__eExpirationPeriodItem, _year, _month, _day, 0, 0, 0, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_ExpirationPeriodItem:showByToday()
  if nil == Panel_Window_ExpirationPeriodItem then
    return false
  end
  local _year = ToClient_GetThisYear()
  local _month = ToClient_GetThisMonth()
  local _day = ToClient_GetToday()
  local dayCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListTime(__eExpirationPeriodItem)
  if nil ~= dayCheck then
    local savedYear = dayCheck:GetYear()
    local savedMonth = dayCheck:GetMonth()
    local savedDay = dayCheck:GetDay()
    if _year == savedYear and _month == savedMonth and _day == savedDay then
      return false
    end
  end
  return true
end
