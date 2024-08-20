function PaGlobalFunc_House_InstallationMode_KeyGuide_All_Open()
  PaGlobal_House_InstallationMode_KeyGuide_All:prepareOpen()
end
function PaGlobalFunc_House_InstallationMode_KeyGuide_All_Close()
  PaGlobal_House_InstallationMode_KeyGuide_All:prepareClose()
end
function HandleEventLUp_House_InstallationMode_KeyGuide_All_CommandShowToggle()
  local isShowCommand = PaGlobal_House_InstallationMode_KeyGuide_All._ui._btn_showCommand:IsCheck()
  PaGlobal_House_InstallationMode_KeyGuide_All._ui._stc_commandBg:SetShow(isShowCommand)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eInstallationModeKeyGuideShow, isShowCommand, CppEnums.VariableStorageType.eVariableStorageType_User)
  PaGlobal_House_InstallationMode_KeyGuide_All:resize()
end
function FromClient_House_InstallationMode_KeyGuide_All_Resize()
  PaGlobal_House_InstallationMode_KeyGuide_All:resize()
end
function FromClient_House_InstallationMode_KeyGuide_All_ChangeInstallMode(preMode, nowMode)
  if true == PaGlobal_House_InstallationMode_KeyGuide_All._isConsole then
    return
  end
  PaGlobal_House_InstallationMode_KeyGuide_All._curModeState = nowMode
  if PaGlobal_House_InstallationMode_KeyGuide_All._eModeState.translation == nowMode or PaGlobal_House_InstallationMode_KeyGuide_All._eModeState.detail == nowMode or PaGlobal_House_InstallationMode_KeyGuide_All._eModeState.watingConfirm == nowMode then
    PaGlobal_House_InstallationMode_KeyGuide_All:prepareOpen()
  else
    PaGlobal_House_InstallationMode_KeyGuide_All:prepareClose()
  end
end
