function PaGlobal_Knave_Report:initialize()
  local stc_main = UI.getChildControl(Panel_Window_Knave_Report, "Static_Main")
  self._ui.list2 = UI.getChildControl(stc_main, "List2_KnaveList")
  self._ui.stc_descBG = UI.getChildControl(stc_main, "StaticText_ContentTitle")
  self._ui.stc_desc = UI.getChildControl(self._ui.stc_descBG, "StaticText_1")
  local descSizeY = self._ui.stc_desc:GetSizeY()
  self._ui.stc_desc:SetTextMode(__eTextMode_AutoWrap)
  local string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COP_KNAVE_REPORT_DESC")
  self._ui.stc_desc:SetText(string)
  if descSizeY < self._ui.stc_desc:GetTextSizeY() then
    local gab = self._ui.stc_desc:GetTextSizeY() - descSizeY
    self._ui.stc_descBG:SetSize(self._ui.stc_descBG:GetSizeX(), self._ui.stc_descBG:GetSizeY() + gab)
    self._ui.stc_desc:SetSize(self._ui.stc_desc:GetSizeX(), self._ui.stc_desc:GetSizeY() + gab)
    stc_main:SetSize(stc_main:GetSizeX(), stc_main:GetSizeY() + gab)
    Panel_Window_Knave_Report:SetSize(Panel_Window_Knave_Report:GetSizeX(), Panel_Window_Knave_Report:GetSizeY() + gab)
  end
  local stc_titleBg = UI.getChildControl(Panel_Window_Knave_Report, "Static_TitleBg")
  self._ui.btn_Close = UI.getChildControl(stc_titleBg, "Button_Close")
  self._ui.stc_notarget = UI.getChildControl(stc_main, "StaticText_NoTarget")
  self._ui.stc_notarget:SetShow(false)
  self._ui.btn_cancel = UI.getChildControl(stc_main, "Button_Cancel")
  self._ui.list2:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.btn_report = UI.getChildControl(stc_main, "Button_Report")
  self._ui.btn_cancel:ComputePos()
  self._ui.btn_report:ComputePos()
  self:registEventHandler()
end
function PaGlobal_Knave_Report:registEventHandler()
  self._ui.list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_KnaveReport_List2Update")
  self._ui.list2:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_Knave_Report:close()")
  self._ui.btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_Knave_Report:close()")
  self._ui.btn_report:addInputEvent("Mouse_LUp", "HandleEventLUp_reportKnave()")
end
function PaGlobal_Knave_Report:update()
  ToClient_updateKnaveList()
  local size = ToClient_getKnaveListSize()
  if size <= 0 then
    self._ui.list2:getElementManager():clearKey()
    self._ui.stc_notarget:SetShow(true)
    return
  end
  self._ui.list2:getElementManager():clearKey()
  for idx = 1, size do
    self._ui.list2:getElementManager():pushKey(toInt64(0, idx))
  end
end
function PaGlobal_Knave_Report:close()
  if -1 ~= PaGlobal_Knave_Report._reportIndex then
    local preContent = self._ui.list2:GetContentByKey(PaGlobal_Knave_Report._reportIndex + 1)
    if nil ~= preContent then
      local preBtn = UI.getChildControl(preContent, "RadioButton_1")
      if nil ~= preBtn then
        preBtn:SetCheck(false)
      end
    end
  end
  PaGlobal_Knave_Report._reportIndex = -1
  Panel_Window_Knave_Report:SetShow(false)
end
function PaGlobal_Knave_Report:open()
  Panel_Window_Knave_Report:ComputePos()
  self._ui.stc_notarget:SetShow(false)
  PaGlobal_Knave_Report:update()
  Panel_Window_Knave_Report:SetShow(true)
end
function FromClient_KnaveReport_List2Update(content, key)
  local key32 = Int64toInt32(key)
  local knaveName = ToClient_getKnaveName(key32 - 1)
  if nil == knaveName then
    return
  end
  local btn = UI.getChildControl(content, "RadioButton_1")
  if nil == btn then
    return
  end
  btn:SetText(knaveName)
  btn:SetShow(true)
  btn:addInputEvent("Mouse_LUp", "HandleEventLUp_SetReportIndex(" .. key32 - 1 .. ")")
end
function HandleEventLUp_SetReportIndex(key)
  if -1 ~= PaGlobal_Knave_Report._reportIndex then
    local preContent = PaGlobal_Knave_Report._ui.list2:GetContentByKey(PaGlobal_Knave_Report._reportIndex + 1)
    if nil ~= preContent then
      local preBtn = UI.getChildControl(preContent, "RadioButton_1")
      if nil ~= preBtn then
        preBtn:SetCheck(false)
      end
    end
  end
  if PaGlobal_Knave_Report._reportIndex == key then
    local preContent = PaGlobal_Knave_Report._ui.list2:GetContentByKey(PaGlobal_Knave_Report._reportIndex + 1)
    if nil ~= preContent then
      local preBtn = UI.getChildControl(preContent, "RadioButton_1")
      if nil ~= preBtn then
        preBtn:SetCheck(false)
        PaGlobal_Knave_Report._reportIndex = -1
        return
      end
    end
  end
  PaGlobal_Knave_Report._reportIndex = key
end
function HandleEventLUp_reportKnave()
  if -1 == PaGlobal_Knave_Report._reportIndex then
    return
  end
  ToClient_reportKnave(PaGlobal_Knave_Report._reportIndex)
end
