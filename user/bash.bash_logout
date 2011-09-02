###
## /etc/bash.bash_logout  -  Generic bash logout script
## Copyright (C) 2006       Kyle Moffett <kyle@moffetthome.net>
## Copyright (C) 2007-2011  eXMeritus, A Boeing Company
##
## This program is free software; you can redistribute it and/or modify it
## under the terms of version 2 of the GNU General Public License, as
## published by the Free Software Foundation.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
## for more details.
##
## You should have received a copy of the GNU General Public License along
## with this program; otherwise you can obtain it here:
##   http://www.gnu.org/licenses/gpl-2.0.txt
###

## Make sure to clear the screen on logout (for privacy reasons)
[ ! -x /usr/bin/clear ] || /usr/bin/clear

## If it's a virtual terminal, try to clear the scrollback buffer too
[ ! -x /usr/bin/clear_console ] || /usr/bin/clear_console -q

# vim:set ft=sh:
