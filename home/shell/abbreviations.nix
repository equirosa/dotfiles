rec {
  # General
  cl = "curl -L";
  clo = "curl -LO";
  cnf = "command-not-found";
  cp = "cp -i";
  ct = "cd $(mktemp -d)";
  d = "dust";
  dt = "dust ~/.local/share/Trash/";
  e = "$EDITOR";
  fex = "fd --extension";
  lb = "lsblk";
  lg = "lazygit";
  md = "mkdir -p";
  mv = "mv -i";
  ned = "nix-env -qaP --description";
  nf = "nix fmt";
  nfc = "nix flake check";
  nfd = ''nix flake new -t "github:numtide/devshell"'';
  nfst = "nix flake show templates";
  nfu = "nix flake update --commit-lock-file";
  nr = "nix run nixpkgs#";
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
  # Flatpak
  fi = "flatpak install";
  fl = "flatpak list";
  fu = "flatpak update --assumeyes";
  fun = "flatpak uninstall --assumeyes";
  # Listing
  l = "ls -lh";
  ll = "ls -lah";
  lls = "ls -lah";
  lss = "ls -lh";
  lt = "lsd --tree";
  # Mpv
  m = "mpv";
  mfs = "mpv --fs";
  sm = "setsid mpv";
  u = "umpv";
  umfs = "umpv --fs";
  # Git
  gca = "git commit -a";
  gcb = "git checkout -b";
  gch = "git checkout";
  gcm = "git checkout master || git checkout main";
  gl = "git log --oneline --decorate --graph --all";
  gr = "git revert";
  gri = "git rebase --interactive";
  grg = "git remote get-url origin";
  pll = "git pull";
  psf = "git push --force-with-lease";
  psh = "git push";
  pum = "git pull upstream master";
  pump = "git pull upstream master && git push";
  pur = "git pull upstream master --rebase";
  # Kitty
  icat = "kitty +kitten icat";
  # Nix
  dn = "deadnix";
  dne = "${dn} -e";
  nb = "nix build";
  nbf = "${nb} -f ./.";
  np = "nix profile";
  nph = "${np} history";
  npi = "${np} install";
  npl = "${np} list";
  npr = "${np} remove";
  npra = "${np} remove '.*'";
  nprb = "${np} rollback";
  npu = "${np} upgrade";
  ro = "regen os";
  rt = "regen test";
  up = "sudo nixos-rebuild switch --profile-name $(date +%s)-";
  # trash-cli
  rm = "trash-put";
  te = "trash-empty";
  tr = "trash-restore";
  # Quickemu
  qe = "quickemu";
  qg = "quickget";
}
