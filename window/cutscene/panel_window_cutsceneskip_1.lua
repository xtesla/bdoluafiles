function PaGlobal_CutSceneSkip:initialize()
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_GroupCamera
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, PaGlobalFunc_CutSceneSkip_Awake)
  self._ui._stc_icon = UI.getChildControl(self._ui._stc_territoryArea, "Static_TerritoryIcon")
  self._ui._txt_mainDesc = UI.getChildControl(self._ui._stc_textArea, "MultilineText_1")
  self:validate()
  self:registerEvent()
  self:resizePanel()
  self._initialize = true
end
function PaGlobal_CutSceneSkip:prepareOpen()
  self:open()
end
function PaGlobal_CutSceneSkip:open()
  if false == self._initialize then
    return
  end
  local skipWrapper = ToClient_groupCameraSkipWrapper()
  if nil == skipWrapper then
    return
  end
  local txt_title = skipWrapper:getTitle()
  local txt_mainDesc = skipWrapper:getMainDescription()
  local txt_subDesc = skipWrapper:getSubDescription()
  local iconPath = skipWrapper:getIconPath()
  self._ui._stc_icon:ChangeTextureInfoNameDefault(iconPath)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_icon, 0, 0, 60, 60)
  self._ui._stc_icon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._stc_icon:setRenderTexture(self._ui._stc_icon:getBaseTexture())
  self._ui._txt_title:SetText(txt_title)
  self._ui._txt_mainDesc:SetText(txt_mainDesc)
  self._ui._txt_subDesc:SetText(txt_subDesc)
  self._renderMode:set()
  Panel_Window_CutSceneSkip:SetShow(true)
end
function PaGlobal_CutSceneSkip:prepareClose()
  self:close()
end
function PaGlobal_CutSceneSkip:close()
  if nil == Panel_Window_CutSceneSkip or false == Panel_Window_CutSceneSkip:GetShow() then
    return
  end
  self._renderMode:reset()
  Panel_Window_CutSceneSkip:SetShow(false)
  if true == ToClient_isPlayingGroupCamera() then
    PaGlobal_CutSceneScript:keyPressReset()
  end
end
function PaGlobal_CutSceneSkip:validate()
  self._ui._stc_territoryArea:isValidate()
  self._ui._stc_icon:isValidate()
  self._ui._txt_title:isValidate()
  self._ui._stc_textArea:isValidate()
  self._ui._txt_subDesc:isValidate()
  self._ui._txt_mainDesc:isValidate()
  self._ui._btn_skip:isValidate()
  self._ui._btn_close:isValidate()
end
function PaGlobal_CutSceneSkip:registerEvent()
  self._ui._btn_skip:addInputEvent("Mouse_LUp", "PaGlobal_CutSceneSkip:doSkip()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_CutSceneSkip:prepareClose()")
  registerEvent("FromClient_stopCutSceneCamera", "FromClient_stopCutSceneCamera")
end
function PaGlobal_CutSceneSkip:doSkip()
  ToClient_stopCutSceneCamera()
end
function PaGlobal_CutSceneSkip:resizePanel()
  Panel_Window_CutSceneSkip:SetSize(getScreenSizeX(), Panel_Window_CutSceneSkip:GetSizeY())
  Panel_Window_CutSceneSkip:ComputePosAllChild()
end
