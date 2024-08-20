local _panel = Panel_ItemWarp_All
function PaGlobal_Itemwarp:init()
  PaGlobal_Itemwarp._ui.stc_Partline = UI.getChildControl(_panel, "Static_PartLine")
  PaGlobal_Itemwarp._ui.btn_Close = UI.getChildControl(PaGlobal_Itemwarp._ui.stc_Partline, "Button_CloseIcon")
  PaGlobal_Itemwarp._ui.list2_Town = UI.getChildControl(_panel, "List2_TownList")
  PaGlobal_Itemwarp._ui.btn_Apply = UI.getChildControl(_panel, "Button_Apply_PCUI")
  PaGlobal_Itemwarp._ui.stc_KeyGuideBG = UI.getChildControl(_panel, "Static_KeyGuideBg_ConsoleUI")
  PaGlobal_Itemwarp._ui.stc_KeyGuide_A = UI.getChildControl(PaGlobal_Itemwarp._ui.stc_KeyGuideBG, "StaticText_Move")
  PaGlobal_Itemwarp._ui.stc_KeyGuide_B = UI.getChildControl(PaGlobal_Itemwarp._ui.stc_KeyGuideBG, "StaticText_Close")
  PaGlobal_Itemwarp._isConsole = _ContentsGroup_UsePadSnapping
  if true == PaGlobal_Itemwarp._isConsole then
    PaGlobal_Itemwarp._ui.btn_Close:SetShow(false)
    PaGlobal_Itemwarp._ui.btn_Apply:SetShow(false)
    local keyguides = {
      PaGlobal_Itemwarp._ui.stc_KeyGuide_A,
      PaGlobal_Itemwarp._ui.stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, PaGlobal_Itemwarp._ui.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  else
    PaGlobal_Itemwarp._ui.stc_KeyGuideBG:SetShow(false)
  end
  PaGlobal_Itemwarp:validate()
  PaGlobal_Itemwarp:registEventHandler()
end
function PaGlobal_Itemwarp:prepareOpen()
  if true == Panel_ItemWarp_All:GetShow() then
    return
  end
  PaGlobal_Itemwarp._selectTownKey = 0
  PaGlobal_Itemwarp:open()
  PaGlobal_PaGlobal_Itemwarp_OnResize()
end
function PaGlobal_Itemwarp:open()
  if true == Panel_ItemWarp_All:GetShow() then
    return
  end
  _panel:SetShow(true)
end
function PaGlobal_Itemwarp:prepareClose()
  if false == Panel_ItemWarp_All:GetShow() then
    return
  end
  PaGlobal_Itemwarp:close()
end
function PaGlobal_Itemwarp:close()
  if false == Panel_ItemWarp_All:GetShow() then
    return
  end
  _panel:SetShow(false)
end
function PaGlobal_Itemwarp:update()
end
function PaGlobal_Itemwarp:itemUseNotify(whereType, slotNo, regionKey)
  PaGlobal_Itemwarp._selectWhereType = whereType
  PaGlobal_Itemwarp._selectSlotNo = slotNo
  PaGlobal_Itemwarp._selectTownKey = 0
  if 0 == regionKey then
    PaGlobal_Itemwarp:prepareOpen()
    PaGlobal_Itemwarp._ui.list2_Town:getElementManager():clearKey()
    local nearTownListCount = getSelfPlayer():get():getNearTownRegionInfoCount()
    for key = 0, nearTownListCount - 1 do
      PaGlobal_Itemwarp._ui.list2_Town:getElementManager():pushKey(toInt64(0, key))
    end
  else
    PaGlobal_Itemwarp:gotoSelectTown(regionKey)
  end
end
function PaGlobal_Itemwarp:gotoSelectTown(regionKey)
  local regionInfo, areaName
  if nil == regionKey then
    regionInfo = getSelfPlayer():get():getNearTownRegionInfoAt(PaGlobal_Itemwarp._selectTownKey)
    areaName = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMWARP_NEARESTTOWN_2")
  else
    regionInfo = getRegionInfoByRegionKey(RegionKey(regionKey))
  end
  local regionKeyRowType = 0
  if regionInfo:get() ~= nil then
    areaName = regionInfo:getAreaName()
    regionKeyRowType = regionInfo:getRegionKey()
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTITEM_NOT_HORSERACING"))
    return
  end
  local function gotoTown()
    Panel_ItemWarp_All_Close()
    getSelfPlayer():get():setNearTownByWarpItem(PaGlobal_Itemwarp._selectWhereType, PaGlobal_Itemwarp._selectSlotNo, RegionKey(regionKeyRowType))
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMWARP_MSGCONTENT", "areaName", areaName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMWARP_MSGTITLE"),
    content = messageBoxMemo,
    functionYes = gotoTown,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Itemwarp:registEventHandler()
  registerEvent("onScreenResize", "PaGlobal_PaGlobal_Itemwarp_OnResize")
  registerEvent("FromClient_UseWarpItemNotify", "FromClient_Itemwarp_UseNotify")
  _panel:RegisterShowEventFunc(true, "Panel_ItemWarp_All_ShowAni()")
  _panel:RegisterShowEventFunc(false, "Panel_ItemWarp_All_HideAni()")
  PaGlobal_Itemwarp._ui.list2_Town:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_Itemwarp_TownListCreate")
  PaGlobal_Itemwarp._ui.list2_Town:createChildContent(__ePAUIList2ElementManagerType_List)
  if true == PaGlobal_Itemwarp._isConsole then
    _panel:ignorePadSnapMoveToOtherPanel()
    _panel:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Itemwarp_GotoSelectTown()")
  else
    PaGlobal_Itemwarp._ui.btn_Close:addInputEvent("Mouse_LUp", "Panel_ItemWarp_All_Close()")
    PaGlobal_Itemwarp._ui.btn_Apply:addInputEvent("Mouse_LUp", "HandleEventLUp_Itemwarp_GotoSelectTown()")
  end
end
function PaGlobal_Itemwarp:validate()
  PaGlobal_Itemwarp._ui.stc_Partline:isValidate()
  PaGlobal_Itemwarp._ui.btn_Close:isValidate()
  PaGlobal_Itemwarp._ui.list2_Town:isValidate()
  PaGlobal_Itemwarp._ui.btn_Apply:isValidate()
  PaGlobal_Itemwarp._ui.stc_KeyGuideBG:isValidate()
  PaGlobal_Itemwarp._ui.stc_KeyGuide_A:isValidate()
  PaGlobal_Itemwarp._ui.stc_KeyGuide_B:isValidate()
end
function PaGlobal_PaGlobal_Itemwarp_OnResize()
  if false == Panel_ItemWarp_All:GetShow() then
    return
  end
  _panel:ComputePos()
end
