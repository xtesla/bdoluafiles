function PaGlobalFunc_MaidList_All_Open()
  PaGlobal_MaidList_All:prepareOpen()
end
function PaGlobalFunc_MaidList_All_Close()
  PaGlobal_MaidList_All:prepareClose()
end
function PadEventRBLB_PaGlobal_MaidList_All_NextTab(val)
  if nil == Panel_Window_MaidList_All then
    return
  end
  if nil == val then
    _PA_ASSERT_NAME(false, "HandleEventLUp_MaidList_All_Update:\236\158\152\235\170\187\235\144\156 val \234\176\146\236\158\133\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local nextTab = PaGlobal_MaidList_All._currentTab + val
  if nextTab > #PaGlobal_MaidList_All._ui_console.rdo_tabs then
    nextTab = 1
  elseif nextTab < 1 then
    nextTab = #PaGlobal_MaidList_All._ui_console.rdo_tabs
  end
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  PaGlobal_MaidList_All:setTabTo(nextTab)
end
function HandleEventLUp_MaidList_All_Update(index)
  if nil == Panel_Window_MaidList_All then
    return
  end
  if nil == index then
    _PA_ASSERT_NAME(false, "HandleEventLUp_MaidList_All_Update:\236\158\152\235\170\187\235\144\156 index \234\176\146\236\158\133\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  PaGlobal_MaidList_All:setTabTo(index)
end
function HandleEventOnOut_MaidList_All_SimpleTooltip(isShow, tipType)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "INTERACTION_MENU10")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_OPENWAREHOUSEBYMAID_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = PaGlobal_MaidList_All._ui_pc.btn_warehouse
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_MAID_MARKETOPENBYMAID_BUTTON_TOOLTIP")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_OPENMARKETBYMAID_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = PaGlobal_MaidList_All._ui_pc.btn_market
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MAIDLIST_MARKETPLACE_OPEN")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_MARKETPLACE_WALLETINVENTORY_SELLTOOLTIPDESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = PaGlobal_MaidList_All._ui_pc.btn_marketPlace
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MAIDLIST_REGISTEPCROOMMAIDBUTTON")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_MAIDLIST_ALL_PCROOM_REGISTER_DESC")
    control = PaGlobal_MaidList_All._ui_pc.btn_pcRoom
  elseif 4 == tipType and nil ~= PaGlobal_MaidList_All._ui.chk_UseMultiMaid and true == PaGlobal_MaidList_All._ui.chk_UseMultiMaid:GetShow() then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MAIDLIST_SETMAX")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDORDER_GROUP_DESC")
    control = PaGlobal_MaidList_All._ui.chk_UseMultiMaid
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_MaidList_All_ClickPcRoomBtn()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_MAIDLIST_ALL_PCROOM_MESSAGEBOX_DESC"),
    functionYes = HandleEventLUp_MaidList_All_RegistPCRoomMaid,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_MaidList_All_RegistPCRoomMaid()
  if nil == Panel_Window_MaidList_All then
    return
  end
  ToClient_RegistPcRoomMaid()
  PaGlobal_MaidList_All._ui_pc.btn_pcRoom:SetShow(false)
end
function HandleEventLDown_MaidList_All_ScaleResizeStart()
  PaGlobal_MaidList_All._panelOpenPosX = Panel_Window_MaidList_All:GetPosX()
  PaGlobal_MaidList_All._panelOpenPosY = Panel_Window_MaidList_All:GetPosY()
  UI.PanelDynamicSacle_ResizeStart(Panel_Window_MaidList_All)
end
function HandleEventLPress_MaidList_All_ScaleResizing()
  UI.PanelDynamicSacle_ResizePressing(Panel_Window_MaidList_All)
  PaGlobal_MaidList_All:setTabTo(PaGlobal_MaidList_All._currentTab)
  PaGlobal_MaidList_All._ui.list2_maid:requestUpdateVisible()
  Panel_Window_MaidList_All:SetPosX(PaGlobal_MaidList_All._panelOpenPosX)
  Panel_Window_MaidList_All:SetPosY(PaGlobal_MaidList_All._panelOpenPosY)
end
function HandleEventLUp_MaidList_All_ScaleResizeEnd()
  UI.PanelDynamicSacle_ResizeEnd(Panel_Window_MaidList_All)
end
function onScreenResize_MaidList_All_Resize()
  PaGlobal_MaidList_All:resize()
end
function FromClient_RefreshMaidList_MaidList_All()
  if nil == Panel_Window_MaidList_All then
    return
  end
  PaGlobal_MaidList_All:updateData(PaGlobal_MaidList_All._currentTab)
  PaGlobal_MaidList_All:pushDataToList()
end
function FromClient_MaidList_All_RefreshPcRoomState()
  if true == PaGlobal_MaidList_All._isConsole then
    return
  end
  local isShow = ToClient_isShowRegistPcRoomMaidButton()
  if true == isShow then
    PaGlobal_MaidList_All._ui_pc.btn_pcRoom:SetShow(true)
  else
    PaGlobal_MaidList_All._ui_pc.btn_pcRoom:SetShow(false)
  end
end
function PaGlobalFunc_MaidList_All_IsCheckedUseMultiMaid(isMarket)
  if nil == Panel_Window_MaidList_All then
    return
  end
  return PaGlobal_MaidList_All:isCheckMaidChief(isMarket)
end
function HandleEventLUp_MaidList_All_UseMultiMaidClick()
  if false == _ContentsGroup_UsePadSnapping then
    PaGlobal_MaidList_All._ui.chk_UseMultiMaid:SetCheck(PaGlobal_MaidList_All._ui.chk_UseMultiMaid:IsCheck())
  else
    PaGlobal_MaidList_All._ui.chk_UseMultiMaid:SetCheck(not PaGlobal_MaidList_All._ui.chk_UseMultiMaid:IsCheck())
  end
  local result = PaGlobal_MaidList_All._ui.chk_UseMultiMaid:IsCheck()
  PaGlobal_MaidList_All:keyGuideAlign(result)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUseMultiMaid, result, CppEnums.VariableStorageType.eVariableStorageType_User)
end
