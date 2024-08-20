function PaGlobal_Worldmap_Grand_GuildColorList:initialize()
  if nil == Worldmap_Grand_Guildwar_ColorList then
    return
  end
  if true == self._initialize then
    return
  end
  local staticBG = UI.getChildControl(Worldmap_Grand_Guildwar_ColorList, "Static_BG")
  self._ui._list2 = UI.getChildControl(staticBG, "List2_TitleList_Import")
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_Worldmap_Grand_GuildColorList:registEventHandler()
  if nil == Worldmap_Grand_Guildwar_ColorList then
    return
  end
  self._ui._list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_Worldmap_Grand_GuildColorList_CreateContent")
  self._ui._list2:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_Worldmap_Grand_GuildColorList:prepareOpen()
  if nil == PaGlobal_Worldmap_Grand_GuildColorList then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_Worldmap_Grand_GuildColorList:open()
  if nil == PaGlobal_Worldmap_Grand_GuildColorList then
    return
  end
  Worldmap_Grand_Guildwar_ColorList:SetShow(true)
end
function PaGlobal_Worldmap_Grand_GuildColorList:prepareClose()
  if nil == PaGlobal_Worldmap_Grand_GuildColorList then
    return
  end
  self:close()
end
function PaGlobal_Worldmap_Grand_GuildColorList:close()
  if nil == PaGlobal_Worldmap_Grand_GuildColorList then
    return
  end
  WorldMapPopupManager:pop()
  Worldmap_Grand_Guildwar_ColorList:SetShow(false)
end
function PaGlobal_Worldmap_Grand_GuildColorList:update()
  if nil == PaGlobal_Worldmap_Grand_GuildColorList then
    return
  end
  self._ui._list2:getElementManager():clearKey()
  local guildNoListCount = ToClient_GetObserverGuildNoListCount()
  if 0 == guildNoListCount then
    return
  end
  for idx = 0, guildNoListCount do
    local guildName = ToClient_GetObserverGuildNameAt(idx)
    if nil ~= guildName and "" ~= guildName then
      self._ui._list2:getElementManager():pushKey(toInt64(0, idx))
    end
  end
end
