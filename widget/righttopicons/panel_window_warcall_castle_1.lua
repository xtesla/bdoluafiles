function PaGlobal_Warcall_Castle:initialize()
  if true == PaGlobal_Warcall_Castle._initialize then
    return
  end
  PaGlobal_Warcall_Castle._ui._stc_BG = UI.getChildControl(Panel_Window_Warcall_Castle, "Static_Main_BG")
  PaGlobal_Warcall_Castle._ui._list_castle = UI.getChildControl(PaGlobal_Warcall_Castle._ui._stc_BG, "List2_1")
  local titleBG = UI.getChildControl(PaGlobal_Warcall_Castle._ui._stc_BG, "Static_Title_BG")
  PaGlobal_Warcall_Castle._ui._btn_closeX = UI.getChildControl(titleBG, "Button_Close")
  PaGlobal_Warcall_Castle._ui._btn_confirm = UI.getChildControl(PaGlobal_Warcall_Castle._ui._stc_BG, "Button_Confirm")
  PaGlobal_Warcall_Castle._ui._btn_close = UI.getChildControl(PaGlobal_Warcall_Castle._ui._stc_BG, "Button_Cancel")
  PaGlobal_Warcall_Castle:registEventHandler()
  PaGlobal_Warcall_Castle:validate()
  PaGlobal_Warcall_Castle._initialize = true
end
function PaGlobal_Warcall_Castle:registEventHandler()
  if nil == Panel_Window_Warcall_Castle then
    return
  end
  self._ui._list_castle:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_Warcall_Castle_List2Update")
  self._ui._list_castle:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_closeX:addInputEvent("Mouse_LUp", "PaGlobal_Warcall_Castle_Close()")
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGlobal_Warcall_Castle_TeleportSelectRegion()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Warcall_Castle_Close()")
end
function PaGlobal_Warcall_Castle:prepareOpen()
  if nil == Panel_Window_Warcall_Castle then
    return
  end
  if nil == Panel_Widget_Function then
    return
  end
  local posX = Panel_Widget_Function:GetPosX()
  local posY = Panel_Widget_Function:GetPosY() + Panel_Widget_Function:GetSizeY()
  Panel_Window_Warcall_Castle:SetPosXY(posX, posY)
  self:update()
  self:open()
end
function PaGlobal_Warcall_Castle:open()
  if nil == Panel_Window_Warcall_Castle then
    return
  end
  Panel_Window_Warcall_Castle:SetShow(true)
end
function PaGlobal_Warcall_Castle:prepareClose()
  if nil == Panel_Window_Warcall_Castle then
    return
  end
  PaGlobal_Warcall_Castle:close()
end
function PaGlobal_Warcall_Castle:close()
  if nil == Panel_Window_Warcall_Castle then
    return
  end
  Panel_Window_Warcall_Castle:SetShow(false)
end
function PaGlobal_Warcall_Castle:update()
  if nil == Panel_Window_Warcall_Castle then
    return
  end
  if nil == Panel_Window_Warcall_Castle then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local guildNo = selfPlayer:getGuildNo_s64()
  if true == selfPlayer:isGuildAllianceMember() then
    guildNo = selfPlayer:getGuildAllianceNo_s64()
  end
  local count = ToClient_getCurrnetBuildingCount(guildNo)
  self._ui._list_castle:getElementManager():clearKey()
  for ii = 1, count do
    local householdNo = ToClient_getHouseholdNoAtIndex(guildNo, ii - 1)
    if 0 ~= householdNo then
      local buildingInfo = ToClient_getBuildingInfoByHouseholdNo(householdNo)
      if nil ~= buildingInfo then
        self._ui._list_castle:getElementManager():pushKey(householdNo)
      end
    end
  end
end
function PaGlobal_Warcall_Castle:validate()
  if nil == Panel_Window_Warcall_Castle then
    return
  end
  PaGlobal_Warcall_Castle._ui._stc_BG:isValidate()
  PaGlobal_Warcall_Castle._ui._list_castle:isValidate()
  PaGlobal_Warcall_Castle._ui._btn_closeX:isValidate()
  PaGlobal_Warcall_Castle._ui._btn_confirm:isValidate()
  PaGlobal_Warcall_Castle._ui._btn_close:isValidate()
end
function PaGlobal_Warcall_Castle:list2Update(content, key)
  if nil == Panel_Window_Warcall_Castle or nil == key then
    return
  end
  local buildingInfo = ToClient_getBuildingInfoByHouseholdNo(key)
  if nil ~= buildingInfo then
    local button = UI.getChildControl(content, "RadioButton_Slot")
    local regionName = UI.getChildControl(button, "StaticText_RegionName")
    local mainIcon = UI.getChildControl(button, "Static_Castle_Type_Main")
    local normalIcon = UI.getChildControl(button, "Static_Castle_Type_Normal")
    if true == ToClient_IsVillageSiegeBeing() then
      buildingRegionKey = buildingInfo:getBuildingRegionKey()
    else
      buildingRegionKey = buildingInfo:getAffiliatedRegionKey()
    end
    local isCapital = buildingRegionKey:get() == ToClient_getGuildCapital()
    mainIcon:SetShow(true == isCapital)
    normalIcon:SetShow(false == isCapital)
    button:addInputEvent("Mouse_LUp", "PaGlobal_Warcall_Castle_SetTeleportRegion(" .. buildingRegionKey:get() .. ")")
    local regionInfo = getRegionInfoByRegionKey(buildingRegionKey)
    if nil ~= regionInfo then
      regionName:SetText(regionInfo:getAreaName())
    end
  end
end
function PaGlobal_Warcall_Castle:setTeleportRegion(regionKey)
  if nil == Panel_Window_Warcall_Castle then
    return
  end
  self._teleportRegionKey = regionKey
end
function PaGlobal_Warcall_Castle_SetTeleportRegion(regionKey)
  if nil == PaGlobal_Warcall_Castle then
    return
  end
  PaGlobal_Warcall_Castle:setTeleportRegion(regionKey)
end
function PaGlobal_Warcall_Castle_TeleportSelectRegion()
  if nil == PaGlobal_Warcall_Castle then
    return
  end
  if nil == PaGlobal_Warcall_Castle._teleportRegionKey then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotSelectTeleportRegion"))
    return
  end
  ToClient_RequestTeleportToSiegeTentCallSelectRegion(PaGlobal_Warcall_Castle._teleportRegionKey)
end
