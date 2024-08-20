function HandleEventLUp_HouseName_All_InstallationMode()
  if getInputMode() == CppEnums.EProcessorInputMode.eProcessorInputMode_ChattingInputMode then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOT_ENTER_HOUSINGMODE_CHATMODE"))
    return
  end
  TooltipSimple_Hide()
  if true == _ContentsGroup_NewUI_InstallMode_All then
    PaGlobal_House_Installation_All_Open()
  else
    FGlobal_House_InstallationMode_Open()
  end
end
function HandleEventLUp_HouseName_All_ShowRank()
  toClient_RequestHouseRankerList()
end
function HandleEventLUp_HouseName_All_ShowInven()
  InventoryWindow_Show()
end
function HandleEventLUp_HouseName_All_SetDurabilityHideToggle()
  if nil == Furniture_Check then
    return
  end
  if nil ~= Panel_Housing and true == Panel_Housing:IsShow() then
    return
  end
  if true == housing_isInstallMode() then
    return
  end
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    return
  end
  local isHideDurability = PaGlobal_HouseName_All._ui._chk_hideDurability:IsCheck()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eHideHousingDurability, isHideDurability, CppEnums.VariableStorageType.eVariableStorageType_User)
  PaGlobal_HouseName_All._ui._stc_hideDurabilityHideIcon:SetShow(not isHideDurability)
  PaGlobal_HouseName_All._ui._stc_hideDurabilityShowIcon:SetShow(isHideDurability)
  local interactionActorKeyRaw = 0
  local interactionActor = interaction_getInteractable()
  if nil ~= interactionActor then
    interactionActorKeyRaw = interactionActor:getActorKey()
  end
  local houseActorCount = houseWrapper:getInstallationCount()
  for ii = 0, houseActorCount - 1 do
    local actorKeyRaw = houseWrapper:getInstallationActorKeyRaw(ii)
    if nil ~= actorKeyRaw and 0 ~= actorKeyRaw and actorKeyRaw ~= interactionActorKeyRaw then
      Furniture_Check(actorKeyRaw)
    end
  end
  if nil ~= interactionActorKeyRaw and 0 ~= interactionActorKeyRaw then
    Furniture_Check(interactionActorKeyRaw)
  end
end
function PaGlobal_HouseName_All_GetDurabilityHideToggle()
  if nil == Panel_House_Name_All then
    return false
  end
  return PaGlobal_HouseName_All._ui._chk_hideDurability:IsCheck()
end
function HandleEventLUp_HouseName_All_SetUnderwearToggle()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == _ContentsGroup_NewUI_Inventory_All then
    HandleEventLUp_Equipment_All_ShowUnderWear()
  elseif true == _ContentsGroup_RenewUI_InventoryEquip then
    if true == isGameTypeKR2() then
      return
    end
    Input_InventoryInfo_ToggleUnderwear()
  else
    Check_Underwear()
  end
  PaGlobal_HouseName_All._ui._chk_setUnderwear:SetCheck(selfPlayer:get():getSwimmingSuitMode() or selfPlayer:get():getUnderwearModeInhouse())
end
function HandleEventLUp_HouseName_All_SetPetToggle()
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  local isHide = housing_getIsHidePetActors()
  if nil == houseWrapper then
    return
  end
  housing_setHidePetInHouse(not isHide)
end
function HandleEventLUp_HouseName_All_SetMaidToggle()
  if true == PaGlobal_HouseName_All._isConsole and false == _ContentsGroup_Maid then
    return
  end
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    return
  end
  local houseSS = houseWrapper:getStaticStatusWrapper()
  if nil ~= houseSS then
    local houseObjectSS = houseSS:getObjectStaticStatus()
    if nil ~= houseObjectSS and true == houseObjectSS:isMansionLand() then
      return
    end
  end
  local isHide = housing_getIsHideMaidActors()
  housing_setHideMaidInHouse(not isHide)
end
function HandleEventOn_HouseName_All_ButtonTooltip(buttonType)
  local control, name, desc
  if PaGlobal_HouseName_All._eButtonType.installMode == buttonType then
    control = PaGlobal_HouseName_All._ui._btn_installMode
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSINGNAME_TOOLTIP_TITLE_INSTALLATIONMODE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSINGNAME_TOOLTIP_DESC_INSTALLATIONMODE")
  elseif PaGlobal_HouseName_All._eButtonType.installGift == buttonType then
    control = PaGlobal_HouseName_All._ui._btn_installGift
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSINGNAME_TOOLTIP_TITLE_INSTALLGIFT")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSINGNAME_TOOLTIP_DESC_INSTALLGIFT")
  elseif PaGlobal_HouseName_All._eButtonType.showRank == buttonType then
    control = PaGlobal_HouseName_All._ui._btn_showRank
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSINGNAME_TOOLTIP_TITLE_SHOWRANK")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSINGNAME_TOOLTIP_DESC_SHOWRANK")
  elseif PaGlobal_HouseName_All._eButtonType.underwear == buttonType then
    control = PaGlobal_HouseName_All._ui._chk_setUnderwear
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSINGNAME_TOOLTIP_TITLE_UNDERWEAR")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSINGNAME_TOOLTIP_DESC_UNDERWEAR")
  elseif PaGlobal_HouseName_All._eButtonType.pet == buttonType then
    control = PaGlobal_HouseName_All._ui._chk_hidePet
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSENAME_PET_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSENAME_PET_TOOLTIP_DESC")
  elseif PaGlobal_HouseName_All._eButtonType.maid == buttonType then
    control = PaGlobal_HouseName_All._ui._chk_hideMaid
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSENAME_MAID_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSENAME_MAID_TOOLTIP_DESC")
  elseif PaGlobal_HouseName_All._eButtonType.durability == buttonType then
    control = PaGlobal_HouseName_All._ui._chk_hideDurability
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSENAME_DURABILITY_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSENAME_DURABILITY_TOOLTIP_DESC")
  end
  if nil == control then
    return
  end
  registTooltipControl(control, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(control, name, desc)
end
function FromClient_HouseName_All_RenderModeChangeState(prevRenderModeList, nextRenderModeList)
  if false == CheckRenderModebyGameMode(nextRenderModeList) then
    return
  end
  if Panel_House_Name_All:GetShow() then
    local houseWrapper = housing_getHouseholdActor_CurrentPosition()
    if nil == houseWrapper then
      PaGlobal_HouseName_All:prepareClose(false)
    end
  end
end
function FromClient_HouseName_All_EventHousingShowVisitHouse(isShow, houseName, userNickname, point, isMine)
  PaGlobal_HouseName_All._prevPoint = point
  local isShowUnderwear = getSelfPlayer():get():getUnderwearModeInhouse()
  if false == ToClient_isAdultUser() then
    PaGlobal_HouseName_All._ui._chk_setUnderwear:SetCheck(false)
    PaGlobal_HouseName_All._ui._chk_setUnderwear:SetShow(false)
    PaGlobal_HouseName_All._ui._chk_setUnderwear:SetIgnore(true)
  else
    PaGlobal_HouseName_All._ui._chk_setUnderwear:SetCheck(isShowUnderwear)
  end
  local isPet = housing_getIsHidePetActors()
  local isMaid = housing_getIsHideMaidActors()
  PaGlobal_HouseName_All._ui._chk_hidePet:SetCheck(isPet)
  PaGlobal_HouseName_All._ui._chk_hideMaid:SetCheck(isMaid)
  if true == ToClient_VisitHouseIsMansionLand() or true == ToClient_VisitHouseIsMansion() then
    PaGlobal_HouseName_All._ui._chk_hideMaid:SetShow(false)
  else
    PaGlobal_HouseName_All._ui._chk_hideMaid:SetShow(true)
  end
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    PaGlobal_HouseName_All:prepareClose(false)
    return
  end
  PaGlobal_HouseName_All._isMyHouse = isMine
  local isMansionLand = houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isMansionLand()
  local isInnRoom = houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isInnRoom()
  local isFixedHouse = houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isFixedHouse()
  if isFixedHouse then
    PaGlobal_HouseName_All._ui._btn_showRank:SetShow(false)
    PaGlobal_HouseName_All._ui._btn_installMode:SetShow(false)
    PaGlobal_HouseName_All._ui._btn_installGift:SetShow(false)
    return
  elseif isInnRoom then
    PaGlobal_HouseName_All._ui._btn_showRank:SetShow(false)
    if isMine then
      PaGlobal_HouseName_All._ui._btn_installMode:SetShow(true)
      PaGlobal_HouseName_All._ui._btn_installGift:SetShow(false)
    else
      PaGlobal_HouseName_All._ui._btn_installMode:SetShow(false)
      if FGlobal_IsCommercialService() then
        PaGlobal_HouseName_All._ui._btn_installGift:SetShow(true)
      else
        PaGlobal_HouseName_All._ui._btn_installGift:SetShow(false)
      end
    end
  elseif isMansionLand then
    PaGlobal_HouseName_All._ui._btn_showRank:SetShow(false)
    if isMine then
      PaGlobal_HouseName_All._ui._btn_installMode:SetShow(true)
      PaGlobal_HouseName_All._ui._btn_installGift:SetShow(false)
    else
      PaGlobal_HouseName_All._ui._btn_installMode:SetShow(false)
      PaGlobal_HouseName_All._ui._btn_installGift:SetShow(not ToClient_VisitHouseIsMansionLand())
    end
  else
    PaGlobal_HouseName_All._ui._btn_showRank:SetShow(false)
    PaGlobal_HouseName_All._ui._btn_installMode:SetShow(false)
    PaGlobal_HouseName_All._ui._btn_installGift:SetShow(false)
  end
  if true == isMansionLand then
    PaGlobal_HouseName_All._ui._txt_houseName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSING_HOUSENAME_BIGHOUSE", "user_nickname", userNickname))
    PaGlobal_HouseName_All._ui._chk_hideMaid:SetShow(false)
    PaGlobal_HouseName_All._ui._chk_hidePet:SetSpanSize(PaGlobal_HouseName_All._ui._chk_hideMaid:GetSpanSize().x, PaGlobal_HouseName_All._ui._chk_hidePet:GetSpanSize().y)
    PaGlobal_HouseName_All._ui._chk_hideDurability:SetSpanSize(PaGlobal_HouseName_All._originPetIconSpanX, PaGlobal_HouseName_All._ui._chk_hideDurability:GetSpanSize().y)
    PaGlobal_HouseName_All._ui._chk_setUnderwear:SetShow(false)
    if true == PaGlobal_HouseName_All._isConsole then
      PaGlobal_HouseName_All._ui._console._stc_underWear:SetShow(false)
      PaGlobal_HouseName_All._ui._console._stc_inventory:SetSpanSize(0, PaGlobal_HouseName_All._ui._console._stc_inventory:GetSpanSize().y)
    end
    local selfPlayerWrraper = getSelfPlayer()
    if nil ~= selfPlayerWrraper and nil ~= selfPlayerWrraper:get() then
      selfPlayerWrraper:get():setUnderwearModeInhouse(false)
    end
  else
    PaGlobal_HouseName_All._ui._txt_houseName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSING_HOUSENAME_LIVING", "user_nickname", userNickname))
    PaGlobal_HouseName_All._ui._chk_hideMaid:SetShow(true)
    PaGlobal_HouseName_All._ui._chk_hidePet:SetSpanSize(PaGlobal_HouseName_All._originPetIconSpanX, PaGlobal_HouseName_All._ui._chk_hidePet:GetSpanSize().y)
    PaGlobal_HouseName_All._ui._chk_hideDurability:SetSpanSize(PaGlobal_HouseName_All._originDurabilityIconSpanX, PaGlobal_HouseName_All._ui._chk_hideDurability:GetSpanSize().y)
    PaGlobal_HouseName_All._ui._chk_setUnderwear:SetShow(true)
    if true == PaGlobal_HouseName_All._isConsole then
      PaGlobal_HouseName_All._ui._console._stc_underWear:SetShow(true)
      PaGlobal_HouseName_All._ui._console._stc_inventory:SetSpanSize(PaGlobal_HouseName_All._baseConsoleInventoryIconSpanX, PaGlobal_HouseName_All._ui._console._stc_inventory:GetSpanSize().y)
    end
  end
  PaGlobal_HouseName_All._ui._txt_houseAddress:SetShow(true)
  PaGlobal_HouseName_All._ui._txt_houseAddress:SetText(houseName)
  PaGlobal_HouseName_All._ui._txt_houseScore:SetShow(true)
  PaGlobal_HouseName_All._ui._txt_houseScore:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_KNOWLEDGE_POINT", "knowledgePoint", point))
  local textSizeX = PaGlobal_HouseName_All._ui._txt_houseName:GetTextSizeX() + 50
  PaGlobal_HouseName_All._ui._txt_houseName:SetSize(math.max(PaGlobal_HouseName_All._defaultNameSizeX, textSizeX), PaGlobal_HouseName_All._ui._txt_houseName:GetSizeY())
  PaGlobal_HouseName_All._ui._txt_houseName:ComputePos()
  PaGlobal_HouseName_All._ui._stc_deco_left:ComputePos()
  PaGlobal_HouseName_All._ui._stc_deco_right:ComputePos()
  if Panel_House_Name_All:IsShow() then
    return
  end
  if true == _ContentsGroup_NewUI_InstallMode_All then
    if true == PaGlobal_House_Installation_All_GetPanelShow() then
      return
    end
  elseif Panel_House_InstallationMode:GetShow() then
    return
  end
  if Panel_Interaction_HouseRank:GetShow() then
    Panel_Interaction_HouseRanke_Close()
  end
  if isGameTypeKR2() then
    PaGlobal_HouseName_All._ui._chk_setUnderwear:SetShow(false)
  end
  if true == isShow then
    PaGlobal_HouseName_All:prepareOpen(true)
  else
    PaGlobal_HouseName_All:prepareClose(true)
  end
end
function FromClient_HouseName_All_ChangeUnderwearModeInHouse(isUnderwearModeInHouse)
  if false == ToClient_isAdultUser() then
    PaGlobal_HouseName_All._ui._chk_setUnderwear:SetCheck(false)
  else
    PaGlobal_HouseName_All._ui._chk_setUnderwear:SetCheck(isUnderwearModeInHouse)
  end
end
function FromClient_HouseName_All_ScreenResize()
  Panel_House_Name_All:SetPosX(getScreenSizeX() * 0.5 - Panel_House_Name_All:GetSizeX() * 0.5)
end
function FromClient_HouseName_All_UpdatePerFrame(deltaTime)
  PaGlobal_HouseName_All:updatePerFrame(deltaTime)
end
function FromClient_responseRepairToInstallation()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRepairToolComplete"))
end
function PaGlobal_HouseName_All_ShowAni()
  if nil == Panel_House_Name_All then
    return
  end
  UIAni.AlphaAnimation(1, Panel_House_Name_All, 0, 1)
end
function PaGlobal_HouseName_All_HideAni()
  if nil == Panel_House_Name_All then
    return
  end
  local aniInfo = UIAni.AlphaAnimation(0, Panel_House_Name_All, 0, 0.35)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_HouseName_All_PetMaidInit()
  local isPet = housing_getIsHidePetActors()
  local isMaid = housing_getIsHideMaidActors()
  PaGlobal_HouseName_All._ui._chk_hidePet:SetCheck(isPet)
  PaGlobal_HouseName_All._ui._chk_hideMaid:SetCheck(isMaid)
end
function PaGlobal_HouseName_All_GetHouseNamePoint()
  return PaGlobal_HouseName_All._prevPoint
end
function PaGlobal_HouseName_All_ResetAlertHouseLighting()
  PaGlobal_HouseName_All:resetAlertHouseLighting()
end
function PaGlobal_HouseName_All_GetShowPanel()
  if nil == Panel_House_Name_All then
    return false
  end
  return Panel_House_Name_All:GetShow()
end
