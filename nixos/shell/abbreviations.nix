let
  nixenvString = "nix-env -f '<nixpkgs>' -qaP";
  ytfzf = "ytfzf --detach --show-thumbnails --thumb-viewer=kitty";
in
{
  # cat = "bat -p";
  ba = "buku --add";
  be = "buku --export ~/Documents/bookmarks.org";
  cl = "curl -L";
  clo = "curl -LO";
  cnf = "command-not-found";
  cp = "cp --reflink";
  duts = "dust";
  gca = "git commit -a";
  gch = "git checkout";
  gp = "gopass";
  gpn = "gopass new";
  icat = "kitty +kitten icat";
  l = "ls -lh";
  lb = "lsblk";
  lg = "lazygit";
  ll = "ls -lah";
  m = "mpv";
  md = "mkdir -p";
  nj = "nixpkgs-info-json";
  nr = "nix run nixpkgs#";
  ns = "nix search nixpkgs";
  nsp = "nix-shell -p";
  nup = "nix-update --test --review --commit --review --build";
  pll = "git pull";
  psh = "git push";
  tl = "tldr";
  u = "umpv";
  v = "nvim";
  wl = "watchlist";
  yf = "${ytfzf}";
  yl = "${ytfzf} --loop";
  # Download stuff
  dmp = "download-music-playlist";
  dmu = "download-music-unique";
  dvp = "download-video-playlist";
  dvu = "download-video-unique";
  # Nix
  elpa = "${nixenvString} emacsPackages.elpaPackages";
  melpa = "${nixenvString} emacsPackages.melpaPackages";
  nb = "nix build";
  nbf = "nix build -f ./.";
  nodep = "${nixenvString} nodePackages";
  nph = "nix profile history";
  npi = "nix profile install";
  npl = "nix profile list";
  npr = "nix profile remove";
  nprb = "nix profile rollback";
  npu = "nix profile upgrade";
  up = "sudo nixos-rebuild switch --upgrade";
  # trash-cli
  te = "trash-empty";
  tp = "trash-put";
  tr = "trash-restore";
  # Quickemu
  qe = "quickemu";
  qg = "quickget";
}
