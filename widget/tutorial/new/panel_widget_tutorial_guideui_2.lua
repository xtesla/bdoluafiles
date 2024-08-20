function FromClient_changePanelSetShow(key, id, isShow)
  if false == Panel_Widget_Tutorial_GuideUI:GetShow() then
    return
  end
  ToClient_updateConditionSetShowPanelFromTutorial(key, isShow)
end
function FromClient_uiBaseInputEventType(parentKey, parentID, childKey, childID, eventType)
  if false == Panel_Widget_Tutorial_GuideUI:GetShow() then
    return
  end
  ToClient_updateConditionUIBaseInputEventFromTutorial(parentKey, childKey, eventType)
end
function FromClient_updateProgressingTutorial()
  local self = PaGlobal_Widget_Tutorial_GuideUI
  local wrapper = ToClient_getProgressingTutorialWrapper()
  if nil == wrapper then
    _PA_ASSERT(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    return
  end
  if true == wrapper:isComplete() then
    self:complete(wrapper:getKey())
  else
    self:update()
  end
end
function FromClient_initProgressingTutorial()
  PaGlobal_Widget_Tutorial_GuideUI:prepareOpen()
end
function FromClient_clearProgressingTutorial()
  PaGlobal_Widget_Tutorial_GuideUI:prepareClose()
end
function PaGlobalFunc_Widget_Tutorial_GuideUI_Update(deltaTime)
  local self = PaGlobal_Widget_Tutorial_GuideUI
  if true == self._effectInfo:isDefined() then
    self._effectInfo:update(deltaTime)
  end
  if nil ~= self:isKeyDown_Once() then
    ToClient_updateConditionAnyInputFromTutorial()
  end
end
