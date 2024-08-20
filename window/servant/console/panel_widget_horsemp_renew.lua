local UI_VT = CppEnums.VehicleType
local servantMpBar = {
  _staticBar = UI.getChildControl(Panel_HorseMp, "HorseMpBar"),
  _staticText = UI.getChildControl(Panel_HorseMp, "StaticText_Mp"),
  _actorKeyRaw = 0,
  _isAutoCarrot = true,
  _button_AutoCarrot = UI.getChildControl(Panel_HorseMp, "CheckButton_AutoCarrot"),
  _button_AutoSpeed = nil,
  _originalAutoBtnPanY = -70,
  _autoBtnFlag = false
}
local horseCarrotItemKey = {
  [0] = 19945,
  [1] = 46906,
  [2] = 46912,
  [3] = 54001,
  [4] = 54004,
  [5] = 54005,
  [6] = 9321
}
local camelCarrotItemKey = {
  [0] = 54012,
  [1] = 54020,
  [2] = 54021,
  [3] = 54022,
  [4] = 9321
}
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_HorseMp")
registerEvent("EventSelfServantUpdate", "HorseMP_Update")
registerEvent("EventSelfServantUpdateOnlyMp", "HorseMP_Update")
registerEvent("EventSelfPlayerRideOn", "HorseMP_OpenByInteraction")
registerEvent("FromClient_RenderModeChangeState", "renderModechange_HorseMP_OpenByInteraction")
registerEvent("EventSelfPlayerCarrierChanged", "HorseMP_EventSelfPlayerCarrierChanged")
registerEvent("EventSelfPlayerRideOff", "HorseMP_Close")
registerEvent("EventCanMoveFastForConsole", "FGlobal_ToggleCanMoveFast_PadInput")
function FromClient_luaLoadComplete_HorseMp()
  HorseMP_init()
end
function HorseMP_init()
  Panel_HorseMp:SetShow(false, false)
  Panel_HorseMp:ComputePos()
  servantMpBar._button_AutoCarrot:SetShow(false)
  servantMpBar._button_AutoCarrot:SetCheck(true)
  servantMpBar._button_AutoCarrot:ComputePos()
  servantMpBar._button_AutoSpeed = UI.getChildControl(Panel_HorseMp, "CheckButton_AutoSpeed")
  servantMpBar._button_AutoSpeed:SetShow(false)
  servantMpBar._button_AutoSpeed:SetCheck(false)
end
function HorseMp_InitStaminaAlertText(vehicleType, isUseFoodText)
  local alertText = ""
  if CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_CowCarriage == vehicleType then
    alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_1")
  elseif true == ToClient_isVehicleTypeWarter(vehicleType) then
    if true == _ContentsGroup_OceanCurrent then
      if false == isUseFoodText then
        alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_3")
      else
        alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_6")
      end
    elseif CppEnums.VehicleType.Type_PersonTradeShip == vehicleType or CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType then
      alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_4")
    else
      alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_3")
    end
  elseif UI_VT.Type_RepairableCarriage == vehicleType then
    alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_4")
  else
    alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_2")
  end
end
function HorseMP_Update()
  if false == Panel_HorseMp:GetShow() then
    return
  end
  local self = servantMpBar
  local vehicleProxy = getVehicleActor(self._actorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  local characterKey = vehicleProxy:getCharacterKey()
  local isShyDonkey = nil ~= characterKey and (9113 == characterKey or 9114 == characterKey or 9115 == characterKey)
  local mp = getMpToActor(vehicleProxy)
  local maxMp = getMaxMpToActor(vehicleProxy)
  local staminaPercent = mp / maxMp * 100
  if CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_CowCarriage == vehicleType or CppEnums.VehicleType.Type_Boat == vehicleType or CppEnums.VehicleType.Type_Raft == vehicleType or CppEnums.VehicleType.Type_FishingBoat == vehicleType or CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_PersonalBoat == vehicleType or CppEnums.VehicleType.Type_PersonTradeShip == vehicleType or staminaPercent < 10 then
  else
  end
  self._staticBar:SetProgressRate(staminaPercent)
  if UI_VT.Type_Horse == vehicleType or UI_VT.Type_Camel == vehicleType or UI_VT.Type_Donkey == vehicleType or UI_VT.Type_MountainGoat == vehicleType then
    self._staticText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_MPBAR_LIFE", "getMp", makeDotMoney(vehicleProxy:get():getMp()), "getMaxMp", makeDotMoney(vehicleProxy:get():getMaxMp())))
    self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 0, " .. staminaPercent .. ")")
    self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 0 )")
    self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 0, " .. staminaPercent .. ")")
  else
    self._staticText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_MPBAR_MACHINE", "getMp", makeDotMoney(vehicleProxy:get():getMp()), "getMaxMp", makeDotMoney(vehicleProxy:get():getMaxMp())))
    if UI_VT.Type_Elephant == vehicleType then
      self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 3, " .. staminaPercent .. ")")
      self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 3 )")
      self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 3, " .. staminaPercent .. ")")
    elseif UI_VT.Type_RidableBabyElephant == vehicleType then
      self._staticText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_MPBAR_LIFE", "getMp", makeDotMoney(vehicleProxy:get():getMp()), "getMaxMp", makeDotMoney(vehicleProxy:get():getMaxMp())))
      self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 0, " .. staminaPercent .. ")")
      self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 0 )")
      self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 0, " .. staminaPercent .. ")")
    elseif UI_VT.Type_RepairableCarriage == vehicleType then
      self._staticText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME") .. " : " .. makeDotMoney(mp) .. "/" .. makeDotMoney(maxMp))
      self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 4, " .. staminaPercent .. ")")
      self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 4 )")
      self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 4, " .. staminaPercent .. ")")
    elseif true == ToClient_isVehicleTypeWarter(vehicleType) then
      if true == _ContentsGroup_OceanCurrent then
        local characterKey = vehicleProxy:getCharacterKey()
        local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
        if nil ~= shipStaticStatus and false == shipStaticStatus:getIsSummonFull() then
          self._staticText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_NAME") .. " : " .. makeDotMoney(mp) .. "/" .. makeDotMoney(maxMp))
          self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 5, " .. staminaPercent .. ")")
          self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 5 )")
          self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 5, " .. staminaPercent .. ")")
        else
          self._staticText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_MPBAR_MACHINE", "getMp", makeDotMoney(mp), "getMaxMp", makeDotMoney(maxMp)))
          self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 1, " .. staminaPercent .. ")")
          self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 1 )")
          self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 1, " .. staminaPercent .. ")")
        end
      elseif CppEnums.VehicleType.Type_PersonTradeShip == vehicleType or CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType then
        self._staticText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME") .. " : " .. makeDotMoney(mp) .. "/" .. makeDotMoney(maxMp))
        self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 4, " .. staminaPercent .. ")")
        self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 4 )")
        self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 4, " .. staminaPercent .. ")")
      else
        self._staticText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_MPBAR_MACHINE", "getMp", makeDotMoney(mp), "getMaxMp", makeDotMoney(maxMp)))
        self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 1, " .. staminaPercent .. ")")
        self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 1 )")
        self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 1, " .. staminaPercent .. ")")
      end
    elseif UI_VT.Type_WoodenFence == vehicleType then
      Panel_HorseMp:SetShow(false, false)
    else
      self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 1, " .. staminaPercent .. ")")
      self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 1 )")
      self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 1, " .. staminaPercent .. ")")
    end
  end
  local oceanShipSkillUI = false
  if true == _ContentsGroup_OceanCurrent then
    local characterKey = vehicleProxy:getCharacterKey()
    local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
    if nil ~= shipStaticStatus and true == shipStaticStatus:getOceanShipSkillUI() and 0 == getSelfPlayer():get():getVehicleSeatIndex() then
      oceanShipSkillUI = true
    end
  end
  local tooltipValue = 0
  if true == oceanShipSkillUI then
    if 21 <= getSelfPlayer():get():getLifeExperienceLevel(9) then
      servantMpBar._button_AutoSpeed:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPFASTMOVE_AUTOUSE"))
      tooltipValue = 6
    else
      servantMpBar._button_AutoSpeed:SetShow(false)
    end
  elseif __eVehicleType_Horse == vehicleType then
    servantMpBar._button_AutoSpeed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_HORSE"))
    tooltipValue = 7
  elseif __eVehicleType_Camel == vehicleType then
    servantMpBar._button_AutoSpeed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_CAMEL"))
    tooltipValue = 8
  elseif CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType then
    servantMpBar._button_AutoSpeed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_ELEPHANT"))
    tooltipValue = 9
  elseif true == isShyDonkey then
    servantMpBar._button_AutoSpeed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_DONKEY"))
    tooltipValue = 10
  elseif __eVehicleType_RepairableCarriage == vehicleType then
    servantMpBar._button_AutoSpeed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_CARRIAGE"))
    tooltipValue = 11
  end
  local isDriver = getSelfPlayer():get():isVehicleDriver()
  if 0 ~= tooltipValue and true == isDriver then
    if false == servantMpBar._button_AutoSpeed:GetShow() then
      servantMpBar._button_AutoSpeed:SetShow(true)
    end
    if false == servantMpBar._autoBtnFlag then
      servantMpBar._autoBtnFlag = true
      servantMpBar._button_AutoSpeed:SetCheck(false)
    end
    local currentFlag = ToClient_IsCanMoveFast()
    local settingFlag = servantMpBar._button_AutoSpeed:IsCheck()
    if currentFlag ~= settingFlag then
      ToClient_SetCanMoveFast(settingFlag)
    end
  end
  if getSelfPlayer():isNavigationLoop() and getSelfPlayer():isNavigationMoving() then
    if __eVehicleType_Boat == vehicleType or __eVehicleType_Raft == vehicleType or __eVehicleType_FishingBoat == vehicleType or __eVehicleType_Carriage == vehicleType or __eVehicleType_CowCarriage == vehicleType or __eVehicleType_RepairableCarriage == vehicleType or __eVehicleType_Cannon == vehicleType or __eVehicleType_PracticeCannon == vehicleType or __eVehicleType_Elephant == vehicleType or __eVehicleType_ThrowFire == vehicleType or __eVehicleType_ThrowStone == vehicleType or __eVehicleType_Ballista == vehicleType or __eVehicleType_SailingBoat == vehicleType or __eVehicleType_CashPersonalTradeShip == vehicleType or __eVehicleType_CashPersonalBattleShip == vehicleType or __eVehicleType_PersonalBattleShip == vehicleType or __eVehicleType_PersonTradeShip == vehicleType or __eVehicleType_Carrack == vehicleType then
      servantMpBar._button_AutoCarrot:SetShow(false)
    else
      servantMpBar._button_AutoCarrot:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSEMP_AUTOCARROT"))
      servantMpBar._button_AutoCarrot:SetShow(true)
      servantMpBar._button_AutoCarrot:SetSpanSize(servantMpBar._button_AutoCarrot:GetSpanSize().x, servantMpBar._originalAutoBtnPanY)
      servantMpBar._button_AutoCarrot:SetPosX(servantMpBar._staticBar:GetPosX() + servantMpBar._staticBar:GetSizeX() / 2 - servantMpBar._button_AutoCarrot:GetTextSizeX() / 2 - 20)
      if staminaPercent <= 10 and true == servantMpBar._button_AutoCarrot:IsCheck() then
        if __eVehicleType_Horse == vehicleType or __eVehicleType_Donkey == vehicleType or __eVehicleType_Ridable_BabyElephant == vehicleType then
          HorseAutoCarrotFunc(horseCarrotItemKey)
        elseif __eVehicleType_Camel == vehicleType then
          HorseAutoCarrotFunc(camelCarrotItemKey)
        end
      end
    end
  else
    servantMpBar._button_AutoCarrot:SetShow(false)
  end
end
function HorseAutoCarrotFunc(carrotItemKey)
  local useAutoCarrot = function(itemWhereType, invenSlot)
    local itemWrapper = getInventoryItemByType(itemWhereType, invenSlot)
    local itemStatic = itemWrapper:getStaticStatus():get()
    local selfProxy = getSelfPlayer():get()
    if nil == selfProxy then
      return
    end
    if selfProxy:doRideMyVehicle() and itemStatic:isUseToVehicle() then
      local equipSlotNo = itemWrapper:getStaticStatus():getEquipSlotNo()
      local carrotName = itemWrapper:getStaticStatus():getName()
      inventoryUseItem(itemWhereType, invenSlot, equipSlotNo, false)
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_AUTO_USE_CARROT", "carrotName", carrotName))
    end
  end
  if true == _ContentsGroup_FamilyInventory then
    local selfPlayerWrapper = getSelfPlayer()
    if nil == selfPlayerWrapper then
      return
    end
    local carrotItemSlot = {}
    local selfPlayer = selfPlayerWrapper:get()
    local itemWhereType = CppEnums.ItemWhereType.eFamilyInventory
    local inventory = selfPlayer:getInventoryByType(itemWhereType)
    local invenSize = inventory:sizeXXX()
    for invenidx = __eTInventorySlotNoUseStart, invenSize - 1 do
      local itemWrapper = getInventoryItemByType(itemWhereType, invenidx)
      if nil ~= itemWrapper then
        local itemKey = itemWrapper:get():getKey():getItemKey()
        for i = 0, #carrotItemKey do
          if carrotItemKey[i] == itemKey then
            local carrotCoolTime = getItemCooltime(itemWhereType, invenidx)
            if 0 ~= carrotCoolTime then
              return
            end
            local isCheckedConditions = itemWrapper:checkConditions()
            if isCheckedConditions then
              if nil == carrotItemSlot[i] then
                carrotItemSlot[i] = {slot = "", key = ""}
              end
              carrotItemSlot[i].itemWhereType = itemWhereType
              carrotItemSlot[i].slot = invenidx
              carrotItemSlot[i].key = itemKey
              break
            end
          end
        end
      end
    end
    for i = 0, #carrotItemKey do
      if nil ~= carrotItemSlot[i] and "" ~= carrotItemSlot[i].slot and carrotItemKey[i] == carrotItemSlot[i].key then
        useAutoCarrot(carrotItemSlot[i].itemWhereType, carrotItemSlot[i].slot)
        return
      end
    end
  end
  local inventory = getSelfPlayer():get():getInventory()
  local invenSize = inventory:sizeXXX()
  local carrotItemSlot = {}
  for invenidx = 2, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, invenidx)
    if nil ~= itemWrapper then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      for i = 0, #carrotItemKey do
        if carrotItemKey[i] == itemKey then
          local carrotCoolTime = getItemCooltime(CppEnums.ItemWhereType.eInventory, invenidx)
          if 0 ~= carrotCoolTime then
            return
          end
          local isCheckedConditions = itemWrapper:checkConditions()
          if isCheckedConditions then
            if nil == carrotItemSlot[i] then
              carrotItemSlot[i] = {slot = "", key = ""}
            end
            carrotItemSlot[i].itemWhereType = CppEnums.ItemWhereType.eInventory
            carrotItemSlot[i].slot = invenidx
            carrotItemSlot[i].key = itemKey
            break
          end
        end
      end
    end
  end
  for i = 0, #carrotItemKey do
    if nil ~= carrotItemSlot[i] and "" ~= carrotItemSlot[i].slot and carrotItemKey[i] == carrotItemSlot[i].key then
      useAutoCarrot(carrotItemSlot[i].itemWhereType, carrotItemSlot[i].slot)
      break
    end
  end
end
function HandleOn_HorseMp_Bar()
  servantMpBar._staticText:SetShow(true)
end
function HandleOut_HorseMp_Bar()
  servantMpBar._staticText:SetShow(false)
end
function HorseMP_OpenByInteraction()
  local self = servantMpBar
  local selfPlayer = getSelfPlayer()
  local selfProxy = selfPlayer:get()
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  local vehicleProxy = getVehicleActor(actorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  if UI_VT.Type_ThrowFire == vehicleType or UI_VT.Type_ThrowStone == vehicleType or UI_VT.Type_Cannon == vehicleType then
    return
  end
  if true == _ContentsGroup_OceanCurrent and true == ToClient_isVehicleTypeWater(vehicleType) and 0 ~= selfProxy:getVehicleSeatIndex() then
    return
  end
  self._actorKeyRaw = actorKeyRaw
  HorseMP_Open()
  FGlobal_ServantIcon_IsNearMonster_Effect(false)
end
function HorseMP_SimpleTooltips(isShow, servantTooltipType, staminaStatus)
  local name, desc, uiControl
  if 0 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_HORSEMP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_HORSEMP_DESC")
    uiControl = Panel_HorseHp
  elseif 1 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_CARRIAGEMP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_CARRIAGEMP_DESC")
    uiControl = Panel_HorseHp
  elseif 3 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_CARRIAGEMP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_ELEPHANTMP_DESC")
    uiControl = Panel_HorseMp
  elseif 4 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_DESC")
    uiControl = Panel_HorseMp
  elseif 5 == servantTooltipType then
    local self = servantMpBar
    local vehicleProxy = getVehicleActor(self._actorKeyRaw)
    local strFood
    if nil ~= vehicleProxy then
      local currentMp = getMpToActor(vehicleProxy)
      local maxMp = getMaxMpToActor(vehicleProxy)
      strFood = makeDotMoney(currentMp) .. "/" .. makeDotMoney(maxMp)
    end
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_NAME")
    if nil ~= strFood then
      desc = strFood .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_DESC")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_DESC")
    end
    uiControl = Panel_HorseMp
  elseif 6 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SHIP_TOOLTIP_AUTO_USE_FAST_MOVE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHIP_TOOLTIP_AUTO_USE_FAST_MOVE_DESC")
    uiControl = servantMpBar._button_AutoSpeed
  elseif 7 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSE_TOOLTIP_AUTO_USE_FAST_MOVE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSE_TOOLTIP_AUTO_USE_FAST_MOVE_DESC")
    uiControl = servantMpBar._button_AutoSpeed
  elseif 8 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CAMEL_TOOLTIP_AUTO_USE_FAST_MOVE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CAMEL_TOOLTIP_AUTO_USE_FAST_MOVE_DESC")
    uiControl = servantMpBar._button_AutoSpeed
  elseif 9 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ELEPHANT_TOOLTIP_AUTO_USE_FAST_MOVE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ELEPHANT_TOOLTIP_AUTO_USE_FAST_MOVE_DESC")
    uiControl = servantMpBar._button_AutoSpeed
  elseif 10 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_DONKEY_TOOLTIP_AUTO_USE_FAST_MOVE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_DONKEY_TOOLTIP_AUTO_USE_FAST_MOVE_DESC")
    uiControl = servantMpBar._button_AutoSpeed
  elseif 11 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CARRIAGE_TOOLTIP_AUTO_USE_FAST_MOVE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CARRIAGE_TOOLTIP_AUTO_USE_FAST_MOVE_DESC")
    uiControl = servantMpBar._button_AutoSpeed
  end
  if isShow == true and nil ~= staminaStatus then
    registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(uiControl, name, desc)
    HandleOn_HorseMp_Bar()
  elseif isShow == true and nil == staminaStatus then
    registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
    HandleOut_HorseMp_Bar()
  end
end
function HorseMP_Open()
  if Panel_HorseMp:GetShow() then
    return
  end
  if Panel_WorldMap:GetShow() then
    return
  end
  local selfPlayer = getSelfPlayer()
  local selfProxy = selfPlayer:get()
  local isDriver = selfProxy:isVehicleDriver()
  if false == isDriver then
  end
  local self = servantMpBar
  local vehicleProxy = getVehicleActor(self._actorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  local characterKey = vehicleProxy:getCharacterKeyRaw()
  local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
  if UI_VT.Type_Ladder == vehicleType or UI_VT.Type_Cow == vehicleType or UI_VT.Type_Bomb == vehicleType or UI_VT.Type_QuestObjectBox == vehicleType or UI_VT.Type_QuestObjectSack == vehicleType or UI_VT.Type_QuestObjectSheep == vehicleType or UI_VT.Type_QuestObjectCart == vehicleType or UI_VT.Type_QuestObjectOak == vehicleType or UI_VT.Type_QuestObjectBoat == vehicleType or UI_VT.Type_QuestObjectPumpkin == vehicleType or UI_VT.Type_QuestObjectBrokenFrag == vehicleType or UI_VT.Type_QuestObjectHerbalMachines == vehicleType or UI_VT.Type_QuestObjectExtractor == vehicleType or UI_VT.Type_Training == vehicleType then
    return
  end
  servantMpBar._button_AutoSpeed:SetShow(false)
  servantMpBar._button_AutoSpeed:SetCheck(false)
  Panel_HorseMp:SetShow(true)
  servantMpBar._autoBtnFlag = false
  HorseMp_InitStaminaAlertText(vehicleType, nil ~= shipStaticStatus and false == shipStaticStatus:getIsSummonFull())
  HorseMP_Update()
end
function HorseMP_Close()
  if not Panel_HorseMp:GetShow() then
    return
  end
  servantMpBar._autoBtnFlag = false
  Panel_HorseMp:SetShow(false)
end
function HandleClick_Horse_Repair_Navi(isAuto)
  local player = getSelfPlayer()
  if nil == player then
    return
  end
end
function HorseMP_EventSelfPlayerCarrierChanged(vehicleActorKeyRaw)
  local self = servantMpBar
  local characterActorProxyWrapper = getCharacterActor(vehicleActorKeyRaw)
  if nil == characterActorProxyWrapper then
    HorseMP_Close()
    return
  end
  self._actorKeyRaw = vehicleActorKeyRaw
  HorseMP_Open()
end
function renderModechange_HorseMP_OpenByInteraction(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  HorseMP_OpenByInteraction()
end
function FGlobal_ToggleServantAutoCarrot_PadInput()
  if nil == PaGlobalFunc_HorseInfo_GetIsCheckAutoCarrot then
    return
  end
  if true == PaGlobalFunc_HorseInfo_GetIsCheckAutoCarrot() then
    servantMpBar._isAutoCarrot = true
    servantMpBar._button_AutoCarrot:SetCheck(true)
  else
    servantMpBar._isAutoCarrot = false
    servantMpBar._button_AutoCarrot:SetCheck(false)
  end
end
function FGlobal_ToggleCanMoveFast_PadInput(isShip)
  if false == servantMpBar._button_AutoSpeed:GetShow() then
    return
  end
  if false == servantMpBar._autoBtnFlag then
    return
  end
  local isBtnCheck = servantMpBar._button_AutoSpeed:IsCheck()
  if false == isShip and 0 ~= servantMpBar._actorKeyRaw then
    local vehicleProxy = getVehicleActor(servantMpBar._actorKeyRaw)
    if nil == vehicleProxy then
      return
    end
    local vehicleType = vehicleProxy:get():getVehicleType()
    FGlobal_HorseMp_ShowAutoSpeedPopUp(vehicleType, isBtnCheck)
  elseif false == isBtnCheck then
    servantMpBar._button_AutoSpeed:SetCheck(true)
  else
    servantMpBar._button_AutoSpeed:SetCheck(false)
  end
end
function FGlobal_HorseMp_ShowAutoSpeedPopUp(vehicleType, isBtnCheck)
  if nil == vehicleType then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfPlayerGet = selfPlayer:get()
  if nil == selfPlayerGet then
    return
  end
  local skillKey = 0
  local lifeType = CppEnums.LifeExperienceType.Type_Count
  local txt_Title = ""
  local txt_Desc = ""
  if __eVehicleType_Horse == vehicleType then
    txt_Title = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_HORSE")
    txt_Desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSE_POPUP_DESC")
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 4
  elseif __eVehicleType_Camel == vehicleType then
    txt_Title = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_CAMEL")
    txt_Desc = PAGetString(Defines.StringSheet_GAME, "LUA_CAMEL_POPUP_DESC")
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 22
  elseif CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType then
    txt_Title = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_ELEPHANT")
    txt_Desc = PAGetString(Defines.StringSheet_GAME, "LUA_ELEPHANT_POPUP_DESC")
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 28
  elseif __eVehicleType_Donkey == vehicleType then
    txt_Title = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_DONKEY")
    txt_Desc = PAGetString(Defines.StringSheet_GAME, "LUA_DONKEY_POPUP_DESC")
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 62
  elseif __eVehicleType_RepairableCarriage == vehicleType then
    txt_Title = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_CARRIAGE")
    txt_Desc = PAGetString(Defines.StringSheet_GAME, "LUA_CARRIAGE_POPUP_DESC")
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 55
  end
  if lifeType ~= CppEnums.LifeExperienceType.Type_Count then
    local vehicleProxy = getVehicleActor(servantMpBar._actorKeyRaw)
    if nil == vehicleProxy then
      return
    end
    local needLifeLv = vehicleProxy:getNeedLifeLevelForAutoSkill(skillKey)
    local myLifeLv = selfPlayerGet:getLifeExperienceLevel(lifeType)
    if needLifeLv > myLifeLv then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_AUTOSPRINT_CANNOTUSE"))
      servantMpBar._button_AutoSpeed:SetCheck(false)
    elseif true == isBtnCheck then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_AUTOSPRINT_DISABLE"))
      servantMpBar._button_AutoSpeed:SetCheck(false)
    elseif false == isBtnCheck then
      local function useAutoSkill()
        servantMpBar._button_AutoSpeed:SetCheck(true)
      end
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
      local messageBoxData = {
        title = txt_Title,
        content = txt_Desc,
        functionYes = useAutoSkill,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  end
end
function HorseMP_CheckAutoSpeedButton()
  if nil == servantMpBar then
    return false
  end
  return nil ~= servantMpBar._button_AutoSpeed
end
