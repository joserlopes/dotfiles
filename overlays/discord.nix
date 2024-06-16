# overlays/discord.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/diogotcorreia/dotfiles
#
# Enable OpenASAR for Discord
{...}: _final: prev: rec {
  discord-openasar = prev.discord.override {withOpenASAR = true;};
}
