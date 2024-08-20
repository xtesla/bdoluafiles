PaGlobal_WorldMap_BookMark = {
  _ui = {
    edit_BookMarkName = nil,
    btn_Save = nil,
    btn_Cancel = nil,
    btn_Close = nil,
    stc_KeyGuideBG = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _inputTextLength = 10,
  _defaultText = PAGetString(Defines.StringSheet_GAME, "LUA_NPCNAVI_ADDBOOKMARK_NAME"),
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_WorldMapBookMark_Init")
function FromClient_WorldMapBookMark_Init()
  PaGlobal_WorldMap_BookMark:initialize()
end
function PaGlobal_WorldMap_BookMark:initialize()
  if true == PaGlobal_WorldMap_BookMark._initialize or nil == Panel_WorldMap_BookMark then
    return
  end
  local stcMainBg = UI.getChildControl(Panel_WorldMap_BookMark, "Static_MainBG")
  self._ui.edit_BookMarkName = UI.getChildControl(stcMainBg, "Edit_Box")
  self._ui.btn_Save = UI.getChildControl(Panel_WorldMap_BookMark, "Button_Apply")
  self._ui.btn_Cancel = UI.getChildControl(Panel_WorldMap_BookMark, "Button_Cancel")
  self._ui.btn_Close = UI.getChildControl(Panel_WorldMap_BookMark, "Button_Close")
  self._ui.stc_KeyGuideBG = UI.getChildControl(Panel_WorldMap_BookMark, "Static_Console_KeyGuide")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuideBG, "StaticText_Console_A")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuideBG, "StaticText_Console_B")
  self._isConsole = _ContentsGroup_RenewUI
  PaGlobal_WorldMap_BookMark:validate()
  PaGlobal_WorldMap_BookMark:registEventHandler()
  PaGlobal_WorldMap_BookMark:swichPlatform(self._isConsole)
  PaGlobal_WorldMap_BookMark._initialize = true
end
function PaGlobal_WorldMap_BookMark:registEventHandler()
  self._ui.edit_BookMarkName:SetMaxInput(self._inputTextLength)
  self._ui.edit_BookMarkName:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_BookMark_ClearText()")
  self._ui.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_BookMark_Close()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_BookMark_Close()")
  registerEvent("FromClient_UpdateWorldMapBookMarkData", "PaGlobalFunc_WorldMap_BookMark_Close")
end
function PaGlobal_WorldMap_BookMark:swichPlatform(isConsole)
end
function PaGlobal_WorldMap_BookMark:validate()
  self._ui.edit_BookMarkName:isValidate()
  self._ui.btn_Save:isValidate()
  self._ui.btn_Cancel:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_KeyGuideBG:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
end
function PaGlobal_WorldMap_BookMark:prepareOpen()
  self._ui.edit_BookMarkName:SetEditText(self._defaultText)
  PaGlobal_WorldMap_BookMark:open()
end
function PaGlobal_WorldMap_BookMark:open()
  Panel_WorldMap_BookMark:SetShow(true)
end
function PaGlobal_WorldMap_BookMark:prepareClose()
  PaGlobal_WorldMap_BookMark:close()
end
function PaGlobal_WorldMap_BookMark:close()
  Panel_WorldMap_BookMark:SetShow(false)
end
function PaGlobalFunc_WorldMap_BookMark_OpenFromNPCNavi(index)
  if nil == index then
    return
  end
  PaGlobal_WorldMap_BookMark._ui.btn_Save:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMap_BookMark_ChangeName(" .. index .. ")")
  PaGlobal_WorldMap_BookMark._ui.edit_BookMarkName:RegistReturnKeyEvent("HandleEventLUp_WorldMap_BookMark_ChangeName(" .. index .. ")")
  PaGlobal_WorldMap_BookMark:prepareOpen()
end
function PaGlobalFunc_WorldMap_BookMark_OpenFromWorldMap()
  PaGlobal_WorldMap_BookMark._ui.btn_Save:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_BookMark_Save()")
  PaGlobal_WorldMap_BookMark._ui.edit_BookMarkName:RegistReturnKeyEvent("PaGlobalFunc_WorldMap_BookMark_Save()")
  PaGlobal_WorldMap_BookMark:prepareOpen()
end
function PaGlobalFunc_WorldMap_BookMark_Close()
  PaGlobal_WorldMap_BookMark:prepareClose()
end
function PaGlobalFunc_WorldMap_BookMark_Save()
  if true == ToClient_WorldMapNaviEmpty() or true == ToClient_WorldMapNaviIsLoopPath() then
    return
  end
  local text = PaGlobal_WorldMap_BookMark._ui.edit_BookMarkName:GetEditText()
  if "" == text then
    return
  end
  ToClient_SaveWorldMapBookMark(text)
  ClearFocusEdit()
end
function FromClient_WorldMap_BookMarkUpdate(notUse)
  PaGlobalFunc_WorldMap_BookMark_Close()
end
function HandleEventLUp_WorldMap_BookMark_ChangeName(index)
  local text = PaGlobal_WorldMap_BookMark._ui.edit_BookMarkName:GetEditText()
  if "" == text then
    return
  end
  ToClient_ChangeWorldMapBookMarkName(index, text)
end
function PaGlobalFunc_WorldMap_BookMark_ClearText()
  PaGlobal_WorldMap_BookMark._ui.edit_BookMarkName:SetEditText("")
end
