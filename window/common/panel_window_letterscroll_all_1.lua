function PaGlobal_LetterScroll_All:initialize()
  if true == PaGlobal_LetterScroll_All._initialize then
    return
  end
  self._ui.btn_Close = UI.getChildControl(Panel_Window_LetterScroll_All, "Button_Close")
  self._ui.txt_Contents = UI.getChildControl(Panel_Window_LetterScroll_All, "StaticText_Contents")
  self._ui.txt_ContentsMultiline = UI.getChildControl(Panel_Window_LetterScroll_All, "MultilineText_Contents")
  self._ui.stc_DecoSeal = UI.getChildControl(Panel_Window_LetterScroll_All, "Static_Deco_Seal")
  self._ui.stc_KeyguideB = UI.getChildControl(Panel_Window_LetterScroll_All, "StaticText_BButton")
  self._ui.txt_Contents:SetTextMode(__eTextMode_AutoWrap)
  self._contentsSpanY = self._ui.txt_Contents:GetSpanSize().y
  PaGlobal_LetterScroll_All:registEventHandler()
  PaGlobal_LetterScroll_All:validate()
  PaGlobal_LetterScroll_All._initialize = true
end
function PaGlobal_LetterScroll_All:registEventHandler()
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_LetterScroll_All_Close()")
  Panel_Window_LetterScroll_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_LetterScroll_All_Close()")
end
function PaGlobal_LetterScroll_All:prepareOpen(eType)
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  self._ui.txt_Contents:SetShow(true)
  self._ui.txt_ContentsMultiline:SetShow(false)
  self:initTexture(eType)
  self:initTextDesc(eType)
  self:switchPadUI(_ContentsGroup_UsePadSnapping)
  PaGlobal_LetterScroll_All:open()
end
function PaGlobal_LetterScroll_All:switchPadUI(isPadUse)
  self._ui.stc_KeyguideB:SetShow(isPadUse)
  self._ui.btn_Close:SetShow(not isPadUse)
  self._ui.stc_KeyguideB:ComputePos()
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Window_LetterScroll_All:ignorePadSnapMoveToOtherPanel()
  end
end
function PaGlobal_LetterScroll_All:open()
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  Panel_Window_LetterScroll_All:SetShow(true)
end
function PaGlobal_LetterScroll_All:prepareClose()
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  PaGlobal_LetterScroll_All:close()
end
function PaGlobal_LetterScroll_All:close()
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  Panel_Window_LetterScroll_All:SetShow(false)
end
function PaGlobal_LetterScroll_All:update()
  if nil == Panel_Window_LetterScroll_All then
    return
  end
end
function PaGlobal_LetterScroll_All:validate()
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  self._ui.btn_Close:isValidate()
  self._ui.txt_Contents:isValidate()
  self._ui.txt_ContentsMultiline:isValidate()
end
function PaGlobal_LetterScroll_All:initTexture(eType)
  local texturePath = "combine/etc/combine_etc_letter.dds"
  local _x1, _y1, _x2, _y2 = 0, 0, 470, 630
  if self._eType.jLetter == eType then
    self._ui.stc_DecoSeal:SetShow(true)
  elseif self._eType.crape == eType then
    self._ui.stc_DecoSeal:SetShow(true)
  elseif self._eType.graduation == eType then
    _x1, _y1, _x2, _y2 = 471, 167, 941, 797
    self._ui.stc_DecoSeal:SetShow(false)
  elseif self._eType.season2graduation == eType or self._eType.season3graduation == eType then
    _x1, _y1, _x2, _y2 = 471, 167, 941, 797
    self._ui.stc_DecoSeal:SetShow(true)
  end
  Panel_Window_LetterScroll_All:ChangeTextureInfoName(texturePath)
  local x1, y1, x2, y2 = setTextureUV_Func(Panel_Window_LetterScroll_All, _x1, _y1, _x2, _y2)
  Panel_Window_LetterScroll_All:getBaseTexture():setUV(x1, y1, x2, y2)
  Panel_Window_LetterScroll_All:setRenderTexture(Panel_Window_LetterScroll_All:getBaseTexture())
end
function PaGlobal_LetterScroll_All:initTextDesc(eType)
  local spanY = self._contentsSpanY
  if self._eType.jLetter == eType then
    self._ui.txt_Contents:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LETTER_2019"))
  elseif self._eType.crape == eType then
    self._ui.txt_Contents:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_J_LETTER_AWARD_DESC"))
  elseif self._eType.graduation == eType then
    spanY = spanY + 50
    self._ui.txt_Contents:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LETTER_SEASON_FINISH_DESC"))
  elseif self._eType.season2graduation == eType then
    spanY = spanY + 50
    self._ui.txt_Contents:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LETTER_SEASON_FINISH_DESC2"))
  elseif self._eType.season3graduation == eType then
    spanY = spanY + 50
    self._ui.txt_Contents:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LETTER_SEASON_FINISH_DESC3"))
  end
  self._ui.txt_Contents:SetSpanSize(self._ui.txt_Contents:GetSpanSize().x, spanY)
end
function PaGlobal_LetterScroll_All:prepareLetterOpen(itemkey)
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  local letterSSW = getItemLetterStaticStatus(ItemEnchantKey(itemkey))
  if nil == letterSSW then
    return
  end
  local mainDescStringKey = letterSSW:getItemLetterMainDescStringKey()
  if nil == mainDescStringKey or "" == mainDescStringKey then
    return
  end
  local texturePath = letterSSW:getItemLetterTexturePath()
  if nil == texturePath or "" == texturePath then
    return
  end
  local isCenterAlignment = letterSSW:isItemLetterCenterAlignment()
  self._ui.stc_DecoSeal:SetShow(false)
  self:SetLetterBGTexture(texturePath)
  self:SetLetterDesc(mainDescStringKey, isCenterAlignment)
  self:switchPadUI(_ContentsGroup_UsePadSnapping)
  PaGlobal_LetterScroll_All:letterOpen()
end
function PaGlobal_LetterScroll_All:letterOpen()
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  Panel_Window_LetterScroll_All:SetShow(true)
end
function PaGlobal_LetterScroll_All:SetLetterBGTexture(texturePath)
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  local _x1, _y1, _x2, _y2 = 0, 0, 470, 630
  Panel_Window_LetterScroll_All:ChangeTextureInfoName(texturePath)
  local x1, y1, x2, y2 = setTextureUV_Func(Panel_Window_LetterScroll_All, _x1, _y1, _x2, _y2)
  Panel_Window_LetterScroll_All:getBaseTexture():setUV(x1, y1, x2, y2)
  Panel_Window_LetterScroll_All:setRenderTexture(Panel_Window_LetterScroll_All:getBaseTexture())
end
function PaGlobal_LetterScroll_All:SetLetterDesc(letterDescKey, isCenterAlignment)
  if nil == Panel_Window_LetterScroll_All then
    return
  end
  if true == isCenterAlignment then
    self._ui.txt_Contents:SetShow(false)
    self._ui.txt_ContentsMultiline:SetShow(true)
    self._ui.txt_ContentsMultiline:SetText(PAGetString(Defines.StringSheet_RESOURCE, letterDescKey))
  else
    self._ui.txt_Contents:SetShow(true)
    self._ui.txt_Contents:SetText(PAGetString(Defines.StringSheet_RESOURCE, letterDescKey))
    self._ui.txt_ContentsMultiline:SetShow(false)
  end
end
