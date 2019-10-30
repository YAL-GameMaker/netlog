/// netlog_fg_rgb(red, green, blue)
return chr(27) + "[38;2;"
    + string_format(argument0, 0, 0) + ";"
    + string_format(argument1, 0, 0) + ";"
    + string_format(argument2, 0, 0) + "m";
