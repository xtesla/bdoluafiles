local UI_VT = CppEnums.VillageSiegeType
local UI_color = Defines.Color
local nodeIconName = UI.getChildControl(Panel_WorldMap_Tooltip, "StaticText_IconName")
local nodeResultDropGroupMaxCount = 10
local nodeResultIconName = {}
local nodeResultIconBG = {}
local nodeResultIcon = {}
local nodeHelpBG = UI.getChildControl(Panel_WorldMap_Tooltip, "StaticText_NodeIconHelp_BG")
local nodeHelpMouseL = UI.getChildControl(Panel_WorldMap_Tooltip, "Static_Help_MouseL")
local nodeHelpMouseR = UI.getChildControl(Panel_WorldMap_Tooltip, "Static_Help_MouseR")
local partyMember = {}
local partyCount = 0
local MAX_PARTY_MEMBER = 20
local gradeString = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_LOW_LEVEL"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_MIDDLE_LEVEL"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_HIGH_LEVEL")
}
local Panel_WorldMap_PartyMemberIcon_table = {}
local Panel_WorldMap_PartyMemberTail_table = {}
local RenderModeWorldMapBitSet = PAUIRenderModeBitSet({
  Defines.RenderMode.eRenderMode_WorldMap
})
local Btn_SetCapital
Btn_SetCapital = UI.getChildControl(Panel_Worldmap_MainCitadelSelect, "Button_Apply")
Btn_SetCapital:addInputEvent("Mouse_LUp", "HandleEventLUp_SetCapital()")
local isAlreadySetPos = false
local function InitPartyMemberTooltipTable()
  Panel_WorldMap_PartyMemberIcon:SetIgnore(true)
  local Name = UI.getChildControl(Panel_WorldMap_PartyMemberIcon, "StaticText_PartyMemberName")
  local ClassIconBG = UI.getChildControl(Panel_WorldMap_PartyMemberIcon, "Static_PartyClassIconBG")
  local ClassIcon = UI.getChildControl(Panel_WorldMap_PartyMemberIcon, "Static_PartyClassIcon")
  local Level = UI.getChildControl(Panel_WorldMap_PartyMemberIcon, "StaticText_PartyLevel")
  local Tail = UI.getChildControl(Panel_WorldMap_PartyMemberTail, "Static_PartyTail")
  local PlatformIcon = UI.getChildControl(Panel_WorldMap_PartyMemberIcon, "Static_CrossPlay")
  Name:SetIgnore(true)
  ClassIconBG:SetIgnore(true)
  ClassIcon:SetIgnore(true)
  Level:SetIgnore(true)
  Tail:SetIgnore(true)
  PlatformIcon:SetIgnore(true)
  for ii = 1, MAX_PARTY_MEMBER do
    local panel = UI.createPanelAndSetPanelRenderMode("Panel_WorldMap_PartyMemberIcon" .. tostring(ii), Defines.UIGroup.PAGameUIGroup_Party + ii, RenderModeWorldMapBitSet)
    local panelTail = UI.createPanelAndSetPanelRenderMode("Panel_WorldMap_PartyMemberTail" .. tostring(ii), Defines.UIGroup.PAGameUIGroup_Party + ii, RenderModeWorldMapBitSet)
    CopyBaseProperty(Panel_WorldMap_PartyMemberIcon, panel)
    CopyBaseProperty(Panel_WorldMap_PartyMemberTail, panelTail)
    panel:SetIgnore(true)
    panel:setMaskingChild(true)
    panel:setGlassBackground(true)
    panelTail:setMaskingChild(true)
    panelTail:setGlassBackground(true)
    panel:SetIgnore(true)
    panel:SetDragAll(false)
    panelTail:SetIgnore(true)
    panelTail:SetDragAll(false)
    panel:SetOffsetIgnorePanel(true)
    panelTail:SetOffsetIgnorePanel(true)
    local controlName = UI.createControl(__ePAUIControl_StaticText, Panel_WorldMap_PartyMemberIcon, "StaticText_PartyMemberName" .. tostring(ii))
    local controlClassIconBG = UI.createControl(__ePAUIControl_Static, Panel_WorldMap_PartyMemberIcon, "Static_PartyClassIconBG" .. tostring(ii))
    local controlClassIcon = UI.createControl(__ePAUIControl_Static, Panel_WorldMap_PartyMemberIcon, "Static_PartyClassIcon" .. tostring(ii))
    local controlLevel = UI.createControl(__ePAUIControl_StaticText, Panel_WorldMap_PartyMemberIcon, "StaticText_PartyLevel" .. tostring(ii))
    local controlTail = UI.createControl(__ePAUIControl_Static, Panel_WorldMap_PartyMemberTail, "Static_PartyTail" .. tostring(ii))
    local controlPlatformIcon = UI.createControl(__ePAUIControl_Static, Panel_WorldMap_PartyMemberIcon, "Static_CrossPlay" .. tostring(ii))
    CopyBaseProperty(Name, controlName)
    CopyBaseProperty(ClassIconBG, controlClassIconBG)
    CopyBaseProperty(ClassIcon, controlClassIcon)
    CopyBaseProperty(Level, controlLevel)
    CopyBaseProperty(Tail, controlTail)
    CopyBaseProperty(PlatformIcon, controlPlatformIcon)
    panel:SetChild_DoNotUseXXX(controlName)
    panel:SetChild_DoNotUseXXX(controlClassIconBG)
    panel:SetChild_DoNotUseXXX(controlClassIcon)
    panel:SetChild_DoNotUseXXX(controlLevel)
    panelTail:SetChild_DoNotUseXXX(controlTail)
    panel:SetChild_DoNotUseXXX(controlPlatformIcon)
    Panel_WorldMap_PartyMemberIcon_table[ii] = panel
    Panel_WorldMap_PartyMemberTail_table[ii] = panelTail
  end
end
function FGlobal_ActorTooltip_SetShowPartyMemberIcon(isShowValue)
  for ii = 1, MAX_PARTY_MEMBER do
    if Panel_WorldMap_PartyMemberIcon_table[ii] ~= nil then
      Panel_WorldMap_PartyMemberIcon_table[ii]:SetShow(isShowValue)
    end
    if Panel_WorldMap_PartyMemberTail_table[ii] ~= nil then
      Panel_WorldMap_PartyMemberTail_table[ii]:SetShow(isShowValue)
    end
  end
end
InitPartyMemberTooltipTable()
local nodeTooltip_NeedCP = UI.getChildControl(Panel_WorldMap_NodeTooltip, "StaticText_NeedCP")
local nodeTooltip_NodeName = UI.getChildControl(Panel_WorldMap_NodeTooltip, "StaticText_NodeName")
local nodeTooltip_MainBG = UI.getChildControl(Panel_WorldMap_NodeTooltip, "Static_MainBg")
local nodeTooltip_ProductBG = UI.getChildControl(Panel_WorldMap_NodeTooltip, "Static_ProductBg")
local nodeTooltip_NodeBG = UI.getChildControl(Panel_WorldMap_NodeTooltip, "Static_NodeBG")
local nodeTooltip_StartNodeBG = UI.getChildControl(Panel_WorldMap_NodeTooltip, "Static_StartNode")
local nodeTooltip_StartNodeTitle = UI.getChildControl(nodeTooltip_StartNodeBG, "StaticText_Title")
local nodeTooltip_StartNodeDesc = UI.getChildControl(nodeTooltip_StartNodeBG, "StaticText_Desc")
local nodeTooltip_ProductBG_PosY = nodeTooltip_ProductBG:GetPosY()
local nodeTooltip_NodeBG_PosY = nodeTooltip_NodeBG:GetPosY()
local nodeTooltip_ProductBG_SizeY = nodeTooltip_ProductBG:GetPosY()
local nodeTooltip_ProductNode_Title_Template = UI.getChildControl(nodeTooltip_ProductBG, "StaticText_ProductNodeTitle")
nodeTooltip_ProductNode_Title_Template:SetShow(false)
local nodeTooltip_ProductNode_Title = {}
local nodeTooltip_ProductNode_Title_Count = 0
local nodeTooltip_ProductNode_Line = UI.getChildControl(nodeTooltip_ProductBG, "Static_Line")
local nodeTooltip_ProductNode_StaticTitle = UI.getChildControl(nodeTooltip_ProductBG, "StaticText_Title")
nodeTooltip_ProductNode_StaticTitle:SetSize(Panel_WorldMap_NodeTooltip:GetSizeX() - 20, nodeTooltip_ProductNode_StaticTitle:GetTextSizeY())
nodeTooltip_ProductNode_StaticTitle:SetTextMode(__eTextMode_LimitText)
nodeTooltip_ProductNode_StaticTitle:SetText(nodeTooltip_ProductNode_StaticTitle:GetText())
local nodeTooltip_Node_GuildWarTitle = UI.getChildControl(nodeTooltip_NodeBG, "StaticText_GuildWarTitle")
nodeTooltip_Node_GuildWarTitle:SetSize(Panel_WorldMap_NodeTooltip:GetSizeX() - 20, nodeTooltip_Node_GuildWarTitle:GetTextSizeY())
nodeTooltip_Node_GuildWarTitle:SetTextMode(__eTextMode_LimitText)
nodeTooltip_Node_GuildWarTitle:SetText(nodeTooltip_Node_GuildWarTitle:GetText())
local villageWar = {
  guildMarkBg = UI.getChildControl(nodeTooltip_NodeBG, "Static_GuildMarkBG"),
  guildMark = UI.getChildControl(nodeTooltip_NodeBG, "Static_GuildMark"),
  guildName = UI.getChildControl(nodeTooltip_NodeBG, "StaticText_GuildName"),
  guildMasterName = UI.getChildControl(nodeTooltip_NodeBG, "StaticText_GuildMaster"),
  guildOption = UI.getChildControl(nodeTooltip_NodeBG, "StaticText_BenefitsTitle"),
  nodeState = UI.getChildControl(nodeTooltip_NodeBG, "StaticText_NodeState"),
  nodeStateDesc = UI.getChildControl(nodeTooltip_NodeBG, "StaticText_StateDesc"),
  nodeWarJoinCount = UI.getChildControl(nodeTooltip_NodeBG, "MultilineText_JoinNodeWarCount"),
  nodeTaxGrade = UI.getChildControl(nodeTooltip_NodeBG, "StaticText_TaxGrade"),
  nodeGuildWarDay = UI.getChildControl(nodeTooltip_NodeBG, "StaticText_GuildWarDay"),
  nodeLastWeek = UI.getChildControl(nodeTooltip_NodeBG, "StaticText_LastWeek"),
  nodeADLimit = UI.getChildControl(nodeTooltip_NodeBG, "StaticText_ADLimit"),
  nodeWarMaxMercenary = UI.getChildControl(nodeTooltip_NodeBG, "StaticText_MercenaryLimit"),
  mercenaryCost = UI.getChildControl(nodeTooltip_NodeBG, "StaticText_EquipScore"),
  _defaultGuildWarDayY = 0,
  _defaultWarMaxMercenaryY = 0
}
local function tooltipHide()
  nodeIconName:SetShow(false)
  for ii = 1, nodeResultDropGroupMaxCount do
    nodeResultIconName[ii]:SetShow(false)
    nodeResultIconBG[ii]:SetShow(false)
    nodeResultIcon[ii]:SetShow(false)
  end
  nodeHelpBG:SetShow(false)
  nodeHelpMouseL:SetShow(false)
  nodeHelpMouseR:SetShow(false)
end
local sizeGap = 10
function FromClient_WorldmapIconTooltipInit(commonOverUI)
end
function FGlobal_ClearWorldmapIconTooltip()
  Panel_WorldMap_Tooltip:SetShow(false)
  nodeIconName:SetShow(false)
  for ii = 1, nodeResultDropGroupMaxCount do
    nodeResultIconName[ii]:SetShow(false)
    nodeResultIcon[ii]:SetShow(false)
    nodeResultIconBG[ii]:SetShow(false)
  end
  nodeHelpBG:SetShow(false)
  nodeHelpMouseL:SetShow(false)
  nodeHelpMouseR:SetShow(false)
end
local On_waypointKey
local dayString = {
  [UI_VT.eVillageSiegeType_Sunday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SUNDAY"),
  [UI_VT.eVillageSiegeType_Monday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_MONDAY"),
  [UI_VT.eVillageSiegeType_Tuesday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_TUESDAY"),
  [UI_VT.eVillageSiegeType_Wednesday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_WEDNESDAY"),
  [UI_VT.eVillageSiegeType_Thursday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_THUSDAY"),
  [UI_VT.eVillageSiegeType_Friday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_FRIDAY"),
  [UI_VT.eVillageSiegeType_Saturday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SATURDAY")
}
function initNodeResultDropGroupControl()
  if 0 == villageWar._defaultGuildWarDayY then
    villageWar._defaultGuildWarDayY = villageWar.nodeGuildWarDay:GetSpanSize().y
  end
  if 0 == villageWar._defaultWarMaxMercenaryY then
    villageWar._defaultWarMaxMercenaryY = villageWar.nodeWarMaxMercenary:GetSpanSize().y
  end
  local nodeResultIconNameBase = UI.getChildControl(Panel_WorldMap_Tooltip, "StaticText_IconName_ResultName")
  local nodeResultIconBase = UI.getChildControl(Panel_WorldMap_Tooltip, "StaticText_IconName_ResultIcon")
  local nodeResultIconBGBase = UI.getChildControl(Panel_WorldMap_Tooltip, "StaticText_IconName_ResultIconBG")
  for ii = 1, nodeResultDropGroupMaxCount do
    if nodeResultIconBG[ii] ~= nil then
      UI.deleteControl(nodeResultIconBG[ii])
    end
    if nodeResultIcon[ii] ~= nil then
      UI.deleteControl(nodeResultIcon[ii])
    end
    if nodeResultIconName[ii] ~= nil then
      UI.deleteControl(nodeResultIconName[ii])
    end
    nodeResultIconBG[ii] = UI.createControl(__ePAUIControl_Static, Panel_WorldMap_Tooltip, "StaticText_IconName_ResultIconBG_" .. tostring(ii))
    CopyBaseProperty(nodeResultIconBGBase, nodeResultIconBG[ii])
    nodeResultIcon[ii] = UI.createControl(__ePAUIControl_Static, Panel_WorldMap_Tooltip, "StaticText_IconName_ResultIcon_" .. tostring(ii))
    CopyBaseProperty(nodeResultIconBase, nodeResultIcon[ii])
    nodeResultIconName[ii] = UI.createControl(__ePAUIControl_StaticText, Panel_WorldMap_Tooltip, "StaticText_IconName_ResultName_" .. tostring(ii))
    CopyBaseProperty(nodeResultIconNameBase, nodeResultIconName[ii])
    nodeResultIconBG[1]:SetPosY(nodeIconName:GetPosY() + (nodeIconName:GetTextSizeY() + 10))
    nodeResultIcon[1]:SetPosY(nodeIconName:GetPosY() + (nodeIconName:GetTextSizeY() + 13))
    nodeResultIconName[1]:SetPosY(nodeIconName:GetPosY() + (nodeIconName:GetTextSizeY() + 10))
    if ii > 1 then
      nodeResultIconBG[ii]:SetPosY(nodeResultIconBG[ii - 1]:GetPosY() + nodeResultIconBG[ii - 1]:GetSizeY() + 10)
      nodeResultIcon[ii]:SetPosY(nodeResultIcon[ii - 1]:GetPosY() + nodeResultIcon[ii - 1]:GetSizeY() + 18)
      nodeResultIconName[ii]:SetPosY(nodeResultIconName[ii - 1]:GetPosY() + nodeResultIconName[ii - 1]:GetSizeY() + 10)
    end
  end
end
local function showDropGroupControlInTooltip(itemExchangeSourceSS)
  if nil == itemExchangeSourceSS then
    _PA_ASSERT(false, "ItemExchangeSourceStaticStatus\234\176\128 nil \236\158\133\235\139\136\235\139\164.")
    return
  end
  local dropItemGroupCount = itemExchangeSourceSS:getDropGroupCount()
  if -1 == dropItemGroupCount then
    _PA_ASSERT(false, "getDropGroupCount()\234\176\128 -1 \236\158\133\235\139\136\235\139\164.")
    return
  end
  if dropItemGroupCount > nodeResultDropGroupMaxCount then
    dropItemGroupCount = nodeResultDropGroupMaxCount
    _PA_ASSERT(false, "\236\131\157\236\130\176 \235\133\184\235\147\156\236\151\144\236\132\156 \236\131\157\236\130\176\235\144\152\235\138\148 \236\149\132\236\157\180\237\133\156\236\157\152 \236\162\133\235\165\152\234\176\128 \237\145\156\236\139\156 \236\181\156\235\140\128\236\185\152(" .. tostring(nodeResultDropGroupMaxCount) .. "\236\162\133\235\165\152)\235\165\188 \235\132\152\236\151\136\236\138\181\235\139\136\235\139\164. \235\141\148 \237\145\156\236\139\156\237\149\152\235\160\164\235\169\180 \235\163\168\236\149\132\236\189\148\235\147\156\235\165\188 \236\136\152\236\160\149\237\149\180\236\163\188\236\132\184\236\154\148.")
  end
  for ii = 1, nodeResultDropGroupMaxCount do
    nodeResultIconName[ii]:SetText("")
  end
  if -1 ~= dropItemGroupCount then
    for ii = 1, dropItemGroupCount do
      local itemGroupValue = itemExchangeSourceSS:getDropGroupByIndex(ii - 1)
      if nil == itemGroupValue then
        _PA_ASSERT(false, "getDropGroupByIndex()\236\157\152 \236\157\184\236\158\144\234\176\128 \235\178\148\236\156\132\235\165\188 \235\178\151\236\150\180\235\130\172\234\177\176\235\130\152 ItemExchangeSourceStaticStatus\236\157\152 _productDropItem\236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
      end
      local itemStatic = itemGroupValue:getItemStaticStatus()
      local iconPath = "icon/" .. getItemIconPath(itemStatic)
      local itemName = getItemName(itemStatic)
      nodeResultIconBG[ii]:SetShow(true)
      nodeResultIcon[ii]:ChangeTextureInfoName(iconPath)
      nodeResultIcon[ii]:SetShow(true)
      nodeResultIconName[ii]:SetText(itemName)
      nodeResultIconName[ii]:SetShow(true)
    end
  end
end
local findLongestTextControl = function(textControlList)
  local longestSizeX = 0
  local longestTextControl
  for key, value in pairs(textControlList) do
    if longestSizeX <= value:GetTextSizeX() then
      longestSizeX = value:GetTextSizeX()
      longestTextControl = value
    end
  end
  return longestTextControl
end
local function setAdjustSizeDropGroupTooltip(dropGroupCount)
  if -1 == dropGroupCount then
    _PA_ASSERT(false, "getDropGroupCount()\236\157\152 \234\176\146\236\157\180 \236\158\152\235\170\187\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    return
  end
  local nodeIconNameTotalSizeX = nodeIconName:GetPosX() + nodeIconName:GetTextSizeX()
  local nodeIconNameTotalSizeY = nodeIconName:GetSizeY()
  local longestTextControl = findLongestTextControl(nodeResultIconName)
  local longestTextControlTotalSizeX = longestTextControl:GetPosX() + longestTextControl:GetTextSizeX()
  local totalTooltipSizeX = 0
  local totalTooltipSizeY = 0
  if nodeIconNameTotalSizeX <= longestTextControlTotalSizeX then
    totalTooltipSizeX = longestTextControlTotalSizeX
  else
    totalTooltipSizeX = nodeIconNameTotalSizeX
  end
  totalTooltipSizeY = totalTooltipSizeY + nodeIconName:GetPosY() + nodeIconName:GetTextSizeY()
  for ii = 1, dropGroupCount do
    totalTooltipSizeY = totalTooltipSizeY + nodeResultIconName[ii]:GetSizeY() + 1
  end
  Panel_WorldMap_Tooltip:SetSize(totalTooltipSizeX + sizeGap, totalTooltipSizeY + sizeGap * dropGroupCount + 10)
end
function FromClient_OnWorldMapNode(nodeBtn)
  tooltipHide()
  FGlobal_ClearWorldmapIconTooltip()
  local nodeInfo = nodeBtn:FromClient_getExplorationNodeInClient()
  local plantKey = nodeInfo:getPlantKey()
  local exploreLevel = nodeInfo:getLevel()
  local plant = getPlant(plantKey)
  local waypointKey = plantKey:getWaypointKey()
  On_plantKey = waypointKey
  local houseCountObject = ToClient_getHouseCountObject(waypointKey)
  local regionInfo = ToClient_getRegionInfoWrapperByWaypoint(waypointKey)
  if regionInfo ~= nil then
    ToClient_createBuildingLineInVillageSiege(waypointKey)
  end
  local nodeName = ""
  nodeName = ToClient_getNodeName(nodeInfo)
  nodeTooltip_NodeName:SetSize(Panel_WorldMap_NodeTooltip:GetSizeX() - 20, nodeTooltip_NodeName:GetTextSizeY())
  nodeTooltip_NodeName:SetTextMode(__eTextMode_LimitText)
  nodeTooltip_NodeName:SetText(nodeName)
  local needCPValue = ToClient_getNodeNeedCp(nodeInfo)
  local displayNeedCP = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_NEEDCP", "CP", tostring(needCPValue))
  nodeTooltip_NeedCP:SetText(displayNeedCP)
  local nodeNameOri = nodeName
  if nil ~= houseCountObject then
    nodeName = nodeName .. "<PAColor0xFFe6e0c6> (" .. houseCountObject:getCurrentCount() .. "/" .. houseCountObject:getMaxCount() .. ")<PAOldColor>"
  end
  local nodeX = nodeBtn:GetPosX()
  local nodeY = nodeBtn:GetPosY()
  local sizeX = nodeBtn:GetSizeX()
  local sizeY = nodeBtn:GetSizeY()
  nodeIconName:SetText(nodeName)
  local nodeIconNameTotalSizeX = nodeIconName:GetPosX() + nodeIconName:GetTextSizeX()
  local nodeIconNameTotalSizeY = nodeIconName:GetPosY() + nodeIconName:GetSizeY()
  Panel_WorldMap_Tooltip:SetSize(nodeIconNameTotalSizeX + sizeGap, nodeIconNameTotalSizeY + sizeGap)
  initNodeResultDropGroupControl()
  if exploreLevel > -1 and plant ~= nil and plant:getType() == CppEnums.PlantType.ePlantType_Zone then
    local workCnt = ToClinet_getPlantWorkListCount(waypointKey, 0)
    if workCnt > 0 then
      local itemExchangeSourceSS = ToClient_getPlantWorkableItemExchangeByIndex(plantKey, 0)
      showDropGroupControlInTooltip(itemExchangeSourceSS)
      setAdjustSizeDropGroupTooltip(itemExchangeSourceSS:getDropGroupCount())
    end
  end
  local overUISizeX = Panel_WorldMap_Tooltip:GetSizeX()
  local overUIPosX = nodeX + (sizeX - overUISizeX) / 2
  local overUIPosY = nodeY - Panel_WorldMap_Tooltip:GetSizeY() - sizeGap
  if overUIPosX + overUISizeX > getScreenSizeX() then
    overUIPosX = getScreenSizeX() - overUISizeX
  end
  Panel_WorldMap_Tooltip:SetPosX(overUIPosX)
  Panel_WorldMap_Tooltip:SetPosY(overUIPosY)
  Panel_WorldMap_Tooltip:SetShow(true)
  nodeIconName:SetShow(true)
  villageWar.nodeADLimit:SetShow(false)
  villageWar.nodeGuildWarDay:SetTextMode(__eTextMode_AutoWrap)
  local villageSiegeType = nodeBtn:getVillageSiegeType()
  local siegeNode = nodeBtn:FromClient_getExplorationNodeInClient():getStaticStatus():getMinorSiegeRegion()
  if nil ~= siegeNode then
    local taxGrade = siegeNode:getVillageTaxLevel()
    local tempString = ""
    if true == _ContentsGroup_SeigeSeason5 then
      if _ContentsGroup_NewSiegeRule then
        tempString = "LUA_NODEGRADE_"
      else
        tempString = "LUA_NODEGRADE2_"
      end
      tempString = PAGetString(Defines.StringSheet_GAME, tempString .. tostring(taxGrade))
      if true == _ContentsGroup_NewCharacterStatInfo then
        if 0 == taxGrade then
          local regionKey = siegeNode._regionKey
          local regionWrapper = getRegionInfoWrapper(regionKey:get())
          local grade = regionWrapper:getSiegeOptionTypeByRegion()
          tempString = tempString .. " " .. gradeString[grade]
          villageWar.nodeADLimit:SetTextMode(__eTextMode_AutoWrap)
          villageWar.nodeADLimit:SetShow(true)
          local maxDD = ToClient_getLimitSiegeDDByRegionKey(siegeNode._regionKey:get())
          local maxPV = ToClient_getLimitSiegePVByRegionKey(siegeNode._regionKey:get())
          local maxDV = ToClient_getLimitSiegeDVByRegionKey(siegeNode._regionKey:get())
          villageWar.nodeADLimit:SetText(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_SIEGENODE_MINMAX_ADLIMIT_BONUS", "attack", tostring(maxDD), "evade", tostring(maxDV), "reduce", tostring(maxPV)))
        end
      elseif false == _ContentsGroup_MinorSiegeDamageReduceAndMaxHp then
        if 0 == taxGrade then
          local regionKey = siegeNode._regionKey
          local regionWrapper = getRegionInfoWrapper(regionKey:get())
          local grade = regionWrapper:getSiegeOptionTypeByRegion()
          villageWar.nodeADLimit:SetShow(true)
          if 0 == grade then
            villageWar.nodeADLimit:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SIEGENODE_MINMAX_ADLIMIT", "attack", 230, "defence", 260))
            tempString = tempString .. " " .. gradeString[grade]
          elseif 1 == grade then
            villageWar.nodeADLimit:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SIEGENODE_MINMAX_ADLIMIT", "attack", 250, "defence", 290))
            tempString = tempString .. " " .. gradeString[grade]
          elseif 2 == grade then
            villageWar.nodeADLimit:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SIEGENODE_MINMAX_ADLIMIT", "attack", 270, "defence", 320))
            tempString = tempString .. " " .. gradeString[grade]
          end
        end
      elseif 0 == taxGrade then
        local regionKey = siegeNode._regionKey
        local regionWrapper = getRegionInfoWrapper(regionKey:get())
        local grade = regionWrapper:getSiegeOptionTypeByRegion()
        villageWar.nodeADLimit:SetShow(true)
        if 0 == grade then
          villageWar.nodeADLimit:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SIEGENODE_MINMAX_ADLIMIT", "attack", 210, "defence", 250))
          tempString = tempString .. " " .. gradeString[grade]
        elseif 1 == grade then
          villageWar.nodeADLimit:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SIEGENODE_MINMAX_ADLIMIT", "attack", 230, "defence", 270))
          tempString = tempString .. " " .. gradeString[grade]
        elseif 2 == grade then
          villageWar.nodeADLimit:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SIEGENODE_MINMAX_ADLIMIT", "attack", 240, "defence", 300))
          tempString = tempString .. " " .. gradeString[grade]
        end
      end
      local minMemberAtSiege = siegeNode:getMinMemberAtSiege()
      local maxMemberAtSiege = siegeNode:getMaxMemberAtSiege()
      if 0 ~= maxMemberAtSiege and true == _ContentsGroup_NewSiegeRule then
        local str = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SIEGENODE_MINMAX_PARTICIPANT", "MaxMember", tostring(maxMemberAtSiege))
        tempString = tempString .. "(" .. str .. ")"
      end
      villageWar.nodeTaxGrade:SetText(tempString)
    else
      if 1 == taxGrade then
        tempString = "I"
      elseif 2 == taxGrade then
        tempString = "II"
      elseif 3 == taxGrade then
        tempString = "III"
      end
      villageWar.nodeTaxGrade:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_TAXGRADE", "taxGrade", tempString))
      if 0 == taxGrade then
        villageWar.nodeTaxGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCE_CHALLENGE_POINT_GRADE_ZERO"))
      end
    end
    villageWar.nodeTaxGrade:SetShow(true)
  else
    villageWar.nodeTaxGrade:SetShow(false)
  end
  local _dayString = ""
  if villageSiegeType >= 0 and villageSiegeType < 7 then
    _dayString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDWARDAY", "day", dayString[villageSiegeType])
    villageWar.nodeGuildWarDay:SetText(_dayString)
    villageWar.nodeGuildWarDay:SetShow(true)
    villageWar.nodeGuildWarDay:ComputePos()
  else
    villageWar.nodeGuildWarDay:SetShow(false)
  end
  if true == _ContentsGroup_ConquestSiege and nil ~= siegeNode then
    _dayString = ""
    local regionKey = siegeNode._regionKey
    local regionWrapper = getRegionInfoWrapper(regionKey:get())
    if nil ~= regionWrapper then
      local territoryKey = regionWrapper:getTerritoryKeyRaw()
      for i = 0, UI_VT.eVillageSiegeType_Count - 1 do
        if true == ToClient_checkSiegeDayByRawKey(territoryKey, i) then
          _dayString = _dayString .. dayString[i] .. "/"
        end
      end
    end
    if 0 ~= string.len(_dayString) then
      _dayString = string.sub(_dayString, 1, string.len(_dayString) - 1)
    end
    if "" ~= _dayString then
      _dayString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDWARDAY", "day", _dayString)
      villageWar.nodeGuildWarDay:SetText(_dayString)
      villageWar.nodeGuildWarDay:SetShow(true)
      villageWar.nodeGuildWarDay:ComputePos()
    else
      villageWar.nodeGuildWarDay:SetShow(false)
    end
  end
  if nil ~= siegeNode then
    local regionKey = siegeNode._regionKey
    local regionWrapper = getRegionInfoWrapper(regionKey:get())
    local maxMecenary = regionWrapper:getSiegeGuildVolunteerLimitCount()
    local guildMercenaryCost = regionWrapper:getMaxMercenaryCost()
    if maxMecenary >= 0 and maxMecenary <= 100 then
      local maxMecenaryString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDMAXMECENARY", "count", maxMecenary)
      villageWar.nodeWarMaxMercenary:SetText(maxMecenaryString)
      villageWar.nodeWarMaxMercenary:SetShow(_ContentsGroup_BattleFieldVolunteer)
      if true == villageWar.nodeADLimit:GetShow() then
        local spanY = 50
        if true == _ContentsGroup_NewCharacterStatInfo then
          spanY = 30
        end
        villageWar.nodeWarMaxMercenary:SetSpanSize(villageWar.nodeWarMaxMercenary:GetSpanSize().x, spanY)
      else
        villageWar.nodeWarMaxMercenary:SetSpanSize(villageWar.nodeWarMaxMercenary:GetSpanSize().x, 70)
      end
      villageWar.nodeWarMaxMercenary:ComputePos()
    else
      villageWar.nodeWarMaxMercenary:SetShow(false)
    end
    if true == _ContentsGroup_SiegeCost then
      local guildMaxCostString = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODETOOLTIP_GUILDMAXCOST")
      villageWar.mercenaryCost:SetText(guildMaxCostString .. " " .. tostring(guildMercenaryCost))
      villageWar.mercenaryCost:SetShow(true)
    else
      villageWar.mercenaryCost:SetShow(false)
    end
  end
  local nodeStaticStatus = nodeInfo:getStaticStatus()
  local regionInfo = nodeStaticStatus:getMinorSiegeRegion()
  if nil ~= regionInfo then
    local regionKey = regionInfo._regionKey
    local regionWrapper = getRegionInfoWrapper(regionKey:get())
    local minorSiegeWrapper = regionWrapper:getMinorSiegeWrapper()
    local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(regionKey:get())
    if nil ~= minorSiegeWrapper then
      if minorSiegeWrapper:isSiegeBeing() then
        local siegeTentCount = ToClient_GetCompleteSiegeTentCount(regionKey:get())
        villageWar.guildMarkBg:SetShow(false)
        villageWar.guildMark:SetShow(false)
        villageWar.guildName:SetShow(false)
        villageWar.guildMasterName:SetShow(false)
        villageWar.guildOption:SetShow(false)
        villageWar.nodeLastWeek:SetShow(false)
        villageWar.guildMasterName:SetText("")
        villageWar.guildName:SetText("")
        villageWar.guildMasterName:SetText("")
        villageWar.nodeState:SetShow(true)
        villageWar.nodeStateDesc:SetShow(true)
        villageWar.nodeWarJoinCount:SetShow(false)
        villageWar.nodeState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_ISBEIGN"))
        local minorSiegeDoing = ToClient_doMinorSiegeInTerritory(regionWrapper:getTerritoryKeyRaw())
        if minorSiegeDoing then
          villageWar.nodeStateDesc:SetShow(true)
        else
          villageWar.nodeStateDesc:SetShow(false)
        end
        villageWar.nodeStateDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_JOINGUILD", "count", siegeTentCount))
      elseif true == siegeWrapper:doOccupantExist() then
        villageWar.guildMarkBg:SetShow(true)
        villageWar.guildMark:SetShow(true)
        villageWar.guildName:SetShow(true)
        if false == isSet then
          villageWar.guildMark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(villageWar.guildMark, 183, 1, 188, 6)
          villageWar.guildMark:getBaseTexture():setUV(x1, y1, x2, y2)
        else
          villageWar.guildMark:getBaseTexture():setUV(0, 0, 1, 1)
        end
        villageWar.guildMark:setRenderTexture(villageWar.guildMark:getBaseTexture())
        villageWar.guildName:SetText(siegeWrapper:getGuildName())
        local siegeTentCount = ToClient_GetCompleteSiegeTentCount(regionKey:get())
        if 0 == siegeTentCount then
          villageWar.nodeWarJoinCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOLTIP_JOINNODEWAR_NO"))
        else
          villageWar.nodeWarJoinCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOLTIP_JOINNODEWAR_COUNT", "siegeTentCount", siegeTentCount))
        end
        local isAlliance = siegeWrapper:isOccupantGuildAlliance()
        if true == isAlliance then
          setGuildTextureByAllianceNo(siegeWrapper:getGuildNo(), villageWar.guildMark)
        else
          setGuildTextureByGuildNo(siegeWrapper:getGuildNo(), villageWar.guildMark)
        end
        villageWar.nodeState:SetShow(false)
        villageWar.nodeStateDesc:SetShow(false)
        villageWar.guildMasterName:SetShow(true)
        villageWar.guildMasterName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_GUILDMASTER", "name", siegeWrapper:getGuildMasterName()))
        villageWar.guildOption:SetShow(true)
        local paDate = siegeWrapper:getOccupyingDate()
        local year = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_YEAR", "year", tostring(paDate:GetYear()))
        local month = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_MONTH", "month", tostring(paDate:GetMonth()))
        local day = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_DAY", "day", tostring(paDate:GetDay()))
        local hour = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_HOUR", "hour", tostring(paDate:GetHour()))
        local d_date = year .. month .. day .. hour
        villageWar.guildOption:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_OCCUPYINGDATE", "date", d_date))
        local hasBuilding = ToClient_IsVillageSiegeInThisWeek(regionKey:get())
        villageWar.nodeLastWeek:SetShow(true)
        if hasBuilding then
          villageWar.nodeLastWeek:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_THISWEEK"))
        else
          villageWar.nodeLastWeek:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_LASTWEEK"))
        end
      else
        local siegeTentCount = ToClient_GetCompleteSiegeTentCount(regionKey:get())
        if 0 == siegeTentCount then
          villageWar.nodeWarJoinCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOLTIP_JOINNODEWAR_NO"))
        else
          villageWar.nodeWarJoinCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOLTIP_JOINNODEWAR_COUNT", "siegeTentCount", siegeTentCount))
        end
        villageWar.guildMarkBg:SetShow(false)
        villageWar.guildMark:SetShow(false)
        villageWar.guildName:SetShow(false)
        villageWar.guildMasterName:SetShow(false)
        villageWar.guildOption:SetShow(false)
        villageWar.nodeLastWeek:SetShow(false)
        villageWar.guildName:SetText("")
        villageWar.guildMasterName:SetText("")
        villageWar.guildOption:SetText("")
        villageWar.nodeState:SetShow(true)
        villageWar.nodeStateDesc:SetShow(false)
        villageWar.nodeState:SetTextMode(__eTextMode_AutoWrap)
        villageWar.nodeState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_NOTYETOCCUPY"))
      end
    else
      villageWar.guildMarkBg:SetShow(false)
      villageWar.guildMark:SetShow(false)
      villageWar.guildName:SetShow(false)
      villageWar.guildMasterName:SetShow(false)
      villageWar.guildOption:SetShow(false)
      villageWar.nodeLastWeek:SetShow(false)
      villageWar.guildName:SetText("")
      villageWar.guildMasterName:SetText("")
      villageWar.guildOption:SetText("")
      villageWar.nodeState:SetShow(true)
      villageWar.nodeStateDesc:SetShow(false)
    end
  end
  Panel_WorldMap_NodeTooltip:SetPosX(nodeBtn:GetPosX() + nodeBtn:GetSizeX() + 10)
  Panel_WorldMap_NodeTooltip:SetPosY(nodeBtn:GetPosY())
  for productNodeTitleIdx = 1, nodeTooltip_ProductNode_Title_Count do
    if nil ~= nodeTooltip_ProductNode_Title[productNodeTitleIdx] then
      UI.deleteControl(nodeTooltip_ProductNode_Title[productNodeTitleIdx])
    end
  end
  nodeTooltip_ProductNode_Title_Count = 0
  local isSatellitePlantExist = false
  local satelliteExplorationList = nodeInfo:getSatelliteExplorationList()
  for idx = 0, #satelliteExplorationList do
    local explorationSS = satelliteExplorationList[idx]
    if nil ~= explorationSS then
      local satellitePlantKey = ToClient_convertWaypointKeyToPlantKey(explorationSS._waypointKey)
      local satellitePlant = getPlant(satellitePlantKey)
      if nil ~= satellitePlant and satellitePlant:getType() == CppEnums.PlantType.ePlantType_Zone then
        isSatellitePlantExist = true
        nodeTooltip_ProductNode_Title_Count = nodeTooltip_ProductNode_Title_Count + 1
        nodeTooltip_ProductNode_Title[nodeTooltip_ProductNode_Title_Count] = UI.createControl(__ePAUIControl_StaticText, nodeTooltip_ProductBG, "StaticText_ProductNodeTitle_" .. tostring(nodeTooltip_ProductNode_Title_Count))
        CopyBaseProperty(nodeTooltip_ProductNode_Title_Template, nodeTooltip_ProductNode_Title[nodeTooltip_ProductNode_Title_Count])
        nodeTooltip_ProductNode_Title[nodeTooltip_ProductNode_Title_Count]:SetShow(true)
        if nodeTooltip_ProductNode_Title_Count > 1 then
          local previousIdx = nodeTooltip_ProductNode_Title_Count - 1
          local previousTitle = nodeTooltip_ProductNode_Title[previousIdx]
          local currentPosY = previousTitle:GetPosY() + previousTitle:GetTextSizeY() + 5
          nodeTooltip_ProductNode_Title[nodeTooltip_ProductNode_Title_Count]:SetPosY(currentPosY)
        end
        local productNodeName = explorationSS:getName()
        local productNodeInfo = productNodeName .. "(" .. tostring(explorationSS._needPoint) .. ") : "
        local satellitePlantWorkListCount = ToClinet_getPlantWorkListCount(explorationSS._waypointKey, 0)
        if satellitePlantWorkListCount > 0 then
          local satelliteItemExchangeSourceSS = ToClient_getPlantWorkableItemExchangeByIndex(satellitePlantKey, 0)
          if nil ~= satelliteItemExchangeSourceSS then
            local satelliteDropGroupCount = satelliteItemExchangeSourceSS:getDropGroupCount()
            if -1 ~= satelliteDropGroupCount then
              for idx2 = 1, satelliteDropGroupCount do
                local itemGroupValue = satelliteItemExchangeSourceSS:getDropGroupByIndex(idx2 - 1)
                if nil ~= itemGroupValue then
                  local itemSS = itemGroupValue:getItemStaticStatus()
                  local itemName = getItemName(itemSS)
                  if satelliteDropGroupCount == idx2 then
                    productNodeInfo = productNodeInfo .. itemName
                  else
                    productNodeInfo = productNodeInfo .. itemName .. ", "
                  end
                end
              end
              nodeTooltip_ProductNode_Title[nodeTooltip_ProductNode_Title_Count]:SetTextMode(__eTextMode_AutoWrap)
              nodeTooltip_ProductNode_Title[nodeTooltip_ProductNode_Title_Count]:SetText(productNodeInfo)
              nodeTooltip_ProductNode_Title[nodeTooltip_ProductNode_Title_Count]:SetTextVerticalTop()
            end
          end
        end
      end
    end
  end
  local panelNodeTooltipSizeX = Panel_WorldMap_NodeTooltip:GetSizeX()
  local productBgSizeY = nodeTooltip_ProductBG_SizeY
  for idx3 = 1, nodeTooltip_ProductNode_Title_Count do
    productBgSizeY = productBgSizeY + nodeTooltip_ProductNode_Title[idx3]:GetTextSizeY() + 5
  end
  nodeTooltip_ProductBG:SetSize(panelNodeTooltipSizeX, productBgSizeY)
  if true == _ContentsGroup_NewSiegeWorldMapTooltip then
    if true == ToClient_GetGuildMode() then
      PaGlobal_WorldMapNodeTooltip_VillageWar_Open(nodeBtn, false)
    else
      Panel_WorldMap_NodeTooltip:SetShow(true)
    end
  else
    Panel_WorldMap_NodeTooltip:SetShow(true)
  end
  nodeTooltip_ProductNode_Line:SetShow(false)
  if nil ~= siegeNode then
    local panelSizeY = 0
    if true == isSatellitePlantExist then
      nodeTooltip_ProductBG:SetShow(true)
      nodeTooltip_NodeBG:SetShow(true)
      nodeTooltip_NodeBG:SetPosY(nodeTooltip_ProductBG:GetPosY() + nodeTooltip_ProductBG:GetSizeY())
      nodeTooltip_ProductNode_Line:SetShow(true)
      nodeTooltip_ProductNode_Line:SetPosY(nodeTooltip_NodeBG:GetPosY() - 51)
      nodeTooltip_MainBG:SetSize(panelNodeTooltipSizeX, nodeTooltip_ProductBG:GetSizeY() + nodeTooltip_NodeBG:GetSizeY())
      Panel_WorldMap_NodeTooltip:SetSize(panelNodeTooltipSizeX, nodeTooltip_ProductBG:GetSizeY() + nodeTooltip_NodeBG:GetSizeY() + 50)
      panelSizeY = nodeTooltip_ProductBG:GetSizeY() + nodeTooltip_NodeBG:GetSizeY() + 50
    else
      nodeTooltip_ProductBG:SetShow(false)
      nodeTooltip_NodeBG:SetShow(true)
      nodeTooltip_NodeBG:SetPosY(nodeTooltip_ProductBG_PosY)
      nodeTooltip_MainBG:SetSize(panelNodeTooltipSizeX, nodeTooltip_NodeBG:GetSizeY())
      Panel_WorldMap_NodeTooltip:SetSize(panelNodeTooltipSizeX, nodeTooltip_NodeBG:GetSizeY() + 50)
      panelSizeY = nodeTooltip_NodeBG:GetSizeY() + 50
    end
  elseif true == isSatellitePlantExist then
    nodeTooltip_ProductBG:SetShow(true)
    nodeTooltip_NodeBG:SetShow(false)
    nodeTooltip_MainBG:SetSize(panelNodeTooltipSizeX, nodeTooltip_ProductBG:GetSizeY())
    Panel_WorldMap_NodeTooltip:SetSize(panelNodeTooltipSizeX, nodeTooltip_ProductBG:GetSizeY() + 50)
  else
    nodeTooltip_ProductBG:SetShow(false)
    nodeTooltip_NodeBG:SetShow(false)
    Panel_WorldMap_NodeTooltip:SetShow(false)
  end
  if true == _ContentsGroup_ConquestSiege then
    if true == nodeBtn:getShowStartFlag() then
      nodeTooltip_StartNodeBG:SetShow(true)
      nodeTooltip_StartNodeTitle:SetTextMode(__eTextMode_AutoWrap)
      nodeTooltip_StartNodeTitle:SetText(nodeTooltip_StartNodeTitle:GetText())
      nodeTooltip_StartNodeDesc:SetTextMode(__eTextMode_AutoWrap)
      nodeTooltip_StartNodeDesc:SetText(nodeTooltip_StartNodeDesc:GetText())
      local startNodeSpanSizeY = Panel_WorldMap_NodeTooltip:GetSizeY()
      local startNodeAddSizeY = nodeTooltip_StartNodeTitle:GetTextSizeY() + nodeTooltip_StartNodeDesc:GetTextSizeY() + 30
      nodeTooltip_StartNodeBG:SetSpanSize(nodeTooltip_StartNodeBG:GetSpanSize().x, startNodeSpanSizeY)
      Panel_WorldMap_NodeTooltip:SetSize(Panel_WorldMap_NodeTooltip:GetSizeX(), Panel_WorldMap_NodeTooltip:GetSizeY() + startNodeAddSizeY)
      nodeTooltip_StartNodeBG:ComputePos()
    else
      nodeTooltip_StartNodeBG:SetShow(false)
    end
  else
    nodeTooltip_StartNodeBG:SetShow(false)
  end
  Panel_WorldMap_NodeTooltip:SetSize(Panel_WorldMap_NodeTooltip:GetSizeX(), Panel_WorldMap_NodeTooltip:GetSizeY() + 5)
  nodeHelpBG:SetShow(true)
  nodeHelpMouseL:SetShow(true)
  nodeHelpMouseR:SetShow(true)
  local txtSizeMouseL = nodeHelpMouseL:GetTextSizeX()
  local txtSizeMouseR = nodeHelpMouseR:GetTextSizeX()
  if txtSizeMouseL < txtSizeMouseR then
    nodeHelpBG:SetSize(txtSizeMouseR + 40, 68)
  else
    nodeHelpBG:SetSize(txtSizeMouseL + 40, 68)
  end
  local nd_left = nodeBtn:GetPosX()
  local nd_top = nodeBtn:GetPosY()
  nodeHelpBG:SetPosX(-Panel_WorldMap_Tooltip:GetPosX() + nd_left - nodeHelpBG:GetSizeX() - 5)
  nodeHelpBG:SetPosY(-Panel_WorldMap_Tooltip:GetPosY() + nd_top)
  nodeHelpMouseL:SetPosX(nodeHelpBG:GetPosX() + nodeHelpBG:GetSizeX() - nodeHelpMouseL:GetSizeX() - 5)
  nodeHelpMouseL:SetPosY(nodeHelpBG:GetPosY() + 5)
  nodeHelpMouseR:SetPosX(nodeHelpMouseL:GetPosX())
  nodeHelpMouseR:SetPosY(nodeHelpMouseL:GetPosY() + nodeHelpMouseL:GetSizeY() + 10)
end
function FromClient_OutWorldMapNode(nodeBtn)
  if true == _ContentsGroup_NewSiegeWorldMapTooltip then
    PaGlobal_WorldMapNodeTooltip_VillageWar_Close()
  end
  local nodeInfo = nodeBtn:FromClient_getExplorationNodeInClient()
  local plantKey = nodeInfo:getPlantKey()
  local waypointKey = plantKey:getWaypointKey()
  local isSubNode = false
  local plant = getPlant(plantKey)
  if nil ~= plant then
    isSubNode = plant:isSatellitePlant()
  end
  ToClient_clearBuildingLineInVillageSiege()
  if On_plantKey ~= waypointKey then
    return
  end
  FGlobal_ClearWorldmapIconTooltip()
  if false == isSubNode then
    Panel_NodeOwnerInfo:SetShow(false)
  end
  Panel_WorldMap_NodeTooltip:SetShow(false)
end
local houseKey_ToolTip
function FromClient_OnWorldMapHouse(houseBtn, commonOverUI)
  FGlobal_ClearWorldmapIconTooltip()
  houseKey_ToolTip = houseBtn:FromClient_getStaticStatus():getHouseKey()
  local houseInClientWrapper = houseBtn:FromClient_getStaticStatus()
  nodeIconName:SetText(houseInClientWrapper:getName())
  local nodeX = houseBtn:GetPosX()
  local nodeY = houseBtn:GetPosY()
  local sizeX = houseBtn:GetSizeX()
  local sizeY = houseBtn:GetSizeY()
  local tooltipSizeX = nodeIconName:GetTextSizeX() + 10
  local tooltipSizeY = nodeIconName:GetTextSizeY() + 5
  Panel_WorldMap_Tooltip:SetSize(tooltipSizeX + sizeGap, tooltipSizeY + sizeGap)
  local overUISizeX = Panel_WorldMap_Tooltip:GetSizeX()
  local overUIPosX = nodeX + (sizeX - overUISizeX) / 2
  local overUIPosY = nodeY - Panel_WorldMap_Tooltip:GetSizeY() - sizeGap
  if overUIPosX + overUISizeX > getScreenSizeX() then
    overUIPosX = getScreenSizeX() - overUISizeX
  end
  Panel_WorldMap_Tooltip:SetPosX(overUIPosX)
  Panel_WorldMap_Tooltip:SetPosY(overUIPosY)
  nodeIconName:SetShow(true)
  Panel_WorldMap_Tooltip:SetShow(true)
  houseBtn:setRenderTexture(houseBtn:getOnTexture())
end
function FromClient_OutWorldMapHouse(houseBtn, commonOverUI)
  if houseKey_ToolTip ~= houseBtn:FromClient_getStaticStatus():getHouseKey() then
    return
  end
  FGlobal_ClearWorldmapIconTooltip()
  houseBtn:setRenderTexture(houseBtn:getBaseTexture())
  houseKey_ToolTip = nil
end
function FromClient_WorldMapAuctionHouseOn(guildHouseBtn, commonOverUI)
  FGlobal_ClearWorldmapIconTooltip()
  local auctionHouseWrapper = guildHouseBtn:FromClient_getAuctionHouseInfoWrapper()
  if nil == auctionHouseWrapper then
    return
  end
  local ownerName
  if auctionHouseWrapper:isFixedHouse() then
    ownerName = auctionHouseWrapper:getOwnerGuildName()
  elseif auctionHouseWrapper:isVilla() then
    ownerName = auctionHouseWrapper:getOwnerUserNickname()
  end
  local houseName = auctionHouseWrapper:getFeature1()
  if nil ~= ownerName then
    houseName = houseName .. " - " .. ownerName
  end
  nodeIconName:SetText(houseName)
  nodeIconName:ComputePos()
  local nodeX = guildHouseBtn:GetPosX()
  local nodeY = guildHouseBtn:GetPosY()
  local sizeX = guildHouseBtn:GetSizeX()
  local sizeY = guildHouseBtn:GetSizeY()
  local tooltipSizeX = nodeIconName:GetTextSizeX() + 10
  local tooltipSizeY = nodeIconName:GetTextSizeY() + 10
  Panel_WorldMap_Tooltip:SetSize(tooltipSizeX + sizeGap, tooltipSizeY + sizeGap)
  local overUISizeX = Panel_WorldMap_Tooltip:GetSizeX()
  local overUIPosX = nodeX + (sizeX - overUISizeX) / 2
  local overUIPosY = nodeY - Panel_WorldMap_Tooltip:GetSizeY() - sizeGap
  if overUIPosX + overUISizeX > getScreenSizeX() then
    overUIPosX = getScreenSizeX() - overUISizeX
  end
  Panel_WorldMap_Tooltip:SetPosX(overUIPosX)
  Panel_WorldMap_Tooltip:SetPosY(overUIPosY)
  nodeIconName:SetShow(true)
  Panel_WorldMap_Tooltip:SetShow(true)
end
function FromClient_WorldMapAuctionHouseOut()
  FGlobal_ClearWorldmapIconTooltip()
end
function FromClient_WorldMapAuctionHouseRClick(position)
  FromClient_RClickWorldmapPanel(position, true, false)
end
function FromClient_RClickActorIcon(actorIcon, pos3D)
  FromClient_RClickWorldmapPanel(pos3D, true, false)
end
function FromClient_OnBuildingNode(buildingBtn, commonOverUI)
  if nil == buildingBtn then
    return
  end
  local buildingInfo = buildingBtn:ToClient_getBuildingStaticStatus()
  local isMyThing = buildingInfo:isMyGuildBuilding()
  local isMyAllianceThing = buildingInfo:isMyAllianceGuildBuilding()
  if true == isMyThing or true == isMyAllianceThing then
    if true == _ContentsGroup_NewUI_InstallMode_All then
      PaGlobal_WarInfomation_All_Open(buildingBtn)
    elseif _ContentsGroup_RenewUI_WorldMap then
      PaGlobal_WarInfomation_Open(buildingBtn)
    else
      FGlobal_HouseInstallation_MinorWar_Open(buildingBtn)
    end
  end
  ToClient_createBuildingLineInVillageSiegeByRegionKey(buildingInfo:getBuildingRegionKey():get())
end
function FromClient_OutBuildingNode(buildingBtn, commonOverUI)
  if true == _ContentsGroup_NewUI_InstallMode_All then
    PaGlobal_WarInfomation_All_Close()
  elseif _ContentsGroup_RenewUI_WorldMap then
    PaGlobal_WarInfomation_Close()
  else
    FGlobal_HouseInstallation_MinorWar_Close()
  end
  ToClient_clearBuildingLineInVillageSiege()
end
function FromClient_LClickDeliveryVehicle(deliveryIcon)
  local objectID
  if true == _ContentsGroup_NewDelivery then
    objectID = deliveryIcon:FromClient_GetNewObjectID()
  else
    objectID = deliveryIcon:FromClient_GetObjectID()
  end
  local delivererType = deliveryIcon:FromClient_getDelivererType()
  if delivererType == CppEnums.DelivererType.WagonForPerson or delivererType == CppEnums.DelivererType.OfferingCarrier then
    return
  end
  DeliveryCarriageInformationWindow_Open(objectID)
end
function FromClient_SetTownModeToActorTooltip()
  Panel_WorldMap_Tooltip:SetShow(false)
end
local screensizeX = getScreenSizeX()
local screensizeY = getScreenSizeY()
local originScreenSizeX = getOriginScreenSizeX()
local originScreenSizeY = getOriginScreenSizeY()
local gapX = (originScreenSizeX - screensizeX) / 2
local gapY = (originScreenSizeY - screensizeY) / 2
function FromClient_PartyIcon(partyMemberIcon, partyMemberProxy, index)
  local partySize = 0
  if true == _ContentsGroup_NewUI_PartyWidget_All then
    partySize = PaGlobalFunc_Widget_Party_All_GetMemberCount()
  else
    partySize = FGlobal_PartyMemberCount()
  end
  local partyCount = index + 1
  partyMember[partyCount] = {
    Name = UI.getChildControl(Panel_WorldMap_PartyMemberIcon_table[partyCount], "StaticText_PartyMemberName" .. tostring(partyCount)),
    ClassIconBG = UI.getChildControl(Panel_WorldMap_PartyMemberIcon_table[partyCount], "Static_PartyClassIconBG" .. tostring(partyCount)),
    ClassIcon = UI.getChildControl(Panel_WorldMap_PartyMemberIcon_table[partyCount], "Static_PartyClassIcon" .. tostring(partyCount)),
    Level = UI.getChildControl(Panel_WorldMap_PartyMemberIcon_table[partyCount], "StaticText_PartyLevel" .. tostring(partyCount)),
    Tail = UI.getChildControl(Panel_WorldMap_PartyMemberTail_table[partyCount], "Static_PartyTail" .. tostring(partyCount)),
    PlatformIcon = UI.getChildControl(Panel_WorldMap_PartyMemberIcon_table[partyCount], "Static_CrossPlay" .. tostring(partyCount)),
    PosX = partyMemberIcon:GetPosX(),
    PosY = partyMemberIcon:GetPosY(),
    SizeX = Panel_WorldMap_PartyMemberIcon_table[partyCount]:GetSizeX(),
    SizeY = Panel_WorldMap_PartyMemberIcon_table[partyCount]:GetSizeY()
  }
  Panel_WorldMap_PartyMemberIcon_table[partyCount]:SetShow(true)
  Panel_WorldMap_PartyMemberTail_table[partyCount]:SetShow(true)
  local partyActorName = partyMemberProxy:name()
  local partyActorLevel = partyMemberProxy._level
  local partyMemeberClassType = partyMemberProxy:classType()
  local classTypeTexture = "new_ui_common_forlua/widget/worldmap/worldmap_etc_06.dds"
  if partyMemeberClassType == __eClassType_Warrior then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 2, 102, 31, 131)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_ElfRanger then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 2, 133, 31, 162)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_Sorcerer then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 2, 164, 31, 193)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_Giant then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 2, 195, 31, 224)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_Tamer then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 2, 226, 31, 255)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_BladeMaster then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 2, 257, 31, 286)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_BladeMasterWoman then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 2, 319, 31, 348)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_Valkyrie then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 2, 288, 31, 317)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_WizardMan then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 2, 381, 31, 410)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_WizardWoman then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 2, 350, 31, 379)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_NinjaMan then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 2, 412, 31, 441)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_Kunoichi then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 2, 443, 31, 472)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_DarkElf then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 2, 474, 31, 503)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_Combattant then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 33, 174, 62, 203)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_Mystic then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 33, 205, 62, 234)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_Lhan then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 33, 236, 62, 265)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_RangerMan then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 33, 267, 62, 296)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_ShyWaman then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 33, 298, 62, 327)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_Guardian then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 33, 329, 62, 358)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_Hashashin then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 33, 360, 62, 389)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_Nova then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 33, 391, 62, 420)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_ReservedBlackSpirit then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 33, 422, 62, 451)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  elseif partyMemeberClassType == __eClassType_Sorcerer_Reserved1 then
    partyMember[partyCount].ClassIcon:ChangeTextureInfoName(classTypeTexture)
    local x1, y1, x2, y2 = setTextureUV_Func(partyMember[partyCount].ClassIcon, 33, 453, 62, 482)
    partyMember[partyCount].ClassIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    partyMember[partyCount].ClassIcon:setRenderTexture(partyMember[partyCount].ClassIcon:getBaseTexture())
  end
  partyMember[partyCount].ClassIconBG:SetShow(false)
  partyMember[partyCount].ClassIcon:SetShow(true)
  partyMember[partyCount].Name:SetShow(true)
  partyMember[partyCount].Level:SetShow(true)
  partyMember[partyCount].Name:SetAutoResize(true)
  partyMember[partyCount].Name:SetText(partyActorName)
  partyMember[partyCount].Level:SetText(partyActorLevel)
  partyMember[partyCount].ClassIcon:SetPosX(partyMember[partyCount].Name:GetPosX() - partyMember[partyCount].ClassIcon:GetSizeX() * 1.5)
  partyMember[partyCount].ClassIcon:SetPosY(partyMember[partyCount].Name:GetPosY() - 2)
  partyMember[partyCount].Level:SetPosX(partyMember[partyCount].ClassIcon:GetPosX() + partyMember[partyCount].ClassIcon:GetSizeX() - partyMember[partyCount].Level:GetSizeX() / 2)
  partyMember[partyCount].Level:SetPosY(partyMember[partyCount].ClassIcon:GetPosY() + partyMember[partyCount].ClassIcon:GetSizeY() - partyMember[partyCount].Level:GetSizeY())
  partyMember[partyCount].PlatformIcon:SetPosX(partyMember[partyCount].Name:GetPosX() + partyMember[partyCount].Name:GetTextSizeX() + 8)
  partyMember[partyCount].PlatformIcon:SetShow(false)
  if true == ToClient_isTotalGameClient() then
    PaGlobalFunc_WorldMap_SetCrossPlayIcon(partyMember[partyCount].PlatformIcon, partyMemberProxy:getPlatformType())
  end
  local platformSize = 0
  if true == partyMember[partyCount].PlatformIcon:GetShow() then
    platformSize = partyMember[partyCount].PlatformIcon:GetSizeX()
  end
  Panel_WorldMap_PartyMemberIcon_table[partyCount]:SetSize(partyMember[partyCount].ClassIcon:GetSizeX() + partyMember[partyCount].Name:GetTextSizeX() + partyMember[partyCount].Name:GetSpanSize().x + platformSize, Panel_WorldMap_PartyMemberIcon_table[partyCount]:GetSizeY())
  Panel_WorldMap_PartyMemberIcon_table[partyCount]:SetPosX(partyMemberIcon:GetPosX() + partyMemberIcon:GetSizeX() / 2 - Panel_WorldMap_PartyMemberIcon_table[partyCount]:GetSizeX() / 2)
  Panel_WorldMap_PartyMemberIcon_table[partyCount]:SetPosY(partyMemberIcon:GetPosY())
  if false == _ContentsGroup_RenewUI then
    partyMember[partyCount].Tail:SetPosX(Panel_WorldMap_PartyMemberIcon_table[partyCount]:GetPosX() + Panel_WorldMap_PartyMemberIcon_table[partyCount]:GetSizeX() / 2 - partyMember[partyCount].Tail:GetSizeX() / 2)
    partyMember[partyCount].Tail:SetPosY(Panel_WorldMap_PartyMemberIcon_table[partyCount]:GetPosY() + Panel_WorldMap_PartyMemberIcon_table[partyCount]:GetSizeY() - 2)
  else
    partyMember[partyCount].Tail:SetPosX(Panel_WorldMap_PartyMemberIcon_table[partyCount]:GetPosX() + Panel_WorldMap_PartyMemberIcon_table[partyCount]:GetSizeX() / 2 - partyMember[partyCount].Tail:GetSizeX() / 2 - gapX)
    partyMember[partyCount].Tail:SetPosY(Panel_WorldMap_PartyMemberIcon_table[partyCount]:GetPosY() + Panel_WorldMap_PartyMemberIcon_table[partyCount]:GetSizeY() - 2 - gapY)
  end
end
function FromClient_RemovePartyIcon(index)
  if index >= MAX_PARTY_MEMBER then
    return
  end
  local partyCount = index + 1
  Panel_WorldMap_PartyMemberIcon_table[partyCount]:SetShow(false)
  Panel_WorldMap_PartyMemberTail_table[partyCount]:SetShow(false)
end
function PaGlobalFunc_WorldMap_SetCrossPlayIcon(targetControl, platformType)
  targetControl:SetShow(false)
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
function FromClient_luaLoadComplete_WorldMap_ActorTooltip()
  initNodeResultDropGroupControl()
end
function FromClient_CapitalButtonOpen(nodeButton)
  if false == _ContentsGroup_ConquestSiege or false == Panel_Worldmap_MainCitadelSelect or nil == Btn_SetCapital then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if nil == getSelfPlayer():get() then
    return
  end
  if ToClient_getOccupyingSiegeCount(selfPlayer:getGuildNo_s64()) < 2 then
    return
  end
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildAdviser = getSelfPlayer():get():isGuildAdviser()
  if false == isGuildMaster and false == isGuildAdviser then
    return
  end
  local buildingActorKey = nodeButton:ToClient_getActorKey()
  local buildingInfo = ToClient_getBuildingInfo(buildingActorKey)
  if nil == buildingInfo then
    return
  end
  if false == buildingInfo:isMyGuildBuilding() and false == buildingInfo:isMyAllianceGuildBuilding() then
    return
  end
  local regionKey = buildingInfo:getBuildingRegionKey()
  local regionWrapper = getRegionInfoWrapper(regionKey:get())
  if nil == regionWrapper then
    return
  end
  local minorSiegeWrapper = regionWrapper:getMinorSiegeWrapper()
  if nil == minorSiegeWrapper then
    return
  end
  local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(regionKey:get())
  if nil == siegeWrapper then
    return
  end
  if false == siegeWrapper:doOccupantExist() then
    return
  end
  if selfPlayer:getGuildNo_s64() ~= siegeWrapper:getGuildNo() then
    return
  end
  if regionKey:get() == ToClient_getGuildCapital() then
    return
  end
  if true == minorSiegeWrapper:isSiegeBeing() then
    return
  end
  capitalRegionKey = regionKey:get()
  local nodeX = nodeButton:GetPosX()
  local nodeY = nodeButton:GetPosY()
  local sizeX = nodeButton:GetSizeX()
  local sizeY = nodeButton:GetSizeY()
  local overUISizeX = Panel_Worldmap_MainCitadelSelect:GetSizeX()
  local overUISizeY = Panel_Worldmap_MainCitadelSelect:GetSizeY()
  local overUIPosX = nodeX + (sizeX - overUISizeX) / 2
  local overUIPosY = nodeY - Panel_Worldmap_MainCitadelSelect:GetSizeY() - 30
  if overUIPosX + overUISizeX > getScreenSizeX() then
    overUIPosX = getScreenSizeX() - overUISizeX
  end
  if overUIPosX < 0 then
    overUIPosX = 0
  end
  if overUIPosY + overUISizeY > getScreenSizeY() then
    overUIPosY = getScreenSizeY() - overUISizeY
  end
  if overUIPosY < 0 then
    overUIPosY = 0
  end
  Panel_Worldmap_MainCitadelSelect:SetPosX(overUIPosX)
  Panel_Worldmap_MainCitadelSelect:SetPosY(overUIPosY)
  if true == _ContentsGroup_UsePadSnapping then
    HandleEventLUp_SetCapital()
  else
    Panel_Worldmap_MainCitadelSelect:SetShow(true)
  end
end
function PaGlobal_Worlmap_CapitalButtonClose()
  if false == Panel_Worldmap_MainCitadelSelect or nil == Btn_SetCapital then
    return
  end
  Panel_Worldmap_MainCitadelSelect:SetShow(false)
end
function HandleEventLUp_SetCapital()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAPGRAND_MAINCITADELSELECT"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SET_SIEGE_CITADEL_DESC"),
    functionYes = PaGlobal_Worlmap_SetCapital,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  PaGlobal_Worlmap_CapitalButtonClose()
end
function PaGlobal_Worlmap_SetCapital()
  if nil == capitalRegionKey then
    return
  end
  ToClient_setGuildCapital(capitalRegionKey)
end
if false == _ContentsGroup_RenewUI_WorldMap then
  registerEvent("FromClient_OnWorldMapNode", "FromClient_OnWorldMapNode")
  registerEvent("FromClient_OutWorldMapNode", "FromClient_OutWorldMapNode")
end
registerEvent("FromClient_OnWorldMapHouse", "FromClient_OnWorldMapHouse")
registerEvent("FromClient_OutWorldMapHouse", "FromClient_OutWorldMapHouse")
registerEvent("FromClient_OnBuildingNode", "FromClient_OnBuildingNode")
registerEvent("FromClient_OutBuildingNode", "FromClient_OutBuildingNode")
registerEvent("FromClient_WorldMapAuctionHouseOn", "FromClient_WorldMapAuctionHouseOn")
registerEvent("FromClient_WorldMapAuctionHouseOut", "FromClient_WorldMapAuctionHouseOut")
registerEvent("FromClient_WorldMapAuctionHouseRClick", "FromClient_WorldMapAuctionHouseRClick")
registerEvent("FromClient_RClickActorIcon", "FromClient_RClickActorIcon")
registerEvent("FromClient_LClickDeliveryVehicle", "FromClient_LClickDeliveryVehicle")
registerEvent("FromClient_SetTownMode", "FromClient_SetTownModeToActorTooltip")
registerEvent("FromClient_PartyIcon", "FromClient_PartyIcon")
registerEvent("FromClient_RemovePartyIcon", "FromClient_RemovePartyIcon")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_WorldMap_ActorTooltip")
registerEvent("FromClient_ShowBuildingInfo", "FromClient_CapitalButtonOpen")
