local IM = CppEnums.EProcessorInputMode
Panel_AutoTraining:SetShow(false)
local isAutoTrainingEnable = ToClient_IsContentsGroupOpen("57")
Panel_AutoTraining:RegisterShowEventFunc(true, "AutoPlayShowAni()")
Panel_AutoTraining:RegisterShowEventFunc(false, "AutoPlayHideAni()")
PaGlobal_AutoPlay = {
  _ui = {
    _originalBG = nil,
    _originalIcon = nil,
    _originalText = nil,
    _newBG = nil,
    _newIcon = nil,
    _newText = nil
  },
  _autoTrain = false,
  _initailize = false
}
function AutoPlayShowAni()
  local ImageMoveAni = Panel_AutoTraining:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(getOriginScreenSizeX() / 2 - Panel_AutoTraining:GetSizeX() / 2, 0 - Panel_AutoTraining:GetSizeY())
  ImageMoveAni:SetEndPosition(getOriginScreenSizeX() / 2 - Panel_AutoTraining:GetSizeX() / 2, getOriginScreenSizeY() - getOriginScreenSizeY() / 1.5 - Panel_AutoTraining:GetSizeY())
  ImageMoveAni.IsChangeChild = true
  Panel_AutoTraining:CalcUIAniPos(ImageMoveAni)
  ImageMoveAni:SetDisableWhileAni(true)
  PAGlobal_AutoTraining_Alarm_OnAutoTrainingStart()
end
function AutoPlayHideAni()
  local ImageMoveAni = Panel_AutoTraining:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(getOriginScreenSizeX() / 2 - Panel_AutoTraining:GetSizeX() / 2, getOriginScreenSizeY() - getOriginScreenSizeY() / 1.5 - Panel_AutoTraining:GetSizeY())
  ImageMoveAni:SetEndPosition(getOriginScreenSizeX() / 2 - Panel_AutoTraining:GetSizeX() / 2, 0 - Panel_AutoTraining:GetSizeY())
  ImageMoveAni.IsChangeChild = true
  Panel_AutoTraining:CalcUIAniPos(ImageMoveAni)
  ImageMoveAni:SetDisableWhileAni(true)
  ImageMoveAni:SetHideAtEnd(true)
  ImageMoveAni:SetDisableWhileAni(true)
  PAGlobal_AutoTraining_Alarm_OnAutoTrainingEnd()
end
function PaGlobal_AutoPlay:initialize()
  if false == ToClient_IsContentsGroupOpen("57") then
    return
  end
  if nil == Panel_AutoTraining or true == self._initailize then
    return
  end
  self._ui._originalBG = UI.getChildControl(Panel_AutoTraining, "Static_OriginalBG")
  self._ui._originalIcon = UI.getChildControl(self._ui._originalBG, "Static_AutoPlay")
  self._ui._originalText = UI.getChildControl(self._ui._originalBG, "StaticText_AutoPlay")
  self._ui._newBG = UI.getChildControl(Panel_AutoTraining, "Static_NewBG")
  self._ui._newIcon = UI.getChildControl(self._ui._newBG, "Static_AutoPlay")
  self._ui._newText = UI.getChildControl(self._ui._newBG, "StaticText_AutoPlay")
  self:validate()
  self:controlInit()
  self:registerEventHandler()
  self._initialize = true
  self._autoTrain = ToClient_IsAutoLevelUp()
  if true == self._autoTrain then
    PaGlobal_AutoPlay:prepareOpen()
  end
end
function PaGlobal_AutoPlay:registerEventHandler()
  registerEvent("onScreenResize", "FromClient_AutoTraining2_OnScreenResize")
  registerEvent("FromClient_CantIncreaseExpWithAutoLevelUp", "FromClient_CantIncreaseExpWithAutoLevelUp")
  registerEvent("FromClient_SetAutoLevelUp", "FromClient_SetAutoLevelUp")
end
function PaGlobal_AutoPlay:controlInit()
  self._ui._originalBG:SetShow(not _ContentsGroup_AutoLifeLevelUp)
  self._ui._newBG:SetShow(_ContentsGroup_AutoLifeLevelUp)
  if false == _ContentsGroup_AutoLifeLevelUp then
    self._ui._originalText:SetTextMode(__eTextMode_AutoWrap)
    self._ui._originalText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_AUTOPLAY_PLAYEND"))
  else
    self._ui._newText:SetTextMode(__eTextMode_AutoWrap)
  end
end
function PaGlobal_AutoPlay:prepareOpen()
  if nil == Panel_AutoTraining or true == Panel_AutoTraining:GetShow() then
    return
  end
  if false == _ContentsGroup_AutoLifeLevelUp then
    self._ui._originalIcon:SetVertexAniRun("Ani_Rotate_New", true)
  else
    self:SetAutoLevelUpUI()
  end
  self:open()
end
function PaGlobal_AutoPlay:open()
  if nil == Panel_AutoTraining then
    return
  end
  Panel_AutoTraining:SetShow(true, true)
end
function PaGlobal_AutoPlay:prepareClose()
  if nil == Panel_AutoTraining or false == Panel_AutoTraining:GetShow() then
    return
  end
  self:close()
end
function PaGlobal_AutoPlay:close()
  if nil == Panel_AutoTraining then
    return
  end
  Panel_AutoTraining:SetShow(false, true)
end
function PaGlobal_AutoPlay:SetAutoLevelUpUI()
  if false == _ContentsGroup_AutoLifeLevelUp then
    return
  end
  self._ui._newBG:SetShow(true)
  self._ui._newBG:ChangeTextureInfoName("Combine/Etc/Combine_Etc_BookofLife.dds")
  self._ui._newIcon:ChangeTextureInfoName("Combine/Etc/Combine_Etc_BookofLife.dds")
  local x1, y1, x2, y2 = 0, 0, 0, 0
  local x3, y3, x4, y4 = 0, 0, 0, 0
  local showDesc
  local trainingType = ToClient_getBlackSpiritTrainingType()
  if __eBlackSpiritTrainingType_LevelAndSkillType == trainingType then
    x1, y1, x2, y2 = setTextureUV_Func(self._ui._newBG, 1, 1, 607, 203)
    x3, y3, x4, y4 = setTextureUV_Func(self._ui._newIcon, 608, 1, 698, 91)
    showDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AUTOTRAINING_LEVEL")
  elseif __eBlackSpiritTrainingType_LifType2 == trainingType then
    x1, y1, x2, y2 = setTextureUV_Func(self._ui._newBG, 1, 204, 607, 406)
    x3, y3, x4, y4 = setTextureUV_Func(self._ui._newIcon, 608, 92, 698, 182)
    showDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AUTOTRAINING_HUNTING")
  elseif __eBlackSpiritTrainingType_LifType0 == trainingType then
    x1, y1, x2, y2 = setTextureUV_Func(self._ui._newBG, 1, 407, 607, 609)
    x3, y3, x4, y4 = setTextureUV_Func(self._ui._newIcon, 608, 183, 698, 273)
    showDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AUTOTRAINING_MINING")
  elseif __eBlackSpiritTrainingType_LifType9 == trainingType then
    x1, y1, x2, y2 = setTextureUV_Func(self._ui._newBG, 1, 610, 607, 812)
    x3, y3, x4, y4 = setTextureUV_Func(self._ui._newIcon, 608, 274, 698, 364)
    showDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AUTOTRAINING_SAILING")
  else
    self._ui._newBG:SetShow(false)
    return
  end
  self._ui._newBG:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._newBG:setRenderTexture(self._ui._newBG:getBaseTexture())
  self._ui._newIcon:getBaseTexture():setUV(x3, y3, x4, y4)
  self._ui._newIcon:setRenderTexture(self._ui._newIcon:getBaseTexture())
  if nil ~= showDesc then
    self._ui._newText:SetText(showDesc)
  end
  Panel_AutoTraining:ComputePosAllChild()
  self._ui._newIcon:SetVertexAniRun("Ani_Rotate_New", true)
end
function PaGlobal_AutoPlay:validate()
  if nil == Panel_AutoTraining then
    return
  end
  self._ui._originalBG:isValidate()
  self._ui._originalIcon:isValidate()
  self._ui._originalText:isValidate()
  self._ui._newBG:isValidate()
  self._ui._newIcon:isValidate()
  self._ui._newText:isValidate()
end
function FromClient_CantIncreaseExpWithAutoLevelUp()
end
function FromClient_SetAutoLevelUp(isAuto)
  if nil == isAuto then
    return
  end
  PaGlobal_AutoPlay._autoTrain = isAuto
  if true == isAuto then
    PaGlobal_AutoPlay:prepareOpen()
  else
    PaGlobal_AutoPlay:prepareClose()
  end
end
function FromClient_AutoTraining2_OnScreenResize()
  if nil == Panel_AutoTraining then
    return
  end
  Panel_AutoTraining:ComputePos()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_AutoTraining2_luaLoadComplete")
function FromClient_AutoTraining2_luaLoadComplete()
  PaGlobal_AutoPlay:initialize()
end
