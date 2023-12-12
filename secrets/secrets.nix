let
  kiri = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEy17h0xv3f2RP6BGtlfByjMMSwoQ0jvUiEGKKqN/uyA";
  users = [ kiri ];
in
{
  "./xxx.age".publicKeys = users;
}
