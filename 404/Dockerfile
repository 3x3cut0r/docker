FROM nginx:stable-alpine
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="404 error page - based on nginx"

# copy html content
COPY html /usr/share/nginx/html
RUN mkdir -p /usr/share/nginx/template && \
    cp /usr/share/nginx/html/index.html /usr/share/nginx/template/index.html

WORKDIR /usr/share/nginx/html

# set environment variables
ENV TZ="UTC" \
    TITLE="404 Not Found" \
    LINK="https://404.3x3cut0r.de" \
    BG="#141019" \
    BG_PRIMARY="#908392" \
    BG_SECONDARY="#0d060e" \
    GROUND_TOP="#2F1829" \
    GROUND_BOTTOM="#2F1829" \
    GROUND_RIGHT="#2F1829" \
    GROUND_LEFT="#2F1829" \
    NUMBER_LEFT_TOP="#3B223C" \
    NUMBER_LEFT_BOTTOM="#2F1829" \
    NUMBER_LEFT_REFLECTION="white" \
    NUMBER_MIDDLE_TOP="#3B223C" \
    NUMBER_MIDDLE_BOTTOM="#2F1829" \
    NUMBER_MIDDLE_LEAF_TOP="#2F1829" \
    NUMBER_MIDDLE_LEAF_BOTTOM="#3B223C" \
    NUMBER_RIGHT_TOP="#3B223C" \
    NUMBER_RIGHT_BOTTOM="#2F1829" \
    NUMBER_RIGHT_REFLECTION="white" \
    SHRUB_MIDDLE="#982245" \
    SHRUB_RIGHT="#982245" \
    SHRUB_LEFT="#982245" \
    LEAF_1="#FFADAE" \
    LEAF_2="#F3475C" \
    LEAF_3="#FFCA51" \
    LEAF_RIGHT="#2F1829" \
    LEAF_MIDDLE="black" \
    LEAF_MIDDLE_RIGHT="#2F1829" \
    LEAF_MIDDLE_LEFT="#2F1829" \
    LEAF_LEFT="black" \
    CLOUD_BG_TOP="#FEF5DA" \
    CLOUD_BG_BOTTOM="#E8D197" \
    CLOUD_BG_RIGHT="#FEF5DA" \
    CLOUD_BG_RIGHT_SHADOW="#E8D197" \
    CLOUD_BG_LEFT="#FEF5DA" \
    CLOUD_BG_LEFT_SHADOW="#E8D197" \
    CLOUD_RIGHT_TOP="white" \
    CLOUD_RIGHT_BOTTOM="white" \
    CLOUD_RIGHT_TOP_SHADOW="white" \
    CLOUD_LEFT_TOP="white" \
    CLOUD_LEFT_BOTTOM="white" \
    CLOUD_LEFT_TOP_SHADOW="white" \
    MAN_HAIR="#2F172B" \
    MAN_SHIRT="#FFCA51" \
    MAN_SLEEVE_LEFT="#2F1829" \
    MAN_SLEEVE_RIGHT="#2F1829" \
    MAN_PANTS="#2F1829" \
    MAN_PANTS_LEFT="#4C3146" \
    MAN_PANTS_RIGHT="#4C3146" \
    MAN_SHOE_LEFT="#1F3247" \
    MAN_SHOE_LEFT_TOP="#122230" \
    MAN_SHOE_RIGHT="#1F3247" \
    MAN_FLASHLIGHT="#2F1829" \
    MAN_FLASHLIGHT_NEAR="white" \
    MAN_FLASHLIGHT_FAR="white" \
    MAN_FLASHLIGHT_SHADOW="white" \
    WOMAN_HAIR="#2F1829" \
    WOMAN_PONY="#2F1829" \
    WOMAN_SHIRT="#F5B539" \
    WOMAN_PANTS="#2F1829" \
    WOMAN_SHOE_LEFT="#1F3247" \
    WOMAN_SHOE_RIGHT="#1F3247" \
    WOMAN_SHOE_RIGHT_TOP="white" \
    WOMAN_FLASHLIGHT="#2F1829" \
    WOMAN_FLASHLIGHT_NEAR="white" \
    WOMAN_FLASHLIGHT_FAR="white" 

VOLUME /usr/share/nginx/html

# add docker-entrypoint.sh
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl --fail http://localhost:80 || exit 1