
mouseSideButtons = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown },
  function(e)
    if e:getButtonState(4) then
      hs.eventtap.event.newKeyEvent({"command", "shift"}, 42, true):post()
      return true -- to supress original key
    elseif e:getButtonState(3) then
      hs.eventtap.event.newKeyEvent({"command", "shift"}, 30, true):post()
      return true -- to supress original key
    end

  end
)
mouseSideButtons:start()

eisuuFlag = false

eisuuD = hs.eventtap.new({ hs.eventtap.event.types.keyDown },
  function(e)
    thisKeyCode = e:getKeyCode()
    if eisuuFlag == true then
      if thisKeyCode == 8 then
        hs.eventtap.event.newKeyEvent({"command", "shift"}, 30, true):post()
        return true
      elseif thisKeyCode == 9 then
        hs.eventtap.event.newKeyEvent({"command", "shift"}, 42, true):post()
        return true
      end
    elseif thisKeyCode == 102 then
      eisuuFlag = true
    else
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
    print(hs.keycodes.map[gestureType])
    print(hs.inspect(hs.keycodes.layouts()))
    print(hs.inspect(hs.keycodes.methods()))
    print(hs.keycodes.currentMethod())
    print(hs.keycodes.currentLayout())
    if gestureType == hs.eventtap.event.types.gesture then
    end
    if keyCode == 50 then
      hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt,true):post()
      hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt,true):post()
      return true
    end
end)
-- keyboardTracker:start()

-- https://github.com/mengelbrecht/hammerspoon-config/blob/main/init.lua
