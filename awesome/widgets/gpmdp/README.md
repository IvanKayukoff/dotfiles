### Google play music desktop player widget

This widget prints information about music that is currently playing.

#### Usage

First of all you have to import gpmdp widget.
```lua
-- Google music widget
local gpmdp = require("widgets.gpmdp")
```

After that you should create a gpmdp instance.
In your awesome config:
```lua
gpmdp_config = gpmdp({
  timeout = 2,       -- (number) timeout in seconds (so often the widget needs to be updated)
  notify = true,     -- (boolean) whether a notification should be displayed
  followtag = false, -- (boolean) set to true if you want to display a notification only
                     --   on a focused screen
  bar_color = "red", -- (string) color of a text that will be printed in your bar
                     --   support any hex color value e.g. #bf2448
  file_location = "" -- (string) path to the gpmdp's playback.json file
                     --   in most cases you should leave the default value
})
```

Finally, add the widget to your panel:
```lua
...
gpmdp_config.widget,
...
```

