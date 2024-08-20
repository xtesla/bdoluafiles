PaGlobal_SeasonUiSelect_All = {
  _ui = {
    stc_titleBG = nil,
    btn_close = nil,
    stc_mainBG = nil,
    stc_imageList = {},
    stc_radioList = {},
    stc_bottomDesc = nil,
    txt_bottomDesc = nil,
    stc_bottomBG = nil,
    btn_apply = nil,
    stc_keyGuideBG = nil,
    stc_keyGuideA = nil,
    stc_keyGuideB = nil,
    stc_keyGuideY = nil,
    stc_keyGuideLTY = nil
  },
  _seasonUiType = {CLASSIC = 0, SEASON = 1},
  _defaultType = 0,
  _selectType = 0,
  _isDefaultType = true,
  _isLowLevel = false,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_SeasonUiSelect_All_Init")
function FromClient_SeasonUiSelect_All_Init()
  PaGlobal_SeasonUiSelect_All:initialize()
end
function PaGlobal_SeasonUiSelect_All:initialize()
  if true == PaGlobal_SeasonUiSelect_All._initialize or nil == Panel_Window_SeasonUiSelect_All then
    return
  end
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_SeasonUiSelect_All, "Static_TitleArea")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Close")
  self._ui.stc_mainBG = UI.getChildControl(Panel_Window_SeasonUiSelect_All, "Static_MainAreaBG")
  self._ui.stc_imageList[self._seasonUiType.CLASSIC] = UI.getChildControl(self._ui.stc_mainBG, "Static_Image_Classic")
  self._ui.stc_imageList[self._seasonUiType.SEASON] = UI.getChildControl(self._ui.stc_mainBG, "Static_Image_Season")
  self._ui.stc_radioList[self._seasonUiType.CLASSIC] = UI.getChildControl(self._ui.stc_mainBG, "RadioButton_Classic")
  self._ui.stc_radioList[self._seasonUiType.SEASON] = UI.getChildControl(self._ui.stc_mainBG, "RadioButton_Season")
  self._ui.stc_bottomDesc = UI.getChildControl(Panel_Window_SeasonUiSelect_All, "Static_BottomDescBG")
  self._ui.txt_bottomDesc = UI.getChildControl(self._ui.stc_bottomDesc, "StaticText_Desc")
  self._ui.stc_bottomBG = UI.getChildControl(Panel_Window_SeasonUiSelect_All, "Static_BottomAreaBG")
  self._ui.btn_apply = UI.getChildControl(self._ui.stc_bottomBG, "Button_Apply")
  self._ui.stc_keyGuideBG = UI.getChildControl(Panel_Window_SeasonUiSelect_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui.stc_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_B_ConsoleUI")
  self._ui.stc_keyGuideY = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_Y")
  local keyguide = {
    self._ui.stc_keyGuideY,
    self._ui.stc_keyGuideA,
    self._ui.stc_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_SeasonUiSelect_All:validate()
  PaGlobal_SeasonUiSelect_All:registEventHandler()
  PaGlobal_SeasonUiSelect_All:swichPlatform(self._isConsole)
  PaGlobal_SeasonUiSelect_All._initialize = true
  PaGlobalFunc_SeasonUiSelect_All_OpenCheck()
end
function PaGlobal_SeasonUiSelect_All:swichPlatform(isConsole)
  if true == self._isConsole then
    self._ui.btn_close:SetShow(false)
    self._ui.btn_apply:SetShow(false)
    self._ui.stc_keyGuideBG:SetShow(true)
  else
    self._ui.btn_close:SetShow(true)
    self._ui.btn_apply:SetShow(true)
    self._ui.stc_keyGuideBG:SetShow(false)
  end
end
function PaGlobal_SeasonUiSelect_All:prepareOpen()
  if nil == Panel_Window_SeasonUiSelect_All then
    return
  end
  HandleEventLUp_SeasonUiSelect_All_SelectType(self._defaultType)
  PaGlobal_SeasonUiSelect_All:open()
  PaGlobal_SeasonUiSelect_All:update()
  PaGlobal_SeasonUiSelect_All:resize()
end
function PaGlobal_SeasonUiSelect_All:dataclear()
end
function PaGlobal_SeasonUiSelect_All:open()
  if nil == Panel_Window_SeasonUiSelect_All then
    return
  end
  Panel_Window_SeasonUiSelect_All:SetShow(true)
end
function PaGlobal_SeasonUiSelect_All:prepareClose()
  if nil == Panel_Window_SeasonUiSelect_All then
    return
  end
  PaGlobal_SeasonUiSelect_All:close()
end
function PaGlobal_SeasonUiSelect_All:close()
  if nil == Panel_Window_SeasonUiSelect_All then
    return
  end
  Panel_Window_SeasonUiSelect_All:SetShow(false)
end
function PaGlobal_SeasonUiSelect_All:update()
end
function PaGlobal_SeasonUiSelect_All:registEventHandler()
  if nil == Panel_Window_SeasonUiSelect_All then
    return
  end
  registerEvent("EventSelfPlayerLevelUp", "FromClient_SeasonUiSelect_EventSelfPlayerLevelUp")
  self._ui.stc_imageList[self._seasonUiType.CLASSIC]:addInputEvent("Mouse_LUp", "HandleEventLUp_SeasonUiSelect_All_SelectType(" .. self._seasonUiType.CLASSIC .. ")")
  self._ui.stc_imageList[self._seasonUiType.SEASON]:addInputEvent("Mouse_LUp", "HandleEventLUp_SeasonUiSelect_All_SelectType(" .. self._seasonUiType.SEASON .. ")")
  self._ui.stc_radioList[self._seasonUiType.CLASSIC]:addInputEvent("Mouse_LUp", "HandleEventLUp_SeasonUiSelect_All_SelectType(" .. self._seasonUiType.CLASSIC .. ")")
  self._ui.stc_radioList[self._seasonUiType.SEASON]:addInputEvent("Mouse_LUp", "HandleEventLUp_SeasonUiSelect_All_SelectType(" .. self._seasonUiType.SEASON .. ")")
  if false == self._isConsole then
    self._ui.btn_apply:addInputEvent("Mouse_LUp", "HandleEventLUp_SeasonUiSelect_All_Apply()")
    self._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_SeasonUiSelect_All_Close()")
  else
    Panel_Window_SeasonUiSelect_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventLUp_SeasonUiSelect_All_Apply()")
  end
end
function PaGlobal_SeasonUiSelect_All:validate()
  if nil == Panel_Window_SeasonUiSelect_All then
    return
  end
  self._ui.stc_titleBG:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_mainBG:isValidate()
  self._ui.stc_imageList[self._seasonUiType.CLASSIC]:isValidate()
  self._ui.stc_imageList[self._seasonUiType.SEASON]:isValidate()
  self._ui.stc_radioList[self._seasonUiType.CLASSIC]:isValidate()
  self._ui.stc_radioList[self._seasonUiType.SEASON]:isValidate()
  self._ui.stc_bottomDesc:isValidate()
  self._ui.txt_bottomDesc:isValidate()
  self._ui.stc_bottomBG:isValidate()
  self._ui.btn_apply:isValidate()
  self._ui.stc_keyGuideBG:isValidate()
  self._ui.stc_keyGuideA:isValidate()
  self._ui.stc_keyGuideB:isValidate()
  self._ui.stc_keyGuideY:isValidate()
end
function PaGlobal_SeasonUiSelect_All:resize()
  if nil == Panel_Window_SeasonUiSelect_All then
    return
  end
  Panel_Window_SeasonUiSelect_All:ComputePos()
end
function PaGlobalFunc_SeasonUiSelect_All_Open()
  PaGlobal_SeasonUiSelect_All:prepareOpen()
end
function PaGlobalFunc_SeasonUiSelect_All_Close()
  PaGlobal_SeasonUiSelect_All:prepareClose()
end
function PaGlobalFunc_SeasonUiSelect_All_OpenCheck()
  if false == PaGlobalFunc_SeasonUiSelect_OpenLevelCheck() then
    PaGlobal_SeasonUiSelect_All._isLowLevel = true
    return
  end
  local isExistCacheData = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSeasonUiTypeSet)
  if false == isExistCacheData then
    local gameOptionSetting = ToClient_getGameOptionControllerWrapper()
    if nil ~= gameOptionSetting and false == gameOptionSetting:getSeasonUiType() then
      PaGlobalFunc_SeasonUiSelect_All_Open()
    end
  end
end
function PaGlobalFunc_SeasonUiSelect_OpenLevelCheck()
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    local curLevel = selfPlayer:get():getLevel()
    if curLevel >= _ContentsUiCheck_SeasonUiSelectOpenLevel then
      return true
    end
  end
  return false
end
function PaGlobalFunc_SeasonUiSelect_All_ResetCache()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSeasonUiTypeSet, false, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function HandleEventLUp_SeasonUiSelect_All_Close()
  PaGlobalFunc_SeasonUiSelect_All_Close()
end
function HandleEventLUp_SeasonUiSelect_All_SelectType(selectType)
  if nil == selectType then
    selectType = PaGlobal_SeasonUiSelect_All._defaultType
  end
  PaGlobal_SeasonUiSelect_All._selectType = selectType
  PaGlobal_SeasonUiSelect_All._ui.stc_radioList[PaGlobal_SeasonUiSelect_All._seasonUiType.CLASSIC]:SetCheck(PaGlobal_SeasonUiSelect_All._seasonUiType.CLASSIC == PaGlobal_SeasonUiSelect_All._selectType)
  PaGlobal_SeasonUiSelect_All._ui.stc_radioList[PaGlobal_SeasonUiSelect_All._seasonUiType.SEASON]:SetCheck(PaGlobal_SeasonUiSelect_All._seasonUiType.SEASON == PaGlobal_SeasonUiSelect_All._selectType)
end
function HandleEventLUp_SeasonUiSelect_All_Apply()
  local isSeasonSet = false
  if PaGlobal_SeasonUiSelect_All._selectType == PaGlobal_SeasonUiSelect_All._seasonUiType.CLASSIC then
    isSeasonSet = false
  elseif PaGlobal_SeasonUiSelect_All._selectType == PaGlobal_SeasonUiSelect_All._seasonUiType.SEASON then
    isSeasonSet = true
  end
  if true == isSeasonSet then
    setSeasonUiType(isSeasonSet)
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSeasonUiTypeSet, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  PaGlobalFunc_SeasonUiSelect_All_Close()
end
function FromClient_SeasonUiSelect_EventSelfPlayerLevelUp()
  if false == PaGlobal_SeasonUiSelect_All._isLowLevel then
    return
  end
  if true == PaGlobalFunc_SeasonUiSelect_OpenLevelCheck() then
    PaGlobalFunc_SeasonUiSelect_All_OpenCheck()
    PaGlobal_SeasonUiSelect_All._isLowLevel = false
  end
end
