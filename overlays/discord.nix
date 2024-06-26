# Enable OpenASAR for Discord
{...}: _final: prev: rec {
  discord-openasar = prev.discord.override {withOpenASAR = true;};
}
