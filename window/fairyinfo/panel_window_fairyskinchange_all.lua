PaGlobal_FairySkinChange_All = {
  _ui = {
    stc_TitleArea = UI.getChildControl(Panel_Window_FairySkinChange_All, "Static_TitleArea"),
    btn_LookChange_Slot = {},
    btn_LookChange = nil,
    stc_SkinSkillBG = nil,
    stc_SkinSkill = nil,
    txt_SkinSkillName = nil,
    txt_Info = nil,
    stc_Select = nil,
    _pc = {btn_Win_Close = nil},
    _console = {}
  },
  _config = {
    _slotCount = 5,
    _defaultSkinPath = "Combine/Etc/Combine_Etc_Fairy_Change_Reira.dds"
  },
  _selectSlotIndex = nil,
  _isDefaultSkin = nil,
  _skinCount = nil,
  _currentPage = nil,
  panelSizeY = 0,
  txt_InfoPosY = 0,
  btn_LookChangePosY = 0,
  NoVoiceFairyAnctionIndex = 5
}
Panel_Window_FairySkinChange_All:SetDragEnable(true)
runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairySkinChange_All_1.lua")
runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairySkinChange_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FairySkinChangeInit")
function FromClient_FairySkinChangeInit()
  PaGlobal_FairySkinChange_All:initialize()
end
