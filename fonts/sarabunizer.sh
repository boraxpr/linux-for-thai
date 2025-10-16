#!/usr/bin/env bash
set -e

echo "[*] Setting up font configuration (cross-distro)..."

# Ensure directories exist
mkdir -p ~/.config/fontconfig/conf.d
mkdir -p ~/.local/share/fonts

# Download Sarabun font if missing
if [ ! -d ~/.local/share/fonts/Sarabun ]; then
  echo "[*] Downloading Sarabun..."
  mkdir -p ~/.local/share/fonts/Sarabun
  curl -L https://github.com/cadsondemak/Sarabun/archive/refs/heads/master.zip -o /tmp/sarabun.zip
  unzip -q /tmp/sarabun.zip -d /tmp
  find /tmp/Sarabun-master -type f -iname "*.ttf" -exec cp {} ~/.local/share/fonts/Sarabun/ \;
  rm -rf /tmp/sarabun.zip /tmp/Sarabun-master
else
  echo "[*] Sarabun already installed."
fi

# Write custom fontconfig
cat > ~/.config/fontconfig/fonts.conf <<'EOF'
<?xml version='1.0'?>
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
<fontconfig>
  <!-- Thai override -->
  <match target="pattern">
    <test name="lang" compare="contains">
      <string>th</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
      <string>Sarabun</string>
    </edit>
  </match>

  <!-- Rendering preferences -->
  <match target="font">
    <edit name="hinting" mode="assign"><bool>true</bool></edit>
    <edit name="hintstyle" mode="assign"><const>hintslight</const></edit>
    <edit name="antialias" mode="assign"><bool>true</bool></edit>
  </match>
</fontconfig>
EOF

# Rebuild font cache
echo "[*] Refreshing font cache..."
fc-cache -fv > /dev/null

# Verify
echo "[*] Current Thai font mapping:"
fc-match ":lang=th"

echo "[+] Font setup complete."
