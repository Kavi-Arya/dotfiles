#!/bin/bash

dwmstuff ()
{
  rm -rf $HOME/.config/chadwm/config.h
  sudo make install
}
dwmstuff
