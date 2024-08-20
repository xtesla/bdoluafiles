function PaGlobal_MiningFuel_All:initialize()
  if true == PaGlobal_MiningFuel_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_TitleArea = UI.getChildControl(Panel_Guild_MiningFuel_All, "Static_TitleArea")
  self._ui_pc.btn_Exit = UI.getChildControl(stc_TitleArea, "Button_Close")
  local stc_SelectBG = UI.getChildControl(Panel_Guild_MiningFuel_All, "Static_SelectBG")
  self._ui.stc_Fuel_BG = UI.getChildControl(stc_SelectBG, "Static_Fuel_BG")
  for index = 0, self._fuelSlotMaxCount - 1 do
    local itemSlot = UI.getChildControl(self._ui.stc_Fuel_BG, "Static_ItemSlot_" .. index + 1)
    local createdSlot = {}
    SlotItem.new(createdSlot, "ItemSlot" .. index + 1, 0, self._ui.stc_Fuel_BG, PaGlobal_MiningFuel_All._slotConfig)
    createdSlot:createChild()
    createdSlot.empty = true
    createdSlot:clearItem()
    createdSlot.icon:SetPosX(itemSlot:GetPosX())
    createdSlot.icon:SetPosY(itemSlot:GetPosY())
    self._fuelSlot[index] = createdSlot
  end
  self._ui.stc_Progress_BG = UI.getChildControl(stc_SelectBG, "Static_Progress_BG")
  self._ui.txt_ProgressValue = UI.getChildControl(self._ui.stc_Progress_BG, "StaticText_ProgressValue")
  self._ui.sliderProgress = UI.getChildControl(stc_SelectBG, "Progress2_1")
  self._ui_pc.btn_Reward = UI.getChildControl(stc_SelectBG, "Button_Reward")
  local crackBG = UI.getChildControl(stc_SelectBG, "Static_Crank_BG")
  self._ui.stc_Pole = UI.getChildControl(crackBG, "Static_Pole")
  self._ui.stc_Hammer = UI.getChildControl(crackBG, "Static_Hammer")
  self._ui.stc_Effect = UI.getChildControl(stc_SelectBG, "Static_Smash_Effect")
  crackBG:SetRectClipOnArea(float2(0, 0), float2(crackBG:GetSizeX(), crackBG:GetSizeY()))
  self._hammerBasePosY = self._ui.stc_Hammer:GetPosY() + 30
  self._hammerLimitPosY = self._hammerBasePosY - 130
  local stc_Desc = UI.getChildControl(stc_SelectBG, "Static_Desc")
  local stc_TextDesc = UI.getChildControl(stc_Desc, "StaticText_Desc")
  stc_TextDesc:SetTextMode(__eTextMode_AutoWrap)
  stc_TextDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDMINING_FUEL_DESC"))
  PaGlobal_MiningFuel_All:registEventHandler()
  PaGlobal_MiningFuel_All:validate()
  PaGlobal_MiningFuel_All._initialize = true
end
function PaGlobal_MiningFuel_All:registEventHandler()
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  if true == self._isConsole then
  else
    self._ui_pc.btn_Exit:addInputEvent("Mouse_LUp", "PaGlobal_MiningFuel_All_Close()")
    self._ui_pc.btn_Reward:addInputEvent("Mouse_LUp", "HandleEventLUp_MiningFuel_All_GetReward()")
  end
  registerEvent("FromClient_GuildDrill_Load", "FromClient_MiningFuel_All_Open")
  registerEvent("FromClient_GuildDrill_FuelUpdate", "FromClient_MiningFuel_All_FuelUpdate")
  Panel_Guild_MiningFuel_All:RegisterUpdateFunc("PaGlobal_MiningFuel_All_UpdatePerFrame")
end
function PaGlobal_MiningFuel_All:prepareOpen(actorKeyRaw)
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  PaGlobal_MiningFuel_All:openUpdate(actorKeyRaw)
  PaGlobal_MiningFuel_All:open()
end
function PaGlobal_MiningFuel_All:open()
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  Panel_Guild_MiningFuel_All:SetShow(true)
end
function PaGlobal_MiningFuel_All:prepareClose()
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  self._actorKeyRaw = nil
  self._state = __eFuelInsertObjectState_None
  self._fuelCount = 0
  self._isAnimationPlay = false
  self._effectTime = 0
  self._effectIsShow = false
  Inventory_SetFunctor(nil, nil, nil, nil)
  if true == Panel_Window_Inventory_All:GetShow() then
    InventoryWindow_Close()
  end
  PaGlobal_MiningFuel_All:close()
end
function PaGlobal_MiningFuel_All:close()
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  Panel_Guild_MiningFuel_All:SetShow(false)
end
function PaGlobal_MiningFuel_All:openUpdate(actorKeyRaw)
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  self._actorKeyRaw = actorKeyRaw
  self._state = ToClient_GetFuelCharacterState(self._actorKeyRaw)
  self._fuelCount = Int64toInt32(ToClient_GetFuelCharacterCount(self._actorKeyRaw))
  local maxFuelCount = Int64toInt32(ToClient_GetFuelCharacterMaxCount(actorProxyWrapper:getCharacterKeyRaw()))
  if maxFuelCount <= 0 then
    return
  end
  local diff = 10
  local percent = self._fuelCount / maxFuelCount
  percent = percent * 100
  if percent > 100 then
    percent = 100
  end
  self._ui.sliderProgress:SetProgressRate(percent)
  self._ui.txt_ProgressValue:SetText(percent .. "%")
  if __eFuelInsertObjectState_Complete ~= self._state then
    if true == _ContentsGroup_NewUI_Inventory_All then
      if Panel_Window_Inventory_All:IsUISubApp() then
        Panel_Guild_MiningFuel_All:OpenUISubApp()
      end
      if false == Panel_Window_Inventory_All:GetShow() then
        InventoryWindow_Show(true)
      end
    end
    Inventory_SetFunctor(PaGlobal_MiningFuel_All_SetInvenFilter, HandleEventRUp_MiningFuel_All_SetInvenRclick, nil, nil)
    self._ui_pc.btn_Reward:SetEnable(false)
  else
    self._ui_pc.btn_Reward:SetEnable(true)
  end
  if false == self._isAnimationPlay then
    self._ui.stc_Hammer:SetPosY(self._hammerBasePosY)
  end
  PaGlobal_MiningFuel_All:fuelUpdate()
end
function PaGlobal_MiningFuel_All:fuelUpdate()
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  for index = 0, self._fuelSlotMaxCount - 1 do
    self._fuelSlot[index]:clearItem()
    self._fuelSlot[index].icon:SetShow(false)
  end
  local fuelListCount = ToClient_GetGuildDrillActorFuelCount(self._actorKeyRaw)
  for index = 0, fuelListCount - 1 do
    local itemKey = ToClient_GetGuildDrillActorFuelByIndex(self._actorKeyRaw, index)
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    local count = ToClient_GetGuildDrillActorFuelCountByIndex(self._actorKeyRaw, index)
    local _slotList = self._fuelSlot
    _slotList[index]:setItemByStaticStatus(itemSSW, Int64toInt32(count))
    _slotList[index].icon:SetShow(true)
    _slotList[index].icon:addInputEvent("Mouse_On", "HandleEventLUp_MiningFuel_All_ItemToolTip( true, " .. itemKey .. ", " .. index .. " )")
    _slotList[index].icon:addInputEvent("Mouse_Out", "HandleEventLUp_MiningFuel_All_ItemToolTip( false, " .. itemKey .. ", " .. index .. " )")
  end
end
function PaGlobal_MiningFuel_All:validate()
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
end
function PaGlobal_MiningFuel_All:updatePerFrame(deltaTime)
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  if false == Panel_Guild_MiningFuel_All:IsShow() then
    return
  end
  if true == PaGlobal_MiningFuel_All._effectIsShow then
    PaGlobal_MiningFuel_All._effectTime = PaGlobal_MiningFuel_All._effectTime + deltaTime
    if PaGlobal_MiningFuel_All._effectTime > 2 then
      PaGlobal_MiningFuel_All._effectTime = 0
      PaGlobal_MiningFuel_All._effectIsShow = false
      PaGlobal_MiningFuel_All._ui.stc_Effect:EraseAllEffect()
    end
  end
  if __eFuelInsertObjectState_Doing ~= PaGlobal_MiningFuel_All._state then
    return
  end
  PaGlobal_MiningFuel_All._isAnimationPlay = true
  local currentPosY = PaGlobal_MiningFuel_All._ui.stc_Hammer:GetPosY()
  if true == PaGlobal_MiningFuel_All._isUp then
    local speedY = 30
    PaGlobal_MiningFuel_All._ui.stc_Hammer:SetPosY(currentPosY - speedY * deltaTime)
    if PaGlobal_MiningFuel_All._ui.stc_Hammer:GetPosY() < PaGlobal_MiningFuel_All._hammerLimitPosY then
      PaGlobal_MiningFuel_All._isUp = false
      PaGlobal_MiningFuel_All._ui.stc_Hammer:SetPosY(PaGlobal_MiningFuel_All._hammerLimitPosY)
    end
  else
    local speedY = 600
    PaGlobal_MiningFuel_All._ui.stc_Hammer:SetPosY(currentPosY + speedY * deltaTime)
    if PaGlobal_MiningFuel_All._hammerBasePosY < PaGlobal_MiningFuel_All._ui.stc_Hammer:GetPosY() then
      PaGlobal_MiningFuel_All._isUp = true
      PaGlobal_MiningFuel_All._ui.stc_Hammer:SetPosY(PaGlobal_MiningFuel_All._hammerBasePosY)
      PaGlobal_MiningFuel_All._effectIsShow = true
      PaGlobal_MiningFuel_All._effectTime = 0
      PaGlobal_MiningFuel_All._ui.stc_Effect:AddEffect("fUI_Drilling_Dust_01A", true, 0, 0)
    end
  end
end
