{ config, pkgs, ... }:

{
  home.username = "braam";
  home.homeDirectory = "/home/braam";
  home.stateVersion = "24.11"; 

  home.packages = [
    pkgs.eza
    pkgs.fastfetch
    pkgs.ripgrep
    pkgs.nerd-fonts.monofur  
  ];

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  programs.emacs = {
    enable = true;
    package = with pkgs; (
      (emacsPackagesFor pkgs.emacs).emacsWithPackages (
        epkgs: [
          epkgs.vterm
	        
	        epkgs.melpaPackages.company

	        # language modes
	        epkgs.melpaPackages.nix-mode
	        epkgs.melpaPackages.go-mode
	        epkgs.melpaPackages.haskell-mode
	        
        ]
      )
    );
    extraConfig = ''
      (setq standard-indent 2)
    '';
  };

  programs.home-manager.enable = true;
}
  
