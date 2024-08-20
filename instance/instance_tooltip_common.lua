Instance_Tooltip_Common:SetShow(false, false)
Instance_Tooltip_Common:setGlassBackground(true)
Instance_Tooltip_Common:SetIgnoreChild(true)
local _uiIcon = UI.getChildControl(Instance_Tooltip_Common, "Tooltip_Common_Icon")
local _uiName = UI.getChildControl(Instance_Tooltip_Common, "Tooltip_Common_Name")
local _uiTitle = UI.getChildControl(Instance_Tooltip_Common, "Tooltip_Common_Title")
local _styleDesc = UI.getChildControl(Instance_Tooltip_Common, "Tooltip_Common_Description")
local uiTextGroup = {_uiName = _uiName, _styleDesc = _styleDesc}
local function getMaxRightPos()
  local rightPos = 0
  for _, control in pairs(uiTextGroup) do
    if control:GetShow() then
      local currentControlRight = control:GetPosX() + control:GetTextSizeX()
      if rightPos < currentControlRight then
        rightPos = currentControlRight
      end
    end
  end
  return rightPos
end
local function getMaxBottomPos()
  local bottomPos = 0
  for _, control in pairs(uiTextGroup) do
    if control:GetShow() then
      local currentControlBottom = control:GetPosY() + control:GetTextSizeY()
      if bottomPos < currentControlBottom then
        bottomPos = currentControlBottom
      end
    end
  end
  return bottomPos
end
local currentIndex = -1
local isShow = false
function TooltipCommon_Show(index, uiWedget, iconPath, name, title, desc)
  if currentIndex == index and isShow then
    return
  else
    currentIndex = index
    isShow = true
  end
  if iconPath ~= nil then
    _uiIcon:ChangeTextureInfoName("icon/" .. iconPath)
  else
    _uiIcon:ChangeTextureInfoName("")
  end
  _uiName:SetTextMode(__eTextMode_AutoWrap)
  _uiName:SetText(name)
  _uiName:ComputePos()
  if nil == desc then
    _styleDesc:SetShow(false)
  else
    _styleDesc:SetText(desc)
  end
  local width = getMaxRightPos()
  local height = getMaxBottomPos() + 30
  if 0 ~= width and 0 ~= height then
    local posX = uiWedget:GetParentPosX() + uiWedget:GetSizeX() * 0.8
    local posY = uiWedget:GetParentPosY() - uiWedget:GetSizeY() - _uiName:GetTextSizeY()
    Instance_Tooltip_Common:SetPosX(posX)
    Instance_Tooltip_Common:SetPosY(posY)
    Instance_Tooltip_Common:SetSize(Instance_Tooltip_Common:GetSizeX(), height)
    Instance_Tooltip_Common:SetShow(true, false)
  else
    Instance_Tooltip_Common:SetShow(false, false)
  end
end
function TooltipCommon_Hide(index)
  if currentIndex ~= index or false == isShow then
    return
  else
    currentIndex = -1
    isShow = false
  end
  Instance_Tooltip_Common:SetShow(false, false)
end
function TooltipCommon_getCurrentIndex()
  return currentIndex
end
