#!/bin/sh
set -e
#####################
# setup environment #
#####################

# copy from template
cp /usr/share/nginx/template/index.html /usr/share/nginx/html/index.html
cp /usr/share/nginx/template/css/styles.css /usr/share/nginx/html/css/styles.css
cp /usr/share/nginx/template/js/script.js /usr/share/nginx/html/js/script.js

# TIMEZONE
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# TITLE
sed -i "10s/.*/\ \ \ \ <title>${TITLE}<\/title>/" /usr/share/nginx/html/index.html

# LINK
sed -i '13s|https://www\.enationalelectronics\.com|'"$LINK"'|g' /usr/share/nginx/html/index.html

##############
# set colors #
##############

# BG
sed -i "2s/.*/  background-color: ${BG};/" /usr/share/nginx/html/css/styles.css
sed -i "3s/.*/  background: radial-gradient(at 50% -20%, ${BG-PRIMARY}, ${BG-SECONDARY}) fixed;/" /usr/share/nginx/html/css/styles.css

# GROUND
sed -i "49s/#2F1829/${GROUND_TOP}/" /usr/share/nginx/html/index.html
sed -i "28s/#2F1829/${GROUND_BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "71s/#2F1829/${GROUND_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "75s/#2F1829/${GROUND_LEFT}/" /usr/share/nginx/html/index.html

# NUMBER_LEFT
sed -i "895s/#3B223C/${NUMBER_LEFT_TOP}/" /usr/share/nginx/html/index.html
sed -i "894s/#2F1829/${NUMBER_LEFT_BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "150s/white/${NUMBER_LEFT_REFLECTION}/" /usr/share/nginx/html/index.html

# NUMBER_MIDDLE
sed -i "905s/#3B223C/${NUMBER_MIDDLE_TOP}/" /usr/share/nginx/html/index.html
sed -i "904s/#2F1829/${NUMBER_MIDDLE_BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "924s/#2F1829/${NUMBER_MIDDLE_LEAF_TOP}/" /usr/share/nginx/html/index.html
sed -i "925s/#3B223C/${NUMBER_MIDDLE_LEAF_BOTTOM}/" /usr/share/nginx/html/index.html

# NUMBER_RIGHT
sed -i "915s/#3B223C/${NUMBER_RIGHT_TOP}/" /usr/share/nginx/html/index.html
sed -i "914s/#2F1829/${NUMBER_RIGHT_BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "155s/white/${NUMBER_RIGHT_REFLECTION}/" /usr/share/nginx/html/index.html

# SHRUB
sed -i "129s/#982245/${SHRUB_MIDDLE}/" /usr/share/nginx/html/index.html
sed -i "753s/#982245/${SHRUB_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "814s/#982245/${SHRUB_LEFT}/" /usr/share/nginx/html/index.html

# LEAF
sed -i "718s/#FFADAE/${LEAF_1}/" /usr/share/nginx/html/index.html
sed -i "779s/#FFADAE/${LEAF_1}/" /usr/share/nginx/html/index.html
sed -i "86s/#F3475C/${LEAF_2}/" /usr/share/nginx/html/index.html
sed -i "736s/#F3475C/${LEAF_2}/" /usr/share/nginx/html/index.html
sed -i "779s/#F3475C/${LEAF_2}/" /usr/share/nginx/html/index.html
sed -i "112s/#FFCA51/${LEAF_3}/" /usr/share/nginx/html/index.html
sed -i "700s/#FFCA51/${LEAF_3}/" /usr/share/nginx/html/index.html
sed -i "684s/#2F1829/${LEAF_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "103s/black/${LEAF_MIDDLE}/" /usr/share/nginx/html/index.html
sed -i "762s/#2F1829/${LEAF_MIDDLE_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "823s/#2F1829/${LEAF_MIDDLE_LEFT}/" /usr/share/nginx/html/index.html
sed -i "80s/black/${LEAF_LEFT}/" /usr/share/nginx/html/index.html

# CLOUD_BG
sed -i "835s/#FEF5DA/${CLOUD_BG_TOP}/" /usr/share/nginx/html/index.html
sed -i "834s/#E8D197/${CLOUD_BG_BOTTOM}/" /usr/share/nginx/html/index.html

# CLOUD_BG
sed -i "875s/#FEF5DA/${CLOUD_BG_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "874s/#E8D197/${CLOUD_BG_RIGHT_SHADOW}/" /usr/share/nginx/html/index.html

# CLOUD_BG
sed -i "885s/#FEF5DA/${CLOUD_BG_LEFT}/" /usr/share/nginx/html/index.html
sed -i "884s/#E8D197/${CLOUD_BG_LEFT_SHADOW}/" /usr/share/nginx/html/index.html

# CLOUD_RIGHT
sed -i "854s/white/${CLOUD_RIGHT_TOP}/" /usr/share/nginx/html/index.html
sed -i "855s/white/${CLOUD_RIGHT_BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "54s/white/${CLOUD_RIGHT_TOP_SHADOW}/" /usr/share/nginx/html/index.html

# CLOUD_LEFT
sed -i "864s/white/${CLOUD_LEFT_TOP}/" /usr/share/nginx/html/index.html
sed -i "865s/white/${CLOUD_LEFT_BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "59s/white/${CLOUD_LEFT_TOP_SHADOW}/" /usr/share/nginx/html/index.html

# MAN
sed -i "213s/#2F172B/${MAN_HAIR}/" /usr/share/nginx/html/index.html
sed -i "225s/#FFCA51/${MAN_SHIRT}/" /usr/share/nginx/html/index.html
sed -i "405s/#2F1829/${MAN_SLEEVE_LEFT}/" /usr/share/nginx/html/index.html
sed -i "209s/#2F1829/${MAN_SLEEVE_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "296s/#2F1829/${MAN_PANTS}/" /usr/share/nginx/html/index.html
sed -i "376s/#4C3146/${MAN_PANTS_LEFT}/" /usr/share/nginx/html/index.html
sed -i "367s/#4C3146/${MAN_PANTS_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "424s/#1F3247/${MAN_SHOE_LEFT}/" /usr/share/nginx/html/index.html
sed -i "446s/#122230/${MAN_SHOE_LEFT_TOP}/" /usr/share/nginx/html/index.html
sed -i "432s/#1F3247/${MAN_SHOE_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "191s/#2F1829/${MAN_FLASHLIGHT}/" /usr/share/nginx/html/index.html
sed -i "944s/white/${MAN_FLASHLIGHT_NEAR}/" /usr/share/nginx/html/index.html
sed -i "945s/white/${MAN_FLASHLIGHT_FAR}/" /usr/share/nginx/html/index.html
sed -i "187s/white/${MAN_FLASHLIGHT_SHADOW}/" /usr/share/nginx/html/index.html

# WOMAN
sed -i "468s/#2F1829/${WOMAN_HAIR}/" /usr/share/nginx/html/index.html
sed -i "593s/#2F1829/${WOMAN_PONY}/" /usr/share/nginx/html/index.html
sed -i "472s/#F5B539/${WOMAN_SHIRT}/" /usr/share/nginx/html/index.html
sed -i "541s/#2F1829/${WOMAN_PANTS}/" /usr/share/nginx/html/index.html
sed -i "554s/#1F3247/${WOMAN_SHOE_LEFT}/" /usr/share/nginx/html/index.html
sed -i "550s/#1F3247/${WOMAN_SHOE_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "658s/white/${WOMAN_SHOE_RIGHT_TOP}/" /usr/share/nginx/html/index.html
sed -i "568s/#2F1829/${WOMAN_FLASHLIGHT}/" /usr/share/nginx/html/index.html
sed -i "1004s/white/${WOMAN_FLASHLIGHT_NEAR}/" /usr/share/nginx/html/index.html
sed -i "1005s/white/${WOMAN_FLASHLIGHT_FAR}/" /usr/share/nginx/html/index.html

# start nginx
exec nginx -g 'daemon off;'
