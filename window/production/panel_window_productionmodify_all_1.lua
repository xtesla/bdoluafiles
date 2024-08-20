function PaGlobal_ProductionModify:initialize()
  if true == PaGlobal_ProductionModify._initialize then
    return
  end
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_Production
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, PaGlobal_ProductionModify_Close)
  self._ui.stc_panelBG = UI.getChildControl(Panel_Window_ProductionModify_All, "Static_PanelBG")
  self._ui.txt_title = UI.getChildControl(Panel_Window_ProductionModify_All, "Static_TitleArea")
  self._ui.check_popup = UI.getChildControl(self._ui.txt_title, "CheckButton_PopUp")
  self._ui.btn_close = UI.getChildControl(self._ui.txt_title, "Button_Replay_Close")
  self._ui.check_popup:SetCheck(false)
  self._ui.stc_recordBG = UI.getChildControl(Panel_Window_ProductionModify_All, "Static_RecordBG")
  self._ui.radioBtnRecordGroupTemplate = UI.getChildControl(self._ui.stc_recordBG, "Static_TemplateRadioBtnRecordGroup")
  self._ui.chk_streaming = UI.getChildControl(self._ui.stc_recordBG, "CheckButton_IsStreaming")
  self._ui.chk_onlyDownload = UI.getChildControl(self._ui.stc_recordBG, "CheckButton_IsOnlyDownload")
  self._ui.chk_exceptRecorder = UI.getChildControl(self._ui.stc_recordBG, "CheckButton_IsExceptRecorder")
  self._ui.edit_replayName = UI.getChildControl(self._ui.stc_recordBG, "Edit_ReplayName")
  self._ui.btn_startRecord = UI.getChildControl(self._ui.stc_recordBG, "Button_StartRecord")
  self._ui.btn_stopRecord = UI.getChildControl(self._ui.stc_recordBG, "Button_StopRecord")
  self._ui.btn_convertFile = UI.getChildControl(self._ui.stc_recordBG, "Button_ConvertFile")
  self._ui.btn_deleteRecordAtServer = UI.getChildControl(self._ui.stc_recordBG, "Button_DeleteRecordAtServer")
  self._ui.stc_playBG = UI.getChildControl(Panel_Window_ProductionModify_All, "Static_PlayBG")
  self._ui.edit_selectedReplayName = UI.getChildControl(self._ui.stc_playBG, "Edit_SelectedReplayName")
  self._ui.btn_play = UI.getChildControl(self._ui.stc_playBG, "Button_Play")
  self._ui.btn_pause = UI.getChildControl(self._ui.stc_playBG, "Button_Pause")
  self._ui.btn_stop = UI.getChildControl(self._ui.stc_playBG, "Button_Stop")
  self._ui.btn_loadReplayList = UI.getChildControl(self._ui.stc_playBG, "Button_ReplayLoadList")
  self._ui.chk_isAutoStop = UI.getChildControl(self._ui.stc_playBG, "CheckButton_IsAutoStop")
  self._ui.chk_isAutoStop:SetCheck(true)
  self._ui.btn_gotoStart = UI.getChildControl(self._ui.stc_playBG, "Button_GoToStart")
  self._ui.btn_prevSecond = UI.getChildControl(self._ui.stc_playBG, "Button_PrevSecond")
  self._ui.btn_nextSecond = UI.getChildControl(self._ui.stc_playBG, "Button_NextSecond")
  self._ui.btn_playProduction = UI.getChildControl(self._ui.stc_playBG, "Button_PlayProductionForce")
  self._ui.btn_resetProductionList = UI.getChildControl(self._ui.stc_playBG, "Button_ResetProductionList")
  self._ui.stc_cameraBG = UI.getChildControl(Panel_Window_ProductionModify_All, "Static_CameraBG")
  local groupCameraInfo = UI.getChildControl(self._ui.stc_cameraBG, "Static_CameraGroupInfo")
  self._ui.list2_cameraGroupInfoList = UI.getChildControl(groupCameraInfo, "List2_CameraGroupListBG")
  self._ui.edit_cameraGroupName = UI.getChildControl(groupCameraInfo, "Edit_CameraGroupName")
  self._ui.btn_addGroupCamera = UI.getChildControl(groupCameraInfo, "Button_AddGroupCamera")
  self._ui.btn_deleteGroupCamera = UI.getChildControl(groupCameraInfo, "Button_DeleteGroupCamera")
  self._ui.btn_closeGroupCamera = UI.getChildControl(groupCameraInfo, "Button_CloseGroupCamera")
  self._ui.btn_playGroupCamera = UI.getChildControl(groupCameraInfo, "Button_PlayGroupCamera")
  self._ui.btn_saveGroupCamera = UI.getChildControl(groupCameraInfo, "Button_SaveGroupCamera")
  self._ui.btn_stopGroupCamera = UI.getChildControl(groupCameraInfo, "Button_StopGroupCamera")
  local stc_freeCamInfo = UI.getChildControl(self._ui.stc_cameraBG, "Static_CameraFreecamInfo")
  self._ui.btn_freeCam = UI.getChildControl(stc_freeCamInfo, "Button_FreeCam")
  self._ui.btn_normalCam = UI.getChildControl(stc_freeCamInfo, "Button_NormalCam")
  local stc_fadeInfo = UI.getChildControl(self._ui.stc_cameraBG, "Static_CameraFadeInfo")
  self._ui.edit_fadeTime = UI.getChildControl(stc_fadeInfo, "Edit_FadeTime")
  self._ui.edit_delayTime = UI.getChildControl(stc_fadeInfo, "Edit_DelayTime")
  self._ui.radioBtnFadeTypeTemplate = UI.getChildControl(stc_fadeInfo, "Static_TemplateRadioBtnFadeType")
  self._ui.edit_fadeTime:SetEditText("0.0")
  self._ui.edit_delayTime:SetEditText("0.0")
  local interpolationInfo = UI.getChildControl(self._ui.stc_cameraBG, "Static_InterpolationInfo")
  self._ui.edit_interpolationTime = UI.getChildControl(interpolationInfo, "Edit_InterpolationTime")
  self._ui.edit_startMoveSpeed = UI.getChildControl(interpolationInfo, "Edit_StartMoveSpeed")
  self._ui.edit_endMoveSpeed = UI.getChildControl(interpolationInfo, "Edit_EndMoveSpeed")
  self._ui.edit_interpolationTime:SetEditText("-1.0")
  self._ui.edit_startMoveSpeed:SetEditText("0.0")
  self._ui.edit_endMoveSpeed:SetEditText("0.0")
  local stc_shakeInfo = UI.getChildControl(self._ui.stc_cameraBG, "Static_CameraShakeInfo")
  self._ui.edit_rotatePower = UI.getChildControl(stc_shakeInfo, "Edit_RotatePower")
  self._ui.edit_translatePower = UI.getChildControl(stc_shakeInfo, "Edit_TranslatePower")
  self._ui.edit_fallOff = UI.getChildControl(stc_shakeInfo, "Edit_FallOff")
  self._ui.edit_radius = UI.getChildControl(stc_shakeInfo, "Edit_Radius")
  self._ui.edit_keepTime = UI.getChildControl(stc_shakeInfo, "Edit_KeepTime")
  self._ui.edit_rotatePower:SetEditText("0.0")
  self._ui.edit_translatePower:SetEditText("0.0")
  self._ui.edit_fallOff:SetEditText("0.0")
  self._ui.edit_radius:SetEditText("0.0")
  self._ui.edit_keepTime:SetEditText("0.0")
  local cutSceneCameraInfo = UI.getChildControl(self._ui.stc_cameraBG, "Static_CutSceneCameraInfo")
  self._ui.list2_camInfoList = UI.getChildControl(cutSceneCameraInfo, "List2_CameraListBG")
  self._ui.txt_selectCutSceneCameraName = UI.getChildControl(cutSceneCameraInfo, "StaticText_SelectCutSceneCameraName")
  self._ui.btn_addCamInfo = UI.getChildControl(cutSceneCameraInfo, "Button_AddCamInfo")
  self._ui.btn_editCamInfo = UI.getChildControl(cutSceneCameraInfo, "Button_EditCamInfo")
  self._ui.btn_deleteCamInfo = UI.getChildControl(cutSceneCameraInfo, "Button_DeleteCamInfo")
  self._ui.txt_prevCameraName = UI.getChildControl(cutSceneCameraInfo, "StaticText_PrevCutSceneCameraName")
  self._ui.txt_nextCameraName = UI.getChildControl(cutSceneCameraInfo, "StaticText_NextCutSceneCameraName")
  self._ui.btn_addCameraPivot = UI.getChildControl(cutSceneCameraInfo, "Button_AddCameraPivot")
  self._ui.btn_deleteCameraPivot = UI.getChildControl(cutSceneCameraInfo, "Button_DeleteCameraPivot")
  self._ui.chk_isRenderFrustum = UI.getChildControl(cutSceneCameraInfo, "CheckButton_IsRenderFrustum")
  self._ui.chk_isRenderFrustum:SetCheck(false)
  self._ui.chk_isThirdPersonMode = UI.getChildControl(cutSceneCameraInfo, "CheckButton_IsThirdPersonMode")
  self._ui.chk_isThirdPersonMode:SetCheck(false)
  self._ui.chk_isRenderObjectOnPlaying = UI.getChildControl(cutSceneCameraInfo, "CheckButton_IsRenderObjectOnPlaying")
  self._ui.chk_isRenderObjectOnPlaying:SetCheck(false)
  self._ui.btn_connectPrevCamera = UI.getChildControl(cutSceneCameraInfo, "Button_ConnectPrevCamera")
  self._ui.btn_disConnectPrevCamera = UI.getChildControl(cutSceneCameraInfo, "Button_DisConnectPrevCamera")
  self._ui.btn_connectNextCamera = UI.getChildControl(cutSceneCameraInfo, "Button_ConnectNextCamera")
  self._ui.btn_disConnectNextCamera = UI.getChildControl(cutSceneCameraInfo, "Button_DisConnectNextCamera")
  local stc_addReplayGroupCameraInfo = UI.getChildControl(self._ui.stc_cameraBG, "Static_AddReplayCameraGroupInfo")
  self._ui.edit_cameraGroupInfoTime = UI.getChildControl(stc_addReplayGroupCameraInfo, "edit_cameraGroupInfoTime")
  self._ui.btn_insertReplayCameraGroupInfo = UI.getChildControl(stc_addReplayGroupCameraInfo, "Button_InsertReplayCameraGroupInfo")
  self._ui.btn_deleteReplayCameraGroupInfo = UI.getChildControl(stc_addReplayGroupCameraInfo, "Button_DeleteReplayCameraGroupInfo")
  self._ui.btn_remakeFileForCameraGroup = UI.getChildControl(stc_addReplayGroupCameraInfo, "Button_RemakeFile")
  self._ui.list2_replayCameraGroupInfoList = UI.getChildControl(stc_addReplayGroupCameraInfo, "List2_ReplayCameraGroupInfoListBG")
  local stc_addReplayCameraTraceInfo = UI.getChildControl(self._ui.stc_cameraBG, "Static_AddReplayCameraTraceInfo")
  self._ui.edit_cameraTraceInfoTime = UI.getChildControl(stc_addReplayCameraTraceInfo, "Edit_CameraTraceInfoTime")
  self._ui.edit_cameraTraceKey = UI.getChildControl(stc_addReplayCameraTraceInfo, "Edit_CameraTraceKey")
  self._ui.btn_insertReplayCameraTraceInfo = UI.getChildControl(stc_addReplayCameraTraceInfo, "Button_InsertReplayCameraTraceInfo")
  self._ui.btn_deleteReplayCameraTraceInfo = UI.getChildControl(stc_addReplayCameraTraceInfo, "Button_DeleteReplayCameraTraceInfo")
  self._ui.btn_remakeFileForCameraTrace = UI.getChildControl(stc_addReplayCameraTraceInfo, "Button_RemakeFile")
  self._ui.btn_playCameraTrace = UI.getChildControl(stc_addReplayCameraTraceInfo, "Button_PlayCameraTrace")
  self._ui.btn_stopCameraTrace = UI.getChildControl(stc_addReplayCameraTraceInfo, "Button_StopCameraTrace")
  self._ui.list2_replayCameraTraceInfoList = UI.getChildControl(stc_addReplayCameraTraceInfo, "List2_ReplayCameraTraceInfoListBG")
  local stc_saveReplayInterval = UI.getChildControl(self._ui.stc_cameraBG, "Static_SaveReplayInterval")
  self._ui.edit_intervalStartTime = UI.getChildControl(stc_saveReplayInterval, "Edit_Interval_StartTime")
  self._ui.edit_intervalEndTime = UI.getChildControl(stc_saveReplayInterval, "Edit_Interval_EndTime")
  self._ui.btn_remakeIntervalFile = UI.getChildControl(stc_saveReplayInterval, "Button_RemakeIntervalFile")
  local stc_addPossesionInfo = UI.getChildControl(self._ui.stc_cameraBG, "Static_AddReplayPossesionInfo")
  self._ui.txt_selectCharacterName = UI.getChildControl(stc_addPossesionInfo, "StaticText_TargetCharacterName")
  self._ui.btn_remakeFileForPossesion = UI.getChildControl(stc_addPossesionInfo, "Button_RemakeFile")
  self._ui.list2_replayCharacterInfoList = UI.getChildControl(stc_addPossesionInfo, "List2_ReplayCharacterInfoListBG")
  local stc_letterBoxInfo = UI.getChildControl(self._ui.stc_cameraBG, "Static_LetterBoxInfo")
  self._ui.radioBtnLetterBoxTemplate = UI.getChildControl(stc_letterBoxInfo, "Static_TemplateRadioBtnLetterBox")
  self:createRadioButtonGruop()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ProductionModify:registEventHandler()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_ProductionModify_ReSizePanel")
  registerEvent("FromClient_closeProductionModify", "PaGlobal_ProductionModify_Close()")
  registerEvent("FromClient_ProductionModify_UpdateCutSceneCameraGroupList", "FromClient_ProductionModify_UpdateCutSceneCameraGroupList")
  registerEvent("FromClient_ProductionModify_UpdateCutSceneCameraList", "FromClient_ProductionModify_UpdateCutSceneCameraList")
  registerEvent("FromClient_ProductionModify_SelectCameraGroupName", "FromClient_ProductionModify_SelectCameraGroupName")
  registerEvent("FromClient_ProductionModify_UpdateCutSceneCameraDefaultInfo", "FromClient_ProductionModify_UpdateCutSceneCameraDefaultInfo")
  registerEvent("FromClient_ProductionModify_UpdateCutSceneCameraShakeInfo", "FromClient_ProductionModify_UpdateCutSceneCameraShakeInfo")
  registerEvent("FromClient_ProductionModify_UpdateCutSceneCameraLinkInfo", "FromClient_ProductionModify_UpdateCutSceneCameraLinkInfo")
  registerEvent("FromClient_ProductionModify_UpdateCutSceneCameraEtcInfo", "FromClient_ProductionModify_UpdateCutSceneCameraEtcInfo")
  registerEvent("FromClient_ProductionModify_UpdateReplayCameraGroupInfoList", "FromClient_ProductionModify_UpdateReplayCameraGroupInfoList")
  registerEvent("FromClient_ProductionModify_UpdateReplayCameraTraceInfoList", "FromClient_ProductionModify_UpdateReplayCameraTraceInfoList")
  registerEvent("FromClient_ProductionModify_UpdateReplayPossesionInfo", "FromClient_ProductionModify_UpdateReplayPossesionInfo")
  self._ui.check_popup:addInputEvent("Mouse_LUp", "HandleEventLUp_ProductionModify_All_CheckPopupUI()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:prepareClose()")
  self._ui.btn_startRecord:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:recordReplay()")
  self._ui.btn_stopRecord:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:stopRecordReplay()")
  self._ui.btn_convertFile:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:convertFile()")
  self._ui.btn_deleteRecordAtServer:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:deleteRecordAtServer()")
  self._ui.btn_play:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify_PlaySelectedReplay()")
  self._ui.btn_pause:addInputEvent("Mouse_LUp", "ToClient_PauseReplay()")
  self._ui.btn_stop:addInputEvent("Mouse_LUp", "ToClient_ReplayStopTest()")
  self._ui.btn_loadReplayList:addInputEvent("Mouse_LUp", "PaGlobal_ReplayLoadList_Open()")
  self._ui.chk_isAutoStop:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:changeAutoStop()")
  self._ui.btn_gotoStart:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:goToStartTime()")
  self._ui.btn_prevSecond:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:prevSecond()")
  self._ui.btn_nextSecond:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:nextSecond()")
  self._ui.btn_playProduction:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:playProductionForce()")
  self._ui.btn_resetProductionList:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:resetProductionList()")
  self._ui.list2_cameraGroupInfoList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_ProductionModify_CreateCameraGroupControlList2")
  self._ui.list2_cameraGroupInfoList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_addGroupCamera:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:addCameraGroup()")
  self._ui.btn_deleteGroupCamera:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:deleteCameraGroup()")
  self._ui.btn_closeGroupCamera:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:closeCameraGroup()")
  self._ui.btn_playGroupCamera:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:playCameraGroup()")
  self._ui.btn_saveGroupCamera:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:saveCameraGroup()")
  self._ui.btn_stopGroupCamera:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:stopCameraGroup()")
  self._ui.btn_freeCam:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:requestChangeCam(true)")
  self._ui.btn_normalCam:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:requestChangeCam(false)")
  self._ui.btn_addCamInfo:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:addCamInfo()")
  self._ui.list2_camInfoList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_ProductionModify_CreateControlList2")
  self._ui.list2_camInfoList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.edit_fadeTime:RegistReturnKeyEvent("PaGlobal_ProductionModify:editCamInfo()")
  self._ui.edit_delayTime:RegistReturnKeyEvent("PaGlobal_ProductionModify:editCamInfo()")
  self._ui.edit_interpolationTime:RegistReturnKeyEvent("PaGlobal_ProductionModify:editCamInfo()")
  self._ui.edit_startMoveSpeed:RegistReturnKeyEvent("PaGlobal_ProductionModify:editCamInfo()")
  self._ui.edit_endMoveSpeed:RegistReturnKeyEvent("PaGlobal_ProductionModify:editCamInfo()")
  self._ui.edit_rotatePower:RegistReturnKeyEvent("PaGlobal_ProductionModify:editCamInfo()")
  self._ui.edit_translatePower:RegistReturnKeyEvent("PaGlobal_ProductionModify:editCamInfo()")
  self._ui.edit_fallOff:RegistReturnKeyEvent("PaGlobal_ProductionModify:editCamInfo()")
  self._ui.edit_radius:RegistReturnKeyEvent("PaGlobal_ProductionModify:editCamInfo()")
  self._ui.edit_keepTime:RegistReturnKeyEvent("PaGlobal_ProductionModify:editCamInfo()")
  self._ui.btn_editCamInfo:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:editCamInfo()")
  self._ui.btn_deleteCamInfo:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:deleteCamInfo()")
  self._ui.btn_addCameraPivot:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:addCameraPivot()")
  self._ui.btn_deleteCameraPivot:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:deleteCameraPivot()")
  self._ui.chk_isRenderFrustum:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:changeRenderFrustum()")
  self._ui.chk_isThirdPersonMode:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:changeThirdPersonMode()")
  self._ui.chk_isRenderObjectOnPlaying:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:changeRenderObjectOnPlaying()")
  self._ui.btn_connectPrevCamera:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:connectPrevCamera()")
  self._ui.btn_disConnectPrevCamera:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:disConnectPrevCamera()")
  self._ui.btn_connectNextCamera:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:connectNextCamera()")
  self._ui.btn_disConnectNextCamera:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:disConnectNextCamera()")
  self._ui.edit_cameraGroupInfoTime:RegistReturnKeyEvent("PaGlobal_ProductionModify:insertReplayCameraGroupInfo()")
  self._ui.btn_insertReplayCameraGroupInfo:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:insertReplayCameraGroupInfo()")
  self._ui.btn_deleteReplayCameraGroupInfo:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:deleteReplayCameraGroupInfo()")
  self._ui.btn_remakeFileForCameraGroup:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:remakeFileForCameraGroup()")
  self._ui.list2_replayCameraGroupInfoList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_ProductionModify_CreateReplayCameraGroupList2")
  self._ui.list2_replayCameraGroupInfoList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_insertReplayCameraTraceInfo:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:insertReplayCameraTraceInfo()")
  self._ui.btn_deleteReplayCameraTraceInfo:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:deleteReplayCameraTraceInfo()")
  self._ui.btn_remakeFileForCameraTrace:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:remakeFileForCameraTrace()")
  self._ui.btn_playCameraTrace:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:playCameraTrace()")
  self._ui.btn_stopCameraTrace:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:stopCameraTrace()")
  self._ui.list2_replayCameraTraceInfoList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_ProductionModify_CreateReplayCameraTraceList2")
  self._ui.list2_replayCameraTraceInfoList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_remakeIntervalFile:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:remakeIntervalFile()")
  self._ui.btn_remakeFileForPossesion:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:remakeFileForPossesion()")
  self._ui.list2_replayCharacterInfoList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_ProductionModify_CreateReplayPlayerList2")
  self._ui.list2_replayCharacterInfoList:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_ProductionModify:prepareOpen()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  Panel_Window_ProductionModify_All:SetIgnore(false)
  self:cameraGroupInfoListUpdate()
  self:cameraInfoListUpdate()
  PaGlobal_ProductionModify:open()
end
function PaGlobal_ProductionModify:open()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  Panel_Window_ProductionModify_All:SetShow(true)
end
function PaGlobal_ProductionModify:prepareClose()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ToClient_groupCameraInfoClose()
  Panel_Window_ProductionModify_All:SetIgnore(true)
  PaGlobal_ProductionModify:close()
end
function PaGlobal_ProductionModify:close()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  Panel_Window_ProductionModify_All:SetShow(false)
end
function PaGlobal_ProductionModify:update()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
end
function PaGlobal_ProductionModify:validate()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  self._ui.stc_panelBG:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_recordBG:isValidate()
  self._ui.chk_streaming:isValidate()
  self._ui.chk_onlyDownload:isValidate()
  self._ui.chk_exceptRecorder:isValidate()
  self._ui.edit_replayName:isValidate()
  self._ui.btn_startRecord:isValidate()
  self._ui.btn_stopRecord:isValidate()
  self._ui.btn_convertFile:isValidate()
  self._ui.btn_deleteRecordAtServer:isValidate()
  self._ui.stc_playBG:isValidate()
  self._ui.edit_selectedReplayName:isValidate()
  self._ui.btn_play:isValidate()
  self._ui.btn_pause:isValidate()
  self._ui.btn_stop:isValidate()
  self._ui.btn_loadReplayList:isValidate()
  self._ui.chk_isAutoStop:isValidate()
  self._ui.btn_gotoStart:isValidate()
  self._ui.btn_prevSecond:isValidate()
  self._ui.btn_nextSecond:isValidate()
  self._ui.stc_cameraBG:isValidate()
  self._ui.edit_cameraGroupName:isValidate()
  self._ui.btn_addGroupCamera:isValidate()
  self._ui.btn_playGroupCamera:isValidate()
  self._ui.btn_saveGroupCamera:isValidate()
  self._ui.btn_stopGroupCamera:isValidate()
  self._ui.btn_freeCam:isValidate()
  self._ui.btn_normalCam:isValidate()
  self._ui.edit_fadeTime:isValidate()
  self._ui.edit_delayTime:isValidate()
  self._ui.edit_interpolationTime:isValidate()
  self._ui.edit_startMoveSpeed:isValidate()
  self._ui.edit_endMoveSpeed:isValidate()
  self._ui.edit_rotatePower:isValidate()
  self._ui.edit_translatePower:isValidate()
  self._ui.edit_fallOff:isValidate()
  self._ui.edit_radius:isValidate()
  self._ui.edit_keepTime:isValidate()
  self._ui.btn_addCamInfo:isValidate()
  self._ui.list2_camInfoList:isValidate()
  self._ui.btn_editCamInfo:isValidate()
  self._ui.btn_deleteCamInfo:isValidate()
  self._ui.chk_isRenderFrustum:isValidate()
  self._ui.chk_isThirdPersonMode:isValidate()
  self._ui.chk_isRenderObjectOnPlaying:isValidate()
  self._ui.btn_connectPrevCamera:isValidate()
  self._ui.btn_disConnectPrevCamera:isValidate()
  self._ui.btn_connectNextCamera:isValidate()
  self._ui.btn_disConnectNextCamera:isValidate()
  self._ui.edit_cameraGroupInfoTime:isValidate()
  self._ui.btn_insertReplayCameraGroupInfo:isValidate()
  self._ui.btn_remakeFileForCameraGroup:isValidate()
  self._ui.edit_intervalStartTime:isValidate()
  self._ui.edit_intervalEndTime:isValidate()
  self._ui.btn_remakeIntervalFile:isValidate()
  self._ui.radioBtnLetterBoxTemplate:isValidate()
end
function PaGlobal_ProductionModify:createRadioButtonGruop()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  local radioButtonRecordTemplate = UI.getChildControl(self._ui.radioBtnRecordGroupTemplate, "RadioButton_Template")
  radioButtonRecordTemplate:SetGroup(0)
  local posX = radioButtonRecordTemplate:GetPosX()
  local posY = radioButtonRecordTemplate:GetPosY()
  local groupSizeX = self._ui.radioBtnRecordGroupTemplate:GetSizeX()
  local groupSizeY = self._ui.radioBtnRecordGroupTemplate:GetSizeY()
  local xIndex = 0
  for ii = 0, self._radioBtnGroupCount._recordCount - 1 do
    xIndex = ii
    local raidoButton = UI.cloneControl(radioButtonRecordTemplate, self._ui.radioBtnRecordGroupTemplate, "RadioButton_" .. tostring(ii))
    raidoButton:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:changeRecordType(" .. ii .. ")")
    raidoButton:SetPosX(posX + xIndex * 130)
    raidoButton:SetPosY(posY)
    raidoButton:SetText(self._radioBtnGroupCount._recordName[ii])
    raidoButton:SetShow(true)
    self._radioBtnRecord[ii] = raidoButton
    if ii == self._radioBtnGroupCount._recordCount - 1 then
      self._radioBtnRecord[ii]:SetCheck(true)
      self._selectedRecordTypeIndex = ii
    end
  end
  local radioBtnFadeTypeTemplate = UI.getChildControl(self._ui.radioBtnFadeTypeTemplate, "RadioButton_Template")
  radioBtnFadeTypeTemplate:SetGroup(1)
  posX = radioBtnFadeTypeTemplate:GetPosX()
  posY = radioBtnFadeTypeTemplate:GetPosY()
  groupSizeX = self._ui.radioBtnFadeTypeTemplate:GetSizeX()
  groupSizeY = self._ui.radioBtnFadeTypeTemplate:GetSizeY()
  xIndex = 0
  for ii = 0, self._radioBtnGroupCount._fadeInOutCount - 1 do
    xIndex = ii
    local raidoButton = UI.cloneControl(radioBtnFadeTypeTemplate, self._ui.radioBtnFadeTypeTemplate, "RadioButton_" .. tostring(ii))
    raidoButton:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:changeCameraFadeInOutType(" .. ii .. ", true)")
    raidoButton:SetPosX(posX)
    raidoButton:SetPosY(posY + ii * 40)
    raidoButton:SetText(self._radioBtnGroupCount._fadeInOutName[ii])
    raidoButton:SetShow(true)
    self._radioBtnCamera[ii] = raidoButton
    if ii == self._radioBtnGroupCount._fadeInOutCount - 1 then
      self._radioBtnCamera[ii]:SetCheck(true)
      self._selectedFadeTypeIndex = ii
    end
  end
  local radioBtnLetterBoxTemplate = UI.getChildControl(self._ui.radioBtnLetterBoxTemplate, "RadioButton_Template")
  radioBtnLetterBoxTemplate:SetGroup(2)
  posX = radioBtnLetterBoxTemplate:GetPosX()
  posY = radioBtnLetterBoxTemplate:GetPosY()
  groupSizeX = self._ui.radioBtnLetterBoxTemplate:GetSizeX()
  groupSizeY = self._ui.radioBtnLetterBoxTemplate:GetSizeY()
  xIndex = 0
  for ii = 0, self._radioBtnGroupCount._letterBoxCount - 1 do
    xIndex = ii
    local raidoButton = UI.cloneControl(radioBtnLetterBoxTemplate, self._ui.radioBtnLetterBoxTemplate, "RadioButton_" .. tostring(ii))
    raidoButton:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:changeLetterBoxType(" .. ii .. ", true)")
    raidoButton:SetPosX(posX)
    raidoButton:SetPosY(posY + ii * 40)
    raidoButton:SetText(self._radioBtnGroupCount._letterBoxName[ii])
    raidoButton:SetShow(true)
    self._radioBtnLetterBox[ii] = raidoButton
    if ii == self._radioBtnGroupCount._letterBoxCount - 1 then
      self._radioBtnLetterBox[ii]:SetCheck(true)
      self._selectedLetterBoxTypeIndex = ii
    end
  end
end
function PaGlobal_ProductionModify:changeAutoStop()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  local isCheck = self._ui.chk_isAutoStop:IsCheck()
  ToClient_changeReplayAutoStop(isCheck)
end
function PaGlobal_ProductionModify:goToStartTime()
  ToClient_StopReplay()
end
function PaGlobal_ProductionModify:prevSecond()
  ToClient_changeCurrentPlayTime(-5)
end
function PaGlobal_ProductionModify:nextSecond()
  ToClient_changeCurrentPlayTime(5)
end
function PaGlobal_ProductionModify:playProductionForce()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local selectReplayName = self._ui.edit_selectedReplayName:GetEditText()
  ToClient_playProductionForce(selectReplayName)
end
function PaGlobal_ProductionModify:resetProductionList()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  ToClient_resetProductionList()
end
function PaGlobal_ProductionModify:changeRecordType(index)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  self._selectedRecordTypeIndex = index
end
function PaGlobal_ProductionModify:recordReplay()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local replayName = self._ui.edit_replayName:GetEditText()
  local replayRecordType = self._selectedRecordTypeIndex
  local isStreaming = self._ui.chk_streaming:IsCheck()
  local isOnlyDownload = self._ui.chk_onlyDownload:IsCheck()
  local isExceptRecorder = self._ui.chk_exceptRecorder:IsCheck()
  ToClient_requestRecordReplay(replayName, replayRecordType, isStreaming, isOnlyDownload, isExceptRecorder)
  if 2 ~= replayRecordType then
    PaGlobalFunc_ProductionRecord_Open()
    PaGlobalFunc_ProductionRecord_ChangeReplayName(replayName)
  end
  ClearFocusEdit()
  PaGlobal_ProductionModify:prepareClose()
end
function PaGlobal_ProductionModify:stopRecordReplay()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  ToClient_requestStopRecordReplay()
end
function PaGlobal_ProductionModify:convertFile()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local replayName = self._ui.edit_replayName:GetEditText()
  ToClient_convertReplayFolderToReplayFile(replayName)
end
function PaGlobal_ProductionModify:deleteRecordAtServer()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  ToClient_requestClearRecordedReplayAtServer()
end
function PaGlobal_ProductionModify:changeCameraFadeInOutType(index, isUpdate)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  self._selectedFadeTypeIndex = index
  if true == isUpdate then
    self:editCamInfo()
  end
end
function PaGlobal_ProductionModify:changeLetterBoxType(index, isUpdate)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  self._selectedLetterBoxTypeIndex = index
  if true == isUpdate then
    self:editCamInfo()
  end
end
function PaGlobal_ProductionModify:changePlayReplayNameByIndex(index)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  local wrapper = ToClient_getLoadReplayDataWrapper(index)
  if nil == wrapper then
    return
  end
  self._ui.edit_selectedReplayName:SetEditText(wrapper:getReplayName())
  self:updateReplayCameraGroupInfoList()
  self:updateReplayCameraTraceInfoList()
  self:updateReplayPossesionInfoList()
end
function PaGlobal_ProductionModify:playSelectedReplay()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ToClient_ReplayPlayTest(self._ui.edit_selectedReplayName:GetEditText())
end
function PaGlobal_ProductionModify:insertReplayCameraGroupInfo()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  local camInfoTime = tonumber(self._ui.edit_cameraGroupInfoTime:GetEditText())
  local cameraGroupName = self._ui.edit_cameraGroupName:GetEditText()
  ToClient_insertReplayCameraGroupInfo(replayName, camInfoTime, cameraGroupName)
end
function PaGlobal_ProductionModify:deleteReplayCameraGroupInfo()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  local camInfoTime = tonumber(self._ui.edit_cameraGroupInfoTime:GetEditText())
  local cameraGroupName = self._ui.edit_cameraGroupName:GetEditText()
  ToClient_deleteReplayCameraGroupInfo(replayName, camInfoTime, cameraGroupName)
end
function PaGlobal_ProductionModify:remakeFileForCameraGrouperaGroup()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  ToClient_modifyReplayFile(replayName)
end
function PaGlobal_ProductionModify:insertReplayCameraTraceInfo()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  local camInfoTime = tonumber(self._ui.edit_cameraTraceInfoTime:GetEditText())
  local cameraTraceKey = tonumber(self._ui.edit_cameraTraceKey:GetEditText())
  ToClient_insertReplayCameraTraceInfo(replayName, camInfoTime, cameraTraceKey)
end
function PaGlobal_ProductionModify:deleteReplayCameraTraceInfo()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  local camInfoTime = tonumber(self._ui.edit_cameraTraceInfoTime:GetEditText())
  local cameraTraceKey = tonumber(self._ui.edit_cameraTraceKey:GetEditText())
  ToClient_deleteReplayCameraTraceInfo(replayName, camInfoTime, cameraTraceKey)
end
function PaGlobal_ProductionModify:remakeFileForCameraTrace()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  ToClient_modifyReplayFile(replayName)
end
function PaGlobal_ProductionModify:playCameraTrace()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local cameraTraceKey = tonumber(self._ui.edit_cameraTraceKey:GetEditText())
  ToClient_playCameraTrace(cameraTraceKey)
end
function PaGlobal_ProductionModify:stopCameraTrace()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  ToClient_stopCameraTrace()
end
function PaGlobal_ProductionModify:remakeIntervalFile()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  local startTime = tonumber(self._ui.edit_intervalStartTime:GetEditText())
  local endTime = tonumber(self._ui.edit_intervalEndTime:GetEditText())
  ToClient_repackageReplayFileByInterval(replayName, startTime, endTime)
end
function PaGlobal_ProductionModify:remakeFileForPossesion()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  ToClient_modifyReplayFile(replayName)
end
function PaGlobal_ProductionModify:addCameraGroup()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  PaGlobalFunc_ProductionCamera_Open()
end
function PaGlobal_ProductionModify:deleteCameraGroup()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local isSuccess = ToClient_ReplayDeleteCameraGroup(self._ui.edit_cameraGroupName:GetEditText())
  if false == isSuccess then
    return
  end
  PaGlobal_ProductionModify:cameraInfoListUpdate()
end
function PaGlobal_ProductionModify:closeCameraGroup()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  ToClient_groupCameraInfoClose()
  self._ui.edit_cameraGroupName:SetEditText("")
  self._ui.txt_selectCutSceneCameraName:SetText("")
  PaGlobal_ProductionModify:cameraInfoListUpdate()
end
function PaGlobal_ProductionModify:playCameraGroup()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  ToClient_playCutSceneCameraGroup()
end
function PaGlobal_ProductionModify:stopCameraGroup()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  ToClient_stopCutSceneCameraGroup()
end
function PaGlobal_ProductionModify:editCamInfo()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local selectedCameraName = self._ui.txt_selectCutSceneCameraName:GetText()
  ToClient_ProductionModifyCameraDefaultInfo(selectedCameraName)
  local fadeTime = tonumber(self._ui.edit_fadeTime:GetEditText())
  local delayTime = tonumber(self._ui.edit_delayTime:GetEditText())
  local interpolationTime = tonumber(self._ui.edit_interpolationTime:GetEditText())
  local startMoveSpeed = tonumber(self._ui.edit_startMoveSpeed:GetEditText())
  local endMoveSpeed = tonumber(self._ui.edit_endMoveSpeed:GetEditText())
  ToClient_ProductionModifyCameraFadeInfo(fadeTime, delayTime, self._selectedFadeTypeIndex, interpolationTime, startMoveSpeed, endMoveSpeed)
  local rotatePower = tonumber(self._ui.edit_rotatePower:GetEditText())
  local translatePower = tonumber(self._ui.edit_translatePower:GetEditText())
  local fallOff = tonumber(self._ui.edit_fallOff:GetEditText())
  local radius = tonumber(self._ui.edit_radius:GetEditText())
  local keepTime = tonumber(self._ui.edit_keepTime:GetEditText())
  ToClient_ProductionModifyCameraShakeInfo(rotatePower, translatePower, fallOff, radius, keepTime)
  ToClient_ProductionModifyCameraEtcInfo(self._selectedLetterBoxTypeIndex)
  PaGlobal_ProductionModify:cameraInfoListUpdate()
end
function PaGlobal_ProductionModify:deleteCamInfo()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  ToClient_ReplayDeleteCurrentCameraInfo()
  PaGlobal_ProductionModify:cameraInfoListUpdate()
end
function PaGlobal_ProductionModify:addCameraPivot()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  ToClient_createProductionPivot()
end
function PaGlobal_ProductionModify:deleteCameraPivot()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  ToClient_removeProductionPivot()
end
function PaGlobal_ProductionModify:saveCameraGroup()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  ToClient_saveCutSceneCameraGroup()
end
function PaGlobal_ProductionModify:addCamInfo()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  local fadeTime = tonumber(self._ui.edit_fadeTime:GetEditText())
  local delayTime = tonumber(self._ui.edit_delayTime:GetEditText())
  local interpolationTime = tonumber(self._ui.edit_interpolationTime:GetEditText())
  local startMoveSpeed = tonumber(self._ui.edit_startMoveSpeed:GetEditText())
  local endMoveSpeed = tonumber(self._ui.edit_endMoveSpeed:GetEditText())
  ClearFocusEdit()
  ToClient_ReplayAddCurrentCameraInfo(fadeTime, delayTime, self._selectedFadeTypeIndex, interpolationTime, startMoveSpeed, endMoveSpeed)
  local rotatePower = tonumber(self._ui.edit_rotatePower:GetEditText())
  local translatePower = tonumber(self._ui.edit_translatePower:GetEditText())
  local fallOff = tonumber(self._ui.edit_fallOff:GetEditText())
  local radius = tonumber(self._ui.edit_radius:GetEditText())
  local keepTime = tonumber(self._ui.edit_keepTime:GetEditText())
  ToClient_ReplayAddCurrentCameraShakeInfo(rotatePower, translatePower, fallOff, radius, keepTime)
  PaGlobal_ProductionModify:cameraInfoListUpdate()
end
function PaGlobal_ProductionModify:cameraInfoListUpdate()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  local cameraGroupName = ToClient_getModifyCameraGroupName()
  self._ui.edit_cameraGroupName:SetEditText(cameraGroupName)
  local camInfoSize = ToClient_getModifyCameraNameListSize()
  self._ui.list2_camInfoList:getElementManager():clearKey()
  if camInfoSize > 0 then
    for ii = 0, camInfoSize - 1 do
      self._ui.list2_camInfoList:getElementManager():pushKey(ii)
    end
  end
  self._ui.list2_camInfoList:ComputePos()
end
function PaGlobal_ProductionModify:cameraGroupInfoListUpdate()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  local cameraGroupSize = ToClient_getCutSceneCameraGroupNameListSize()
  self._ui.list2_cameraGroupInfoList:getElementManager():clearKey()
  if cameraGroupSize > 0 then
    for ii = 0, cameraGroupSize - 1 do
      self._ui.list2_cameraGroupInfoList:getElementManager():pushKey(ii)
    end
  end
  self._ui.list2_cameraGroupInfoList:ComputePos()
end
function PaGlobal_ProductionModify:requestChangeCam(isFreeCam)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  if nil == isFreeCam then
    return
  end
  if true == isFreeCam then
    ToClient_ReplayChangeFreecam()
  else
    ToClient_ReplayChangeNomalcam()
  end
  ClearFocusEdit()
end
function PaGlobal_ProductionModify:updateCutSceneCameraDefaultInfo(cameraName, fadeTime, delayTime, fadeType, interpolationTime, startMoveSpeed, endMoveSpeed)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  self._ui.txt_selectCutSceneCameraName:SetText(cameraName)
  self._ui.edit_fadeTime:SetEditText(string.format("%.3f", fadeTime))
  self._ui.edit_delayTime:SetEditText(string.format("%.3f", delayTime))
  self._ui.edit_interpolationTime:SetEditText(string.format("%.3f", interpolationTime))
  self._ui.edit_startMoveSpeed:SetEditText(string.format("%.3f", startMoveSpeed))
  self._ui.edit_endMoveSpeed:SetEditText(string.format("%.3f", endMoveSpeed))
  for idx = 0, self._radioBtnGroupCount._fadeInOutCount - 1 do
    self._radioBtnCamera[idx]:SetCheck(false)
  end
  if nil ~= fadeType and nil ~= self._radioBtnCamera[fadeType] and fadeType < self._radioBtnGroupCount._fadeInOutCount then
    self._radioBtnCamera[fadeType]:SetCheck(true)
    self:changeCameraFadeInOutType(fadeType, false)
  end
end
function PaGlobal_ProductionModify:updateCutSceneCameraShakeInfo(rotatePower, translatePower, falloff, radius, keepTime)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  self._ui.edit_rotatePower:SetEditText(string.format("%.3f", rotatePower))
  self._ui.edit_translatePower:SetEditText(string.format("%.3f", translatePower))
  self._ui.edit_fallOff:SetEditText(string.format("%.3f", falloff))
  self._ui.edit_radius:SetEditText(string.format("%.3f", radius))
  self._ui.edit_keepTime:SetEditText(string.format("%.3f", keepTime))
end
function PaGlobal_ProductionModify:updateCutSceneCameraLinkInfo(prevCameraName, nextCameraName)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  if nil ~= prevCameraName then
    self._ui.txt_prevCameraName:SetText(prevCameraName)
  else
    self._ui.txt_prevCameraName:SetText("")
  end
  if nil ~= nextCameraName then
    self._ui.txt_nextCameraName:SetText(nextCameraName)
  else
    self._ui.txt_nextCameraName:SetText("")
  end
end
function PaGlobal_ProductionModify:updateCutSceneCameraEtcInfo(letterBoxType)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  for idx = 0, self._radioBtnGroupCount._letterBoxCount - 1 do
    self._radioBtnLetterBox[idx]:SetCheck(false)
  end
  if nil ~= letterBoxType and nil ~= self._radioBtnLetterBox[letterBoxType] and letterBoxType < self._radioBtnGroupCount._letterBoxCount then
    self._radioBtnLetterBox[letterBoxType]:SetCheck(true)
    self:changeLetterBoxType(letterBoxType, false)
  end
end
function PaGlobal_ProductionModify:selectCameraName(key)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ToClient_ReplaySelectCameraName(key)
  local cameraGroupName = ToClient_getModifyCameraGroupName()
  self._ui.edit_cameraGroupName:SetEditText(cameraGroupName)
end
function PaGlobal_ProductionModify:selectCameraGroupNameByKey(key)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  local cameraGroupName = ToClient_getCutSceneCameraGroupNameByIndex(key)
  if nil == cameraGroupName then
    return
  end
  self:selectCameraGroupName(cameraGroupName)
end
function PaGlobal_ProductionModify:selectCameraGroupName(cameraGroupName)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  if nil == cameraGroupName then
    return
  end
  ToClient_groupCameraInfoOpen(cameraGroupName)
  ToClient_selectCutSceneCameraName(cameraGroupName)
  self._ui.edit_cameraGroupName:SetEditText(tostring(cameraGroupName .. "_temp"))
  self:updateCutSceneCameraList(cameraGroupName)
end
function PaGlobal_ProductionModify:selectReplayCameraGroupInfo(key, playTime)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  self._ui.edit_cameraGroupInfoTime:SetEditText(tostring(playTime))
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  local cameraGroupName = ToClient_getReplayCameraGroupNameInfoByIndex(replayName, key)
  if nil == cameraGroupName then
    return
  end
  self:selectCameraGroupName(cameraGroupName)
end
function PaGlobal_ProductionModify:selectReplayCameraTraceInfo(traceKey, playTime)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  self._ui.edit_cameraTraceInfoTime:SetEditText(tostring(playTime))
  self._ui.edit_cameraTraceKey:SetEditText(tostring(traceKey))
end
function PaGlobal_ProductionModify:selectReplayPossesionInfo(actorKeyRaw)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ClearFocusEdit()
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  ToClient_setReplayPossesionInfo(replayName, actorKeyRaw)
end
function PaGlobal_ProductionModify:updateCutSceneCameraList(cameraGroupName)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  if nil == cameraGroupName then
    return
  end
  local camInfoSize = ToClient_getModifyCameraNameListSize()
  self._ui.list2_camInfoList:getElementManager():clearKey()
  if camInfoSize > 0 then
    for ii = 0, camInfoSize - 1 do
      self._ui.list2_camInfoList:getElementManager():pushKey(ii)
    end
  end
  self._ui.list2_camInfoList:ComputePos()
end
function PaGlobal_ProductionModify:updateReplayCameraGroupInfoList()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  local replayCameraGroupInfoSize = ToClient_getReplayCameraGroupInfoListSize(replayName)
  self._ui.list2_replayCameraGroupInfoList:getElementManager():clearKey()
  if replayCameraGroupInfoSize > 0 then
    for ii = 0, replayCameraGroupInfoSize - 1 do
      self._ui.list2_replayCameraGroupInfoList:getElementManager():pushKey(ii)
    end
  end
end
function PaGlobal_ProductionModify:updateReplayCameraTraceInfoList()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  local replayCameraTraceInfoSize = ToClient_getReplayCameraTraceInfoListSize(replayName)
  self._ui.list2_replayCameraTraceInfoList:getElementManager():clearKey()
  if replayCameraTraceInfoSize > 0 then
    for ii = 0, replayCameraTraceInfoSize - 1 do
      self._ui.list2_replayCameraTraceInfoList:getElementManager():pushKey(ii)
    end
  end
end
function PaGlobal_ProductionModify:updateReplayPossesionInfoList()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  local playerListSize = ToClient_getReplayPlayerDataSize(replayName)
  self._ui.txt_selectCharacterName:SetText("")
  self._ui.list2_replayCharacterInfoList:getElementManager():clearKey()
  if playerListSize > 0 then
    for ii = 0, playerListSize - 1 do
      self._ui.list2_replayCharacterInfoList:getElementManager():pushKey(ii)
    end
  end
end
function PaGlobal_ProductionModify:changeCurrentCameraGroupName(cameraGroupName)
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  self._ui.edit_cameraGroupName:SetEditText(cameraGroupName)
end
function PaGlobal_ProductionModify:changeRenderFrustum()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  local isCheck = self._ui.chk_isRenderFrustum:IsCheck()
  ToClient_changeReplayRenderFrustum(isCheck)
end
function PaGlobal_ProductionModify:changeThirdPersonMode()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  local isCheck = self._ui.chk_isThirdPersonMode:IsCheck()
  ToClient_changeProductionThirdPersonMode(isCheck)
end
function PaGlobal_ProductionModify:changeRenderObjectOnPlaying()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  local isCheck = self._ui.chk_isRenderObjectOnPlaying:IsCheck()
  ToClient_changeRenderObjectOnPlaying(isCheck)
end
function PaGlobal_ProductionModify:connectPrevCamera()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ToClient_changeCameraLink(true, true)
end
function PaGlobal_ProductionModify:disConnectPrevCamera()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ToClient_changeCameraLink(false, true)
end
function PaGlobal_ProductionModify:connectNextCamera()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ToClient_changeCameraLink(true, false)
end
function PaGlobal_ProductionModify:disConnectNextCamera()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  ToClient_changeCameraLink(false, false)
end
function HandleEventLUp_ProductionModify_All_CheckPopupUI()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
  if true == PaGlobal_ProductionModify._ui.check_popup:IsCheck() then
    Panel_Window_ProductionModify_All:OpenUISubApp()
  else
    Panel_Window_ProductionModify_All:CloseUISubApp()
  end
end
