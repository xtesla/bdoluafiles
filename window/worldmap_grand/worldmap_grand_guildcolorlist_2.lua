function PaGlobal_Worldmap_Grand_GuildColorList_Open()
  if nil == PaGlobal_Worldmap_Grand_GuildColorList then
    return
  end
  PaGlobal_Worldmap_Grand_GuildColorList:prepareOpen()
end
function PaGlobal_Worldmap_Grand_GuildColorList_Close()
  if nil == PaGlobal_Worldmap_Grand_GuildColorList then
    return
  end
  if ToClient_WorldMapIsShow() then
    WorldMapPopupManager:pop()
  else
    PaGlobal_Worldmap_Grand_GuildColorList:prepareClose()
  end
end
function PaGlobal_Worldmap_Grand_GuildColorList_Toggle()
  if nil == Worldmap_Grand_Guildwar_ColorList then
    return
  end
  if false == Worldmap_Grand_Guildwar_ColorList:GetShow() then
    GrandWorldMap_CheckPopup(Global_getGuildColorListPopUpType())
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Worldmap_Grand_Guildwar_ColorList, true)
    Worldmap_Grand_Guildwar_ColorList:SetPosX(getScreenSizeX() - Worldmap_Grand_Guildwar_ColorList:GetSizeX() - 10)
    PaGlobal_Worldmap_Grand_GuildColorList_Open()
  else
    PaGlobal_Worldmap_Grand_GuildColorList_Close()
  end
end
function PaGlobal_Worldmap_Grand_GuildColorList_CreateContent(content, key64)
  local self = PaGlobal_Worldmap_Grand_GuildColorList
  local stc_Icon = UI.getChildControl(content, "Static_Icon_Temp")
  local txt_Name = UI.getChildControl(stc_Icon, "StaticText_GuildName")
  local idx = Int64toInt32(key64)
  local guildName = ToClient_GetObserverGuildNameAt(idx)
  if nil ~= guildName and "" ~= guildName then
    txt_Name:SetTextMode(__eTextMode_LimitText)
    txt_Name:SetText(guildName)
  end
  local color = ToClient_GetObserverGuildColorAt(idx)
  stc_Icon:SetColor(color)
end
