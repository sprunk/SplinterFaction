
function widget:GetInfo()
	return {
		name      = "Tooltip",
		desc      = "Shows tooltips",
		author    = "Floris",
		date      = "April 2017",
		license   = "GNU GPL, v2 or later",
		layer     = -9999999999,
		enabled   = true,  --  loaded by default?
	}
end

------------------------------------------------------------------------------------
-- Info
------------------------------------------------------------------------------------
--[[

-- Availible API functions:
WG['tooltip'].AddTooltip(name, area, value, delay, x, y)  -- area: {x1,y1,x2,y2}   value: 'text'   delay(optional): #seconds   x/y(optional): display coordinates
WG['tooltip'].RemoveTooltip(name)

WG['tooltip'].ShowTooltip(name, value, x, y)    -- x/y (optional): display coordinates

You can use 'AddTooltip' to add a screen area that will display a tooltip when you hover over it

Use 'ShowTooltip' to directly show a tooltip, the name you give should be unique, and not one you desined in 'AddTooltip'
(the name will be deleted after use)

]]--
------------------------------------------------------------------------------------
-- Config
------------------------------------------------------------------------------------

local defaultDelay = 0.4
local usedFontSize = 15
local xOffset = 35
local yOffset = -35-usedFontSize

local fontfile = LUAUI_DIRNAME .. "fonts/" .. Spring.GetConfigString("ui_font", "JosefinSans-SemiBold.ttf")
local vsx,vsy = Spring.GetViewGeometry()
local fontfileScale = (0.5 + (vsx*vsy / 5700000))
local fontfileSize = 25
local fontfileOutlineSize = 4.5
local fontfileOutlineStrength = 1.8
local font = gl.LoadFont(fontfile, fontfileSize*fontfileScale, fontfileOutlineSize*fontfileScale, fontfileOutlineStrength)

------------------------------------------------------------------------------------
-- Speedups
------------------------------------------------------------------------------------

local bgcorner				= "LuaUI/Images/bgcorner.png"
local glColor = gl.Color
local glText = gl.Text
local glRect = gl.Rect
local glTranslate = gl.Translate

local spGetModKeyState = Spring.GetModKeyState
local spGetMouseState = Spring.GetMouseState
local spTraceScreenRay = Spring.TraceScreenRay
local spGetTooltip = Spring.GetCurrentTooltip

local vsx, vsy = Spring.GetViewGeometry()

local tooltips = {}

------------------------------------------------------------------------------------
-- Functions
------------------------------------------------------------------------------------

function RectRound(px,py,sx,sy,cs)
	
	local px,py,sx,sy,cs = math.floor(px),math.floor(py),math.floor(sx),math.floor(sy),math.floor(cs)
	
	gl.Rect(px+cs, py, sx-cs, sy)
	gl.Rect(sx-cs, py+cs, sx, sy-cs)
	gl.Rect(px+cs, py+cs, px, sy-cs)
	
	gl.Texture(bgcorner)
	gl.TexRect(px, py+cs, px+cs, py)		-- top left
	gl.TexRect(sx, py+cs, sx-cs, py)		-- top right
	gl.TexRect(px, sy-cs, px+cs, sy)		-- bottom left
	gl.TexRect(sx, sy-cs, sx-cs, sy)		-- bottom right
	gl.Texture(false)
end

function widget:Initialize()
	init()
end

function widget:Shutdown()
    gl.DeleteFont(font)
	if WG['guishader'] then
        for name, tooltip in pairs(tooltips) do
		    WG['guishader'].DeleteScreenDlist('tooltip_'..name)
        end
	end
	WG['tooltip'] = nil
end

function init()
	vsx, vsy = gl.GetViewSizes()
	widgetScale = (0.60 + (vsx*vsy / 5000000))

    if WG['tooltip'] == nil then
        WG['tooltip'] = {}
        WG['tooltip'].AddTooltip = function(name, area, value, delay)
			if (value ~= nil and area[1]~=nil and area[2]~=nil and area[3]~=nil and area[4]~=nil) or tooltips[name] ~= nil and tooltips[name].value ~= nil then
                if delay == nil then delay = defaultDelay end
                if tooltips[name] == nil then
					tooltips[name] = {}
				end
				tooltips[name].area = area
				tooltips[name].delay = delay
                if value ~= nil then
                    tooltips[name].value = tostring(value)
                end
            end
        end
        WG['tooltip'].RemoveTooltip = function(name)
            if tooltips[name] ~= nil then
                tooltips[name] = nil
            end
        end
        WG['tooltip'].ShowTooltip = function(name, value, x, y)
            if value ~= nil then
                tooltips[name] = {value=tostring(value) }
                if x ~= nil and y ~= nil then
                    tooltips[name].pos = {x,y}
                end
            end
        end
    end
end


function widget:ViewResize(x,y)
	vsx,vsy = Spring.GetViewGeometry()

	local newFontfileScale = (0.5 + (vsx*vsy / 5700000))
	if (fontfileScale ~= newFontfileScale) then
		fontfileScale = newFontfileScale
		font = gl.LoadFont(fontfile, fontfileSize*fontfileScale, fontfileOutlineSize*fontfileScale, fontfileOutlineStrength)
	end

	init()
end


function IsOnRect(x, y, BLcornerX, BLcornerY,TRcornerX,TRcornerY)
	return x >= BLcornerX and x <= TRcornerX and y >= BLcornerY and y <= TRcornerY
end


function lines(str)
  local t = {}
  local function helper(line) t[#t+1]=line return "" end
  helper((str:gsub("(.-)\r?\n", helper)))
  return t
end


function drawTooltip(name, x, y)
	--Spring.Echo('Showing tooltip:  '..name)

	local paddingH = 7 *widgetScale
	local paddingW = paddingH * 1.33
	local posX = x + paddingW
	local posY = y + paddingH

	local fontSize = usedFontSize*widgetScale
	local maxWidth = 0
	local maxHeight = 0
	local lineHeight = fontSize + (fontSize/4.5)
	local lines = lines(tooltips[name].value)
	
	-- get text dimentions
	for i, line in ipairs(lines) do
		maxWidth = math.max(maxWidth, (font:GetTextWidth(line)*fontSize), maxWidth)
		maxHeight = maxHeight + lineHeight
	end
	-- adjust position when needed
	if posX+maxWidth+paddingW+paddingW > vsx then
		posX = posX - maxWidth - paddingW - paddingW - (xOffset*widgetScale*2)
	end
	if posX - paddingW < 0 then
		posX = 0 + paddingW
	end
	if posY + paddingH > vsy then
		posY = (posY - (posY - vsy)) - paddingH
	end
	if posY-maxHeight-paddingH-paddingH < 0 then
		posY = 0 + maxHeight + paddingH + paddingH
	end
	
	-- draw background
	local cornersize = 0
	glColor(0.85,0.85,0.85,(WG['guishader'] and 0.66 or 0.8))
	RectRound(posX-paddingW+cornersize, posY-maxHeight-paddingH+cornersize, posX+maxWidth+paddingW-cornersize, posY+paddingH-cornersize, 5*widgetScale)
	if WG['guishader'] then
		WG['guishader'].InsertScreenDlist( gl.CreateList( function()
			RectRound(posX-paddingW+cornersize, posY-maxHeight-paddingH+cornersize, posX+maxWidth+paddingW-cornersize, posY+paddingH-cornersize, 5*widgetScale)
		end), 'tooltip_'..name)
	end
	cornersize = 2.25*widgetScale
	glColor(0,0,0,(WG['guishader'] and 0.22 or 0.3))
	RectRound(posX-paddingW+cornersize,
		posY-maxHeight-paddingH+cornersize,
		posX+maxWidth+paddingW-cornersize,
		posY+paddingH-cornersize-0.06, 4.3*widgetScale)
	
	-- draw text
	maxHeight = -fontSize*0.93
	glTranslate(posX, posY, 0)
	font:Begin()
	--font:SetTextColor(0.95,0.95,0.95,1)
	--font:SetOutlineColor(0.3,0.3,0.3,0.3)
	for i, line in ipairs(lines) do
		font:Print('\255\244\244\244'..line, 0, maxHeight, fontSize, "o")
		maxHeight = maxHeight - lineHeight
	end
	font:End()
	glTranslate(-posX, -posY, 0)
end

local cleanupGuishaderAreas = {} 
function widget:RecvLuaMsg(msg, playerID)
	if msg:sub(1,18) == 'LobbyOverlayActive' then
		chobbyInterface = (msg:sub(1,19) == 'LobbyOverlayActive1')
	end
end

function widget:DrawScreen()
	if chobbyInterface then return end
	if (WG['topbar'] and WG['topbar'].showingQuit()) then
		return
	end
	local x, y = spGetMouseState()
	local now = os.clock()

	if WG['guishader'] then
		for name, _ in pairs(cleanupGuishaderAreas) do
			WG['guishader'].DeleteScreenDlist(name)
			cleanupGuishaderAreas[name] = nil
		end
	end
	for name, tooltip in pairs(tooltips) do
		if tooltip.area == nil or (tooltip.area[4]~= nil and IsOnRect(x, y, tooltip.area[1], tooltip.area[2], tooltip.area[3], tooltip.area[4])) then
			if tooltip.area == nil then
                if tooltip.pos ~= nil then
				    drawTooltip(name, tooltip.pos[1], tooltip.pos[2])
                else
                    drawTooltip(name, x + (xOffset*widgetScale), y + (yOffset*widgetScale))
                end
				tooltips[name] = nil
				cleanupGuishaderAreas['tooltip_'..name] = true
			else
				if tooltip.displayTime == nil then
					tooltip.displayTime = now + tooltip.delay
				elseif tooltip.displayTime <= now then
                    if tooltip.pos ~= nil then
                        drawTooltip(name, tooltip.pos[1], tooltip.pos[2])
                    else
                        drawTooltip(name, x + (xOffset*widgetScale), y + (yOffset*widgetScale))
                    end
				end
			end
		else
			if tooltip.displayTime ~= nil then
				tooltip.displayTime = nil
				if WG['guishader'] then
					WG['guishader'].DeleteScreenDlist('tooltip_'..name)
				end
			end
		end
	end
end

------------------------------------------------------------------------------------
