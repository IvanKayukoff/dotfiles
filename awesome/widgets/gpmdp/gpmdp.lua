local helpers             = require("lain.helpers")
local json                = require("lain.util.dkjson")
local focused             = require("awful.screen").focused
local naughty             = require("naughty")
local wibox               = require("wibox")
local next, getenv, table = next, os.getenv, table
local awful               = require("awful")
local gears               = require("gears")
local timer               = gears.timer or timer

-------------------------------------------------------
-- GPMDP widget for awesome 4.x
-------------------------------------------------------

local function load_info(file_location)
  local filelines = helpers.lines_from(file_location)
  local gpm_now = {}
  if not next(filelines) then
    gpm_now = { running = false, playing = false }
  else
    dict, pos, err = json.decode(table.concat(filelines), 1, nil)
    gpm_now = {}
    gpm_now.artist    = dict.song.artist
    gpm_now.album     = dict.song.album
    gpm_now.title     = dict.song.title
    gpm_now.cover_url = dict.song.albumArt
    gpm_now.playing   = dict.playing
  end
  return gpm_now
end

local viewer = {}

function viewer:new(args)
  return setmetatable({}, {__index = self}):init(args)
end

function viewer:init(args)
  self.widget        = wibox.widget.textbox()
  self.args          = args or {}
  self.timeout       = args.timeout or 2
  self.notify        = args.notify or true
  self.followtag     = args.followtag or false
  self.bar_color     = args.bar_color or "red"
  self.file_location = args.file_location or getenv("HOME") ..
                        "/.config/Google Play Music Desktop Player/json_store/playback.json"

  self.gpmdp_notification_preset = {
    title     = "Now playing",
    timeout   = 3,
    width     = 380,
    icon_size = 128
  }

  helpers.set_map("gpmdp_current", nil)

  self.timer = timer({ timeout = self.timeout })
  self.timer:connect_signal("timeout", function() self:update() end)
  self.timer:start()

  return self
end

function viewer:update_text(gpm_now)
  if gpm_now.running and gpm_now.title ~= nil then
    self.widget:set_markup(string.format(
      "<span color='%s'>%s - %s</span>", self.bar_color, gpm_now.artist, gpm_now.title))
  else
    self.widget:set_text("")
  end
end

function viewer:update()
  local gpm_now = load_info(self.file_location)
  awful.spawn.easy_async("pidof 'Google Play Music Desktop Player'",
    function(out)
      if out ~= '' then
        gpm_now.running = true
      else
        gpm_now.running = false
      end

      self:update_text(gpm_now)
      self:show_notification(gpm_now)
    end
  )
end

function viewer:show_notification(gpm_now)
  self.gpmdp_notification_preset.text = string.format("%s (%s) - %s",
                                          gpm_now.artist, gpm_now.album, gpm_now.title)
  if gpm_now.playing then
    if self.notify and gpm_now.title ~= helpers.get_map("gpmdp_current") then
      helpers.set_map("gpmdp_current", gpm_now.title)

      if self.followtag then self.gpmdp_notification_preset.screen = focused() end

      helpers.async(string.format("curl %s -o /tmp/gpmcover.png", gpm_now.cover_url),
        function(f)
          self.widget.id = naughty.notify({
            preset = self.gpmdp_notification_preset,
            icon = "/tmp/gpmcover.png",
            replaces_id = self.widget.id
          }).id
        end
      )
    end
  elseif not gpm_now.running then
    helpers.set_map("gpmdp_current", nil)
  end
end

return setmetatable(viewer, {
  __call = viewer.new,
})

