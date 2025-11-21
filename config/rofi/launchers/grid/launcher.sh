#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/grid"
theme='default'

## Run
rofi \
  -show drun \
  -theme ${dir}/${theme}.rasi
