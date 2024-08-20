function PaGlobalFunc_Window_Description_Open()
  if nil == Panel_Window_Description or true == Panel_Window_Description:GetShow() then
    return
  end
  if false == _ContentsGroup_SettingSaveLoad then
    return
  end
  PaGlobal_Window_Description:prepareOpen()
end
function PaGlobalFunc_Window_Description_Close()
  if nil == Panel_Window_Description or false == Panel_Window_Description:GetShow() then
    return
  end
  PaGlobal_Window_Description:prepareClose()
end
function FromClient_Window_Description_ResultAutoGameOption()
  if false == _ContentsGroup_SettingSaveLoad then
    return
  end
  local autoSaveState = ToClient_getDownloadPackAutoFlag()
  if __eDownLoadCacheResultType_DownloadSuccess == autoSaveState then
    PaGlobalFunc_Window_Description_Open()
  elseif __eDownLoadCacheResultType_DownloadUrlFail == autoSaveState or __eDownLoadCacheResultType_DownloadCacheFail == autoSaveState or __eDownLoadCacheResultType_ApplyFileFail == autoSaveState then
    local GameOptionSaveSettingOpen = function()
      if nil ~= PaGlobal_Panel_SaveSetting_Show then
        PaGlobal_Panel_SaveSetting_Show(true)
      end
    end
    local messageData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AUTOSAVE_FAILMESSAGE"),
      functionYes = GameOptionSaveSettingOpen,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageData)
  end
end
function FromClient_Window_Description_OnScreenResize()
  if nil == Panel_Window_Description then
    return
  end
  Panel_Window_Description:ComputePos()
end
