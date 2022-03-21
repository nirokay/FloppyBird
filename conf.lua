local info = require("data/info")

function love.conf(t)
    t.version = "11.4"

    -- Modules:
    t.modules.audio    = true
    t.modules.data     = true
    t.modules.event    = true
    t.modules.font     = true
    t.modules.graphics = true
    t.modules.image    = true
    t.modules.joystick = false
    t.modules.keyboard = true
    t.modules.math     = true
    t.modules.mouse    = true
    t.modules.physics  = false
    t.modules.sound    = true
    t.modules.system   = true
    t.modules.thread   = true
    t.modules.timer    = true
    t.modules.touch    = false
    t.modules.video    = true
    t.modules.window   = true

	-- Storage:
	t.identity = string.lower(info.authors[1])..".floppybird"
	t.externalstorage = true

    -- Permissions:
	t.accelerometerjoystick = false
	t.audio.mic = false
    t.audio.mixwithsystem = true

    -- Window:
    t.window.title = info.title .. " v" .. info.version
    t.window.icon = "assets/img/icon.png"
	t.window.width = 640
	t.window.height = 780
    t.window.resizable = false
end