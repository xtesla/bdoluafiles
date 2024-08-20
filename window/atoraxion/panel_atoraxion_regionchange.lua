PaGlobal_Atoraxion_RegionChange = {
  _ui = {_txt_RegionName = nil},
  _initialize = false,
  _currentTime = 0,
  _endTime = 5
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Atoraxion_RegionChange_Init")
function FromClient_Atoraxion_RegionChange_Init()
  PaGlobal_Atoraxion_RegionChange:initialize()
end
function PaGlobal_Atoraxion_RegionChange:initialize()
  if true == PaGlobal_Atoraxion_RegionChange._initialize or nil == Panel_Atoraxion_RegionChange then
    return
  end
  local bg = UI.getChildControl(Panel_Atoraxion_RegionChange, "Static_BG")
  self._ui._txt_RegionName = UI.getChildControl(bg, "StaticText_RegionName")
  self._ui._txt_RegionName:isValidate()
  Panel_Atoraxion_RegionChange:RegisterShowEventFunc(true, "PaGlobalFunc_Atoraxion_RegionChange_ShowAni()")
  Panel_Atoraxion_RegionChange:RegisterShowEventFunc(false, "PaGlobalFunc_Atoraxion_RegionChange_HideAni()")
  self._initialize = true
end
function PaGlobal_Atoraxion_RegionChange:prepareOpen()
  self._currentTime = 0
  Panel_Atoraxion_RegionChange:RegisterUpdateFunc("FromClient_Atoraxion_RegionChange_UpdatePerFrame")
  Panel_Atoraxion_RegionChange:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  Panel_Atoraxion_RegionChange:ComputePosAllChild()
  PaGlobal_Atoraxion_RegionChange:open()
end
function PaGlobal_Atoraxion_RegionChange:open()
  Panel_Atoraxion_RegionChange:SetShow(true, true)
end
function PaGlobal_Atoraxion_RegionChange:prepareClose()
  Panel_Atoraxion_RegionChange:ClearUpdateLuaFunc()
  PaGlobal_Atoraxion_RegionChange:close()
end
function PaGlobal_Atoraxion_RegionChange:close()
  Panel_Atoraxion_RegionChange:SetShow(false, true)
end
function PaGlobalFunc_Atoraxion_RegionChangeOpen()
  if nil == Panel_Atoraxion_RegionChange then
    return
  end
  PaGlobal_Atoraxion_RegionChange:prepareOpen()
end
function PaGlobalFunc_Atoraxion_RegionChange_ShowAni()
  UIAni.fadeInSCR_MidOut(Panel_Atoraxion_RegionChange)
  local aniInfo = Panel_Atoraxion_RegionChange:addColorAnimation(0, 1.05, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
end
function PaGlobalFunc_Atoraxion_RegionChange_HideAni()
  Panel_Atoraxion_RegionChange:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo6 = Panel_Atoraxion_RegionChange:addColorAnimation(0, 1.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo6:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo6:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo6.IsChangeChild = true
  aniInfo6:SetHideAtEnd(true)
  aniInfo6:SetDisableWhileAni(true)
end
function FromClient_Atoraxion_RegionChange_UpdatePerFrame(deltaTime)
  if nil == Panel_Atoraxion_RegionChange then
    return
  end
  PaGlobal_Atoraxion_RegionChange._currentTime = PaGlobal_Atoraxion_RegionChange._currentTime + deltaTime
  if PaGlobal_Atoraxion_RegionChange._endTime < PaGlobal_Atoraxion_RegionChange._currentTime then
    PaGlobal_Atoraxion_RegionChange:prepareClose()
  end
end
function FromClient_Atoraxion_RegionChange_Open(regionData)
  if nil == getSelfPlayer() or nil == Panel_Atoraxion_RegionChange then
    return false
  end
  if nil == regionData then
    return
  end
  if true == Panel_Atoraxion_RegionChange:GetShow() then
    PaGlobal_Atoraxion_RegionChange:prepareClose()
  end
  PaGlobal_Atoraxion_RegionChange._ui._txt_RegionName:SetText(regionData:getAreaName())
  PaGlobal_Atoraxion_RegionChange:prepareOpen()
end
