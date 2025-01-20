{
  ...

}: {
  services.uptime-kuma = {
    enable = true;
    settings.PORT = "5002";
  };
}
