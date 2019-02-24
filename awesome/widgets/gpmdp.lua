local helpers             = require("lain.helpers")
local json                = require("lain.util.dkjson")
local focused             = require("awful.screen").focused
local naughty             = require("naughty")
local wibox               = require("wibox")
local next, getenv, table = next, os.getenv, table
local awful               = require("awful")

-------------------------------------------------------
-- GPMDP widget for awesome 4.x
--
-- TODO add icon, buttons, and refactor code use OOP
-------------------------------------------------------
local function factory(args)
  local gpmdp         = { widget = wibox.widget.textbox() }
  local args          = args or {}
  local timeout       = args.timeout or 2
  local notify        = args.notify or "on"
  local followtag     = args.followtag or false
  local file_location = args.file_location or
                        getenv("HOME") .. "/.config/Google Play Music Desktop Player/json_store/playback.json"
  local update_text   = args.update_text or
    function(gpm_now)
      if gpm_now.running and gpm_now.title ~= nil then
        gpmdp.widget:set_markup(string.format(
          "<span color='red'>%s - %s</span>", gpm_now.artist, gpm_now.title))
      else
        gpmdp.widget:set_text("")
      end
    end

  gpmdp_notification_preset = {
    title   = "Now playing",
    timeout = 3,
    width   = 380,
    icon_size = 128
  }

  helpers.set_map("gpmdp_current", nil)

  function gpmdp.update()
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

    awful.spawn.easy_async("pidof 'Google Play Music Desktop Player'",
      function(out)
        if out ~= '' then
          gpm_now.running = true
        else
          gpm_now.running = false
        end
        gpmdp_notification_preset.text = string.format("%s (%s) - %s", gpm_now.artist, gpm_now.album, gpm_now.title)
        widget = gpmdp.widget
        update_text(gpm_now)

        if gpm_now.playing then
          if notify == "on" and gpm_now.title ~= helpers.get_map("gpmdp_current") then
            helpers.set_map("gpmdp_current", gpm_now.title)

            if followtag then gpmdp_notification_preset.screen = focused() end

            helpers.async(string.format("curl %s -o /tmp/gpmcover.png", gpm_now.cover_url),
              function(f)
                gpmdp.id = naughty.notify({
                  preset = gpmdp_notification_preset,
                  icon = "/tmp/gpmcover.png",
                  replaces_id = gpmdp.id
                }).id
              end
            )
          end
        elseif not gpm_now.running then
          helpers.set_map("gpmdp_current", nil)
        end
      end
    )

  end

  gpmdp.timer = helpers.newtimer("gpmdp", timeout, gpmdp.update, true, true)

  return gpmdp
end

return factory

