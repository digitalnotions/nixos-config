{ cofig, pkgs, ... }:

{
  networking.extraHosts = ''
  0.0.0.0 www.youtube.com
  0.0.0.0 play.google.com
  0.0.0.0 ytimg.com
  '';
  
}
  
