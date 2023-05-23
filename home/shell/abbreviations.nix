{
  # General
  cl = "curl -L";
  clo = "curl -LO";
  cnf = "command-not-found";
  cp = "cp -i";
  mv = "mv -i";
  duts = "dust";
  e = "$EDITOR";
  fex = "fd --extension";
  lb = "lsblk";
  lg = "lazygit";
  md = "mkdir -p";
  ned = "nix-env -qaP --description";
  nf = "nix fmt";
  nfu = "nix flake update --commit-lock-file";
  nr = "nix run nixpkgs#";
  nfst = "nix flake show templates";
  nrh = "nixpkgs-review rev HEAD";
  nrp = "nixpkgs-review pr --post-result";
  nrw = "nixpkgs-review wip";
  ns = "nix search nixpkgs";
  nsp = "nix-shell -p";
  nup = "nix-update --test --commit --review";
  qr = "qrencode -t ansiutf8";
  sid = "setsid";
  snp = "show-nix-store-path";
  ss = "show-script";
  tl = "tldr";
  v = "nvim";
  wl = "watchlist";
  x = "xdg-open";
  # Listing
  l = "ls -lh";
  ll = "ls -lah";
  lss = "ls -lh";
  lls = "ls -lah";
  # Mpv
  m = "mpv";
  mfs = "mpv --fs";
  sm = "setsid mpv";
  u = "umpv";
  umfs = "umpv --fs";
  # Flatpak
  fi = "flatpak install --assumeyes";
  fl = "flatpak list";
  fs = "flatpak search";
  fu = "flatpak update --assumeyes && flatpak uninstall --unused --assumeyes";
  fun = "flatpak uninstall --assumeyes";
  # Git
  gca = "git commit -a";
  gcb = "git checkout -b";
  gch = "git checkout";
  gcm = "git checkout master || git checkout main";
  gl = "git log --oneline --decorate --graph --all";
  gr = "git revert";
  pll = "git pull";
  psh = "git push";
  psf = "git push --force-with-lease";
  pum = "git pull upstream master";
  pump = "git pull upstream master && git push";
  pur = "git pull upstream master --rebase";
  # Kitty
  icat = "kitty +kitten icat";
  # Download stuff
  dmp = "download-music-playlist";
  dmu = "download-music-unique";
  dvp = "download-video-playlist";
  dvu = "download-video-unique";
  # Nix
  cm = "check-modifications";
  cu = "check-updates";
  nb = "nix build";
  nbf = "nix build -f ./.";
  nph = "nix profile history";
  npi = "nix profile install";
  npl = "nix profile list";
  npr = "nix profile remove";
  npra = "nix profile remove '.*'";
  nprb = "nix profile rollback";
  npu = "nix profile upgrade";
  up = ''sudo nixos-rebuild switch --profile-name $(date +%s)-'';
  # trash-cli
  rm = "trash-put";
  te = "trash-empty";
  tp = "trash-put";
  tr = "trash-restore";
  # Quickemu
  qe = "quickemu";
  qg = "quickget";
}
