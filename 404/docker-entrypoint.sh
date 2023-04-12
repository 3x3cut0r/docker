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
sed -i "9s/.*/\ \ \ \ <title>${TITLE}<\/title>/" /usr/share/nginx/html/index.html

# LINK
sed -i '12s|https://www\.enationalelectronics\.com|'"$LINK"'|g' /usr/share/nginx/html/index.html

##############
# set colors #
##############

# BG
sed -i "2s/.*/  background-color: ${BG};/" /usr/share/nginx/html/css/styles.css
sed -i "3s/.*/  background: radial-gradient(at 50% -20%, ${BG_PRIMARY}, ${BG_SECONDARY}) fixed;/" /usr/share/nginx/html/css/styles.css

# GROUND
sed -i "48s/#2F1829/${GROUND_TOP}/" /usr/share/nginx/html/index.html
sed -i "27s/#2F1829/${GROUND_BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "70s/#2F1829/${GROUND_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "74s/#2F1829/${GROUND_LEFT}/" /usr/share/nginx/html/index.html

# NUMBER_LEFT
sed -i "894s/#3B223C/${NUMBER_LEFT_TOP}/" /usr/share/nginx/html/index.html
sed -i "893s/#2F1829/${NUMBER_LEFT_BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "149s/white/${NUMBER_LEFT_REFLECTION}/" /usr/share/nginx/html/index.html

# NUMBER_MIDDLE
sed -i "904s/#3B223C/${NUMBER_MIDDLE_TOP}/" /usr/share/nginx/html/index.html
sed -i "903s/#2F1829/${NUMBER_MIDDLE_BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "923s/#2F1829/${NUMBER_MIDDLE_LEAF_TOP}/" /usr/share/nginx/html/index.html
sed -i "924s/#3B223C/${NUMBER_MIDDLE_LEAF_BOTTOM}/" /usr/share/nginx/html/index.html

# NUMBER_RIGHT
sed -i "914s/#3B223C/${NUMBER_RIGHT_TOP}/" /usr/share/nginx/html/index.html
sed -i "913s/#2F1829/${NUMBER_RIGHT_BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "154s/white/${NUMBER_RIGHT_REFLECTION}/" /usr/share/nginx/html/index.html

# SHRUB
sed -i "128s/#982245/${SHRUB_MIDDLE}/" /usr/share/nginx/html/index.html
sed -i "752s/#982245/${SHRUB_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "813s/#982245/${SHRUB_LEFT}/" /usr/share/nginx/html/index.html

# LEAF
sed -i "717s/#FFADAE/${LEAF_1}/" /usr/share/nginx/html/index.html
sed -i "778s/#FFADAE/${LEAF_1}/" /usr/share/nginx/html/index.html
sed -i "85s/#F3475C/${LEAF_2}/" /usr/share/nginx/html/index.html
sed -i "735s/#F3475C/${LEAF_2}/" /usr/share/nginx/html/index.html
sed -i "778s/#F3475C/${LEAF_2}/" /usr/share/nginx/html/index.html
sed -i "111s/#FFCA51/${LEAF_3}/" /usr/share/nginx/html/index.html
sed -i "699s/#FFCA51/${LEAF_3}/" /usr/share/nginx/html/index.html
sed -i "683s/#2F1829/${LEAF_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "102s/black/${LEAF_MIDDLE}/" /usr/share/nginx/html/index.html
sed -i "761s/#2F1829/${LEAF_MIDDLE_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "822s/#2F1829/${LEAF_MIDDLE_LEFT}/" /usr/share/nginx/html/index.html
sed -i "79s/black/${LEAF_LEFT}/" /usr/share/nginx/html/index.html

# CLOUD_BG
sed -i "834s/#FEF5DA/${CLOUD_BG_TOP}/" /usr/share/nginx/html/index.html
sed -i "833s/#E8D197/${CLOUD_BG_BOTTOM}/" /usr/share/nginx/html/index.html

# CLOUD_BG
sed -i "874s/#FEF5DA/${CLOUD_BG_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "873s/#E8D197/${CLOUD_BG_RIGHT_SHADOW}/" /usr/share/nginx/html/index.html

# CLOUD_BG
sed -i "884s/#FEF5DA/${CLOUD_BG_LEFT}/" /usr/share/nginx/html/index.html
sed -i "883s/#E8D197/${CLOUD_BG_LEFT_SHADOW}/" /usr/share/nginx/html/index.html

# CLOUD_RIGHT
sed -i "853s/white/${CLOUD_RIGHT_TOP}/" /usr/share/nginx/html/index.html
sed -i "854s/white/${CLOUD_RIGHT_BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "53s/white/${CLOUD_RIGHT_TOP_SHADOW}/" /usr/share/nginx/html/index.html

# CLOUD_LEFT
sed -i "863s/white/${CLOUD_LEFT_TOP}/" /usr/share/nginx/html/index.html
sed -i "864s/white/${CLOUD_LEFT_BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "58s/white/${CLOUD_LEFT_TOP_SHADOW}/" /usr/share/nginx/html/index.html

# MAN
sed -i "212s/#2F172B/${MAN_HAIR}/" /usr/share/nginx/html/index.html
sed -i "224s/#FFCA51/${MAN_SHIRT}/" /usr/share/nginx/html/index.html
sed -i "404s/#2F1829/${MAN_SLEEVE_LEFT}/" /usr/share/nginx/html/index.html
sed -i "208s/#2F1829/${MAN_SLEEVE_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "295s/#2F1829/${MAN_PANTS}/" /usr/share/nginx/html/index.html
sed -i "375s/#4C3146/${MAN_PANTS_LEFT}/" /usr/share/nginx/html/index.html
sed -i "366s/#4C3146/${MAN_PANTS_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "423s/#1F3247/${MAN_SHOE_LEFT}/" /usr/share/nginx/html/index.html
sed -i "445s/#122230/${MAN_SHOE_LEFT_TOP}/" /usr/share/nginx/html/index.html
sed -i "431s/#1F3247/${MAN_SHOE_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "190s/#2F1829/${MAN_FLASHLIGHT}/" /usr/share/nginx/html/index.html
sed -i "943s/white/${MAN_FLASHLIGHT_NEAR}/" /usr/share/nginx/html/index.html
sed -i "944s/white/${MAN_FLASHLIGHT_FAR}/" /usr/share/nginx/html/index.html
sed -i "186s/white/${MAN_FLASHLIGHT_SHADOW}/" /usr/share/nginx/html/index.html

# WOMAN
sed -i "467s/#2F1829/${WOMAN_HAIR}/" /usr/share/nginx/html/index.html
sed -i "592s/#2F1829/${WOMAN_PONY}/" /usr/share/nginx/html/index.html
sed -i "471s/#F5B539/${WOMAN_SHIRT}/" /usr/share/nginx/html/index.html
sed -i "540s/#2F1829/${WOMAN_PANTS}/" /usr/share/nginx/html/index.html
sed -i "553s/#1F3247/${WOMAN_SHOE_LEFT}/" /usr/share/nginx/html/index.html
sed -i "549s/#1F3247/${WOMAN_SHOE_RIGHT}/" /usr/share/nginx/html/index.html
sed -i "657s/white/${WOMAN_SHOE_RIGHT_TOP}/" /usr/share/nginx/html/index.html
sed -i "567s/#2F1829/${WOMAN_FLASHLIGHT}/" /usr/share/nginx/html/index.html
sed -i "1003s/white/${WOMAN_FLASHLIGHT_NEAR}/" /usr/share/nginx/html/index.html
sed -i "1004s/white/${WOMAN_FLASHLIGHT_FAR}/" /usr/share/nginx/html/index.html

# start nginx
exec nginx -g 'daemon off;'
