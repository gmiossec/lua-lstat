#include <fcntl.h>
#include <sys/statvfs.h>
#include <sys/sysinfo.h>

#include <errno.h>
#include <string.h>

#define LUA_LIB

#include <lua.h>
#include <lauxlib.h>


#define LUA_LSTAT_LIBNAME "lua-lstat"


static int
lua_stat_fs(lua_State *L)
{
	const char *path;
	struct statvfs stat;
	size_t free, size;

	path = luaL_checkstring(L, 1);
	if (statvfs(path, &stat) == -1)
		return luaL_error(L, "statfs() error: %s",  strerror(errno));
	lua_newtable(L);
	size = stat.f_frsize * stat.f_blocks;
	lua_pushnumber(L, size);
	lua_setfield(L, -2, "size");
	free = stat.f_frsize * stat.f_bfree;
	lua_pushnumber(L, free);
	lua_setfield(L, -2, "free");

	return 1;
}

static int
lua_stat_mem(lua_State *L)
{
	struct sysinfo info;

	if (sysinfo(&info) == -1)
		return luaL_error(L, "sysinfo() error: %s",  strerror(errno));
	lua_newtable(L);
	lua_pushnumber(L, info.totalram);
	lua_setfield(L, -2, "total");
	lua_pushnumber(L, info.freeram);
	lua_setfield(L, -2, "free");

	return 1;
}

static int
lua_stat_uptime(lua_State *L)
{
	struct sysinfo info;

	if (sysinfo(&info) == -1)
		return luaL_error(L, "sysinfo() error: %s",  strerror(errno));
	lua_pushnumber(L, info.uptime);

	return 1;
}

static const luaL_reg lstat_lib_f[] = {
	{ "fs", lua_stat_fs },
	{ "mem", lua_stat_mem },
	{ "uptime", lua_stat_uptime },
	{ NULL, NULL }
};


LUALIB_API int
luaopen_lstat(lua_State *L)
{
	luaL_register(L, LUA_LSTAT_LIBNAME, lstat_lib_f);

	return 1;
}
