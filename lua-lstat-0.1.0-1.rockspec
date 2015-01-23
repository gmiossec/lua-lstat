package = "lua-lstat"
version = "0.1.0-1"

source = {
   url = "git://git/lib/lua-lstat.git",
   tag = "0.1.0",
}

description = {
    summary = "Wrapper around lstat() system call",
    detailed = [[
	lua-lstat returns some system informations based on the lstat() system call.
	It cans return disk (mount point) and memory usage and, system uptime.
    ]],
    license = "WTFPL",
}

dependencies = {
    "lua >= 5.1, < 5.3"
}

build = {
    type = "builtin",
    modules = {
        lstat = {
            sources = { "lua-lstat.c" },
        }
    },
}
