PaGlobal_InterestKnowledge_All = {
  _ui = {
    stc_subBg = nil,
    stc_needKnowledge = nil,
    list2 = nil,
    txt_knowledgeList = nil,
    stc_scroll = nil
  },
  _ui_pc = {btn_question = nil},
  _ui_console = {stc_guideBg = nil, stc_guideIconRS = nil},
  _knowledgeMaxCount = 8,
  _scrollIndex = 0,
  _listPosY = 0,
  _baseNeedKnowledgeSizeY = 0,
  _basePanelSizeY = 0,
  _baseSubBgSizeY = 0,
  _uiText = {},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_InterestKnowledge_All_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_InterestKnowledge_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_InterestKnowledge_All_Init")
function FromClient_InterestKnowledge_All_Init()
  PaGlobal_InterestKnowledge_All:initialize()
end
