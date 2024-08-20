function PaGlobal_Worldmap_TentInfo_All_Open(householdDataWithInstallationWrapper)
  PaGlobal_Worldmap_TentInfo_All:prepareOpen(householdDataWithInstallationWrapper)
end
function PaGlobal_Worldmap_TentInfo_All_Close()
  PaGlobal_Worldmap_TentInfo_All:prepareClose()
end
function PaGlobal_Worldmap_TentInfo_All_UpdateFrame(deltaTime)
  PaGlobal_Worldmap_TentInfo_All:updateFrame(deltaTime)
end
function FromClient_TentTooltipShow(tentIcon, householdDataWithInstallationWrapper)
  if nil == Panel_Worldmap_TentInfo_All then
    return
  end
  if nil == householdDataWithInstallationWrapper or nil == tentIcon then
    return
  end
  PaGlobal_Worldmap_TentInfo_All:update(householdDataWithInstallationWrapper)
  if false == Panel_Worldmap_TentInfo_All:IsShow() then
    Panel_Worldmap_TentInfo_All:SetPosX(tentIcon:GetPosX() - (Panel_Worldmap_TentInfo_All:GetSizeX() / 2 - tentIcon:GetSizeX() / 2))
    Panel_Worldmap_TentInfo_All:SetPosY(tentIcon:GetPosY() - Panel_Worldmap_TentInfo_All:GetSizeY())
  end
  PaGlobal_Worldmap_TentInfo_All._selectTentID = tentIcon:GetID()
  Panel_Worldmap_TentInfo_All:SetShow(true)
end
function FromClient_TentTooltipHide(tentIcon, householdDataWithInstallationWrapper)
  if nil == Panel_Worldmap_TentInfo_All then
    return
  end
  if nil == householdDataWithInstallationWrapper or nil == tentIcon then
    return
  end
  if PaGlobal_Worldmap_TentInfo_All._selectTentID == tentIcon:GetID() then
    PaGlobal_Worldmap_TentInfo_All_Close()
  end
end
