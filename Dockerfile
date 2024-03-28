FROM opengamehosting/steamcmd:stable 

ARG STEAM_USERNAME
ARG STEAM_PASSWORD

ARG GAME
ARG STEAM_APP_ID
ARG DEPOT_ID
ARG MANIFEST_ID

RUN curl -LSs https://github.com/dyc3/steamguard-cli/releases/download/v0.13.0/steamguard > /usr/local/bin/steamguard && chmod +x /usr/local/bin/steamguard

RUN --mount=type=secret,id=maFile,target=/root/.config/steamguard-cli/maFiles/steam.maFile  \
--mount=type=secret,id=maManifest,target=/root/.config/steamguard-cli/maFiles/manifest.json  \
/opt/steam/steamcmd.sh \
  +force_install_dir "/etc/ogh/depots/$STEAM_APP_ID/$DEPOT_ID/$MANIFEST_ID" \
  +login $STEAM_USERNAME $STEAM_PASSWORD $(steamguard code) \
  +download_depot $STEAM_APP_ID $DEPOT_ID $MANIFEST_ID \
  +quit