function PaGlobal_ReplayLoadList:initialize()
  if true == self._initialize then
    return
  end
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_GroupCamera
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, PaGlobal_ReplayLoadList_Close)
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_ReplayLoadList_All, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleBG, "StaticText_Title")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Close")
  self._ui.stc_subTitleBG = UI.getChildControl(Panel_Window_ReplayLoadList_All, "Static_SubTitleArea")
  self._ui.txt_replayName = UI.getChildControl(self._ui.stc_subTitleBG, "StaticText_ReplayName")
  self._ui.txt_replayLength = UI.getChildControl(self._ui.stc_subTitleBG, "StaticText_Length")
  self._ui.stc_mainBG = UI.getChildControl(Panel_Window_ReplayLoadList_All, "Static_Main")
  self._ui.list2_replayList = UI.getChildControl(self._ui.stc_mainBG, "List2_ListBG")
  self._ui.stc_bottomBG = UI.getChildControl(Panel_Window_ReplayLoadList_All, "Static_BottomArea")
  self._ui.btn_refresh = UI.getChildControl(self._ui.stc_bottomBG, "Button_Refresh")
  self:initControl()
  self:createSlot()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ReplayLoadList:registEventHandler()
  if nil == Panel_Window_ReplayLoadList_All then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ReplayLoadList_Close()")
  self._ui.list2_replayList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_ReplayLoadList_CreateControlList2")
  self._ui.list2_replayList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_refresh:addInputEvent("Mouse_LUp", "PaGlobal_ReplayLoadList:reloadAndUpdate()")
end
function PaGlobal_ReplayLoadList:prepareOpen()
  if nil == Panel_Window_ReplayLoadList_All then
    return
  end
  if false == self._isLoad then
    ToClient_ReplayLoadTest()
    self._isLoad = true
  end
  self:listUpdate()
  self:open()
end
function PaGlobal_ReplayLoadList:open()
  if nil == Panel_Window_ReplayLoadList_All then
    return
  end
  Panel_Window_ReplayLoadList_All:SetShow(true)
end
function PaGlobal_ReplayLoadList:prepareClose()
  if nil == Panel_Window_ReplayLoadList_All then
    return
  end
  self:close()
end
function PaGlobal_ReplayLoadList:close()
  if nil == Panel_Window_ReplayLoadList_All then
    return
  end
  Panel_Window_ReplayLoadList_All:SetShow(false)
end
function PaGlobal_ReplayLoadList:update()
  if nil == Panel_Window_ReplayLoadList_All then
    return
  end
end
function PaGlobal_ReplayLoadList:validate()
  if nil == Panel_Window_ReplayLoadList_All then
    return
  end
  self._ui.stc_titleBG:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_subTitleBG:isValidate()
  self._ui.txt_replayName:isValidate()
  self._ui.txt_replayLength:isValidate()
  self._ui.stc_mainBG:isValidate()
  self._ui.list2_replayList:isValidate()
  self._ui.stc_bottomBG:isValidate()
  self._ui.btn_refresh:isValidate()
end
function PaGlobal_ReplayLoadList:reloadAndUpdate()
  ToClient_ReplayLoadTest()
  self:listUpdate()
end
function PaGlobal_ReplayLoadList:listUpdate()
  local loadListSize = ToClient_getLoadReplayDataSize()
  self._ui.list2_replayList:getElementManager():clearKey()
  if loadListSize > 0 then
    for ii = 0, loadListSize - 1 do
      self._ui.list2_replayList:getElementManager():pushKey(ii)
    end
  end
  self._ui.list2_replayList:ComputePos()
end
function PaGlobal_ReplayLoadList:refresh()
end
function PaGlobal_ReplayLoadList:initControl()
  Panel_Window_ReplayLoadList_All:ComputePos()
end
function PaGlobal_ReplayLoadList:setControl()
end
function PaGlobal_ReplayLoadList:createSlot()
end
