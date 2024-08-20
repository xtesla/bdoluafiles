function PaGlobal_Worldmap_Grand_NodeNavigation_Open()
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  if false == ToClient_WorldMapIsShow() then
    return
  end
  if true == ToClient_isTownMode() then
    local maxCountForExcept = 3
    for index = 0, maxCountForExcept do
      if true == FGlobal_WorldMapWindowEscape() then
        break
      end
    end
    WorldMapPopupManager:clear()
    NodeName_Hide()
    GrandWorldMap_CheckPopup(Global_getNodeNavigationPopUpType())
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Worldmap_NodeCal, true)
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:prepareOpen()
  PaGlobal_Worldmap_Grand_NodeNavigation:registUpdate(true)
end
function PaGlobal_Worldmap_Grand_NodeNavigation_Close()
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  ToClient_SetWorldMapNavigationMode(false)
  PaGlobal_Worldmap_Grand_NodeNavigation:registUpdate(false)
  if true == ToClient_WorldMapIsShow() then
    WorldMapPopupManager:pop()
  else
    PaGlobal_Worldmap_Grand_NodeNavigation:prepareClose()
  end
end
function PaGlobal_Worldmap_Grand_NodeNavigation_GetShow()
  return Panel_Worldmap_NodeCal:GetShow()
end
function HandleEventLUp_Worldmap_Grand_NodeNavigation_Close()
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation_Close()
end
function HandleEventLUp_Worldmap_Grand_NodeNavigation_Preview()
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:calcWorldMapNodeNavigation()
end
function HandleEventLUp_Worldmap_Grand_NodeNavigation_Clear()
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:clearUI()
  PaGlobal_Worldmap_Grand_NodeNavigation:clearClient()
end
function HandleEventLUp_Worldmap_Grand_NodeNavigation_ConnectAll()
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:connectAll()
end
function HandleEventLUP_Worldmap_Grand_NodeNavigation_OnClicked_FromSearchEditBox()
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:onClickedEditBox("FromSearchEditBox")
end
function HandleEventLUP_Worldmap_Grand_NodeNavigation_OnClicked_ToSearchEditBox()
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:onClickedEditBox("ToSearchEditBox")
end
function HandleEventLUp_Worldmap_Grand_NodeNavigation_onClicked_SearchResultSlot(index)
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:onClickedResultSlot(index)
end
function HandleEventMouseScroll_Worldmap_Grand_NodeNavigation_FindResultSlotList(isUpScroll)
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:onScrollResultSlotList(isUpScroll)
end
function HandleEventMouseLUP_WorldMap_Grand_NodeNavigation_OnClicked_CheckBox()
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:onClickedCheckBox()
end
function FromClient_InputedWorldMapFromNode_WorldMap_NodeNavigation(nodeName)
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:onSelectedFromNode(nodeName)
end
function FromClient_InputedWorldMapToNode_WorldMap_NodeNavigation(nodeName)
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:onSelectedToNode(nodeName)
end
function FromClient_ClearWorldMapNodeNaviData_WorldMap_NodeNavigation()
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:clearUI()
end
function FromClient_NeedInvestmentFromBaseExplorationNode_WorldMap_NodeNavigation()
  if nil == PaGlobal_Worldmap_Grand_NodeNavigation then
    return
  end
  PaGlobal_Worldmap_Grand_NodeNavigation:showMessageBoxTypeForNeedInvestmentFromBaseExplorationNode()
end
