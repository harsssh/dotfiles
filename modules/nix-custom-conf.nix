username: ''
  trusted-users = root ${username}
  extra-substituters = https://harsssh.cachix.org https://nix-community.cachix.org
  extra-trusted-public-keys = harsssh.cachix.org-1:65C0xZ93n9w8nRj7Sf5sOHHTcVeWDEEO2N6ckeVDRJM= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
  http-connections = 50
  narinfo-cache-positive-ttl = 86400
''
