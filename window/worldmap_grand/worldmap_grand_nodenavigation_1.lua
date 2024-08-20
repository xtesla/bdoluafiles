local VCK = CppEnums.VirtualKeyCode
local defaultValueBgSizeY = UI.getChildControl(Panel_Worldmap_NodeCal, "Static_Value_BG"):GetSizeY()
function PaGlobal_Worldmap_Grand_NodeNavigation:initialize()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  if true == self._initialize then
    return
  end
  local static_searchGroupBg = UI.getChildControl(Panel_Worldmap_NodeCal, "Static_Search_Group_Bg")
  local static_fromSearchBox = UI.getChildControl(static_searchGroupBg, "Static_SearchBox_1")
  local static_toSearchBox = UI.getChildControl(static_searchGroupBg, "Static_SearchBox_2")
  local static_valueBg = UI.getChildControl(Panel_Worldmap_NodeCal, "Static_Value_BG")
  self._ui._fromSearchEditBox = UI.getChildControl(static_fromSearchBox, "Edit_SearchBox")
  self._ui._fromSearchBoxDefaultText = UI.getChildControl(self._ui._fromSearchEditBox, "StaticText_DefaltText")
  self._ui._fromSearchResult = UI.getChildControl(static_fromSearchBox, "Static_Search_Result")
  self._ui._fromScroll = UI.getChildControl(self._ui._fromSearchResult, "Scroll_1")
  self._ui._toSearchEditBox = UI.getChildControl(static_toSearchBox, "Edit_SearchBox")
  self._ui._toSearchBoxDefaultText = UI.getChildControl(self._ui._toSearchEditBox, "StaticText_DefaltText")
  self._ui._toSearchResult = UI.getChildControl(static_toSearchBox, "Static_Search_Result")
  self._ui._toScroll = UI.getChildControl(self._ui._toSearchResult, "Scroll_1")
  self._ui._selectedCount = UI.getChildControl(static_valueBg, "StaticText_Count_Value")
  self._ui._needExplorationPoint = UI.getChildControl(static_valueBg, "StaticText_NeedPoint")
  self._ui._isPossibleRemoteInvestment = UI.getChildControl(static_valueBg, "StaticText_ValuePack")
  self._ui._needWP = UI.getChildControl(static_valueBg, "StaticText_NeedWP")
  self._ui._emptyDesc = UI.getChildControl(static_valueBg, "StaticText_Empty_Desc")
  self._ui._closeBtn = UI.getChildControl(Panel_Worldmap_NodeCal, "Button_Close")
  self._ui._preViewBtn = UI.getChildControl(static_searchGroupBg, "Button_Preview")
  self._ui._clearBtn = UI.getChildControl(static_searchGroupBg, "Button_Clear")
  self._ui._connectAllBtn = UI.getChildControl(Panel_Worldmap_NodeCal, "Button_Confirm")
  self._ui._findModeCheckBox = UI.getChildControl(static_searchGroupBg, "CheckButton_1")
  static_searchGroupBg:SetChildIndex(static_fromSearchBox, 9999)
  static_searchGroupBg:SetChildIndex(self._ui._findModeCheckBox, 1)
  self:registEventHandler()
  self:validate()
  PaGlobal_Worldmap_Grand_NodeNavigation:modifyDefaultTextSize()
  PaGlobal_Worldmap_Grand_NodeNavigation:makeSearchResultSlotPool()
  self._initialize = true
end
function PaGlobal_Worldmap_Grand_NodeNavigation:registEventHandler()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  self._ui._closeBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_NodeNavigation_Close()")
  self._ui._preViewBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_NodeNavigation_Preview()")
  self._ui._clearBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_NodeNavigation_Clear()")
  self._ui._connectAllBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_NodeNavigation_ConnectAll()")
  self._ui._fromSearchEditBox:addInputEvent("Mouse_LUp", "HandleEventLUP_Worldmap_Grand_NodeNavigation_OnClicked_FromSearchEditBox()")
  self._ui._fromSearchResult:addInputEvent("Mouse_UpScroll", "HandleEventMouseScroll_Worldmap_Grand_NodeNavigation_FindResultSlotList( true )")
  self._ui._fromSearchResult:addInputEvent("Mouse_DownScroll", "HandleEventMouseScroll_Worldmap_Grand_NodeNavigation_FindResultSlotList( false )")
  self._ui._toSearchEditBox:addInputEvent("Mouse_LUp", "HandleEventLUP_Worldmap_Grand_NodeNavigation_OnClicked_ToSearchEditBox()")
  self._ui._toSearchResult:addInputEvent("Mouse_UpScroll", "HandleEventMouseScroll_Worldmap_Grand_NodeNavigation_FindResultSlotList( true )")
  self._ui._toSearchResult:addInputEvent("Mouse_DownScroll", "HandleEventMouseScroll_Worldmap_Grand_NodeNavigation_FindResultSlotList( false )")
  self._ui._findModeCheckBox:addInputEvent("Mouse_LUp", "HandleEventMouseLUP_WorldMap_Grand_NodeNavigation_OnClicked_CheckBox()")
  registerEvent("FromClient_InputedWorldMapFromNode", "FromClient_InputedWorldMapFromNode_WorldMap_NodeNavigation")
  registerEvent("FromClient_InputedWorldMapToNode", "FromClient_InputedWorldMapToNode_WorldMap_NodeNavigation")
  registerEvent("FromClient_ClearWorldMapNodeNaviData", "FromClient_ClearWorldMapNodeNaviData_WorldMap_NodeNavigation")
  registerEvent("FromClient_NeedInvestmentFromBaseExplorationNode", "FromClient_NeedInvestmentFromBaseExplorationNode_WorldMap_NodeNavigation")
end
function PaGlobal_Worldmap_Grand_NodeNavigation:validate()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  self._ui._fromSearchEditBox:isValidate()
  self._ui._fromSearchBoxDefaultText:isValidate()
  self._ui._fromSearchResult:isValidate()
  self._ui._fromScroll:isValidate()
  self._ui._toSearchEditBox:isValidate()
  self._ui._toSearchBoxDefaultText:isValidate()
  self._ui._toSearchResult:isValidate()
  self._ui._toScroll:isValidate()
  self._ui._selectedCount:isValidate()
  self._ui._needExplorationPoint:isValidate()
  self._ui._isPossibleRemoteInvestment:isValidate()
  self._ui._needWP:isValidate()
  self._ui._emptyDesc:isValidate()
  self._ui._closeBtn:isValidate()
  self._ui._preViewBtn:isValidate()
  self._ui._clearBtn:isValidate()
  self._ui._connectAllBtn:isValidate()
  self._ui._findModeCheckBox:isValidate()
end
function PaGlobal_Worldmap_Grand_NodeNavigation:modifyDefaultTextSize()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  local emptyText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_NODECAL_DESC")
  self._ui._emptyDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._emptyDesc:SetText(emptyText)
end
function PaGlobal_Worldmap_Grand_NodeNavigation:makeSearchResultSlotPool()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  for idx = 0, self._searchResultMaxCount - 1 do
    self._fromSearchResultSlotPool[idx] = UI.createAndCopyBasePropertyControl(self._ui._fromSearchResult, "StaticText_Templete_Slot", self._ui._fromSearchResult, "WorldmapGrand_FromSearchResultList_" .. idx)
    self._fromSearchResultSlotPool[idx]:SetPosX(4)
    self._fromSearchResultSlotPool[idx]:SetPosY(5 + (self._fromSearchResultSlotPool[idx]:GetSizeY() + 3) * idx)
    self._fromSearchResultSlotPool[idx]:SetText("")
    self._fromSearchResultSlotPool[idx]:SetShow(false)
    self._toSearchResultSlotPool[idx] = UI.createAndCopyBasePropertyControl(self._ui._toSearchResult, "StaticText_Templete_Slot", self._ui._toSearchResult, "WorldmapGrand_ToSearchResultList_" .. idx)
    self._toSearchResultSlotPool[idx]:SetPosX(4)
    self._toSearchResultSlotPool[idx]:SetPosY(5 + (self._toSearchResultSlotPool[idx]:GetSizeY() + 3) * idx)
    self._toSearchResultSlotPool[idx]:SetText("")
    self._toSearchResultSlotPool[idx]:SetShow(false)
  end
end
function PaGlobal_Worldmap_Grand_NodeNavigation:prepareOpen()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  self._ui._fromSearchResult:SetShow(false)
  self._ui._toSearchResult:SetShow(false)
  self._ui._selectedCount:SetShow(false)
  self._ui._needExplorationPoint:SetShow(false)
  self._ui._isPossibleRemoteInvestment:SetShow(false)
  self._ui._needWP:SetShow(false)
  self._ui._emptyDesc:SetShow(true)
  self._scrollStartSlotIndex = 0
  self._ui._fromScroll:SetControlPos(0)
  self._ui._toScroll:SetControlPos(0)
  self._ui._findModeCheckBox:SetCheck(false)
  PaGlobal_Worldmap_Grand_NodeNavigation:modifyNeedValueTextSize()
  PaGlobal_Worldmap_Grand_NodeNavigation:open()
end
function PaGlobal_Worldmap_Grand_NodeNavigation:open()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  ToClient_SetWorldMapNavigationMode(true)
  Panel_Worldmap_NodeCal:SetShow(true)
end
function PaGlobal_Worldmap_Grand_NodeNavigation:prepareClose()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:close()
end
function PaGlobal_Worldmap_Grand_NodeNavigation:close()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  Panel_Worldmap_NodeCal:SetShow(false)
end
function PaGlobal_Worldmap_Grand_NodeNavigation:registUpdate(isOnUpdate)
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  if true == isOnUpdate then
    Panel_Worldmap_NodeCal:RegisterUpdateFunc("PaGlobal_Worldmap_Grand_NodeNavigation_Update")
  else
    Panel_Worldmap_NodeCal:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Worldmap_Grand_NodeNavigation_Update(deltaTime)
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  if false == Panel_Worldmap_NodeCal:GetShow() then
    return
  end
  local self = PaGlobal_Worldmap_Grand_NodeNavigation
  if true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    self._lastClickedEditBox = ""
    if "" == self._ui._fromSearchEditBox:GetEditText() then
      self._ui._fromSearchBoxDefaultText:SetShow(true)
    end
    if "" == self._ui._toSearchEditBox:GetEditText() then
      self._ui._toSearchBoxDefaultText:SetShow(true)
    end
    self._ui._fromSearchResult:SetShow(false)
    self._ui._toSearchResult:SetShow(false)
    self._scrollStartSlotIndex = 0
    self._ui._fromScroll:SetControlPos(0)
    self._ui._toScroll:SetControlPos(0)
  elseif true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
    local isFromEditBox = false
    if self._lastClickedEditBox == "FromSearchEditBox" then
      isFromEditBox = true
    elseif self._lastClickedEditBox == "ToSearchEditBox" then
      isFromEditBox = false
    else
      return
    end
    local inputString = ""
    if true == isFromEditBox then
      inputString = self._ui._fromSearchEditBox:GetEditText()
    else
      inputString = self._ui._toSearchEditBox:GetEditText()
    end
    if "" == inputString then
      return
    end
    self._searchResultCount = ToClient_FindNodeByName(inputString)
    if 0 == self._searchResultCount then
      return
    end
    if true == isFromEditBox then
      self._ui._fromSearchResult:SetShow(true)
    else
      self._ui._toSearchResult:SetShow(true)
    end
    self._scrollStartSlotIndex = 0
    local pool, scroll
    if true == isFromEditBox then
      pool = self._fromSearchResultSlotPool
      scroll = self._ui._fromScroll
    else
      pool = self._toSearchResultSlotPool
      scroll = self._ui._toScroll
    end
    scroll:SetControlPos(0)
    PaGlobal_Worldmap_Grand_NodeNavigation:clearFindResultSlotPool(false)
    PaGlobal_Worldmap_Grand_NodeNavigation:updateFindResultSlotList()
  end
end
function PaGlobal_Worldmap_Grand_NodeNavigation:updateFindResultSlotList()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  local isFromEditBox = false
  if self._lastClickedEditBox == "FromSearchEditBox" then
    isFromEditBox = true
  elseif self._lastClickedEditBox == "ToSearchEditBox" then
    isFromEditBox = false
  else
    return
  end
  local pool
  if true == isFromEditBox then
    pool = self._fromSearchResultSlotPool
  else
    pool = self._toSearchResultSlotPool
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:clearFindResultSlotPool(false)
  local slotCount = 0
  for idx = self._scrollStartSlotIndex, self._searchResultCount - 1 do
    if slotCount >= self._searchResultMaxCount then
      break
    end
    local findNodeName = ToClient_getFindResultNameByIndex(idx)
    local slot = pool[slotCount]
    slot:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_NodeNavigation_onClicked_SearchResultSlot(" .. idx .. ")")
    slot:addInputEvent("Mouse_UpScroll", "HandleEventMouseScroll_Worldmap_Grand_NodeNavigation_FindResultSlotList( true )")
    slot:addInputEvent("Mouse_DownScroll", "HandleEventMouseScroll_Worldmap_Grand_NodeNavigation_FindResultSlotList( false )")
    slot:SetText(findNodeName)
    slot:SetShow(true)
    slotCount = slotCount + 1
  end
  local scroll
  if true == isFromEditBox then
    scroll = self._ui._fromScroll
  else
    scroll = self._ui._toScroll
  end
  UIScroll.SetButtonSize(scroll, self._searchResultMaxCount, self._searchResultCount)
end
function PaGlobal_Worldmap_Grand_NodeNavigation:onScrollResultSlotList(isUpScroll)
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  local isFromEditBox = false
  if self._lastClickedEditBox == "FromSearchEditBox" then
    isFromEditBox = true
  elseif self._lastClickedEditBox == "ToSearchEditBox" then
    isFromEditBox = false
  else
    return
  end
  local scroll
  if true == isFromEditBox then
    scroll = self._ui._fromScroll
  else
    scroll = self._ui._toScroll
  end
  self._scrollStartSlotIndex = UIScroll.ScrollEvent(scroll, isUpScroll, self._searchResultMaxCount, self._searchResultCount, self._scrollStartSlotIndex, 1)
  PaGlobal_Worldmap_Grand_NodeNavigation:updateFindResultSlotList()
end
function PaGlobal_Worldmap_Grand_NodeNavigation:onClickedResultSlot(index)
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  local nodeName = ToClient_getFindResultNameByIndex(index)
  if "" == nodeName then
    return
  end
  self._scrollStartSlotIndex = 0
  if self._lastClickedEditBox == "FromSearchEditBox" then
    self._ui._fromSearchEditBox:SetEditText(nodeName)
    self._ui._fromSearchResult:SetShow(false)
    self._ui._fromScroll:SetControlPos(0)
  elseif self._lastClickedEditBox == "ToSearchEditBox" then
    self._ui._toSearchEditBox:SetEditText(nodeName)
    self._ui._toSearchResult:SetShow(false)
    self._ui._toScroll:SetControlPos(0)
  end
end
function PaGlobal_Worldmap_Grand_NodeNavigation:onClickedCheckBox()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  ToClient_SetWorldMapNodeNavigationFindMode(self._ui._findModeCheckBox:IsCheck())
end
function PaGlobal_Worldmap_Grand_NodeNavigation:onSelectedFromNode(nodeName)
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  self._ui._fromSearchEditBox:SetEditText(nodeName)
  self._ui._fromSearchBoxDefaultText:SetShow(false)
end
function PaGlobal_Worldmap_Grand_NodeNavigation:onSelectedToNode(nodeName)
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    PaGlobal_Worldmap_Grand_NodeNavigation:clearUI()
    PaGlobal_Worldmap_Grand_NodeNavigation:clearClient()
    return
  end
  local player = selfPlayer:get()
  self._ui._emptyDesc:SetShow(false)
  self._ui._toSearchEditBox:SetEditText(nodeName)
  self._ui._toSearchBoxDefaultText:SetShow(false)
  self._ui._selectedCount:SetTextMode(__eTextMode_AutoWrap)
  self._ui._selectedCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODECAL_VALUE_COUNT", "count", tostring(ToClient_GetWorldMapNodePathCount())))
  self._ui._selectedCount:SetShow(true)
  local territoryKeyRaw = ToClient_getDefaultTerritoryKey()
  local explorePoint = ToClient_getExplorePointByTerritoryRaw(territoryKeyRaw)
  local currentHaveCP = explorePoint:getRemainedPoint()
  local needCP = ToClient_GetWorldMapNodePathNeedExplorationPoint()
  local showCPText = ""
  if currentHaveCP < needCP then
    showCPText = "<PAColor0xFFF21E13>" .. tostring(needCP) .. "<PAOldColor>"
  else
    showCPText = "<PAColor0xFFFFD649>" .. tostring(needCP) .. "<PAOldColor>"
  end
  self._ui._needExplorationPoint:SetTextMode(__eTextMode_AutoWrap)
  self._ui._needExplorationPoint:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NODECAL_VALUE_NEEDCP", "CP", showCPText, "mycp", tostring(currentHaveCP)))
  self._ui._needExplorationPoint:SetShow(true)
  local applyPremium = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_PremiumPackage)
  local isPossibleText = ""
  if true == applyPremium then
    isPossibleText = "<PAColor0xFFFFD649>" .. PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_POSSIBLE") .. "<PAOldColor>"
    self._ui._connectAllBtn:SetIgnore(false)
  else
    isPossibleText = "<PAColor0xFFF21E13>" .. PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_IMPOSSIBLE") .. "<PAOldColor>"
    self._ui._connectAllBtn:SetIgnore(true)
  end
  self._ui._isPossibleRemoteInvestment:SetTextMode(__eTextMode_AutoWrap)
  self._ui._isPossibleRemoteInvestment:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODECAL_VALUE_VALUEPACK", "buff", isPossibleText))
  self._ui._isPossibleRemoteInvestment:SetShow(true)
  local needWP = ToClient_GetPossibleInvestmentNodeCountInWorldMapNodePath() * 10
  local currentHaveWP = selfPlayer:getWp()
  local showWPText = ""
  if needWP > currentHaveWP then
    showWPText = "<PAColor0xFFF21E13>" .. tostring(needWP) .. "<PAOldColor>"
  else
    showWPText = "<PAColor0xFFFFD649>" .. tostring(needWP) .. "<PAOldColor>"
  end
  self._ui._needWP:SetTextMode(__eTextMode_AutoWrap)
  self._ui._needWP:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NODECAL_VALUE_NEEDWP", "wp", showWPText, "mywp", tostring(currentHaveWP)))
  self._ui._needWP:SetShow(true)
  PaGlobal_Worldmap_Grand_NodeNavigation:modifyNeedValueTextSize()
end
function PaGlobal_Worldmap_Grand_NodeNavigation:modifyNeedValueTextSize()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  local valueBg = UI.getChildControl(Panel_Worldmap_NodeCal, "Static_Value_BG")
  if true == self._ui._emptyDesc:GetShow() then
    valueBg:SetSize(valueBg:GetSizeX(), defaultValueBgSizeY)
    Panel_Worldmap_NodeCal:SetSize(Panel_Worldmap_NodeCal:GetSizeX(), valueBg:GetSpanSize().y + valueBg:GetSizeY() + self._ui._connectAllBtn:GetSizeY() + 25)
  else
    local unitSpanY = 5
    self._ui._selectedCount:SetSize(self._ui._selectedCount:GetSizeX(), self._ui._selectedCount:GetTextSizeY())
    self._ui._needExplorationPoint:SetSize(self._ui._needExplorationPoint:GetSizeX(), self._ui._needExplorationPoint:GetTextSizeY())
    self._ui._needExplorationPoint:SetSpanSize(self._ui._needExplorationPoint:GetSpanSize().x, self._ui._selectedCount:GetSpanSize().y + self._ui._selectedCount:GetSizeY() + unitSpanY)
    self._ui._isPossibleRemoteInvestment:SetSize(self._ui._isPossibleRemoteInvestment:GetSizeX(), self._ui._isPossibleRemoteInvestment:GetTextSizeY())
    self._ui._isPossibleRemoteInvestment:SetSpanSize(self._ui._isPossibleRemoteInvestment:GetSpanSize().x, self._ui._needExplorationPoint:GetSpanSize().y + self._ui._needExplorationPoint:GetSizeY() + unitSpanY)
    self._ui._needWP:SetSize(self._ui._needWP:GetSizeX(), self._ui._needWP:GetTextSizeY())
    self._ui._needWP:SetSpanSize(self._ui._needWP:GetSpanSize().x, self._ui._isPossibleRemoteInvestment:GetSpanSize().y + self._ui._isPossibleRemoteInvestment:GetSizeY() + unitSpanY)
    valueBg:SetSize(valueBg:GetSizeX(), self._ui._needWP:GetSpanSize().y + self._ui._needWP:GetSizeY() + self._ui._selectedCount:GetSpanSize().y)
    Panel_Worldmap_NodeCal:SetSize(Panel_Worldmap_NodeCal:GetSizeX(), valueBg:GetSpanSize().y + valueBg:GetSizeY() + self._ui._connectAllBtn:GetSizeY() + 25)
  end
  self._ui._selectedCount:ComputePos()
  self._ui._needExplorationPoint:ComputePos()
  self._ui._isPossibleRemoteInvestment:ComputePos()
  self._ui._needWP:ComputePos()
  valueBg:ComputePos()
  self._ui._connectAllBtn:ComputePos()
  Panel_Worldmap_NodeCal:ComputePos()
end
function PaGlobal_Worldmap_Grand_NodeNavigation:clearUI()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  self._ui._fromSearchEditBox:SetEditText("")
  if self._lastClickedEditBox ~= "FromSearchEditBox" then
    self._ui._fromSearchBoxDefaultText:SetShow(true)
  end
  self._ui._fromSearchResult:SetShow(false)
  self._ui._toSearchEditBox:SetEditText("")
  if self._lastClickedEditBox ~= "ToSearchEditBox" then
    self._ui._toSearchBoxDefaultText:SetShow(true)
  end
  self._ui._toSearchResult:SetShow(false)
  self._ui._selectedCount:SetShow(false)
  self._ui._needExplorationPoint:SetShow(false)
  self._ui._isPossibleRemoteInvestment:SetShow(false)
  self._ui._needWP:SetShow(false)
  self._ui._emptyDesc:SetShow(true)
  self._ui._findModeCheckBox:SetCheck(false)
  PaGlobal_Worldmap_Grand_NodeNavigation:modifyNeedValueTextSize()
end
function PaGlobal_Worldmap_Grand_NodeNavigation:clearFindResultSlotPool(isShow)
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  for idx = 0, self._searchResultMaxCount - 1 do
    self._fromSearchResultSlotPool[idx]:SetTextMode(__eTextMode_Limit_AutoWra)
    self._fromSearchResultSlotPool[idx]:SetText("")
    self._fromSearchResultSlotPool[idx]:SetShow(isShow)
    self._fromSearchResultSlotPool[idx]:addInputEvent("Mouse_LUp", "")
    self._toSearchResultSlotPool[idx]:SetTextMode(__eTextMode_Limit_AutoWra)
    self._toSearchResultSlotPool[idx]:SetText("")
    self._toSearchResultSlotPool[idx]:SetShow(isShow)
    self._toSearchResultSlotPool[idx]:addInputEvent("Mouse_LUp", "")
  end
end
function PaGlobal_Worldmap_Grand_NodeNavigation:clearClient()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  ToClient_WorldMapNodeNavigationDataClear()
end
function PaGlobal_Worldmap_Grand_NodeNavigation:connectAll()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local applyPremium = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_PremiumPackage)
  if false == applyPremium then
    return
  end
  local territoryKeyRaw = ToClient_getDefaultTerritoryKey()
  local explorePoint = ToClient_getExplorePointByTerritoryRaw(territoryKeyRaw)
  local currentHaveCP = explorePoint:getRemainedPoint()
  local needCP = ToClient_GetWorldMapNodePathNeedExplorationPoint()
  if currentHaveCP < needCP then
    PaGlobal_Worldmap_Grand_NodeNavigation:showMessageBoxTypeForNeedCP()
    return
  end
  local pathNodeCount = ToClient_GetPossibleInvestmentNodeCountInWorldMapNodePath()
  local needWP = pathNodeCount * 10
  local currentHaveWP = selfPlayer:getWp()
  if needWP > currentHaveWP then
    PaGlobal_Worldmap_Grand_NodeNavigation:showMessageBoxTypeForNeedWP()
    return
  end
  ToClient_tryToInvestCurrentNodeNavigationPath()
end
function PaGlobal_Worldmap_Grand_NodeNavigation:showMessageBoxTypeForNeedCP()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "DIALOG_ERROR_SHORTAGE_POINT"))
end
function PaGlobal_Worldmap_Grand_NodeNavigation:showMessageBoxTypeForNeedWP()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERRANDOMSELECT_SHORTAGE_WP_ACK"))
end
function PaGlobal_Worldmap_Grand_NodeNavigation:showMessageBoxTypeForNeedInvestmentFromBaseExplorationNode()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "PANEL_WORLDMAP_NODENOTUPGRADE"))
end
function PaGlobal_Worldmap_Grand_NodeNavigation:calcWorldMapNodeNavigation()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  ToClient_CalcWorldMapNodeNavationData(self._ui._fromSearchEditBox:GetEditText(), self._ui._toSearchEditBox:GetEditText())
end
function PaGlobal_Worldmap_Grand_NodeNavigation:onClickedEditBox(editBoxName)
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  if "FromSearchEditBox" == editBoxName then
    self._ui._fromSearchBoxDefaultText:SetShow(false)
    if "" == self._ui._toSearchEditBox:GetEditText() then
      self._ui._toSearchBoxDefaultText:SetShow(true)
      self._ui._toSearchResult:SetShow(false)
    end
  elseif "ToSearchEditBox" == editBoxName then
    self._ui._toSearchBoxDefaultText:SetShow(false)
    if "" == self._ui._fromSearchEditBox:GetEditText() then
      self._ui._fromSearchBoxDefaultText:SetShow(true)
      self._ui._fromSearchResult:SetShow(false)
    end
  else
    return
  end
  self._lastClickedEditBox = editBoxName
end
