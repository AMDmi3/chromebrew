require 'buildsystems/autotools'

class Libx11 < Autotools
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.8.7'
  license 'X11'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libx11.git'
  git_hashtag "libX11-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5e7b10f0a4931a057e6583e254a58abf3230bab91f39d5b64fd027d1d102639',
     armv7l: 'a5e7b10f0a4931a057e6583e254a58abf3230bab91f39d5b64fd027d1d102639',
     x86_64: 'c089d6bf6eb3715240f02aacb87064f85aa2c03448dc9e34c18495f62ccd5e9a'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxtrans' => :build
  depends_on 'llvm18_lib' => :build
  depends_on 'xorg_proto' => :build
end
