function PaGlobal_FriendInfoList_All:initialize()
  if true == PaGlobal_FriendInfoList_All._initialize then
    return
  end
  PaGlobal_FriendInfoList_All._ui.stc_PartLine = UI.getChildControl(Panel_FriendInfoList_All, "Static_PartLine")
  PaGlobal_FriendInfoList_All._ui.btn_Close = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_PartLine, "Button_Close_PCUI")
  PaGlobal_FriendInfoList_All._ui.btn_Question = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_PartLine, "Button_Question_PCUI")
  PaGlobal_FriendInfoList_All._ui.list2_Friend = UI.getChildControl(Panel_FriendInfoList_All, "List2_Friend")
  PaGlobal_FriendInfoList_All._ui.stc_AddGroup = UI.getChildControl(Panel_FriendInfoList_All, "Static_AddGroup")
  PaGlobal_FriendInfoList_All._ui.btn_AddFriend = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_AddGroup, "Button_AddFriend_PCUI")
  PaGlobal_FriendInfoList_All._ui.btn_AddGroup = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_AddGroup, "Button_AddGroup_PCUI")
  PaGlobal_FriendInfoList_All._ui.btn_Request = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_AddGroup, "Button_Offer_PCUI")
  PaGlobal_FriendInfoList_All._ui.stc_SoundOptionBg = UI.getChildControl(Panel_FriendInfoList_All, "Static_SoundOptionBg_PCUI")
  PaGlobal_FriendInfoList_All._ui.btn_Sound = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_SoundOptionBg, "CheckButton_Sound_PCUI")
  PaGlobal_FriendInfoList_All._ui.btn_Effect = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_SoundOptionBg, "CheckButton_Effect_PCUI")
  PaGlobal_FriendInfoList_All._ui.btn_ScaleResize = UI.getChildControl(Panel_FriendInfoList_All, "Button_ScaleResize")
  PaGlobal_FriendInfoList_All._ui.stc_XBFunctionBG = UI.getChildControl(Panel_FriendInfoList_All, "Static_Function_BG_1")
  PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionBG = UI.getChildControl(Panel_FriendInfoList_All, "Static_Function_BG_2")
  PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionBG = UI.getChildControl(Panel_FriendInfoList_All, "Static_Function_BG_3")
  PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionBG = UI.getChildControl(Panel_FriendInfoList_All, "Static_Function_BG_4")
  PaGlobal_FriendInfoList_All._ui.stc_Function = UI.getChildControl(Panel_FriendInfoList_All, "Style_Function")
  PaGlobal_FriendInfoList_All._ui.stc_Emoticon_BG = UI.getChildControl(Panel_FriendInfoList_All, "Static_Emoticon_BG")
  PaGlobal_FriendInfoList_All._ui.stc_Chat_TitleBar = UI.getChildControl(Panel_FriendInfoList_All, "Static_Chat_TitleBar")
  PaGlobal_FriendInfoList_All._ui.btn_Back = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_Chat_TitleBar, "Button_Back")
  PaGlobal_FriendInfoList_All._ui.stc_ChatName = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_Chat_TitleBar, "StaticText_Name")
  PaGlobal_FriendInfoList_All._ui.btn_Drop = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_Chat_TitleBar, "Button_Drop")
  PaGlobal_FriendInfoList_All._ui.btn_Alarm = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_Chat_TitleBar, "CheckButton_Alarm")
  PaGlobal_FriendInfoList_All._ui.Frame_Chat = UI.getChildControl(Panel_FriendInfoList_All, "Frame_Chat")
  PaGlobal_FriendInfoList_All._ui.FrameContent = PaGlobal_FriendInfoList_All._ui.Frame_Chat:GetFrameContent()
  PaGlobal_FriendInfoList_All._ui.FrameScroll = PaGlobal_FriendInfoList_All._ui.Frame_Chat:GetVScroll()
  PaGlobal_FriendInfoList_All._ui.FrameContent:SetSize(0, 0)
  PaGlobal_FriendInfoList_All._ui.Frame_Chat:UpdateContentScroll()
  PaGlobal_FriendInfoList_All._ui.Frame_Chat:UpdateContentPos()
  local stc_To = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.FrameContent, "Static_To")
  local stc_From = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.FrameContent, "Static_From")
  stc_To:SetShow(false)
  stc_From:SetShow(false)
  PaGlobal_FriendInfoList_All._ui.stc_EditGroup = UI.getChildControl(Panel_FriendInfoList_All, "Static_EditGroup")
  PaGlobal_FriendInfoList_All._ui.stc_Edit = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_EditGroup, "Edit_1")
  PaGlobal_FriendInfoList_All._ui.btn_Enter = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_EditGroup, "Button_Enter")
  PaGlobal_FriendInfoList_All._ui.stc_Emo = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_EditGroup, "Static_Emo")
  PaGlobal_FriendInfoList_All._ui.stc_KeyX = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_EditGroup, "Static_X_ConsoleUI")
  PaGlobal_FriendInfoList_All._ui.stc_Tab_Console = UI.getChildControl(Panel_FriendInfoList_All, "Static_TabTypeBg_ConsoleUI")
  PaGlobal_FriendInfoList_All._ui.btn_PCFriend = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_Tab_Console, "RadioButton_PCFrined")
  PaGlobal_FriendInfoList_All._ui.btn_ConsoleFriend = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_Tab_Console, "RadioButton_XBoxFrined")
  PaGlobal_FriendInfoList_All._ui.stc_KeyGuide_LB = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_Tab_Console, "Static_LB")
  PaGlobal_FriendInfoList_All._ui.stc_KeyGuide_RB = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_Tab_Console, "Static_RB")
  PaGlobal_FriendInfoList_All._ui.stc_BottomBg = UI.getChildControl(Panel_FriendInfoList_All, "Static_BottomBg")
  PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_X = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_BottomBg, "StaticText_GroupRename")
  PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_A = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_BottomBg, "StaticText_Select")
  PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_B = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_BottomBg, "StaticText_Close")
  PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_LB = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_BottomBg, "StaticText_PS4Invite")
  PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_RS = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.stc_BottomBg, "StaticText_Scroll_Console")
  PaGlobal_FriendInfoList_All._keyGuides = {
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_RS,
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_LB,
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_X,
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_A,
    PaGlobal_FriendInfoList_All._ui.txt_KeyGuide_B
  }
  PaGlobal_FriendInfoList_All._ui.txt_RequestNew = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.btn_Request, "StaticText_New")
  PaGlobal_FriendInfoList_All._isPS4 = ToClient_isPS4()
  PaGlobal_FriendInfoList_All:initSubMenuPopup()
  PaGlobal_FriendInfoList_All:preparePlatform()
  PaGlobal_FriendInfoList_All._ui.stc_Function:SetShow(false)
  Panel_FriendInfoList_All:setDynamicScalePanelIndex(__eDynamicScalePanel_FriendList)
  FromClient_FriendInfoList_All_OnScreenResize()
  PaGlobalFunc_FriendInfoList_All_MessangerCloseInFriendList()
  PaGlobal_FriendInfoList_All:registEventHandler()
  PaGlobal_FriendInfoList_All._initialize = true
end
function PaGlobal_FriendInfoList_All:preparePlatform()
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_FriendInfoList_All._ui.btn_Close:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.btn_Question:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.stc_SoundOptionBg:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.btn_ScaleResize:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.btn_Drop:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.btn_Alarm:SetShow(false)
    local listContent = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.list2_Friend, "List2_1_Content")
    local child = UI.getChildControl(listContent, "Static_ChildBG")
    child:ChangeOnTextureInfoName("combine/etc/combine_etc_chatting.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(child, 419, 300, 469, 350)
    child:getOnTexture():setUV(x1, y1, x2, y2)
    child:ChangeClickTextureInfoName("combine/etc/combine_etc_chatting.dds")
    x1, y1, x2, y2 = setTextureUV_Func(child, 470, 300, 520, 350)
    child:getClickTexture():setUV(x1, y1, x2, y2)
    if true == _ContentsGroup_RenewUI then
      PaGlobal_FriendInfoList_All._ui.btn_Sound:SetShow(false)
      PaGlobal_FriendInfoList_All._ui.btn_Effect:SetShow(false)
      if true == PaGlobal_FriendInfoList_All._isPS4 then
        PaGlobal_FriendInfoList_All._ui.stc_Tab_Console:SetShow(false)
        PaGlobal_FriendInfoList_All._ui.list2_Friend:SetSpanSize(0, PaGlobal_FriendInfoList_All._ui.list2_Friend:GetSpanSize().y - PaGlobal_FriendInfoList_All._ui.stc_Tab_Console:GetSizeY())
        PaGlobal_FriendInfoList_All:SetSize(PaGlobal_FriendInfoList_All:GetSizeX(), PaGlobal_FriendInfoList_All:GetSizeY() - PaGlobal_FriendInfoList_All._ui.stc_Tab_Console:GetSizeY())
      else
        PaGlobal_FriendInfoList_All._ui.stc_PartLine:SetShow(true)
      end
    end
    local stc_Plus = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.btn_AddFriend, "Static_Plus")
    stc_Plus:SetShow(false)
    stc_Plus = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.btn_AddGroup, "Static_Plus")
    stc_Plus:SetShow(false)
    stc_Plus = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.btn_Request, "Static_Plus")
    stc_Plus:SetShow(false)
    local stc_KeyGuide_1 = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.btn_AddFriend, "Static_LT_ConsoleUI")
    local stc_KeyGuide_2 = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.btn_AddFriend, "Static_Plus_Console")
    local stc_KeyGuide_3 = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.btn_AddFriend, "Static_X_ConsoleUI")
    stc_KeyGuide_1:SetShow(true)
    stc_KeyGuide_2:SetShow(true)
    stc_KeyGuide_3:SetShow(true)
    stc_KeyGuide_1 = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.btn_AddGroup, "Static_LT_ConsoleUI")
    stc_KeyGuide_2 = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.btn_AddGroup, "Static_Plus_ConsoleUI")
    stc_KeyGuide_3 = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.btn_AddGroup, "Static_Y_ConsoleUI")
    stc_KeyGuide_1:SetShow(true)
    stc_KeyGuide_2:SetShow(true)
    stc_KeyGuide_3:SetShow(true)
    stc_KeyGuide_1 = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.btn_Request, "Static_LT_ConsoleUI")
    stc_KeyGuide_2 = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.btn_Request, "Static_Plus_ConsoleUI")
    stc_KeyGuide_3 = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.btn_Request, "Static_A_ConsoleUI")
    stc_KeyGuide_1:SetShow(true)
    stc_KeyGuide_2:SetShow(true)
    stc_KeyGuide_3:SetShow(true)
    Panel_FriendInfoList_All:SetSize(Panel_FriendInfoList_All:GetSizeX(), Panel_FriendInfoList_All:GetSizeY() - PaGlobal_FriendInfoList_All._ui.stc_SoundOptionBg:GetSizeY())
    PaGlobal_FriendInfoList_All:updateKeyGuides()
    PaGlobal_FriendInfoList_All._ui.txt_RequestNew:SetPosX(stc_KeyGuide_1:GetPosX() - PaGlobal_FriendInfoList_All._ui.txt_RequestNew:GetSizeX())
  else
    PaGlobal_FriendInfoList_All._ui.stc_BottomBg:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.stc_Tab_Console:SetShow(false)
    PaGlobal_FriendInfoList_All._ui.btn_ScaleResize:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.btn_Drop:SetShow(true)
    PaGlobal_FriendInfoList_All._ui.btn_Alarm:SetShow(true)
  end
end
function PaGlobal_FriendInfoList_All:initSubMenuPopup()
  if nil == Panel_FriendInfoList_All then
    return
  end
  local bgSizeX = PaGlobal_FriendInfoList_All._ui.stc_XBFunctionBG:GetSizeX()
  local buttonSizeY = PaGlobal_FriendInfoList_All._ui.stc_Function:GetSizeY()
  for i = 0, 1 do
    local control = UI.cloneControl(PaGlobal_FriendInfoList_All._ui.stc_Function, PaGlobal_FriendInfoList_All._ui.stc_XBFunctionBG, "Static_Funtion_" .. i)
    control:SetPosX(0)
    control:SetPosY(buttonSizeY * i)
    PaGlobal_FriendInfoList_All._ui.stc_XBFunctionList[i] = control
  end
  PaGlobal_FriendInfoList_All._ui.stc_XBFunctionBG:SetSize(bgSizeX, buttonSizeY * 2)
  PaGlobal_FriendInfoList_All._ui.stc_XBFunctionList[0]:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_XBOX_PROFILE"))
  PaGlobal_FriendInfoList_All._ui.stc_XBFunctionList[1]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_XBOX_FRIEND_GAMEINVITE"))
  PaGlobal_FriendInfoList_All._ui.stc_XBFunctionList[0]:addInputEvent("Mouse_LUp", "PaGlobal_FriendInfoList_All:ShowXBoxProfile()")
  PaGlobal_FriendInfoList_All._ui.stc_XBFunctionList[1]:addInputEvent("Mouse_LUp", "PaGlobal_FriendInfoList_All:SendXboxInvite()")
  PaGlobal_FriendInfoList_All._ui.stc_XBFunctionBG:SetShow(false)
  for i = 0, 4 do
    local control = UI.cloneControl(PaGlobal_FriendInfoList_All._ui.stc_Function, PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionBG, "Static_Funtion_" .. i)
    control:SetPosX(0)
    control:SetPosY(buttonSizeY * i)
    PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[i] = control
  end
  if true == _ContentsGroup_RenewUI then
    PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[0]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INVITE"))
  else
    PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[0]:SetText(PAGetString(Defines.StringSheet_GAME, "INTERACTION_MENU3"))
  end
  PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[1]:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_REMOVE_FRIEND"))
  PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[2]:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_CHANGE_GROUP"))
  PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[3]:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_WHISPER"))
  PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[4]:SetText(PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_WHISPER"))
  if true == _ContentsGroup_RenewUI then
    PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[0]:addInputEvent("Mouse_LUp", "PaGlobal_FriendInfoList_All:guildInvite()")
  else
    PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[0]:addInputEvent("Mouse_LUp", "PaGlobal_FriendInfoList_All:partyInvite()")
  end
  PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[1]:addInputEvent("Mouse_LUp", "PaGlobal_FriendInfoList_All:deleteFriend()")
  PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[2]:addInputEvent("Mouse_LUp", "PaGlobal_FriendInfoList_All:groupMoveList()")
  PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[3]:addInputEvent("Mouse_LUp", "PaGlobal_FriendInfoList_All:messangerPrepareOpen()")
  PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionList[4]:addInputEvent("Mouse_LUp", "PaGlobal_FriendInfoList_All:whisperWithFriend()")
  PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionBG:SetSize(bgSizeX, buttonSizeY * 5)
  PaGlobal_FriendInfoList_All._ui.stc_FriendFunctionBG:SetShow(false)
  for i = 0, PaGlobal_FriendInfoList_All._MAX_GROUP_COUNT - 1 do
    local control = UI.cloneControl(PaGlobal_FriendInfoList_All._ui.stc_Function, PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionBG, "Static_Funtion_" .. i)
    control:SetPosX(0)
    control:SetPosY(buttonSizeY * i)
    PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionList[i] = control
  end
  PaGlobal_FriendInfoList_All._ui.stc_GroupListFunctionBG:SetShow(false)
  for i = 0, 1 do
    local control = UI.cloneControl(PaGlobal_FriendInfoList_All._ui.stc_Function, PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionBG, "Static_Funtion_" .. i)
    control:SetPosX(0)
    control:SetPosY(buttonSizeY * i)
    PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionList[i] = control
  end
  PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionList[0]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_STCTXT_CHANGEGROUPNAME"))
  PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionList[1]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FRIENDGROUP_DELETE"))
  PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionList[0]:addInputEvent("Mouse_LUp", "PaGlobal_Friend_GroupRename_All:prepareOpen(" .. "false" .. ")")
  PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionList[1]:addInputEvent("Mouse_LUp", "PaGlobal_FriendInfoList_All:deleteFriendGroup()")
  PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionBG:SetSize(bgSizeX, buttonSizeY * 2)
  PaGlobal_FriendInfoList_All._ui.stc_GroupFunctionBG:SetShow(false)
end
function PaGlobal_FriendInfoList_All:registEventHandler()
  if nil == Panel_FriendInfoList_All then
    return
  end
  registerEvent("ResponseFriendList_updateFriends", "FromClient_FriendInfoList_All_ResponseUpdateFriends")
  registerEvent("FromClient_FriendMessangerOpen", "FromClient_FriendInfoListOpenMessangerInFriendList")
  registerEvent("FromClient_FriendRegionChangeNotify", "FromClient_FriendRegionChangeNotify")
  PaGlobal_FriendInfoList_All._ui.list2_Friend:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_FriendInfoList_All_List2ControlCreate")
  PaGlobal_FriendInfoList_All._ui.list2_Friend:createChildContent(__ePAUIList2ElementManagerType_Tree)
  if true == _ContentsGroup_UsePadSnapping then
    Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobal_FriendRequest_All_OpenToggle()")
    Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobal_FriendInfoList_All_ClickAddFriendButton()")
    Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobal_Friend_GroupRename_All_Open(true)")
    if true == _ContentsGroup_RenewUI then
      if true == PaGlobal_FriendInfoList_All._isPS4 then
        Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_FriendInfoList_All_ShowPSInviteDialog()")
      else
        Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_FriendInfoList_All_ChangeTab()")
        Panel_FriendInfoList_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_FriendInfoList_All_ChangeTab()")
      end
    end
  else
    PaGlobal_FriendInfoList_All._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_FriendInfoList_Hide_All()")
    PaGlobal_FriendInfoList_All._ui.btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelFriends\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(PaGlobal_FriendInfoList_All._ui.btn_Question, "\"PanelFriends\"")
    PaGlobal_FriendInfoList_All._ui.btn_Request:addInputEvent("Mouse_LUp", "PaGlobal_FriendRequest_All_OpenToggle()")
    PaGlobal_FriendInfoList_All._ui.btn_AddFriend:addInputEvent("Mouse_LUp", "PaGlobal_FriendInfoList_All_ClickAddFriendButton()")
    PaGlobal_FriendInfoList_All._ui.btn_AddGroup:addInputEvent("Mouse_LUp", "PaGlobal_Friend_GroupRename_All_Open(true)")
    PaGlobal_FriendInfoList_All._ui.btn_ScaleResize:addInputEvent("Mouse_LDown", "HandleEventLDown_FriendInfoList_All_ScaleResizeStart()")
    PaGlobal_FriendInfoList_All._ui.btn_ScaleResize:addInputEvent("Mouse_LPress", "HandleEventLPress_FriendInfoList_All_ScaleResizing()")
    PaGlobal_FriendInfoList_All._ui.btn_ScaleResize:addInputEvent("Mouse_LUp", "HandleEventLUp_FriendInfoList_All_ScaleResizeEnd()")
    PaGlobal_FriendInfoList_All._ui.btn_Back:addInputEvent("Mouse_LUp", "HandleEventLUp_FriendInfoList_All_MessangerCloseInFriendList()")
  end
  if true == _ContentsGroup_RenewUI then
    registerEvent("FromClient_CantFindFriendForXbox", "FromClient_FriendInfoList_All_CantFindFriendForXbox")
    registerEvent("FromClient_ResponseFriendResult", "FromClient_FriendInfoList_All_ResponseFriendResult")
  else
    PaGlobal_FriendInfoList_All._ui.btn_Sound:addInputEvent("Mouse_LUp", "ToClient_RequestToggleSoundNotice()")
    PaGlobal_FriendInfoList_All._ui.btn_Effect:addInputEvent("Mouse_LUp", "ToClient_RequestToggleEffectNotice()")
    registerEvent("FromClient_NoticeNewMessage", "FromClient_NoticeNewMessage_All")
  end
end
function PaGlobal_AddFriend_All:initialize()
  if true == PaGlobal_AddFriend_All._initialize then
    return
  end
  PaGlobal_AddFriend_All._ui.btn_Close = UI.getChildControl(Panel_FriendList_Add_All, "Button_AddFriend_Close_PCUI")
  PaGlobal_AddFriend_All._ui.txt_Desc = UI.getChildControl(Panel_FriendList_Add_All, "StaticText_NameDesc")
  PaGlobal_AddFriend_All._ui.sub_BG = UI.getChildControl(Panel_FriendList_Add_All, "Static_FriendName_SubBg")
  PaGlobal_AddFriend_All._ui.stc_keyGuide_X = UI.getChildControl(Panel_FriendList_Add_All, "StaticText_EditNameKeyGuide_ConsoleUI")
  PaGlobal_AddFriend_All._ui.edit_Name = UI.getChildControl(Panel_FriendList_Add_All, "Edit_FriendName")
  PaGlobal_AddFriend_All._ui.btn_Confirm = UI.getChildControl(Panel_FriendList_Add_All, "Button_AddFriend_Yes_PCUI")
  PaGlobal_AddFriend_All._ui.btn_Cancel = UI.getChildControl(Panel_FriendList_Add_All, "Button_AddFriend_No_PCUI")
  PaGlobal_AddFriend_All._ui.stc_keyGuideBG = UI.getChildControl(Panel_FriendList_Add_All, "Static_FriendBotton_ConsoleUI")
  PaGlobal_AddFriend_All._ui.stc_KeyGuide_A = UI.getChildControl(PaGlobal_AddFriend_All._ui.stc_keyGuideBG, "StaticText_Apply")
  PaGlobal_AddFriend_All._ui.stc_KeyGuide_B = UI.getChildControl(PaGlobal_AddFriend_All._ui.stc_keyGuideBG, "StaticText_Cancel")
  local Static_LB_ConsoleUI = UI.getChildControl(Panel_FriendList_Add_All, "Static_LB_ConsoleUI")
  local Static_RB_ConsoleUI = UI.getChildControl(Panel_FriendList_Add_All, "Static_RB_ConsoleUI")
  Static_LB_ConsoleUI:SetShow(false)
  Static_RB_ConsoleUI:SetShow(false)
  PaGlobal_AddFriend_All._keyGuides = {
    PaGlobal_AddFriend_All._ui.stc_KeyGuide_A,
    PaGlobal_AddFriend_All._ui.stc_KeyGuide_B
  }
  PaGlobal_AddFriend_All._ui.edit_Name:SetMaxInput(getGameServiceTypeUserNickNameLength())
  PaGlobal_AddFriend_All:preparePlatform()
  PaGlobal_AddFriend_All:registEventHandler()
  PaGlobal_AddFriend_All._initialize = true
end
function PaGlobal_AddFriend_All:preparePlatform()
  if nil == Panel_FriendList_Add_All then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_AddFriend_All._ui.btn_Close:SetShow(false)
    PaGlobal_AddFriend_All._ui.btn_Confirm:SetShow(false)
    PaGlobal_AddFriend_All._ui.btn_Cancel:SetShow(false)
    local listContent = UI.getChildControl(PaGlobal_FriendInfoList_All._ui.list2_Friend, "List2_1_Content")
    local child = UI.getChildControl(listContent, "Static_ChildBG")
    child:ChangeOnTextureInfoName("combine/etc/combine_etc_chatting.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(child, 419, 300, 469, 300)
    child:getOnTexture():setUV(x1, y1, x2, y2)
    child:ChangeClickTextureInfoName("combine/etc/combine_etc_chatting.dds")
    x1, y1, x2, y2 = setTextureUV_Func(child, 419, 300, 469, 350)
    child:getClickTexture():setUV(x1, y1, x2, y2)
    local subBG = PaGlobal_AddFriend_All._ui.sub_BG
    Panel_FriendList_Add_All:SetSize(Panel_FriendList_Add_All:GetSizeX(), Panel_FriendList_Add_All:GetSizeY() - 40)
    subBG:SetSize(subBG:GetSizeX(), subBG:GetSizeY() - 40)
    Panel_FriendList_Add_All:ComputePos()
    PaGlobal_AddFriend_All._ui.stc_keyGuideBG:ComputePos()
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_AddFriend_All._keyGuides, PaGlobal_AddFriend_All._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    PaGlobal_AddFriend_All._ui.stc_keyGuide_X:SetShow(false)
    PaGlobal_AddFriend_All._ui.stc_keyGuideBG:SetShow(false)
  end
end
function PaGlobal_AddFriend_All:registEventHandler()
  if nil == Panel_FriendList_Add_All then
    return
  end
  Panel_FriendList_Add_All:ignorePadSnapMoveToOtherPanel()
  if true == _ContentsGroup_UsePadSnapping then
    if true == _ContentsGroup_RenewUI then
      PaGlobal_AddFriend_All._ui.edit_Name:setXboxVirtualKeyBoardEndEvent("PaGlobal_AddFriend_All_EnterAddFriend")
    else
      PaGlobal_AddFriend_All._ui.edit_Name:RegistReturnKeyEvent("PaGlobal_AddFriend_All_SendAddFriend()")
    end
    Panel_FriendList_Add_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddFriend_All_SetFocusEdit()")
    Panel_FriendList_Add_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_AddFriend_All_SendAddFriend()")
  else
    PaGlobal_AddFriend_All._ui.edit_Name:RegistReturnKeyEvent("PaGlobal_AddFriend_All_SendAddFriend()")
    PaGlobal_AddFriend_All._ui.btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_AddFriend_All_SendAddFriend()")
    PaGlobal_AddFriend_All._ui.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobal_AddFriend_All_Close()")
    PaGlobal_AddFriend_All._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_AddFriend_All_Close()")
  end
end
function PaGlobal_FriendRequest_All:initialize()
  if true == PaGlobal_FriendRequest_All._initialize then
    return
  end
  PaGlobal_FriendRequest_All._ui.btn_Close = UI.getChildControl(Panel_Friend_RequestList_All, "RequestFriend_Close_PCUI")
  PaGlobal_FriendRequest_All._ui.stc_noRequest = UI.getChildControl(Panel_Friend_RequestList_All, "Static_NoRequest")
  PaGlobal_FriendRequest_All._ui.list2_requested = UI.getChildControl(Panel_Friend_RequestList_All, "List2_RequestFriend")
  PaGlobal_FriendRequest_All._ui.list2_request = UI.getChildControl(Panel_Friend_RequestList_All, "List2_RequestFriend_SEND")
  local buttonBg = UI.getChildControl(Panel_Friend_RequestList_All, "Static_RadioButtonBg")
  PaGlobal_FriendRequest_All._ui.rdo_ReceiveList = UI.getChildControl(buttonBg, "RadioButton_ReceiveList")
  PaGlobal_FriendRequest_All._ui.rdo_SendList = UI.getChildControl(buttonBg, "RadioButton_SendList")
  PaGlobal_FriendRequest_All._ui.stc_selectBar = UI.getChildControl(buttonBg, "Static_SelectBar")
  PaGlobal_FriendRequest_All._ui.stc_keyGuideRB = UI.getChildControl(buttonBg, "Static_RB_ConsoleUI")
  PaGlobal_FriendRequest_All._ui.stc_keyGuideLB = UI.getChildControl(buttonBg, "Static_LB_ConsoleUI")
  PaGlobal_FriendRequest_All._ui.stc_keyGuideBG = UI.getChildControl(Panel_Friend_RequestList_All, "Static_RequestBottom_ConsoleUI")
  PaGlobal_FriendRequest_All._ui.stc_keyGuide_X = UI.getChildControl(PaGlobal_FriendRequest_All._ui.stc_keyGuideBG, "StaticText_Refuse")
  PaGlobal_FriendRequest_All._ui.stc_keyGuide_A = UI.getChildControl(PaGlobal_FriendRequest_All._ui.stc_keyGuideBG, "StaticText_Accept")
  PaGlobal_FriendRequest_All._ui.stc_KeyGuide_B = UI.getChildControl(PaGlobal_FriendRequest_All._ui.stc_keyGuideBG, "StaticText_Cancel")
  PaGlobal_FriendRequest_All._ui.stc_keyGuide_LS = UI.getChildControl(PaGlobal_FriendRequest_All._ui.stc_keyGuideBG, "StaticText_RefuseAll")
  PaGlobal_FriendRequest_All._ui.btn_RefuseAll = UI.getChildControl(Panel_Friend_RequestList_All, "Button_RefuseAll")
  PaGlobal_FriendRequest_All._keyGuides = {
    PaGlobal_FriendRequest_All._ui.stc_keyGuide_LS,
    PaGlobal_FriendRequest_All._ui.stc_keyGuide_X,
    PaGlobal_FriendRequest_All._ui.stc_keyGuide_A,
    PaGlobal_FriendRequest_All._ui.stc_KeyGuide_B
  }
  PaGlobal_FriendRequest_All:preparePlatform()
  PaGlobal_FriendRequest_All._ui.list2_requested:createChildContent(__ePAUIList2ElementManagerType_List)
  PaGlobal_FriendRequest_All._ui.list2_request:createChildContent(__ePAUIList2ElementManagerType_List)
  PaGlobal_FriendRequest_All:registEventHandler()
  PaGlobal_FriendRequest_All._initialize = true
end
function PaGlobal_FriendRequest_All:preparePlatform()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_FriendRequest_All._ui.btn_Close:SetShow(false)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_FriendRequest_All._keyGuides, PaGlobal_FriendRequest_All._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    PaGlobal_FriendRequest_All._ui.btn_RefuseAll:SetShow(false)
    Panel_Friend_RequestList_All:SetSize(Panel_Friend_RequestList_All:GetSizeX(), Panel_Friend_RequestList_All:GetSizeY() - PaGlobal_FriendRequest_All._ui.btn_RefuseAll:GetSizeY())
    PaGlobal_FriendRequest_All._ui.stc_keyGuideBG:SetPosY(PaGlobal_FriendRequest_All._ui.stc_keyGuideBG:GetPosY() - PaGlobal_FriendRequest_All._ui.btn_RefuseAll:GetSizeY())
  else
    PaGlobal_FriendRequest_All._ui.stc_keyGuideBG:SetShow(false)
  end
end
function PaGlobal_FriendRequest_All:registEventHandler()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  Panel_Friend_RequestList_All:ignorePadSnapMoveToOtherPanel()
  registerEvent("ResponseFriendList_updateAddFriends", "FromClient_FriendRequest_All_UpdateAddFriends")
  PaGlobal_FriendRequest_All._ui.list2_requested:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_FriendRequested_All_List2EventControlCreate")
  PaGlobal_FriendRequest_All._ui.list2_request:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_FriendRequest_All_List2EventControlCreate")
  if false == _ContentsGroup_UsePadSnapping then
    PaGlobal_FriendRequest_All._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_FriendRequest_All_Close()")
    PaGlobal_FriendRequest_All._ui.rdo_ReceiveList:addInputEvent("Mouse_LUp", "PaGlobal_FriendRequest_All_SelectTab(true)")
    PaGlobal_FriendRequest_All._ui.rdo_SendList:addInputEvent("Mouse_LUp", "PaGlobal_FriendRequest_All_SelectTab(false)")
    PaGlobal_FriendRequest_All._ui.btn_RefuseAll:addInputEvent("Mouse_LUp", "PaGlobal_FriendRequest_All_RefuseAllAddFriend()")
  else
    Panel_Friend_RequestList_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_FriendRequest_All_SelectTabConsole()")
    Panel_Friend_RequestList_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_FriendRequest_All_SelectTabConsole()")
  end
end
function PaGlobal_Friend_GroupRename_All:initialize()
  if true == PaGlobal_Friend_GroupRename_All._initialize then
    return
  end
  PaGlobal_Friend_GroupRename_All._ui.btn_Close = UI.getChildControl(Panel_Friend_GroupRename_All, "Button_GroupName_Close_PCUI")
  PaGlobal_Friend_GroupRename_All._ui.txt_title = UI.getChildControl(Panel_Friend_GroupRename_All, "StaticText_ChangeGroupName")
  PaGlobal_Friend_GroupRename_All._ui.txt_groupDesc = UI.getChildControl(Panel_Friend_GroupRename_All, "StaticText_GruopDesc")
  PaGlobal_Friend_GroupRename_All._ui.sub_BG = UI.getChildControl(Panel_Friend_GroupRename_All, "Static_GroupName_SubBg")
  PaGlobal_Friend_GroupRename_All._ui.edit_GroupName = UI.getChildControl(Panel_Friend_GroupRename_All, "Edit_GroupName")
  PaGlobal_Friend_GroupRename_All._ui.stc_keyGuide_X = UI.getChildControl(Panel_Friend_GroupRename_All, "StaticText_EditGroupKeyGuide_ConsoleUI")
  PaGlobal_Friend_GroupRename_All._ui.btn_Confirm = UI.getChildControl(Panel_Friend_GroupRename_All, "Button_GroupName_Yes_PCUI")
  PaGlobal_Friend_GroupRename_All._ui.btn_Cancel = UI.getChildControl(Panel_Friend_GroupRename_All, "Button_GroupName_No_PCUI")
  PaGlobal_Friend_GroupRename_All._ui.stc_keyGuideBG = UI.getChildControl(Panel_Friend_GroupRename_All, "Static_Bottom_ConsoleUI")
  PaGlobal_Friend_GroupRename_All._ui.stc_KeyGuide_A = UI.getChildControl(PaGlobal_Friend_GroupRename_All._ui.stc_keyGuideBG, "StaticText_Apply")
  PaGlobal_Friend_GroupRename_All._ui.stc_KeyGuide_B = UI.getChildControl(PaGlobal_Friend_GroupRename_All._ui.stc_keyGuideBG, "StaticText_Cancel")
  PaGlobal_Friend_GroupRename_All._keyGuides = {
    PaGlobal_Friend_GroupRename_All._ui.stc_KeyGuide_A,
    PaGlobal_Friend_GroupRename_All._ui.stc_KeyGuide_B
  }
  PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:SetMaxInput(getGameServiceTypeUserNickNameLength())
  PaGlobal_Friend_GroupRename_All:preparePlatform()
  PaGlobal_Friend_GroupRename_All:registEventHandler()
  PaGlobal_Friend_GroupRename_All._initialize = true
end
function PaGlobal_Friend_GroupRename_All:preparePlatform()
  if nil == Panel_Friend_GroupRename_All then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_Friend_GroupRename_All._ui.btn_Close:SetShow(false)
    PaGlobal_Friend_GroupRename_All._ui.btn_Confirm:SetShow(false)
    PaGlobal_Friend_GroupRename_All._ui.btn_Cancel:SetShow(false)
    local subBG = PaGlobal_Friend_GroupRename_All._ui.sub_BG
    Panel_Friend_GroupRename_All:SetSize(Panel_Friend_GroupRename_All:GetSizeX(), Panel_Friend_GroupRename_All:GetSizeY() - 90)
    subBG:SetSize(subBG:GetSizeX(), subBG:GetSizeY() - 90)
    Panel_Friend_GroupRename_All:ComputePos()
    PaGlobal_Friend_GroupRename_All._ui.stc_keyGuideBG:ComputePos()
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_Friend_GroupRename_All._keyGuides, PaGlobal_Friend_GroupRename_All._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    PaGlobal_Friend_GroupRename_All._ui.stc_keyGuide_X:SetShow(false)
    PaGlobal_Friend_GroupRename_All._ui.stc_keyGuideBG:SetShow(false)
  end
end
function PaGlobal_Friend_GroupRename_All:registEventHandler()
  if nil == Panel_Friend_GroupRename_All then
    return
  end
  Panel_Friend_GroupRename_All:ignorePadSnapMoveToOtherPanel()
  if true == _ContentsGroup_UsePadSnapping then
    if true == _ContentsGroup_RenewUI then
      PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:setXboxVirtualKeyBoardEndEvent("PaGlobal_Friend_GroupRename_All_EnterGroupName")
    else
      PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:RegistReturnKeyEvent("PaGlobal_Friend_GroupRename_All_Confirm()")
    end
    Panel_Friend_GroupRename_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Friend_GroupRename_All_SetFocusEdit()")
    Panel_Friend_GroupRename_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Friend_GroupRename_All_Confirm()")
  else
    PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:RegistReturnKeyEvent("PaGlobal_Friend_GroupRename_All_Confirm()")
    PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:addInputEvent("Mouse_LUp", "PaGlobal_Friend_GroupRename_All_SetFocusEdit()")
    PaGlobal_Friend_GroupRename_All._ui.btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_Friend_GroupRename_All_Confirm()")
    PaGlobal_Friend_GroupRename_All._ui.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobal_Friend_GroupRename_All_Close()")
    PaGlobal_Friend_GroupRename_All._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_Friend_GroupRename_All_Close()")
  end
end
function PaGlobal_Friend_SetTexture(calssIcon, classType)
  if nil == calssIcon or nil == classType then
    return
  end
  local friendTextureInfo = PaGlobal_FriendClassTextureInfo[classType]
  if nil == friendTextureInfo then
    friendTextureInfo = PaGlobal_FriendClassTextureInfo[__eClassType_Count]
  end
  calssIcon:ChangeTextureInfoName(friendTextureInfo[1])
  local x1, y1, x2, y2 = setTextureUV_Func(calssIcon, friendTextureInfo[2], friendTextureInfo[3], friendTextureInfo[4], friendTextureInfo[5])
  calssIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  calssIcon:setRenderTexture(calssIcon:getBaseTexture())
end
function PaGlobal_FriendMessangerFloatingAlert_All:initialize()
  if true == PaGlobal_FriendMessangerFloatingAlert_All._initialize then
    return
  end
  for i = 0, PaGlobal_FriendMessangerFloatingAlert_All._messangerAlertCount - 1 do
    PaGlobal_FriendMessangerFloatingAlert_All._messangerPosY[i] = Panel_Widget_Friends_FloatingAlert:GetPosY() - Panel_Widget_Friends_FloatingAlert:GetSizeY() * (i + 1)
  end
  PaGlobal_FriendMessangerFloatingAlert_All._initialize = true
end
Panel_FriendInfoList_All:RegisterShowEventFunc(true, "PaGlobal_FriendInfoList_All_ShowAni()")
Panel_FriendInfoList_All:RegisterShowEventFunc(false, "PaGlobal_FriendInfoList_All_HideAni()")
registerEvent("onScreenResize", "FromClient_FriendInfoList_All_OnScreenResize")
registerEvent("FromClient_FriendMessangerUpdate", "FromClient_FriendInfoList_All_FriendMessangerUpdate")
registerEvent("FromClient_FriendMessangerAlert", "FriendMessangerFloatingAlert_OpenMessanger")
registerEvent("FromClient_FriendMessangerAlarm", "FromClient_FriendMessangerAlarm")
registerEvent("FromClient_FriendMessangerAlarmLoad", "FromClient_FriendMessangerAlarmLoad")
registerEvent("FromClient_GroundMouseClick", "FriendMessanger_KillFocusEdit")
registerEvent("FromClient_GroundMouseClick", "PaGlobalFunc_FriendInfoList_All_KillFocusEdit()")
registerEvent("FromClient_NotifyFriendLogInOut", "FromClient_NotifyFriendMessage")
registerEvent("FromClient_FriendDirectlyMessage", "FromClient_FriendDirectlyMessage")
