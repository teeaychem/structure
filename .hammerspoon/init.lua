-- function dump(o)
--   if type(o) == 'table' then
--     local s = '{ '
--     for k,v in pairs(o) do
--       if type(k) ~= 'number' then k = '"'..k..'"' end
--       s = s .. '['..k..'] = ' .. dump(v) .. ','
--     end
--     return s .. '} '
--   else
--     return tostring(o)
--   end
-- end

mouseSideButtons = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown },
  function(e)
    if e:getButtonState(4) then
      hs.eventtap.event.newKeyEvent({"command", "shift"}, 42, true):post()
    elseif e:getButtonState(3) then
      hs.eventtap.event.newKeyEvent({"command", "shift"}, 30, true):post()
    end
  end
)
mouseSideButtons:start()

eisuuFlag = true
eisuuKeys = {}
eisuuKeys[8] = true
eisuuKeys[9] = true

eisuuD = hs.eventtap.new({ hs.eventtap.event.types.keyDown },
  function(e)
    thisKeyCode = e:getKeyCode()
    if thisKeyCode == 102 then
      eisuuFlag = true
    elseif (eisuuFlag and thisKeyCode == 8) then
      hs.eventtap.event.newKeyEvent({"command", "shift"}, 42, true):post()
    elseif (eisuuFlag and thisKeyCode == 9) then
      hs.eventtap.event.newKeyEvent({"command", "shift"}, 30, true):post()
    elseif eisuuFlag == true and not eisuuKeys[thisKeyCode] then
      eisuuFlag = false
    end
  end
):start()

eisuuU = hs.eventtap.new({ hs.eventtap.event.types.keyUp },
  function(e)
    if e:getKeyCode() == 102 then
      eisuuFlag = false
    end
  end
):start()


-- Use to figure out key
local events = hs.eventtap.event.types
keyboardTracker = hs.eventtap.new({ hs.eventtap.event.types.keyDown },
  function (e)
    local gestureType = e:getKeyCode(true)
    if gestureType == hs.eventtap.event.types.gesture then
    end
    if keyCode == 50 then
      hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt,true):post()
      hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt,true):post()
      return true
    end
end)
keyboardTracker:start()

-- https://github.com/mengelbrecht/hammerspoon-config/blob/main/init.lua
