#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/minimal"
theme='default'

## Run
rofi \
  -show drun \
  -theme ${dir}/${theme}.rasi
