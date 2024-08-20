function PaGlobal_GuildMainServerSet:initialize()
  self._ui.stc_titleBg = UI.getChildControl(Panel_Guild_MainServerSet_All, "Static_TitleArea")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui.stc_selectBg = UI.getChildControl(Panel_Guild_MainServerSet_All, "Static_SelectBG")
  self._ui.list2_serverList = UI.getChildControl(self._ui.stc_selectBg, "List2_MainServerList")
  self._ui.stc_descBg = UI.getChildControl(self._ui.stc_selectBg, "Static_Desc")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descBg, "StaticText_Desc")
  self._ui.stc_keyGuideBG = UI.getChildControl(Panel_Guild_MainServerSet_All, "Static_KeyGuide_ConsoleUI")
  self._ui.txt_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui.txt_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_B_ConsoleUI")
  self:registEventHandler()
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
  self:setDescSize()
  if true == _ContentsGroup_UsePadSnapping then
    self:setAlignKeyGuide()
  else
    self._ui.stc_keyGuideBG:SetShow(false)
  end
end
function PaGlobal_GuildMainServerSet:registEventHandler()
  registerEvent("FromClient_ChangeGuildMainServer", "FromClient_GuildMainServerSet_ChangeGuildMainServer")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildMainServerSet_Close()")
  self._ui.list2_serverList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_GuildMainServerSet_ListCreateControl")
  self._ui.list2_serverList:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_GuildMainServerSet:prepareOpen()
  if nil == Panel_Guild_MainServerSet_All then
    return
  end
  if false == _ContentsGroup_GuildServerWar then
    return
  end
  local remainTime = ToClient_GetGuildMainServerCurrentCoolTime()
  if 0 ~= remainTime then
    local cooltimeString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDSERVERSET_LIMIT_CHANGE", "time", convertStringFromMillisecondtime(toUint64(0, remainTime * 1000)))
    Proc_ShowMessage_Ack(cooltimeString)
    return
  end
  if nil ~= PaGlobalFunc_GuildInfo_All_RightCheck then
    local isRightGuildServerSet = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_GuildDestroy)
    if false == isRightGuildServerSet then
      return
    end
  end
  self:update()
  self:open()
end
function PaGlobal_GuildMainServerSet:open()
  if nil == Panel_Guild_MainServerSet_All then
    return
  end
  Panel_Guild_MainServerSet_All:SetShow(true)
end
function PaGlobal_GuildMainServerSet:prepareClose()
  if nil == Panel_Guild_MainServerSet_All then
    return
  end
  self:close()
end
function PaGlobal_GuildMainServerSet:close()
  if nil == Panel_Guild_MainServerSet_All then
    return
  end
  Panel_Guild_MainServerSet_All:SetShow(false)
end
function PaGlobal_GuildMainServerSet:setDescSize()
  local textSizeY = self._ui.txt_desc:GetTextSizeY()
  local gap = self._ui.txt_desc:GetSizeY() - textSizeY
  self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetSizeY() - gap)
  self._ui.stc_descBg:SetSize(self._ui.stc_descBg:GetSizeX(), self._ui.stc_descBg:GetSizeY() - gap)
  self._ui.stc_selectBg:SetSize(self._ui.stc_selectBg:GetSizeX(), self._ui.stc_selectBg:GetSizeY() - gap)
  Panel_Guild_MainServerSet_All:SetSize(Panel_Guild_MainServerSet_All:GetSizeX(), Panel_Guild_MainServerSet_All:GetSizeY() - gap)
  self._ui.stc_keyGuideBG:ComputePos()
end
function PaGlobal_GuildMainServerSet:update()
  local normalServerGroupCount = Int64toInt32(ToClient_GetNormalServerGroupCount())
  local rowCount = math.ceil(normalServerGroupCount * 0.5)
  self._ui.list2_serverList:getElementManager():clearKey()
  for index = 0, rowCount - 1 do
    self._ui.list2_serverList:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_GuildMainServerSet:setAlignKeyGuide()
  local keyGuides = {
    self._ui.txt_keyGuideA,
    self._ui.txt_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
