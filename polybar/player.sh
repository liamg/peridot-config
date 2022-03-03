#!/bin/bash

playerctl metadata --format '%{A1:playerctl play-pause:}%{F#F0C674}@{{ status }}@%{F-} {{ title }} %{F#666666}-%{F-} {{ artist }} %{F#666666}{{duration(position)}}/{{duration(mpris:length)}}%{F-}%{A}' --follow | sed -u 's/@Playing@/契/; s/@Paused@//; s/@Stopped@/栗/'

