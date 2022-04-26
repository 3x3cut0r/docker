#!/bin/bash

# setup environment

# misc
TZ=${TZ:-"Europe/Berlin"}



# set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
