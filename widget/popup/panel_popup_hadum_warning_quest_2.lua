function PaGlobal_HadumWarning_Quest_Open()
  PaGlobal_HadumWarning_Quest:prepareOpen()
end
function PaGlobal_HadumWarning_Quest_Close()
  PaGlobal_HadumWarning_Quest:prepareClose()
end
function PaGlobal_HadumWarning_Quest_SetOpenFlag()
  PaGlobal_HadumWarning_Quest._openFlag = true
end
function PaGlobal_HadumWarning_Quest_IsShow()
  if nil == Panel_Popup_Hadum_Warning_Quest then
    return false
  end
  return Panel_Popup_Hadum_Warning_Quest:GetShow()
end
