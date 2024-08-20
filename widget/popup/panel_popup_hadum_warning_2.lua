function PaGlobal_Popup_Hadum_Warning_Open(key32)
  PaGlobal_Popup_HadumWarning._selectServerNo = key32
  PaGlobal_Popup_HadumWarning:prepareOpen()
end
function PaGlobal_Popup_HadumWarning_Close()
  PaGlobal_Popup_HadumWarning:prepareClose()
end
function HandleEventLUp_HadumWarning_EnterServer()
  PaGlobal_ServerSelect_All_HadumEnterAgree(PaGlobal_Popup_HadumWarning._selectServerNo)
  PaGlobal_Popup_HadumWarning_Close()
end
function HandleEventLUp_HadumWarning_TodayShow()
  PaGlobal_Popup_HadumWarning:setTodayShow()
end
