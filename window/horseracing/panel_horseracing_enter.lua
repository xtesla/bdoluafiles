PaGlobal_HorseRacing_Enter = {
  _ui = {
    btn_Join = nil,
    btn_exit = nil,
    stc_InfoArea = nil,
    btn_smallExit = nil,
    combo_mapList = nil,
    txt_mapName = nil,
    stc_descBg = nil,
    btn_RankList = nil,
    stc_infoBG = nil,
    stc_buttonArea = nil,
    stc_line1 = nil,
    stc_line2 = nil,
    txt_reward = nil,
    stc_rewardBox = {},
    stc_rewardIcon = {},
    stc_recordArea = nil,
    txt_record = nil,
    txt_Nonrecord = nil,
    stc_raceRecord = nil,
    txt_shortRecord = nil,
    txt_shortRecordValue = nil,
    stc_raceCount = nil,
    txt_raceCount = nil,
    txt_raceCountValue = nil,
    stc_descBox = nil,
    txt_desc = nil,
    stc_rankListPanel = nil,
    btn_rankListExit = nil,
    web_rankList = nil,
    stc_keyGuideConsol = nil
  },
  _MAX_REWARD_COUNT = 5,
  _selectedMode = -1,
  _isConsole = false,
  _initialize = false,
  _recordAreaPos = {},
  _recordAreaSize = {},
  _descBoxPos = {},
  _descBoxSize = {},
  _baseTexture = "combine/etc/combine_etc_horseracing.dds",
  _string_NotSelected = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_MAP_STAGENAME_NONE")
}
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseRacing_Enter_Init")
function FromClient_HorseRacing_Enter_Init()
  PaGlobal_HorseRacing_Enter:initialize()
end
function PaGlobal_HorseRacing_Enter:initialize()
  if true == PaGlobal_HorseRacing_Enter._initialize or nil == Panel_HorseRacing_Enter then
    return
  end
  self._ui.stc_buttonArea = UI.getChildControl(Panel_HorseRacing_Enter, "Static_ButtonArea")
  self._ui.btn_Join = UI.getChildControl(self._ui.stc_buttonArea, "Button_Enter")
  self._ui.btn_exit = UI.getChildControl(self._ui.stc_buttonArea, "Button_Exit")
  self._ui.btn_smallExit = UI.getChildControl(Panel_HorseRacing_Enter, "Button_ExitButton")
  self._ui.stc_InfoArea = UI.getChildControl(Panel_HorseRacing_Enter, "Static_InfoArea")
  self._ui.stc_descBg = UI.getChildControl(self._ui.stc_InfoArea, "Static_HorceRacingMap")
  self._ui.stc_infoBG = UI.getChildControl(Panel_HorseRacing_Enter, "Static_InfoBG")
  local txt_player = UI.getChildControl(self._ui.stc_descBg, "StaticText_Player")
  local stc_map = UI.getChildControl(self._ui.stc_descBg, "StaticText_Map")
  self._ui.txt_mapName = UI.getChildControl(stc_map, "StaticText_NoneSelect")
  self._ui.btn_RankList = UI.getChildControl(Panel_HorseRacing_Enter, "Button_RankList")
  self._ui.combo_mapList = UI.getChildControl(self._ui.stc_InfoArea, "Combobox2_ChangeMap")
  self._ui.combo_mapList:addInputEvent("Mouse_LUp", "HandleEventLUp_HorseRacingEnter_ToggleMapList()")
  self._ui.combo_mapList:GetListControl():AddSelectEvent("HandleEventLUp_HorseRacingEnter_SelectMapList()")
  self._ui.txt_reward = UI.getChildControl(Panel_HorseRacing_Enter, "StaticText_Reward")
  for index = 0, self._MAX_REWARD_COUNT - 1 do
    self._ui.stc_rewardBox[index] = UI.getChildControl(self._ui.txt_reward, "Static_RewardBox0" .. tostring(index + 1))
    self._ui.stc_rewardIcon[index] = UI.getChildControl(self._ui.stc_rewardBox[index], "Static_RewardIcon0" .. tostring(index + 1))
  end
  self._ui.stc_line1 = UI.getChildControl(Panel_HorseRacing_Enter, "Static_Line01")
  self._ui.stc_line2 = UI.getChildControl(Panel_HorseRacing_Enter, "Static_Line02")
  self._ui.stc_rankListPanel = UI.getChildControl(Panel_HorseRacing_Enter, "Static_RankListPanel")
  local rankListTitle = UI.getChildControl(self._ui.stc_rankListPanel, "Static_RankListTitle")
  self._ui.btn_rankListExit = UI.getChildControl(rankListTitle, "Button_RankExit")
  local webGap = 10
  self._ui.web_rankList = UI.createControl(__ePAUIControl_WebControl, Panel_HorseRacing_Enter, "WebControl_HorseRacingSeasonRank")
  self._ui.web_rankList:SetShow(true)
  self._ui.web_rankList:SetPosX(self._ui.stc_rankListPanel:GetPosX() + 5)
  self._ui.web_rankList:SetPosY(self._ui.stc_rankListPanel:GetPosY() + rankListTitle:GetSizeY() + 5)
  self._ui.web_rankList:ResetUrl()
  self._ui.web_rankList:SetSize(self._ui.stc_rankListPanel:GetSizeX() - webGap, self._ui.stc_rankListPanel:GetSizeY() - rankListTitle:GetSizeY() - webGap)
  self._ui.stc_recordArea = UI.getChildControl(Panel_HorseRacing_Enter, "Static_RecordArea")
  self._ui.txt_record = UI.getChildControl(self._ui.stc_recordArea, "StaticText_Record")
  self._ui.txt_Nonrecord = UI.getChildControl(self._ui.txt_record, "StaticText_Norecord")
  self._ui.stc_raceRecord = UI.getChildControl(self._ui.stc_recordArea, "Static_RaceRecord")
  self._ui.txt_shortRecord = UI.getChildControl(self._ui.stc_raceRecord, "StaticText_ShortRecord")
  self._ui.txt_shortRecordValue = UI.getChildControl(self._ui.stc_raceRecord, "StaticText_ShortRecord_Val")
  self._ui.stc_raceCount = UI.getChildControl(self._ui.stc_recordArea, "Static_RaceCount")
  self._ui.txt_raceCount = UI.getChildControl(self._ui.stc_raceCount, "StaticText_RaceCount")
  self._ui.txt_raceCountValue = UI.getChildControl(self._ui.stc_raceCount, "StaticText_RaceCount_Val")
  self._ui.stc_descBox = UI.getChildControl(Panel_HorseRacing_Enter, "Static_DescBox")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descBox, "StaticText_Desc")
  self._ui.stc_keyGuideConsol = UI.getChildControl(Panel_HorseRacing_Enter, "Static_KeyGuide_Console")
  self._ui.stc_keyGuideConsol:SetShow(false)
  self:setNotice()
  self._recordAreaPos = {
    x = self._ui.stc_recordArea:GetPosX(),
    y = self._ui.stc_recordArea:GetPosY()
  }
  self._recordAreaSize = {
    x = self._ui.stc_recordArea:GetSizeX(),
    y = self._ui.stc_recordArea:GetSizeY()
  }
  self._descBoxPos = {
    x = self._ui.stc_descBox:GetPosX(),
    y = self._ui.stc_descBox:GetPosY()
  }
  self._descBoxSize = {
    x = self._ui.stc_descBox:GetSizeX(),
    y = self._ui.stc_descBox:GetSizeY()
  }
  self:openRecord()
  self._isConsole = _ContentsGroup_RenewUI
  PaGlobal_HorseRacing_Enter:validate()
  PaGlobal_HorseRacing_Enter:registEventHandler()
  local self = PaGlobal_HorseRacing_Enter
  self._ui.combo_mapList:DeleteAllItem()
  local horseMapCount = ToClient_GetInstanceFieldTypeInfoCount(__eInstanceContentsType_HorseRacing)
  for index = 0, horseMapCount - 1 do
    local mapKey = ToClient_GetInstanceFieldMapKeyInfoByTypeAndIndex(__eInstanceContentsType_HorseRacing, __eHorseRacingMode_Normal, index)
    local instanceMapSSW = ToClient_GetInstanceMapStaticStatusWrapper(mapKey)
    if nil ~= instanceMapSSW then
      local mapName = instanceMapSSW:getFieldNameStringKey()
      if nil ~= mapName then
        local mapeNameStrig = PAGetString(Defines.StringSheet_GAME, mapName)
        self._ui.combo_mapList:AddItem(mapeNameStrig)
      end
    end
  end
  PaGlobal_HorseRacing_Enter._initialize = true
end
function PaGlobal_HorseRacing_Enter:setNotice()
  local padding = 30
  local panelSizeY = Panel_HorseRacing_Enter:GetSizeY() - self._ui.stc_descBox:GetSizeY()
  local infoBgSizeY = self._ui.stc_infoBG:GetSizeY() - self._ui.stc_descBox:GetSizeY()
  local padPosY = self._ui.stc_keyGuideConsol:GetPosY() - self._ui.stc_descBox:GetSizeY()
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
  self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  self._ui.stc_descBox:SetSize(self._ui.stc_descBox:GetSizeX(), self._ui.txt_desc:GetSizeY() + padding)
  panelSizeY = panelSizeY + self._ui.stc_descBox:GetSizeY()
  Panel_HorseRacing_Enter:SetSize(Panel_HorseRacing_Enter:GetSizeX(), panelSizeY)
  infoBgSizeY = infoBgSizeY + self._ui.stc_descBox:GetSizeY()
  self._ui.stc_infoBG:SetSize(self._ui.stc_infoBG:GetSizeX(), infoBgSizeY)
  padPosY = padPosY + self._ui.stc_descBox:GetSizeY()
  self._ui.stc_keyGuideConsol:SetPosY(padPosY)
  self._ui.stc_buttonArea:ComputePos()
  self._ui.stc_descBox:ComputePos()
  self._ui.txt_desc:ComputePos()
  Panel_HorseRacing_Enter:ComputePos()
end
function PaGlobal_HorseRacing_Enter:registEventHandler()
  if nil == Panel_HorseRacing_Enter then
    return
  end
  self._ui.btn_Join:addInputEvent("Mouse_LUp", "PaGlobalFunc_HorseRacingEnter_Join( )")
  self._ui.btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_HorseRacingEnter_Close()")
  self._ui.btn_smallExit:addInputEvent("Mouse_LUp", "HandleEventLUp_HorseRacingEnter_Close()")
  self._ui.btn_RankList:addInputEvent("Mouse_LUp", "HandleEventLUp_HorseRacingEnter_ShowRankList(true)")
  self._ui.btn_rankListExit:addInputEvent("Mouse_LUp", "HandleEventLUp_HorseRacingEnter_ShowRankList(false)")
  registerEvent("FromClient_ResponseInstanceFieldTypeList", "FromClient_HorseRacing_Enter_ResponseInstanceFieldTypeList")
  registerEvent("FromClient_HorseRacing_Record", "FromClient_HorseRacing_SetRecord")
end
function PaGlobal_HorseRacing_Enter:prepareOpen()
  if nil == Panel_HorseRacing_Enter then
    return
  end
  PaGlobal_HorseRacing_Enter._ui.combo_mapList:SetSelectItemIndex(-1)
  PaGlobal_HorseRacing_Enter._ui.stc_descBg:ChangeTextureInfoName(self._baseTexture)
  local x1, y1, x2, y2 = 0, 0, 0, 0
  x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_HorseRacing_Enter._ui.stc_descBg, 1, 204, 501, 364)
  PaGlobal_HorseRacing_Enter._ui.stc_descBg:getBaseTexture():setUV(x1, y1, x2, y2)
  PaGlobal_HorseRacing_Enter._ui.stc_descBg:setRenderTexture(PaGlobal_HorseRacing_Enter._ui.stc_descBg:getBaseTexture())
  PaGlobal_HorseRacing_Enter._ui.txt_mapName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_MAP_STAGENAME_NONE"))
  PaGlobal_HorseRacing_Enter._ui.combo_mapList:SetText(self._string_NotSelected)
  PaGlobal_HorseRacing_Enter._selectedMode = -1
  PaGlobal_HorseRacing_Enter:openRecord()
  PaGlobal_HorseRacing_Enter:open()
  Panel_HorseRacing_Enter:ComputePos()
  local originalItemKeyList = {}
  local rewardCount = ToClient_GetHorseRacingRewardOverlapCount()
  for index = 0, rewardCount do
    originalItemKeyList[index] = ToClient_GetInstanceHorseRaceRewardItemKeyByOverlapRankIndex(index)
    if nil ~= originalItemKeyList[index] then
      local itemSSW = getItemEnchantStaticStatus(originalItemKeyList[index])
      if nil ~= itemSSW then
        self._ui.stc_rewardIcon[index]:ChangeTextureInfoName("Icon/" .. itemSSW:getIconPath())
        self._ui.stc_rewardIcon[index]:addInputEvent("Mouse_On", "PaGlobal_HorseRacing_Enter_ShowItemToolTip(" .. index .. ")")
        self._ui.stc_rewardIcon[index]:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
        self._ui.stc_rewardIcon[index]:SetIgnore(false)
      end
    end
  end
  HandleEventLUp_HorseRacingEnter_ShowRankList(false)
  if false == _ContentsGroup_HorseRacingRank then
    self:showRankArea(_ContentsGroup_HorseRacingRank)
  end
  self:setNotice()
end
function PaGlobal_HorseRacing_Enter_ShowItemToolTip(index)
  local itemKey = ToClient_GetInstanceHorseRaceRewardItemKeyByOverlapRankIndex(index)
  if nil == itemKey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(itemKey)
  if nil == itemSSW then
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, PaGlobal_HorseRacing_Enter._ui.stc_rewardIcon[index], true, false)
end
function PaGlobal_HorseRacing_Enter:showRankArea(isShow)
  if nil == Panel_HorseRacing_Enter then
    return
  end
  local gap = 9
  local skipSizeY = self._ui.combo_mapList:GetSpanSize().y - gap
  self._ui.btn_RankList:SetShow(false)
  self._ui.combo_mapList:SetSpanSize(self._ui.combo_mapList:GetSpanSize().x, self._ui.combo_mapList:GetSpanSize().y - skipSizeY)
  self._ui.stc_descBg:SetSpanSize(self._ui.stc_descBg:GetSpanSize().x, self._ui.stc_descBg:GetSpanSize().y - skipSizeY)
  self._ui.stc_infoBG:SetSpanSize(self._ui.stc_infoBG:GetSpanSize().x, self._ui.stc_infoBG:GetSpanSize().y - skipSizeY)
  self._ui.txt_reward:SetSpanSize(self._ui.txt_reward:GetSpanSize().x, self._ui.txt_reward:GetSpanSize().y - skipSizeY)
  self._ui.stc_line1:SetSpanSize(self._ui.stc_line1:GetSpanSize().x, self._ui.stc_line1:GetSpanSize().y - skipSizeY)
  self._ui.stc_line2:SetSpanSize(self._ui.stc_line2:GetSpanSize().x, self._ui.stc_line2:GetSpanSize().y - skipSizeY)
  Panel_HorseRacing_Enter:SetSize(Panel_HorseRacing_Enter:GetSizeX(), Panel_HorseRacing_Enter:GetSizeY() - skipSizeY)
  Panel_HorseRacing_Enter:ComputePos()
end
function PaGlobal_HorseRacing_Enter:open()
  if nil == Panel_HorseRacing_Enter then
    return
  end
  Panel_HorseRacing_Enter:SetShow(true)
end
function PaGlobal_HorseRacing_Enter:prepareClose()
  if nil == Panel_HorseRacing_Enter then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_HorseRacing_Enter._ui.combo_mapList:ToggleListbox()
  PaGlobal_HorseRacing_Enter:close()
end
function PaGlobal_HorseRacing_Enter:close()
  if nil == Panel_HorseRacing_Enter then
    return
  end
  Panel_HorseRacing_Enter:SetShow(false)
end
function PaGlobal_HorseRacing_Enter:validate()
  PaGlobal_HorseRacing_Enter._ui.btn_Join:isValidate()
  PaGlobal_HorseRacing_Enter._ui.btn_exit:isValidate()
  PaGlobal_HorseRacing_Enter._ui.btn_smallExit:isValidate()
  PaGlobal_HorseRacing_Enter._ui.combo_mapList:isValidate()
end
function PaGlobal_HorseRacing_Enter:openRecord()
  if nil == PaGlobal_HorseRacing_Enter then
    return
  end
  if -1 == self._selectedMode then
    if true == self._ui.stc_recordArea:GetShow() then
      self._ui.stc_recordArea:SetShow(false)
      self._ui.stc_descBox:SetPosY(self._recordAreaPos.y)
      local panelSizeY = Panel_HorseRacing_Enter:GetSizeY() - self._ui.stc_recordArea:GetSizeY()
      local infoBgSizeY = self._ui.stc_infoBG:GetSizeY() - self._ui.stc_recordArea:GetSizeY()
      local padPosY = self._ui.stc_keyGuideConsol:GetPosY() - self._ui.stc_recordArea:GetSizeY()
      Panel_HorseRacing_Enter:SetSize(Panel_HorseRacing_Enter:GetSizeX(), panelSizeY)
      self._ui.stc_infoBG:SetSize(self._ui.stc_infoBG:GetSizeX(), infoBgSizeY)
      self._ui.stc_keyGuideConsol:SetPosY(padPosY)
    end
  elseif true == _ContentsGroup_HorseRacingRank and false == self._ui.stc_recordArea:GetShow() then
    self._ui.stc_recordArea:SetShow(true)
    self._ui.stc_descBox:SetPosY(self._descBoxPos.y)
    local panelSizeY = Panel_HorseRacing_Enter:GetSizeY() + self._ui.stc_recordArea:GetSizeY()
    local infoBgSizeY = self._ui.stc_infoBG:GetSizeY() + self._ui.stc_recordArea:GetSizeY()
    local padPosY = self._ui.stc_keyGuideConsol:GetPosY() + self._ui.stc_recordArea:GetSizeY()
    Panel_HorseRacing_Enter:SetSize(Panel_HorseRacing_Enter:GetSizeX(), panelSizeY)
    self._ui.stc_infoBG:SetSize(self._ui.stc_infoBG:GetSizeX(), infoBgSizeY)
    self._ui.stc_keyGuideConsol:SetPosY(padPosY)
  end
  self._ui.stc_buttonArea:ComputePos()
  self._ui.stc_descBox:ComputePos()
  self._ui.txt_desc:ComputePos()
  Panel_HorseRacing_Enter:ComputePos()
end
function FromClient_HorseRacingEnter_Open()
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_HORSERACE_EXIT_WARNING"),
      functionYes = ToClient_UnJoinInstanceFieldForAll,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    local state = ToClient_getHorseRacingState()
    if __eHorseRacing_Play == state then
      messageBoxData.content = PAGetString(Defines.StringSheet_GAME, "LUA_HORSERACE_EXIT_WARNING_PENALTY")
    end
    MessageBox.showMessageBox(messageBoxData)
  else
    PaGlobal_HorseRacing_Enter:prepareOpen()
  end
end
function HandleEventLUp_HorseRacingEnter_ShowRankList(isShow)
  if nil == Panel_HorseRacing_Enter then
    return
  end
  if true == isShow then
    Panel_HorseRacing_Enter:SetHorizonCenter()
    local spanX = PaGlobal_HorseRacing_Enter._ui.stc_rankListPanel:GetSizeX() / 2
    Panel_HorseRacing_Enter:SetSpanSize(-spanX, Panel_HorseRacing_Enter:GetSpanSize().y)
    PaGlobal_HorseRacing_Enter._ui.stc_rankListPanel:SetShow(true)
    PaGlobal_HorseRacing_Enter._ui.web_rankList:SetShow(true)
    PaGlobal_HorseRacing_Enter._ui.web_rankList:SetIgnore(false)
  else
    Panel_HorseRacing_Enter:SetHorizonCenter()
    Panel_HorseRacing_Enter:SetSpanSize(0, Panel_HorseRacing_Enter:GetSpanSize().y)
    PaGlobal_HorseRacing_Enter._ui.stc_rankListPanel:SetShow(false)
    PaGlobal_HorseRacing_Enter._ui.web_rankList:SetIgnore(true)
    PaGlobal_HorseRacing_Enter._ui.web_rankList:SetShow(false)
    PaGlobal_HorseRacing_Enter._ui.web_rankList:ResetUrl()
    Panel_HorseRacing_Enter:ComputePos()
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local bAdventureWebUrl = PaGlobal_URL_Check(worldNo)
  local UserNo = getSelfPlayer():get():getUserNo()
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  if -1 == PaGlobal_HorseRacing_Enter._selectedMode then
    local url = bAdventureWebUrl .. "/HorseRacingRank/Index?userNo=" .. tostring(UserNo) .. "&certKey=" .. tostring(cryptKey)
    PaGlobal_HorseRacing_Enter._ui.web_rankList:SetUrl(PaGlobal_HorseRacing_Enter._ui.web_rankList:GetSizeX(), PaGlobal_HorseRacing_Enter._ui.web_rankList:GetSizeY(), url)
  else
    local mapKey = ToClient_GetInstanceFieldMapKeyInfoByTypeAndIndex(__eInstanceContentsType_HorseRacing, __eHorseRacingMode_Normal, PaGlobal_HorseRacing_Enter._selectedMode)
    local url = bAdventureWebUrl .. "/HorseRacingRank/Index?userNo=" .. tostring(UserNo) .. "&certKey=" .. tostring(cryptKey) .. "&mapKey=" .. tostring(mapKey)
    PaGlobal_HorseRacing_Enter._ui.web_rankList:SetUrl(PaGlobal_HorseRacing_Enter._ui.web_rankList:GetSizeX(), PaGlobal_HorseRacing_Enter._ui.web_rankList:GetSizeY(), url)
  end
  Panel_HorseRacing_Enter:ComputePos()
end
function HandleEventLUp_HorseRacingEnter_Close()
  PaGlobal_HorseRacing_Enter:prepareClose()
end
function HandleEventLUp_HorseRacingEnter_ToggleMapList()
  PaGlobal_HorseRacing_Enter._ui.combo_mapList:ToggleListbox()
end
function HandleEventLUp_HorseRacingEnter_SelectMapList()
  local mode = PaGlobal_HorseRacing_Enter._ui.combo_mapList:GetSelectIndex()
  local mapKey = ToClient_GetInstanceFieldMapKeyInfoByTypeAndIndex(__eInstanceContentsType_HorseRacing, __eHorseRacingMode_Normal, mode)
  local instanceMapSSW = ToClient_GetInstanceMapStaticStatusWrapper(mapKey)
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if nil ~= instanceMapSSW then
    local uiTexturePath = instanceMapSSW:getUITexturePath()
    local fieldName = instanceMapSSW:getFieldNameStringKey()
    if nil ~= uiTexturePath and nil ~= fieldName then
      local mapeNameStrig = PAGetString(Defines.StringSheet_GAME, fieldName)
      PaGlobal_HorseRacing_Enter._ui.combo_mapList:SetText(mapeNameStrig)
      PaGlobal_HorseRacing_Enter._ui.txt_mapName:SetText(mapeNameStrig)
      local uiTextureUV_x1 = instanceMapSSW:getUVByIndex(0)
      local uiTextureUV_y1 = instanceMapSSW:getUVByIndex(1)
      local uiTextureUV_x2 = instanceMapSSW:getUVByIndex(2)
      local uiTextureUV_y2 = instanceMapSSW:getUVByIndex(3)
      PaGlobal_HorseRacing_Enter._ui.stc_descBg:ChangeTextureInfoName(uiTexturePath)
      x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_HorseRacing_Enter._ui.stc_descBg, uiTextureUV_x1, uiTextureUV_y1, uiTextureUV_x2, uiTextureUV_y2)
      PaGlobal_HorseRacing_Enter._ui.stc_descBg:getBaseTexture():setUV(x1, y1, x2, y2)
    end
  end
  PaGlobal_HorseRacing_Enter._ui.stc_descBg:setRenderTexture(PaGlobal_HorseRacing_Enter._ui.stc_descBg:getBaseTexture())
  PaGlobal_HorseRacing_Enter._selectedMode = mode
  ToClient_GetHorseRacingShortRecord(mapKey)
  if true == _ContentsGroup_HorseRacingRank then
    PaGlobal_HorseRacing_Enter:openRecord()
  end
end
function PaGlobalFunc_HorseRacingEnter_Join()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == selfPlayer:isInstancePlayer() then
    return
  end
  if true == selfPlayer:get():hasParty() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_ROOM_PARTY_NOT_IN"))
    return
  end
  local horseMapCount = ToClient_GetInstanceFieldTypeInfoCount(__eInstanceContentsType_HorseRacing)
  if PaGlobal_HorseRacing_Enter._selectedMode < 0 or horseMapCount < PaGlobal_HorseRacing_Enter._selectedMode then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HORSERACE_SELECT_NOT_TRACK"))
    return
  end
  local playerWrapper = getSelfPlayer()
  if nil == playerWrapper then
    return
  end
  local player = playerWrapper:get()
  local hp = player:getHp()
  local maxHp = player:getMaxHp()
  if player:doRideMyVehicle() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_NOT_RIDEHORSE"))
    return
  elseif ToClient_IsMyselfInArena() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCompetitionAlreadyIn"))
    return
  end
  if false == IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_HORSERACING"))
    return
  end
  if true == ToClient_isEventChannel() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantAccessToField"))
    return
  end
  if hp == maxHp then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"))
    local mapKey = ToClient_GetInstanceFieldMapKeyInfoByTypeAndIndex(__eInstanceContentsType_HorseRacing, __eHorseRacingMode_Normal, PaGlobal_HorseRacing_Enter._selectedMode)
    ToClient_RequestJoinInstanceHorseRace(mapKey, __eHorseRacingMode_Normal)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
  end
end
function HandleEventLUp_HorseRacingEnter_Toggle()
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_HORSERACE_EXIT_WARNING"),
      functionYes = ToClient_UnJoinInstanceFieldForAll,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    local state = ToClient_getHorseRacingState()
    if __eHorseRacing_Play == state then
      messageBoxData.content = PAGetString(Defines.StringSheet_GAME, "LUA_HORSERACE_EXIT_WARNING_PENALTY")
    end
    MessageBox.showMessageBox(messageBoxData)
  elseif true == Panel_HorseRacing_Enter:GetShow() then
    PaGlobal_HorseRacing_Enter:prepareClose()
  else
    PaGlobal_HorseRacing_Enter:prepareOpen()
  end
end
function FromClient_HorseRacing_Enter_ResponseInstanceFieldTypeList()
  if nil == Panel_HorseRacing_Enter then
  end
  local self = PaGlobal_HorseRacing_Enter
  self._ui.combo_mapList:DeleteAllItem()
  local horseMapCount = ToClient_GetInstanceFieldTypeInfoCount(__eInstanceContentsType_HorseRacing)
  for index = 0, horseMapCount - 1 do
    local mapKey = ToClient_GetInstanceFieldMapKeyInfoByTypeAndIndex(__eInstanceContentsType_HorseRacing, __eHorseRacingMode_Normal, index)
    local instanceMapSSW = ToClient_GetInstanceMapStaticStatusWrapper(mapKey)
    if nil ~= instanceMapSSW then
      local mapName = instanceMapSSW:getFieldNameStringKey()
      if nil ~= mapName then
        local mapeNameStrig = PAGetString(Defines.StringSheet_GAME, mapName)
        self._ui.combo_mapList:AddItem(mapeNameStrig)
      end
    end
  end
end
function FromClient_HorseRacing_SetRecord(playCount, shortRecord)
  if nil == Panel_HorseRacing_Enter then
    return
  end
  if 0 == playCount then
    PaGlobal_HorseRacing_Enter._ui.txt_Nonrecord:SetShow(true)
    PaGlobal_HorseRacing_Enter._ui.txt_shortRecord:SetShow(false)
    PaGlobal_HorseRacing_Enter._ui.txt_shortRecordValue:SetShow(false)
    PaGlobal_HorseRacing_Enter._ui.txt_raceCount:SetShow(false)
    PaGlobal_HorseRacing_Enter._ui.txt_raceCountValue:SetShow(false)
  else
    PaGlobal_HorseRacing_Enter._ui.txt_Nonrecord:SetShow(false)
    PaGlobal_HorseRacing_Enter._ui.txt_shortRecord:SetShow(true)
    PaGlobal_HorseRacing_Enter._ui.txt_shortRecordValue:SetShow(true)
    PaGlobal_HorseRacing_Enter._ui.txt_raceCount:SetShow(true)
    PaGlobal_HorseRacing_Enter._ui.txt_raceCountValue:SetShow(true)
    PaGlobal_HorseRacing_Enter._ui.txt_raceCountValue:SetText(tostring(playCount))
    PaGlobal_HorseRacing_Enter._ui.txt_shortRecordValue:SetText(tostring(shortRecord))
  end
end
