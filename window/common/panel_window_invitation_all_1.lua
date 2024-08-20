function PaGlobal_Invitation_All:initialize()
  if true == PaGlobal_Invitation_All._initialize then
    return
  end
  self._ui.btn_Close = UI.getChildControl(Panel_Window_Invitation_All, "Button_Close")
  self._ui.txt_Contents = UI.getChildControl(Panel_Window_Invitation_All, "StaticText_Contents")
  self._ui.stc_decoSeal = UI.getChildControl(Panel_Window_Invitation_All, "Static_Deco_Seal")
  self._ui.stc_keyGuideConsoleBg = UI.getChildControl(Panel_Window_Invitation_All, "Static_KeyGuide_Console")
  self._ui.stc_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideConsoleBg, "StaticText_B_Close")
  self._ui.txt_Contents:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_Invitation_All:registEventHandler()
  PaGlobal_Invitation_All:validate()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.btn_Close:SetShow(not self._isConsole)
  self._ui.stc_keyGuideConsoleBg:SetShow(self._isConsole)
  PaGlobal_Invitation_All._initialize = true
end
function PaGlobal_Invitation_All:registEventHandler()
  if nil == Panel_Window_Invitation_All then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_Invitation_All_Close()")
end
function PaGlobal_Invitation_All:prepareOpen(eType)
  if nil == Panel_Window_Invitation_All then
    return
  end
  self:initTextDesc(eType)
  self:initTexture(eType)
  self:initSeal(eType)
  PaGlobal_Invitation_All:open()
  self:setAlignKeyGuide()
end
function PaGlobal_Invitation_All:open()
  if nil == Panel_Window_Invitation_All then
    return
  end
  Panel_Window_Invitation_All:SetShow(true)
end
function PaGlobal_Invitation_All:prepareClose()
  if nil == Panel_Window_Invitation_All then
    return
  end
  PaGlobal_Invitation_All:close()
end
function PaGlobal_Invitation_All:close()
  if nil == Panel_Window_Invitation_All then
    return
  end
  Panel_Window_Invitation_All:SetShow(false)
end
function PaGlobal_Invitation_All:setAlignKeyGuide()
  local keyGuides = {
    self._ui.stc_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideConsoleBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Invitation_All:update()
  if nil == Panel_Window_Invitation_All then
    return
  end
end
function PaGlobal_Invitation_All:validate()
  if nil == Panel_Window_Invitation_All then
    return
  end
  self._ui.btn_Close:isValidate()
  self._ui.txt_Contents:isValidate()
end
function PaGlobal_Invitation_All:initTextDesc(eType)
  if self._eType.invitation == eType then
    self._ui.txt_Contents:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LETTER_JARETT_DESC"))
  elseif self._eType.invitation2 == eType then
    self._ui.txt_Contents:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LETTER_CALPHEON_DESC"))
  end
end
function PaGlobal_Invitation_All:initTexture(eType)
  local texturePath = "combine/etc/combine_etc_invitation.dds"
  local _x1, _y1, _x2, _y2 = 1, 1, 471, 701
  if self._eType.invitation2 == eType then
    texturePath = "combine/etc/combine_etc_calpheoninvitation.dds"
  end
  Panel_Window_Invitation_All:ChangeTextureInfoName(texturePath)
  local x1, y1, x2, y2 = setTextureUV_Func(Panel_Window_Invitation_All, _x1, _y1, _x2, _y2)
  Panel_Window_Invitation_All:getBaseTexture():setUV(x1, y1, x2, y2)
  Panel_Window_Invitation_All:setRenderTexture(Panel_Window_Invitation_All:getBaseTexture())
end
function PaGlobal_Invitation_All:initSeal(eType)
  local texturePath = "combine/etc/combine_etc_invitation.dds"
  local _x1, _y1, _x2, _y2 = 472, 32, 574, 114
  if self._eType.invitation2 == eType then
    texturePath = "combine/etc/combine_etc_calpheoninvitation.dds"
    _x1, _y1, _x2, _y2 = 472, 32, 585, 123
  end
  self._ui.stc_decoSeal:ChangeTextureInfoName(texturePath)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_decoSeal, _x1, _y1, _x2, _y2)
  self._ui.stc_decoSeal:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_decoSeal:setRenderTexture(self._ui.stc_decoSeal:getBaseTexture())
end
