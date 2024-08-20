function PaGlobal_BarterInfoSearch:init()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_keyGuideBG:SetShow(true == self._isConsole)
  self._originalKeyGuideBgSize = self._ui._stc_keyGuideBG:GetSizeY()
  self._originalPanelPosY = Panel_Window_Barter_Search:GetPosY()
  self._ui._keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_B_ConsoleUI")
  self._ui._keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_Y_ConsoleUI")
  self._ui._keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_A_ConsoleUI")
  self._ui._keyGuide_LT_X = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_LT_X_ConsoleUI")
  self._ui._keyGuide_RT_X = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_RT_X_ConsoleUI")
  self._ui._keyGuide_RT_Y = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_RT_Y_ConsoleUI")
  self._ui._keyGuide_LT_Y = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_LT_Y_ConsoleUI")
  self._ui._keyGuide_LB_X = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_LB_X_ConsoleUI")
  self._ui._keyGuide_LB_Y = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_LB_Y_ConsoleUI")
  self._ui._keyGuide_RS = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_RS_ConsoleUI")
  self._ui._keyGuide_DPadL = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_DpadL_ConsoleUI")
  self._ui._keyGuide_DPadU = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_DpadU_ConsoleUI")
  self._ui._keyGuide_LS = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_LS_ConsoleUI")
  self._ui._keyGuide_B:SetShow(true == self._isConsole)
  self._ui._keyGuide_Y:SetShow(true == self._isConsole)
  self._ui._keyGuide_A:SetShow(true == self._isConsole)
  self._ui._keyGuide_LT_X:SetShow(true == self._isConsole)
  self._ui._keyGuide_LT_Y:SetShow(true == self._isConsole)
  self._ui._keyGuide_RT_X:SetShow(true == self._isConsole)
  self._ui._keyGuide_RT_Y:SetShow(true == self._isConsole)
  self._ui._keyGuide_LB_X:SetShow(true == self._isConsole)
  self._ui._keyGuide_RS:SetShow(true == self._isConsole)
  self._ui._keyGuide_DPadL:SetShow(true == self._isConsole)
  self._ui._keyGuide_DPadU:SetShow(true == self._isConsole)
  self._ui._btn_specialBarterInfo = UI.getChildControl(self._ui._stc_specialInfoBG, "Button_SpecialBarterInfo")
  if true == self._isConsole then
    Panel_Window_Barter_Search:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobal_BarterInfoSearch_Special:open()")
  else
    self._ui._btn_specialBarterInfo:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch_Special:open()")
  end
  self._ui._txt_specialInfo = UI.getChildControl(self._ui._stc_specialInfoBG, "StaticText_SpecialBarter")
  self._ui._btn_close = UI.getChildControl(self._ui._titleBar, "Button_Close")
  self._ui._btn_close:SetShow(false == self._isConsole)
  if true == self._isConsole then
    Panel_Window_Barter_Search:registerPadEvent(__eConsoleUIPadEvent_B, "PaGlobal_BarterInfoSearch_Close()")
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch_Close()")
  end
  if true == _ContentsGroup_RenewUI and nil ~= Panel_Window_CargoLoading_ALL then
    Panel_Window_Barter_Search:registerPadEvent(__eConsoleUIPadEvent_LSClick, "ToClient_padSnapSetTargetPanel(Panel_Window_CargoLoading_ALL)")
  end
  self._ui._btn_tray = UI.getChildControl(self._ui._titleBar, "CheckButton_TrayBTN")
  self._ui._btn_tray:addInputEvent("Mouse_On", "PaGlobal_BarterInfoSearch:popUpUITooltip( true )")
  self._ui._btn_tray:addInputEvent("Mouse_Out", "PaGlobal_BarterInfoSearch:popUpUITooltip( false )")
  self._ui._btn_tray:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch:popUpUI()")
  self._ui._btn_tray:SetShow(_ContentsGroup_PopUp)
  self._ui._edit = UI.getChildControl(self._ui._searchBar, "Edit_Search")
  self._ui._edit:RegistReturnKeyEvent("PaGlobal_BarterInfoSearch:refresh()")
  self._ui._btn_search_pc = UI.getChildControl(self._ui._edit, "Button_Search")
  self._ui._btn_search_console = UI.getChildControl(self._ui._edit, "Static_KeyGuide_X_ConsoleUI")
  if true == self._isConsole then
    self._ui._edit:SetShow(false)
    self._ui._btn_search_pc:SetShow(false)
    self._ui._btn_search_console:SetShow(false)
  else
    self._ui._edit:SetShow(true)
    self._ui._btn_search_pc:SetShow(true)
    self._ui._btn_search_console:SetShow(false)
    self._ui._btn_search_pc:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch:refresh()")
  end
  self._ui._txt_exchangeCountForTime = UI.getChildControl(self._ui._searchBar, "StaticText_RemainCountValue")
  self._ui._txt_totalExchangeCount = UI.getChildControl(self._ui._searchBar, "StaticText_TotalRemainCountTitle")
  self._ui._btn_position = UI.getChildControl(self._ui._searchBar, "Button_Position")
  if true == _ContentsGroup_Barter_Renew then
    self._ui._btn_position:addInputEvent("Mouse_LUp", "PaGlobalFunc_BarterInfoSearch_SetWayPointSort()")
    self._ui._btn_position:addInputEvent("Mouse_On", "PaGlobalFunc_ShowWayPointSortToolTip()")
    self._ui._btn_position:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  end
  self._ui._btn_refresh = UI.getChildControl(self._ui._searchBar, "Button_Reload")
  if true == self._isConsole then
    Panel_Window_Barter_Search:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_BarterInfoSearch:refresh()")
  else
    self._ui._btn_refresh:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch:refresh()")
  end
  self._ui._list2_barterInfoList = UI.getChildControl(self._ui._mainBg, "List2_1")
  self._ui._list2_barterInfoList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_BarterInfoSearch_CreateControlList2")
  self._ui._list2_barterInfoList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._txt_noticeDesc:SetTextMode(__eTextMode_AutoWrap)
  if true == self._isConsole then
    self._ui._txt_noticeDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_BARTER_SEARCH_BARTERNOTICE_CONSOLE"))
  else
    self._ui._txt_noticeDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_BARTER_SEARCH_BARTERNOTICE"))
  end
  self._ui._filter = UI.getChildControl(self._ui._searchBar, "Combobox_Gender")
  self._ui._filter:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch:showFilterList()")
  self._ui._filter:GetListControl():AddSelectEvent("PaGlobal_BarterInfoSearch:setFilter()")
  self._selectFilterIndex = __eItemGradeTypeCount
  self._ui._valueLimit = UI.getChildControl(Panel_Window_Barter_Search, "Combobox_Rate")
  self._ui._valueLimit:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch:showValueLimit()")
  self._ui._valueLimit:GetListControl():AddSelectEvent("PaGlobal_BarterInfoSearch:setValueLimit()")
  self._selectValueLimitIndex = 1
  self._ui._category = UI.getChildControl(Panel_Window_Barter_Search, "Combobox_Depth")
  self._ui._category:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch:showCategory()")
  self._ui._category:GetListControl():AddSelectEvent("PaGlobal_BarterInfoSearch:setCategory()")
  self._selectCategoryIndex = __eBarterCategory_Count
  if true == self._isConsole then
    Panel_Window_Barter_Search:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobal_BarterInfoSearch:setNextFilter()")
    Panel_Window_Barter_Search:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "PaGlobal_BarterInfoSearch:setNextValueLimit()")
    Panel_Window_Barter_Search:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "PaGlobal_BarterInfoSearch:setNextCategory()")
  end
  self._specailBG_DefaultSizeX = self._ui._btn_specialBarterInfo:GetSizeX()
  self._ui._barterLifeInfoBg = UI.getChildControl(self._ui._searchBar, "Static_BarterLifeLevel")
  self._ui._pg2_barterLifeLevel = UI.getChildControl(self._ui._barterLifeInfoBg, "Progress2_Gauge")
  self._ui._txt_barterLifeLevel = UI.getChildControl(self._ui._barterLifeInfoBg, "StaticText_Level")
  self._ui._txt_barterLifeExp = UI.getChildControl(self._ui._barterLifeInfoBg, "StaticText_Percent")
  if true == _ContentsGroup_Barter_Renew then
    self._ui._btn_position:SetShow(true)
  else
    self._ui._btn_position:SetShow(false)
    self._ui._filter:SetPosX(self._ui._filter:GetPosX() + self._ui._btn_position:GetSizeX())
    self._ui._edit:SetPosX(self._ui._edit:GetPosX() + self._ui._btn_position:GetSizeX())
    self._ui._valueLimit:SetShow(false)
    self._ui._category:SetShow(false)
  end
  local btn_check = UI.getChildControl(Panel_Window_Barter_Search, "CheckButton_1")
  local txt_checkDesc = UI.getChildControl(btn_check, "StaticText_1")
  UI.setLimitTextAndAddTooltip(txt_checkDesc)
  if true == self._isConsole then
    Panel_Window_Barter_Search:registerPadEvent(__eConsoleUIPadEvent_LBPress_X, "PaGlobal_BarterInfoSearch:SetCheckHideComplete()")
  else
    self._ui._chk_hideComplete:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch:refresh()")
  end
  self._ui._chk_hideComplete:SetEnableArea(0, 0, self._ui._chk_hideComplete:GetSizeX() + self._ui._chk_hideComplete:GetTextSizeX() + 10, self._ui._chk_hideComplete:GetSizeY())
  self._ui._btnResetBarterSeed = UI.getChildControl(Panel_Window_Barter_Search, "Button_BarterRefresh")
  if true == self._isConsole then
    Panel_Window_Barter_Search:registerPadEvent(__eConsoleUIPadEvent_LBPress_Y, "HandleEventLUp_BarterInfoSearch_All_requestChangeBarterList()")
  else
    self._ui._btnResetBarterSeed:addInputEvent("Mouse_LUp", "HandleEventLUp_BarterInfoSearch_All_requestChangeBarterList()")
    self._ui._btnResetBarterSeed:addInputEvent("Mouse_On", "HandleEventMouseOver_BarterInfoSearch_All_ShowTooltip(true)")
    self._ui._btnResetBarterSeed:addInputEvent("Mouse_Out", "HandleEventMouseOver_BarterInfoSearch_All_ShowTooltip(false)")
  end
  local gapY = 10
  if self._ui._stc_noticeBg:GetSizeY() < self._ui._txt_noticeDesc:GetTextSizeY() + gapY then
    local addSizeY = self._ui._txt_noticeDesc:GetTextSizeY() + gapY - self._ui._stc_noticeBg:GetSizeY()
    self._ui._stc_noticeBg:SetSize(self._ui._stc_noticeBg:GetSizeX(), self._ui._stc_noticeBg:GetSizeY() + addSizeY)
    self._ui._txt_noticeDesc:SetSize(self._ui._stc_noticeBg:GetSizeX(), self._ui._stc_noticeBg:GetSizeY())
    Panel_Window_Barter_Search:SetSize(Panel_Window_Barter_Search:GetSizeX(), Panel_Window_Barter_Search:GetSizeY() + addSizeY)
    self._ui._stc_noticeBg:ComputePos()
    self._ui._txt_noticeDesc:ComputePos()
    Panel_Window_Barter_Search:ComputePos()
  end
  self._ui._timeBar:SetShow(false)
  self._isInit = true
end
function PaGlobal_BarterInfoSearch:clear()
  self._updateCurrentTime = 0
  self._updatePastTime = 0
  self._ui._btn_tray:SetCheck(false)
end
function PaGlobal_BarterInfoSearch:open()
  if false == _ContentsGroup_Barter then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  self:clear()
  PaGlobalFunc_BarterInfoSearch_ComboBoxResetAdd()
  self._ui._txt_totalExchangeCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEM_ACCRUE_COUNT", "count", tostring(ToClient_barterTotalExchangeCount())))
  self:refresh()
  local remainCount = ToClient_barterMaxExchangeCountForTime() - ToClient_barterCurrentExchangeCountForTime()
  local remainCount_s64 = toInt64(0, remainCount)
  self._ui._txt_exchangeCountForTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEM_TICKET_COUNT", "count", tostring(makeDotMoney(remainCount_s64))))
  local maxSeedChangeCount = ToClient_getMaxChangeSeedCountForDay()
  local remainSeedChangeCount = maxSeedChangeCount - ToClient_getChangeSeedCountForDay()
  if remainSeedChangeCount < 0 then
    remainSeedChangeCount = 0
  end
  local string = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTER_CHANGEBARTERSEEDCOUNT", "count", tostring(remainSeedChangeCount), "maxcount", tostring(maxSeedChangeCount))
  self._ui._btnResetBarterSeed:SetText(string)
  self._ui._btnResetBarterSeed:SetMonoTone(not ToClient_isEnableChangeBarterSeed())
  PaGlobal_BarterInfoSearch:setKeyGuideAlign()
  if true == _ContentsGroup_RenewUI and true == Panel_Window_CargoLoading_ALL:GetShow() then
    Panel_Window_CargoLoading_ALL:SetPosX(getOriginScreenSizeX() / 2 - Panel_Window_CargoLoading_ALL:GetSizeX() - 10)
    Panel_Window_CargoLoading_ALL:ignorePadSnapMoveToOtherPanelUpdate(false)
    Panel_Window_Barter_Search:SetPosX(getOriginScreenSizeX() / 2 + 10)
    Panel_Dialog_ServantList_All:SetShow(false)
    Panel_Dialog_ServantInfo_All:SetShow(false)
  end
  Panel_Window_Barter_Search:SetShow(true)
end
function PaGlobal_BarterInfoSearch:close()
  if true == ToClient_WorldMapIsShow() then
    WorldMapPopupManager:pop()
  end
  if true == _ContentsGroup_UsePadSnapping and nil ~= PaGlobal_BarterInfoSearch_Special_isShow and true == PaGlobal_BarterInfoSearch_Special_isShow() then
    PaGlobal_BarterInfoSearch_Special_Close()
    return
  end
  if true == _ContentsGroup_RenewUI and true == Panel_Window_CargoLoading_ALL:GetShow() then
    if nil ~= PaGlobal_BarterInfoSearch_Special_isShow and true == PaGlobal_BarterInfoSearch_Special_isShow() then
      PaGlobal_BarterInfoSearch_Special_Close()
      return
    end
    if nil ~= PaGlobalFunc_CargoLoading_SetBarterInfoKeyGuide then
      PaGlobalFunc_CargoLoading_SetBarterInfoKeyGuide(true)
    end
    Panel_Window_CargoLoading_ALL:ComputePos()
    Panel_Window_Barter_Search:ComputePos()
  end
  Panel_Window_Barter_Search:SetShow(false)
  Panel_Window_Barter_Search:CloseUISubApp()
  PaGlobal_BarterInfoSearch_ItemTooltip_Hide()
  TooltipSimple_Hide()
  Panel_Window_Barter_Search:ClearUpdateLuaFunc("Update_BarterInfoSearch_FrameEvent")
end
function PaGlobal_BarterInfoSearch:setBarterLifeInfo()
  if nil == getSelfPlayer() then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  if nil == selfPlayer then
    return
  end
  local lifeType = 11
  local currentLevel = selfPlayer:getLifeExperienceLevel(lifeType)
  local currentExp64 = selfPlayer:getCurrLifeExperiencePoint(lifeType)
  local needExp64 = selfPlayer:getDemandLifeExperiencePoint(lifeType)
  local currentExpRate64 = currentExp64 * toInt64(0, 10000) / needExp64
  local currentExpRate = Int64toInt32(currentExpRate64)
  currentExpRate = currentExpRate / 100
  local currentExpRateString = string.format("%.2f", currentExpRate)
  local colorLifeLevel = PaGlobalFunc_Util_CraftLevelColorReplace(currentLevel)
  self._ui._txt_barterLifeLevel:SetText(colorLifeLevel)
  self._ui._txt_barterLifeExp:SetText(currentExpRateString .. "%")
  self._ui._pg2_barterLifeLevel:SetProgressRate(currentExpRate)
end
function PaGlobal_BarterInfoSearch:refresh()
  if false == self._isInit then
    return
  end
  self:setBarterLifeInfo()
  self._ui._list2_barterInfoList:getElementManager():clearKey()
  self._ui._filter:SetText(self._itemGradeText[self._selectFilterIndex])
  local barterType = ToClient_getCurrentBarterType()
  if true == _ContentsGroup_Barter_Renew then
    self._ui._valueLimit:SetText(self._valueLimitText[self._selectValueLimitIndex])
    self._ui._category:SetText(self._categoryText[self._selectCategoryIndex])
    if self._selectCategoryIndex == __eBarterCategory_Level1ToLevel2 or self._selectCategoryIndex == __eBarterCategory_Level2ToLevel3 or self._selectCategoryIndex == __eBarterCategory_Count then
      if __eBarterType_Normal == barterType then
        self._ui._valueLimit:SetShow(true)
        self._ui._category:SetShow(true)
      else
        self._ui._valueLimit:SetShow(false)
        self._ui._category:SetShow(false)
      end
    else
      if __eBarterType_Normal == barterType then
        self._ui._category:SetShow(true)
      else
        self._ui._category:SetShow(false)
      end
      self._ui._valueLimit:SetShow(false)
    end
  end
  local regionList = {}
  if true == _ContentsGroup_Barter_Renew then
    if __eBarterType_Normal == barterType then
      regionList = ToClient_barterRegionListForRenew(self._ui._edit:GetEditText(), self._selectFilterIndex, self._selectCategoryIndex, self._selectValueLimitIndex)
    else
      regionList = ToClient_barterRegionList(self._ui._edit:GetEditText(), self._selectFilterIndex)
    end
  else
    regionList = ToClient_barterRegionList(self._ui._edit:GetEditText(), self._selectFilterIndex)
  end
  if nil ~= regionList then
    for ii = 0, #regionList do
      local barterWrapper = ToClient_barterWrapper(regionList[ii])
      if nil ~= barterWrapper then
        if true == self._ui._chk_hideComplete:IsCheck() then
          if barterWrapper:getExchangeCurrentCount() < barterWrapper:getExchangeMaxCount() then
            self._ui._list2_barterInfoList:getElementManager():pushKey(regionList[ii]:get())
          end
        else
          self._ui._list2_barterInfoList:getElementManager():pushKey(regionList[ii]:get())
        end
      end
    end
    self._ui._list2_barterInfoList:ComputePos()
    self._ui._txt_NotFind:SetShow(false)
  else
    self._ui._txt_NotFind:SetShow(true)
  end
  local remainCount = ToClient_barterMaxExchangeCountForTime() - ToClient_barterCurrentExchangeCountForTime()
  local maxSeedChangeCount = ToClient_getMaxChangeSeedCountForDay()
  local remainSeedChangeCount = maxSeedChangeCount - ToClient_getChangeSeedCountForDay()
  local string = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTER_CHANGEBARTERSEEDCOUNT", "count", tostring(remainSeedChangeCount), "maxcount", tostring(maxSeedChangeCount))
  local remainCount_s64 = toInt64(0, remainCount)
  self._ui._txt_exchangeCountForTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEM_TICKET_COUNT", "count", tostring(makeDotMoney(remainCount_s64))))
  self._ui._btnResetBarterSeed:SetText(string)
  self._ui._btnResetBarterSeed:SetMonoTone(not ToClient_isEnableChangeBarterSeed())
  PaGlobal_BarterInfoSearch:refreshSpecialBarter()
end
function PaGlobal_BarterInfoSearch:refreshSpecialBarter()
  if false == self._isInit then
    return
  end
  local specialBarterWrapper = ToClient_specialBarterWrapper()
  local str = ""
  if nil ~= specialBarterWrapper then
    local regionWrapper = getRegionInfoWrapper(specialBarterWrapper:getRegionKey():get())
    if nil == regionWrapper then
      str = PAGetString(Defines.StringSheet_GAME, "LUA_SPECIAL_TRADE_UNKNOWN_ISLAND")
    else
      str = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPECIAL_TRADE_KNOW_ISLAND", "areaname", regionWrapper:getAreaName())
    end
  else
    str = PAGetString(Defines.StringSheet_GAME, "LUA_SPECIAL_TRADE_NONE_ISLAND")
  end
  self._ui._txt_specialInfo:SetTextMode(__eTextMode_None)
  self._ui._txt_specialInfo:SetText(str)
  local spanX = self._ui._txt_specialInfo:GetTextSpan().x
  local textSizeX = self._ui._txt_specialInfo:GetTextSizeX() + spanX
  local specialBGSizeX = self._specailBG_DefaultSizeX
  local panelSizeX = Panel_Window_Barter_Search:GetSizeX()
  local pointX = 80
  if textSizeX > panelSizeX * 0.5 then
    self._ui._stc_specialInfoBG:SetSize(panelSizeX * 0.5, self._ui._stc_specialInfoBG:GetSizeY())
    self._ui._btn_specialBarterInfo:SetSize(panelSizeX * 0.5, self._ui._btn_specialBarterInfo:GetSizeY())
    self._ui._txt_specialInfo:SetSize(self._ui._btn_specialBarterInfo:GetSizeX() - pointX, self._ui._txt_specialInfo:GetSizeY())
    self._ui._txt_specialInfo:SetTextMode(__eTextMode_AutoWrap)
  elseif specialBGSizeX > textSizeX + pointX then
    self._ui._stc_specialInfoBG:SetSize(specialBGSizeX, self._ui._txt_specialInfo:GetSizeY())
    self._ui._btn_specialBarterInfo:SetSize(specialBGSizeX, self._ui._txt_specialInfo:GetSizeY())
  else
    self._ui._stc_specialInfoBG:SetSize(textSizeX + pointX, self._ui._txt_specialInfo:GetSizeY())
    self._ui._btn_specialBarterInfo:SetSize(textSizeX + pointX, self._ui._txt_specialInfo:GetSizeY())
  end
  self._ui._txt_specialInfo:SetText(str)
end
function PaGlobal_BarterInfoSearch:showFilterList()
  self._ui._filter:ToggleListbox()
end
function PaGlobal_BarterInfoSearch:setFilter()
  self._selectFilterIndex = self._ui._filter:GetSelectIndex()
  if self._selectFilterIndex < __eItemGradeNormal or __eItemGradeTypeCount < self._selectFilterIndex then
    self._selectFilterIndex = __eItemGradeTypeCount
  end
  self:refresh()
end
function PaGlobal_BarterInfoSearch:setNextValueLimit()
  if false == self._isConsole then
    return
  end
  local oldIndex = self._ui._valueLimit:GetSelectIndex()
  if 2 == oldIndex then
    oldIndex = 0
  else
    oldIndex = oldIndex + 1
  end
  self._ui._valueLimit:SetSelectItemIndex(oldIndex)
  self:setValueLimit()
end
function PaGlobal_BarterInfoSearch:showValueLimit()
  self._ui._valueLimit:ToggleListbox()
end
function PaGlobal_BarterInfoSearch:setValueLimit()
  if false == _ContentsGroup_Barter_Renew then
    return
  end
  self._selectValueLimitIndex = self._ui._valueLimit:GetSelectIndex() + 1
  if self._selectValueLimitIndex < 1 or self._selectValueLimitIndex > 3 then
    self._selectValueLimitIndex = 1
  end
  self:refresh()
end
function PaGlobal_BarterInfoSearch:setNextCategory()
  if false == self._isConsole then
    return
  end
  local oldIndex = self._ui._category:GetSelectIndex()
  if __eBarterCategory_Count == oldIndex then
    oldIndex = 1
  else
    oldIndex = oldIndex + 1
  end
  self._ui._category:SetSelectItemIndex(oldIndex)
  self:setCategory()
end
function PaGlobal_BarterInfoSearch:showCategory()
  self._ui._category:ToggleListbox()
end
function PaGlobal_BarterInfoSearch:setCategory()
  if false == _ContentsGroup_Barter_Renew then
    return
  end
  self._selectCategoryIndex = self._ui._category:GetSelectIndex() + 1
  if self._selectCategoryIndex < __eBarterCategory_NormalToLevel1 or __eBarterCategory_CrowCoin + 1 < self._selectCategoryIndex then
    self._selectCategoryIndex = __eBarterCategory_NormalToLevel1
  end
  local barterType = ToClient_getCurrentBarterType()
  if self._selectCategoryIndex == __eBarterCategory_Level1ToLevel2 or self._selectCategoryIndex == __eBarterCategory_Level2ToLevel3 or self._selectCategoryIndex == __eBarterCategory_Count then
    if __eBarterType_Normal == barterType then
      self._ui._valueLimit:SetShow(true)
      self._ui._category:SetShow(true)
    else
      self._ui._valueLimit:SetShow(false)
      self._ui._category:SetShow(false)
    end
  else
    if __eBarterType_Normal == barterType then
      self._ui._category:SetShow(true)
    else
      self._ui._category:SetShow(false)
    end
    self._ui._valueLimit:SetShow(false)
  end
  self:refresh()
end
function PaGlobal_BarterInfoSearch:popUpUI()
  if true == self._ui._btn_tray:IsCheck() then
    Panel_Window_Barter_Search:OpenUISubApp()
  else
    Panel_Window_Barter_Search:CloseUISubApp()
  end
end
function PaGlobal_BarterInfoSearch:popUpUITooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  control = self._ui._btn_tray
  name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
  if false == Panel_CharacterInfo_All:IsUISubApp() then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_BarterInfoSearch:SetCheckHideComplete()
  if false == self._isConsole then
    return
  end
  if true == self._ui._chk_hideComplete:IsCheck() then
    self._ui._chk_hideComplete:SetCheck(false)
  else
    self._ui._chk_hideComplete:SetCheck(true)
  end
  self:refresh()
end
function PaGlobal_BarterInfoSearch:setSearchFocus()
  SetFocusEdit(self._ui._edit)
end
function PaGlobal_BarterInfoSearch:setNextFilter()
  _PA_LOG("\235\176\149\234\183\156\235\130\152", "SetNextFilter")
  if false == self._isConsole then
    return
  end
  local oldIndex = self._selectFilterIndex
  if __eItemGradeTypeCount == oldIndex then
    oldIndex = 0
  else
    oldIndex = oldIndex + 1
  end
  self._ui._filter:SetSelectItemIndex(oldIndex)
  self:setFilter()
end
function PaGlobal_BarterInfoSearch:setKeyGuideAlign()
  if nil == Panel_Window_Barter_Search then
    return
  end
  self._ui._keyGuide_LS:SetShow(true == _ContentsGroup_RenewUI and true == Panel_Window_CargoLoading_ALL:GetShow())
  local keyGuide = {
    self._ui._keyGuide_LT_X,
    self._ui._keyGuide_LT_Y,
    self._ui._keyGuide_RT_X,
    self._ui._keyGuide_RT_Y,
    self._ui._keyGuide_LB_X,
    self._ui._keyGuide_LB_Y,
    self._ui._keyGuide_DPadL,
    self._ui._keyGuide_DPadU,
    self._ui._keyGuide_LS,
    self._ui._keyGuide_RS,
    self._ui._keyGuide_Y,
    self._ui._keyGuide_A,
    self._ui._keyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  local changeKeyGuideBgSize = self._ui._stc_keyGuideBG:GetSizeY()
  Panel_Window_Barter_Search:SetPosY(self._originalPanelPosY + (self._originalKeyGuideBgSize - changeKeyGuideBgSize))
end
