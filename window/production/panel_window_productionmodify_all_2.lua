function PaGlobal_ProductionModify_Open()
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:prepareOpen()
end
function PaGlobal_ProductionModify_Close()
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:prepareClose()
end
function PaGlobal_ProductionModify_isOpen()
  if nil == PaGlobal_ProductionModify or nil == Panel_Window_ProductionModify_All then
    return
  end
  return Panel_Window_ProductionModify_All:GetShow()
end
function PaGlobal_ProductionModify_ChangePlayReplayNameByIndex(index)
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:changePlayReplayNameByIndex(index)
end
function PaGlobal_ProductionModify_PlaySelectedReplay()
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:playSelectedReplay()
end
function PaGlobal_ProductionModify_CreateCameraGroupControlList2(content, index)
  local key = Int64toInt32(index)
  local cameraGroupName = ToClient_getCutSceneCameraGroupNameByIndex(key)
  if nil == cameraGroupName then
    return
  end
  local txt_cameraName = UI.getChildControl(content, "StaticText_CameraName")
  txt_cameraName:SetText(cameraGroupName)
  local btn_select = UI.getChildControl(content, "Button_Select")
  btn_select:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:selectCameraGroupNameByKey(" .. key .. ")")
end
function PaGlobal_ProductionModify_CreateControlList2(content, index)
  local key = Int64toInt32(index)
  local cameraName = ToClient_getModifyCameraNameByIndex(key)
  if nil == cameraName then
    return
  end
  local txt_cameraName = UI.getChildControl(content, "StaticText_CameraName")
  txt_cameraName:SetText(cameraName)
  local btn_select = UI.getChildControl(content, "Button_Select")
  btn_select:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:selectCameraName(" .. key .. ")")
end
function PaGlobal_ProductionModify_CreateReplayCameraGroupList2(content, index)
  local key = Int64toInt32(index)
  local self = PaGlobal_ProductionModify
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  local cameraGroupName = ToClient_getReplayCameraGroupNameInfoByIndex(replayName, key)
  if nil == cameraGroupName then
    return
  end
  local txt_cameraGroupName = UI.getChildControl(content, "StaticText_CameraGroupName")
  txt_cameraGroupName:SetText(cameraGroupName)
  local playTime = ToClient_getReplayCameraGroupTimeInfoByIndex(replayName, key)
  if nil == playTime then
    return
  end
  local txt_time = UI.getChildControl(content, "StaticText_PlayTime")
  txt_time:SetText(playTime)
  local btn_select = UI.getChildControl(content, "Button_Select")
  btn_select:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:selectReplayCameraGroupInfo(" .. key .. "," .. playTime .. ")")
end
function PaGlobal_ProductionModify_CreateReplayCameraTraceList2(content, index)
  local key = Int64toInt32(index)
  local self = PaGlobal_ProductionModify
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  local cameraTraceKey = ToClient_getReplayCameraTraceKeyInfoByIndex(replayName, key)
  if nil == cameraTraceKey then
    return
  end
  local txt_cameraTraceKey = UI.getChildControl(content, "StaticText_CameraTraceKey")
  txt_cameraTraceKey:SetText(cameraTraceKey)
  local playTime = ToClient_getReplayCameraTraceTimeInfoByIndex(replayName, key)
  if nil == playTime then
    return
  end
  local txt_time = UI.getChildControl(content, "StaticText_PlayTime")
  txt_time:SetText(playTime)
  local btn_select = UI.getChildControl(content, "Button_Select")
  btn_select:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:selectReplayCameraTraceInfo(" .. cameraTraceKey .. "," .. playTime .. ")")
end
function PaGlobal_ProductionModify_CreateReplayPlayerList2(content, index)
  local key = Int64toInt32(index)
  local self = PaGlobal_ProductionModify
  local replayName = self._ui.edit_selectedReplayName:GetEditText()
  local playerDataWrapper = ToClient_getReplayPlayerDataWrapper(replayName, key)
  if nil == playerDataWrapper then
    return
  end
  local isPossesionTarget = ToClient_isReplayPossesionTarget(replayName, key)
  if nil == isPossesionTarget then
    return
  end
  local actorKeyRaw = playerDataWrapper:getActorKeyRaw()
  local userNickname = playerDataWrapper:getUserNickname()
  local txt_actorKey = UI.getChildControl(content, "StaticText_ActorKeyRaw")
  txt_actorKey:SetText(actorKeyRaw)
  local txt_userNickname = UI.getChildControl(content, "StaticText_UserNickname")
  txt_userNickname:SetText(userNickname)
  local btn_select = UI.getChildControl(content, "Button_Select")
  btn_select:addInputEvent("Mouse_LUp", "PaGlobal_ProductionModify:selectReplayPossesionInfo(" .. actorKeyRaw .. ")")
  local chk_target = UI.getChildControl(content, "CheckButton_IsPossesionTarget")
  chk_target:SetCheck(isPossesionTarget)
  if true == isPossesionTarget then
    self._ui.txt_selectCharacterName:SetText(userNickname)
  end
end
function PaGlobal_ProductionModify_ShowAni()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
end
function PaGlobal_ProductionModify_HideAni()
  if nil == Panel_Window_ProductionModify_All then
    return
  end
end
function PaGlobal_ProductionModify_ChangeCurrentCameraGroupName(cameraGroupName)
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:changeCurrentCameraGroupName(cameraGroupName)
end
function TestCameraRender()
  ToClient_TestCameraRender()
end
function playProductionForce(productionName)
  if nil == productionName then
    return
  end
  ToClient_playProductionForce(productionName)
end
function FromClient_ProductionModify_ReSizePanel()
  PaGlobal_ProductionModify._ui.stc_panelBG:ComputePos()
  PaGlobal_ProductionModify._ui.txt_title:ComputePos()
  PaGlobal_ProductionModify._ui.btn_close:ComputePos()
  PaGlobal_ProductionModify._ui.stc_panelBG:ComputePos()
  PaGlobal_ProductionModify._ui.txt_title:ComputePos()
  PaGlobal_ProductionModify._ui.btn_close:ComputePos()
  PaGlobal_ProductionModify._ui.stc_recordBG:ComputePos()
  PaGlobal_ProductionModify._ui.chk_streaming:ComputePos()
  PaGlobal_ProductionModify._ui.chk_onlyDownload:ComputePos()
  PaGlobal_ProductionModify._ui.chk_exceptRecorder:ComputePos()
  PaGlobal_ProductionModify._ui.edit_replayName:ComputePos()
  PaGlobal_ProductionModify._ui.radioBtnRecordGroupTemplate:ComputePos()
  PaGlobal_ProductionModify._ui.btn_startRecord:ComputePos()
  PaGlobal_ProductionModify._ui.btn_stopRecord:ComputePos()
  PaGlobal_ProductionModify._ui.btn_convertFile:ComputePos()
  PaGlobal_ProductionModify._ui.btn_deleteRecordAtServer:ComputePos()
  PaGlobal_ProductionModify._ui.stc_playBG:ComputePos()
  PaGlobal_ProductionModify._ui.edit_selectedReplayName:ComputePos()
  PaGlobal_ProductionModify._ui.btn_play:ComputePos()
  PaGlobal_ProductionModify._ui.btn_pause:ComputePos()
  PaGlobal_ProductionModify._ui.btn_stop:ComputePos()
  PaGlobal_ProductionModify._ui.btn_loadReplayList:ComputePos()
  PaGlobal_ProductionModify._ui.chk_isAutoStop:ComputePos()
  PaGlobal_ProductionModify._ui.chk_isThirdPersonMode:ComputePos()
  PaGlobal_ProductionModify._ui.chk_isRenderObjectOnPlaying:ComputePos()
  PaGlobal_ProductionModify._ui.stc_cameraBG:ComputePos()
  PaGlobal_ProductionModify._ui.edit_cameraGroupName:ComputePos()
  PaGlobal_ProductionModify._ui.btn_addGroupCamera:ComputePos()
  PaGlobal_ProductionModify._ui.btn_deleteGroupCamera:ComputePos()
  PaGlobal_ProductionModify._ui.btn_closeGroupCamera:ComputePos()
  PaGlobal_ProductionModify._ui.btn_playGroupCamera:ComputePos()
  PaGlobal_ProductionModify._ui.btn_saveGroupCamera:ComputePos()
  PaGlobal_ProductionModify._ui.btn_stopGroupCamera:ComputePos()
  PaGlobal_ProductionModify._ui.btn_freeCam:ComputePos()
  PaGlobal_ProductionModify._ui.btn_normalCam:ComputePos()
  PaGlobal_ProductionModify._ui.edit_fadeTime:ComputePos()
  PaGlobal_ProductionModify._ui.edit_delayTime:ComputePos()
  PaGlobal_ProductionModify._ui.edit_interpolationTime:ComputePos()
  PaGlobal_ProductionModify._ui.edit_startMoveSpeed:ComputePos()
  PaGlobal_ProductionModify._ui.edit_endMoveSpeed:ComputePos()
  PaGlobal_ProductionModify._ui.list2_camInfoList:ComputePos()
  PaGlobal_ProductionModify._ui.txt_selectCutSceneCameraName:ComputePos()
  PaGlobal_ProductionModify._ui.btn_addCamInfo:ComputePos()
  PaGlobal_ProductionModify._ui.btn_editCamInfo:ComputePos()
  PaGlobal_ProductionModify._ui.btn_deleteCamInfo:ComputePos()
  PaGlobal_ProductionModify._ui.txt_prevCameraName:ComputePos()
  PaGlobal_ProductionModify._ui.txt_nextCameraName:ComputePos()
  PaGlobal_ProductionModify._ui.btn_addCameraPivot:ComputePos()
  PaGlobal_ProductionModify._ui.btn_deleteCameraPivot:ComputePos()
  PaGlobal_ProductionModify._ui.chk_isRenderFrustum:ComputePos()
  PaGlobal_ProductionModify._ui.btn_connectPrevCamera:ComputePos()
  PaGlobal_ProductionModify._ui.btn_disConnectPrevCamera:ComputePos()
  PaGlobal_ProductionModify._ui.btn_connectNextCamera:ComputePos()
  PaGlobal_ProductionModify._ui.btn_disConnectNextCamera:ComputePos()
  PaGlobal_ProductionModify._ui.edit_cameraGroupInfoTime:ComputePos()
  PaGlobal_ProductionModify._ui.btn_insertReplayCameraGroupInfo:ComputePos()
  PaGlobal_ProductionModify._ui.btn_deleteReplayCameraGroupInfo:ComputePos()
  PaGlobal_ProductionModify._ui.btn_remakeFileForCameraGroup:ComputePos()
  PaGlobal_ProductionModify._ui.btn_playCameraTrace:ComputePos()
  PaGlobal_ProductionModify._ui.btn_stopCameraTrace:ComputePos()
  PaGlobal_ProductionModify._ui.radioBtnFadeTypeTemplate:ComputePos()
  PaGlobal_ProductionModify._ui.edit_cameraTraceInfoTime:ComputePos()
  PaGlobal_ProductionModify._ui.edit_cameraTraceKey:ComputePos()
  PaGlobal_ProductionModify._ui.btn_insertReplayCameraTraceInfo:ComputePos()
  PaGlobal_ProductionModify._ui.btn_deleteReplayCameraTraceInfo:ComputePos()
  PaGlobal_ProductionModify._ui.btn_remakeFileForCameraTrace:ComputePos()
  PaGlobal_ProductionModify._ui.list2_replayCameraTraceInfoList:ComputePos()
  PaGlobal_ProductionModify._ui.edit_intervalStartTime:ComputePos()
  PaGlobal_ProductionModify._ui.edit_intervalEndTime:ComputePos()
  PaGlobal_ProductionModify._ui.btn_remakeIntervalFile:ComputePos()
  PaGlobal_ProductionModify._ui.txt_selectCharacterName:ComputePos()
  PaGlobal_ProductionModify._ui.btn_remakeFileForPossesion:ComputePos()
  PaGlobal_ProductionModify._ui.list2_replayCharacterInfoList:ComputePos()
end
function FromClient_ProductionModify_UpdateCutSceneCameraGroupList()
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:cameraGroupInfoListUpdate()
end
function FromClient_ProductionModify_UpdateCutSceneCameraList()
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:cameraInfoListUpdate()
end
function FromClient_ProductionModify_SelectCameraGroupName(cameraGroupName)
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:selectCameraGroupName(cameraGroupName)
end
function FromClient_ProductionModify_UpdateCutSceneCameraDefaultInfo(cameraName, fadeTime, delayTime, fadeType, interpolationTime, startMoveSpeed, endMoveSpeed)
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:updateCutSceneCameraDefaultInfo(cameraName, fadeTime, delayTime, fadeType, interpolationTime, startMoveSpeed, endMoveSpeed)
end
function FromClient_ProductionModify_UpdateCutSceneCameraShakeInfo(rotatePower, translatePower, falloff, radius, keepTime)
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:updateCutSceneCameraShakeInfo(rotatePower, translatePower, falloff, radius, keepTime)
end
function FromClient_ProductionModify_UpdateCutSceneCameraLinkInfo(prevCameraName, nextCameraName)
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:updateCutSceneCameraLinkInfo(prevCameraName, nextCameraName)
end
function FromClient_ProductionModify_UpdateCutSceneCameraEtcInfo(letterBoxType)
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:updateCutSceneCameraEtcInfo(letterBoxType)
end
function FromClient_ProductionModify_UpdateReplayCameraGroupInfoList()
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:updateReplayCameraGroupInfoList()
end
function FromClient_ProductionModify_UpdateReplayCameraTraceInfoList()
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:updateReplayCameraTraceInfoList()
end
function FromClient_ProductionModify_UpdateReplayPossesionInfo()
  if nil == PaGlobal_ProductionModify then
    return
  end
  PaGlobal_ProductionModify:updateReplayPossesionInfoList()
end
