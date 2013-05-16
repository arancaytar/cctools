os.loadAPI("aran/builder")

args = {...}

builder.buildPattern(builder.loadPattern(args[1]), tonumber(args[2]))
