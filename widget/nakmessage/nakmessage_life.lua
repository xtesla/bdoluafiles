PaGlobal_NakMessage_Life = {
  _ui = {
    stc_basic = nil,
    stc_LifeType_Icons = {},
    txt_basic_desc = nil,
    stc_master = nil,
    stc_lifeType_BG = nil,
    txt_master_desc = nil
  },
  _animationEndTime = 8.5,
  _currentTime = 0,
  _lifeTypeMax = 11,
  _initialize = false
}
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local positionAdjust = {_originX = 0, _originY = 180}
local _targetPosX, _targetPosY
local _defaultXSize = Panel_NakMessage_Life:GetSizeX()
local _defaultYSize = Panel_NakMessage_Life:GetSizeY()
function PaGlobal_NakMessage_Life:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_basic = UI.getChildControl(Panel_NakMessage_Life, "Static_Basic")
  for idx = 0, self._lifeTypeMax do
    self._ui.stc_LifeType_Icons[idx] = UI.getChildControl(self._ui.stc_basic, "Static_LifeType_Icon_" .. tostring(idx))
  end
  self._ui.txt_basic_desc = UI.getChildControl(self._ui.stc_basic, "StaticText_Desc")
  self._ui.stc_master = UI.getChildControl(Panel_NakMessage_Life, "Static_Master")
  local masterDescBG = UI.getChildControl(self._ui.stc_master, "Static_Desc_BG")
  self._ui.txt_master_desc = UI.getChildControl(masterDescBG, "StaticText_Desc_1")
  self._ui.stc_lifeType_BG = UI.getChildControl(self._ui.stc_master, "Static_LifeType_BG")
  Panel_NakMessage_Life:SetIgnore(true)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_NakMessage_Life:registEventHandler()
  registerEvent("onScreenResize", "NakLifeMessagePanel_Resize")
  registerEvent("FromClient_LifeGradeUP", "FromClient_ShowNakLife_LifeGradeUP")
end
function PaGlobal_NakMessage_Life:validate()
  self._ui.stc_basic:isValidate()
  for idx = 0, self._lifeTypeMax do
    if nil ~= self._ui.stc_LifeType_Icons[idx] then
      self._ui.stc_LifeType_Icons[idx]:isValidate()
    end
  end
  self._ui.txt_basic_desc:isValidate()
  self._ui.stc_master:isValidate()
  self._ui.txt_master_desc:isValidate()
  self._ui.stc_lifeType_BG:isValidate()
end
function PaGlobal_NakMessage_Life:showLifeNak_OverArtisan(lifeType, lifeGrade)
  self._ui.stc_basic:SetShow(false)
  self._ui.stc_master:SetShow(true)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfPlayerActorProxyWrapper = selfPlayer:get()
  if nil == selfPlayerActorProxyWrapper then
    return
  end
  local characterName = selfPlayer:getName()
  local lifeTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE" .. tostring(lifeType))
  if "" == lifeTypeString then
    return
  end
  local gradeStirng = PAGetString(Defines.StringSheet_GAME, "LUA_LIFELEVEL_GROUP_" .. tostring(lifeGrade))
  if "" == gradeStirng then
    return
  end
  local descStr = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_NAK_LIFELVUP_BASIC", "Name", characterName, "lifetype", lifeTypeString, "grade", gradeStirng)
  self._ui.txt_master_desc:SetText(descStr)
  _AudioPostEvent_SystemUiForXBOX(3, 26)
  audioPostEvent_SystemUi(3, 26)
  self._ui.stc_lifeType_BG:AddEffect("fUI_NakMessage_01A", false, 0, 0)
  Panel_NakMessage_Life:SetShow(true)
  self:startAnim()
end
function PaGlobal_NakMessage_Life:showLifeNak_Basic(lifeType, lifeGrade)
  self._ui.stc_basic:SetShow(true)
  self._ui.stc_master:SetShow(false)
  for idx = 0, self._lifeTypeMax do
    if nil ~= self._ui.stc_LifeType_Icons[idx] then
      if lifeType == idx then
        self._ui.stc_LifeType_Icons[idx]:SetShow(true)
      else
        self._ui.stc_LifeType_Icons[idx]:SetShow(false)
      end
    end
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfPlayerActorProxyWrapper = selfPlayer:get()
  if nil == selfPlayerActorProxyWrapper then
    return
  end
  local characterName = selfPlayer:getName()
  local lifeTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE" .. tostring(lifeType))
  if "" == lifeTypeString then
    return
  end
  local gradeStirng = PAGetString(Defines.StringSheet_GAME, "LUA_LIFELEVEL_GROUP_" .. tostring(lifeGrade))
  if "" == gradeStirng then
    return
  end
  local descStr = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_NAK_LIFELVUP_BASIC", "Name", characterName, "lifetype", lifeTypeString, "grade", gradeStirng)
  self._ui.txt_basic_desc:SetText(descStr)
  _AudioPostEvent_SystemUiForXBOX(3, 25)
  audioPostEvent_SystemUi(3, 25)
  self._ui.stc_basic:AddEffect("fUI_NakMessage_02A", false, 0, 0)
  Panel_NakMessage_Life:SetShow(true)
  self:startAnim()
end
function PaGlobal_NakMessage_Life:startAnim()
  self._currentTime = 0
  Panel_NakMessage_Life:ResetAndClearVertexAni()
  local hideStartTime = 8
  local hideToShowTime = 0.7
  local aniInfo = Panel_NakMessage_Life:addColorAnimation(0, hideToShowTime, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
  local aniInfo2 = Panel_NakMessage_Life:addColorAnimation(hideStartTime, PaGlobal_NakMessage_Life._animationEndTime, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo2:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo2.IsChangeChild = true
  Panel_NakMessage_Life:RegisterUpdateFunc("FromClient_ShowNakLife_Update")
end
function NakLifeMessagePanel_Resize()
  if nil == Panel_NakMessage_Life then
    return
  end
  local val = (getOriginScreenSizeX() - Panel_NakMessage_Life:GetSizeX()) * 0.5
  Panel_NakMessage_Life:SetPosX(val)
end
function FromClient_ShowNakLife_LifeGradeUP(lifeType, lifeGrade)
  if false == _ContentsGroup_RenewalLifeGradeUpUI then
    return
  end
  if nil == Panel_NakMessage_Life then
    return
  end
  if __eLifeGrade_Master == lifeGrade or __eLifeGrade_GURU == lifeGrade then
    PaGlobal_NakMessage_Life:showLifeNak_OverArtisan(lifeType, lifeGrade)
  else
    PaGlobal_NakMessage_Life:showLifeNak_Basic(lifeType, lifeGrade)
  end
end
function FromClient_ShowNakLife_Update(deltatime)
  if nil == Panel_NakMessage_Life then
    return
  end
  PaGlobal_NakMessage_Life._currentTime = PaGlobal_NakMessage_Life._currentTime + deltatime
  if PaGlobal_NakMessage_Life._animationEndTime < PaGlobal_NakMessage_Life._currentTime then
    Panel_NakMessage_Life:SetShow(false)
    Panel_NakMessage_Life:ClearUpdateLuaFunc()
  end
end
NakLifeMessagePanel_Resize()
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_NakMessage_Life_Init")
function FromClient_PaGlobal_NakMessage_Life_Init()
  PaGlobal_NakMessage_Life:initialize()
end
