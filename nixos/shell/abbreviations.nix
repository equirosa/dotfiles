let
  nixenvString = ''nix-env -f "<nixpkgs>" -qaP'';
  ytfzf = "ytfzf --detach --show-thumbnails --thumb-viewer=kitty";
in {
  # cat = "bat -p";
  ba = "buku --add";
  be = "buku --export ~/Documents/bookmarks.org";
  cl = "curl -L";
  clo = "curl -LO";
  cnf = "command-not-found";
  cp = "cp --reflink=always";
  duts = "dust";
  fex = "fd --extension";
  # Git
  gca = "git commit -a";
  gch = "git checkout";
  pll = "git pull";
  psh = "git push";
  pur = "git pull upstream master --rebase";
  # Gopass
  gp = "gopass";
  gn = "gopass new";
  icat = "kitty +kitten icat";
  l = "ls -lh";
  lb = "lsblk";
  lg = "lazygit";
  ll = "ls -lah";
  m = "mpv";
  md = "mkdir -p";
  nf = "nix fmt";
  nr = "nix run nixpkgs#";
  ns = "nix search nixpkgs";
  nsp = "nix-shell -p";
  nup = "nix-update --test --commit --review";
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
  elpa = "${nixenvString} emacs.pkgs.elpaPackages";
  melpa = "${nixenvString} emacs.pkgs.melpaPackages";
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
