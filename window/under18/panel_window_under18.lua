local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
Panel_Message_Under18:SetShow(false, false)
local UnderMessage = {
  MsgText = nil,
  isShowTime = false,
  timer = 0,
  animationEndTime = 5,
  elapsedTime = 5
}
local aleartMessage = PAGetString(Defines.StringSheet_GAME, "SYSTEM_MESSAGE_TIME_ALERT_UNDER")
function FromClient_AdultMessage(playingTime)
  local timeMessage = PAGetStringParam1(Defines.StringSheet_GAME, "SYSTEM_MESSAGE_OVER_TIME_ALERT", "time", tostring(playingTime))
  chatting_sendMessage("", timeMessage, CppEnums.ChatType.System)
  chatting_sendMessage("", aleartMessage, CppEnums.ChatType.System)
  UnderMessage.MsgText1:SetText(timeMessage)
  UnderMessage.MsgText2:SetText(aleartMessage)
  UnderMessage:AnimationAdd()
  AdultMessage_OnResize()
  Panel_Message_Under18:SetShow(true, false)
end
function FromClient_UnderMessage_RestMessage(playingTime)
  local timeMessage = PAGetStringParam1(Defines.StringSheet_GAME, "SYSTEM_MESSAGE_OVER_TIME_ALERT", "time", tostring(playingTime))
  local restMessage = PAGetString(Defines.StringSheet_GAME, "SYSTEM_MESSAGE_TIME_ALERT")
  chatting_sendMessage("", restMessage, CppEnums.ChatType.System)
  chatting_sendMessage("", timeMessage, CppEnums.ChatType.System)
  UnderMessage.MsgText1:SetText(timeMessage)
  UnderMessage.MsgText2:SetText(restMessage)
  UnderMessage:AnimationAdd()
  AdultMessage_OnResize()
  Panel_Message_Under18:SetShow(true, false)
end
function UnderMessage:AnimationAdd()
  local aniInfo = Panel_Message_Under18:addColorAnimation(0, 0.3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
  local aniInfo2 = Panel_Message_Under18:addScaleAnimation(0.15, UnderMessage.animationEndTime - 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_PI)
  aniInfo2:SetStartScale(1)
  aniInfo2:SetEndScale(1)
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  local aniInfo3 = Panel_Message_Under18:addColorAnimation(UnderMessage.animationEndTime - 0.3, UnderMessage.animationEndTime, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo3:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo3.IsChangeChild = true
end
function PAGlobal_UnderMessage_Initialize()
  UnderMessage.MsgText1 = UI.getChildControl(Panel_Message_Under18, "StaticText_1")
  UnderMessage.MsgText2 = UI.getChildControl(Panel_Message_Under18, "StaticText_2")
  UnderMessage.MsgText1:SetText(" ")
  UnderMessage.MsgText2:SetText(" ")
end
function AdultMessage_OnResize()
  Panel_Message_Under18:ComputePos()
  if nil == UnderMessage.MsgText1 or nil == UnderMessage.MsgText2 then
    return
  end
  UnderMessage.MsgText1:ComputePos()
  UnderMessage.MsgText1:ComputePos()
end
registerEvent("FromClient_luaLoadComplete", "PAGlobal_UnderMessage_Initialize")
registerEvent("FromClient_AdultMessage", "FromClient_AdultMessage")
registerEvent("FromClient_RestMessage", "FromClient_UnderMessage_RestMessage")
registerEvent("onScreenResize", "AdultMessage_OnResize")
