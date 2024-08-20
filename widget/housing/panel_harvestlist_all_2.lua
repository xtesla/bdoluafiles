function HandleEventOn_HarvestList_All_WorkTooltipShow(isShow, index)
  if nil == isShow or nil == index then
    return
  end
  local control
  local name = ""
  local desc
  if true == isShow then
    local control = PaGlobal_HarvestList_All.slot[index].btnDoWork
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_WORKINGNOW")
    local desc
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventLUp_HarvestList_All_TentInfoShow(index)
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper or nil == index then
    return
  end
  local householdDataWithInstallationWrapper = temporaryWrapper:getSelfTentWrapperByIndex(index)
  if nil ~= householdDataWithInstallationWrapper then
    PaGlobal_Worldmap_TentInfo_All_Open(householdDataWithInstallationWrapper)
  end
  PaGlobal_HarvestList_All._selectInfoIndex = index
  if true == _ContentsGroup_UsePadSnapping then
    for ii = 0, PaGlobal_HarvestList_All._maxTentCount - 1 do
      PaGlobal_HarvestList_All.slot[ii].btnInfo:SetCheck(false)
    end
    PaGlobal_HarvestList_All.slot[index].btnInfo:SetCheck(true)
  end
end
function HandleEventLUp_HarvestList_All_NavigatorStart(index)
  if nil == index then
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  local navigationGuideParam = NavigationGuideParam()
  navigationGuideParam._isAutoErase = true
  worldmapNavigatorStart(PaGlobal_HarvestList_All.slot[index].tentPos, navigationGuideParam, false, false, true)
  audioPostEvent_SystemUi(0, 14)
end
function HandleEventLUp_HarvestList_All_WorkManagerOpen(index)
  if nil == index then
    return
  end
  if true == _ContentsGroup_RenewUI_WorldMap then
    PaGlobal_GardenWorkerManagement_Open(index)
  else
    FGlobal_Harvest_WorkManager_Open(index)
  end
end
function PaGlobal_HarvestList_All_Open()
  PaGlobal_HarvestList_All:prepareOpen()
end
function PaGlobal_HarvestList_All_Close()
  PaGlobal_HarvestList_All:prepareClose()
end
function PaGlobal_HarvestList_All_Update()
  PaGlobal_HarvestList_All:update()
end
function FromClient_HarvestList_RenderModeChange(prevRenderModeList, nextRenderModeList)
  if false == CheckRenderModebyGameMode(nextRenderModeList) then
    return
  end
  PaGlobal_HarvestList_All:update()
end
