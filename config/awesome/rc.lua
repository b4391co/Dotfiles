-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local c = client.focus


-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Autorun programs
autorun = true
autorunApps = 
{ 
    "picom -b --animations --animation-for-open-window zoom --animation-window-mass 0.5 --animation-stiffness 350;",  
    "~/.config/polybar/launch.sh",
    "nitrogen --restore",
    "export FS=1"
}

if autorun then
   for app = 1, #autorunApps do
       awful.util.spawn(autorunApps[app])
   end
end



-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                        title = "Oops, an error happened!",
                        text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "wezterm"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default alt.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
alt = "Mod1"
super = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,

}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "Manual", terminal .. " -e man awesome" },
    { "Edit config", editor_cmd .. " " .. awesome.conffile },
    { "Restart", awesome.restart },
    { "Quit", function() awesome.quit() end },
 }
 beautiful.menu_height=20
 beautiful.menu_width=180
 beautiful.menu_bg_normal="#374247"
 beautiful.menu_bg_focus="f7f4e0"
 --beautiful.menu_fg_normal=""
 beautiful.menu_fg_focus="374247"

 mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                     { "open terminal", "xfce4-terminal" },
                                     { " firefox", "firefox" },
                                     { " brave", "brave" },
                                     { " vs code", "code" },
                                     { " files", "nautilus" }
                                   }
                         })
 
 mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                      menu = mymainmenu })
 

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}

beautiful.menubar_border_width=25
beautiful.menubar_width=850
beautiful.menubar_height=850

beautiful.menubar_all_categories=true
-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ alt }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ alt }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox

end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ alt,           }, "h",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ alt, "Control" }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "workspace"}),
    awful.key({ alt, "Control" }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "workspace"}),
    awful.key({ alt,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "workspace"}),

    --awful.key({ alt,           }, "s",
    --    function ()
    --        awful.client.focus.byidx( 1)
    --    end,
    --    {description = "focus next by index", group = "client"}
    --),
    --awful.key({ alt,           }, "w",
    --    function ()
    --        awful.client.focus.byidx(-1)
    --    end,
    --    {description = "focus previous by index", group = "client"}
    --),
    
    awful.key({ alt }, "a", function()
        awful.client.focus.bydirection("left")
        if client.focus then client.focus:raise() end
    end),
    awful.key({ alt }, "s", function()
        awful.client.focus.bydirection("down")
        if client.focus then client.focus:raise() end
    end),
    awful.key({ alt }, "w", function()
        awful.client.focus.bydirection("up")
        if client.focus then client.focus:raise() end
    end),
    awful.key({ alt }, "d", function()
        awful.client.focus.bydirection("right")
        if client.focus then client.focus:raise() end
    end),

-- Move client to next tag
awful.key({ alt, "Shift" , "Control",}, "Right",
function()
    if client.focus then
        local s = awful.screen.focused()
        if s.selected_tag then
        local t = (s.selected_tag.index % 9 + 1)
        local tag = s.tags[t]
        client.focus:move_to_tag(tag)
        awful.tag.viewnext()
        end
end
end,
{description = "Move client to next tag", group = "workspace" }),

-- Move client to prev tag
awful.key({ alt, "Shift", "Control",}, "Left",
function()
    if client.focus then
        local s = awful.screen.focused()
        if s.selected_tag then
        local t = s.selected_tag.index - 1
        if t == 0 then t = 9 end
        local tag = s.tags[t]
        client.focus:move_to_tag(tag)
        awful.tag.viewprev()
        end
  end
end,
{description = "Move client to next tag", group = "workspace" }),

-- Move client to next tag no move preview
awful.key({ alt, "Shift" , }, "Right",
function()
    if client.focus then
        local s = awful.screen.focused()
        if s.selected_tag then
        local t = (s.selected_tag.index % 9 + 1)
        local tag = s.tags[t]
        client.focus:move_to_tag(tag)
        --awful.tag.viewnext()
        end
end
end,
{description = "Move client to next tag", group = "workspace" }),

-- Move client to prev tag no move preview
awful.key({ alt, "Shift",}, "Left",
function()
    if client.focus then
        local s = awful.screen.focused()
        if s.selected_tag then
        local t = s.selected_tag.index - 1
        if t == 0 then t = 9 end
        local tag = s.tags[t]
        client.focus:move_to_tag(tag)
        --awful.tag.viewprev()
        end
  end
end,
{description = "Move client to next tag", group = "workspace" }),

    awful.key({ alt,           }, "r", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation

    awful.key({ alt, "Shift"   }, "s", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "window"}),
    awful.key({ alt, "Shift"   }, "w", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "window"}),
    awful.key({ alt, "Control" }, "Up", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ alt, "Control" }, "Down", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ alt,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "window"}),
    awful.key({ alt,           }, "",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ alt,           }, "Return", function () awful.spawn(terminal) end,
            {description = "open a terminal", group = "apps"}),
    awful.key({ alt, "Control" }, "r", awesome.restart,
            {description = "reload awesome", group = "awesome"}),
    awful.key({ alt, "Shift"   }, "q", awesome.quit,
            {description = "quit awesome", group = "awesome"}),

    -- TECLAS DE FUNCIONES
    --- Brillo
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn("brightnessctl set 5%+ -q", false)
		awesome.emit_signal("widget::brightness")
		awesome.emit_signal("module::brightness_osd:show", true)
	end, { description = "increase brightness", group = "hotkeys" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn("brightnessctl set 5%- -q", false)
		awesome.emit_signal("widget::brightness")
		awesome.emit_signal("module::brightness_osd:show", true)
	end, { description = "decrease brightness", group = "hotkeys" }),
	
    --- Volume control
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%", false)
		awesome.emit_signal("widget::volume")
		awesome.emit_signal("module::volume_osd:show", true)
	end, { description = "increase volume", group = "hotkeys" }),
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%", false)
		awesome.emit_signal("widget::volume")
		awesome.emit_signal("module::volume_osd:show", true)
	end, { description = "decrease volume", group = "hotkeys" }),
	awful.key({}, "XF86AudioMute", function()
		awful.spawn("amixer sset Master toggle", false)
	end, { description = "mute volume", group = "hotkeys" }),

	--- Music
    -- Media Keys
    awful.key({}, "XF86AudioPlay", function()
        awful.util.spawn("playerctl play-pause", false) end),
    awful.key({}, "XF86AudioNext", function()
        awful.util.spawn("playerctl next", false) end),
    awful.key({}, "XF86AudioPrev", function()
        awful.util.spawn("playerctl previous", false) end),

    -- Open VSCODE, VIVAILDY FIREFOX

    awful.key({ alt, "Control" }, "v", function () awful.spawn("brave") end,
    {description = "brave", group = "apps"}),
    awful.key({ alt, "Control" }, "b", function () awful.spawn("notion-app") end,
    {description = "notion", group = "apps"}),
    awful.key({ alt, "Control" }, "x", function () awful.spawn("brave-browser") end,
    {description = "brave-browser ", group = "apps"}),
    awful.key({ alt, "Control" }, "c", function () awful.spawn("code") end,
    {description = "code", group = "apps"}),
    awful.key({ alt, "Control" }, "t", function () awful.spawn("gnome-text-editor") end,
    {description = "nautilus", group = "apps"}),
    awful.key({ super            }, "e", function () awful.spawn("nautilus") end,
    {description = "nautilus", group = "apps"}),
    awful.key({                   }, "Print", function () awful.spawn("flameshot gui") end,
    {description = "flameshot", group = "apps"}),
    awful.key({ super            }, "r", function () awful.spawn("/home/b4391co/.config/hypr/scripts/rofilaunch.sh d") end,
    {description = "rofi", group = "apps"}),
    awful.key({ alt,           }, "Tab", function () awful.spawn("/home/b4391co/.config/hypr/scripts/rofilaunch.sh w") end,
    {description = "rofi", group = "apps"}),
    awful.key({ super,  "Shift"  }, "r", function () awful.spawn("/home/b4391co/.config/hypr/scripts/rofilaunch.sh s") end,
    {description = "rofi", group = "apps"}),
    awful.key({ super,  "Shift"  }, "e", function () awful.spawn("/home/b4391co/.config/hypr/scripts/rofilaunch.sh f") end,
    {description = "rofi", group = "apps"}),
    awful.key({ super,           }, "l", function () awful.spawn("i3lock-fancy") end,
    {description = "i3lock", group = "apps"}),

    awful.key({ alt, "Control" }, "d",     function () awful.tag.incmwfact( 0.02)          end,
              {description = "increase master width factor", group = "window"}),
    awful.key({ alt, "Control" }, "a",     function () awful.tag.incmwfact(-0.02)          end,
              {description = "decrease master width factor", group = "window"}),
    awful.key({ alt, "Shift"   }, "d",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "workspace"}),
    awful.key({ alt, "Shift"   }, "a",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "workspace"}),
    --awful.key({ alt, "Control" }, "d",     function () awful.tag.incncol( 1, nil, true)    end,
    --          {description = "increase the number of columns", group = "layout"}),
    --awful.key({ alt, "Control" }, "a",     function () awful.tag.incncol(-1, nil, true)    end,
    --          {description = "decrease the number of columns", group = "layout"}),
    awful.key({ alt,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ alt, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ alt, "Control" }, "s", function () awful.client.incwfact(0.05) end,
            {description = "increase window width factor", group = "window"}),
    awful.key({ alt, "Control" }, "w", function () awful.client.incwfact(-0.05) end,
            {description = "decrease window width factor", group = "window"}),
    

    awful.key({ alt, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "window"}),

    -- Prompt
    awful.key({ alt },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "apps"}),

    awful.key({ alt }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ alt }, "m", function() menubar.show() end,
              {description = "show the menubar", group = "apps"})
)

beautiful.border_width = 3

-- Mouse bindings
root.buttons(gears.table.join(
    -- Resize by dragging the edges
    awful.button({ }, 3, function () awful.mouse.resize.set() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))


client.disconnect_signal("request::geometry", awful.mouse.resize_handler)
client.connect_signal("request::geometry", function(c, context, hints)
    local t = c.screen.selected_tag
    local lay = t and t.layout or nil

    if context == "mouse.resize" and (
      c.floating or lay == awful.layout.suit.floating
    ) then
        hints = gears.table.clone(hints)
        local geo = c:geometry()
        local aspect = geo.width / geo.height
        hints.width = math.min(hints.width, aspect * hints.height)
        hints.height = math.min(hints.height, hints.width / aspect)
        hints.width, hints.height = gears.math.round(hints.width), gears.math.round(hints.height)
    end

    return awful.mouse.resize_handler(c, context, hints)
end)


clientkeys = gears.table.join(
    awful.key({ alt,           }, "g",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
            awful.spawn.with_shell("~/.config/awesome/fs.sh")
        end,
        {description = "toggle fullscreen", group = "window"}),
    awful.key({ alt, "Control"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "window"}),
    awful.key({alt, "Control" }, "space", function(c) -- Center and raise floating windows if there is more than one
        awful.client.floating.toggle(c)
        local num_tiled_clients = 0
        for _ in pairs(c.screen.tiled_clients) do num_tiled_clients = num_tiled_clients + 1 end
        if num_tiled_clients >= 1 then
        awful.placement.centered(c, nil)
        end
        c:raise()
    end,
    {
        description = "Toggle floating",
        group = "client"
    }
    ),
    awful.key({ alt,"Control", "Shift", }, "Down",      function (c) c:move_to_screen(-1)               end,
              {description = "move to screen", group = "screen"}),
    awful.key({ alt, "Control", "Shift", }, "Up",      function (c) c:move_to_screen(1)               end,
              {description = "move to screen", group = "screen"}),
    awful.key({ alt,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "window"}),
    awful.key({ alt,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "window"}),
    awful.key({ alt,           }, "f",
        function (c)
            c.maximized  = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "window"}),
    awful.key({ alt, "Control" }, "f",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "window"}),
    awful.key({ alt, "Shift"   }, "f",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "window"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ alt }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "workspace"}),
        -- Toggle tag display.
        awful.key({ alt, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "workspace"}),
        -- Move client to tag.
        awful.key({ alt, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "workspace"}),
        -- Toggle tag on focused client.
        awful.key({ alt, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "workspace"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ alt }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ alt }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)


beautiful.titlebar_bg_normal="#141414"
beautiful.titlebar_bg="#141414"
-- Create titlebar
client.connect_signal('request::titlebars', function (c)
    local titlebar = awful.titlebar(c, {
        position = 'top',
        size = 10
    })

    local titlebars_buttons = {
        awful.button({}, 1, function ()
            c:activate {
                context = 'titlebar',
                action = 'mouse_move',
            }
        end),
        awful.button({}, 3, function ()
            c:activate {
                context = 'titlebar',
                action = 'mouse_resize',
            }
        end)
    }

    local buttons_loader = {
        layout = wibox.layout.fixed.horizontal,
        buttons = titlebars_buttons,
    }

    local function paddined_button(button, margins)
        margins = margins or {
            top = 11,
            bottom = 11,
            left = 4,
            right = 4
        }

        return wibox.widget {
            button,
            top = margins.top,
            bottom = margins.bottom,
            left = margins.left,
            right = margins.right, 
            widget = wibox.container.margin,
        }
    end

    titlebar:setup {
        {
            paddined_button(awful.titlebar.widget.closebutton(c), {
                top = 13,
                bottom = 13,
                right = 4,
                left = 14
            }),
            paddined_button(awful.titlebar.widget.maximizedbutton(c)),
            paddined_button(awful.titlebar.widget.minimizebutton(c)),
            layout = wibox.layout.fixed.horizontal,
        },
        buttons_loader,
        buttons_loader,
        layout = wibox.layout.align.horizontal
    }
end)

-- custom config
beautiful.useless_gap=3

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

awful.spawn.with_shell("nitrogen --restore")
local wallpaper_cmd="feh --bg-fill /home/b4391co/Pictures/wallpaper.png"
os.execute(wallpaper_cmd)


local show_volume_notification = function()
    local command = "sleep 0.09 ; pactl list sinks | grep Volume | grep -oaE '..[0-9]%' | awk 'FNR == 1 {print}'"
    awful.spawn.easy_async_with_shell(command, function(out) naughty.notify({ text = out, timeout = 1, position = "bottom_middle", replaces_id = 1}) end)
end  


