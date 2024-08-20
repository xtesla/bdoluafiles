function PaGlobal_Cop_Rank:initialize()
  local title = UI.getChildControl(Panel_Window_Cop_Rank, "Static_RankListTitle")
  self._ui.btn_close = UI.getChildControl(title, "Button_RankExit")
  self._rankWeb = UI.createControl(__ePAUIControl_WebControl, Panel_Window_Cop_Rank, "WebControl_Rank")
  self._rankWeb:SetShow(true)
  self._rankWeb:SetSize(1000, 610)
  self._rankWeb:SetHorizonCenter()
  self._rankWeb:SetVerticalTop()
  self._rankWeb:SetSpanSize(0, 60)
  self._rankWeb:ComputePos()
  self._rankWeb:ResetUrl()
  self:registEventHandler()
end
function PaGlobal_Cop_Rank:registEventHandler()
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Cop_Rank_Close()")
end
function PaGlobal_Cop_Rank:open()
  FGlobal_SetCandidate()
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = PaGlobal_URL_Check(worldNo)
  if nil == getSelfPlayer() then
    return
  end
  local userNo = getSelfPlayer():get():getUserNo()
  local characterNo = getSelfPlayer():getCharacterNo_64()
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local classType = getSelfPlayer():getClassType()
  url = url .. "/FameRank/RankList?userNo=" .. tostring(userNo) .. "&characterNo=" .. tostring(characterNo) .. "&certKey=" .. tostring(cryptKey)
  self._rankWeb:SetUrl(1000, 610, url, false, true)
  self._rankWeb:SetIME(true)
  Panel_Window_Cop_Rank:SetShow(true)
end
function PaGlobal_Cop_Rank:close()
  self._rankWeb:ResetUrl()
  Panel_Window_Cop_Rank:SetShow(false)
end
