let
  nixenvString = ''nix-env -f "<nixpkgs>" -qaP'';
  ytfzf = "ytfzf --detach --show-thumbnails --thumb-viewer=kitty";
in
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
  l = "ls -lh";
  lb = "lsblk";
  lg = "lazygit";
  ll = "ls -lah";
  md = "mkdir -p";
  ned = "nix-env -qaP --description";
  nf = "nix fmt";
  nfu = "nix flake upate --commit-lock-file";
  nr = "nix run nixpkgs#";
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
  yf = "${ytfzf}";
  yl = "${ytfzf} --loop";
  x = "xdg-open";
  # Mpv
  m = "mpv";
  mfs = "mpv --fs";
  sm = "setsid mpv";
  u = "umpv";
  # Flatpak
  fi = "flatpak install --assumeyes";
  fl = "flatpak list";
  fs = "flatpak search";
  fu = "flatpak update --assumeyes";
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
  # Gopass
  gp = "gopass";
  gn = "gopass new";
  # Kitty
  icat = "kitty +kitten icat";
  # Download stuff
  dmp = "download-music-playlist";
  dmu = "download-music-unique";
  dvp = "download-video-playlist";
  dvu = "download-video-unique";
  # Nix
  c = "check-modifications";
  nb = "nix build";
  nbf = "nix build -f ./.";
  nodep = "${nixenvString} nodePackages";
  nph = "nix profile history";
  npi = "nix profile install";
  npl = "nix profile list";
  npr = "nix profile remove";
  npra = "nix profile remove '.*'";
  nprb = "nix profile rollback";
  npu = "nix profile upgrade";
  up = ''sudo nixos-rebuild switch --upgrade --profile-name $(date +%s)-'';
  # trash-cli
  rm = "trash-put";
  te = "trash-empty";
  tp = "trash-put";
  tr = "trash-restore";
  # Quickemu
  qe = "quickemu";
  qg = "quickget";
}
