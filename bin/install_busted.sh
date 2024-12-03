#!/bin/bash

if ! luarocks show --tree lua_modules busted &>/dev/null; then
  echo "installing busted to lua_modules/ ..."
  luarocks install --tree lua_modules busted
fi
