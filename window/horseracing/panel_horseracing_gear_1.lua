function PaGlobal_HorseRacing_Gear:initialize()
  if true == self._initialize then
    return
  end
  local gearListBG = UI.getChildControl(Panel_HorseRacing_Gear, "Static_GearBG")
  local gearList = UI.getChildControl(gearListBG, "Static_GearList")
  local gearGauseBG = UI.getChildControl(gearListBG, "Static_GearGauge")
  for ii = 1, self._maxGearCount do
    self._ui.progress_gear[ii] = UI.getChildControl(gearGauseBG, "Progress2_GearGauge0" .. ii)
    self._ui.progress_gear[ii]:SetProgressRate(0)
    local gearCount = {bg = nil, icon = nil}
    gearCount.bg = UI.getChildControl(gearListBG, "Static_GearCount0" .. ii)
    gearCount.icon = UI.getChildControl(gearCount.bg, "Static_Check0" .. ii)
    self._ui.stc_gearCount[ii] = gearCount
    self._ui.stc_gearCount[ii].icon:SetShow(false)
  end
  self._ui.stc_gearNow = UI.getChildControl(gearListBG, "Static_GearNow")
  self._ui.stc_gearNow:SetShow(false)
  self._ui.stc_gearPointer = UI.getChildControl(gearListBG, "Static_GearPointer")
  local horseHpBG = UI.getChildControl(Panel_HorseRacing_Gear, "Static_HorseHPBG")
  self._ui.progress_hp = UI.getChildControl(horseHpBG, "Progress2_HPBar")
  self._ui.progress_hp:SetProgressRate(100)
  local horseMpBG = UI.getChildControl(Panel_HorseRacing_Gear, "Static_HorseMPBG")
  self._ui.progress_mp = UI.getChildControl(horseMpBG, "Progress2_MPBar")
  self._ui.progress_mp:SetProgressRate(0)
  self._ui.stc_gearEffect = UI.getChildControl(gearListBG, "Static_GearEffect")
  self._ui.stc_gearPointerEffect = UI.getChildControl(gearListBG, "Static_GearPoint_Effect")
  self._ui.stc_mpEffect = UI.getChildControl(horseMpBG, "Static_MPBar_Effect")
  self._ui.stc_maxMp = UI.getChildControl(horseMpBG, "Static_SteminaMax")
  self._ui.txt_mpKeyGuide = UI.getChildControl(self._ui.stc_maxMp, "StaticText_Stemina_KeyGuide")
  self._ui.txt_gearKeyGuide = UI.getChildControl(self._ui.stc_gearPointer, "StaticText_KeyGuide")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_HorseRacing_Gear:registEventHandler()
  if nil == Panel_HorseRacing_Gear then
    return
  end
  registerEvent("onScreenResize", "FromClient_HorseRacing_Gear_ReSizePanel")
  registerEvent("EventSelfPlayerRideOff", "PaGlobal_HorseRacing_Gear_Close")
  registerEvent("EventSelfServantUpdate", "FromClient_HorseRacing_Gear_ServantUpdate")
  registerEvent("EventSelfServantUpdateOnlyHp", "FromClient_HorseRacing_Gear_ServantHpUpdate")
  registerEvent("subResourceChanged", "FromClient_HorseRacing_Gear_ServantStatUpdate")
  registerEvent("EventSelfPlayerCarrierChanged", "FromClient_HorseRacing_Gear_CarrierChanged")
  ActionChartEventBindFunction(8, PaGlobal_HorseRacing_Gear_GearPointOpen)
  ActionChartEventBindFunction(9, PaGlobal_HorseRacing_Gear_GearPointClose)
end
function PaGlobal_HorseRacing_Gear:prepareOpen(vehicleActorKeyRaw)
  if nil == Panel_HorseRacing_Gear then
    return
  end
  if false == Panel_HorseRacing_Gear:GetShow() then
    self._vehicleActorKeyRaw = vehicleActorKeyRaw
    self:resetGearSetting()
    self._ui.stc_maxMp:SetShow(false)
    self._ui.stc_gearPointer:SetShow(false)
  end
  Panel_HorseRacing_Gear:RegisterUpdateFunc("PaGlobal_HorseRacing_Gear_UpdateGear")
  FromClient_HorseRacing_Gear_ServantUpdate()
  PaGlobal_HorseRacing_Gear:open()
end
function PaGlobal_HorseRacing_Gear:open()
  if nil == Panel_HorseRacing_Gear then
    return
  end
  Panel_HorseRacing_Gear:SetShow(true)
end
function PaGlobal_HorseRacing_Gear:prepareClose()
  if nil == Panel_HorseRacing_Gear then
    return
  end
  self._ui.progress_hp:SetProgressRate(100)
  self._ui.progress_mp:SetProgressRate(0)
  Panel_HorseRacing_Gear:ClearUpdateLuaFunc()
  PaGlobal_HorseRacing_Gear:close()
end
function PaGlobal_HorseRacing_Gear:close()
  if nil == Panel_HorseRacing_Gear then
    return
  end
  Panel_HorseRacing_Gear:SetShow(false)
end
function PaGlobal_HorseRacing_Gear:resetGearSetting()
  self._curLev = 0
  self._changeLev = 0
  self._changeRate = 0
  self._gearPointShowLev = 0
  self._ui.stc_gearNow:SetShow(false)
  for ii = 1, self._maxGearCount do
    self._ui.progress_gear[ii]:SetProgressRate(0)
    self._ui.stc_gearCount[ii].icon:SetShow(false)
  end
end
function PaGlobal_HorseRacing_Gear:changedRacingHorseGear(changeLev)
  local curRate = 0
  if nil ~= self._ui.progress_gear[self._curLev] then
    curRate = self._ui.progress_gear[self._curLev]:GetProgressRate()
  end
  local changeRate = 0
  if 0 ~= ToClient_getMaxVariedServantSpeed() then
    local curSpeed = ToClient_getVariedServantSpeed()
    local maxSpeed = ToClient_getMaxVariedServantSpeed()
    changeRate = curSpeed / maxSpeed * 100
  end
  if changeLev < self._curLev or self._curLev == changeLev and curRate > changeRate then
    self._changeLev = changeLev
    self._changeRate = changeRate
    if 1 == self._curLev then
      self._changeRate = 100
      self._ui.progress_gear[self._curLev]:SetProgressRate(self._changeRate)
      if 0 == changeLev then
        self._curLev = 0
        self._changeRate = 0
        self._ui.progress_gear[1]:SetProgressRate(self._changeRate)
        self:updateGearCount()
        return
      end
    end
    self:updateRacingHorseGearProgress(true)
  end
  if changeLev > self._curLev or self._curLev == changeLev and curRate < changeRate then
    self._changeLev = changeLev
    self._changeRate = changeRate
    if 0 == self._curLev then
      self._curLev = 1
      self._changeRate = 100
      self._ui.progress_gear[self._curLev]:SetProgressRate(self._changeRate)
      self:updateGearCount()
      return
    end
    self:updateRacingHorseGearProgress(false)
  end
end
function PaGlobal_HorseRacing_Gear:updateRacingHorseGearProgress(isDecrease)
  local variedRate = 10
  if true == isDecrease then
    variedRate = -10
  end
  local rate = 0
  if nil ~= self._ui.progress_gear[self._curLev] then
    rate = self._ui.progress_gear[self._curLev]:GetProgressRate()
  end
  if self._changeLev == self._curLev then
    if nil ~= self._ui.progress_gear[self._curLev] then
      self._ui.progress_gear[self._curLev]:SetProgressRate(self._changeRate)
    end
    return
  end
  rate = rate + variedRate
  if true == isDecrease then
    if rate <= 0 then
      rate = 100
      if nil ~= self._ui.progress_gear[self._curLev] then
        self._ui.progress_gear[self._curLev]:SetProgressRate(0)
      end
      self._curLev = self._curLev - 1
      if self._curLev < self._changeLev then
        self._curLev = self._changeLev
        rate = self._changeRate
      end
    end
  elseif rate >= 100 then
    rate = 0
    if nil ~= self._ui.progress_gear[self._curLev] then
      self._ui.progress_gear[self._curLev]:SetProgressRate(100)
    end
    self._curLev = self._curLev + 1
    if self._changeLev < self._curLev then
      self._curLev = self._changeLev
      rate = self._changeRate
    end
  end
  self:updateGearCount()
  if nil == self._ui.progress_gear[self._curLev] then
    return
  end
  self._ui.progress_gear[self._curLev]:SetProgressRate(rate)
end
function PaGlobal_HorseRacing_Gear:updateGearCount()
  if self._curLev < 1 then
    self:resetGearSetting()
    return
  end
  for ii = 1, self._maxGearCount do
    if ii < self._curLev then
      self._ui.stc_gearCount[ii].icon:SetShow(true)
    elseif ii == self._curLev then
      self._ui.stc_gearCount[ii].icon:SetShow(true)
      self._ui.stc_gearNow:SetShow(true)
      local posX = self._ui.stc_gearCount[ii].bg:GetPosX()
      self._ui.stc_gearNow:SetPosX(posX - 5)
    else
      self._ui.stc_gearCount[ii].icon:SetShow(false)
    end
  end
end
function PaGlobal_HorseRacing_Gear:updateHp(vehicleProxy)
  if nil == Panel_HorseRacing_Gear or nil == vehicleProxy then
    return
  end
  self._ui.progress_hp:SetProgressRate(vehicleProxy:get():getHp() / vehicleProxy:get():getMaxHp() * 100)
end
function PaGlobal_HorseRacing_Gear:updateMp(vehicleProxy)
  if nil == Panel_HorseRacing_Gear or nil == vehicleProxy then
    return
  end
  local mp = getMpToActor(vehicleProxy)
  local maxMp = getMaxMpToActor(vehicleProxy)
  local staminaPercent = mp / maxMp * 100
  self._ui.progress_mp:SetProgressRate(staminaPercent)
end
function PaGlobal_HorseRacing_Gear:updateStat()
  if nil == Panel_HorseRacing_Gear then
    return
  end
  local mp = ToClient_getRacingHorseSubResourcePoint()
  local staminaPercent = mp / __eMaxRacingHorseSP * 100
  if staminaPercent >= 100 then
    self._ui.stc_mpEffect:AddEffect("fUI_Race_Horse_SpeedGauge_01C", true, 0, 0)
    self._ui.stc_maxMp:SetShow(true)
  else
    self._ui.stc_mpEffect:EraseAllEffect()
    self._ui.stc_maxMp:SetShow(false)
    if staminaPercent < 1 then
      staminaPercent = -1
    end
  end
  self._ui.progress_mp:SetProgressRate(staminaPercent)
end
function PaGlobal_HorseRacing_Gear:validate()
  if nil == Panel_HorseRacing_Gear then
    return
  end
  for ii = 1, self._maxGearCount do
    self._ui.progress_gear[ii]:isValidate()
    self._ui.stc_gearCount[ii].icon:isValidate()
  end
  self._ui.stc_gearNow:isValidate()
  self._ui.stc_gearPointer:isValidate()
  self._ui.progress_hp:isValidate()
  self._ui.progress_mp:isValidate()
end
