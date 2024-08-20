PaGlobal_SkillFilter_All = {
  _ui = {_btn_close = nil, _filterList = nil},
  _skillCCTypeConfig = {
    _iconPath = "combine/etc/combine_etc_skill_00.dds",
    _uv = {
      [1] = nil,
      [2] = nil,
      [3] = {
        x1 = 272,
        y1 = 817,
        x2 = 292,
        y2 = 837
      },
      [4] = {
        x1 = 272,
        y1 = 838,
        x2 = 292,
        y2 = 858
      },
      [5] = {
        x1 = 272,
        y1 = 859,
        x2 = 292,
        y2 = 879
      },
      [6] = {
        x1 = 293,
        y1 = 817,
        x2 = 313,
        y2 = 837
      },
      [7] = {
        x1 = 293,
        y1 = 838,
        x2 = 313,
        y2 = 858
      },
      [8] = {
        x1 = 356,
        y1 = 817,
        x2 = 376,
        y2 = 837
      },
      [9] = {
        x1 = 314,
        y1 = 817,
        x2 = 334,
        y2 = 837
      },
      [10] = {
        x1 = 314,
        y1 = 838,
        x2 = 334,
        y2 = 858
      },
      [11] = {
        x1 = 356,
        y1 = 838,
        x2 = 376,
        y2 = 858
      },
      [12] = {
        x1 = 335,
        y1 = 817,
        x2 = 355,
        y2 = 837
      },
      [13] = {
        x1 = 335,
        y1 = 838,
        x2 = 355,
        y2 = 858
      },
      [14] = {
        x1 = 335,
        y1 = 859,
        x2 = 355,
        y2 = 879
      },
      [15] = {
        x1 = 356,
        y1 = 859,
        x2 = 376,
        y2 = 879
      },
      [16] = {
        x1 = 293,
        y1 = 859,
        x2 = 313,
        y2 = 879
      },
      [17] = {
        x1 = 314,
        y1 = 859,
        x2 = 334,
        y2 = 879
      }
    }
  },
  _startCCIndex = 2,
  _skillFilterCount = 17,
  _selectFilterType = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillFilter_All_1.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillFilter_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SkillFilterInit")
function FromClient_SkillFilterInit()
  PaGlobal_SkillFilter_All:initialize()
end
