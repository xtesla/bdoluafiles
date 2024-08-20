PaGlobal_Atoraxion_NakClear = {
  _ui = {
    txtDesc1 = nil,
    txtDesc2 = nil,
    txtDesc3 = nil
  },
  _initialize = false,
  _currentTime = 0,
  _endTime = 5
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Atoraxion_NakClear_Init")
function FromClient_Atoraxion_NakClear_Init()
  PaGlobal_Atoraxion_NakClear:initialize()
end
function PaGlobal_Atoraxion_NakClear:initialize()
  if true == PaGlobal_Atoraxion_NakClear._initialize or nil == Panel_Atoraxion_NakClear then
    return
  end
  local stcMainBg = UI.getChildControl(Panel_Atoraxion_NakClear, "Static_BossClear")
  local stcDescBg = UI.getChildControl(stcMainBg, "Static_Desc_BG")
  self._ui.txtDesc1 = UI.getChildControl(stcDescBg, "StaticText_Desc_1")
  self._ui.txtDesc2 = UI.getChildControl(stcDescBg, "StaticText_Desc_2")
  self._ui.txtDesc3 = UI.getChildControl(stcDescBg, "MultilineText_Desc_3")
  self._initialize = true
end
function PaGlobal_Atoraxion_NakClear:prepareOpen()
  self._currentTime = 0
  Panel_Atoraxion_NakClear:RegisterUpdateFunc("FromClient_Atoraxion_NakClear_UpdatePerFrame")
  Panel_Atoraxion_NakClear:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  Panel_Atoraxion_NakClear:ComputePosAllChild()
  PaGlobal_Atoraxion_NakClear:open()
end
function PaGlobal_Atoraxion_NakClear:open()
  Panel_Atoraxion_NakClear:SetShow(true)
end
function PaGlobal_Atoraxion_NakClear:prepareClose()
  Panel_Atoraxion_NakClear:ClearUpdateLuaFunc()
  PaGlobal_Atoraxion_NakClear:close()
end
function PaGlobal_Atoraxion_NakClear:close()
  Panel_Atoraxion_NakClear:SetShow(false)
end
function PaGlobal_Atoraxion_NakClear:changeNotiText()
  local fieldMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  if __eInstanceAtoraxion_Hadum == fieldMapKey or __eInstanceAtoraxion_Normal == fieldMapKey then
    self._ui.txtDesc1:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_TITLE"))
    self._ui.txtDesc2:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_SUBTITLE_SECTOR_1"))
    self._ui.txtDesc3:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_DESC_SECTOR_1"))
  elseif __eInstanceAtoraxionSea_Hadum == fieldMapKey or __eInstanceAtoraxionSea_Normal == fieldMapKey then
    self._ui.txtDesc1:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_TITLE_1"))
    self._ui.txtDesc2:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_SUBTITLE_SECTOR_2"))
    self._ui.txtDesc3:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXXTION_BOSSCLEAR_DESC_SECTOR_3"))
  end
end
function PaGlobalFunc_Atoraxion_NakClearOpen()
  if nil == Panel_Atoraxion_NakClear then
    return
  end
  PaGlobal_Atoraxion_NakClear:changeNotiText()
  Panel_Atoraxion_NakClear:ComputePos()
  Panel_Atoraxion_NakClear:AddEffect("fui_Ancient_Clear_01A", false, 0, 0)
  audioPostEvent_SystemUi(4, 22)
  _AudioPostEvent_SystemUiForXBOX(4, 22)
  PaGlobal_Atoraxion_NakClear:prepareOpen()
end
function FromClient_Atoraxion_NakClear_UpdatePerFrame(deltaTime)
  if nil == Panel_Atoraxion_NakClear then
    return
  end
  PaGlobal_Atoraxion_NakClear._currentTime = PaGlobal_Atoraxion_NakClear._currentTime + deltaTime
  if PaGlobal_Atoraxion_NakClear._endTime < PaGlobal_Atoraxion_NakClear._currentTime then
    PaGlobal_Atoraxion_NakClear:prepareClose()
  end
end
