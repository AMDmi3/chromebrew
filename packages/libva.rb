require 'buildsystems/meson'

class Libva < Meson
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.21.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/intel/libva.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc7d16f80a0d856abc063d8a72eb0756ae6dbded238df15ca3c52341f2d7541d',
     armv7l: 'dc7d16f80a0d856abc063d8a72eb0756ae6dbded238df15ca3c52341f2d7541d',
     x86_64: '85fb920efc0290c4397ab1c836d5b4990912a02b5b563359de6c617103096d0e'
  })

  depends_on 'glibc' # R
  depends_on 'libdrm' # R
  depends_on 'libglvnd' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'mesa' # L
  depends_on 'wayland' # R
end
