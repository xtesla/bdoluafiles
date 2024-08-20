function PaGlobal_ToTargetKeyGuide:initialize()
  if true == PaGlobal_ToTargetKeyGuide._initialize then
    return
  end
  self._ui.txt_MouseBody_1 = UI.getChildControl(Panel_Widget_AttackWayCorrection_KeyGuide, "StaticText_Mouse_Body")
  self._ui.txt_MouseBody_2 = UI.getChildControl(Panel_Widget_AttackWayCorrection_KeyGuide, "StaticText_Mouse_Body_2")
  self._ui.txt_M0_1 = UI.getChildControl(Panel_Widget_AttackWayCorrection_KeyGuide, "StaticText_M0")
  self._ui.txt_M0_2 = UI.getChildControl(Panel_Widget_AttackWayCorrection_KeyGuide, "StaticText_M0_2")
  self._ui.txt_M1_1 = UI.getChildControl(Panel_Widget_AttackWayCorrection_KeyGuide, "StaticText_M1")
  self._ui.txt_M1_2 = UI.getChildControl(Panel_Widget_AttackWayCorrection_KeyGuide, "StaticText_M1_2")
  PaGlobal_ToTargetKeyGuide:registEventHandler()
  PaGlobal_ToTargetKeyGuide:validate()
  PaGlobal_ToTargetKeyGuide:reposition()
  self._initialize = true
end
function PaGlobal_ToTargetKeyGuide:registEventHandler()
  if nil == Panel_Widget_AttackWayCorrection_KeyGuide then
    return
  end
  registerEvent("FromClient_ToTargetKeyGuideOnOff", "FromClient_ToTargetKeyGuideOnOff")
end
function PaGlobal_ToTargetKeyGuide:validate()
  if nil == Panel_Widget_AttackWayCorrection_KeyGuide then
    return
  end
  self._ui.txt_MouseBody_1:isValidate()
  self._ui.txt_MouseBody_2:isValidate()
  self._ui.txt_M0_1:isValidate()
  self._ui.txt_M0_2:isValidate()
  self._ui.txt_M1_1:isValidate()
  self._ui.txt_M1_2:isValidate()
end
function PaGlobal_ToTargetKeyGuide:reposition()
  Panel_Widget_AttackWayCorrection_KeyGuide:SetPosX((getOriginScreenSizeX() - Panel_Widget_AttackWayCorrection_KeyGuide:GetSizeX()) * 0.3)
  Panel_Widget_AttackWayCorrection_KeyGuide:SetPosY((getOriginScreenSizeY() - Panel_Widget_AttackWayCorrection_KeyGuide:GetSizeY()) * 0.5)
end
