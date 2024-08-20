function PaGlobal_Servant_FantasySelect_All:initialize()
  if nil == Panel_Dialog_Servant_FantasySelect_All or true == self._initailize then
    return
  end
  self._ui._stc_Title = UI.getChildControl(Panel_Dialog_Servant_FantasySelect_All, "Static_Title")
  self._ui._txt_Title = UI.getChildControl(self._ui._stc_Title, "StaticText_Title")
  self._ui._btn_Question = UI.getChildControl(self._ui._stc_Title, "Button_Question")
  self._ui._btn_Close = UI.getChildControl(self._ui._stc_Title, "Button_Close")
  self._ui._stc_Bg = UI.getChildControl(Panel_Dialog_Servant_FantasySelect_All, "Static_Bg")
  self._ui._btn_Select = UI.getChildControl(Panel_Dialog_Servant_FantasySelect_All, "Button_Exchange")
  self._ui._btn_Cancel = UI.getChildControl(Panel_Dialog_Servant_FantasySelect_All, "Button_Cancel")
  self._ui._list2_Servant = UI.getChildControl(Panel_Dialog_Servant_FantasySelect_All, "List2_Servant")
  self._ui._list2_Content = UI.getChildControl(self._ui._list2_Servant, "List2_1_Content")
  self._ui._list2_Btn_List = UI.getChildControl(self._ui._list2_Content, "Button_List")
  self._ui._list2_Image = UI.getChildControl(self._ui._list2_Content, "Static_Image")
  self._ui._list2_GenderIcon = UI.getChildControl(self._ui._list2_Content, "Static_GenderIcon")
  self._ui._list2_ServantName = UI.getChildControl(self._ui._list2_Content, "StaticText_ServantName")
  self._ui._txt_NoHorse = UI.getChildControl(self._ui._list2_Servant, "StaticText_NoHorse")
  self._ui._stc_Bottom_KeyGuide = UI.getChildControl(Panel_Dialog_Servant_FantasySelect_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_KeyGuide_Y = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_Y_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_B_ConsoleUI")
  self:validate()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:isConsoleUI(self._isConsole)
  self:registerEventHandler(self._isConsole)
  self._initialize = true
end
function PaGlobal_Servant_FantasySelect_All:registerEventHandler(isConsole)
  registerEvent("onScreenResize", "FromClient_Servant_FantasySelect_All_OnScreenResize")
  self._ui._list2_Servant:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_Servant_FantasySelect_All_List2Update")
  self._ui._list2_Servant:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_Select:addInputEvent("Mouse_LUp", "HandleEventLUp_Servant_FantasySelect_All_Confirm()")
  self._ui._btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_Servant_FantasySelect_All_Close()")
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Servant_FantasySelect_All_Close()")
  self._ui._btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowStableShop\" )")
  if true == isConsole then
    Panel_Dialog_Servant_FantasySelect_All:ignorePadSnapMoveToOtherPanel()
  end
end
function PaGlobal_Servant_FantasySelect_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_Servant_FantasySelect_All or false == self._initailize then
    return
  end
  Panel_Dialog_Servant_FantasySelect_All:SetDragEnable(not isConsole)
  Panel_Dialog_Servant_FantasySelect_All:SetDragAll(not isConsole)
  self._ui._btn_Question:SetShow(not isConsole and false == _ContentsOption_CH_WepHelperControl)
  self._ui._stc_Bottom_KeyGuide:SetShow(isConsole)
  self._ui._stc_KeyGuide_Y:SetShow(isConsole)
  self._ui._stc_KeyGuide_A:SetShow(isConsole)
  self._ui._stc_KeyGuide_B:SetShow(isConsole)
  if true == isConsole then
    local keyguide = {
      self._ui._stc_KeyGuide_Y,
      self._ui._stc_KeyGuide_A,
      self._ui._stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui._stc_Bottom_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_Servant_FantasySelect_All:clear()
  self._selectServantData = nil
  self._isMale = false
end
function PaGlobal_Servant_FantasySelect_All:prepareOpen(isMale)
  if nil == Panel_Dialog_Servant_FantasySelect_All or true == Panel_Dialog_Servant_FantasySelect_All:GetShow() then
    return
  end
  if false == _ContentsGroup_ServantFantasyMix then
    return
  end
  self:clear()
  self:open()
  self:update(isMale)
end
function PaGlobal_Servant_FantasySelect_All:open()
  if nil == Panel_Dialog_Servant_FantasySelect_All or true == Panel_Dialog_Servant_FantasySelect_All:GetShow() then
    return
  end
  if false == _ContentsGroup_ServantFantasyMix then
    return
  end
  Panel_Dialog_Servant_FantasySelect_All:SetShow(true)
end
function PaGlobal_Servant_FantasySelect_All:prepareClose()
  if nil == Panel_Dialog_Servant_FantasySelect_All or false == Panel_Dialog_Servant_FantasySelect_All:GetShow() then
    return
  end
  self:clear()
  self:close()
  if true == self._isConsole then
    ToClient_padSnapSetTargetPanel(Panel_Dialog_ServantList_All)
  end
end
function PaGlobal_Servant_FantasySelect_All:close()
  if nil == Panel_Dialog_Servant_FantasySelect_All or false == Panel_Dialog_Servant_FantasySelect_All:GetShow() then
    return
  end
  Panel_Dialog_Servant_FantasySelect_All:SetShow(false)
end
function PaGlobal_Servant_FantasySelect_All:update(isMale)
  PaGlobal_Servant_FantasySelect_All:pushList2(isMale)
end
function PaGlobal_Servant_FantasySelect_All:pushList2(isMale)
  if nil == Panel_Dialog_Servant_FantasySelect_All or false == Panel_Dialog_Servant_FantasySelect_All:GetShow() then
    return
  end
  local servantCount = stable_count()
  if servantCount <= 0 then
    self._ui._txt_NoHorse:SetShow(true)
    self._ui._btn_Select:SetMonoTone(true, true)
    self._ui._btn_Select:SetIgnore(true)
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfPlayer:getPosition())
  if nil == regionInfo then
    return
  end
  local regionKey = regionInfo:getRegionKey()
  if nil == regionKey then
    return
  end
  self._isMale = isMale
  self._ui._txt_NoHorse:SetShow(false)
  self._servantDataTable = {}
  self._ui._list2_Servant:getElementManager():clearKey()
  for ii = 0, servantCount - 1 do
    local servantInfo = stable_getServant(ii)
    if nil ~= servantInfo and CppEnums.VehicleType.Type_Horse == servantInfo:getVehicleType() then
      local servantRegionKey = servantInfo:getRegionKeyRaw()
      if nil ~= servantRegionKey and regionKey == servantRegionKey and servantInfo:isMale() == self._isMale and 30 <= servantInfo:getLevel() and true == ToClient_isPossibleFantasyMix(ii) then
        local currentState = servantInfo:getStateType()
        if true == servantInfo:isSeized() or CppEnums.ServantStateType.Type_RegisterMarket == currentState or CppEnums.ServantStateType.Type_RegisterMating == currentState or CppEnums.ServantStateType.Type_Mating == currentState or servantInfo:isMatingComplete() or CppEnums.ServantStateType.Type_Coma == currentState or CppEnums.ServantStateType.Type_SkillTraining == currentState or CppEnums.ServantStateType.Type_Rent == currentState or CppEnums.ServantStateType.Type_Return == currentState or servantInfo:isLink() or Defines.s64_const.s64_0 < servantInfo:getRentOwnerNo() then
        else
          local servantData = {
            _servantNo = servantInfo:getServantNo(),
            _servantIndex = ii
          }
          self._servantDataTable[ii] = servantData
          self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, ii))
          if nil == self._selectServantData then
            self._selectServantData = servantData
          end
        end
      end
    end
  end
end
function PaGlobal_Servant_FantasySelect_All:list2Update(content, key)
  if nil == Panel_Dialog_Servant_FantasySelect_All or false == Panel_Dialog_Servant_FantasySelect_All:GetShow() then
    return
  end
  if nil == content or nil == key or nil == self._servantDataTable then
    return
  end
  local key32 = Int64toInt32(key)
  local btn_List = UI.getChildControl(content, "Button_List")
  local stc_Image = UI.getChildControl(content, "Static_Image")
  local stc_GenderIcon = UI.getChildControl(content, "Static_GenderIcon")
  local txt_ServantName = UI.getChildControl(content, "StaticText_ServantName")
  content:SetShow(false)
  if nil ~= self._servantDataTable[key32] then
    local servantIndex = self._servantDataTable[key32]._servantIndex
    local servantNo = self._servantDataTable[key32]._servnatNo
    local servantInfo = stable_getServant(servantIndex)
    if nil == servantInfo then
      return
    end
    content:SetShow(true)
    local isMale = servantInfo:isMale()
    local name = servantInfo:getName()
    local level = servantInfo:getLevel()
    if nil ~= name then
      txt_ServantName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. level .. " " .. name)
    end
    local iconPath = servantInfo:getIconPath1()
    if nil ~= iconPath then
      stc_Image:ChangeTextureInfoName(iconPath)
    end
    stc_GenderIcon:SetShow(false)
    if true == servantInfo:isDisplayGender() then
      stc_GenderIcon:SetShow(true)
      stc_GenderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
      local x1, y1, x2, y2 = 0, 0, 0, 0
      if true == isMale then
        x1, y1, x2, y2 = setTextureUV_Func(stc_GenderIcon, 1, 209, 31, 239)
      else
        x1, y1, x2, y2 = setTextureUV_Func(stc_GenderIcon, 1, 178, 31, 208)
      end
      stc_GenderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      stc_GenderIcon:setRenderTexture(stc_GenderIcon:getBaseTexture())
    end
    btn_List:addInputEvent("Mouse_LUp", "HandleEventLUp_Servant_FantasySelect_All_SelectServantData(" .. key32 .. ")")
    if nil ~= self._selectServantData and self._selectServantData._servantIndex == servantIndex then
      btn_List:SetCheck(true)
    else
      btn_List:SetCheck(false)
    end
  end
end
function PaGlobal_Servant_FantasySelect_All:validate()
  if nil == Panel_Dialog_Servant_FantasySelect_All then
    return
  end
  self._ui._stc_Title:isValidate()
  self._ui._txt_Title:isValidate()
  self._ui._btn_Question:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._stc_Bg:isValidate()
  self._ui._btn_Select:isValidate()
  self._ui._btn_Cancel:isValidate()
  self._ui._list2_Servant:isValidate()
  self._ui._list2_Content:isValidate()
  self._ui._list2_Btn_List:isValidate()
  self._ui._list2_Image:isValidate()
  self._ui._list2_GenderIcon:isValidate()
  self._ui._list2_ServantName:isValidate()
  self._ui._txt_NoHorse:isValidate()
  self._ui._stc_Bottom_KeyGuide:isValidate()
  self._ui._stc_KeyGuide_Y:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
end
