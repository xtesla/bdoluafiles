function PaGlobal_Widget_CrewMatch_Count:initialize()
  if true == PaGlobal_Widget_CrewMatch_Count._initialize then
    return
  end
  for ii = 1, 10 do
    PaGlobal_Widget_CrewMatch_Count._ui.stc_count[ii] = UI.getChildControl(Panel_Widget_CrewMatch_Count, "Static_Count_" .. ii)
    PaGlobal_Widget_CrewMatch_Count._ui.stc_count[ii]:SetShow(false)
  end
  PaGlobal_Widget_CrewMatch_Count:registEventHandler()
  PaGlobal_Widget_CrewMatch_Count:validate()
  PaGlobal_Widget_CrewMatch_Count._initialize = true
end
function PaGlobal_Widget_CrewMatch_Count:registEventHandler()
  if nil == Panel_Widget_CrewMatch_Count then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_Count_ReSizePanel")
end
function PaGlobal_Widget_CrewMatch_Count:prepareOpen()
  if nil == Panel_Widget_CrewMatch_Count then
    return
  end
  PaGlobal_Widget_CrewMatch_Count:open()
end
function PaGlobal_Widget_CrewMatch_Count:open()
  if nil == Panel_Widget_CrewMatch_Count then
    return
  end
  Panel_Widget_CrewMatch_Count:SetShow(true)
end
function PaGlobal_Widget_CrewMatch_Count:prepareClose()
  if nil == Panel_Widget_CrewMatch_Count then
    return
  end
  PaGlobal_Widget_CrewMatch_Count:close()
end
function PaGlobal_Widget_CrewMatch_Count:close()
  if nil == Panel_Widget_CrewMatch_Count then
    return
  end
  Panel_Widget_CrewMatch_Count:SetShow(false)
end
function PaGlobal_Widget_CrewMatch_Count:validate()
  if nil == Panel_Widget_CrewMatch_Count then
    return
  end
  for ii = 1, 10 do
    PaGlobal_Widget_CrewMatch_Count._ui.stc_count[ii]:isValidate()
  end
end
function PaGlobal_Widget_CrewMatch_Count:showCount(currentCount)
  if nil == Panel_Widget_CrewMatch_Count or false == Panel_Widget_CrewMatch_Count:GetShow() then
    return
  end
  for ii = 1, 10 do
    if ii == currentCount then
      local baseTexture = self._ui.stc_count[ii]:getBaseTexture()
      self._ui.stc_count[ii]:setRenderTexture(baseTexture)
      self._ui.stc_count[ii]:SetShow(true)
    else
      self._ui.stc_count[ii]:SetShow(false)
    end
  end
end
