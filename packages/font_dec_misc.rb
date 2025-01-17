require 'package'

class Font_dec_misc < Package
  description 'DEC cursor and session PCF fonts'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.0.3'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/releases/individual/font/font-dec-misc-1.0.3.tar.bz2'
  source_sha256 'e19ddf8b5f8de914d81675358fdfe37762e9ce524887cc983adef34f2850ff7b'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e9bd304b0a670711ef40a84c9464c3f27778b111848728a2915a0e347955245e',
     armv7l: 'e9bd304b0a670711ef40a84c9464c3f27778b111848728a2915a0e347955245e',
     x86_64: '4c62adf9306c813a0f977d8f591762561a1e069a06b66d765ee87ecd940a481f'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-fontrootdir=#{CREW_PREFIX}/share/fonts"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
