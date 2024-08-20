local UI_color = Defines.Color
Panel_Stamina:SetShow(false, false)
PaGlobal_Widget_Stamina = {
  _ui = {
    staticBar = nil,
    _bar_FullGauge = nil,
    _txt_StaminaMax = nil,
    _cannonDesc = nil
  },
  _isShowAutoRun = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Stamina_Init")
function FromClient_Stamina_Init()
  PaGlobal_Widget_Stamina:initialize()
  PaGlobal_Widget_Stamina:registEventHandler()
end
function PaGlobal_Widget_Stamina:initialize()
  self._ui.staticBar = UI.getChildControl(Panel_Stamina, "StaminaBar")
  self._ui._bar_FullGauge = UI.getChildControl(Panel_Stamina, "Static_FullGauge")
  self._ui._txt_StaminaMax = UI.getChildControl(Panel_Stamina, "StaticText_StaminaMax")
  self._ui._cannonDesc = UI.getChildControl(Panel_Stamina, "StaticText_CannonDesc")
  self._ui._checkAutoRun = UI.getChildControl(Panel_Stamina, "CheckButton_AutoRun")
  self._ui._checkAutoRun:SetShow(false)
end
function PaGlobal_Widget_Stamina:registEventHandler()
  Panel_Stamina:RegisterShowEventFunc(false, "Panel_Stamina_HideAni()")
  Panel_Stamina:RegisterUpdateFunc("Stamina_Update")
  registerEvent("EventStaminaUpdate", "Stamina_Update()")
  registerEvent("onScreenResize", "PaGlobal_Stamina_ResetPosition")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "PaGlobal_Stamina_ResetPosition")
  self._ui._checkAutoRun:addInputEvent("Mouse_LUp", "HandleEventLUp_StaminaAutoRun_AutoCheck()")
end
function Panel_Stamina_HideAni()
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Stamina, 0, 0.2)
  aniInfo:SetHideAtEnd(true)
end
local SpUseType = {
  Once = 0,
  Continue = 1,
  Recover = 2,
  Stop = 3,
  Reset = 4,
  None = 5
}
function Stamina_Update()
  local self = PaGlobal_Widget_Stamina
  local selfPlayerWrapper = getSelfPlayer()
  if nil ~= selfPlayerWrapper then
    local stamina = selfPlayerWrapper:get():getStamina()
    if nil ~= stamina then
      local sp = stamina:getSp()
      local maxSp = stamina:getMaxSp()
      local useType = stamina:getUseType()
      if Panel_Cannon_Value_IsCannon == true then
        self._ui._cannonDesc:SetShow(true)
      else
        self._ui._cannonDesc:SetShow(false)
      end
      if sp == maxSp and useType == SpUseType.Recover then
        self._ui._bar_FullGauge:SetShow(true)
        self._ui._bar_FullGauge:EraseAllEffect()
        local aniInfo1 = UIAni.AlphaAnimation(0, PaGlobal_Widget_Stamina._ui._checkAutoRun, 0, 0.2)
        aniInfo1:SetHideAtEnd(true)
        Panel_Stamina:SetShow(false, false)
        return
      end
      local spRate = sp / maxSp
      local alpha = (1 - spRate) * 15
      local fullGauge = spRate * 100
      if alpha > 1 then
        alpha = 1
      end
      Panel_Stamina:SetAlphaChild(alpha)
      self._ui.staticBar:SetProgressRate(fullGauge)
      self._ui._txt_StaminaMax:SetFontAlpha(alpha)
      self._ui._checkAutoRun:SetFontAlpha(alpha)
      self._ui._txt_StaminaMax:SetText(tostring(math.floor(spRate * 100)))
      local isDriver = selfPlayerWrapper:get():isVehicleDriver()
      if 0 ~= selfPlayerWrapper:getVariable("IsAutoRun") and false == isDriver then
        self._ui._checkAutoRun:SetShow(true)
        local savedAutoRunCheck = false
        if nil ~= ToClient_getGameUIManagerWrapper() then
          savedAutoRunCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eStaminaAutoRun)
        end
        self._ui._checkAutoRun:SetCheck(savedAutoRunCheck)
        ToClient_SetCanMoveFast(savedAutoRunCheck)
      elseif useType ~= SpUseType.Recover and useType ~= SpUseType.Stop then
        self._ui._checkAutoRun:SetShow(false)
      end
      Panel_Stamina:SetShow(true, false)
      local totalStamina = math.floor(spRate * 100)
    end
  end
end
function HandleEventLUp_StaminaAutoRun_AutoCheck()
  if nil == Panel_Stamina then
    return
  end
  local isChkAutoRun = PaGlobal_Widget_Stamina._ui._checkAutoRun:IsCheck()
  ToClient_SetCanMoveFast(isChkAutoRun)
  if nil ~= ToClient_getGameUIManagerWrapper() then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eStaminaAutoRun, isChkAutoRun, CppEnums.VariableStorageType.eVariableStorageType_Character)
  end
end
function PaGlobal_Stamina_ResetPosition()
  local scrX = getOriginScreenSizeX()
  local scrY = getOriginScreenSizeY()
  local relativePosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_Stamina, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
  local relativePosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_Stamina, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
  local initPosX = (scrX - Panel_Stamina:GetSizeX()) * 0.5
  local initPosY = scrY * 0.85
  if relativePosX == -1 and relativePosY == -1 then
    local haveServerPosotion = 0 < ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_Stamina, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved)
    if not haveServerPosotion then
      Panel_Stamina:SetPosX(initPosX)
      Panel_Stamina:SetPosY(initPosY)
    end
    changePositionBySever(Panel_Stamina, CppEnums.PAGameUIType.PAGameUIPanel_Stamina, true, true, false)
    FGlobal_InitPanelRelativePos(Panel_Stamina, initPosX, initPosY)
  elseif relativePosX == 0 and relativePosY == 0 then
    Panel_Stamina:SetPosX(initPosX)
    Panel_Stamina:SetPosY(initPosY)
  else
    Panel_Stamina:SetRelativePosX(relativePosX)
    Panel_Stamina:SetRelativePosY(relativePosY)
    Panel_Stamina:SetPosX(getOriginScreenSizeX() * relativePosX - Panel_Stamina:GetSizeX() * 0.5)
    Panel_Stamina:SetPosY(getOriginScreenSizeY() * relativePosY - Panel_Stamina:GetSizeY() * 0.5)
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_Stamina)
end
