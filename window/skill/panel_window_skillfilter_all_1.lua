function PaGlobal_SkillFilter_All:initialize()
  if true == self._initialize then
    return
  end
  self:initControlAll()
  self._selectFilterType = 0
  self._ui._filterList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_SkillFilter_All_ListControlCreate")
  self._ui._filterList:createChildContent(__ePAUIList2ElementManagerType_List)
  self:registEventHandler()
  self:validate()
  if true == _ContentsGroup_UsePadSnapping then
    local originalSpan = Panel_Window_SkillFilter_All:GetSpanSize()
    Panel_Window_SkillFilter_All:SetSpanSize(originalSpan.x, originalSpan.y * 2)
  end
  self._initialize = true
end
function PaGlobal_SkillFilter_All:initControlAll()
  if nil == Panel_Window_SkillFilter_All then
    return
  end
  local titleArea = UI.getChildControl(Panel_Window_SkillFilter_All, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(titleArea, "Button_Win_Close")
  self._ui._filterList = UI.getChildControl(Panel_Window_SkillFilter_All, "List2_1")
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btn_close:SetShow(false)
    local keyGuideBG = UI.getChildControl(Panel_Window_SkillFilter_All, "Static_KeyGuide_ConsoleUI")
    keyGuideBG:SetShow(true)
    local keyGuideList = {
      UI.getChildControl(keyGuideBG, "StaticText_KeyGuide_A_ConsoleUI"),
      UI.getChildControl(keyGuideBG, "StaticText_KeyGuide_B_ConsoleUI")
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_SkillFilter_All:registEventHandler()
  if nil == Panel_Window_SkillFilter_All then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_SkillFilter_Close()")
end
function PaGlobal_SkillFilter_All:prepareOpen()
  if nil == PaGlobal_SkillFilter_All then
    return
  end
  self:pushDataToList()
  PaGlobal_SkillFilter_All:open()
end
function PaGlobal_SkillFilter_All:open()
  if nil == Panel_Window_SkillFilter_All then
    return
  end
  Panel_Window_SkillFilter_All:SetShow(true)
end
function PaGlobal_SkillFilter_All:prepareClose()
  if nil == Panel_Window_SkillFilter_All then
    return
  end
  PaGlobal_SkillFilter_All:close()
end
function PaGlobal_SkillFilter_All:close()
  if nil == Panel_Window_SkillFilter_All then
    return
  end
  Panel_Window_SkillFilter_All:SetShow(false)
end
function PaGlobal_SkillFilter_All:update()
  if nil == Panel_Window_SkillFilter_All then
    return
  end
end
function PaGlobal_SkillFilter_All:pushDataToList()
  if nil == Panel_Window_SkillFilter_All then
    return
  end
  self._ui._filterList:getElementManager():clearKey()
  for ii = 1, self._skillFilterCount do
    self._ui._filterList:getElementManager():pushKey(toInt64(0, ii))
  end
end
function PaGlobal_SkillFilter_All:validate()
  if nil == Panel_Window_SkillFilter_All then
    return
  end
  self._ui._btn_close:isValidate()
  self._ui._filterList:isValidate()
end
