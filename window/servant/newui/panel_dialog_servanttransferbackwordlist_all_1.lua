function PaGlobal_ServantTransferBackwardList_All:initialize()
  if nil == Panel_Window_SimpleStableList_All or true == self._initailize then
    return
  end
  local staticTittle = UI.getChildControl(Panel_Window_SimpleStableList_All, "Static_TitleBG")
  self._ui._stc_ListTitle = UI.getChildControl(staticTittle, "List_Title")
  self._ui._btn_Close_PC = UI.getChildControl(staticTittle, "List_Button_Close")
  self._ui._list2_Servant = UI.getChildControl(Panel_Window_SimpleStableList_All, "List2_1")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:validate()
  self:isConsoleUI(self._isConsole)
  self:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantTransferBackwardList_All:validate()
  if nil == Panel_Window_SimpleStableList_All then
    return
  end
  self._ui._stc_ListTitle:isValidate()
  self._ui._btn_Close_PC:isValidate()
  self._ui._list2_Servant:isValidate()
  self._initailize = true
end
function PaGlobal_ServantTransferBackwardList_All:registerEventHandler(isConsole)
  if nil == Panel_Window_SimpleStableList_All or false == self._initailize then
    return
  end
  registerEvent("onScreenResize", "PaGlobalFunc_ServantTransferBackwardList_All_OnScreenResize")
  self._ui._list2_Servant:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ServantTransferBackwardList_All_List2Update")
  self._ui._list2_Servant:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == isConsole then
    self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantTransferBackwardList_All_Close()")
  end
end
function PaGlobal_ServantTransferBackwardList_All:isConsoleUI(isConsole)
  if nil == Panel_Window_SimpleStableList_All or false == self._initailize then
    return
  end
  Panel_Window_SimpleStableList_All:SetDragEnable(not isConsole)
  Panel_Window_SimpleStableList_All:SetDragAll(not isConsole)
  self._ui._btn_Close_PC:SetShow(not isConsole)
end
function PaGlobal_ServantTransferBackwardList_All:prepareOpen(regionKey)
  if nil == Panel_Window_SimpleStableList_All or true == Panel_Window_SimpleStableList_All:GetShow() then
    return
  end
  self._currentRegionKey = regionKey
  PaGlobalFunc_ServantTransferBackwardList_All_OnScreenResize()
  local posX = Panel_Dialog_ServantTransferList_All:GetPosX() + Panel_Dialog_ServantTransferList_All:GetSizeX() + 10
  Panel_Window_SimpleStableList_All:SetPosX(posX)
  Panel_Window_SimpleStableList_All:SetPosY(Panel_Dialog_ServantTransferList_All:GetPosY())
  PaGlobal_ServantTransferBackwardList_All:open()
  PaGlobal_ServantTransferBackwardList_All:update()
end
function PaGlobal_ServantTransferBackwardList_All:open()
  if nil == Panel_Window_SimpleStableList_All or true == Panel_Window_SimpleStableList_All:GetShow() then
    return
  end
  Panel_Window_SimpleStableList_All:SetShow(true)
end
function PaGlobal_ServantTransferBackwardList_All:update()
  if nil == Panel_Window_SimpleStableList_All or false == Panel_Window_SimpleStableList_All:GetShow() then
    return
  end
  if nil == getSelfPlayer then
    return
  end
  self._isTransBackWordList = false
  self._ui._list2_Servant:getElementManager():clearKey()
  local seravntList = PaGlobal_ServantTransferList_All._transBackWordList[self._currentRegionKey]
  for ii = 1, #seravntList do
    self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, ii))
  end
  if CppEnums.ServantType.Type_Vehicle == stable_getServantType() then
    self._ui._stc_ListTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NODESTABLE_TITLE"))
  elseif CppEnums.ServantType.Type_Ship == stable_getServantType() then
    self._ui._stc_ListTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WHARFLIST_WHARF_TITLE"))
  else
    return
  end
end
function PaGlobal_ServantTransferBackwardList_All:list2Update(content, key)
  if nil == Panel_Window_SimpleStableList_All or false == Panel_Window_SimpleStableList_All:GetShow() or nil == key then
    return
  end
  local key32 = Int64toInt32(key)
  local linkedHorseCount = 0
  local btn = UI.getChildControl(content, "List_SlotBG")
  local image = UI.getChildControl(content, "List_Icon")
  local genderIcon = UI.getChildControl(content, "List_FemaleIcon")
  local name = UI.getChildControl(content, "List_Name_Value")
  local state = UI.getChildControl(content, "List_Coma")
  local levelTxt = UI.getChildControl(content, "List_Level_Value")
  local tierTxt = UI.getChildControl(content, "List_Tier_Value")
  local seravntList = PaGlobal_ServantTransferList_All._transBackWordList[self._currentRegionKey]
  servantInfo = stable_getServantByServantNo(seravntList[key32])
  if nil ~= servantInfo then
    local servantRegionName = servantInfo:getRegionName()
    if nil == servantRegionName then
      servantRegionName = ""
    end
    local servantType = servantInfo:getVehicleType()
    local isLinkedHorse = servantInfo:isLink() and CppEnums.VehicleType.Type_Horse == servantType
    local regionKey = servantInfo:getRegionKeyRaw()
    local regionInfoWrapper = getRegionInfoWrapper(regionKey)
    local exploerKey = 0
    if nil ~= regionInfoWrapper then
      exploerKey = regionInfoWrapper:getExplorationKey()
    end
    local getState = servantInfo:getStateType()
    local vehicleType = servantInfo:getVehicleType()
    local servantNo = servantInfo:getServantNo()
    local level = servantInfo:getLevel()
    image:SetMonoTone(false, false)
    genderIcon:SetMonoTone(false, false)
    name:SetMonoTone(false, false)
    btn:SetMonoTone(false, false)
    state:SetShow(false)
    btn:setNotImpactScrollEvent(true)
    name:SetText(servantInfo:getName())
    if false == servantInfo:isPcroomOnly() and false == PaGlobalFunc_ServantFunction_All_GetIsGuild() and (servantType == CppEnums.VehicleType.Type_Horse or servantType == CppEnums.VehicleType.Type_Camel or servantType == CppEnums.VehicleType.Type_Donkey or servantType == CppEnums.VehicleType.Type_RidableBabyElephant) then
      levelTxt:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. tostring(level))
      if servantType == CppEnums.VehicleType.Type_Horse then
        tierTxt:SetText("")
        local tierName = servantInfo:getDisplayTierName()
        if nil ~= tierName then
          tierTxt:SetText(tierName)
        end
      end
    end
    image:ChangeTextureInfoName(servantInfo:getIconPath1())
    image:SetShow(true)
    if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
      btn:SetMonoTone(false, false)
      image:SetMonoTone(false, false)
      genderIcon:SetMonoTone(false, false)
      name:SetMonoTone(false, false)
    elseif regionKey ~= self._currentRegionKey then
      if 0 == servantInfo:getHp() or CppEnums.ServantStateType.Type_Coma == getState then
        if CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_Elephant == vehicleType or CppEnums.VehicleType.Type_RepairableCarriage == vehicleType or CppEnums.VehicleType.Type_Elephant == vehicleType or CppEnums.VehicleType.Type_Train == vehicleType or CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType or CppEnums.VehicleType.Type_SailingBoat == vehicleType then
          btn:SetMonoTone(true, true)
          image:SetMonoTone(true, true)
          genderIcon:SetMonoTone(true, true)
          name:SetMonoTone(true, true)
        end
      elseif not isSiegeStable() then
        btn:SetMonoTone(true, true)
        image:SetMonoTone(true, true)
        genderIcon:SetMonoTone(true, true)
        name:SetMonoTone(true, true)
      end
    end
    genderIcon:SetShow(false)
    levelTxt:SetShow(false)
    tierTxt:SetShow(false)
    local isHorse = false
    if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Horse or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_RaceHorse then
      isHorse = true
      if true == servantInfo:isDisplayGender() then
        if true == servantInfo:isMale() then
          genderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(genderIcon, 1, 209, 31, 239)
          genderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
          genderIcon:setRenderTexture(genderIcon:getBaseTexture())
        else
          genderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(genderIcon, 1, 178, 31, 208)
          genderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
          genderIcon:setRenderTexture(genderIcon:getBaseTexture())
        end
        genderIcon:SetShow(true)
      end
      if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Horse then
        levelTxt:SetShow(true)
        tierTxt:SetShow(true)
      end
    end
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    local regieonKey = regionInfo:getRegionKey()
    btn:SetShow(true)
    btn:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantTransferBackwardList_All_Transfer(" .. key32 .. "," .. self._currentRegionKey .. "," .. tostring(isHorse) .. ")")
    if false == self._isConsole then
      btn:addInputEvent("Mouse_UpScroll", "PaGlobalFunc_SeravntInfo_All_SaveScrollPos()")
      btn:addInputEvent("Mouse_DownScroll", "PaGlobalFunc_SeravntInfo_All_SaveScrollPos()")
    end
  end
end
function PaGlobal_ServantTransferBackwardList_All:prepareClose()
  if nil == Panel_Window_SimpleStableList_All or false == Panel_Window_SimpleStableList_All:GetShow() then
    return
  end
  if MessageBoxCheck.isCurrentOpen(self._currentTitle) then
    messageBoxCheck_CancelButtonUp()
  end
  PaGlobal_ServantTransferBackwardList_All:close()
end
function PaGlobal_ServantTransferBackwardList_All:close()
  if nil == Panel_Window_SimpleStableList_All or false == Panel_Window_SimpleStableList_All:GetShow() then
    return
  end
  Panel_Window_SimpleStableList_All:SetShow(false)
end
