INSTALL=install
CC := $(CROSS_COMPILE)$(CC)
AR := $(CROSS_COMPILE)$(AR)

CFLAGS  += -O3 -Wall -Wextra -Wfatal-errors -std=gnu99 -pedantic -I include/
LDFLAGS += -s

DESTDIR ?= /usr/lib/
SOURCES := $(wildcard *.c)
OBJECTS := $(SOURCES:%.c=%.o)
TARGET  := lua-lstat.so
VERSION := 1

LUA_CFLAGS := `pkg-config lua5.1 --cflags`


.PHONY: all clean distclean install


%.o: %.c
	@echo "[lua-lstat] CC $<"
	@$(CC) $(CFLAGS) $(LUA_CFLAGS) -fPIC -c $< -o $@

$(TARGET): $(OBJECTS)
	@echo "[lua-lstat] LD $@"
	@$(CC) -shared -Wl,-soname,$@.$(VERSION) -o $@ $^ $(LDFLAGS) -lrt

clean:
	@echo "[lua-lstat] Clean"
	@$(RM) $(OBJECTS)

distclean: clean
	@echo "[lua-lstat] Distclean"
	@$(RM) $(TARGET)

install: $(TARGET)
	@echo "[lua-lstat] Install"
	@$(INSTALL) -m 644 $(TARGET) $(PREFIX)$(DESTDIR)

rockspec:
	luarocks pack lua-lstat-0.1.0-1.rockspec
