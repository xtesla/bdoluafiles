PaGlobal_ReplayLoadList = {
  _ui = {
    stc_titleBG = nil,
    txt_title = nil,
    btn_close = nil,
    stc_subTitleBG = nil,
    txt_replayName = nil,
    txt_replayLength = nil,
    stc_mainBG = nil,
    list2_replayList = nil,
    stc_bottomBG = nil,
    btn_refresh = nil
  },
  _loadList = {},
  _replayListTemplate = {
    btn_Template = nil,
    txt_ReplayName = nil,
    txt_replayLength = nil
  },
  _isLoad = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Replay/Panel_Window_ReplayLoadList_All_1.lua")
runLua("UI_Data/Script/Window/Replay/Panel_Window_ReplayLoadList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ReplayLoadListInit")
function FromClient_ReplayLoadListInit()
  PaGlobal_ReplayLoadList:initialize()
end
