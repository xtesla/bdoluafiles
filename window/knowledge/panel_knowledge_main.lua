local UI_color = Defines.Color
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local IM = CppEnums.EProcessorInputMode
local UI_PD = CppEnums.Padding
local renderMode = RenderModeWrapper.new(100, {
  Defines.RenderMode.eRenderMode_Knowledge
}, false)
Panel_Knowledge_Main:TEMP_UseUpdateListSwap(true)
Panel_Knowledge_List:TEMP_UseUpdateListSwap(true)
Panel_Knowledge_Point:SetShow(false)
local ui_Copy = {
  _icon = UI.getChildControl(Panel_Knowledge_Main, "Static_C_Knowledge_Icon"),
  _gaugeBG = UI.getChildControl(Panel_Knowledge_Main, "Static_C_GaugeBG"),
  _gauge = UI.getChildControl(Panel_Knowledge_Main, "Progress_C_Gauge"),
  _name = UI.getChildControl(Panel_Knowledge_Main, "StaticText_C_Knowledge_Name"),
  _normal = UI.getChildControl(Panel_Knowledge_Main, "Static_C_Knowledge_Nor"),
  _cardIcon = UI.getChildControl(Panel_Knowledge_Main, "StaticText_C_Knowledge_NrIcon"),
  _category = UI.getChildControl(Panel_Knowledge_List, "StaticText_ListStep_1"),
  _nextArrow = UI.getChildControl(Panel_Knowledge_List, "Static_ListStepArrow_1"),
  _list_Step2 = UI.getChildControl(Panel_Knowledge_List, "StaticText_ListStep_2"),
  _list_Step3 = UI.getChildControl(Panel_Knowledge_List, "StaticText_ListStep_3"),
  _list_Arrow2 = UI.getChildControl(Panel_Knowledge_List, "Static_ListStepArrow_2")
}
uiConst = {
  main = Panel_Knowledge_Main,
  main_WhosKnowledge = UI.getChildControl(Panel_Knowledge_Main, "StaticText_WhosKnowledge"),
  main_Top = UI.getChildControl(Panel_Knowledge_Main, "Button_Top"),
  main_Hint = UI.getChildControl(Panel_Knowledge_Main, "StaticText_Notice"),
  staticText_KnowledgeBuff = UI.getChildControl(Panel_Knowledge_Main, "StaticText_KnowledgeBuff"),
  list = Panel_Knowledge_List,
  list_MenuBg = UI.getChildControl(Panel_Knowledge_List, "Static_TopMenuBG"),
  list_ListBg = UI.getChildControl(Panel_Knowledge_List, "Static_ListBG"),
  list_Edit = UI.getChildControl(Panel_Knowledge_List, "Edit_FindKnowledge"),
  list_Tree = UI.getChildControl(Panel_Knowledge_List, "Tree_Knowledge_List"),
  list_FindList = UI.getChildControl(Panel_Knowledge_List, "Button_MyList"),
  list_Hint = UI.getChildControl(Panel_Knowledge_List, "StaticText_Notice"),
  list_HintBG = UI.getChildControl(Panel_Knowledge_List, "StaticText_NoticeBG"),
  info = Panel_Knowledge_Info,
  info_Picture = UI.getChildControl(Panel_Knowledge_Info, "Static_Knowledge_Icon"),
  info_Name = UI.getChildControl(Panel_Knowledge_Info, "StaticText_NamePanel"),
  info_Story = UI.getChildControl(Panel_Knowledge_Info, "StaticText_Knowledge_Story"),
  info_Zodiac = UI.getChildControl(Panel_Knowledge_Info, "Static_StarBG"),
  info_zodiacName = UI.getChildControl(Panel_Knowledge_Info, "StaticText_StarName"),
  info_InfoBg = UI.getChildControl(Panel_Knowledge_Info, "Static_InfoBG"),
  info_npcInfoBG = UI.getChildControl(Panel_Knowledge_Info, "Static_NpcInfo_BG"),
  info_NpcInterest = UI.getChildControl(Panel_Knowledge_Info, "StaticText_OnlyNpc_Interest"),
  info_NpcInt = UI.getChildControl(Panel_Knowledge_Info, "StaticText_OnlyNpc_NpcInt"),
  info_NpcValue = UI.getChildControl(Panel_Knowledge_Info, "StaticText_OnlyNpc_Value"),
  info_Value = UI.getChildControl(Panel_Knowledge_Info, "Static_Icon_Value"),
  info_Interest = UI.getChildControl(Panel_Knowledge_Info, "Static_Icon_Interest"),
  info_CardEffect = UI.getChildControl(Panel_Knowledge_Info, "StaticText_CardEffect"),
  list_GetKnowledgeCount = UI.getChildControl(Panel_Knowledge_List, "StaticText_GetKnowledgeCount"),
  _btn_ChaseStart = UI.getChildControl(Panel_Knowledge_List, "Button_Chase_Start"),
  _btn_ChaseStop = UI.getChildControl(Panel_Knowledge_List, "Button_Chase_Stop"),
  _stc_ChaseInfoBox = UI.getChildControl(Panel_Knowledge_List, "Static_ChaseInfo_Box"),
  _txt_ChaseInfoTitle = nil,
  _txt_ChaseInfoDesc = nil,
  _txt_ChaseName = nil,
  _btn_ChaseCheck = UI.getChildControl(Panel_Knowledge_List, "Button_Chase_Check")
}
PaGlobal_Knowledge_Point = {
  point_Btn_Question = UI.getChildControl(Panel_Knowledge_Point, "Button_Question"),
  point_Txt_Desc = UI.getChildControl(Panel_Knowledge_Point, "StaticText_Desc"),
  point_Tooltip = UI.getChildControl(Panel_Knowledge_Point, "StaticText_TooltipBg"),
  point_OptionBG = UI.getChildControl(Panel_Knowledge_Point, "StaticText_OptionBG"),
  point_HorizonLine = UI.getChildControl(Panel_Knowledge_Point, "Static_HorizonLine"),
  point_Title = {},
  point_Desc = {},
  point_Count = 10,
  defaultOptionBGSizeY = 0
}
local lastSelectCardKey
local chaseData = {
  baseChaseToolTipPosY = 0,
  ecologyMinThemaKey = 10001,
  ecologyMaxThemaKey = 20000,
  isEcology = false,
  chaseSelectKey = nil,
  chaseName = nil
}
function PaGlobal_Knowledge_Point:Init()
  local originalTooltipBgSizeX = self.point_Tooltip:GetSizeX()
  local titleTextSizeX = 0
  local descTextSizeX = 0
  for index = 0, self.point_Count - 1 do
    self.point_Title[index] = UI.getChildControl(self.point_Tooltip, "StaticText_" .. index)
    self.point_Desc[index] = UI.getChildControl(self.point_Tooltip, "StaticText_GreDesc_" .. index)
    titleTextSizeX = math.max(titleTextSizeX, self.point_Title[index]:GetTextSizeX())
    descTextSizeX = math.max(descTextSizeX, self.point_Desc[index]:GetTextSizeX())
  end
  if titleTextSizeX > 70 then
    self.point_Tooltip:SetSize(math.max(originalTooltipBgSizeX, 20 + titleTextSizeX + 5 + descTextSizeX + 10), self.point_Tooltip:GetSizeY())
    self.point_Tooltip:SetPosX(originalTooltipBgSizeX - self.point_Tooltip:GetSizeX())
    for index = 0, self.point_Count - 1 do
      self.point_Desc[index]:SetPosX(20 + titleTextSizeX + 5)
    end
  else
    self.point_Tooltip:SetSize(math.max(originalTooltipBgSizeX, 90 + descTextSizeX + 10), self.point_Tooltip:GetSizeY())
    self.point_Tooltip:SetPosX(originalTooltipBgSizeX - self.point_Tooltip:GetSizeX())
  end
  uiConst.list_HintTop = UI.getChildControl(uiConst.list_HintBG, "StaticText_Notice_Top")
  PaGlobal_Knowledge_Point.point_OptionShow = UI.getChildControl(PaGlobal_Knowledge_Point.point_OptionBG, "RadioButton_Show")
  PaGlobal_Knowledge_Point.point_OptionHide = UI.getChildControl(PaGlobal_Knowledge_Point.point_OptionBG, "RadioButton_Hide")
  PaGlobal_Knowledge_Point.point_bottomDesc = UI.getChildControl(PaGlobal_Knowledge_Point.point_OptionBG, "StaticText_Option_Desc")
  PaGlobal_Knowledge_Point.point_tooltipOptionShow = UI.getChildControl(Panel_Knowledge_Point, "Static_ShowOption")
  PaGlobal_Knowledge_Point.point_tooltipOptionHide = UI.getChildControl(Panel_Knowledge_Point, "Static_HideOption")
  PaGlobal_Knowledge_Point.defaultOptionBGSizeY = PaGlobal_Knowledge_Point.point_OptionBG:GetSizeY()
end
PaGlobal_Knowledge_Point:Init()
local uiListControlByKey = {
  [1] = UI.getChildControl(Panel_Knowledge_List, "Button_Man"),
  [5001] = UI.getChildControl(Panel_Knowledge_List, "Button_Land"),
  [5020] = UI.getChildControl(Panel_Knowledge_List, "Button_BigSea"),
  [10001] = UI.getChildControl(Panel_Knowledge_List, "Button_Env"),
  [25001] = UI.getChildControl(Panel_Knowledge_List, "Button_Book"),
  [20001] = UI.getChildControl(Panel_Knowledge_List, "Button_Travel"),
  [30001] = UI.getChildControl(Panel_Knowledge_List, "Button_Life"),
  [31300] = UI.getChildControl(Panel_Knowledge_List, "Button_Guide"),
  [31310] = UI.getChildControl(Panel_Knowledge_List, "Button_TradeItem")
}
local circularColorValue = {
  [1] = Defines.Color.C_FFF4D35D,
  [5001] = Defines.Color.C_FF387f14,
  [5020] = Defines.Color.C_FF3E5CFF,
  [10001] = Defines.Color.C_FF00C2EA,
  [25001] = Defines.Color.C_FF844BE3,
  [20001] = Defines.Color.C_FFBCF44B,
  [30001] = Defines.Color.C_FFDA0000,
  [31300] = Defines.Color.C_FFf570a1,
  [31310] = Defines.Color.C_FF25c28b
}
local ui = {
  mainGroup = {},
  currentGroup = {},
  cardGroup = {},
  topList = {}
}
local constValue = {
  buffTypeString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_FAVOR"),
    PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_INTERESTING"),
    PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_DEMANDINGINTERESTING"),
    PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_DEMANDINGFAVOR")
  },
  listIconLeft = uiListControlByKey[1]:GetPosX()
}
local rotateValue = 0
local rotateResultValue = 0
local radiusValue = 0
local radiusResultValue = 100
local zodiacInfo = {
  lineKeyList = {},
  color = float4(1, 1, 1, 1),
  zOrder = 10,
  width = 1,
  lineBGKeyList = {},
  colorBG = float4(0.8, 0.9, 0.6, 0.5),
  colorFG = float4(0.8, 0.9, 0.6, 1),
  zOrderBG = 5,
  widthBG = 10,
  category = "InstantLine_MentalKnowledgeZodiac"
}
local function init()
  for _, v in pairs(ui_Copy) do
    v:SetShow(false)
  end
  for key, value in pairs(uiListControlByKey) do
    value:SetShow(false)
    value:addInputEvent("Mouse_LUp", "Panel_Knowledge_SelectMainUIByKey(" .. key .. ")")
  end
  uiConst.main_WhosKnowledge:SetShow(true)
  uiConst.main_Top:SetShow(true)
  uiConst.main_WhosKnowledge:SetPosX(100)
  uiConst.main_WhosKnowledge:SetPosY(100)
  uiConst.main_Top:SetPosX(100)
  uiConst.main_Top:SetPosY(100)
  uiConst.info_Story:SetTextMode(__eTextMode_AutoWrap)
  uiConst.info_Story:SetAutoResize(true)
  uiConst.info_npcInfoBG:AddChild(uiConst.info_NpcInterest)
  uiConst.info_npcInfoBG:AddChild(uiConst.info_NpcInt)
  uiConst.info_npcInfoBG:AddChild(uiConst.info_NpcValue)
  uiConst.info_InfoBg:AddChild(uiConst.info_CardEffect)
  uiConst.info_InfoBg:AddChild(uiConst.info_Value)
  uiConst.info_InfoBg:AddChild(uiConst.info_Interest)
  uiConst.info:RemoveControl(uiConst.info_NpcInterest)
  uiConst.info:RemoveControl(uiConst.info_NpcInt)
  uiConst.info:RemoveControl(uiConst.info_NpcValue)
  uiConst.info:RemoveControl(uiConst.info_CardEffect)
  uiConst.info:RemoveControl(uiConst.info_Value)
  uiConst.info:RemoveControl(uiConst.info_Interest)
  uiConst.info_NpcValue:SetTextMode(__eTextMode_AutoWrap)
  uiConst.info_Value:SetTextMode(__eTextMode_AutoWrap)
  uiConst.list_GetKnowledgeCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_KNOWLEDGE_MAIN_GETKNOWLEDGECOUNT", "count", ToClient_GetTotalMentalCardCount()))
  uiConst._txt_ChaseInfoTitle = UI.getChildControl(uiConst._stc_ChaseInfoBox, "StaticText_Title")
  uiConst._txt_ChaseInfoDesc = UI.getChildControl(uiConst._stc_ChaseInfoBox, "StaticText_Desc")
  uiConst._txt_ChaseName = UI.getChildControl(uiConst._stc_ChaseInfoBox, "StaticText_Chasing_Name")
  uiConst._stc_ChaseInfoBox:SetShow(false)
  uiConst._btn_ChaseStart:SetShow(false)
  uiConst._btn_ChaseStop:SetShow(false)
  uiConst._btn_ChaseCheck:SetShow(false)
  chaseData.baseChaseToolTipPosY = uiConst._stc_ChaseInfoBox:GetPosY()
  if true == _ContentsGroup_ChaseMonster then
    uiConst._btn_ChaseStart:addInputEvent("Mouse_On", "HandleEventOn_Knowledge_ShowChaseTooltip(true)")
    uiConst._btn_ChaseStart:addInputEvent("Mouse_Out", "HandleEventOn_Knowledge_ShowChaseTooltip(false)")
    uiConst._btn_ChaseStart:addInputEvent("Mouse_LUp", "HandleEventLUp_Knowledge_SelectChase(true)")
    uiConst._btn_ChaseStop:addInputEvent("Mouse_On", "HandleEventOn_Knowledge_ShowChaseTooltip(true)")
    uiConst._btn_ChaseStop:addInputEvent("Mouse_Out", "HandleEventOn_Knowledge_ShowChaseTooltip(false)")
    uiConst._btn_ChaseStop:addInputEvent("Mouse_LUp", "HandleEventLUp_Knowledge_SelectChase(false)")
    uiConst._btn_ChaseCheck:addInputEvent("Mouse_On", "HandleEventOn_Knowledge_ShowChaseTooltip(true)")
    uiConst._btn_ChaseCheck:addInputEvent("Mouse_Out", "HandleEventOn_Knowledge_ShowChaseTooltip(false)")
    uiConst._btn_ChaseCheck:addInputEvent("Mouse_LUp", "HandleEventLUp_Knowledge_FindChaseCard()")
    local chaseNameGab = -10
    local diffChaseTitleSizeX = uiConst._txt_ChaseInfoTitle:GetTextSizeX() - uiConst._txt_ChaseInfoTitle:GetSizeX()
    uiConst._txt_ChaseName:SetSize(uiConst._txt_ChaseName:GetSizeX() - diffChaseTitleSizeX, uiConst._txt_ChaseName:GetSizeY())
    uiConst._txt_ChaseName:SetSpanSize(uiConst._txt_ChaseName:GetSpanSize().x + diffChaseTitleSizeX + chaseNameGab, uiConst._txt_ChaseName:GetSpanSize().y)
  end
end
function Panel_Knowledge_AddItemTree(parentUIItem, theme)
  local childItem = uiConst.list_Tree:createRootItem()
  childItem:SetKey(-theme:getKey())
  local nameString = theme:getName()
  if 0 < theme:getMaxIncreaseWp() then
    nameString = nameString .. PAGetStringParam1(Defines.StringSheet_GAME, "Lua_Knowledge_TalkingPowerUp", "increaseWp", theme:getIncreaseWp() .. "/" .. theme:getMaxIncreaseWp() .. " ")
  end
  local collected_complete
  if theme:getCardCollectedCount() == theme:getCardCollectMaxCount() then
    collected_complete = PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGE_LIST_COMPLETE")
    childItem:SetFontColor(Defines.Color.C_FF6DC6FF)
  else
    collected_complete = ""
    childItem:SetFontColor(Defines.Color.C_FFFFFFFF)
  end
  nameString = nameString .. " " .. collected_complete
  childItem:SetText(nameString)
  if nil == parentUIItem then
    uiConst.list_Tree:AddRootItem(childItem)
  else
    uiConst.list_Tree:AddItem(childItem, parentUIItem)
  end
  local childThemeCount = theme:getChildThemeCount()
  for idx = 0, childThemeCount - 1 do
    local childTheme = theme:getChildThemeByIndex(idx)
    Panel_Knowledge_AddItemTree(childItem, childTheme)
  end
  local isParentsChase = false
  if true == _ContentsGroup_ChaseMonster and nil ~= chaseData.chaseSelectKey and 0 > chaseData.chaseSelectKey and chaseData.chaseSelectKey == -theme:getKey() then
    isParentsChase = true
  end
  local childCardCount = theme:getChildCardCount()
  for idx = 0, childCardCount - 1 do
    local childCard = theme:getChildCardByIndex(idx)
    local childCardItem = uiConst.list_Tree:createChildItem()
    if nil ~= childCard then
      local cardKey = childCard:getKey()
      childCardItem:SetKey(cardKey)
      local cardName = childCard:getName()
      if true == _ContentsGroup_ChaseMonster and nil ~= chaseData.chaseSelectKey then
        local characterKey = ToClient_getCharacterKeyByMentalCardKey(cardKey)
        if cardKey == chaseData.chaseSelectKey or true == isParentsChase and true == ToClient_isPossibleChase(characterKey) then
          local strsplit = string.split(cardName, "]")
          if nil ~= strsplit[2] then
            local grade = strsplit[1]
            local name = strsplit[2]
            cardName = grade .. "]<PAColor0xff84fff5>" .. name .. "<PAOldColor>"
          else
            cardName = "<PAColor0xff84fff5>" .. cardName .. "<PAOldColor>"
          end
        end
      end
      childCardItem:SetText(cardName)
      uiConst.list_Tree:AddItem(childCardItem, childItem)
    end
  end
end
local function createMainControls(progressCount)
  for index = 0, progressCount - 1 do
    if nil == ui.mainGroup[index] then
      ui.mainGroup[index] = {}
    end
    local gaugeBG = ui.mainGroup[index]._gaugeBG
    if nil == gaugeBG then
      gaugeBG = UI.createControl(__ePAUIControl_Static, Panel_Knowledge_Main, "Static_GaugeBG_" .. index)
      CopyBaseProperty(ui_Copy._gaugeBG, gaugeBG)
      gaugeBG:SetPosX(20 + index * 140)
      gaugeBG:addInputEvent("Mouse_LUp", "Panel_Knowledge_SelectMainUI(" .. index .. ")")
      gaugeBG:addInputEvent("Mouse_DownScroll", "Panel_Knowledge_RotateValueUpdate(true)")
      gaugeBG:addInputEvent("Mouse_UpScroll", "Panel_Knowledge_RotateValueUpdate(false)")
      ui.mainGroup[index]._gaugeBG = gaugeBG
    end
    gaugeBG:SetShow(true)
    local gauge = ui.mainGroup[index]._gauge
    if nil == gauge then
      gauge = UI.createControl(__ePAUIControl_CircularProgress, gaugeBG, "Progress_Gauge_" .. index)
      CopyBaseProperty(ui_Copy._gauge, gauge)
      gauge:SetVerticalMiddle()
      gauge:SetHorizonCenter()
      gauge:SetIgnore(true)
      ui.mainGroup[index]._gauge = gauge
    end
    gauge:SetCurrentControlPos(0)
    gauge:SetShow(true)
    local icon = ui.mainGroup[index]._icon
    if nil == icon then
      icon = UI.createControl(__ePAUIControl_Static, gaugeBG, "Static_Icon_" .. index)
      CopyBaseProperty(ui_Copy._icon, icon)
      icon:SetVerticalMiddle()
      icon:SetHorizonCenter()
      icon:SetIgnore(true)
      ui.mainGroup[index]._icon = icon
    end
    icon:SetShow(true)
    local name = ui.mainGroup[index]._name
    if nil == name then
      name = UI.createControl(__ePAUIControl_StaticText, gaugeBG, "StaticText_Name_" .. index)
      CopyBaseProperty(ui_Copy._name, name)
      name:SetVerticalBottom()
      name:SetHorizonCenter()
      name:SetSpanSize(name:GetSpanSize().x, -name:GetSizeY())
      name:SetIgnore(true)
      ui.mainGroup[index]._name = name
    end
    name:SetShow(true)
  end
end
local function createCurrentControls(progressCount)
  for index = 0, progressCount - 1 do
    if nil == ui.currentGroup[index] then
      ui.currentGroup[index] = {}
    end
    local gaugeBG = ui.currentGroup[index]._gaugeBG
    if nil == gaugeBG then
      gaugeBG = UI.createControl(__ePAUIControl_Static, Panel_Knowledge_Main, "Static_GaugeBG__" .. index)
      CopyBaseProperty(ui_Copy._gaugeBG, gaugeBG)
      gaugeBG:SetPosX(20 + index * 140)
      gaugeBG:addInputEvent("Mouse_LUp", "Panel_Knowledge_SelectMainUI(" .. index .. ")")
      gaugeBG:addInputEvent("Mouse_DownScroll", "Panel_Knowledge_RotateValueUpdate(true)")
      gaugeBG:addInputEvent("Mouse_UpScroll", "Panel_Knowledge_RotateValueUpdate(false)")
      ui.currentGroup[index]._gaugeBG = gaugeBG
    end
    gaugeBG:SetShow(true)
    local gauge = ui.currentGroup[index]._gauge
    if nil == gauge then
      gauge = UI.createControl(__ePAUIControl_CircularProgress, gaugeBG, "Progress_Gauge_" .. index)
      CopyBaseProperty(ui_Copy._gauge, gauge)
      gauge:SetVerticalMiddle()
      gauge:SetHorizonCenter()
      gauge:SetIgnore(true)
      ui.currentGroup[index]._gauge = gauge
    end
    gauge:SetCurrentControlPos(0)
    gauge:SetShow(true)
    local icon = ui.currentGroup[index]._icon
    if nil == icon then
      icon = UI.createControl(__ePAUIControl_Static, gaugeBG, "Static_Icon__" .. index)
      CopyBaseProperty(ui_Copy._icon, icon)
      icon:SetVerticalMiddle()
      icon:SetHorizonCenter()
      icon:SetIgnore(true)
      ui.currentGroup[index]._icon = icon
    end
    icon:SetShow(true)
    local normal = ui.currentGroup[index]._normal
    if nil == normal then
      normal = UI.createControl(__ePAUIControl_Static, gaugeBG, "Progress_Normal__" .. index)
      CopyBaseProperty(ui_Copy._normal, normal)
      normal:SetVerticalMiddle()
      normal:SetHorizonCenter()
      normal:SetIgnore(true)
      ui.currentGroup[index]._normal = normal
    end
    normal:SetShow(true)
    local name = ui.currentGroup[index]._name
    if nil == name then
      name = UI.createControl(__ePAUIControl_StaticText, gaugeBG, "StaticText_Name__" .. index)
      CopyBaseProperty(ui_Copy._name, name)
      name:SetVerticalBottom()
      name:SetHorizonCenter()
      name:SetSpanSize(name:GetSpanSize().x, -name:GetSizeY())
      name:SetIgnore(true)
      ui.currentGroup[index]._name = name
    end
    name:SetShow(true)
  end
end
local function createCardControls(count)
  for index = 0, count - 1 do
    if nil == ui.cardGroup[index] then
      ui.cardGroup[index] = {}
    end
    local cardIcon = ui.cardGroup[index]._cardIcon
    if nil == cardIcon then
      cardIcon = UI.createControl(__ePAUIControl_StaticText, Panel_Knowledge_Main, "Static_CardIcon__" .. index)
      CopyBaseProperty(ui_Copy._cardIcon, cardIcon)
      cardIcon:SetPosX(20 + index * 140)
      cardIcon:addInputEvent("Mouse_LUp", "Panel_Knowledge_SelectMainUICard(" .. index .. ")")
      cardIcon:addInputEvent("Mouse_On", "Panel_Knowledge_ShowHint(" .. index .. ")")
      cardIcon:addInputEvent("Mouse_Out", "Panel_Knowledge_HideHint()")
      cardIcon:addInputEvent("Mouse_DownScroll", "Panel_Knowledge_RotateValueUpdate(true)")
      cardIcon:addInputEvent("Mouse_UpScroll", "Panel_Knowledge_RotateValueUpdate(false)")
      ui.cardGroup[index]._cardIcon = cardIcon
    end
    cardIcon:SetShow(true)
  end
end
local function createTopListControls(count)
  for index = 0, count - 1 do
    if nil == ui.topList[index] then
      ui.topList[index] = {}
    end
    local category = ui.topList[index]._category
    if nil == category then
      category = UI.createControl(__ePAUIControl_StaticText, Panel_Knowledge_List, "StaticText_CategoryStr_" .. index)
      CopyBaseProperty(ui_Copy._category, category)
      category:SetIgnore(true)
      ui.topList[index]._category = category
    end
    category:SetShow(true)
    local nextArrow = ui.topList[index]._nextArrow
    if nil == nextArrow then
      nextArrow = UI.createControl(__ePAUIControl_Static, Panel_Knowledge_List, "Static_NextArrow_" .. index)
      CopyBaseProperty(ui_Copy._nextArrow, nextArrow)
      nextArrow:SetIgnore(true)
      ui.topList[index]._nextArrow = nextArrow
    end
    nextArrow:SetShow(count - 1 ~= index)
  end
end
local createAndUpdateCircle = function(inputData)
  if inputData.circleLineRadius <= 0 then
    return
  end
  local lineDataBuffer
  if -1 == inputData.circleKey then
    local colorCore = float4(1, 1, 1, 0.8 * inputData.lineAlpha)
    inputData.circleKey = insertCircleLine(inputData.lineCategory, float3(0, 0, 0), colorCore, inputData.circleLineRadius, 2, inputData.coreInteractionLineOrder)
    lineDataBuffer = getLine(inputData.lineCategory, inputData.circleKey, inputData.coreInteractionLineOrder)
    lineDataBuffer._isGlowLine = true
    lineDataBuffer._colorGlow = float4(0.65, 0.8, 1, 0.8 * inputData.lineAlpha)
    lineDataBuffer._lineWidthGlow = 20
  end
  if lineDataBuffer == nil then
    lineDataBuffer = getLine(inputData.lineCategory, inputData.circleKey, inputData.coreInteractionLineOrder)
  end
  if nil ~= lineDataBuffer then
    lineDataBuffer._position = inputData.position
    lineDataBuffer._scale = float3(inputData.circleLineRadius, inputData.circleLineRadius, inputData.circleLineRadius)
    lineDataBuffer._color.w = inputData.constAlphaCore * inputData.lineAlpha
    lineDataBuffer._colorGlow.w = inputData.constAlphaAura * inputData.lineAlpha
  end
end
local function insertCircleLineAndObject(zodiacSignStaticStatusWrapper)
  uiConst.info_Zodiac:ChangeTextureInfoName(zodiacSignStaticStatusWrapper:getZodiacImagePath())
  local defaultPosX = uiConst.info_Zodiac:GetParentPosX() + uiConst.info_Zodiac:GetSizeX() / 2
  local defaultPosY = uiConst.info_Zodiac:GetParentPosY() + uiConst.info_Zodiac:GetSizeY() / 2
  local percents = 0.45
  local uiScale = ToClient_getGameOptionControllerWrapper():getUIScale()
  local lineCount = zodiacSignStaticStatusWrapper:getLineListCount()
  local maxPointX = zodiacSignStaticStatusWrapper:getLineFirstPointByIndex(0).x
  local maxPointY = zodiacSignStaticStatusWrapper:getLineFirstPointByIndex(0).y
  local minPointX = zodiacSignStaticStatusWrapper:getLineFirstPointByIndex(0).x
  local minPointY = zodiacSignStaticStatusWrapper:getLineFirstPointByIndex(0).y
  for index = 0, lineCount - 1 do
    local fromPos = zodiacSignStaticStatusWrapper:getLineFirstPointByIndex(index)
    local toPos = zodiacSignStaticStatusWrapper:getLineSecondPointByIndex(index)
    maxPointX = math.max(maxPointX, fromPos.x)
    maxPointY = math.max(maxPointY, fromPos.y)
    minPointX = math.min(minPointX, fromPos.x)
    minPointY = math.min(minPointY, fromPos.y)
    maxPointX = math.max(maxPointX, toPos.x)
    maxPointY = math.max(maxPointY, toPos.y)
    minPointX = math.min(minPointX, toPos.x)
    minPointY = math.min(minPointY, toPos.y)
  end
  local centerX = (maxPointX + minPointX) / 2
  local centerY = (maxPointY + minPointY) / 2
  for index = 0, lineCount - 1 do
    local fromPos = zodiacSignStaticStatusWrapper:getLineFirstPointByIndex(index)
    local toPos = zodiacSignStaticStatusWrapper:getLineSecondPointByIndex(index)
    local vecX = fromPos.x - centerX
    local vecY = fromPos.y - centerY
    local lenth = math.sqrt(vecX * vecX + vecY * vecY)
    local normalVecX = vecX / lenth
    local normalVecY = vecY / lenth
    fromPos.x = centerX + normalVecX * lenth * uiScale
    fromPos.y = centerY + normalVecY * lenth * uiScale
    vecX = toPos.x - centerX
    vecY = toPos.y - centerY
    lenth = math.sqrt(vecX * vecX + vecY * vecY)
    normalVecX = vecX / lenth
    normalVecY = vecY / lenth
    toPos.x = centerX + normalVecX * lenth * uiScale
    toPos.y = centerY + normalVecY * lenth * uiScale
    fromPos.x = fromPos.x * percents + defaultPosX * uiScale
    fromPos.y = fromPos.y * percents + defaultPosY * uiScale
    toPos.x = toPos.x * percents + defaultPosX * uiScale
    toPos.y = toPos.y * percents + defaultPosY * uiScale
    zodiacInfo.lineKeyList[index] = insertLine(zodiacInfo.category, fromPos, toPos, zodiacInfo.color, zodiacInfo.width * uiScale, zodiacInfo.zOrder)
    local lineData = getLine(zodiacInfo.category, zodiacInfo.lineKeyList[index], zodiacInfo.zOrder)
    lineData._isScreenDemension = true
    lineData._isGlowLine = true
    lineData._colorGlow = zodiacInfo.colorBG
    lineData._lineWidthGlow = zodiacInfo.widthBG
    lineData:setLinePointRadius(0, 12)
    lineData:setLinePointRadius(2, 12)
    lineData:setLinePointColor(0, zodiacInfo.colorFG)
    lineData:setLinePointColor(2, zodiacInfo.colorFG)
  end
end
local function removeMainControls()
  for key, value in pairs(ui.mainGroup) do
    value._gaugeBG:SetShow(false)
  end
end
local function removeCurrentControls()
  for key, value in pairs(ui.currentGroup) do
    value._gaugeBG:SetShow(false)
  end
end
local function removeCardControls()
  for key, value in pairs(ui.cardGroup) do
    value._cardIcon:SetShow(false)
  end
end
local function removeTopListControls()
  for key, value in pairs(ui.topList) do
    value._category:SetShow(false)
    value._nextArrow:SetShow(false)
  end
end
local removeCircle = function(inputData)
  if -1 ~= inputData.circleKey then
    deleteLine(inputData.lineCategory, inputData.circleKey, inputData.coreInteractionLineOrder)
    inputData.circleKey = -1
  end
  isChanged = false
end
local function clearZodiacLine()
  for key, value in pairs(zodiacInfo.lineKeyList) do
    deleteLine(zodiacInfo.category, value, zodiacInfo.zOrder)
  end
  zodiacInfo.lineKeyList = {}
end
local function settingUIMainGroup(isFullUpdate)
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local childCount = knowledge:getMainKnowledgeCount()
  local visibleChildCount = childCount
  for index, value in pairs(ui.mainGroup) do
    local mentalCardKeyRaw = knowledge:getMainKnowledgeKeyByIndex(index)
    if nil == circularColorValue[mentalCardKeyRaw] then
      visibleChildCount = visibleChildCount - 1
      if visibleChildCount <= 0 then
        return
      end
    end
  end
  local discountIndex = 0
  for index = 0, childCount - 1 do
    local value = ui.mainGroup[index]
    if nil ~= value then
      local mentalCardKeyRaw = knowledge:getMainKnowledgeKeyByIndex(index)
      local mentalObject = knowledge:getThemeByKeyRaw(mentalCardKeyRaw)
      if nil ~= circularColorValue[mentalCardKeyRaw] then
        if isFullUpdate then
          value._gauge:SetColor(circularColorValue[mentalCardKeyRaw])
          value._gauge:SetProgressRate(mentalObject:getCardCollectPercents())
          value._name:SetText(mentalObject:getName())
        end
        local pos2d = knowledge:getElementaPos2dByPlayerPos(rotateValue + index - discountIndex, visibleChildCount, radiusValue)
        value._gaugeBG:SetDepth(-pos2d.z)
        local zOrder = math.min(math.max(pos2d.z, 0), 1)
        value._gaugeBG:SetScale(zOrder, zOrder)
        value._icon:SetScale(zOrder, zOrder)
        value._gauge:SetScale(zOrder, zOrder)
        value._name:SetScale(zOrder, zOrder)
        value._gaugeBG:SetPosX(pos2d.x - value._gaugeBG:GetSizeX() / 2)
        value._gaugeBG:SetPosY(pos2d.y - value._gaugeBG:GetSizeY() / 2)
      else
        discountIndex = discountIndex + 1
        value._gaugeBG:SetShow(false)
      end
    end
  end
end
local function settingUICurrentGroup(isFullUpdate)
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local childCount = knowledge:getCurrentThemeChildThemeCount()
  for index, value in pairs(ui.currentGroup) do
    if value._gaugeBG:GetShow() then
      if isFullUpdate then
        local mentalCardKeyRaw = knowledge:getCurrentThemeChildThemeKeyByIndex(index)
        local mentalObject = knowledge:getThemeByKeyRaw(mentalCardKeyRaw)
        value._gauge:SetProgressRate(mentalObject:getCardCollectPercents())
        value._name:SetText(mentalObject:getName())
      end
      local pos2d = knowledge:getElementaPos2dByPlayerPos(rotateValue + index, childCount, radiusValue)
      value._gaugeBG:SetDepth(-pos2d.z)
      local zOrder = math.min(math.max(pos2d.z, 0), 1)
      value._gaugeBG:SetScale(zOrder, zOrder)
      value._gauge:SetColor(Defines.Color.C_FF00C2EA)
      value._gauge:SetScale(zOrder, zOrder)
      value._icon:SetScale(zOrder, zOrder)
      value._normal:SetScale(zOrder, zOrder)
      value._name:SetScale(zOrder, zOrder)
      value._normal:SetShow(false)
      value._gaugeBG:SetPosX(pos2d.x - value._gaugeBG:GetSizeX() / 2)
      value._gaugeBG:SetPosY(pos2d.y - value._gaugeBG:GetSizeY() / 2)
    end
  end
end
local function settingUIMainCard(isFullupdate)
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local currentTheme = knowledge:getCurrentTheme()
  local childCardCount = currentTheme:getChildCardCount()
  for index = 0, childCardCount - 1 do
    local card = currentTheme:getChildCardByIndex(index)
    local pos2d = knowledge:getElementaPos2dByPlayerPos(rotateValue + index, childCardCount, radiusValue)
    if isFullupdate then
      ui.cardGroup[index]._cardIcon:SetText(card:getName())
      ui.cardGroup[index]._cardIcon:ChangeTextureInfoName(card:getPicture())
    end
    ui.cardGroup[index]._cardIcon:SetDepth(-pos2d.z)
    local zOrder = math.min(math.max(pos2d.z, 0), 1)
    ui.cardGroup[index]._cardIcon:SetScale(zOrder, zOrder)
    ui.cardGroup[index]._cardIcon:SetPosX(pos2d.x - ui.cardGroup[index]._cardIcon:GetSizeX() / 2)
    ui.cardGroup[index]._cardIcon:SetPosY(pos2d.y - ui.cardGroup[index]._cardIcon:GetSizeY() / 2)
    ui.cardGroup[index]._cardIcon:SetDepth(9999)
  end
  uiConst.main:SetDepthSort()
  uiConst.main_Hint:SetDepth(0)
end
local settingToFirstButton = function()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local pos2d = knowledge:getPlayerPos2d(float3(0, -100, 0))
  pos2d.x = 350
  uiConst.main_Top:SetPosX(pos2d.x - uiConst.main_Top:GetSizeX() / 2)
  uiConst.main_Top:SetPosY(pos2d.y - uiConst.main_Top:GetSizeY() / 2 + 180)
  uiConst.main_WhosKnowledge:SetPosX(pos2d.x - uiConst.main_WhosKnowledge:GetSizeX() / 2)
  uiConst.main_WhosKnowledge:SetPosY(uiConst.main_Top:GetPosY() - uiConst.main_WhosKnowledge:GetSizeY())
  uiConst.main_WhosKnowledge:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "Lua_Knowledge_OfKnowledge", "name", getSelfPlayer():getName()))
end
local function settingUIListIcon(progressCount)
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  for _, value in pairs(uiListControlByKey) do
    value:SetShow(false)
  end
  local posX = constValue.listIconLeft
  for index = 0, progressCount - 1 do
    local mentalCardKeyRaw = knowledge:getMainKnowledgeKeyByIndex(index)
    local mentalObject = knowledge:getThemeByKeyRaw(mentalCardKeyRaw)
    local targetUIList = uiListControlByKey[mentalCardKeyRaw]
    if nil ~= targetUIList then
      targetUIList:SetShow(true)
      targetUIList:SetPosX(posX)
      posX = posX + targetUIList:GetSizeX()
    end
  end
end
local function settingUIListTree()
  uiConst.list_Tree:ClearTree()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local mainTopTheme = knowledge:getMainTheme()
  local childThemeCount = mainTopTheme:getChildThemeCount()
  for index = 0, childThemeCount - 1 do
    local theme = mainTopTheme:getChildThemeByIndex(index)
    local mentalCardKeyRaw = theme:getKey()
    if nil ~= circularColorValue[mentalCardKeyRaw] then
      Panel_Knowledge_AddItemTree(nil, theme)
    end
  end
  uiConst.list_Tree:RestoreOpenListFromTempList()
end
local function settingListTopLine()
  local nameList = Array.new()
  local treeItem = uiConst.list_Tree:GetSelectItem()
  while nil ~= treeItem do
    nameList:push_back(treeItem:GetText())
    treeItem = treeItem:getParent()
  end
  local count = #nameList
  removeTopListControls()
  local leftValue = 20
  local drawCount = count
  if count > 2 then
    drawCount = 2
  end
  createTopListControls(drawCount)
  local index = 0
  local endIndex = count - 1
  if endIndex < 1 then
    endIndex = 1
  end
  for rindex = count, endIndex, -1 do
    ui.topList[index]._category:SetText(nameList[rindex])
    ui.topList[index]._category:SetPosX(leftValue)
    ui.topList[index]._category:SetSize(ui.topList[index]._category:GetTextSizeX(), ui.topList[index]._category:GetSizeY())
    leftValue = leftValue + ui.topList[index]._category:GetSizeX()
    ui.topList[index]._nextArrow:SetPosX(leftValue)
    leftValue = leftValue + ui.topList[index]._nextArrow:GetSizeX()
    index = index + 1
  end
end
local function settingCardInfo()
  uiConst.info:SetShow(false)
  uiConst.list_HintBG:SetShow(false)
  clearZodiacLine()
  local selectItem = uiConst.list_Tree:GetSelectItem()
  if nil == selectItem then
    return
  end
  local mentalObjectKey = selectItem:GetKey()
  if mentalObjectKey <= 0 then
    return
  end
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local card = knowledge:getCardByKeyRaw(mentalObjectKey)
  if false == card:hasCard() then
    uiConst.info_Picture:ChangeTextureInfoName(card:getPicture())
    uiConst.info_Name:SetText(card:getName())
    uiConst.info_Zodiac:SetShow(false)
    uiConst.info_zodiacName:SetShow(false)
    uiConst.info_NpcInt:SetShow(false)
    uiConst.info_NpcValue:SetShow(false)
    uiConst.info_NpcInterest:SetShow(false)
    uiConst.info_npcInfoBG:SetShow(false)
    uiConst.info_Story:SetShow(false)
    uiConst.info_CardEffect:SetShow(false)
    uiConst.info_Interest:SetShow(false)
    uiConst.info_Value:SetShow(false)
    uiConst.info_InfoBg:SetShow(false)
    uiConst.info:SetShow(true)
    if true == _ContentsGroup_ChaseMonster then
      local isFind = false
      local childCard = knowledge:getCardByKeyRaw(lastSelectCardKey)
      if nil ~= childCard then
        local theme = childCard:getParents()
        if nil ~= theme then
          local childCardCount = theme:getChildCardCount()
          for idx = 0, childCardCount - 1 do
            local childCard = theme:getChildCardByIndex(idx)
            if nil ~= childCard and lastSelectCardKey == childCard:getKey() then
              Panel_Knowledge_ShowHint_LClick(idx)
              isFind = true
              break
            end
          end
        end
      end
      if false == isFind then
        Panel_Knowledge_ShowHint_LClick()
      end
      PaGlobal_Knowledge_UpdateChaseTooltipPos()
    else
      Panel_Knowledge_ShowHint_LClick()
    end
    return
  else
    uiConst.info_Story:SetShow(true)
    uiConst.info_CardEffect:SetShow(true)
    uiConst.info_Interest:SetShow(true)
    uiConst.info_Value:SetShow(true)
    uiConst.info_InfoBg:SetShow(true)
    uiConst.info:SetShow(true)
  end
  local npcpersonalityStaticWrapper = card:getNpcPersonalityStaticStatus()
  if nil == npcpersonalityStaticWrapper then
    uiConst.info_Zodiac:SetShow(false)
    uiConst.info_zodiacName:SetShow(false)
    uiConst.info_NpcInt:SetShow(false)
    uiConst.info_NpcValue:SetShow(false)
    uiConst.info_NpcInterest:SetShow(false)
    uiConst.info_npcInfoBG:SetShow(false)
  else
    uiConst.info_Zodiac:SetShow(true)
    uiConst.info_zodiacName:SetShow(true)
    uiConst.info_zodiacName:SetText(npcpersonalityStaticWrapper:getZodiacName())
    local favoritedList = ""
    local isFirst = true
    local count = npcpersonalityStaticWrapper:getFavoritedThemeCount()
    for index = 0, count - 1 do
      local favoritedName = npcpersonalityStaticWrapper:getFavoritedThemeNameByIndex(index)
      if isFirst then
        favoritedList = PAGetStringParam1(Defines.StringSheet_GAME, "Lua_Knowledge_FavoritedList", "favoritedName", favoritedName)
        isFirst = false
      else
        favoritedList = favoritedList .. "," .. favoritedName
      end
    end
    uiConst.info_NpcInterest:SetTextMode(__eTextMode_AutoWrap)
    uiConst.info_NpcInterest:SetText(favoritedList)
    uiConst.info_npcInfoBG:SetSize(350, uiConst.info_NpcInterest:GetTextSizeY() + 35)
    local npcPersonalityStatic = npcpersonalityStaticWrapper:get()
    uiConst.info_NpcInt:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_DEMANDINGINTERESTING") .. " : " .. npcPersonalityStatic._minDv .. "~" .. npcPersonalityStatic._maxDv)
    uiConst.info_NpcValue:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_DEMANDINGFAVOR") .. " : " .. npcPersonalityStatic._minPv .. "~" .. npcPersonalityStatic._maxPv)
    uiConst.info_NpcInt:SetShow(true)
    uiConst.info_NpcValue:SetShow(true)
    uiConst.info_NpcInterest:SetShow(true)
    uiConst.info_npcInfoBG:SetShow(true)
    uiConst.info_NpcInt:ComputePos()
    uiConst.info_NpcValue:ComputePos()
    clearZodiacLine()
    insertCircleLineAndObject(npcpersonalityStaticWrapper:getZodiacOrderStaticStatusWrapper():getZodiacSignStaticStatusWrapper())
  end
  uiConst.info_Picture:ChangeTextureInfoName(card:getPicture())
  uiConst.info_Name:SetText(card:getName())
  if uiConst.info_Name:GetSizeX() < uiConst.info_Name:GetTextSizeX() + 10 then
    uiConst.info_Name:SetSize(uiConst.info_Name:GetTextSizeX() + 20, uiConst.info_Name:GetSizeY())
    local storycenter = uiConst.info_Story:GetPosX() + uiConst.info_Story:GetSizeX() * 0.5
    uiConst.info_Name:SetPosX(storycenter - uiConst.info_Name:GetSizeX() * 0.5)
  end
  uiConst.info_Story:SetText(card:getDescription())
  uiConst.info_Story:setLocalizedStaticType(34)
  uiConst.info_Story:setLocalizedKey(card:getDescriptionLocalizedKey())
  uiConst.info_Story:SetIgnore(false)
  local buffText = PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFF_EMPTY")
  if card:isBuff() then
    if card:getApplyTurn() == 0 then
      if card:getBuffType() < 2 then
        buffText = PAGetStringParam3(Defines.StringSheet_GAME, "MENTALGAME_BUFF_MESSAGE_1_UP", "buff", constValue.buffTypeString[card:getBuffType()], "turn", tostring(card:getValidTurn()), "value", tostring(card:getVariedValue()))
      else
        buffText = PAGetStringParam3(Defines.StringSheet_GAME, "MENTALGAME_BUFF_MESSAGE_1_DOWN", "buff", constValue.buffTypeString[card:getBuffType()], "turn", tostring(card:getValidTurn()), "value", tostring(card:getVariedValue()))
      end
    elseif card:getBuffType() < 2 then
      buffText = PAGetStringParam4(Defines.StringSheet_GAME, "MENTALGAME_BUFF_MESSAGE_ANY_UP", "count", tostring(card:getApplyTurn() + 1), "buff", constValue.buffTypeString[card:getBuffType()], "turn", tostring(card:getValidTurn()), "value", tostring(card:getVariedValue()))
    else
      buffText = PAGetStringParam4(Defines.StringSheet_GAME, "MENTALGAME_BUFF_MESSAGE_ANY_DOWN", "count", tostring(card:getApplyTurn() + 1), "buff", constValue.buffTypeString[card:getBuffType()], "turn", tostring(card:getValidTurn()), "value", tostring(card:getVariedValue()))
    end
  end
  uiConst.info_CardEffect:SetText(buffText)
  uiConst.info_Interest:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_INTERESTING") .. " : " .. card:getHit())
  uiConst.info_Value:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_FAVOR") .. " : " .. card:getMinDd() .. "~" .. card:getMaxDd())
  local ySize = 0
  local sizeYInfo_Picture = 360
  local sizeYInfo_Story = uiConst.info_Story:GetSizeY()
  local sizeYInfo_InfoBg = uiConst.info_InfoBg:GetSizeY()
  local sizeYList_Panel = uiConst.list:GetSizeY()
  if getScreenSizeY() < sizeYInfo_Picture + sizeYInfo_Story + sizeYInfo_InfoBg + sizeYList_Panel then
    local pictureSize = getScreenSizeY() - (sizeYInfo_Story + sizeYInfo_InfoBg + sizeYList_Panel)
    uiConst.info_Picture:SetSize(pictureSize, pictureSize)
    uiConst.info_Picture:SetPosX(uiConst.info_Name:GetPosX() + uiConst.info_Name:GetSizeX() / 2 - uiConst.info_Picture:GetSizeX() / 2)
    uiConst.info_Story:SetPosY(uiConst.info_Picture:GetPosY() + uiConst.info_Picture:GetSizeY() * 0.9)
    uiConst.info_Zodiac:SetPosY(uiConst.info_Picture:GetPosY() + uiConst.info_Picture:GetSizeY() * 2 / 3 - uiConst.info_Zodiac:GetSizeY() / 2)
    uiConst.info_zodiacName:SetPosY(uiConst.info_Zodiac:GetPosY() + uiConst.info_Zodiac:GetSizeY() * 3 / 4 - uiConst.info_zodiacName:GetSizeY())
    uiConst.info_InfoBg:ComputePos()
  else
    uiConst.info_Picture:SetSize(360, 360)
    uiConst.info_Picture:ComputePos()
    uiConst.info_Story:ComputePos()
  end
  Panel_Knowledge_Info:SetSize(Panel_Knowledge_Info:GetSizeX(), getScreenSizeY() - Panel_Knowledge_List:GetSizeY() - 10)
  Panel_Knowledge_Info:ComputePos()
  uiConst.info_InfoBg:ComputePos()
  audioPostEvent_SystemUi(5, 0)
  uiConst.info:SetShow(true)
  PaGlobal_Knowledge_UpdateChaseTooltipPos()
end
local settingTheme = function()
  local selectItem = uiConst.list_Tree:GetSelectItem()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  if nil == selectItem then
    knowledge:setCurrentTheme(knowledge:getMainTheme())
    return
  end
  local mentalObjectKey = selectItem:GetKey()
  if 0 == mentalObjectKey then
    return
  end
  if mentalObjectKey < 0 then
    local theme = knowledge:getThemeByKeyRaw(-mentalObjectKey)
    if nil == theme then
      return
    end
    knowledge:setCurrentTheme(theme)
  else
    local card = knowledge:getCardByKeyRaw(mentalObjectKey)
    knowledge:setCurrentThemeByCard(card)
  end
end
local function settingForNextTheme()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  radiusResultValue = 0
  rotateValue = 0
  rotateResultValue = knowledge:getCurrentThemeChildThemeCount()
  if 0 == rotateResultValue then
    rotateResultValue = knowledge:getCurrentThemeChildCardCount()
  end
end
local inputData = {
  lineCategory = "InstantLine_HumanRelation",
  lineAlpha = 1,
  circleLineRadius = 150,
  isChanged = false,
  circleKey = -1,
  intimacyKey = -1,
  coreInteractionLineOrder = 10,
  constAlphaAura = 0.2,
  constAlphaCore = 0.7,
  position = float3(0, 0, 0)
}
local function settingCircleInputData()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local targetPos = knowledge:getCameraTargetPos()
  targetPos.y = targetPos.y + 30
  local isChangedPos = inputData.position ~= targetPos
  inputData.position = targetPos
  inputData.circleLineRadius = radiusValue
  return isChangedPos
end
local UIMode = Defines.UIMode
local function onShowLoadControls()
  ToClient_SaveUiInfo(false)
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local mainKnowledgeCount = knowledge:getMainKnowledgeCount()
  rotateResultValue = 0
  rotateValue = 0
  radiusValue = 0
  radiusResultValue = 100
  SetUIMode(UIMode.eUIMode_Mental)
  renderMode:set()
  uiConst.main:SetShow(true)
  uiConst.main:SetIgnore(false)
  createMainControls(mainKnowledgeCount)
  settingUIMainGroup(true)
  settingUIListTree()
  uiConst.list:SetShow(true)
  settingUIListIcon(mainKnowledgeCount)
  settingCardInfo()
  PaGlobal_Knowledge_Point.point_Tooltip:SetShow(false)
end
local function onHideCloseControls()
  SetUIMode(UIMode.eUIMode_Default)
  renderMode:reset()
  uiConst.main:SetShow(false)
  removeMainControls()
  removeCurrentControls()
  removeCardControls()
  uiConst.list:SetShow(false)
  uiConst.list_Edit:SetEditText("")
  uiConst.list_Tree:SetFilterString("")
  uiConst.info:SetShow(false)
  removeCircle(inputData)
  clearZodiacLine()
  uiConst.list_Tree:SaveOpenListAtItemlist()
  if Panel_Knowledge_CheckCurrentUiEdit(GetFocusEdit()) then
    Panel_Knowledge_OutInputMode()
  end
end
local function updateMainUI()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  removeMainControls()
  removeCurrentControls()
  removeCardControls()
  if knowledge:getCurrentTheme():getKey() == knowledge:getMainTheme():getKey() then
    createMainControls(knowledge:getMainKnowledgeCount())
    settingUIMainGroup(true)
  else
    local theme = knowledge:getCurrentTheme()
    createCurrentControls(theme:getChildThemeCount())
    createCardControls(theme:getChildCardCount())
    settingUICurrentGroup(true)
    settingUIMainCard(true)
  end
  settingListTopLine()
  settingCardInfo()
end
local _cardKeyRaw
function Panel_Knowledge_Show()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == ToClient_getJoinGuildBattle() then
    return
  end
  local key = ToClient_GetEnterToInstanceFieldKey()
  if true == key:isDefined() and __eInstanceContentsType_PersonalField ~= key:getType() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGEOPENALERT_IN_INSTANCEFIELD"))
    return
  end
  if isDeadInWatchingMode() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGEOPENALERT_INDEAD"))
    return
  end
  if selfPlayerIsInCompetitionArea() then
    return
  end
  if true == ToClient_SniperGame_IsPlaying() then
    return
  end
  PaGlobalFunc_FullScreenFade_RunAfterFadeIn(Panel_Knowledge_ShowActual)
end
function Panel_Knowledge_ShowActual()
  PaGlobalFunc_FullScreenFade_FadeOut()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  if knowledge:isShow() or GetUIMode() ~= Defines.UIMode.eUIMode_Default then
    return
  end
  local isShowable = knowledge:show()
  if false == isShowable then
    return
  end
  TooltipSimple_Hide()
  audioPostEvent_SystemUi(1, 32)
  PaGlobal_Knowledge_UpdateChaseData()
  if MessageBoxGetShow() then
    allClearMessageData()
  end
  PaGlobal_Knowledge_OtherPanels_Close()
  UIMain_KnowledgeUpdateRemove()
  PaGlobal_Knowledge_Point_Show()
  uiConst.list_GetKnowledgeCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_KNOWLEDGE_MAIN_GETKNOWLEDGECOUNT", "count", ToClient_GetTotalMentalCardCount()))
  onShowLoadControls()
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    if _cardKeyRaw ~= FGlobal_CardKeyReturn() then
      _cardKeyRaw = FGlobal_CardKeyReturn()
      Panel_Knowledge_SelectAnotherCard(_cardKeyRaw)
    end
  else
    if nil ~= lastSelectCardKey then
      Panel_Knowledge_SelectAnotherCard(lastSelectCardKey)
    end
    if _cardKeyRaw ~= PaGlobalFunc_Widget_Alert_NewKnowledge_CardKeyReturn() then
      _cardKeyRaw = PaGlobalFunc_Widget_Alert_NewKnowledge_CardKeyReturn()
      Panel_Knowledge_SelectAnotherCard(_cardKeyRaw)
    end
  end
  Panel_KnowledgeBuff_Update()
end
function Panel_KnowledgeBuff_Update()
  local knowledgePoint = ToClient_getKnowledgePoint()
  local battleBuffPercent = ToClient_getBattleExperienceByKnowledgePoint()
  local dropItemBuffPercent = ToClient_getEfficiencyOfDropItemByKnowledgePoint()
  battleBuffPercent = battleBuffPercent / 10000
  dropItemBuffPercent = dropItemBuffPercent / 10000
  local str1 = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_KNOWLEDGE_POINT_TEXT", "point", tostring(knowledgePoint))
  local str2 = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_KNOWLEDGE_BUFF_TEXT", "battlePercent", tostring(battleBuffPercent), "dropPercent", tostring(dropItemBuffPercent))
  uiConst.staticText_KnowledgeBuff:SetShow(false)
  uiConst.staticText_KnowledgeBuff:SetText(str1 .. "\n" .. str2)
end
function Panel_Knowledge_Hide()
  if true == Panel_TranslationReport:GetShow() then
    TranslationReport_Close()
    return
  end
  PaGlobalFunc_FullScreenFade_RunAfterFadeIn(Panel_Knowledge_HideActual)
end
function Panel_Knowledge_HideActual()
  PaGlobalFunc_FullScreenFade_FadeOut()
  audioPostEvent_SystemUi(1, 33)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local knowledge = selfPlayer:get():getMentalKnowledge()
  if false == knowledge:isShow() then
    return
  end
  knowledge:hide()
  onHideCloseControls()
  PackageIconPosition()
end
function Panel_Knowledge_ShowHint(index)
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local mentalCardKeyRaw = knowledge:getCurrentThemeChildCardKeyByIndex(index)
  local card = knowledge:getCardByKeyRaw(mentalCardKeyRaw)
  local cardIcon = ui.cardGroup[index]._cardIcon
  if false == card:hasCard() then
    if 0 == string.len(card:getKeyword()) then
      uiConst.main_Hint:SetShow(false)
    else
      uiConst.main_Hint:SetAutoResize(true)
      uiConst.main_Hint:SetTextMode(__eTextMode_AutoWrap)
      uiConst.main_Hint:SetText(card:getKeyword())
      uiConst.main_Hint:SetSize(uiConst.main_Hint:GetSizeX(), uiConst.main_Hint:GetSizeY() + 25)
      uiConst.main_Hint:SetPosX(cardIcon:GetPosX() - (uiConst.main_Hint:GetSizeX() - cardIcon:GetSizeX()) / 2)
      uiConst.main_Hint:SetPosY(cardIcon:GetPosY() - 40)
      uiConst.main_Hint:SetShow(true)
    end
  end
end
function Panel_Knowledge_HideHint()
  uiConst.main_Hint:SetShow(false)
  uiConst.list_Hint:SetShow(false)
end
function Panel_Knowledge_ShowHint_byList()
  local isUiMode = CppEnums.EProcessorInputMode.eProcessorInputMode_UiModeNotInput == getInputMode()
  local index = uiConst.list_Tree:GetOverItemKey()
  if index < 0 or false == isUiMode then
    uiConst.list_Hint:SetShow(false)
    return
  end
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local card = knowledge:getCardByKeyRaw(index)
  if nil ~= card then
    if false == card:hasCard() then
      if 0 == string.len(card:getKeyword()) then
        uiConst.list_Hint:SetShow(false)
      else
        uiConst.list_Hint:SetAutoResize(true)
        uiConst.list_Hint:SetTextMode(__eTextMode_AutoWrap)
        uiConst.list_Hint:SetText(card:getKeyword())
        local hintTextSize = uiConst.list_Hint:GetTextSizeX()
        if hintTextSize > Panel_Knowledge_Point:GetSizeX() then
          hintTextSize = Panel_Knowledge_Point:GetSizeX()
        else
          hintTextSize = hintTextSize + 10
        end
        uiConst.list_Hint:SetSize(uiConst.list_Hint:GetSizeX(), uiConst.list_Hint:GetSizeY() + 25)
        uiConst.list_Hint:SetPosX(uiConst.list_Tree:GetPosX() - uiConst.list_Hint:GetSizeX() - 5)
        uiConst.list_Hint:SetPosY(uiConst.list_Tree:GetPosY() + uiConst.list_Hint:GetSizeY() / 2)
        uiConst.list_Hint:SetShow(true)
      end
    else
      uiConst.list_Hint:SetShow(false)
    end
  end
end
function Panel_Knowledge_ShowHint_LClick(index)
  if nil == getSelfPlayer() then
    return
  end
  local isUiMode = CppEnums.EProcessorInputMode.eProcessorInputMode_UiModeNotInput == getInputMode()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  if nil == index then
    index = uiConst.list_Tree:GetOverItemKey()
  else
    local indexFind = false
    local theme = knowledge:getCurrentTheme()
    if nil ~= theme then
      local childCard = theme:getChildCardByIndex(index)
      if nil ~= childCard then
        index = childCard:getKey()
        indexFind = true
      end
    end
    if false == indexFind then
      index = uiConst.list_Tree:GetOverItemKey()
    end
  end
  if index < 0 or false == isUiMode then
    uiConst.list_HintBG:SetShow(false)
    return
  end
  local card = knowledge:getCardByKeyRaw(index)
  if nil ~= card then
    if false == card:hasCard() then
      if 0 == string.len(card:getKeyword()) then
        uiConst.list_HintBG:SetShow(false)
      else
        uiConst.list_HintTop:SetTextMode(__eTextMode_AutoWrap)
        uiConst.list_HintTop:SetText(card:getKeyword())
        local hintTextSizeX = uiConst.list_HintTop:GetTextSizeX()
        local hintTextSizeY = uiConst.list_HintTop:GetTextSizeY()
        uiConst.list_HintBG:SetSize(uiConst.list_HintBG:GetSizeX(), hintTextSizeY + 25)
        uiConst.list_HintBG:SetPosY(ui_Copy._category:GetPosY() - uiConst.list_HintBG:GetSizeY() - 10)
        uiConst.list_HintBG:SetShow(true)
      end
    else
      uiConst.list_HintBG:SetShow(false)
    end
  end
end
uiConst.main:addInputEvent("Mouse_DownScroll", "Panel_Knowledge_RotateValueUpdate(true)")
uiConst.main:addInputEvent("Mouse_UpScroll", "Panel_Knowledge_RotateValueUpdate(false)")
uiConst.main:RegisterUpdateFunc("Panel_Knowledge_UpdatePerFrame")
uiConst.list_Tree:addInputEvent("Mouse_LUp", "Panel_Knowledge_SelectElement()")
uiConst.list_Tree:addInputEvent("Mouse_On", "Panel_Knowledge_ShowHint_byList()")
uiConst.list_Tree:addInputEvent("Mouse_Out", "Panel_Knowledge_HideHint()")
uiConst.list:RegisterUpdateFunc("Panel_Knowledge_OverBarUpdatePerFrame")
uiConst.main_Top:addInputEvent("Mouse_LUp", "Panel_Knowledge_GotoParents()")
uiConst.list_Edit:addInputEvent("Mouse_LDown", "Panel_Knowledge_OnInputMode()")
uiConst.list_Edit:addInputEvent("Mouse_LUp", "Panel_Knowledge_OnInputMode()")
uiConst.list_FindList:addInputEvent("Mouse_LUp", "Panel_Knowledge_OutInputMode(true)")
uiConst.list_Edit:RegistReturnKeyEvent("Panel_Knowledge_OutInputMode( true )")
function Panel_Knowledge_OverBarUpdatePerFrame(deltaTime)
  Panel_Knowledge_ShowHint_byList()
end
function Panel_Knowledge_OnLPressStart()
  inputModeManageMove(true)
end
function Panel_Knowledge_OnLPressEnd()
  inputModeManageMove(false)
end
function Panel_Knowledge_OnRPressStart()
  inputModeManageRotate(true)
end
function Panel_Knowledge_OnRPressEnd()
  inputModeManageRotate(false)
end
function Panel_Knowledge_SelectElement()
  local selectItem = uiConst.list_Tree:GetSelectItem()
  if nil == selectItem then
    return
  end
  local mentalObjectKey = selectItem:GetKey()
  if 0 == mentalObjectKey then
    return
  end
  local selfPlayerWrrapper = getSelfPlayer()
  if nil == selfPlayerWrrapper then
    return
  end
  local selfPlayer = selfPlayerWrrapper:get()
  if nil == selfPlayer then
    return
  end
  uiConst._btn_ChaseStart:SetShow(false)
  uiConst._btn_ChaseStop:SetShow(false)
  local knowledge = selfPlayer:getMentalKnowledge()
  if mentalObjectKey < 0 then
    local theme = knowledge:getThemeByKeyRaw(-mentalObjectKey)
    if nil == theme then
      return
    end
    settingForNextTheme()
    if true == _ContentsGroup_ChaseMonster then
      lastSelectCardKey = mentalObjectKey
      local themeKey = theme:getKey()
      chaseData.isEcology = themeKey >= chaseData.ecologyMinThemaKey and themeKey <= chaseData.ecologyMaxThemaKey
      if true == chaseData.isEcology then
        if chaseData.chaseSelectKey == mentalObjectKey then
          uiConst._btn_ChaseStop:SetShow(true)
        else
          local childCardCount = theme:getChildCardCount()
          for idx = 0, childCardCount - 1 do
            local childCard = theme:getChildCardByIndex(idx)
            if nil ~= childCard then
              local characterKey = ToClient_getCharacterKeyByMentalCardKey(childCard:getKey())
              if 0 ~= characterKey and true == ToClient_isPossibleChase(characterKey) then
                uiConst._btn_ChaseStart:SetShow(true)
                local chaseStartText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TARGET_MONSTER_CHASE_START")
                uiConst._btn_ChaseStart:SetText(chaseStartText)
                break
              end
            end
          end
        end
      end
    end
  else
    local currentTheme = knowledge:getCurrentTheme()
    if nil == currentTheme then
      return
    end
    local card = knowledge:getCardByKeyRaw(mentalObjectKey)
    if nil == card then
      return
    end
    local currentThemeKey = currentTheme:getKey()
    local parentsTheme = card:getParents()
    if nil == parentsTheme then
      return
    end
    local themeKey = parentsTheme:getKey()
    if currentThemeKey == themeKey then
      updateMainUI()
      lastSelectCardKey = mentalObjectKey
    else
      settingForNextTheme()
    end
    if true == _ContentsGroup_ChaseMonster then
      lastSelectCardKey = mentalObjectKey
      chaseData.isEcology = themeKey >= chaseData.ecologyMinThemaKey and themeKey <= chaseData.ecologyMaxThemaKey
      if true == chaseData.isEcology then
        local chaseStartText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TARGET_MONSTER_CHASE_START")
        local cardKey = card:getKey()
        if chaseData.chaseSelectKey == cardKey then
          uiConst._btn_ChaseStop:SetShow(true)
        else
          local isParentsChase = false
          if nil ~= chaseData.chaseSelectKey and 0 > chaseData.chaseSelectKey and parentsTheme:getKey() == -chaseData.chaseSelectKey then
            isParentsChase = true
          end
          local characterKey = ToClient_getCharacterKeyByMentalCardKey(cardKey)
          if 0 == characterKey or false == ToClient_isPossibleChase(characterKey) then
            chaseStartText = "<PAColor0xffb82929>" .. chaseStartText .. "<PAOldColor>"
            uiConst._btn_ChaseStart:SetShow(true)
          elseif true == isParentsChase then
            uiConst._btn_ChaseStop:SetShow(true)
          else
            uiConst._btn_ChaseStart:SetShow(true)
          end
          local isFind = false
          local childCardCount = parentsTheme:getChildCardCount()
          for idx = 0, childCardCount - 1 do
            local childCard = parentsTheme:getChildCardByIndex(idx)
            if nil ~= childCard and lastSelectCardKey == childCard:getKey() then
              Panel_Knowledge_ShowHint_LClick(idx)
              isFind = true
              break
            end
          end
          if false == isFind then
            Panel_Knowledge_ShowHint_LClick()
          end
        end
        uiConst._btn_ChaseStart:SetText(chaseStartText)
      end
    end
  end
  PaGlobal_Knowledge_UpdateChaseTooltipPos()
end
function Panel_Knowledge_GotoRoot()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  knowledge:setCurrentTheme(knowledge:getMainTheme())
  uiConst.list_Tree:RefreshOpenList()
end
function Panel_Knowledge_GotoParents()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local theme = knowledge:getCurrentTheme()
  if nil == theme then
    return
  end
  local parentsTheme = theme:getParents()
  if nil == parentsTheme then
    return
  end
  if parentsTheme:getKey() == knowledge:getMainTheme():getKey() then
    uiConst.list_Tree:ResetSelectItem()
  else
    uiConst.list_Tree:SetSelectItemByKey(-parentsTheme:getKey())
  end
  settingForNextTheme()
end
function Panel_Knowledge_SelectMainUI(index)
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local theme = knowledge:getCurrentTheme()
  local childTheme = theme:getChildThemeByIndex(index)
  if nil == childTheme then
    return
  end
  uiConst.list_Tree:SetSelectItemByKey(-childTheme:getKey())
  settingForNextTheme()
end
function Panel_Knowledge_SelectMainUICard(index)
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local theme = knowledge:getCurrentTheme()
  local childCard = theme:getChildCardByIndex(index)
  uiConst.list_Tree:SetSelectItemByKey(childCard:getKey())
  updateMainUI()
  ui.cardGroup[index]._cardIcon:EraseAllEffect()
  ui.cardGroup[index]._cardIcon:AddEffect("fUI_SkillButton01", false, 0, 0)
  ui.cardGroup[index]._cardIcon:AddEffect("UI_Knowledge_Select01", false, 0, 0)
  Panel_Knowledge_ShowHint_LClick(index)
end
function Panel_Knowledge_SelectMainUIByKey(themeKeyRaw)
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local theme = knowledge:getThemeByKeyRaw(themeKeyRaw)
  if nil == theme then
    return
  end
  uiConst.list_Tree:SetSelectItemByKey(-theme:getKey())
  settingForNextTheme()
end
function Panel_Knowledge_SelectAnotherCard(cardKeyRaw)
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local childCard = knowledge:getCardByKeyRaw(cardKeyRaw)
  if nil == childCard then
    return
  end
  local theme = childCard:getParents()
  uiConst.list_Tree:SetSelectItemByKey(-theme:getKey())
  settingForNextTheme()
  uiConst.list_Tree:SetSelectItemByKey(childCard:getKey())
  updateMainUI()
end
function Panel_Knowledge_OnInputMode()
  SetFocusEdit(uiConst.list_Edit)
  uiConst.list_Edit:SetEditText("")
end
local filterText = ""
function Panel_Knowledge_OutInputMode(isApply)
  if true ~= isApply then
    uiConst.list_Edit:SetEditText("")
  end
  ClearFocusEdit()
  uiConst.list_Tree:SetFilterString(uiConst.list_Edit:GetEditText())
  uiConst.list_Tree:RefreshOpenList()
  if true == _ContentsGroup_ChaseMonster and true == isApply then
    if nil == chaseData.chaseSelectKey or chaseData.chaseSelectKey >= 0 then
      return
    end
    local selfPlayerWrrapper = getSelfPlayer()
    if nil == selfPlayerWrrapper then
      return
    end
    local selfPlayer = selfPlayerWrrapper:get()
    if nil == selfPlayer then
      return
    end
    local knowledge = selfPlayer:getMentalKnowledge()
    if nil == knowledge then
      return
    end
    local theme = knowledge:getThemeByKeyRaw(-chaseData.chaseSelectKey)
    if nil == theme then
      return
    end
    local themeKey = theme:getKey()
    if -chaseData.chaseSelectKey ~= themeKey then
      return
    end
    local childCardCount = theme:getChildCardCount()
    for idx = 0, childCardCount - 1 do
      local childCard = theme:getChildCardByIndex(idx)
      if nil ~= childCard then
        local cardKey = childCard:getKey()
        local characterKey = ToClient_getCharacterKeyByMentalCardKey(cardKey)
        local cardName = childCard:getName()
        if nil ~= cardName and 0 ~= characterKey and true == ToClient_isPossibleChase(characterKey) then
          uiConst.list_Tree:SetSelectItemByKey(cardKey)
          local selectItem = uiConst.list_Tree:GetSelectItem()
          if nil ~= selectItem and selectItem:GetKey() == cardKey then
            local strsplit = string.split(cardName, "]")
            if nil ~= strsplit[2] then
              local grade = strsplit[1]
              local monsterName = strsplit[2]
              cardName = grade .. "]<PAColor0xff84fff5>" .. monsterName .. "<PAOldColor>"
            else
              cardName = "<PAColor0xff84fff5>" .. cardName .. "<PAOldColor>"
            end
            selectItem:SetText(cardName)
          end
        end
      end
    end
  end
end
function Panel_Knowledge_CheckCurrentUiEdit(targetUI)
  return nil ~= targetUI and targetUI:GetKey() == uiConst.list_Edit:GetKey()
end
function Panel_Knowledge_RotateValueUpdate(isUp)
  if isUp then
    rotateResultValue = rotateResultValue + 1
  else
    rotateResultValue = rotateResultValue - 1
  end
end
function Panel_Knowledge_UpdatePerFrame(deltaTime)
  local diff = rotateResultValue - rotateValue
  if 0 ~= diff then
    if math.abs(diff) < 0.01 then
      rotateValue = rotateResultValue
    else
      local moveRate = deltaTime * 5
      if 0 ~= radiusDiff then
        moveRate = deltaTime * 10
      end
      moveRate = math.min(moveRate, 1)
      rotateValue = rotateValue + diff * moveRate
    end
  end
  local radiusDiff = radiusResultValue - radiusValue
  if 0 ~= radiusDiff then
    if math.abs(radiusDiff) < 0.01 then
      radiusValue = radiusResultValue
    else
      local absRaiusDiff = math.abs(radiusDiff)
      local moveRate = deltaTime * 600
      moveRate = math.min(moveRate, absRaiusDiff) * (absRaiusDiff / radiusDiff)
      radiusValue = radiusValue + moveRate
    end
  end
  if 0 == radiusValue then
    settingTheme()
    radiusResultValue = 100
    updateMainUI()
  end
  local isChanged = settingCircleInputData()
  if 0 ~= diff or 0 ~= radiusDiff or isChanged then
    settingUIMainCard(false)
    settingUIMainGroup(false)
    settingUICurrentGroup(false)
    settingToFirstButton()
  end
  createAndUpdateCircle(inputData)
end
function PaGlobal_Knowledge_Point:Init()
  local isKnowledgeGradeShow = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eKnowledgeGrade)
  if true == isKnowledgeGradeShow then
    PaGlobal_Knowledge_Point.point_OptionShow:SetCheck(true)
    PaGlobal_Knowledge_Point.point_OptionHide:SetCheck(false)
  else
    PaGlobal_Knowledge_Point.point_OptionShow:SetCheck(false)
    PaGlobal_Knowledge_Point.point_OptionHide:SetCheck(true)
  end
  PaGlobal_Knowledge_Point.point_OptionShow:SetEnableArea(0, 0, PaGlobal_Knowledge_Point.point_OptionShow:GetSizeX() + PaGlobal_Knowledge_Point.point_OptionShow:GetTextSizeX() + 10, 20)
  PaGlobal_Knowledge_Point.point_OptionHide:SetEnableArea(0, 0, PaGlobal_Knowledge_Point.point_OptionHide:GetSizeX() + PaGlobal_Knowledge_Point.point_OptionHide:GetTextSizeX() + 10, 20)
  self.point_Btn_Question:SetShow(true)
  self.point_Btn_Question:addInputEvent("Mouse_On", "PaGlobal_Knowledge_Point_Tooltip(true, 0)")
  self.point_Btn_Question:addInputEvent("Mouse_Out", "PaGlobal_Knowledge_Point_Tooltip(false)")
  self.point_OptionShow:addInputEvent("Mouse_LUp", "PaGlobal_KnowledgePoint_SetData(true)")
  self.point_OptionHide:addInputEvent("Mouse_LUp", "PaGlobal_KnowledgePoint_SetData(false)")
  self.point_OptionShow:addInputEvent("Mouse_On", "PaGlobal_Knowledge_PointTooltip(true, 0)")
  self.point_OptionShow:addInputEvent("Mouse_Out", "PaGlobal_Knowledge_PointTooltip(false)")
  self.point_OptionHide:addInputEvent("Mouse_On", "PaGlobal_Knowledge_PointTooltip(true, 1)")
  self.point_OptionHide:addInputEvent("Mouse_Out", "PaGlobal_Knowledge_PointTooltip(false)")
  self.point_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
  self.point_bottomDesc:SetText(self.point_bottomDesc:GetText())
end
function PaGlobal_KnowledgePoint_SetData(isShow)
  if nil == isShow then
    return
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eKnowledgeGrade, isShow, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_Knowledge_Point:Update()
  local knowledgePoint = ToClient_getKnowledgePoint()
  local battleBuffPercent = ToClient_getBattleExperienceByKnowledgePoint()
  local dropItemBuffPercent = ToClient_getEfficiencyOfDropItemByKnowledgePoint()
  battleBuffPercent = battleBuffPercent / 10000
  dropItemBuffPercent = dropItemBuffPercent / 10000
  local isBattleBuff = ""
  local isDropItemBuff = ""
  if battleBuffPercent > 0 then
    isBattleBuff = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_KNOWLEDGE_MAIN_BATTLEEXPBUFF", "battleBuff", tostring(battleBuffPercent))
  end
  if dropItemBuffPercent > 0 then
    isDropItemBuff = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_KNOWLEDGE_MAIN_ITEMDROPBUFF", "dropItemBuff", tostring(dropItemBuffPercent))
  end
  local txt_Comma = "\n"
  if 0 == dropItemBuffPercent then
    txt_Comma = ""
  end
  local isText = isBattleBuff .. txt_Comma .. isDropItemBuff
  local isGetKnowledge = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_KNOWLEDGE_MAIN_CURRENTPOINTBUFF", "knowledgePoint", tostring(knowledgePoint), "isText", tostring(isText))
  if knowledgePoint < 500 then
    isGetKnowledge = PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGE_MAIN_NONEBUFF")
  end
  self.point_Txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self.point_Txt_Desc:setPadding(UI_PD.ePadding_Left, 10)
  self.point_Txt_Desc:setPadding(UI_PD.ePadding_Top, 5)
  self.point_Txt_Desc:setPadding(UI_PD.ePadding_Right, 10)
  self.point_Txt_Desc:setPadding(UI_PD.ePadding_Bottom, 5)
  self.point_Txt_Desc:SetText(isGetKnowledge)
  self.point_bottomDesc:SetText(self.point_bottomDesc:GetText())
  self.point_HorizonLine:SetPosY(self.point_Txt_Desc:GetPosY() + self.point_Txt_Desc:GetTextSizeY() + 15)
  PaGlobal_Knowledge_Point:Position()
end
function PaGlobal_Knowledge_Point_Show()
  Panel_Knowledge_Point:SetShow(true)
  PaGlobal_Knowledge_Point:Update()
end
function PaGlobal_Knowledge_Point_Close()
  Panel_Knowledge_Point:SetShow(false)
end
function PaGlobal_Knowledge_PointTooltip(isShow, isType)
  if false == isShow then
    PaGlobal_Knowledge_Point.point_tooltipOptionShow:SetShow(false)
    PaGlobal_Knowledge_Point.point_tooltipOptionHide:SetShow(false)
    return
  end
  local name, desc, control
  PaGlobal_Knowledge_Point.point_tooltipOptionShow:ComputePos()
  PaGlobal_Knowledge_Point.point_tooltipOptionHide:ComputePos()
  if 0 == isType then
    PaGlobal_Knowledge_Point.point_tooltipOptionShow:SetShow(true)
  elseif 1 == isType then
    PaGlobal_Knowledge_Point.point_tooltipOptionHide:SetShow(true)
  end
end
function PaGlobal_Knowledge_Point:Position()
  local pointTextSizeY = self.point_Txt_Desc:GetTextSizeY()
  local botTextSizeY = self.point_bottomDesc:GetTextSizeY()
  self.point_Txt_Desc:SetSize(self.point_Txt_Desc:GetSizeX(), pointTextSizeY + 13)
  Panel_Knowledge_Point:SetSize(Panel_Knowledge_Point:GetSizeX(), pointTextSizeY + botTextSizeY + PaGlobal_Knowledge_Point.defaultOptionBGSizeY + 25)
  self.point_OptionBG:SetSize(self.point_OptionBG:GetSizeX(), Panel_Knowledge_Point:GetSizeY() - self.point_HorizonLine:GetPosY())
  self.point_OptionShow:ComputePos()
  self.point_OptionHide:ComputePos()
  self.point_OptionShow:SetPosX(self.point_OptionBG:GetSizeX() / 2 - (self.point_OptionShow:GetSizeX() + self.point_OptionShow:GetTextSizeX() + self.point_OptionHide:GetSizeX() + self.point_OptionHide:GetTextSizeX() + 50) / 2)
  self.point_OptionHide:SetPosX(self.point_OptionShow:GetPosX() + self.point_OptionShow:GetSizeX() + self.point_OptionShow:GetTextSizeX() + 50)
  self.point_OptionBG:ComputePos()
  Panel_Knowledge_Point:SetPosX(Panel_Knowledge_List:GetPosX() - Panel_Knowledge_Point:GetSizeX() - 5)
  Panel_Knowledge_Point:SetPosY(Panel_Knowledge_List:GetPosY() + (Panel_Knowledge_List:GetSizeY() - Panel_Knowledge_Point:GetSizeY()))
end
function PaGlobal_Knowledge_Point_Tooltip(isShow, tipType)
  PaGlobal_Knowledge_Point.point_Tooltip:SetShow(isShow)
end
function PaGlobal_Knowledge_OtherPanels_Close()
  if nil ~= Panel_IngameCashShop_EasyPayment and Panel_IngameCashShop_EasyPayment:IsShow() then
    Panel_IngameCashShop_EasyPayment:SetShow(false, false)
  end
  if nil ~= TranslationReport_Close then
    TranslationReport_Close()
  end
  if nil ~= InGameShopBuy_Close then
    InGameShopBuy_Close()
  end
  if nil ~= FGlobal_WebHelper_ForceClose then
    FGlobal_WebHelper_ForceClose()
  end
  if nil ~= Panel_ProductNote and true == Panel_ProductNote:GetShow() then
    Panel_ProductNote_ShowToggle()
  end
end
PaGlobal_Knowledge_Point:Init()
registerEvent("onScreenResize", "Panel_Knowledge_ReSizeScreen")
registerEvent("ToClient_MentalKnowlegeViewFirstUpdate", "ToClient_MentalKnowlegeViewFirstUpdate")
function Panel_Knowledge_ReSizeScreen()
  uiConst.main:SetSize(getScreenSizeX(), getScreenSizeY())
  uiConst.main:SetPosX(0)
  uiConst.main:SetPosY(0)
  uiConst.list:ComputePos()
  uiConst.info:ComputePos()
  uiConst.list:SetSize(uiConst.list:GetSizeX(), getScreenSizeY() * 0.38)
  uiConst.list_ListBg:SetSize(uiConst.list_ListBg:GetSizeX(), uiConst.list:GetSizeY() - 126)
  uiConst.list_Tree:SetSize(uiConst.list_Tree:GetSizeX(), uiConst.list:GetSizeY() - 126)
  if 0 < ToClient_getGameOptionControllerWrapper():getUIFontSizeType() then
    uiConst.list_Tree:SetItemQuantity(uiConst.list_Tree:GetSizeY() / 465 * 18)
    uiConst.list_Tree:setAddImagePosY(5)
  else
    uiConst.list_Tree:SetItemQuantity(uiConst.list_Tree:GetSizeY() / 465 * 25)
    uiConst.list_Tree:setAddImagePosY(2)
  end
  for _, v in pairs(uiConst) do
    v:ComputePos()
  end
  local scrollVertical = UI.getChildControl(uiConst.list_Tree, "Tree_1_Scroll")
  scrollVertical:SetSize(scrollVertical:GetSizeX(), uiConst.list_Tree:GetSizeY())
  scrollVertical:ComputePos()
end
function ToClient_MentalKnowlegeViewFirstUpdate()
  settingToFirstButton()
end
function PaGlobal_Knowledge_UpdateChaseData()
  chaseData.chaseSelectKey = nil
  chaseData.chaseName = nil
  uiConst._btn_ChaseCheck:SetShow(false)
  if false == _ContentsGroup_ChaseMonster then
    return
  end
  local selfPlayerWrrapper = getSelfPlayer()
  if nil == selfPlayerWrrapper then
    return
  end
  local selfPlayer = selfPlayerWrrapper:get()
  if nil == selfPlayer then
    return
  end
  local knowledge = selfPlayer:getMentalKnowledge()
  if nil == knowledge then
    return
  end
  local chaseCount = ToClient_getChaseCharacterKeyCount()
  if 0 == chaseCount then
    return
  end
  if 1 == chaseCount then
    local chaseCharacterKey = ToClient_getChaseCharacterKeyByIndex(0)
    if 0 == chaseCharacterKey or false == ToClient_isPossibleChase(chaseCharacterKey) then
      return
    end
    local cardKey = ToClient_getMentalCardKeyByCharacterKey(chaseCharacterKey)
    local card = knowledge:getCardByKeyRaw(cardKey)
    if nil == card then
      return
    end
    chaseData.chaseSelectKey = cardKey
    local cardName = card:getName()
    local strsplit = string.split(card:getName(), "]")
    if nil ~= strsplit[2] then
      chaseData.chaseName = strsplit[2]
    else
      local keyword = card:getKeyword()
      if 0 ~= string.len(keyword) then
        chaseData.chaseName = keyword
      else
        chaseData.chaseName = cardName
      end
    end
  else
    for idx = 0, chaseCount - 1 do
      local chaseCharacterKey = ToClient_getChaseCharacterKeyByIndex(idx)
      if 0 ~= chaseCharacterKey then
        local cardKey = ToClient_getMentalCardKeyByCharacterKey(chaseCharacterKey)
        local card = knowledge:getCardByKeyRaw(cardKey)
        if nil ~= card and nil == chaseData.chaseSelectKey then
          local theme = card:getParents()
          if nil ~= theme then
            local themeName = theme:getName()
            chaseData.chaseSelectKey = -theme:getKey()
            if nil ~= themeName then
              chaseData.chaseName = themeName
            end
            break
          end
        end
      end
    end
  end
  uiConst._btn_ChaseCheck:SetShow(true)
end
function PaGlobal_Knowledge_UpdateChaseTooltipPos()
  local tooltipPosY = chaseData.baseChaseToolTipPosY
  if true == uiConst.list_HintBG:GetShow() then
    tooltipPosY = tooltipPosY - uiConst.list_HintBG:GetSizeY()
  elseif nil ~= lastSelectCardKey and lastSelectCardKey > 0 then
    tooltipPosY = tooltipPosY - uiConst.info_InfoBg:GetSizeY() - 5
  end
  uiConst._stc_ChaseInfoBox:SetPosY(tooltipPosY)
end
function HandleEventOn_Knowledge_ShowChaseTooltip(isShow)
  if false == _ContentsGroup_ChaseMonster or false == isShow then
    uiConst._stc_ChaseInfoBox:SetShow(false)
    return
  end
  if nil ~= chaseData and nil ~= chaseData.chaseName then
    uiConst._txt_ChaseName:SetText(chaseData.chaseName)
  else
    uiConst._txt_ChaseName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "OPTION_TXT_FILTER_0"))
  end
  uiConst._stc_ChaseInfoBox:SetShow(true)
  PaGlobal_Knowledge_UpdateChaseTooltipPos()
end
function HandleEventLUp_Knowledge_SelectChase(isSetting)
  if false == _ContentsGroup_ChaseMonster then
    return
  end
  if nil == chaseData then
    return
  end
  local selfPlayerWrrapper = getSelfPlayer()
  if nil == selfPlayerWrrapper then
    return
  end
  local selfPlayer = selfPlayerWrrapper:get()
  if nil == selfPlayer then
    return
  end
  local knowledge = selfPlayer:getMentalKnowledge()
  if nil == knowledge then
    return
  end
  if true == isSetting and true == chaseData.isEcology then
    if nil == lastSelectCardKey or 0 == lastSelectCardKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
      return
    end
    do
      local currentTheme = knowledge:getCurrentTheme()
      if nil == currentTheme then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
        return
      end
      local currentThemeKey = currentTheme:getKey()
      if currentThemeKey < chaseData.ecologyMinThemaKey or currentThemeKey > chaseData.ecologyMaxThemaKey then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
        return
      end
      local chaseUpdate = function()
        if nil ~= FGlobal_Radar_UpdateActorIconColor then
          FGlobal_Radar_UpdateActorIconColor()
        end
        uiConst._btn_ChaseStart:SetShow(false)
        uiConst._btn_ChaseStop:SetShow(true)
        uiConst._btn_ChaseCheck:SetShow(true)
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ENABLE"))
      end
      if lastSelectCardKey > 0 then
        local card = knowledge:getCardByKeyRaw(lastSelectCardKey)
        if nil == card then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
          return
        end
        local selectCharacterKey = ToClient_getCharacterKeyByMentalCardKey(lastSelectCardKey)
        if 0 == selectCharacterKey or false == ToClient_isPossibleChase(selectCharacterKey) then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
          return
        end
        PaGlobal_Knowledge_ClearBeforeChase()
        chaseData.chaseSelectKey = lastSelectCardKey
        local cardName = card:getName()
        if nil ~= cardName then
          uiConst.list_Tree:SetSelectItemByKey(lastSelectCardKey)
          local selectItem = uiConst.list_Tree:GetSelectItem()
          if nil ~= selectItem and selectItem:GetKey() == lastSelectCardKey then
            local strsplit = string.split(cardName, "]")
            if nil ~= strsplit[2] then
              local grade = strsplit[1]
              local monsterName = strsplit[2]
              cardName = grade .. "]<PAColor0xff84fff5>" .. monsterName .. "<PAOldColor>"
              chaseData.chaseName = monsterName
            else
              local keyword = card:getKeyword()
              if 0 ~= string.len(keyword) then
                chaseData.chaseName = keyword
              else
                chaseData.chaseName = cardName
              end
              cardName = "<PAColor0xff84fff5>" .. cardName .. "<PAOldColor>"
            end
            selectItem:SetText(cardName)
          end
        end
        ToClient_addChaseMonster(selectCharacterKey)
        chaseUpdate()
      else
        do
          local theme = knowledge:getThemeByKeyRaw(-lastSelectCardKey)
          if nil == theme then
            Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
            return
          end
          local childCardCount = theme:getChildCardCount()
          if 0 == childCardCount then
            Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
            return
          end
          local function chaseStart()
            PaGlobal_Knowledge_ClearBeforeChase()
            chaseData.chaseSelectKey = lastSelectCardKey
            local firstCardKey = -1
            for idx = 0, childCardCount - 1 do
              local childCard = theme:getChildCardByIndex(idx)
              if nil ~= childCard then
                local cardKey = childCard:getKey()
                local characterKey = ToClient_getCharacterKeyByMentalCardKey(cardKey)
                if 0 ~= characterKey and true == ToClient_isPossibleChase(characterKey) then
                  ToClient_addChaseMonster(characterKey)
                  local cardName = childCard:getName()
                  if nil ~= cardName then
                    uiConst.list_Tree:SetSelectItemByKey(cardKey)
                    local selectItem = uiConst.list_Tree:GetSelectItem()
                    if nil ~= selectItem and selectItem:GetKey() == cardKey then
                      local strsplit = string.split(cardName, "]")
                      if nil ~= strsplit[2] then
                        local grade = strsplit[1]
                        local monsterName = strsplit[2]
                        cardName = grade .. "]<PAColor0xff84fff5>" .. monsterName .. "<PAOldColor>"
                      else
                        cardName = "<PAColor0xff84fff5>" .. cardName .. "<PAOldColor>"
                      end
                      selectItem:SetText(cardName)
                    end
                  end
                  if -1 == firstCardKey then
                    firstCardKey = cardKey
                  end
                end
              end
            end
            local themeName = theme:getName()
            if nil ~= themeName then
              chaseData.chaseName = themeName
            end
            if -1 ~= firstCardKey then
              uiConst.list_Tree:SetSelectItemByKey(firstCardKey)
            end
            chaseUpdate()
          end
          local checkImpossibleChase = false
          local isPossibleChase = false
          for idx = 0, childCardCount - 1 do
            local childCard = theme:getChildCardByIndex(idx)
            if nil ~= childCard then
              local cardKey = childCard:getKey()
              local characterKey = ToClient_getCharacterKeyByMentalCardKey(cardKey)
              if 0 ~= characterKey and true == ToClient_isPossibleChase(characterKey) then
                isPossibleChase = true
              else
                checkImpossibleChase = true
              end
            end
          end
          if false == isPossibleChase then
            Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
            return
          end
          local messageDesc = PAGetString(Defines.StringSheet_GAME, "LUA_MONSTERTRACKING_SELECTTHEME_COMPLETE")
          if true == checkImpossibleChase then
            messageDesc = PAGetString(Defines.StringSheet_GAME, "LUA_MONSTERTRACKING_SELECTTHEME_ALRET")
          end
          local messageBoxData = {
            title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
            content = messageDesc,
            functionYes = chaseStart,
            functionNo = MessageBox_Empty_function,
            priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
          }
          MessageBox.showMessageBox(messageBoxData)
        end
      end
    end
  else
    local function chaseStop()
      uiConst.list_Tree:SetSelectItemByKey(chaseData.chaseSelectKey)
      PaGlobal_Knowledge_ClearBeforeChase()
      uiConst._btn_ChaseStart:SetShow(false)
      uiConst._btn_ChaseStop:SetShow(false)
      uiConst._btn_ChaseCheck:SetShow(false)
      if nil ~= chaseData.chaseSelectKey and 0 ~= chaseData.chaseSelectKey then
        local knowledge = selfPlayer:getMentalKnowledge()
        if nil ~= knowledge then
          local currentTheme = knowledge:getCurrentTheme()
          if nil ~= currentTheme then
            local currentThemeKey = currentTheme:getKey()
            if currentThemeKey >= chaseData.ecologyMinThemaKey and currentThemeKey <= chaseData.ecologyMaxThemaKey then
              uiConst._btn_ChaseStart:SetShow(true)
            end
          end
        end
        if chaseData.chaseSelectKey > 0 then
          uiConst.list_Tree:SetSelectItemByKey(chaseData.chaseSelectKey)
        else
          local theme = knowledge:getThemeByKeyRaw(-chaseData.chaseSelectKey)
          if nil ~= theme then
            local childCardCount = theme:getChildCardCount()
            if childCardCount > 0 then
              for idx = 0, childCardCount - 1 do
                local childCard = theme:getChildCardByIndex(idx)
                if nil ~= childCard then
                  local cardKey = childCard:getKey()
                  uiConst.list_Tree:SetSelectItemByKey(cardKey)
                  break
                end
              end
            end
          end
          uiConst.list_Tree:SetSelectItemByKey(-chaseData.chaseSelectKey)
          Panel_Knowledge_SelectElement()
        end
      end
      chaseData.chaseSelectKey = nil
      chaseData.chaseName = nil
      if nil ~= FGlobal_Radar_UpdateActorIconColor then
        FGlobal_Radar_UpdateActorIconColor()
      end
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_DISABLE"))
    end
    if nil == chaseData.chaseSelectKey or 0 < chaseData.chaseSelectKey then
      chaseStop()
    else
      local messageDesc = PAGetString(Defines.StringSheet_GAME, "LUA_MONSTERTRACKING_SELECTTHEME_CANCEL")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
        content = messageDesc,
        functionYes = chaseStop,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  end
end
function PaGlobal_Knowledge_ClearBeforeChase()
  local selfPlayerWrrapper = getSelfPlayer()
  if nil == selfPlayerWrrapper then
    return
  end
  local selfPlayer = selfPlayerWrrapper:get()
  if nil == selfPlayer then
    return
  end
  local knowledge = selfPlayer:getMentalKnowledge()
  if nil == knowledge then
    return
  end
  ToClient_clearChaseMonsterList()
  if nil == chaseData or nil == chaseData.chaseSelectKey or 0 == chaseData.chaseSelectKey then
    return
  end
  if chaseData.chaseSelectKey > 0 then
    local card = knowledge:getCardByKeyRaw(chaseData.chaseSelectKey)
    if nil ~= card then
      local cardName = card:getName()
      if nil ~= cardName then
        uiConst.list_Tree:SetSelectItemByKey(chaseData.chaseSelectKey)
        local selectItem = uiConst.list_Tree:GetSelectItem()
        if nil ~= selectItem and selectItem:GetKey() == chaseData.chaseSelectKey then
          selectItem:SetText(cardName)
        end
      end
    end
  else
    local theme = knowledge:getThemeByKeyRaw(-chaseData.chaseSelectKey)
    if nil ~= theme then
      local childCardCount = theme:getChildCardCount()
      for idx = 0, childCardCount - 1 do
        local childCard = theme:getChildCardByIndex(idx)
        if nil ~= childCard then
          local cardKey = childCard:getKey()
          local cardName = childCard:getName()
          if nil ~= cardName then
            uiConst.list_Tree:SetSelectItemByKey(cardKey)
            local selectItem = uiConst.list_Tree:GetSelectItem()
            if nil ~= selectItem and selectItem:GetKey() == cardKey then
              selectItem:SetText(cardName)
            end
          end
        end
      end
      local themeName = theme:getName()
      if nil ~= themeName then
        uiConst.list_Tree:SetSelectItemByKey(-chaseData.chaseSelectKey)
        local selectItem = uiConst.list_Tree:GetSelectItem()
        if nil ~= selectItem and selectItem:GetKey() == chaseData.chaseSelectKey then
          selectItem:SetText(cardName)
        end
      end
    end
  end
end
function HandleEventLUp_Knowledge_FindChaseCard()
  if false == _ContentsGroup_ChaseMonster then
    return
  end
  if nil == chaseData or nil == chaseData.chaseSelectKey or 0 == chaseData.chaseSelectKey or nil == uiConst.list_Tree then
    return
  end
  local selfPlayerWrrapper = getSelfPlayer()
  if nil == selfPlayerWrrapper then
    return
  end
  local selfPlayer = selfPlayerWrrapper:get()
  if nil == selfPlayer then
    return
  end
  local knowledge = selfPlayer:getMentalKnowledge()
  if nil == knowledge then
    return
  end
  local selectThemeKey = 0
  local selectCardKey = 0
  if chaseData.chaseSelectKey > 0 then
    local childCard = knowledge:getCardByKeyRaw(chaseData.chaseSelectKey)
    if nil == childCard then
      return
    end
    local theme = childCard:getParents()
    if nil == theme then
      return
    end
    selectThemeKey = -theme:getKey()
    selectCardKey = childCard:getKey()
  else
    local theme = knowledge:getThemeByKeyRaw(-chaseData.chaseSelectKey)
    if nil == theme then
      return
    end
    local childCardCount = theme:getChildCardCount()
    for idx = 0, childCardCount - 1 do
      local childCard = theme:getChildCardByIndex(idx)
      if nil ~= childCard then
        local cardKey = childCard:getKey()
        local characterKey = ToClient_getCharacterKeyByMentalCardKey(cardKey)
        if 0 ~= characterKey and true == ToClient_isPossibleChase(characterKey) then
          selectCardKey = cardKey
          break
        end
      end
    end
    selectThemeKey = -theme:getKey()
  end
  if 0 == selectThemeKey or 0 == selectCardKey then
    return
  end
  Panel_Knowledge_OutInputMode()
  uiConst.list_Tree:SetSelectItemByKey(selectThemeKey)
  settingForNextTheme()
  uiConst.list_Tree:SetSelectItemByKey(selectCardKey)
  uiConst._btn_ChaseStart:SetShow(false)
  uiConst._btn_ChaseStop:SetShow(true)
  lastSelectCardKey = selectCardKey
  PaGlobal_Knowledge_UpdateChaseTooltipPos()
end
init()
ToClient_setNoHasCardPicture("UI_Artwork/COLLECTED_noBrain.dds")
renderMode:setClosefunctor(renderMode, Panel_Knowledge_Hide)
