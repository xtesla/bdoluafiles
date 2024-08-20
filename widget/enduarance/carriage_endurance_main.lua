PaGlobalCarriageEnduranceList = {
  panel = Panel_CarriageEndurance,
  enduranceTypeCount = 5,
  enduranceInfo = {},
  effectBG = UI.getChildControl(Panel_CarriageEndurance, "Static_CarriageEffect"),
  noticeEndurance = UI.getChildControl(Panel_CarriageEndurance, "StaticText_NoticeEndurance"),
  repair_AutoNavi = UI.getChildControl(Panel_CarriageEndurance, "CheckButton_Repair_AutoNavi"),
  repair_Navi = UI.getChildControl(Panel_CarriageEndurance, "Checkbox_Repair_Navi"),
  radarSizeX = 0
}
function PaGlobalCarriageEnduranceList:initialize()
  for index = 0, CppEnums.EquipSlotNo.equipSlotNoCount - 1 do
    self.enduranceInfo[index] = {}
    if 0 == index then
      self.enduranceInfo[index].control = nil
    elseif 1 == index then
      self.enduranceInfo[index].control = nil
    elseif 2 == index then
      self.enduranceInfo[index].control = nil
    elseif 3 == index then
      self.enduranceInfo[index].control = nil
    elseif 4 == index then
      self.enduranceInfo[index].control = UI.getChildControl(self.panel, "Static_Carriage_Wheel")
    elseif 5 == index then
      self.enduranceInfo[index].control = UI.getChildControl(self.panel, "Static_Carriage_Flag")
    elseif 6 == index then
      self.enduranceInfo[index].control = UI.getChildControl(self.panel, "Static_Carriage_Curtain")
    elseif 7 == index then
      self.enduranceInfo[index].control = nil
    elseif 8 == index then
      self.enduranceInfo[index].control = nil
    elseif 9 == index then
      self.enduranceInfo[index].control = nil
    elseif 10 == index then
      self.enduranceInfo[index].control = nil
    elseif 11 == index then
      self.enduranceInfo[index].control = nil
    elseif 12 == index then
      self.enduranceInfo[index].control = nil
    elseif 13 == index then
      self.enduranceInfo[index].control = UI.getChildControl(self.panel, "Static_Carriage_Lamp")
    elseif 14 == index then
      self.enduranceInfo[index].control = nil
    elseif 15 == index then
      self.enduranceInfo[index].control = nil
    elseif 16 == index then
      self.enduranceInfo[index].control = nil
    elseif 17 == index then
      self.enduranceInfo[index].control = nil
    elseif 18 == index then
      self.enduranceInfo[index].control = nil
    elseif 19 == index then
      self.enduranceInfo[index].control = nil
    elseif 20 == index then
      self.enduranceInfo[index].control = nil
    elseif 21 == index then
      self.enduranceInfo[index].control = nil
    elseif 22 == index then
      self.enduranceInfo[index].control = nil
    elseif 23 == index then
      self.enduranceInfo[index].control = nil
    elseif 24 == index then
      self.enduranceInfo[index].control = nil
    elseif 25 == index then
      self.enduranceInfo[index].control = UI.getChildControl(self.panel, "Static_Carriage_Cover")
    elseif 26 == index then
      self.enduranceInfo[index].control = nil
    elseif 27 == index then
      self.enduranceInfo[index].control = nil
    elseif 28 == index then
      self.enduranceInfo[index].control = nil
    elseif 29 == index then
      self.enduranceInfo[index].control = nil
    elseif 30 == index then
      self.enduranceInfo[index].control = nil
    elseif 31 == index then
      self.enduranceInfo[index].control = nil
    end
    if nil ~= self.enduranceInfo[index].control then
      self.enduranceInfo[index].control:SetShow(false)
      self.enduranceInfo[index].color = Defines.Color.C_FF000000
      self.enduranceInfo[index].itemEquiped = false
      self.enduranceInfo[index].isBroken = false
    end
  end
  self.noticeEndurance:SetShow(false)
  self.repair_AutoNavi:SetShow(false)
  self.repair_Navi:SetShow(false)
  self.panel:SetShow(true)
  if not self.repair_Navi:GetShow() then
    self.effectBG:EraseAllEffect()
  end
  self.effectBG:addInputEvent("Mouse_On", "HandleMEnduranceNotice(CppEnums.EnduranceType.eEnduranceType_Carriage, true)")
  self.effectBG:addInputEvent("Mouse_Out", "HandleMEnduranceNotice(CppEnums.EnduranceType.eEnduranceType_Carriage, false)")
  self.repair_AutoNavi:addInputEvent("Mouse_LUp", "HandleMLUpRepairNavi(CppEnums.EnduranceType.eEnduranceType_Carriage, true)")
  self.repair_Navi:addInputEvent("Mouse_LUp", "HandleMLUpRepairNavi(CppEnums.EnduranceType.eEnduranceType_Carriage, false)")
  self.radarSizeX = FGlobal_Panel_Radar_GetSizeX()
  Panel_CarriageEndurance_Position()
  self._isInit = true
end
function PaGlobalCarriageEnduranceList:checkInit()
  return self._isInit == true
end
function Panel_CarriageEndurance_Position()
  local self = PaGlobalCarriageEnduranceList
  local gapX = (getOriginScreenSizeX() - getScreenSizeX()) / 2
  self.radarSizeX = FGlobal_Panel_Radar_GetSizeX()
  self.panel:SetPosX(getOriginScreenSizeX() - self.radarSizeX - self.panel:GetSizeX() * 1.7 - gapX)
  self.panel:SetPosY(FGlobal_Panel_Radar_GetPosY() - FGlobal_Panel_Radar_GetSizeY() / 1.5)
  if Panel_Widget_TownNpcNavi:GetShow() then
    self.panel:SetPosY(Panel_Widget_TownNpcNavi:GetSizeY() + Panel_Widget_TownNpcNavi:GetPosY() + 10)
  end
  if true == _ContentsGroup_UsePadSnapping and nil ~= Panel_NewEquip then
    self.panel:SetPosY(Panel_NewEquip:GetSizeY() + Panel_NewEquip:GetPosY() + 10)
  end
end
function renderModeChange_CarriageEndurance_Position(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  Panel_CarriageEndurance_Position()
end
function PaGlobalCarriageEnduranceList_Init()
  PaGlobalCarriageEnduranceList:initialize()
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalCarriageEnduranceList_Init")
registerEvent("FromClient_RenderModeChangeState", "renderModeChange_CarriageEndurance_Position")
registerEvent("onScreenResize", "Panel_CarriageEndurance_Position")
