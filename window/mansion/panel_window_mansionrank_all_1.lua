function PaGlobal_MansionRank_All:initialize()
  if true == PaGlobal_MansionRank_All._initialize or nil == Panel_Window_MansionRank_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_MansionRank_All, "Static_TitleBG")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Win_Close")
  self._ui.stc_tabBg = UI.getChildControl(Panel_Window_MansionRank_All, "Static_Category_Tap_ConsoleUI")
  self._ui.rdo_tabList[self._rankType.SERVER] = UI.getChildControl(self._ui.stc_tabBg, "RadioButton_Server")
  self._ui.rdo_tabList[self._rankType.GUILD] = UI.getChildControl(self._ui.stc_tabBg, "RadioButton_Guild")
  self._ui.rdo_tabList[self._rankType.FRIEND] = UI.getChildControl(self._ui.stc_tabBg, "RadioButton_Friends")
  self._ui.rdo_tabList[self._rankType.WORLD] = UI.getChildControl(self._ui.stc_tabBg, "RadioButton_World")
  self._ui.stc_selectLine = UI.getChildControl(self._ui.stc_tabBg, "Static_SelectLine")
  self._ui.stc_rankTitleBg = UI.getChildControl(Panel_Window_MansionRank_All, "Static_RankListTitleBG")
  self._ui.txt_titleRank = UI.getChildControl(self._ui.stc_rankTitleBg, "StaticText_RankTitle")
  self._ui.txt_titleName = UI.getChildControl(self._ui.stc_rankTitleBg, "StaticText_NameTitle")
  self._ui.txt_titleGuild = UI.getChildControl(self._ui.stc_rankTitleBg, "StaticText_GuildTitle")
  self._ui.txt_titlePoint = UI.getChildControl(self._ui.stc_rankTitleBg, "StaticText_PointTitle")
  self._ui.list2_Ranking = UI.getChildControl(Panel_Window_MansionRank_All, "List2_RankingList")
  self._ui_console.stc_keyGuideLT = UI.getChildControl(self._ui.stc_tabBg, "Static_LT_ConsoleUI")
  self._ui_console.stc_keyGuideRT = UI.getChildControl(self._ui.stc_tabBg, "Static_RT_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._currentTab = self._rankType.SERVER
  self:validate()
  self:registEventHandler()
  self:swichPlatform(self._isConsole)
  self._initialize = true
end
function PaGlobal_MansionRank_All:swichPlatform(isConsole)
  if true == self._isConsole then
    self._ui.btn_close:SetShow(false)
    self._ui_console.stc_keyGuideLT:SetShow(true)
    self._ui_console.stc_keyGuideRT:SetShow(true)
  else
    self._ui.btn_close:SetShow(true)
    self._ui_console.stc_keyGuideLT:SetShow(false)
    self._ui_console.stc_keyGuideRT:SetShow(false)
  end
end
function PaGlobal_MansionRank_All:prepareOpen()
  if nil == Panel_Window_MansionRank_All then
    return
  end
  self._ui.txt_titlePoint:SetShow(false)
  HandleEventLUp_MansionRank_All_SetTabMenu(self._currentTab)
  PaGlobal_MansionRank_All:open()
  PaGlobal_MansionRank_All:resize()
end
function PaGlobal_MansionRank_All:dataclear()
end
function PaGlobal_MansionRank_All:open()
  if nil == Panel_Window_MansionRank_All then
    return
  end
  Panel_Window_MansionRank_All:SetShow(true)
end
function PaGlobal_MansionRank_All:prepareClose()
  if nil == Panel_Window_MansionRank_All then
    return
  end
  self._currentTab = self._rankType.SERVER
  PaGlobal_MansionRank_All:close()
end
function PaGlobal_MansionRank_All:close()
  if nil == Panel_Window_MansionRank_All then
    return
  end
  Panel_Window_MansionRank_All:SetShow(false)
end
function PaGlobal_MansionRank_All:currentTabUpdate()
  if nil == Panel_Window_MansionRank_All then
    return
  end
  for index = self._rankType.SERVER, self._rankType.COUNT - 1 do
    self._ui.rdo_tabList[index]:SetCheck(false)
  end
  self._ui.rdo_tabList[self._currentTab]:SetCheck(true)
  self._currentTab = self._currentTab
  local targetControl = self._ui.rdo_tabList[self._currentTab]
  local selectBarPosX = targetControl:GetPosX() + targetControl:GetSizeX() / 2 - PaGlobal_Quest_All._ui.stc_selectBar:GetSizeX() / 2
  self._ui.stc_selectLine:SetPosX(selectBarPosX)
end
function PaGlobal_MansionRank_All:listUpdate()
  if nil == Panel_Window_MansionRank_All then
    return
  end
  self._ui.list2_Ranking:getElementManager():clearKey()
  local listType = self._currentTab
  local listCount = ToClient_GetMansionRankerCount()
  for index = 0, listCount do
    local rankInfo = ToClient_GetMansionRankerAt(index)
    if nil ~= rankInfo then
      local rankName = rankInfo:getUserName()
      if nil ~= rankName and " " ~= rankName and 0 < string.len(rankName) then
        self._ui.list2_Ranking:getElementManager():pushKey(toInt64(0, index))
      end
    end
  end
end
function PaGlobal_MansionRank_All:registEventHandler()
  if nil == Panel_Window_MansionRank_All then
    return
  end
  registerEvent("onScreenResize", "FromCleint_MansionRank_All_onScreenResize")
  registerEvent("FromClient_UpdateMansionRanking", "FromClient_MansionRank_All_UpdateMansionRanking")
  self._ui.list2_Ranking:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_Ranking:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_MansionRank_All_CreateList")
  if false == self._isConsole then
    self._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_MansionRank_All_Close()")
  else
    Panel_Window_MansionRank_All:registerPadEvent(__eConsoleUIPadEvent_LT, "HandlePadEventLTRT_SeasonUiSelect_All_MoveTabMenu(-1)")
    Panel_Window_MansionRank_All:registerPadEvent(__eConsoleUIPadEvent_RT, "HandlePadEventLTRT_SeasonUiSelect_All_MoveTabMenu(1)")
  end
  for index = self._rankType.SERVER, self._rankType.COUNT - 1 do
    self._ui.rdo_tabList[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_MansionRank_All_SetTabMenu(" .. index .. ")")
  end
end
function PaGlobal_MansionRank_All:validate()
  if nil == Panel_Window_MansionRank_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_tabBg:isValidate()
  self._ui.rdo_tabList[self._rankType.SERVER]:isValidate()
  self._ui.rdo_tabList[self._rankType.GUILD]:isValidate()
  self._ui.rdo_tabList[self._rankType.FRIEND]:isValidate()
  self._ui.rdo_tabList[self._rankType.WORLD]:isValidate()
  self._ui.stc_selectLine:isValidate()
  self._ui.stc_rankTitleBg:isValidate()
  self._ui.txt_titleRank:isValidate()
  self._ui.txt_titleName:isValidate()
  self._ui.txt_titleGuild:isValidate()
  self._ui.txt_titlePoint:isValidate()
  self._ui.list2_Ranking:isValidate()
end
function PaGlobal_MansionRank_All:resize()
  if nil == Panel_Window_MansionRank_All then
    return
  end
  Panel_Window_MansionRank_All:ComputePos()
end
