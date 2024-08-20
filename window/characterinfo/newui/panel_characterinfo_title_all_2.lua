function PaGlobalFunc_CharInfoTitle_All_Update()
  if false == Panel_CharacterInfo_All:GetShow() then
    return
  end
  PaGlobal_CharInfoTitle_All:dataClear()
  PaGlobal_CharInfoTitle_All:update()
  PaGlobal_CharInfoTitle_All:updateCoolTime()
end
function FromClient_CharInfoTitle_Update()
  if true == PaGlobal_CharInfoTitle_All._isApplied then
    PaGlobal_CharInfoTitle_All._ui.list2_Title:requestUpdateVisible()
    PaGlobal_CharInfoTitle_All._isApplied = false
  else
    PaGlobal_CharInfoTitle_All:update()
  end
  PaGlobal_CharInfoTitle_All:setAppliedTitleButton()
  PaGlobal_CharInfoTitle_All:updateCoolTime()
end
function HandleEventPadPress_CharInfoTitle_SelectCategory(isUp)
  local curTab = PaGlobal_CharInfoTitle_All._currentTab
  if true == isUp then
    curTab = curTab + 1
    if curTab > #PaGlobal_CharInfoTitle_All._ui.rdo_tabTable then
      curTab = 0
    end
  else
    curTab = curTab - 1
    if curTab < 0 then
      curTab = #PaGlobal_CharInfoTitle_All._ui.rdo_tabTable
    end
  end
  HandleEventLUp_CharInfoTitle_SelectCategory(curTab)
end
function HandleEventLUp_CharInfoTitle_SelectCategory(idx)
  if nil == idx or false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._title) then
    return
  end
  if PaGlobal_CharInfoTitle_All._currentTab ~= idx and nil ~= PaGlobal_CharInfoTitle_All._currentTab then
    PaGlobal_CharInfoTitle_All._ui.rdo_tabTable[PaGlobal_CharInfoTitle_All._currentTab]:SetCheck(false)
  end
  ToClient_SetCurrentTitleCategory(idx)
  PaGlobal_CharInfoTitle_All._currentTab = idx
  PaGlobal_CharInfoTitle_All._ui.rdo_tabTable[idx]:SetCheck(true)
  PaGlobal_CharInfoTitle_All._curCategoryCount = ToClient_GetCategoryTitleCount(idx)
  local selectLine = PaGlobal_CharInfoTitle_All._ui.stc_SelectBar
  local currentSelectBar = PaGlobal_CharInfoTitle_All._ui.rdo_tabTable[idx]
  selectLine:SetSpanSize(currentSelectBar:GetSpanSize().x, selectLine:GetSpanSize().y)
  PaGlobal_CharInfoTitle_All._list2ScrollData._list2Idx = 0
  PaGlobal_CharInfoTitle_All._list2ScrollData._ScrollPos = 0
  local lastCount = PaGlobal_CharInfoTitle_All._curCategoryCount
  if lastCount < 1 then
    return
  end
  local list2 = PaGlobal_CharInfoTitle_All._ui.list2_Title
  list2:getElementManager():clearKey()
  for titleIndex = 0, lastCount - 1 do
    list2:getElementManager():pushKey(toInt64(0, titleIndex))
  end
  if true == PaGlobal_CharInfoTitle_All._isFiltered then
    PaGlobal_CharInfoTitle_All:updateFilteredList()
  end
  PaGlobal_CharInfoTitle_All:updateCoolTime()
end
function FromClient_CharInfoTitle_AquireTitle(keyValue, noop)
  local set = ToClient_setNewTitleByAlarm(keyValue)
  UI.ASSERT_NAME(false ~= set, "\237\154\141\235\147\157\237\149\156 \236\185\173\237\152\184\234\176\128 list\236\151\144 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\235\176\149\234\180\145\236\154\180")
end
function FromClient_CharInfoTitle_List2AnimationStop()
  ToClient_ActiveEffectAllNewTitle()
end
function FromClient_CharInfoTitle_List2Update(content, key)
  local key32 = Int64toInt32(key)
  local titleWrapper = ToClient_GetTitleStaticStatusWrapper(key32)
  if nil == titleWrapper then
    return
  end
  local rdo_name = UI.getChildControl(content, "RadioButton_TilteName")
  local chkBox = UI.getChildControl(rdo_name, "CheckButton_1")
  rdo_name:setNotImpactScrollEvent(true)
  rdo_name:SetText(titleWrapper:getName())
  content:EraseAllEffect()
  content:setNotImpactScrollEvent(true)
  ToClient_insertNewTitleUI(titleWrapper:getKey(), content)
  if rdo_name:GetTextSizeX() + 25 > content:GetSizeX() - 25 then
    rdo_name:SetIgnore(false)
    UI.setLimitTextAndAddTooltip(rdo_name)
  end
  if key32 ~= PaGlobal_CharInfoTitle_All._list2ScrollData._list2Idx then
    rdo_name:SetCheck(false)
  end
  local isAcquired = titleWrapper:isAcquired()
  rdo_name:SetMonoTone(not isAcquired, not isAcquired)
  local isApplied = ToClient_IsAppliedTitle(titleWrapper:getKey())
  chkBox:SetShow(isApplied)
  if false == PaGlobal_CharInfoTitle_All._isConsole then
    rdo_name:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoTitle_SelectTitle(" .. key32 .. ")")
  else
    rdo_name:addInputEvent("Mouse_On", "HandleEventLUp_CharInfoTitle_SelectTitle(" .. key32 .. ")")
    rdo_name:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoTitle_ApplyTitle()")
  end
end
function HandleEventLUp_CharInfoTitle_SelectTitle(idx)
  if nil == idx then
    return
  end
  if true == PaGlobal_CharInfoTitle_All._isConsole and true == PaGlobal_CharInfoTitle_All._ui.comb_Filter:GetShow() then
    return
  end
  local titleWrapper = ToClient_GetTitleStaticStatusWrapper(idx)
  if nil == titleWrapper then
    return
  end
  local list2 = PaGlobal_CharInfoTitle_All._ui.list2_Title
  PaGlobal_CharInfoTitle_All._saveTab = PaGlobal_CharInfoTitle_All._currentTab
  PaGlobal_CharInfoTitle_All._list2ScrollData._list2Idx = idx
  PaGlobal_CharInfoTitle_All._list2ScrollData._ScrollPos = list2:GetVScroll():GetControlPos()
  PaGlobal_CharInfoTitle_All._ui.btn_Apply:SetShow(not PaGlobal_CharInfoTitle_All._isConsole)
  PaGlobal_CharInfoTitle_All:setTitleText(titleWrapper)
  if false == PaGlobal_CharInfoTitle_All._isConsole then
    local isApplied = ToClient_IsAppliedTitle(titleWrapper:getKey())
    if true == titleWrapper:isAcquired() then
      if true == isApplied then
        PaGlobal_CharInfoTitle_All._ui.btn_Apply:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_RELEASE"))
      else
        PaGlobal_CharInfoTitle_All._ui.btn_Apply:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MARKETPLACE_KEYGUIDE_APPLY"))
      end
    else
      PaGlobal_CharInfoTitle_All._ui.btn_Apply:SetShow(false)
    end
  end
  PaGlobal_CharInfoTitle_All:alignTitleTextForGlobal(PaGlobal_CharInfoTitle_All._ui.btn_Apply:GetShow())
  if true == PaGlobal_CharInfoTitle_All._ui.btn_Apply:GetShow() then
    PaGlobal_CharInfoTitle_All._ui.txt_TitleCondi:SetHorizonLeft()
    PaGlobal_CharInfoTitle_All._ui.txt_TitleCondi:SetSpanSize(20, PaGlobal_CharInfoTitle_All._ui.txt_TitleCondi:GetSpanSize().y)
  else
    PaGlobal_CharInfoTitle_All._ui.txt_TitleCondi:SetHorizonCenter()
    PaGlobal_CharInfoTitle_All._ui.txt_TitleCondi:SetSpanSize(0, PaGlobal_CharInfoTitle_All._ui.txt_TitleCondi:GetSpanSize().y)
  end
  PaGlobal_CharInfoTitle_All._isApplyBtnShow = PaGlobal_CharInfoTitle_All._ui.btn_Apply:GetShow()
  PaGlobal_CharInfoTitle_All._selectedIdx = idx
end
function HandleEventLUp_CharInfoTitle_ApplyTitle()
  if nil == PaGlobal_CharInfoTitle_All._selectedIdx then
    return
  end
  PaGlobal_CharInfoTitle_All:updateCoolTime()
  if nil ~= PaGlobal_CharInfoTitle_All._saveTab and 0 >= ToClient_GetUpdateTitleDelay() then
    ToClient_SetCurrentTitleCategory(PaGlobal_CharInfoTitle_All._saveTab)
    ToClient_TitleSetRequest(PaGlobal_CharInfoTitle_All._saveTab, PaGlobal_CharInfoTitle_All._selectedIdx)
    ToClient_SetCurrentTitleCategory(PaGlobal_CharInfoTitle_All._currentTab)
    PaGlobal_CharInfoTitle_All._saveTab = nil
  else
    ToClient_TitleSetRequest(PaGlobal_CharInfoTitle_All._currentTab, PaGlobal_CharInfoTitle_All._selectedIdx)
  end
  PaGlobal_CharInfoTitle_All._isApplied = true
end
function HandleEventLUp_CharInfoTitle_ToggleFilter()
  PaGlobal_CharInfoTitle_All._ui.stc_FilterBg:ToggleListbox()
  if true == PaGlobal_CharInfoTitle_All._isConsole then
    ToClient_padSnapChangeToTarget(PaGlobal_CharInfoTitle_All._ui.stc_FilterBg)
  end
end
function HandleEventLUp_CharInfoTitle_SelectFilter()
  audioPostEvent_SystemUi(0, 0)
  PaGlobal_CharInfoTitle_All:updateFilteredList()
end
function HandleEventLUp_CharInfoTitle_ClickSearchBox()
  PaGlobal_CharInfoTitle_All:updateFilteredList()
  if true == PaGlobal_CharInfoTitle_All._isConsole then
    ClearFocusEdit()
  end
end
function HandleEventLUp_CharInfoTitle_ClickEditBox()
  PaGlobal_CharInfoTitle_All._ui.edit_Title:SetEditText("")
end
function HandleEventOnOut_CharInfoTitle_TabBtnTooltip(idx)
  if nil == idx or true == PaGlobal_CharInfo_All._isConsole then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_CharInfoTitle_All._ui.rdo_tabTable then
    return
  end
  local control, name, desc
  control = PaGlobal_CharInfoTitle_All._ui.rdo_tabTable[idx]
  if idx == PaGlobal_CharInfoTitle_All._eTITLETYPE._WORLD then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_TITLE_RDOBTN_ALLROUND")
  elseif idx == PaGlobal_CharInfoTitle_All._eTITLETYPE._COMBAT then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_TITLE_RDOBTN_COMBAT")
  elseif idx == PaGlobal_CharInfoTitle_All._eTITLETYPE._LIFE then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_TITLE_RDOBTN_PRODUCT")
  else
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_TITLE_RDOBTN_FISH")
  end
  TooltipSimple_Show(control, name, dsec)
end
function HandleEventOn_CharInfoTitle_QuestionTooltip(isShow)
  if nil == isShow then
    local show = PaGlobal_CharInfoTitle_All._ui.stc_TitleTooltip:GetShow()
    PaGlobal_CharInfoTitle_All._ui.stc_TitleTooltip:SetShow(not show)
  else
    PaGlobal_CharInfoTitle_All._ui.stc_TitleTooltip:SetShow(isShow)
    if isShow == true then
      if true == Panel_CharacterInfo_All:IsUISubApp() then
        PaGlobal_CharInfoTitle_All._ui.stc_TitleTooltip:SetPosX(Panel_CharacterInfo_All:GetPosX())
        PaGlobal_CharInfoTitle_All._ui.stc_TitleTooltip:SetPosY(0)
      else
        PaGlobal_CharInfoTitle_All._ui.stc_TitleTooltip:SetPosX(PaGlobal_CharInfoTitle_All._ui.titleTooltipPosX)
        PaGlobal_CharInfoTitle_All._ui.stc_TitleTooltip:SetPosY(PaGlobal_CharInfoTitle_All._ui.titleTooltipPosY)
      end
    end
  end
end
function PaGlobal_CharinfoTitle_OpenVirtualKeyboard()
  SetFocusEdit(PaGlobal_CharInfoTitle_All._ui.edit_Title)
end
function PaGlobal_CharinfoTitle_CloseVirtualKeyboard(str)
  ClearFocusEdit()
  PaGlobal_CharInfoTitle_All._ui.edit_Title:SetEditText(str)
  PaGlobal_CharInfoTitle_All:updateFilteredList()
  HandleEventLUp_CharInfoTitle_ClickSearchBox()
end
function PaGlobal_CharinfoTitle_LinkAcquireTitle(linkTitle, linkCategory)
  PaGlobal_CharInfoTitle_All._linkTitleKeyRaw = linkTitle
  PaGlobal_CharInfoTitle_All._linkTitleCategory = linkCategory
  HandleEventLUp_CharInfoTitle_SelectCategory(linkCategory)
  if 0 ~= PaGlobal_CharInfoTitle_All._curCategoryCount then
    local titleCategoryListIndex = ToClient_FindTitleCategoryListIndexByTitleKey(linkTitle)
    if -1 == titleCategoryListIndex then
      PaGlobal_CharInfoTitle_All._linkTitleKeyRaw = 0
      PaGlobal_CharInfoTitle_All._linkTitleCategory = 0
      PaGlobal_CharInfoTitle_All._linkFindIndex = -1
      return
    end
    local progress = titleCategoryListIndex / PaGlobal_CharInfoTitle_All._curCategoryCount
    PaGlobal_CharInfoTitle_All._ui.list2_Title:setCurrenttoIndex(titleCategoryListIndex)
    PaGlobal_CharInfoTitle_All._ui.list2_Title:GetVScroll():SetControlPos(progress)
    PaGlobal_CharInfoTitle_All._linkTitleKeyRaw = linkTitle
    PaGlobal_CharInfoTitle_All._linkTitleCategory = 0
    PaGlobal_CharInfoTitle_All._linkFindIndex = titleCategoryListIndex
  else
    PaGlobal_CharInfoTitle_All._ui.list2_Title:setCurrenttoIndex(0)
    PaGlobal_CharInfoTitle_All._ui.list2_Title:GetVScroll():SetControlPos(0)
    PaGlobal_CharInfoTitle_All._linkTitleKeyRaw = 0
    PaGlobal_CharInfoTitle_All._linkTitleCategory = 0
    PaGlobal_CharInfoTitle_All._linkFindIndex = -1
  end
end
