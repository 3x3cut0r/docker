#!/bin/sh
set -e
#####################
# setup environment #
#####################

# copy from template
cp /usr/share/nginx/template/index.html /usr/share/nginx/html/index.html

# TIMEZONE
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# TITLE
sed -i "s/<title>.*<\/title>/<title>${TITLE}<\/title>/g" /usr/share/nginx/html/index.html

# LINK
sed -i "13s#https://www.enationalelectronics.com#${LINK}#" /usr/share/nginx/html/css/styles.css

##############
# set colors #
##############

# BG
sed -i "2s/.*/  background-color: ${BG};/" /usr/share/nginx/html/css/styles.css
sed -i "3s/.*/  background: radial-gradient(at 50% -20%, ${BG-PRIMARY}, ${BG-SECONDARY}) fixed;/" /usr/share/nginx/html/css/styles.css

# GROUND
sed -i "49s/#2F1829/${GROUND-TOP}/" /usr/share/nginx/html/index.html
sed -i "28s/#2F1829/${GROUND-BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "71s/#2F1829/${GROUND-RIGHT}/" /usr/share/nginx/html/index.html
sed -i "75s/#2F1829/${GROUND-LEFT}/" /usr/share/nginx/html/index.html

# NUMBER-LEFT
sed -i "895s/#3B223C/${NUMBER-LEFT-TOP}/" /usr/share/nginx/html/index.html
sed -i "894s/#2F1829/${NUMBER-LEFT-BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "150s/white/${NUMBER-LEFT-REFLECTION}/" /usr/share/nginx/html/index.html

# NUMBER-MIDDLE
sed -i "905s/#3B223C/${NUMBER-MIDDLE-TOP}/" /usr/share/nginx/html/index.html
sed -i "904s/#2F1829/${NUMBER-MIDDLE-BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "924s/#2F1829/${NUMBER-MIDDLE-LEAF-TOP}/" /usr/share/nginx/html/index.html
sed -i "925s/#3B223C/${NUMBER-MIDDLE-LEAF-BOTTOM}/" /usr/share/nginx/html/index.html

# NUMBER-RIGHT
sed -i "915s/#3B223C/${NUMBER-RIGHT-TOP}/" /usr/share/nginx/html/index.html
sed -i "914s/#2F1829/${NUMBER-RIGHT-BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "155s/white/${NUMBER-RIGHT-REFLECTION}/" /usr/share/nginx/html/index.html

# SHRUB
sed -i "129s/#982245/${SHRUB-MIDDLE}/" /usr/share/nginx/html/index.html
sed -i "753s/#982245/${SHRUB-RIGHT}/" /usr/share/nginx/html/index.html
sed -i "814s/#982245/${SHRUB-LEFT}/" /usr/share/nginx/html/index.html

# LEAF
sed -i "718s/#FFADAE/${LEAF-1}/" /usr/share/nginx/html/index.html
sed -i "779s/#FFADAE/${LEAF-1}/" /usr/share/nginx/html/index.html
sed -i "86s/#F3475C/${LEAF-2}/" /usr/share/nginx/html/index.html
sed -i "736s/#F3475C/${LEAF-2}/" /usr/share/nginx/html/index.html
sed -i "779s/#F3475C/${LEAF-2}/" /usr/share/nginx/html/index.html
sed -i "112s/#FFCA51/${LEAF-3}/" /usr/share/nginx/html/index.html
sed -i "700s/#FFCA51/${LEAF-3}/" /usr/share/nginx/html/index.html
sed -i "684s/#2F1829/${LEAF-RIGHT}/" /usr/share/nginx/html/index.html
sed -i "103s/black/${LEAF-MIDDLE}/" /usr/share/nginx/html/index.html
sed -i "762s/#2F1829/${LEAF-MIDDLE-RIGHT}/" /usr/share/nginx/html/index.html
sed -i "823s/#2F1829/${LEAF-MIDDLE-LEFT}/" /usr/share/nginx/html/index.html
sed -i "80s/black/${LEAF-LEFT}/" /usr/share/nginx/html/index.html

# CLOUD-BG
sed -i "835s/#FEF5DA/${CLOUD-BG-TOP}/" /usr/share/nginx/html/index.html
sed -i "834s/#E8D197/${CLOUD-BG-BOTTOM}/" /usr/share/nginx/html/index.html

# CLOUD-BG
sed -i "875s/#FEF5DA/${CLOUD-BG-RIGHT}/" /usr/share/nginx/html/index.html
sed -i "874s/#E8D197/${CLOUD-BG-RIGHT-SHADOW}/" /usr/share/nginx/html/index.html

# CLOUD-BG
sed -i "885s/#FEF5DA/${CLOUD-BG-LEFT}/" /usr/share/nginx/html/index.html
sed -i "884s/#E8D197/${CLOUD-BG-LEFT-SHADOW}/" /usr/share/nginx/html/index.html

# CLOUD-RIGHT
sed -i "854s/white/${CLOUD-RIGHT-TOP}/" /usr/share/nginx/html/index.html
sed -i "855s/white/${CLOUD-RIGHT-BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "54s/white/${CLOUD-RIGHT-TOP-SHADOW}/" /usr/share/nginx/html/index.html

# CLOUD-LEFT
sed -i "864s/white/${CLOUD-LEFT-TOP}/" /usr/share/nginx/html/index.html
sed -i "865s/white/${CLOUD-LEFT-BOTTOM}/" /usr/share/nginx/html/index.html
sed -i "59s/white/${CLOUD-LEFT-TOP-SHADOW}/" /usr/share/nginx/html/index.html

# MAN
sed -i "213s/#2F172B/${MAN-HAIR}/" /usr/share/nginx/html/index.html
sed -i "225s/#FFCA51/${MAN-SHIRT}/" /usr/share/nginx/html/index.html
sed -i "405s/#2F1829/${MAN-SLEEVE-LEFT}/" /usr/share/nginx/html/index.html
sed -i "209s/#2F1829/${MAN-SLEEVE-RIGHT}/" /usr/share/nginx/html/index.html
sed -i "296s/#2F1829/${MAN-PANTS}/" /usr/share/nginx/html/index.html
sed -i "376s/#4C3146/${MAN-PANTS-LEFT}/" /usr/share/nginx/html/index.html
sed -i "367s/#4C3146/${MAN-PANTS-RIGHT}/" /usr/share/nginx/html/index.html
sed -i "424s/#1F3247/${MAN-SHOE-LEFT}/" /usr/share/nginx/html/index.html
sed -i "446s/#122230/${MAN-SHOE-LEFT-TOP}/" /usr/share/nginx/html/index.html
sed -i "432s/#1F3247/${MAN-SHOE-RIGHT}/" /usr/share/nginx/html/index.html
sed -i "191s/#2F1829/${MAN-FLASHLIGHT}/" /usr/share/nginx/html/index.html
sed -i "944s/white/${MAN-FLASHLIGHT-NEAR}/" /usr/share/nginx/html/index.html
sed -i "945s/white/${MAN-FLASHLIGHT-FAR}/" /usr/share/nginx/html/index.html
sed -i "187s/white/${MAN-FLASHLIGHT-SHADOW}/" /usr/share/nginx/html/index.html

# WOMAN
sed -i "468s/#2F1829/${WOMAN-HAIR}/" /usr/share/nginx/html/index.html
sed -i "593s/#2F1829/${WOMAN-PONY}/" /usr/share/nginx/html/index.html
sed -i "472s/#F5B539/${WOMAN-SHIRT}/" /usr/share/nginx/html/index.html
sed -i "541s/#2F1829/${WOMAN-PANTS}/" /usr/share/nginx/html/index.html
sed -i "554s/#1F3247/${WOMAN-SHOE-LEFT}/" /usr/share/nginx/html/index.html
sed -i "550s/#1F3247/${WOMAN-SHOE-RIGHT}/" /usr/share/nginx/html/index.html
sed -i "658s/white/${WOMAN-SHOE-RIGHT-TOP}/" /usr/share/nginx/html/index.html
sed -i "568s/#2F1829/${WOMAN-FLASHLIGHT}/" /usr/share/nginx/html/index.html
sed -i "1004s/white/${WOMAN-FLASHLIGHT-NEAR}/" /usr/share/nginx/html/index.html
sed -i "1005s/white/${WOMAN-FLASHLIGHT-FAR}/" /usr/share/nginx/html/index.html

# start nginx
nginx -g "daemon off;"