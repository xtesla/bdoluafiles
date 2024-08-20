PaGlobal_GuildPoint_SkillLog = {
  _ui = {
    btn_close = nil,
    stc_lineBG = nil,
    frame = nil,
    frame_content = nil,
    frame_content_txt_title = nil,
    frame_content_txt_count = nil,
    frame_content_txt_time = nil,
    frame_content_txt_noTimeLine = nil,
    frame_vertical = nil,
    frame_vertical_ctrl = nil,
    btn_function = nil
  },
  _titleTable = {},
  _countTable = {},
  _timeTable = {},
  _NonDesc = {},
  _nextPos = 0,
  _count = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_GuildPoint_SkillLog_All_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_GuildPoint_SkillLog_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildPoint_SkillLogInit")
function FromClient_GuildPoint_SkillLogInit()
  PaGlobal_GuildPoint_SkillLog:initialize()
end
