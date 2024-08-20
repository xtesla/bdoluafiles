Panel_CustomizationMain:setFlushAble(false)
Panel_CustomizationStatic:setFlushAble(false)
Panel_CustomizationMessage:setFlushAble(false)
local Line_Template = UI.getChildControl(Panel_CustomizationMain, "Static_LineTemplate1")
local Static_Large_Point = UI.getChildControl(Panel_CustomizationMain, "Static_Large_Point")
local Static_Small_Point = UI.getChildControl(Panel_CustomizationMain, "Static_Small_Point")
local Button_MainButton = UI.getChildControl(Panel_CustomizationMain, "Button_MainButton")
local Button_Group = UI.getChildControl(Panel_CustomizationMain, "Button_Group")
local StaticText_Main = UI.getChildControl(Panel_CustomizationMain, "StaticText_Main")
local RadioButton_HistoryTemp = UI.getChildControl(Panel_CustomizationMain, "RadioButton_HistoryTemp")
local Button_SaveHistory = UI.getChildControl(Panel_CustomizationMain, "Button_SaveHistory")
local staticMainImage = {}
staticMainImage[1] = UI.getChildControl(Panel_CustomizationMain, "Static_Weather")
staticMainImage[2] = UI.getChildControl(Panel_CustomizationMain, "Static_Customization")
staticMainImage[3] = UI.getChildControl(Panel_CustomizationMain, "Static_BG")
staticMainImage[4] = UI.getChildControl(Panel_CustomizationMain, "Static_Pose")
staticMainImage[5] = UI.getChildControl(Panel_CustomizationMain, "Static_Constellation")
local staticPoseImage = {}
staticPoseImage[1] = UI.getChildControl(Panel_CustomizationMain, "StaticText_look")
staticPoseImage[2] = UI.getChildControl(Panel_CustomizationMain, "StaticText_costume")
local staticWeatherImage = {}
staticWeatherImage[1] = UI.getChildControl(Panel_CustomizationMain, "Static_Weather_01")
staticWeatherImage[2] = UI.getChildControl(Panel_CustomizationMain, "Static_Weather_02")
staticWeatherImage[3] = UI.getChildControl(Panel_CustomizationMain, "Static_Weather_03")
staticWeatherImage[4] = UI.getChildControl(Panel_CustomizationMain, "Static_Weather_04")
staticWeatherImage[5] = UI.getChildControl(Panel_CustomizationMain, "Static_Weather_05")
staticWeatherImage[6] = UI.getChildControl(Panel_CustomizationMain, "Static_Weather_06")
staticWeatherImage[7] = UI.getChildControl(Panel_CustomizationMain, "Static_Weather_07")
local backGroundNum = 5
local zodiacDefalutSpanSizeX = 20
local zodiacDefalutSpanSizeY = 220
local stc_Zodiac = UI.getChildControl(Panel_CustomizationMain, "Static_Zodiac")
local StaticText_Zodiac = UI.getChildControl(stc_Zodiac, "StaticText_Zodiac")
local Static_ZodiacImage = UI.getChildControl(stc_Zodiac, "Static_ZodiacImage")
local StaticText_ZodiacName = UI.getChildControl(stc_Zodiac, "StaticText_ZodiacName")
local StaticText_ZodiacDescription = UI.getChildControl(stc_Zodiac, "StaticText_ZodiacDescription")
local Static_ZodiacITooltip = UI.getChildControl(Panel_CustomizationMain, "StaticText_zodiacTooltip")
local Static_ZodiacIcon = UI.getChildControl(Panel_CustomizationMain, "Static_ZodiacIcon")
local Button_ApplyDefaultCustomization = UI.getChildControl(Panel_CustomizationMain, "Button_ApplyDefaultCustomization")
local Button_Duplication = UI.getChildControl(Panel_CustomizationMain, "Button_Duplication")
local Button_Char = UI.getChildControl(Panel_CustomizationMain, "Button_CharacterCreateStart")
local Button_SelectClass = UI.getChildControl(Panel_CustomizationMain, "Button_SelectClass")
local Button_Back = UI.getChildControl(Panel_CustomizationMain, "Button_Back")
local Static_CharName = UI.getChildControl(Panel_CustomizationMain, "StaticText_CharacterName")
local Edit_CharName = UI.getChildControl(Panel_CustomizationMain, "Edit_CharacterName")
local btn_CharacterNameCreateRule = UI.getChildControl(Panel_CustomizationMain, "Button_CharacterNameCreateRule")
local btn_RandomBeauty = UI.getChildControl(Panel_CustomizationMain, "Button_RandomBeauty")
local Button_SaveCustomization = UI.getChildControl(Panel_CustomizationMain, "Button_SaveCustomization")
local Button_LoadCustomization = UI.getChildControl(Panel_CustomizationMain, "Button_LoadCustomization")
local Button_CustomizingAlbum = UI.getChildControl(Panel_CustomizationMain, "Button_CustomizingAlbum")
Button_CustomizingAlbum:SetShow(_ContentsGroup_webAlbumOpen)
local staticCustom = {}
staticCustom[1] = UI.getChildControl(Panel_CustomizationMain, "StaticText_Hair")
staticCustom[2] = UI.getChildControl(Panel_CustomizationMain, "StaticText_Face")
staticCustom[3] = UI.getChildControl(Panel_CustomizationMain, "StaticText_Form")
staticCustom[4] = UI.getChildControl(Panel_CustomizationMain, "StaticText_Voice")
local CheckButton_CameraLook = UI.getChildControl(Panel_CustomizationStatic, "CheckButton_CameraLook")
local CheckButton_ToggleUi = UI.getChildControl(Panel_CustomizationStatic, "CheckButton_ToggleUi")
local CheckButton_ImagePreset = UI.getChildControl(Panel_CustomizationStatic, "CheckButton_ImagePreset")
local Button_ScreenShot = UI.getChildControl(Panel_CustomizationStatic, "Static_ScreenShot")
local Button_ScreenShotFolder = UI.getChildControl(Panel_CustomizationStatic, "Static_ScreenShotFolder")
local Button_ProfileScreenShot = UI.getChildControl(Panel_CustomizationStatic, "Static_ProfileScreenShot")
local CheckButton_CameraLook_Title = UI.getChildControl(Panel_CustomizationStatic, "StaticText_CameraLook")
local CheckButton_ToggleUi_Title = UI.getChildControl(Panel_CustomizationStatic, "StaticText_ToggleUi")
local CheckButton_ImagePreset_Title = UI.getChildControl(Panel_CustomizationStatic, "StaticText_ImagePreset")
local Button_ScreenShot_Title = UI.getChildControl(Panel_CustomizationStatic, "StaticText_ScreenShot")
local Button_ScreenShotFolder_Title = UI.getChildControl(Panel_CustomizationStatic, "StaticText_ScreenShotFolder")
local Button_ProfileScreenShot_Title = UI.getChildControl(Panel_CustomizationStatic, "StaticText_ProfileScreenShot")
local btn_isSeasonChar = UI.getChildControl(Panel_CustomizationMain, "Button_Season")
local stc_SeasonBg = UI.getChildControl(Panel_CustomizationMain, "Static_Area")
local stc_SeasonArea = UI.getChildControl(stc_SeasonBg, "Static_CreateSeasonArea")
local txt_SeasonCharNameTitle = UI.getChildControl(stc_SeasonArea, "StaticText_CharName")
local edit_SeasonCharName = UI.getChildControl(stc_SeasonArea, "Edit_CharName")
local chk_Season = UI.getChildControl(stc_SeasonArea, "CheckButton_SeasonChk")
local txt_SeasonChkBtn = UI.getChildControl(chk_Season, "StaticText_SeasonCheckBtn")
local btn_duplicate_season = UI.getChildControl(stc_SeasonArea, "Button_Duplication_Season")
local btn_CreateSeason = UI.getChildControl(stc_SeasonArea, "Button_CreateChar")
local stc_SeasonTopline = UI.getChildControl(stc_SeasonArea, "Static_TopImage")
local stc_SeasonBottomImg = UI.getChildControl(stc_SeasonArea, "Static_BottomImage")
local txt_SeasonFamilyName = UI.getChildControl(stc_SeasonBg, "StaticText_SeasonFamilyName")
local txt_SeasonFamilyTitle = UI.getChildControl(stc_SeasonBg, "StaticText_SeasonFamilyNameTitle")
btn_isSeasonChar:SetShow(false)
UI.setLimitTextAndAddTooltip(txt_SeasonChkBtn)
local originSeasonBgSizeY = stc_SeasonBg:GetSizeY()
local originSeasonAreaSizeY = stc_SeasonArea:GetSizeY()
local originSeasonAreaSpan = stc_SeasonArea:GetSpanSize().y
local originToplineSpan = stc_SeasonTopline:GetSpanSize().y
local originBottomlineSpan = stc_SeasonBottomImg:GetSpanSize().y
local originFamTitleSpan = txt_SeasonFamilyTitle:GetSpanSize().y
local originFamNameSpan = txt_SeasonFamilyName:GetSpanSize().y
local originCharTitleSpan = txt_SeasonCharNameTitle:GetSpanSize().y
local originEditSpan = edit_SeasonCharName:GetSpanSize().y
local originBtnSpan = btn_CreateSeason:GetSpanSize().y
local originDupBtnSpan = btn_duplicate_season:GetSpanSize().y
local isValidInputCharacterName = false
local cachedInputCharacterName = ""
local isShowScreenShot = true
Button_ScreenShot:SetShow(isShowScreenShot)
Button_ScreenShotFolder:SetShow(isShowScreenShot)
Button_ScreenShot_Title:SetShow(isShowScreenShot)
Button_ScreenShotFolder_Title:SetShow(isShowScreenShot)
local StaticText_CustomizationMessage = UI.getChildControl(Panel_CustomizationMessage, "StaticText_CustomizationMessage")
local StaticText_FamilyNameTitle = UI.getChildControl(Panel_CustomizationMain, "StaticText_FamilyNameTitle")
local StaticText_FamilyName = UI.getChildControl(Panel_CustomizationMain, "StaticText_FamilyName")
local StaticText_CustomizationInfo = UI.getChildControl(Panel_CustomizationMain, "StaticText_CustomizationInfo")
local StaticText_AuthorName = UI.getChildControl(Panel_CustomizationMain, "StaticText_AuthorName")
local StaticText_AuthorTitle = UI.getChildControl(Panel_CustomizationMain, "StaticText_AuthorTitle")
local link1 = UI.getChildControl(Panel_CustomizationMain, "Button_Link1")
local link2 = UI.getChildControl(Panel_CustomizationMain, "Button_Link2")
local japanEventBanner = UI.getChildControl(Panel_CustomizationMain, "Button_JapanEvent")
local btn_Warn = UI.getChildControl(Panel_CustomizationMain, "Button_Warn")
local isDevelopment = ToClient_IsDevelopment()
local Button_RandFaceBoneOpen_DEV, Button_CaptureFaceBoneByBeautyAlbum_DEV, Button_RandFaceBoneOpen_DEV_Title, Button_CaptureFaceBoneByBeautyAlbum_DEV_Title
local originCameraLookEnable = false
local isFaceScreenShotByBeautyAlbum = false
local faceScreenSizeX = 1024
local faceScreenSizeY = 1024
function PaGloabl_RandFaceBoneOpen_DEV_Show(isShow)
  if nil ~= Button_RandFaceBoneOpen_DEV then
    Button_RandFaceBoneOpen_DEV:SetShow(isShow)
  end
  if nil ~= Button_RandFaceBoneOpen_DEV_Title then
    Button_RandFaceBoneOpen_DEV_Title:SetShow(isShow)
  end
end
function PaGloabl_CaptureFaceBoneByBeautyAlbum_Show(isShow)
  if nil ~= Button_CaptureFaceBoneByBeautyAlbum_DEV then
    Button_CaptureFaceBoneByBeautyAlbum_DEV:SetShow(isShow)
  end
  if nil ~= Button_CaptureFaceBoneByBeautyAlbum_DEV_Title then
    Button_CaptureFaceBoneByBeautyAlbum_DEV_Title:SetShow(isShow)
  end
end
function HandleClicked_RandomFaceBoneUI_Open_DEV()
  if nil ~= Panel_CreateRandomFaceBoneForDEV and nil ~= FaceBoneUI_Show then
    FaceBoneUI_Show(true)
  end
end
if true == isDevelopment and nil ~= Button_ProfileScreenShot and nil ~= Button_ProfileScreenShot_Title then
  local gapX = 74
  local textGapY = 74
  local PosX = CheckButton_CameraLook:GetPosX()
  local PosY = CheckButton_CameraLook:GetPosY() + 130
  if nil == Button_RandFaceBoneOpen_DEV and nil ~= HandleClicked_RandomFaceBoneUI_Open_DEV then
    Button_RandFaceBoneOpen_DEV = UI.cloneControl(Button_ProfileScreenShot, Panel_CustomizationStatic, "Static_RandFaceBoneOpen_DEV")
    Button_RandFaceBoneOpen_DEV:addInputEvent("Mouse_LUp", "HandleClicked_RandomFaceBoneUI_Open_DEV()")
    if nil == Button_RandFaceBoneOpen_DEV_Title then
      Button_RandFaceBoneOpen_DEV_Title = UI.cloneControl(Button_ProfileScreenShot_Title, Panel_CustomizationStatic, "StaticText_RandFaceBoneOpen_DEV")
      Button_RandFaceBoneOpen_DEV_Title:SetText("\235\158\156\235\141\164 \236\150\188\234\181\180\236\131\157\236\132\177 \236\151\180\234\184\176(Dev\236\154\169)")
    end
    Button_RandFaceBoneOpen_DEV:SetPosX(PosX)
    Button_RandFaceBoneOpen_DEV_Title:SetPosX(PosX)
    Button_RandFaceBoneOpen_DEV:SetPosY(PosY)
    Button_RandFaceBoneOpen_DEV_Title:SetPosY(PosY + Button_RandFaceBoneOpen_DEV:GetSizeY() + 2)
  end
  if nil == Button_CaptureFaceBoneByBeautyAlbum_DEV and nil ~= HandleClicked_CreateFaceBoneForDev_CreateBeautyAlbum then
    Button_CaptureFaceBoneByBeautyAlbum_DEV = UI.cloneControl(Button_ProfileScreenShot, Panel_CustomizationStatic, "Static_CaptureFaceBoneByBeautyAlbum_DEV")
    Button_CaptureFaceBoneByBeautyAlbum_DEV:addInputEvent("Mouse_LUp", "HandleClicked_CreateFaceBoneForDev_CreateBeautyAlbum()")
    if nil == Button_CaptureFaceBoneByBeautyAlbum_DEV_Title then
      Button_CaptureFaceBoneByBeautyAlbum_DEV_Title = UI.cloneControl(Button_ProfileScreenShot_Title, Panel_CustomizationStatic, "StaticText_CaptureFaceBoneByBeautyAlbum_DEV")
      Button_CaptureFaceBoneByBeautyAlbum_DEV_Title:SetText("\235\183\176\237\139\176\236\149\168\235\178\148 \236\160\149\235\179\180\235\161\156 \236\180\136\236\131\129\237\153\148 \236\180\172\236\152\129(Dev\236\154\169)")
    end
    Button_CaptureFaceBoneByBeautyAlbum_DEV:SetPosX(PosX + gapX)
    Button_CaptureFaceBoneByBeautyAlbum_DEV_Title:SetPosX(PosX + gapX)
    Button_CaptureFaceBoneByBeautyAlbum_DEV:SetPosY(PosY)
    Button_CaptureFaceBoneByBeautyAlbum_DEV_Title:SetPosY(PosY + Button_CaptureFaceBoneByBeautyAlbum_DEV:GetSizeY() + 2)
  end
end
if false then
  link1:SetSize(321, 90)
  link2:SetSize(321, 90)
  link1:SetSpanSize(0, 140)
  link2:SetSpanSize(0, 240)
  if 12 == getGameServiceResType() then
    link1:ChangeTextureInfoName("new_ui_common_forlua/Window/Cash_Customization/Apply_base_th.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(link1, 0, 0, 321, 90)
    link1:getBaseTexture():setUV(x1, y1, x2, y2)
    link1:setRenderTexture(link1:getBaseTexture())
    link1:ChangeOnTextureInfoName("new_ui_common_forlua/Window/Cash_Customization/Apply_over_th.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(link1, 0, 0, 321, 90)
    link1:getOnTexture():setUV(x1, y1, x2, y2)
    link1:ChangeClickTextureInfoName("new_ui_common_forlua/Window/Cash_Customization/Apply_click_th.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(link1, 0, 0, 321, 90)
    link1:getClickTexture():setUV(x1, y1, x2, y2)
    link2:ChangeTextureInfoName("new_ui_common_forlua/Window/Cash_Customization/PreOrder_base_th.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(link2, 0, 0, 321, 90)
    link2:getBaseTexture():setUV(x1, y1, x2, y2)
    link2:setRenderTexture(link2:getBaseTexture())
    link2:ChangeOnTextureInfoName("new_ui_common_forlua/Window/Cash_Customization/PreOrder_over_th.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(link2, 0, 0, 321, 90)
    link2:getOnTexture():setUV(x1, y1, x2, y2)
    link2:ChangeClickTextureInfoName("new_ui_common_forlua/Window/Cash_Customization/PreOrder_click_th.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(link2, 0, 0, 321, 90)
    link2:getClickTexture():setUV(x1, y1, x2, y2)
  else
    link1:ChangeTextureInfoName("new_ui_common_forlua/Window/Cash_Customization/Apply_base_en.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(link1, 0, 0, 321, 90)
    link1:getBaseTexture():setUV(x1, y1, x2, y2)
    link1:setRenderTexture(link1:getBaseTexture())
    link1:ChangeOnTextureInfoName("new_ui_common_forlua/Window/Cash_Customization/Apply_over_en.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(link1, 0, 0, 321, 90)
    link1:getOnTexture():setUV(x1, y1, x2, y2)
    link1:ChangeClickTextureInfoName("new_ui_common_forlua/Window/Cash_Customization/Apply_click_en.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(link1, 0, 0, 321, 90)
    link1:getClickTexture():setUV(x1, y1, x2, y2)
    link2:ChangeTextureInfoName("new_ui_common_forlua/Window/Cash_Customization/PreOrder_base_en.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(link2, 0, 0, 321, 90)
    link2:getBaseTexture():setUV(x1, y1, x2, y2)
    link2:setRenderTexture(link2:getBaseTexture())
    link2:ChangeOnTextureInfoName("new_ui_common_forlua/Window/Cash_Customization/PreOrder_over_en.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(link2, 0, 0, 321, 90)
    link2:getOnTexture():setUV(x1, y1, x2, y2)
    link2:ChangeClickTextureInfoName("new_ui_common_forlua/Window/Cash_Customization/PreOrder_click_en.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(link2, 0, 0, 321, 90)
    link2:getClickTexture():setUV(x1, y1, x2, y2)
  end
end
link1:SetShow(false)
link2:SetShow(false)
japanEventBanner:SetShow(false)
local historyButtons = {}
local _classIndex
local InGameMode = false
local closeCustomizationMode = false
local isFristAddHistory = false
local screenShotTime = 0
local screenShotButtonUse = true
local screenShotReady = false
local showSeasonBanner = false
function customHistoryDo()
  local hairState = PaGloabl_getFacehairCheckBtnValue()
  if ToClient_HistoryDo() then
    historyTableDoChangeActive()
  end
  PaGloabl_setFacehairCheckBtnValue(hairState)
end
function customHistoryUnDo()
  local hairState = PaGloabl_getFacehairCheckBtnValue()
  if ToClient_HistoryUnDo() then
    historyTableUnDoChangeActive()
  end
  PaGloabl_setFacehairCheckBtnValue(hairState)
end
function customHistorySelectByIndex(index)
  ToClient_HistorySelectByIndex(index)
end
Button_ApplyDefaultCustomization:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_APPLYDEFAULTCUSTOMIZATION"))
Button_Char:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_CREATEOK"))
Button_SelectClass:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_SELECTCLASS"))
Button_Back:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_SELECTCHARACTER"))
Static_CharName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_CHARNAME"))
StaticText_Zodiac:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_ZODIAC"))
Button_SaveCustomization:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERCREATION_MAIN_BUTTON_SAVECUSTOMIZATION"))
Button_LoadCustomization:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERCREATION_MAIN_BUTTON_LOADCUSTOMIZATION"))
Button_SaveHistory:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERCREATION_MAIN_BUTTON_SAVEHISTORY"))
Button_CustomizingAlbum:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BEAUTYALBUM"))
StaticText_FamilyName:SetText(getFamilyName())
CheckButton_CameraLook_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_CAMERALOOK_TITLE"))
CheckButton_ToggleUi_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_TOGGLEUI_TITLE"))
Button_ScreenShot_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERCREATION_MAIN_SCREENSHOT_TITLE"))
Button_ScreenShotFolder_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERCREATION_MAIN_SCREENSHOTFOLDER_TITLE"))
Button_ProfileScreenShot_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERCREATION_MAIN_PROFILESCREENSHOT_TITLE"))
StaticText_CustomizationMessage:SetText("")
StaticText_CustomizationInfo:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_CUSTOMIZING_INFO"))
StaticText_AuthorTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_CUSTOMIZING_AUTHOR"))
Line_Template:SetSize(Line_Template:GetSizeX(), 28)
Panel_CustomizationMain:RegisterUpdateFunc("MainPanel_UpdatePerFrame")
local _web_RandomBeauty = UI.createControl(__ePAUIControl_WebControl, Panel_CustomizationMain, "WebControl_RandomCustomization")
btn_RandomBeauty:SetShow(_ContentsGroup_webAlbumOpen)
local preview_Main = true
local mainButtonNum = 5
local timer = 0
local isSubEffectPlay = false
CheckButton_ImagePreset_Title:SetShow(false)
RadioButton_HistoryTemp:SetShow(false)
local mainText = {
  PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_WEATHER"),
  PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_CUSTOMIZE"),
  PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_BACKGROUND"),
  PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_CHARACTER_ACTION"),
  PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_ZODIAC")
}
Button_ApplyDefaultCustomization:addInputEvent("Mouse_LUp", "HandleClicked_CustomizationMain_applyDefaultCustomizationParams()")
Button_Duplication:addInputEvent("Mouse_LUp", "HandleClicked_DuplicateName()")
Button_Char:addInputEvent("Mouse_LUp", "Panel_CharacterCreateOK_NewCustomization()")
Button_SelectClass:addInputEvent("Mouse_LUp", "HandleClicked_CustomizationMain_SelectClass()")
Button_Back:addInputEvent("Mouse_LUp", "HandleClicked_CustomizationMain_Back()")
btn_CharacterNameCreateRule:addInputEvent("Mouse_LUp", "HandleClicked_RuleShow()")
btn_RandomBeauty:addInputEvent("Mouse_LUp", "HandleClicked_RandomBeautyMSG()")
Button_SaveCustomization:addInputEvent("Mouse_LUp", "HandleClicked_saveCustomizationData()")
Button_LoadCustomization:addInputEvent("Mouse_LUp", "HandleClicked_loadCustomizationData()")
Button_CustomizingAlbum:addInputEvent("Mouse_LUp", "FGlobal_CustomizingAlbum_Show(true, CppEnums.ClientSceneState.eClientSceneStateType_Customization)")
link1:addInputEvent("Mouse_LUp", "HandleClicked_NationalOption( 0 )")
link2:addInputEvent("Mouse_LUp", "HandleClicked_NationalOption( 1 )")
japanEventBanner:addInputEvent("Mouse_LUp", "HandleClicked_JapanEventExecute()")
CheckButton_CameraLook:addInputEvent("Mouse_LUp", "CameraLookCheck()")
CheckButton_CameraLook:addInputEvent("Mouse_On", "overToggleButton(\"" .. CheckButton_CameraLook:GetID() .. "\"" .. ")")
CheckButton_ToggleUi:addInputEvent("Mouse_LUp", "ToggleUi()")
CheckButton_ToggleUi:addInputEvent("Mouse_On", "overToggleButton(\"" .. CheckButton_ToggleUi:GetID() .. "\"" .. ")")
Button_ScreenShot:addInputEvent("Mouse_LUp", "TakeScreenShot()")
Button_ScreenShot:addInputEvent("Mouse_On", "overToggleButton(\"" .. Button_ScreenShot:GetID() .. "\"" .. ")")
Button_ScreenShotFolder:addInputEvent("Mouse_LUp", "OpenScreenShotFolder()")
Button_ScreenShotFolder:addInputEvent("Mouse_On", "overToggleButton(\"" .. Button_ScreenShotFolder:GetID() .. "\"" .. ")")
Button_ProfileScreenShot:addInputEvent("Mouse_LUp", "TakeFaceScreenShot()")
Button_ProfileScreenShot:addInputEvent("Mouse_On", "overToggleButton(\"" .. Button_ProfileScreenShot:GetID() .. "\"" .. ")")
Button_ProfileScreenShot:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
btn_Warn:addInputEvent("Mouse_On", "HandleOver_EditOptionTooltip()")
btn_Warn:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
CheckButton_ImagePreset:SetShow(false)
Button_SaveHistory:addInputEvent("Mouse_LUp", "HandleClicked_CustomizationAddHistory()")
if false == _ContentsGroup_RenewUI_Customization then
  registerEvent("EventSetMainButtonPosition", "SetMainButtonPosition")
  registerEvent("EventShowUpAllUI", "showAllUI")
  registerEvent("EventCustomizationMessage", "CustomizationMessage")
  registerEvent("EventShowCharacterCustomization", "ShowCharacterCustomization")
  registerEvent("EventinitToggleIndex", "initToggleIndex")
  registerEvent("EventNotify_customizationAuthorName", "CustomizationAuthorName")
  registerEvent("FromClient_Customizing_IsEditableUpdate", "FromClient_CustomizationIsEditable")
  registerEvent("FromClient_CustomizationHistoryApplyUpdate", "FromClient_CustomizationHistoryApplyUpdate")
  registerEvent("FromClient_CustomizationHistoryUpdate", "FromClient_CustomizationHistoryUpdate")
end
local mainButtonInfo = {}
local groupTree = {}
local initialized = false
local preview_Main = true
local timer = 0
local isSubEffectPlay = false
local doScreenShot = false
local doScreenShotSub = false
local doScreenShotInFrame = false
local doScreenCapture = false
local EndScreenCapture = false
local rotationPointNormalize = function(x, y, angle)
  local nX = x * math.cos(angle) + y * math.sin(angle)
  local nY = x * -math.sin(angle) + y * math.cos(angle)
  local normalize = math.sqrt(nX * nX + nY * nY)
  nX = nX / normalize
  nY = nY / normalize
  return nX, nY
end
local function updateComputePos()
  CheckButton_CameraLook:ComputePos()
  CheckButton_ToggleUi:ComputePos()
  CheckButton_ImagePreset:ComputePos()
  Button_ScreenShot:ComputePos()
  Button_ScreenShotFolder:ComputePos()
  stc_Zodiac:ComputePos()
  StaticText_Zodiac:ComputePos()
  StaticText_ZodiacName:ComputePos()
  StaticText_ZodiacDescription:ComputePos()
  Static_ZodiacImage:ComputePos()
  Button_ApplyDefaultCustomization:ComputePos()
  Button_Duplication:ComputePos()
  Button_Char:ComputePos()
  Button_Back:ComputePos()
  Button_SelectClass:ComputePos()
  Edit_CharName:ComputePos()
  Static_CharName:ComputePos()
  Button_SaveCustomization:ComputePos()
  Button_LoadCustomization:ComputePos()
  Button_CustomizingAlbum:ComputePos()
  btn_CharacterNameCreateRule:ComputePos()
  btn_RandomBeauty:ComputePos()
  StaticText_CustomizationInfo:ComputePos()
  StaticText_AuthorTitle:ComputePos()
  StaticText_AuthorName:ComputePos()
  Button_SaveHistory:ComputePos()
  StaticText_FamilyNameTitle:ComputePos()
  StaticText_FamilyName:ComputePos()
  StaticText_CustomizationMessage:ComputePos()
  link1:ComputePos()
  link2:ComputePos()
  japanEventBanner:ComputePos()
  historyTableRePosY()
end
local function createWeatherGroup(groupInfo)
  local count = getWeatherCount()
  groupInfo.treeItem:SetAsParentNode(100, Line_Template, 0.61, math.pi / 9, math.pi + math.pi / 8)
  for ii = 1, count do
    local groupItem = groupInfo.treeItem:addItem(Button_Group, "TREE_BUTTON_" .. ii, staticWeatherImage[ii])
    groupItem.control:SetShow(true)
    groupItem.control:addInputEvent("Mouse_LUp", "applyWeather(" .. ii - 1 .. ")")
    groupItem.control:addInputEvent("Mouse_LDown", "clickSubButton()")
    local name = groupItem.control:GetID()
    local parentName = groupInfo.button:GetID()
    groupItem.control:addInputEvent("Mouse_On", "overSubButton(\"" .. parentName .. "\",\"" .. name .. "\"" .. ")")
  end
end
local function createCustomizationGroup(groupInfo)
  groupInfo.treeItem:SetAsParentNode(100, Line_Template, 0.61, math.pi / 5, -math.pi / 2)
  for ii = 1, 4 do
    local groupItem
    groupItem = groupInfo.treeItem:addItem(Button_Group, "TREE_BUTTON_" .. ii, staticCustom[ii])
    groupItem.control:SetShow(true)
    groupItem.control:addInputEvent("Mouse_LDown", "clickSubButton()")
    if ii ~= 4 then
      groupItem.control:addInputEvent("Mouse_LUp", "SelectCustomizationGroup(" .. ii - 1 .. ")")
    else
      groupItem.control:addInputEvent("Mouse_LUp", "SelectCustomizationVoice()")
    end
    local name = groupItem.control:GetID()
    local parentName = groupInfo.button:GetID()
    groupItem.control:addInputEvent("Mouse_On", "overSubButton(\"" .. parentName .. "\",\"" .. name .. "\"" .. ")")
  end
end
local function createPoseGroup(groupInfo)
  groupInfo.treeItem:SetAsParentNode(100, Line_Template, 0.61, math.pi / 5, -math.pi / 5)
  for ii = 1, 2 do
    local groupItem = groupInfo.treeItem:addItem(Button_Group, "TREE_BUTTON_" .. ii, staticPoseImage[ii])
    groupItem.control:SetShow(true)
    if ii ~= 2 then
      groupItem.control:addInputEvent("Mouse_LUp", "SelectPoseControl(" .. ii .. ")")
    else
      groupItem.control:addInputEvent("Mouse_LUp", "SelectPoseControl(" .. ii .. ")")
    end
    groupItem.control:addInputEvent("Mouse_LDown", "clickSubButton()")
    local name = groupItem.control:GetID()
    local parentName = groupInfo.button:GetID()
    groupItem.control:addInputEvent("Mouse_On", "overSubButton(\"" .. parentName .. "\",\"" .. name .. "\"" .. ")")
  end
end
local function createBackgroundGroup(groupInfo)
  groupInfo.treeItem:SetAsParentNode(100, Line_Template, 0.61, math.pi * 2 / 5, math.pi * 5 / 4)
  for ii = 1, backGroundNum do
    local groupItem = groupInfo.treeItem:addItem(Button_Group, "TREE_BUTTON_" .. ii, staticWeatherImage[ii])
    groupItem.control:SetShow(true)
    groupItem.control:addInputEvent("Mouse_LUp", "applyBackground(" .. ii - 1 .. ")")
    groupItem.control:addInputEvent("Mouse_LDown", "clickSubButton()")
    local name = groupItem.control:GetID()
    local parentName = groupInfo.button:GetID()
    groupItem.control:addInputEvent("Mouse_On", "overSubButton(\"" .. parentName .. "\",\"" .. name .. "\"" .. ")")
  end
end
function SelectZodiac(zodiacIndex)
  local zodiacInfo = getZodiac(zodiacIndex)
  local zodiacName = zodiacInfo:getZodiacName()
  if zodiacName ~= nil then
    StaticText_ZodiacName:SetText(zodiacName)
  end
  local zodiacDescription = zodiacInfo:getZodiacDescription()
  if zodiacDescription ~= nil then
    zodiacDescription = zodiacDescription .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERCREATION_ZODIACDESC")
    local txtSizeY = StaticText_ZodiacDescription:GetTextSizeY()
    stc_Zodiac:SetSpanSize(zodiacDefalutSpanSizeX, zodiacDefalutSpanSizeY + txtSizeY)
    StaticText_ZodiacDescription:SetTextMode(__eTextMode_AutoWrap)
    StaticText_ZodiacDescription:SetText(zodiacDescription)
  end
  local zodiacImagePath = zodiacInfo:getZodiacImagePath()
  if zodiacImagePath ~= nil then
    Static_ZodiacImage:SetShow(true)
    Static_ZodiacImage:ChangeTextureInfoName(zodiacImagePath)
    Static_ZodiacImage:getBaseTexture():setUV(0, 0, 1, 1)
    Static_ZodiacImage:setRenderTexture(Static_ZodiacImage:getBaseTexture())
  end
  local zodiacKey = zodiacInfo:getZodiacKey()
  applyZodiac(zodiacKey)
end
local function createZodiacGroup(groupInfo, mainButtonIndex)
  local tempStatic_ZodiacIcon = UI.createControl(__ePAUIControl_Static, Panel_CustomizationMain, "StaticText_Zodiac_Copied")
  CopyBaseProperty(Static_ZodiacIcon, tempStatic_ZodiacIcon)
  Line_Template:SetSize(Line_Template:GetSizeX(), 53)
  local count = getZodiacCount()
  groupInfo.treeItem:SetAsParentNode(130, Line_Template, 0.59, math.pi, -math.pi * 5 / 6)
  for ii = 1, count do
    local zodiacInfo = getZodiac(ii - 1)
    local zodiacIconPath = zodiacInfo:getZodiacIconPath()
    tempStatic_ZodiacIcon:ChangeTextureInfoName(zodiacIconPath)
    tempStatic_ZodiacIcon:getBaseTexture():setUV(0, 0, 1, 1)
    tempStatic_ZodiacIcon:setRenderTexture(tempStatic_ZodiacIcon:getBaseTexture())
    local groupItem = groupInfo.treeItem:addItem(Button_Group, "TREE_BUTTON_" .. ii, tempStatic_ZodiacIcon)
    groupItem.control:SetShow(true)
    groupItem.control:addInputEvent("Mouse_LUp", "SelectZodiac(" .. ii - 1 .. ")")
    local name = groupItem.control:GetID()
    local parentName = groupInfo.button:GetID()
    groupItem.control:addInputEvent("Mouse_LDown", "clickSubButton_Zodiac()")
    groupItem.control:addInputEvent("Mouse_On", "overSubButton_Zodiac(\"" .. parentName .. "\",\"" .. name .. "\",\"" .. ii - 1 .. "\"," .. mainButtonIndex .. ")")
    groupItem.control:addInputEvent("Mouse_Out", "outSubButton_Zodiac(\"" .. ii - 1 .. "\"" .. ")")
  end
end
local function createUI()
  for idx = 1, mainButtonNum do
    if idx ~= 3 then
      mainButtonInfo[idx] = {
        line = UI.createControl(__ePAUIControl_Static, Panel_CustomizationMain, "STATIC_LINE_" .. idx),
        point = UI.createControl(__ePAUIControl_Static, Panel_CustomizationMain, "STATIC_POINT_" .. idx),
        smallPoint = UI.createControl(__ePAUIControl_Static, Panel_CustomizationMain, "STATIC_SMALL_POINT_" .. idx),
        tree = TreeMenu.new_Button("TreeMenu_Button" .. idx, Panel_CustomizationMain),
        static = UI.createControl(__ePAUIControl_Static, Panel_CustomizationMain, "STATIC_IMAGE_" .. idx),
        staticText = UI.createControl(__ePAUIControl_StaticText, Panel_CustomizationMain, "STATICTEXT_MAIN_" .. idx),
        isOpen = true,
        button = nil
      }
      mainButtonInfo[idx].treeItem = mainButtonInfo[idx].tree:getRootItem()
      mainButtonInfo[idx].button = mainButtonInfo[idx].treeItem.control
      CopyBaseProperty(Button_MainButton, mainButtonInfo[idx].button)
      CopyBaseProperty(Static_Large_Point, mainButtonInfo[idx].point)
      CopyBaseProperty(Line_Template, mainButtonInfo[idx].line)
      CopyBaseProperty(Static_Small_Point, mainButtonInfo[idx].smallPoint)
      CopyBaseProperty(staticMainImage[idx], mainButtonInfo[idx].static)
      CopyBaseProperty(StaticText_Main, mainButtonInfo[idx].staticText)
      if false == _ContentsGroup_isConsolePadControl then
        mainButtonInfo[idx].button:addInputEvent("Mouse_On", "overMainButton(" .. idx .. ")")
        mainButtonInfo[idx].button:SetShow(true)
        mainButtonInfo[idx].line:SetShow(true)
        mainButtonInfo[idx].point:SetShow(true)
        mainButtonInfo[idx].smallPoint:SetShow(true)
        mainButtonInfo[idx].staticText:SetText(mainText[idx])
        mainButtonInfo[idx].staticText:SetShow(true)
        if idx == 2 then
          createCustomizationGroup(mainButtonInfo[idx])
        elseif idx == 1 then
          createWeatherGroup(mainButtonInfo[idx])
        elseif idx == 4 then
          createPoseGroup(mainButtonInfo[idx])
        elseif idx == 3 then
        elseif idx == 5 then
          createZodiacGroup(mainButtonInfo[idx], idx)
        end
        mainButtonInfo[idx].tree:collapseAll()
        mainButtonInfo[idx].isOpen = false
      end
      if _ContentsGroup_isConsolePadControl then
        mainButtonInfo[idx].static:SetShow(false)
      end
    end
    staticMainImage[idx]:SetShow(false)
  end
end
local function InitZodiac()
  Static_ZodiacImage:SetShow(false)
  StaticText_ZodiacName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_NONEZODIAC"))
  StaticText_ZodiacDescription:SetText("")
end
local isShow_CustomizationMessage, isShow_CustomizationCloth, isShow_CustomizationMotion, isShow_CustomizationFrame, isShow_CustomizationMain, isShow_CashCustom, isShow_CustomizationStatic, isShow_CustomizingAlbum, isShow_HistoryTable
function TakeScreenShot()
  if screenShotReady == false then
    return
  end
  screenShotReady = false
  screenShotButtonUse = true
  if ToClient_getCaptureUpdateState() then
    return
  end
  isShow_CustomizationMessage = StaticText_CustomizationMessage:GetShow()
  isShow_CustomizationCloth = Panel_CustomizationCloth:GetShow()
  isShow_CustomizationMotion = Panel_CustomizationMotion:GetShow()
  isShow_CustomizationFrame = Panel_CustomizationFrame:GetShow()
  isShow_CustomizationMain = Panel_CustomizationMain:GetShow()
  isShow_CustomizingAlbum = Panel_CustomizingAlbum:GetShow()
  isShow_HistoryTable = historyTableGetShow()
  StaticText_CustomizationMessage:SetShow(false)
  Panel_CustomizationCloth:SetShow(false)
  Panel_CustomizationMotion:SetShow(false)
  Panel_CustomizationFrame:SetShow(false)
  Panel_CustomizationMain:SetShow(false)
  Panel_CustomizingAlbum:SetShow(false)
  historyTableSetShow(false)
  CheckButton_CameraLook:SetShow(false)
  CheckButton_ToggleUi:SetShow(false)
  CheckButton_ImagePreset:SetShow(false)
  Button_ScreenShot:SetShow(false)
  Button_ScreenShotFolder:SetShow(false)
  CheckButton_CameraLook_Title:SetShow(false)
  CheckButton_ToggleUi_Title:SetShow(false)
  CheckButton_ImagePreset_Title:SetShow(false)
  Button_ScreenShot_Title:SetShow(false)
  Button_ScreenShotFolder_Title:SetShow(false)
  if InGameMode then
    Button_ProfileScreenShot:SetShow(false)
    Button_ProfileScreenShot_Title:SetShow(false)
  end
  if true == isDevelopment then
    PaGloabl_RandFaceBoneOpen_DEV_Show(false)
    PaGloabl_CaptureFaceBoneByBeautyAlbum_Show(false)
  end
  if not ToClient_isLobbyProcessor() then
    isShow_CashCustom = Panel_Cash_Customization:GetShow()
    Panel_Cash_Customization:SetShow(false)
  end
  doScreenShot = true
  doScreenShotSub = true
  ToClient_setCaptureUpdateState(true)
end
function TakeFaceScreenShotForRandomFace()
  if false == isDevelopment then
    return
  end
  if screenShotReady == false then
    ToClient_recallFaceCaptureEvent()
    return
  end
  screenShotReady = false
  screenShotButtonUse = true
  local function goShot()
    if ToClient_getCaptureUpdateState() then
      ToClient_recallFaceCaptureEvent()
      return
    end
    isShow_CustomizationMessage = StaticText_CustomizationMessage:GetShow()
    isShow_CustomizationCloth = Panel_CustomizationCloth:GetShow()
    isShow_CustomizationMotion = Panel_CustomizationMotion:GetShow()
    isShow_CustomizationFrame = Panel_CustomizationFrame:GetShow()
    isShow_CustomizationMain = Panel_CustomizationMain:GetShow()
    isShow_CustomizationStatic = Panel_CustomizationStatic:GetShow()
    isShow_CustomizingAlbum = Panel_CustomizingAlbum:GetShow()
    isShow_HistoryTable = historyTableGetShow()
    StaticText_CustomizationMessage:SetShow(false)
    Panel_CustomizationCloth:SetShow(false)
    Panel_CustomizationMotion:SetShow(false)
    Panel_CustomizationFrame:SetShow(false)
    Panel_CustomizationMain:SetShow(false)
    Panel_CustomizingAlbum:SetShow(false)
    Panel_CustomizationMessage:SetShow(false)
    CheckButton_CameraLook:SetShow(false)
    CheckButton_ToggleUi:SetShow(false)
    CheckButton_ImagePreset:SetShow(false)
    Button_ScreenShot:SetShow(false)
    Button_ScreenShotFolder:SetShow(false)
    if InGameMode then
      Button_ProfileScreenShot:SetShow(false)
      Button_ProfileScreenShot_Title:SetShow(false)
    end
    CheckButton_CameraLook_Title:SetShow(false)
    CheckButton_ToggleUi_Title:SetShow(false)
    CheckButton_ImagePreset_Title:SetShow(false)
    Button_ScreenShot_Title:SetShow(false)
    Button_ScreenShotFolder_Title:SetShow(false)
    historyTableSetShow(false)
    if not ToClient_isLobbyProcessor() then
      isShow_CashCustom = Panel_Cash_Customization:GetShow()
      Panel_Cash_Customization:SetShow(false)
    end
    doScreenShotInFrame = true
    doScreenCapture = true
    doScreenShotSub = true
    ToClient_setCaptureUpdateState(true)
    ToClient_UpdateCaptureQuestCondition()
  end
  goShot()
end
function TakeFaceScreenShotByBeautyAlbum(sizeX, sizeY)
  if false == isDevelopment then
    return
  end
  if screenShotReady == false then
    return false
  end
  screenShotReady = false
  screenShotButtonUse = true
  if true == ToClient_getCaptureUpdateState() then
    return false
  end
  isShow_CustomizationMessage = StaticText_CustomizationMessage:GetShow()
  isShow_CustomizationCloth = Panel_CustomizationCloth:GetShow()
  isShow_CustomizationMotion = Panel_CustomizationMotion:GetShow()
  isShow_CustomizationFrame = Panel_CustomizationFrame:GetShow()
  isShow_CustomizationMain = Panel_CustomizationMain:GetShow()
  isShow_CustomizationStatic = Panel_CustomizationStatic:GetShow()
  isShow_CustomizingAlbum = Panel_CustomizingAlbum:GetShow()
  isShow_HistoryTable = historyTableGetShow()
  StaticText_CustomizationMessage:SetShow(false)
  Panel_CustomizationCloth:SetShow(false)
  Panel_CustomizationMotion:SetShow(false)
  Panel_CustomizationFrame:SetShow(false)
  Panel_CustomizationMain:SetShow(false)
  Panel_CustomizingAlbum:SetShow(false)
  Panel_CustomizationMessage:SetShow(false)
  CheckButton_CameraLook:SetShow(false)
  CheckButton_ToggleUi:SetShow(false)
  CheckButton_ImagePreset:SetShow(false)
  Button_ScreenShot:SetShow(false)
  Button_ScreenShotFolder:SetShow(false)
  if true == InGameMode then
    Button_ProfileScreenShot:SetShow(false)
    Button_ProfileScreenShot_Title:SetShow(false)
  end
  if true == isDevelopment then
    PaGloabl_RandFaceBoneOpen_DEV_Show(false)
    PaGloabl_CaptureFaceBoneByBeautyAlbum_Show(false)
  end
  CheckButton_CameraLook_Title:SetShow(false)
  CheckButton_ToggleUi_Title:SetShow(false)
  CheckButton_ImagePreset_Title:SetShow(false)
  Button_ScreenShot_Title:SetShow(false)
  Button_ScreenShotFolder_Title:SetShow(false)
  historyTableSetShow(false)
  if false == ToClient_isLobbyProcessor() then
    isShow_CashCustom = Panel_Cash_Customization:GetShow()
    Panel_Cash_Customization:SetShow(false)
  end
  isFaceScreenShotByBeautyAlbum = true
  faceScreenSizeX = sizeX + 0
  faceScreenSizeY = sizeY + 0
  doScreenShotInFrame = true
  doScreenCapture = true
  doScreenShotSub = true
  if true == MessageBoxGetShow() then
    postProcessMessageData()
  end
  ToClient_setCaptureUpdateState(true)
  return true
end
function TakeFaceScreenShot()
  if screenShotReady == false then
    return
  end
  screenShotReady = false
  screenShotButtonUse = true
  local function goShot()
    if ToClient_getCaptureUpdateState() then
      return
    end
    isShow_CustomizationMessage = StaticText_CustomizationMessage:GetShow()
    isShow_CustomizationCloth = Panel_CustomizationCloth:GetShow()
    isShow_CustomizationMotion = Panel_CustomizationMotion:GetShow()
    isShow_CustomizationFrame = Panel_CustomizationFrame:GetShow()
    isShow_CustomizationMain = Panel_CustomizationMain:GetShow()
    isShow_CustomizationStatic = Panel_CustomizationStatic:GetShow()
    isShow_CustomizingAlbum = Panel_CustomizingAlbum:GetShow()
    isShow_HistoryTable = historyTableGetShow()
    StaticText_CustomizationMessage:SetShow(false)
    Panel_CustomizationCloth:SetShow(false)
    Panel_CustomizationMotion:SetShow(false)
    Panel_CustomizationFrame:SetShow(false)
    Panel_CustomizationMain:SetShow(false)
    Panel_CustomizingAlbum:SetShow(false)
    Panel_CustomizationMessage:SetShow(false)
    CheckButton_CameraLook:SetShow(false)
    CheckButton_ToggleUi:SetShow(false)
    CheckButton_ImagePreset:SetShow(false)
    Button_ScreenShot:SetShow(false)
    Button_ScreenShotFolder:SetShow(false)
    if InGameMode then
      Button_ProfileScreenShot:SetShow(false)
      Button_ProfileScreenShot_Title:SetShow(false)
    end
    CheckButton_CameraLook_Title:SetShow(false)
    CheckButton_ToggleUi_Title:SetShow(false)
    CheckButton_ImagePreset_Title:SetShow(false)
    Button_ScreenShot_Title:SetShow(false)
    Button_ScreenShotFolder_Title:SetShow(false)
    historyTableSetShow(false)
    if not ToClient_isLobbyProcessor() then
      isShow_CashCustom = Panel_Cash_Customization:GetShow()
      Panel_Cash_Customization:SetShow(false)
    end
    doScreenShotInFrame = true
    doScreenCapture = true
    doScreenShotSub = true
    ToClient_setCaptureUpdateState(true)
    ToClient_UpdateCaptureQuestCondition()
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATION_FACEPHOTO_MSGTITLE")
  local _contenet = PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATION_FACEPHOTO_MSGDESC")
  local messageBoxData = {
    title = _title,
    content = _contenet,
    functionYes = goShot,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FGlobal_TakeScreenShotByHotKey()
  if Button_ProfileScreenShot:GetShow() then
    TakeFaceScreenShot()
  end
end
function FGlobal_Customization_UiShow()
  StaticText_CustomizationMessage:SetShow(isShow_CustomizationMessage)
  Panel_CustomizationCloth:SetShow(isShow_CustomizationCloth)
  Panel_CustomizationMotion:SetShow(isShow_CustomizationMotion)
  Panel_CustomizationFrame:SetShow(isShow_CustomizationFrame)
  Panel_CustomizationMain:SetShow(isShow_CustomizationMain)
  Panel_CustomizationStatic:SetShow(isShow_CustomizationStatic)
  Panel_CustomizingAlbum:SetShow(isShow_CustomizingAlbum)
  if not ToClient_isLobbyProcessor() then
    Panel_Cash_Customization:SetShow(isShow_CashCustom)
  end
end
function FGlobal_Customization_UiClose()
  isShow_CustomizationMessage = StaticText_CustomizationMessage:GetShow()
  isShow_CustomizationCloth = Panel_CustomizationCloth:GetShow()
  isShow_CustomizationMotion = Panel_CustomizationMotion:GetShow()
  isShow_CustomizationFrame = Panel_CustomizationFrame:GetShow()
  isShow_CustomizationMain = Panel_CustomizationMain:GetShow()
  isShow_CustomizationStatic = Panel_CustomizationStatic:GetShow()
  isShow_CustomizingAlbum = Panel_CustomizingAlbum:GetShow()
  StaticText_CustomizationMessage:SetShow(false)
  Panel_CustomizationCloth:SetShow(false)
  Panel_CustomizationMotion:SetShow(false)
  Panel_CustomizationFrame:SetShow(false)
  Panel_CustomizationMain:SetShow(false)
  Panel_CustomizationStatic:SetShow(false)
  Panel_CustomizingAlbum:SetShow(false)
  if not ToClient_isLobbyProcessor() then
    isShow_CashCustom = Panel_Cash_Customization:GetShow()
    Panel_Cash_Customization:SetShow(false)
  end
end
local function _takeScreenShot()
  ToClient_Capture()
  Panel_CustomizationCloth:SetShow(isShow_CustomizationCloth)
  Panel_CustomizationMotion:SetShow(isShow_CustomizationMotion)
  Panel_CustomizationFrame:SetShow(isShow_CustomizationFrame)
  Panel_CustomizationMain:SetShow(isShow_CustomizationMain)
  Panel_CustomizingAlbum:SetShow(isShow_CustomizingAlbum)
  Panel_CustomizationStatic:SetShow(true)
  if not ToClient_isLobbyProcessor() then
    Panel_Cash_Customization:SetShow(isShow_CashCustom)
  end
end
local function _takeFaceScreenShot()
  if true == isDevelopment and true == isFaceScreenShotByBeautyAlbum and nil ~= PaGlobalFunc_CreateFaceBoneForDev_CaptureFaceByBeautyAlbum then
    PaGlobalFunc_CreateFaceBoneForDev_CaptureFaceByBeautyAlbum()
  else
    ToClientEnd_CaptureFace()
  end
  if not ToClient_isLobbyProcessor() then
    Panel_Cash_Customization:SetShow(isShow_CashCustom)
  end
end
local function _UIShowInterface()
  StaticText_CustomizationMessage:SetShow(isShow_CustomizationMessage)
  Panel_CustomizationCloth:SetShow(isShow_CustomizationCloth)
  Panel_CustomizationMotion:SetShow(isShow_CustomizationMotion)
  Panel_CustomizationFrame:SetShow(isShow_CustomizationFrame)
  Panel_CustomizationMain:SetShow(isShow_CustomizationMain)
  Panel_CustomizingAlbum:SetShow(isShow_CustomizingAlbum)
  CheckButton_CameraLook:SetShow(true)
  CheckButton_ToggleUi:SetShow(true)
  CheckButton_ImagePreset:SetShow(true)
  Button_ScreenShot:SetShow(true)
  Button_ScreenShotFolder:SetShow(true)
  Button_ProfileScreenShot:SetShow(true)
  Button_ProfileScreenShot_Title:SetShow(true)
  CheckButton_CameraLook_Title:SetShow(true)
  CheckButton_ToggleUi_Title:SetShow(true)
  CheckButton_ImagePreset_Title:SetShow(true)
  Button_ScreenShot_Title:SetShow(true)
  Button_ScreenShotFolder_Title:SetShow(true)
  Panel_CustomizationMessage:SetShow(true)
  isFaceScreenShotByBeautyAlbum = false
end
local timerForSS = 0
local subTime = 0
function OpenScreenShotFolder()
  ToClient_OpenDirectory(CppEnums.OpenDirectoryType.DirectoryType_ScreenShot)
end
function CustomizationStatic_UpdatePerFrame(deltaTime)
  if doScreenShot then
    if timerForSS > 0.3 then
      timerForSS = 0
      doScreenShot = false
      _takeScreenShot()
    else
      timerForSS = timerForSS + deltaTime
    end
  end
  if screenShotButtonUse == true then
    screenShotTime = screenShotTime + deltaTime
    if screenShotTime > 1 then
      screenShotTime = 0
      screenShotReady = true
      screenShotButtonUse = false
    end
  end
  if doScreenShotSub then
    if subTime > 0.5 then
      doScreenShotSub = false
      subTime = 0
      StaticText_CustomizationMessage:SetShow(isShow_CustomizationMessage)
      historyTableSetShow(isShow_HistoryTable)
      CheckButton_CameraLook:SetShow(true)
      CheckButton_ToggleUi:SetShow(true)
      CheckButton_ImagePreset:SetShow(true)
      Button_ScreenShot:SetShow(true)
      Button_ScreenShotFolder:SetShow(true)
      CheckButton_CameraLook_Title:SetShow(true)
      CheckButton_ToggleUi_Title:SetShow(true)
      CheckButton_ImagePreset_Title:SetShow(true)
      Button_ScreenShot_Title:SetShow(true)
      Button_ScreenShotFolder_Title:SetShow(true)
      if InGameMode then
        Button_ProfileScreenShot:SetShow(true)
        Button_ProfileScreenShot_Title:SetShow(true)
      end
      if true == isDevelopment then
        PaGloabl_RandFaceBoneOpen_DEV_Show(true)
        PaGloabl_CaptureFaceBoneByBeautyAlbum_Show(true)
      end
    else
      subTime = subTime + deltaTime
    end
  end
  if doScreenShotInFrame then
    if timerForSS > 0.1 and doScreenCapture == true then
      if true == isDevelopment and true == isFaceScreenShotByBeautyAlbum then
        ToClient_CaptureFaceByBeautyAlbumDev(faceScreenSizeX, faceScreenSizeY)
      else
        ToClient_CaptureFace()
      end
      doScreenCapture = false
      EndScreenCapture = true
    elseif timerForSS > 0.2 and EndScreenCapture == true then
      _takeFaceScreenShot()
      EndScreenCapture = false
    elseif timerForSS > 0.3 then
      timerForSS = 0
      doScreenShotInFrame = false
      _UIShowInterface()
    else
      timerForSS = timerForSS + deltaTime
    end
  end
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_RIGHT) then
    if false == Edit_CharName:GetFocusEdit() and false == FileExplorer_IsOpen() and false == edit_SeasonCharName:GetFocusEdit() then
      customHistoryDo()
    end
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_LEFT) and false == Edit_CharName:GetFocusEdit() and false == FileExplorer_IsOpen() and false == edit_SeasonCharName:GetFocusEdit() then
    customHistoryUnDo()
  end
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_LBUTTON) and true == globalcheckSlider then
    add_CurrentHistory()
    globalcheckSlider = false
  end
end
Panel_CustomizationStatic:RegisterUpdateFunc("CustomizationStatic_UpdatePerFrame")
function MainPanel_UpdatePerFrame(deltaTime)
  if initialized == true then
    for index = 1, mainButtonNum do
      if index ~= 3 then
        mainButtonInfo[index].tree:update()
        local x = mainButtonInfo[index].button:GetPosX() + mainButtonInfo[index].button:GetSizeX() / 2
        local y = mainButtonInfo[index].button:GetPosY() + mainButtonInfo[index].button:GetSizeY() / 2
        local x2 = getMousePosX()
        local y2 = getMousePosY()
        local distance = math.sqrt(math.pow(x - x2, 2) + math.pow(y - y2, 2))
        if true == mainButtonInfo[index].isOpen and distance > 170 then
          mainButtonInfo[index].button:EraseAllEffect()
          mainButtonInfo[index].tree:collapseAll()
          mainButtonInfo[index].isOpen = false
          hideZodiacTooltip()
        end
      end
    end
  end
  if isSubEffectPlay == false then
    if timer > 0.2 then
      isSubEffectPlay = true
      timer = 0
    else
      timer = timer + deltaTime
    end
  end
end
function overToggleButton(name)
  local control = UI.getChildControl(Panel_CustomizationStatic, name)
  control:EraseAllEffect()
  control:AddEffect("UI_Customize_Button01_Mini", false, 0, 0)
  if Button_ProfileScreenShot:GetID() == name then
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATION_FACEPHOTOBUTTON_TOOLTIP")
    TooltipSimple_Show(Button_ProfileScreenShot, desc)
  end
end
function HandleOver_EditOptionTooltip()
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOM_DONTUSE_EDITOPTION")
  desc = ""
  control = btn_Warn
  TooltipSimple_Show(control, name, desc)
end
function clickSubButton()
end
function overSubButton(parent, name)
  if isSubEffectPlay == true then
    local controlParent = UI.getChildControl(Panel_CustomizationMain, parent)
    local control = UI.getChildControl(controlParent, name)
    control:EraseAllEffect()
    control:AddEffect("UI_Customize_Button01_Mini", false, 0, 0)
  end
end
local selected_zodiacIndex
function overSubButton_Zodiac(parent, name, zodiacIndex, mainButtonIndex)
  if false == mainButtonInfo[mainButtonIndex].isOpen then
    return
  end
  selected_zodiacIndex = zodiacIndex
  local zodiacInfo = getZodiac(zodiacIndex)
  local zodiacName = zodiacInfo:getZodiacName()
  Panel_CustomizationMain:SetChildIndex(Static_ZodiacITooltip, 9999)
  Static_ZodiacITooltip:SetText(zodiacName)
  Static_ZodiacITooltip:SetPosX(getMousePosX())
  Static_ZodiacITooltip:SetPosY(getMousePosY() + 30)
  Static_ZodiacITooltip:SetShow(true)
  if isSubEffectPlay == true then
    local controlParent = UI.getChildControl(Panel_CustomizationMain, parent)
    local control = UI.getChildControl(controlParent, name)
    control:EraseAllEffect()
    control:AddEffect("UI_Customize_Button01_Mini", false, 0, 0)
  end
end
function clickSubButton_Zodiac()
end
function outSubButton_Zodiac(zodiacIndex)
  if selected_zodiacIndex == zodiacIndex then
    Static_ZodiacITooltip:SetShow(false)
  end
end
function hideZodiacTooltip()
  Static_ZodiacITooltip:SetShow(false)
end
function overMainButton(idx)
  if mainButtonInfo[idx].isOpen == false then
    mainButtonInfo[idx].tree:update()
    mainButtonInfo[idx].tree:expandAll()
    mainButtonInfo[idx].isOpen = true
    isSubEffectPlay = false
    mainButtonInfo[idx].button:EraseAllEffect()
    mainButtonInfo[idx].button:AddEffect("UI_Customize_Button01", false, 0, 0)
    mainButtonInfo[idx].static:SetAlpha(0.5)
    UIAni.AlphaAnimation(1, mainButtonInfo[idx].static, 0, 0.2)
  end
  for mainIndex = 1, mainButtonNum do
    if mainIndex ~= idx and mainIndex ~= 3 then
      mainButtonInfo[mainIndex].button:EraseAllEffect()
      mainButtonInfo[mainIndex].tree:collapseAll()
      mainButtonInfo[mainIndex].isOpen = false
      mainButtonInfo[idx].static:SetAlpha(1)
      UIAni.AlphaAnimation(0.5, mainButtonInfo[mainIndex].static, 0, 0.2)
    end
  end
end
function mouseOnGroupButton(control)
  control:EraseAllEffect()
  control:AddEffect("UI_Customize_Button01", false, 0, 0)
end
function SetMainButtonPosition(index, x, y, buttonRelativeX, buttonRelativeY)
  if InGameMode == true and index == 5 then
    return
  end
  if index ~= 3 then
    local buttonPosX = buttonRelativeX * getScreenSizeX()
    local buttonPosY = buttonRelativeY * getScreenSizeY()
    if index == 1 then
      x = buttonPosX - 45
      y = buttonPosY - 30
    elseif index == 5 then
      x = buttonPosX - 45
      y = buttonPosY + 30
    end
    offsetX = buttonPosX - x
    offsetY = buttonPosY - y
    local control = mainButtonInfo[index]
    local lineLength = math.sqrt(math.abs(math.pow(x - (offsetX + x), 2)) + math.abs(math.pow(y - (offsetY + y), 2)))
    local angle = math.atan2((offsetX + 0) * -1 - (offsetY + -1) * 0, (offsetX + 0) * 0 + offsetY * -1 * -1)
    control.line:SetRotate(angle)
    if math.abs(angle) > 1.57 then
      control.line:SetPosY(y + offsetY - (lineLength - math.abs(offsetY)) / 2)
    else
      control.line:SetPosY(y - (lineLength - math.abs(offsetY)) / 2)
    end
    control.line:SetPosX(x + offsetX / 2)
    control.line:SetSize(control.line:GetSizeX(), lineLength)
    local nX, nY = rotationPointNormalize(0, -1, angle)
    nX = nX * control.static:GetSizeX() / 2
    nY = nY * control.static:GetSizeY() / 2
    control.button:SetPosX(x + offsetX - control.button:GetSizeX() / 2 + nX)
    control.button:SetPosY(y + offsetY - control.button:GetSizeX() / 2 - nY)
    control.smallPoint:SetPosX(x + offsetX - control.smallPoint:GetSizeX() / 2 + 1)
    control.smallPoint:SetPosY(y + offsetY - control.smallPoint:GetSizeY() / 2)
    control.static:SetPosX(x + offsetX - control.static:GetSizeX() / 2 + nX)
    control.static:SetPosY(y + offsetY - control.static:GetSizeX() / 2 - nY)
    control.point:SetPosX(x - control.point:GetSizeX() / 2)
    control.point:SetPosY(y - control.point:GetSizeY() / 2)
    control.staticText:SetPosX(control.button:GetPosX() + control.button:GetSizeX() / 2 - control.staticText:GetSizeX() / 2)
    control.staticText:SetPosY(control.button:GetPosY() + control.button:GetSizeY())
  end
end
function SelectCustomizationGroup(idx)
  selectCustomizationControlGroup(idx)
  CustomizationMainUIShow(false)
  closeExplorer()
end
function SelectCustomizationVoice()
  CustomizationMainUIShow(false)
  createVoiceList(InGameMode, selectedClassType)
  showVoiceUI(true)
  closeExplorer()
end
function SelectPoseControl(idx)
  selectPoseControl(idx)
  CustomizationMainUIShow(false)
  closeExplorer()
end
function FGlobal_IsInGameMode()
  return InGameMode
end
function InitCustomizationMainUI()
  Panel_CustomizationMain:SetSize(getScreenSizeX(), getScreenSizeY())
  if initialized == false then
    createUI()
    initialized = true
  end
  updateComputePos()
  CreateHistoryButton()
  ClearFocusEdit()
  InitZodiac()
  chracterCraeation_SeasonSetting()
  Edit_CharName:SetMaxInput(getGameServiceTypeCharacterNameLength())
  isValidInputCharacterName = false
  cachedInputCharacterName = ""
  CheckButton_CameraLook:SetCheck(true)
  showAllUI(false)
  HistoryTableOpen()
  if false == ToClient_isLobbyProcessor() then
    PaGlobal_CustomizationIsEditable(ToClient_getCustomizingIsEditable(), ToClient_getOriginalAuthorUserNo())
  end
end
function chracterCraeation_SeasonSetting()
  if false == _ContentsGroup_SeasonContents and false == _ContentsGroup_PreSeason then
    stc_SeasonBg:SetShow(false)
    return
  end
  if nil == FGlobal_getIsSpecialCharacter or nil == PaGlobalFunc_CharacterSelect_All_CanMakeSeason then
    return
  end
  Button_Duplication:SetShow(false)
  Button_Char:SetShow(false)
  Edit_CharName:SetShow(false)
  Static_CharName:SetShow(false)
  StaticText_FamilyName:SetShow(false)
  StaticText_FamilyNameTitle:SetShow(false)
  stc_SeasonBg:SetShow(true)
  btn_duplicate_season:SetShow(true)
  chk_Season:SetCheck(false)
  stc_SeasonBg:ComputePos()
  stc_SeasonArea:ComputePos()
  stc_SeasonTopline:ComputePos()
  stc_SeasonBottomImg:ComputePos()
  txt_SeasonFamilyTitle:ComputePos()
  txt_SeasonFamilyName:ComputePos()
  txt_SeasonCharNameTitle:ComputePos()
  edit_SeasonCharName:ComputePos()
  btn_duplicate_season:ComputePos()
  btn_CreateSeason:ComputePos()
  btn_CreateSeason:addInputEvent("Mouse_LUp", "Panel_CharacterCreateOK_NewCustomization()")
  btn_duplicate_season:addInputEvent("Mouse_LUp", "HandleClicked_DuplicateName()")
  chk_Season:addInputEvent("Mouse_LUp", "PaGlobalFunc_Customization_SeasonBtnTextureChange()")
  PaGlobalFunc_Customization_SeasonBtnTextureChange()
  edit_SeasonCharName:SetMaxInput(getGameServiceTypeCharacterNameLength())
  edit_SeasonCharName:SetEditText("")
  if true == FGlobal_getIsSpecialCharacter() then
    btn_CreateSeason:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATENEWCHARACTER_BTN"))
  else
    btn_CreateSeason:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEASONCONTENTS_CREATECHAR_NOMAL"))
  end
  local canMakeSeason = true == PaGlobalFunc_CharacterSelect_All_CanMakeSeason() and false == FGlobal_getIsSpecialCharacter()
  if nil ~= Panel_Lobby_CheckNotAllowSeasonClassType and true == Panel_Lobby_CheckNotAllowSeasonClassType() then
    canMakeSeason = false
  end
  chk_Season:SetShow(canMakeSeason)
  if true == canMakeSeason then
    stc_SeasonArea:SetSize(stc_SeasonArea:GetSizeX(), originSeasonAreaSizeY + 30)
    stc_SeasonArea:SetSpanSize(stc_SeasonArea:GetSpanSize().x, originSeasonAreaSpan)
    stc_SeasonTopline:SetSpanSize(stc_SeasonTopline:GetSpanSize().x, originToplineSpan)
    stc_SeasonBottomImg:SetSpanSize(stc_SeasonBottomImg:GetSpanSize().x, originBottomlineSpan)
    txt_SeasonFamilyTitle:SetSpanSize(txt_SeasonFamilyTitle:GetSpanSize().x, originFamTitleSpan + 50)
    txt_SeasonFamilyName:SetSpanSize(txt_SeasonFamilyName:GetSpanSize().x, originFamNameSpan + 45)
    txt_SeasonCharNameTitle:SetSpanSize(txt_SeasonCharNameTitle:GetSpanSize().x, originCharTitleSpan + 50)
    edit_SeasonCharName:SetSpanSize(edit_SeasonCharName:GetSpanSize().x, originEditSpan + 50)
    btn_duplicate_season:SetSpanSize(btn_duplicate_season:GetSpanSize().x, originDupBtnSpan)
    btn_CreateSeason:SetSpanSize(btn_CreateSeason:GetSpanSize().x, originBtnSpan)
  else
    stc_SeasonArea:SetSize(stc_SeasonArea:GetSizeX(), originSeasonAreaSizeY)
    stc_SeasonArea:SetSpanSize(stc_SeasonArea:GetSpanSize().x, originSeasonAreaSpan)
    stc_SeasonTopline:SetSpanSize(stc_SeasonTopline:GetSpanSize().x, originToplineSpan)
    stc_SeasonBottomImg:SetSpanSize(stc_SeasonBottomImg:GetSpanSize().x, originBottomlineSpan)
    txt_SeasonFamilyTitle:SetSpanSize(txt_SeasonFamilyTitle:GetSpanSize().x, originFamTitleSpan + 80)
    txt_SeasonFamilyName:SetSpanSize(txt_SeasonFamilyName:GetSpanSize().x, originFamNameSpan + 75)
    txt_SeasonCharNameTitle:SetSpanSize(txt_SeasonCharNameTitle:GetSpanSize().x, originCharTitleSpan + 50)
    edit_SeasonCharName:SetSpanSize(edit_SeasonCharName:GetSpanSize().x, originEditSpan + 50)
    btn_duplicate_season:SetSpanSize(btn_duplicate_season:GetSpanSize().x, originDupBtnSpan)
    btn_CreateSeason:SetSpanSize(btn_CreateSeason:GetSpanSize().x, originBtnSpan)
  end
  txt_SeasonFamilyName:SetText(getFamilyName())
end
function showAllUI(show)
  CheckButton_ToggleUi:SetCheck(show)
  ToggleUi()
  showStaticUI(show)
  CustomizationMain_OpenSeasonBanner(show)
  local loadTempUi = function()
    ToClient_LoadUserTempCustomizationFile()
  end
  if true == show and true == ToClient_IsTempCustomizationFileExist() then
    local _contenet = PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATION_LOADTEMP_MSGDESC")
    local messageBoxData = {
      content = _contenet,
      functionYes = loadTempUi,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
  if not InGameMode then
    SelectZodiac(getRandomValue(0, getZodiacCount() - 1))
  end
  if _ContentsGroup_isConsolePadControl then
    showStaticUI(false)
    CheckButton_ToggleUi:SetShow(false)
    Button_ScreenShot:SetShow(false)
    Button_ScreenShotFolder:SetShow(false)
    Button_ScreenShotFolder_Title:SetShow(false)
    historyTableSetShow(false)
    StaticText_CustomizationMessage:SetShow(false)
    for ii = 1, 5 do
      staticMainImage[ii]:SetShow(false)
    end
    StaticText_AuthorName:SetShow(false)
    StaticText_AuthorTitle:SetShow(false)
    StaticText_CustomizationInfo:SetShow(false)
    Button_SaveHistory:SetShow(false)
    btn_RandomBeauty:SetShow(false)
    Button_SaveCustomization:SetShow(false)
    Button_LoadCustomization:SetShow(false)
    Button_ApplyDefaultCustomization:SetShow(false)
    Button_CustomizingAlbum:SetShow(false)
  end
end
local isShow_WebAlbum = false
function CustomizationMainUIShow(show)
  if false == closeCustomizationMode then
    if show == true then
      Panel_CustomizationMain:SetShow(true)
      Panel_CustomizationMain:SetAlpha(0)
      UIAni.AlphaAnimation(1, Panel_CustomizationMain, 0, 0.2)
      if initialized == true then
        for idx = 1, mainButtonNum do
          if idx ~= 3 then
            UIAni.AlphaAnimation(0.5, mainButtonInfo[idx].static, 0, 0.2)
          end
        end
      end
      if isShow_WebAlbum then
        CustomizingAlbum_Open(true, CppEnums.ClientSceneState.eClientSceneStateType_InGameCustomization)
      end
    else
      local aniInfo = UIAni.AlphaAnimation(0, Panel_CustomizationMain, 0, 0.2)
      aniInfo:SetHideAtEnd(true)
      isShow_WebAlbum = Panel_CustomizingAlbum:GetShow()
      if isShow_WebAlbum then
        CustomizingAlbum_Close()
      end
    end
  end
end
function CameraLookCheck()
  setCharacterLookAtCamera(CheckButton_CameraLook:IsCheck())
end
function CameraLookEnable(lookEnable)
  setCharacterLookAtCamera(lookEnable)
  CheckButton_CameraLook:SetCheck(lookEnable)
end
function PaGlobal_SetCameraLookDisable()
  originCameraLookEnable = CheckButton_CameraLook:IsCheck()
  CameraLookEnable(false)
end
function PaGlobal_SetCameraLookByOrigin()
  CameraLookEnable(originCameraLookEnable)
end
function PaGlobal_SetIgnoreCameraLook(isIgnore)
  if true == isIgnore then
    setCharacterLookAtCamera(false)
    CheckButton_CameraLook:SetCheck(false)
  end
  CheckButton_CameraLook:SetIgnore(isIgnore)
end
local hideUIIndex = 0
function ToggleUi()
  if CheckButton_ToggleUi:IsCheck() then
    StaticText_CustomizationMessage:SetShow(true)
    if 2 == hideUIIndex then
      Panel_CustomizationCloth:SetShow(true)
    elseif 3 == hideUIIndex then
      Panel_CustomizationMotion:SetShow(true)
    elseif 1 == hideUIIndex then
      toggleShowFrameUI(true)
    else
      if InGameMode == true and Panel_Cash_Customization:IsShow() == false then
        CashCustomization_Open()
      end
      Panel_CustomizationMain:SetShow(true)
      Panel_CustomizationMain:SetAlpha(0)
      UIAni.AlphaAnimation(1, Panel_CustomizationMain, 0, 0.2)
      for idx = 1, mainButtonNum do
        if idx ~= 3 then
          UIAni.AlphaAnimation(0.5, mainButtonInfo[idx].static, 0, 0.2)
        end
      end
    end
    if false == isFristAddHistory then
      historyInit()
      add_CurrentHistory()
      isFristAddHistory = true
    end
    historyTableSetShow(true)
    hideUIIndex = 0
  else
    StaticText_CustomizationMessage:SetShow(false)
    if Panel_CustomizationCloth:GetShow() then
      Panel_CustomizationCloth:SetShow(false)
      hideUIIndex = 2
    elseif Panel_CustomizationMotion:GetShow() then
      Panel_CustomizationMotion:SetShow(false)
      hideUIIndex = 3
    elseif Panel_CustomizationFrame:GetShow() then
      toggleShowFrameUI(false)
      hideUIIndex = 1
    else
      local aniInfo = UIAni.AlphaAnimation(0, Panel_CustomizationMain, 0, 0.2)
      aniInfo:SetHideAtEnd(true)
      hideUIIndex = 0
    end
    historyTableSetShow(false)
  end
end
function ToggleImageUI()
  if Panel_CustomizationImage:IsShow() then
    CloseTextureUi()
  else
    OpenTextureUi()
  end
end
function initToggleIndex()
  if true == _ContentsGroup_RgbUIPick and nil ~= Panel_Window_ColorPalette_All and true == Panel_Window_ColorPalette_All:IsShow() then
    PaGlobal_ColorPalette_All_Close()
    return
  end
  if true == FGlobal_ScreenShotFrame_IsShow() then
    return
  end
  if Panel_CustomizationImage:IsShow() then
    CloseTextureUi()
  end
  hideUIIndex = 0
  CheckButton_ToggleUi:SetCheck(true)
  StaticText_CustomizationMessage:SetShow(true)
  Panel_CustomizationMain:SetShow(true)
  historyTableSetShow(true)
end
function showStaticUI(show)
  if show == true then
    Panel_CustomizationStatic:SetShow(true, false)
    CheckButton_CameraLook:SetShow(true)
    CheckButton_CameraLook:SetAlpha(0)
    UIAni.AlphaAnimation(1, CheckButton_CameraLook, 0, 0.2)
    CheckButton_ToggleUi:SetShow(true)
    CheckButton_ToggleUi:SetAlpha(0)
    UIAni.AlphaAnimation(1, CheckButton_ToggleUi, 0, 0.2)
    Button_ScreenShot:SetShow(isShowScreenShot)
    Button_ScreenShot:SetAlpha(0)
    UIAni.AlphaAnimation(1, Button_ScreenShot, 0, 0.2)
    Button_ScreenShotFolder:SetShow(isShowScreenShot)
    Button_ScreenShotFolder:SetAlpha(0)
    UIAni.AlphaAnimation(1, Button_ScreenShotFolder, 0, 0.2)
    CheckButton_CameraLook_Title:SetShow(true)
    CheckButton_CameraLook_Title:SetAlpha(0)
    UIAni.AlphaAnimation(1, CheckButton_CameraLook_Title, 0, 0.2)
    CheckButton_ToggleUi_Title:SetShow(true)
    CheckButton_ToggleUi_Title:SetAlpha(0)
    UIAni.AlphaAnimation(1, CheckButton_ToggleUi_Title, 0, 0.2)
    Button_ScreenShot_Title:SetShow(isShowScreenShot)
    Button_ScreenShot_Title:SetAlpha(0)
    UIAni.AlphaAnimation(1, Button_ScreenShot_Title, 0, 0.2)
    Button_ScreenShotFolder_Title:SetShow(isShowScreenShot)
    Button_ScreenShotFolder_Title:SetAlpha(0)
    UIAni.AlphaAnimation(1, Button_ScreenShotFolder_Title, 0, 0.2)
  else
    local aniInfo_cam = UIAni.AlphaAnimation(0, CheckButton_CameraLook, 0, 0.2)
    aniInfo_cam:SetHideAtEnd(true)
    local aniInfo_ui = UIAni.AlphaAnimation(0, CheckButton_ToggleUi, 0, 0.2)
    aniInfo_ui:SetHideAtEnd(true)
    local aniInfo_ScreenShot = UIAni.AlphaAnimation(0, Button_ScreenShot, 0, 0.2)
    aniInfo_ui:SetHideAtEnd(true)
    local aniInfo_ScreenShotFolder = UIAni.AlphaAnimation(0, Button_ScreenShotFolder, 0, 0.2)
    aniInfo_ui:SetHideAtEnd(true)
    local aniInfo_ScreenShotFolder = UIAni.AlphaAnimation(0, Button_ScreenShotFolder_Title, 0, 0.2)
    aniInfo_ui:SetHideAtEnd(true)
    local aniInfo_cam_Title = UIAni.AlphaAnimation(0, CheckButton_CameraLook_Title, 0, 0.2)
    aniInfo_cam_Title:SetHideAtEnd(true)
    local aniInfo_ui_Title = UIAni.AlphaAnimation(0, CheckButton_ToggleUi_Title, 0, 0.2)
    aniInfo_ui_Title:SetHideAtEnd(true)
    local aniInfo_ScreenShot_Title = UIAni.AlphaAnimation(0, Button_ScreenShot_Title, 0, 0.2)
    aniInfo_ui_Title:SetHideAtEnd(true)
    local aniInfo_ScreenShotFolder_Title = UIAni.AlphaAnimation(0, CheckButton_ToggleUi, 0, 0.2)
    aniInfo_ui_Title:SetHideAtEnd(true)
  end
end
local currentCameraIndex = -1
function SetPresetCamNext()
end
function SetPresetCam(index)
end
function SetPresetCamText(index)
  if -1 == index then
    CheckButton_ImagePreset:SetText("user")
  elseif 0 == index then
    CheckButton_ImagePreset:SetText("cam 1")
  elseif 1 == index then
    CheckButton_ImagePreset:SetText("cam 2")
  elseif 2 == index then
    CheckButton_ImagePreset:SetText("cam 3")
  elseif 3 == index then
    CheckButton_ImagePreset:SetText("cam 4")
  elseif 4 == index then
    CheckButton_ImagePreset:SetText("freecam")
  end
end
function CustomizationMessage(message)
  if message ~= nil then
    StaticText_CustomizationMessage:SetText(message)
    StaticText_CustomizationMessage:SetSize(StaticText_CustomizationMessage:GetTextSizeX() + 10 + StaticText_CustomizationMessage:GetSpanSize().x, StaticText_CustomizationMessage:GetTextSizeY() + 5)
    StaticText_CustomizationMessage:SetSpanSize(0, 0)
    StaticText_CustomizationMessage:SetShow(true)
  else
    StaticText_CustomizationMessage:SetText("")
    StaticText_CustomizationMessage:SetShow(false)
  end
end
function CreateHistoryButton()
  if false == _ContentsGroup_isConsolePadControl then
    for _, v in pairs(historyButtons) do
      v:SetShow(false)
      UI.deleteControl(v)
    end
    historyButtons = {}
    local count = getHistoryCount()
    for index = 0, 9 do
      local tempButton = UI.createControl(__ePAUIControl_Button, Panel_CustomizationMain, "BT_HISTORY_" .. index)
      local PosX = Button_SaveHistory:GetPosX()
      local PosY = Button_SaveHistory:GetPosY()
      CopyBaseProperty(RadioButton_HistoryTemp, tempButton)
      tempButton:SetPosX(PosX + Button_SaveHistory:GetSizeX() + 10 + (tempButton:GetSizeX() + 2) * index)
      tempButton:SetPosY(PosY)
      tempButton:SetShow(true)
      if _ContentsGroup_isConsolePadControl then
        tempButton:SetShow(false)
      end
      if index < count then
        tempButton:addInputEvent("Mouse_LUp", "HandleClicked_ApplyHistory(" .. index .. ")")
      else
        local x1, y1, x2, y2 = setTextureUV_Func(tempButton, 124, 1, 153, 30)
        tempButton:getBaseTexture():setUV(x1, y1, x2, y2)
        tempButton:setRenderTexture(tempButton:getBaseTexture())
        tempButton:SetIgnore(true)
      end
      historyButtons[index + 1] = tempButton
    end
  end
end
local historyIndex = 0
function HandleClicked_ApplyHistory(index)
  historyIndex = index
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATION_MESSAGEBOX_APPLY")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = ApplyHistory,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function ApplyHistory()
  applyHistory(historyIndex)
end
function CustomizationAddHistory()
  addHistory()
  CreateHistoryButton()
end
function HandleClicked_CustomizationAddHistory()
  if getHistoryCount() > 9 then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATION_MESSAGEBOX_ADD_PRESET")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = CustomizationAddHistory,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    CustomizationAddHistory()
  end
end
function HandleClicked_DuplicateName()
  local isSeason = false
  if false == _ContentsGroup_SeasonContents and false == _ContentsGroup_PreSeason then
    isSeason = false
  else
    isSeason = true
  end
  local userInput = ""
  if true == isSeason then
    userInput = edit_SeasonCharName:GetEditText()
  else
    userInput = Edit_CharName:GetEditText()
  end
  if "" == userInput then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_TITLE_CHARACTER"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMAIZATION_CHARACTER_NAME_MESSAGE"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  ToClient_CheckOverlapChangeName(userInput, 0, true)
end
function CloseCharacterCustomization()
  closeCustomizationMode = true
  CheckButton_ToggleUi:SetCheck(false)
  if Panel_CustomizationCloth:GetShow() then
    closeClothUI()
  elseif Panel_CustomizationMotion:GetShow() then
    closeMotionUi()
  elseif Panel_CustomizationFrame:GetShow() then
    CloseFrame()
  end
  Panel_CustomizationMain:SetShow(false)
  PaGlobalFunc_Customization_ResetUrlRandBeauty()
  historyTableClose()
  isFristAddHistory = false
end
function ShowCharacterCustomization(customizationData, classIndex, isInGame)
  closeCustomizationMode = false
  InGameMode = isInGame
  _classIndex = classIndex
  ToClient_clear_DoUnDoHistory()
  if isInGame == true then
    mainButtonNum = 4
    Button_Duplication:SetShow(false)
    Button_Char:SetShow(false)
    Button_SelectClass:SetShow(false)
    Button_Back:SetShow(false)
    btn_CharacterNameCreateRule:SetShow(false)
    btn_RandomBeauty:SetShow(_ContentsGroup_webAlbumOpen)
    Static_CharName:SetShow(false)
    Edit_CharName:SetShow(false)
    staticMainImage[5]:SetShow(false)
    StaticText_Zodiac:SetShow(false)
    Static_ZodiacImage:SetShow(false)
    StaticText_ZodiacName:SetShow(false)
    StaticText_ZodiacDescription:SetShow(false)
    Static_ZodiacIcon:SetShow(false)
    Static_ZodiacITooltip:SetShow(false)
    StaticText_FamilyNameTitle:SetShow(false)
    StaticText_FamilyName:SetShow(false)
    link1:SetShow(false)
    link2:SetShow(false)
    japanEventBanner:SetShow(false)
    Button_ProfileScreenShot:SetShow(true)
    Button_ProfileScreenShot_Title:SetShow(true)
    if true == isDevelopment then
      PaGloabl_RandFaceBoneOpen_DEV_Show(true)
      PaGloabl_CaptureFaceBoneByBeautyAlbum_Show(true)
    end
  else
    mainButtonNum = 5
    Button_Duplication:SetShow(true)
    Button_Char:SetShow(true)
    Button_SelectClass:SetShow(true)
    Button_Back:SetShow(true)
    btn_CharacterNameCreateRule:SetShow(true)
    btn_RandomBeauty:SetShow(_ContentsGroup_webAlbumOpen)
    Static_CharName:SetShow(true)
    Edit_CharName:SetShow(true)
    StaticText_Zodiac:SetShow(true)
    Static_ZodiacImage:SetShow(true)
    StaticText_ZodiacName:SetShow(true)
    StaticText_ZodiacDescription:SetShow(true)
    StaticText_FamilyNameTitle:SetShow(true)
    StaticText_FamilyName:SetShow(true)
    Button_ProfileScreenShot:SetShow(false)
    Button_ProfileScreenShot_Title:SetShow(false)
    if true == isDevelopment then
      PaGloabl_RandFaceBoneOpen_DEV_Show(false)
      PaGloabl_CaptureFaceBoneByBeautyAlbum_Show(false)
    end
    local usingClassPic = {
      [__eClassType_Warrior] = true,
      [__eClassType_ElfRanger] = true,
      [__eClassType_Sorcerer] = true,
      [__eClassType_Giant] = true,
      [__eClassType_Tamer] = true,
      [__eClassType_ShyWaman] = false,
      [__eClassType_ShyMan] = false,
      [__eClassType_BladeMaster] = true,
      [__eClassType_BladeMasterWoman] = true,
      [__eClassType_Valkyrie] = true,
      [__eClassType_Kunoichi] = true,
      [__eClassType_NinjaMan] = true,
      [__eClassType_DarkElf] = false,
      [__eClassType_WizardMan] = true,
      [__eClassType_KunoichiOld] = false,
      [__eClassType_WizardWoman] = true,
      [__eClassType_Guardian] = false
    }
    if isGameTypeEnglish() and getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_Pre then
      link1:SetShow(true)
      link2:SetShow(true)
    elseif false then
      if true == usingClassPic[classIndex] then
        japanEventBanner:ChangeTextureInfoName("New_UI_Common_forLua/Window/Lobby/Customize_EventBanner_" .. classIndex .. ".dds")
        local x1, y1, x2, y2 = setTextureUV_Func(japanEventBanner, 2, 2, 342, 158)
        japanEventBanner:getBaseTexture():setUV(x1, y1, x2, y2)
        japanEventBanner:setRenderTexture(japanEventBanner:getBaseTexture())
        japanEventBanner:ChangeOnTextureInfoName("New_UI_Common_forLua/Window/Lobby/Customize_EventBanner_" .. classIndex .. ".dds")
        x1, y1, x2, y2 = setTextureUV_Func(japanEventBanner, 2, 161, 342, 317)
        japanEventBanner:getOnTexture():setUV(x1, y1, x2, y2)
        japanEventBanner:ChangeClickTextureInfoName("New_UI_Common_forLua/Window/Lobby/Customize_EventBanner_" .. classIndex .. ".dds")
        x1, y1, x2, y2 = setTextureUV_Func(japanEventBanner, 2, 320, 342, 476)
        japanEventBanner:getClickTexture():setUV(x1, y1, x2, y2)
        japanEventBanner:SetShow(true)
      else
        japanEventBanner:SetShow(false)
      end
    end
  end
  if (isGameTypeEnglish() or isGameTypeTaiwan() or isGameTypeGT() or isGameTypeTR() or isGameTypeTH() or isGameTypeID()) and not isInGame then
    btn_CharacterNameCreateRule:SetShow(true)
  else
    btn_CharacterNameCreateRule:SetShow(false)
  end
  InitializeCustomizationData(customizationData, classIndex)
  if false == _ContentsGroup_RenewUI_Customization then
    Panel_CustomizationMessage:SetShow(true, false)
  end
  InitCustomizationMainUI()
  StaticText_CustomizationInfo:SetShow(true)
  StaticText_AuthorName:SetShow(true)
  StaticText_AuthorTitle:SetShow(true)
end
function CustomizationMain_OpenSeasonBanner(isShow)
  if false == isShow then
    return
  end
  if nil ~= PaGlobalFunc_CharacterSelect_All_CanMakeSeason and false == PaGlobalFunc_CharacterSelect_All_CanMakeSeason() then
    return
  end
  if nil ~= FGlobal_getIsSpecialCharacter and true == FGlobal_getIsSpecialCharacter() then
    return
  end
  if true == showSeasonBanner then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
  if (1 == userType or 2 == userType) and nil ~= PaGlobalFunc_SeasonBanner_Open then
    PaGlobalFunc_SeasonBanner_Open()
    showSeasonBanner = true
  end
end
function HandleClicked_NationalOption(isType)
  local linkURL = ""
  if 0 == isType then
    if isGameTypeTH() then
      linkURL = "https://www.th.playblackdesert.com/Intro/Event/CBT_Signup"
    else
      linkURL = "https://www.sea.playblackdesert.com/Intro/Event/CBT_Signup"
    end
  elseif 1 == isType then
    if isGameTypeTH() then
      linkURL = "https://payment.th.playblackdesert.com/Pay/PackageAcoin"
    else
      linkURL = "https://payment.sea.playblackdesert.com/Pay/PackageAcoin"
    end
  end
  ToClient_OpenChargeWebPage(linkURL, false)
end
function HandleClicked_JapanEventExecute()
  applyPreSetCustomizationParams()
end
function EventApplyDefaultParams()
  applyDefaultCustomizationParams()
end
function EventSelectClass()
  restoreUIScale()
  if true == _ContentsGroup_RenewUI_Customization then
    PaGlobalFunc_Customization_Close()
  end
  PaGlobalFunc_Customization_ResetUrlRandBeauty()
  changeCreateCharacterMode_SelectClass(FGlobal_getIsSpecialCharacter())
  ToClient_DeleteCustomizationTempData()
end
function EventSelectBack()
  if true == _ContentsGroup_RemasterUI_Lobby then
    showAllUI(false)
  end
  PaGlobalFunc_Customization_ResetUrlRandBeauty()
  showStaticUI(false)
  Panel_CustomizationMain:SetShow(false)
  restoreUIScale()
  characterCreateCancel(FGlobal_getIsSpecialCharacter())
  ToClient_clear_DoUnDoHistory()
  ToClient_DeleteCustomizationTempData()
end
function HandleClicked_CustomizationMain_applyDefaultCustomizationParams()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATION_MSGBOX_APPLYDEFAULTPARAMS")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = EventApplyDefaultParams,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleClicked_CustomizationMain_SelectClass()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATION_MSGBOX_CANCEL")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = EventSelectClass,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  closeExplorer()
  Panel_CustomizingAlbum:SetShow(false)
end
function HandleClicked_CustomizationMain_Back()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATION_MSGBOX_CANCEL")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = EventSelectBack,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  closeExplorer()
  Panel_CustomizingAlbum:SetShow(false)
end
function HandleClicked_saveCustomizationData()
  OpenExplorerSaveCustomizing()
end
function HandleClicked_RuleShow()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_EN")
  if isGameTypeTR() then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_TR")
  elseif isGameTypeTH() then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_TH")
  elseif isGameTypeID() then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_ID")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "COMMON_CHARACTERCREATEPOLICY_TITLE_EN"),
    content = messageBoxMemo,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "top")
end
function HandleClicked_RandomBeautyMSG()
  if ToClient_isUserCreateContentsAllowed() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATION_MAIN_RANDOMBEAUTY_MSG")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = HandleClicked_RandomBeauty,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    ToClient_showPrivilegeError()
  end
end
function HandleClicked_RandomBeauty()
  local sizeX = getScreenSizeX()
  local sizeY = getScreenSizeY()
  _web_RandomBeauty:SetIgnore(true)
  _web_RandomBeauty:SetPosX(-1500)
  _web_RandomBeauty:SetPosY(-1500)
  _web_RandomBeauty:SetSize(1, 1)
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = PaGlobal_URL_Check(worldNo)
  local userNo = 0
  local userNickName = ""
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local classType = getSelfPlayer():getClassType()
  local isGm = ToClient_SelfPlayerIsGM()
  if ToClient_isLobbyProcessor() then
    userNickName = getFamilyName()
    userNo = getUserNoByLobby()
  else
    userNickName = getSelfPlayer():getUserNickname()
    userNo = getSelfPlayer():get():getUserNo()
  end
  url = url .. "/customizing?userNo=" .. tostring(userNo) .. "&userNickname=" .. tostring(userNickName) .. "&certKey=" .. tostring(cryptKey) .. "&classType=" .. tostring(classType) .. "&isCustomizationMode=" .. tostring(true) .. "&isGm=" .. tostring(isGm) .. "&isRandom=" .. tostring(true)
  _web_RandomBeauty:SetUrl(1, 1, url, false, true)
end
function HandleClicked_loadCustomizationData()
  OpenExplorerLoadCustomizing()
end
function CustomizationAuthorName(authorName)
  if nil == authorName then
    StaticText_AuthorName:SetText("-")
  else
    StaticText_AuthorName:SetText(authorName)
  end
end
function FromClient_CustomizationIsEditable(isEditable)
  PaGlobal_CustomizationIsEditable(isEditable, ToClient_getOriginalAuthorUserNoTmp())
end
function PaGlobal_CustomizationIsEditable(isEditable, authorUserNo)
  local setIgnore = not isEditable
  local selfplayerUserNo = 0
  if true == ToClient_isLobbyProcessor() then
    selfplayerUserNo = getUserNoByLobby()
  else
    selfplayerUserNo = getSelfPlayer():get():getUserNo()
  end
  if false == isEditable and (selfplayerUserNo == authorUserNo or Defines.s64_const.s64_m1 == authorUserNo) then
    setIgnore = false
  end
  if Defines.s64_const.s64_m1 == authorUserNo then
    local warnPosX = StaticText_AuthorName:GetPosX() + StaticText_AuthorName:GetTextSizeX()
    local warnPosY = StaticText_AuthorName:GetPosY() - 5
    btn_Warn:SetPosX(warnPosX)
    btn_Warn:SetPosY(warnPosY)
    btn_Warn:SetShow(true)
  else
    btn_Warn:SetShow(false)
  end
  local custiomizingIdx = 2
  if false == _ContentsGroup_isConsolePadControl then
    if nil == mainButtonInfo[custiomizingIdx] then
      return
    end
    mainButtonInfo[custiomizingIdx].button:SetIgnore(setIgnore)
    if true == setIgnore then
      mainButtonInfo[custiomizingIdx].staticText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATION_NOEDIT"))
    else
      mainButtonInfo[custiomizingIdx].staticText:SetText(mainText[custiomizingIdx])
    end
  else
  end
end
function isShowCustomizationMain()
  return Panel_CustomizationMain:GetShow()
end
function CustomizationMain_PanelResize_ByFontSize()
  StaticText_CustomizationInfo:SetSize(math.max(210, StaticText_CustomizationInfo:GetTextSizeX() + 10), StaticText_CustomizationInfo:GetSizeY())
  Button_SaveHistory:SetTextMode(__eTextMode_Limit_AutoWrap)
  Button_SaveCustomization:SetTextMode(__eTextMode_Limit_AutoWrap)
  Button_LoadCustomization:SetTextMode(__eTextMode_Limit_AutoWrap)
  Button_ApplyDefaultCustomization:SetTextMode(__eTextMode_Limit_AutoWrap)
  Button_SaveHistory:SetText(Button_SaveHistory:GetText())
  Button_SaveCustomization:SetText(Button_SaveCustomization:GetText())
  Button_LoadCustomization:SetText(Button_LoadCustomization:GetText())
  Button_ApplyDefaultCustomization:SetText(Button_ApplyDefaultCustomization:GetText())
  Button_SaveHistory:addInputEvent("Mouse_On", "CustomizationMain_ButtonTooltip(" .. 0 .. ")")
  Button_SaveHistory:addInputEvent("Mouse_Out", "CustomizationMain_ButtonTooltip()")
  Button_SaveCustomization:addInputEvent("Mouse_On", "CustomizationMain_ButtonTooltip(" .. 1 .. ")")
  Button_SaveCustomization:addInputEvent("Mouse_Out", "CustomizationMain_ButtonTooltip()")
  Button_LoadCustomization:addInputEvent("Mouse_On", "CustomizationMain_ButtonTooltip(" .. 2 .. ")")
  Button_LoadCustomization:addInputEvent("Mouse_Out", "CustomizationMain_ButtonTooltip()")
  Button_ApplyDefaultCustomization:addInputEvent("Mouse_On", "CustomizationMain_ButtonTooltip(" .. 3 .. ")")
  Button_ApplyDefaultCustomization:addInputEvent("Mouse_Out", "CustomizationMain_ButtonTooltip()")
end
function CustomizationMain_ButtonTooltip(_type)
  if nil == _type then
    TooltipSimple_Hide()
    return
  end
  local uiControl, name, desc
  desc = ""
  if 0 == _type then
    uiControl = Button_SaveHistory
    name = Button_SaveHistory:GetText()
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERCREATION_MAIN_BUTTON_SAVEHISTORY_DESC")
  elseif 1 == _type then
    uiControl = Button_SaveCustomization
    name = Button_SaveCustomization:GetText()
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERCREATION_MAIN_BUTTON_SAVECUSTOMIZATION_DESC")
  elseif 2 == _type then
    uiControl = Button_LoadCustomization
    name = Button_LoadCustomization:GetText()
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERCREATION_MAIN_BUTTON_LOADCUSTOMIZATION_DESC")
  elseif 3 == _type then
    uiControl = Button_ApplyDefaultCustomization
    name = Button_ApplyDefaultCustomization:GetText()
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_APPLYDEFAULTCUSTOMIZATION_DESC")
  end
  TooltipSimple_Show(uiControl, name, desc)
end
CustomizationMain_PanelResize_ByFontSize()
function FromClient_CustomizationHistoryApplyUpdate()
  HairShapeHistoryApplyUpdate()
  MeshHistoryApplyUpdate()
  BodyBoneHistoryApplyUpdate()
  CommonDecorationHistoryApplyUpdate()
  FaceBoneHistoryApplyUpdate()
  SkinHistoryApplyUpdate()
end
function FromClient_customzationGamePadInput(currentScene, moveScene)
  if CppEnums.CountryType.DEV == getGameServiceType() then
    if currentScene == 1 then
      if moveScene == true then
      elseif moveScene == false then
      end
    elseif currentScene == 2 then
      if moveScene == true then
        changeCreateCharacterMode()
      elseif moveScene == false then
        Panel_CharacterCreateCancel()
      end
    elseif currentScene ~= 3 or moveScene == true then
    elseif moveScene == false then
      HandleClicked_CustomizationMain_SelectClass()
    end
  end
end
function FromClient_VaildCheckResultForCharacterName(type, isCreate, isPossible)
  if 0 ~= type or false == isCreate then
    return
  end
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_NAMECHANGE_TITLE_CHARACTER")
  local messageBoxMemo = ""
  if true == isPossible then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DUPLICATIONNAME_CREATE_POSSIBLE")
    local isSeason = false
    if false == _ContentsGroup_SeasonContents and false == _ContentsGroup_PreSeason then
      isSeason = false
    else
      isSeason = true
    end
    if true == isSeason then
      cachedInputCharacterName = edit_SeasonCharName:GetEditText()
    else
      cachedInputCharacterName = Edit_CharName:GetEditText()
    end
    isValidInputCharacterName = true
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DUPLICATIONNAME_CREATE_IMPOSSIBLE")
    cachedInputCharacterName = ""
    isValidInputCharacterName = false
  end
  local messageBoxData = {
    title = msgTitle,
    content = messageBoxMemo,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_Customization_GetCheckedValidUserInputCharNameString()
  return cachedInputCharacterName
end
function PaGlobalFunc_Customization_GetIsValidUserInputCharNameString()
  return isValidInputCharacterName
end
function PaGlobalFunc_Customization_SetSeasonBtnShow(set)
  if false == _ContentsGroup_SeasonContents and false == _ContentsGroup_PreSeason then
    return
  end
end
function PaGlobalFunc_Customization_SeasonBtnTextureChange()
  if false == _ContentsGroup_SeasonContents and false == _ContentsGroup_PreSeason then
    return
  end
  btn_CreateSeason:ChangeTextureInfoName("renewal/pcremaster/remaster_common_00.dds")
  local x1, y1, x2, y2 = 0, 0, 0, 0
  local on1, on2, on3, on4 = 0, 0, 0, 0
  local click1, click2, click3, click4 = 0, 0, 0, 0
  if true == chk_Season:IsCheck() then
    x1, y1, x2, y2 = setTextureUV_Func(btn_CreateSeason, 165, 63, 205, 103)
    on1, on2, on3, on4 = setTextureUV_Func(btn_CreateSeason, 206, 63, 246, 103)
    click1, click2, click3, click4 = setTextureUV_Func(btn_CreateSeason, 247, 63, 287, 103)
    btn_CreateSeason:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEASONCONTENTS_CREATECHAR_SEASON"))
  else
    x1, y1, x2, y2 = setTextureUV_Func(btn_CreateSeason, 1, 22, 41, 62)
    on1, on2, on3, on4 = setTextureUV_Func(btn_CreateSeason, 42, 22, 82, 62)
    click1, click2, click3, click4 = setTextureUV_Func(btn_CreateSeason, 83, 22, 123, 62)
    btn_CreateSeason:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEASONCONTENTS_CREATECHAR_NOMAL"))
  end
  btn_CreateSeason:getBaseTexture():setUV(x1, y1, x2, y2)
  btn_CreateSeason:setRenderTexture(btn_CreateSeason:getBaseTexture())
  btn_CreateSeason:getOnTexture():setUV(on1, on2, on3, on4)
  btn_CreateSeason:getClickTexture():setUV(click1, click2, click3, click4)
end
function PaGlobalFunc_Customization_IsSeasonBtnClick()
  if false == _ContentsGroup_SeasonContents and false == _ContentsGroup_PreSeason then
    return false
  end
  return chk_Season:IsCheck()
end
function PaGlobalFunc_Customization_SetSeasonCharacter()
  if false == _ContentsGroup_SeasonContents and false == _ContentsGroup_PreSeason then
    return false
  end
  if false == chk_Season:GetShow() then
    return
  end
  chk_Season:SetCheck(true)
  PaGlobalFunc_Customization_SeasonBtnTextureChange()
end
function PaGlobalFunc_Customization_GetEditName()
  if false == _ContentsGroup_SeasonContents and false == _ContentsGroup_PreSeason then
    return ""
  end
  return edit_SeasonCharName:GetEditText()
end
function PaGlobalFunc_Customization_ResetUrlRandBeauty()
  if nil ~= _web_RandomBeauty then
    _web_RandomBeauty:ResetUrl()
  end
end
registerEvent("FromClient_customzationGamePadInput", "FromClient_customzationGamePadInput")
registerEvent("FromClient_notifyChangeNameResult", "FromClient_VaildCheckResultForCharacterName")
