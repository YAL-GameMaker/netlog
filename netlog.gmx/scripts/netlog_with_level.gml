/// netlog_with_level(level, level_red, level_green, level_blue, message)
return netlog(netlog_bg_rgb(0, 0, 0)
    + netlog_fg_rgb(255, 255, 255) + "["
    + netlog_fg_rgb(argument1, argument2, argument3) + argument0
    + netlog_fg_rgb(255, 255, 255) + "] "
    + argument4
);
