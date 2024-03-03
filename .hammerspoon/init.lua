

mouseSideButtons = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown },
    function(e)
        if e:getButtonState(4) then
           hs.eventtap.event.newKeyEvent({"command", "shift"}, 42, true):post()
        end
        if e:getButtonState(3) then
           hs.eventtap.event.newKeyEvent({"command", "shift"}, 30, true):post()
        end
    end
)

mouseSideButtons:start()

-- Use to figure out keys
-- local events = hs.eventtap.event.types
-- keyboardTracker = hs.eventtap.new({ events.keyDown }, function (e)
--   local keyCode = e:getKeyCode()
--   print(keyCode)
--   if keyCode == 50 then
--     hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt,true):post()
--     hs.eventtap.event.newKeyEvent(hs.keycodes.map.alt,true):post()
--     return true
--   end
-- end)
-- keyboardTracker:start()

-- https://github.com/mengelbrecht/hammerspoon-config/blob/main/init.lua