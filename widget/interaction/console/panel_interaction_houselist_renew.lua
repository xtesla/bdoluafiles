local Interaction_HouseListInfo = {
  _ui = {
    _static_TabBg = UI.getChildControl(Panel_Interaction_HouseList, "Static_Tab_Group"),
    _staticText_Tooltip = UI.getChildControl(Panel_Interaction_HouseList, "StaticText_ToolTip"),
    _list2_MemberList = UI.getChildControl(Panel_Interaction_HouseList, "List2_MemberList"),
    _radioButton_Tab = {}
  },
  _config = {
    _rank = 0,
    _guild = 1,
    _friend = 2,
    _party = 3,
    _count = 4
  },
  _strConfig = {
    [0] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSERANK_TITLE"),
    [1] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYINVITE_FRIEND"),
    [2] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATTING_OPTION_FILTER_GUILD"),
    [3] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATTING_OPTION_FILTER_PARTY")
  },
  _houseInfoList = {},
  _currentTabIndex = 0,
  _isVisitHousePS = false
}
function Interaction_HouseListInfo:UpdateTabButton()
  for index = 0, self._config._count - 1 do
    self._ui._radioButton_Tab[index]:SetCheck(index == self._currentTabIndex)
  end
  self._ui._staticText_Tooltip:SetText(self._strConfig[self._currentTabIndex])
  self._ui._staticText_Tooltip:SetSize(self._ui._staticText_Tooltip:GetTextSizeX() + 10, self._ui._staticText_Tooltip:GetSizeY())
  self._ui._static_Arrow:ComputePos()
  local tooltipCenterX = self._ui._staticText_Tooltip:GetPosX() + self._ui._staticText_Tooltip:GetSizeX() / 2
  local radioButtonCenterX = self._ui._radioButton_Tab[self._currentTabIndex]:GetPosX() + self._ui._radioButton_Tab[self._currentTabIndex]:GetSizeX() / 2
  local offsetX = tooltipCenterX - radioButtonCenterX
  self._ui._staticText_Tooltip:SetPosX(radioButtonCenterX - self._ui._staticText_Tooltip:GetSizeX() / 2 + self._ui._static_Arrow:GetSizeX() / 2)
end
function Interaction_HouseListInfo:UpdateList()
  self._ui._list2_MemberList:getElementManager():clearKey()
  self._houseInfoList = {}
  local count = housing_getVisitableHouseWrapperCount()
  local isRequestMansion = ToClient_getVisitableListIsMansion()
  if count <= 0 then
    if false == isRequestMansion then
      self._houseInfoList[0] = {}
      self._houseInfoList[0]._name = PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_FRIENDHOUSELIST_EMPTYHOUSE")
      self._houseInfoList[0]._rank = 0
      self._houseInfoList[0]._point = 0
      self._houseInfoList[0]._isEmpty = true
      self._houseInfoList[0]._platformType = false
      self._ui._list2_MemberList:getElementManager():pushKey(toInt64(0, 0))
      self._ui._list2_MemberList:requestUpdateByKey(toInt64(0, 0))
    end
  else
    for index = 0, count - 1 do
      local visitableHouseWrapper = housing_getVisitableHouseWrapper(index)
      self._houseInfoList[index] = {}
      self._houseInfoList[index]._name = visitableHouseWrapper:getUserNickname()
      self._houseInfoList[index]._rank = index
      self._houseInfoList[index]._point = visitableHouseWrapper:getInteriorPoint()
      self._houseInfoList[index]._isEmpty = false
      self._houseInfoList[index]._platformType = visitableHouseWrapper:getPlatformType()
      if true == _ContentsGroup_RenewUI then
        local selfPlayerPlatform = ToClient_getGamePlatformType()
        if selfPlayerPlatform == self._houseInfoList[index]._platformType then
          self._houseInfoList[index]._name = visitableHouseWrapper:getUserNickname() .. " (" .. visitableHouseWrapper:getPlatformId() .. ")"
        end
      end
      self._ui._list2_MemberList:getElementManager():pushKey(toInt64(0, index))
      self._ui._list2_MemberList:requestUpdateByKey(toInt64(0, index))
    end
  end
end
function PaGlobalFunc_Interaction_HouseList_Update(type)
  local self = Interaction_HouseListInfo
  PaGlobalFunc_Interaction_HouseList_Open()
end
function PaGlobalFunc_Interaction_HouseList_SelectTab(value)
  local self = Interaction_HouseListInfo
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  self._currentTabIndex = self._currentTabIndex + value
  if self._currentTabIndex < 0 then
    self._currentTabIndex = self._config._count - 1
  end
  if self._config._count - 1 < self._currentTabIndex then
    self._currentTabIndex = 0
  end
  self:UpdateTabButton()
  housing_SelectVisitableHouseType(self._currentTabIndex)
end
function Interaction_HouseListInfo:InitControl()
  self._ui._radioButton_Tab[0] = UI.getChildControl(self._ui._static_TabBg, "RadioButton_Rank")
  self._ui._radioButton_Tab[1] = UI.getChildControl(self._ui._static_TabBg, "RadioButton_Guild")
  self._ui._radioButton_Tab[2] = UI.getChildControl(self._ui._static_TabBg, "RadioButton_Friend")
  self._ui._radioButton_Tab[3] = UI.getChildControl(self._ui._static_TabBg, "RadioButton_Party")
  self._ui._static_Arrow = UI.getChildControl(self._ui._staticText_Tooltip, "Static_ToolTip_Arrow")
end
function Interaction_HouseListInfo:InitEvent()
  self._ui._list2_MemberList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Interaction_HouseList_List2EventControlCreate")
  self._ui._list2_MemberList:createChildContent(__ePAUIList2ElementManagerType_List)
  Panel_Interaction_HouseList:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobalFunc_Interaction_HouseList_SelectTab(-1)")
  Panel_Interaction_HouseList:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobalFunc_Interaction_HouseList_SelectTab(1)")
end
function Interaction_HouseListInfo:InitRegister()
  registerEvent("EventUpdateHouseRankerList", "PaGlobalFunc_Interaction_HouseList_Open")
  registerEvent("EventUpdateVisitableHouseList", "PaGlobalFunc_Interaction_HouseList_Update")
end
function Interaction_HouseListInfo:Initialize()
  self:InitControl()
  self:InitEvent()
  self:InitRegister()
end
function PaGlobalFunc_Interaction_HouseList_List2EventControlCreate(list_content, key)
  local self = Interaction_HouseListInfo
  local id = Int64toInt32(key)
  local houseInfo = self._houseInfoList[id]
  if nil == houseInfo then
    return
  end
  local button_GuildSlot = UI.getChildControl(list_content, "Button_GuildSlot")
  local staticText_Rank = UI.getChildControl(list_content, "StaticText_Rank")
  local staticText_Name = UI.getChildControl(list_content, "StaticText_Name")
  local staticText_Point = UI.getChildControl(list_content, "StaticText_Point")
  local stc_platformIcon = UI.getChildControl(list_content, "Static_PlatformIcon")
  stc_platformIcon:SetShow(false)
  if false == houseInfo._isEmpty and true == ToClient_isTotalGameClient() then
    PaGlobalFunc_Interaction_HouseList_CrossPlayIconSetting(stc_platformIcon, houseInfo._platformType)
  end
  staticText_Rank:SetText(houseInfo._rank + 1)
  staticText_Point:SetText(houseInfo._point)
  staticText_Name:SetText(houseInfo._name)
  if true == _ContentsGroup_RenewUI then
    if false == houseInfo._isEmpty then
      button_GuildSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_Interaction_HouseList_VisitFriend(" .. id .. ",true )")
    else
      staticText_Rank:SetText("")
      staticText_Point:SetText("")
      button_GuildSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_Interaction_HouseList_VisitFriend(0,false)")
    end
  elseif false == houseInfo._isEmpty then
    button_GuildSlot:addInputEvent("Mouse_LUp", "PaGlobalFunc_Interaction_HouseList_VisitFriend(" .. id .. ",true )")
  else
    staticText_Rank:SetText("")
    staticText_Point:SetText("")
    button_GuildSlot:addInputEvent("Mouse_LUp", "PaGlobalFunc_Interaction_HouseList_VisitFriend(0,false)")
  end
end
function PaGlobalFunc_Interaction_HouseList_VisitFriend(index, isUse)
  Interaction_HouseListInfo._isVisitHousePS = false
  if true == isUse then
    housing_SelectVisitableHouse(index)
    local houseInfo = Interaction_HouseListInfo._houseInfoList[index]
    if nil ~= houseInfo then
      Interaction_HouseListInfo._isVisitHousePS = __eGAME_PLATFORM_TYPE_PS == houseInfo._platformType
    end
  else
    housing_visitEmptyHouse()
  end
  PaGlobalFunc_Interaction_HouseList_Close()
end
function PaGlobalFunc_Interaction_HouseList_IsVisitHousePS()
  return Interaction_HouseListInfo._isVisitHousePS
end
function PaGlobalFunc_Interaction_HouseList_GetShow()
  return Panel_Interaction_HouseList:GetShow()
end
function PaGlobalFunc_Interaction_HouseList_SetShow(isShow, isAni)
  Panel_Interaction_HouseList:SetShow(isShow, isAni)
end
function PaGlobalFunc_Interaction_HouseList_Open()
  local self = Interaction_HouseListInfo
  self:UpdateTabButton()
  self:UpdateList()
  PaGlobalFunc_Interaction_HouseList_SetShow(true, false)
end
function PaGlobalFunc_Interaction_HouseList_Close()
  local self = Interaction_HouseListInfo
  if false == PaGlobalFunc_Interaction_HouseList_GetShow() then
    return
  end
  self._currentTabIndex = 0
  PaGlobalFunc_Interaction_HouseList_SetShow(false, false)
end
function PaGlobalFunc_FromClient_Interaction_HouseList_luaLoadComplete()
  local self = Interaction_HouseListInfo
  self:Initialize()
end
function PaGlobalFunc_Interaction_HouseList_CrossPlayIconSetting(targetControl, platformType)
  if nil == platformType then
    return
  end
  if true == _ContentsGroup_ConsoleIntegration then
    targetControl:SetShow(true)
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    if selfPlayerPlatform == platformType then
      if __eGAME_PLATFORM_TYPE_PS == selfPlayerPlatform then
        targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_ps.dds")
      elseif __eGAME_PLATFORM_TYPE_XB == selfPlayerPlatform then
        targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_xb.dds")
      end
    else
      targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_other.dds")
    end
  end
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_FromClient_Interaction_HouseList_luaLoadComplete")
