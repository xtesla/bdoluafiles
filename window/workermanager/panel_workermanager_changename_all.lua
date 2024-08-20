PaGlobal_WorkerManagerChangeName_All = {
  _ui = {
    stc_blockBg = nil,
    stc_titleBg = nil,
    btn_close = nil,
    stc_subFrame = nil,
    edit_nickname = nil,
    btn_apply = nil,
    btn_reset = nil,
    stc_descBg = nil,
    txt_desc = nil,
    stc_keyGuideBg = nil,
    stc_keyGuideY = nil,
    stc_keyGuideA = nil,
    stc_keyGuideB = nil,
    stc_keyGuideX = nil
  },
  _isConsole = false,
  _currentWorkerIdx = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_ChangeName_All_1.lua")
runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_ChangeName_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WorkerManagerChangeName_All_Init")
function FromClient_WorkerManagerChangeName_All_Init()
  PaGlobal_WorkerManagerChangeName_All:initialize()
end
