function PaGlobalFunc_UserSetting_Open()
  if nil == PaGlobal_LobbyUserSetting then
    return
  end
  PaGlobal_LobbyUserSetting:prepareOpen()
end
function PaGlobalFunc_UserSetting_Close()
  if nil == PaGlobal_LobbyUserSetting then
    return
  end
  PaGlobal_LobbyUserSetting:prepareClose()
end
function PaGlobalFunc_UserSetting_ShowPolicy()
  if false == Panel_Lobby_UserSetting:GetShow() then
    return
  end
  PaGlobal_LobbyUserSetting:close()
  if isLoginIDShow() then
    if true == _ContentsGroup_NewUI_Login_All then
      PaGlobal_LoginNickname_All_Open()
    else
      PaGlobalFunc_LoginNickname_Open()
    end
  else
    PaGlobal_Copyright_Open(true)
  end
end
function PaGlobal_LobbyUserSetting_SetGamma()
  if false == Panel_Lobby_UserSetting:GetShow() then
    return
  end
  PaGlobal_LobbyUserSetting:setSlider()
end
function PaGlobal_LobbyUserSetting_DoStep()
  if false == Panel_Lobby_UserSetting:GetShow() then
    return
  end
  PaGlobal_LobbyUserSetting:doStep()
end
PaGlobal_LobbyUserSetting:initialize()
