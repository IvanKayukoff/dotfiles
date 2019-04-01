local awful = require("awful")
local wibox = require("wibox")

------------------------------------------
-- Brightness widget for awesome 4.x
------------------------------------------

local control = {}

function control:new(args)
  return setmetatable({}, {__index = self}):init(args)
end

function control:init(args)
  widget_path      = "~/.config/awesome/widgets/brightness"
  self.set_cmd     = "sudo " .. widget_path .. "/set_brightness.sh"
  self.get_cmd     = "cat /sys/class/backlight/intel_backlight/brightness"
  self.get_max_cmd = "cat /sys/class/backlight/intel_backlight/max_brightness"
  self.cur_bright  = '1'
  self.max_bright  = '1'
  self.step = args.step or '5'
  
  -- Init fields synchronously
  self.cur_bright = io.popen(self.get_cmd):read("*all")
  self.max_bright = io.popen(self.get_max_cmd):read("*all")

  self.widget = wibox.widget.textbox()
  self.widget.set_align("right")

  self.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function() self:up() end),
    awful.button({ }, 3, function() self:down() end),
    awful.button({ }, 4, function() self:up() end),
    awful.button({ }, 5, function() self:down() end)
  ))

  self:update_widget()
  return self
end

function control:get()
  awful.spawn.easy_async(self.get_cmd, function(out)
    self.cur_bright = out
  end)
end

function control:update_widget()
  if type(tonumber(self.cur_bright)) == "nil" then
    self.cur_bright = 100
    self.max_bright = 100
  end
  local brightness = math.floor(
    0.5 + tonumber(self.cur_bright) / tonumber(self.max_bright) * 100
  )
  self.widget:set_markup(string.format("<span color='yellow'> Bright:%3d%% </span>", brightness))
end

function control:get_max()
  awful.spawn.easy_async(self.get_max_cmd, function(out)
    self.max_bright = out
  end)
end

function control:set()
  awful.spawn.easy_async_with_shell(self.set_cmd .. " " ..
    self.cur_bright, function() end)
end

function control:up()
  local cur_percent = math.floor(0.5 + tonumber(self.cur_bright) / tonumber(self.max_bright) * 100)
  local new_percent = cur_percent + tonumber(self.step)
  if new_percent > 100 then
    new_percent = 100
  end
  self.cur_bright = math.floor(new_percent / 100 * tonumber(self.max_bright))
  self:set()
  self:update_widget()
end

function control:down()
  local cur_percent = math.floor(0.5 + tonumber(self.cur_bright) / tonumber(self.max_bright) * 100)
  local new_percent = cur_percent - tonumber(self.step)
  if new_percent < 0 then
    new_percent = 0
  end
  self.cur_bright = math.floor(new_percent / 100 * tonumber(self.max_bright))
  self:set()
  self:update_widget()
end

return setmetatable(control, {
  __call = control.new,
})

