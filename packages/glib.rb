require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.80.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51156b4b2f9528ac1214cab16363af56db9f3889b0d468705329f4502985b71e',
     armv7l: '51156b4b2f9528ac1214cab16363af56db9f3889b0d468705329f4502985b71e',
       i686: '8d5c84282eb479f7afeb1e312866fcc6eca37ee2a1aba578d8a554e66cf6a3e2',
     x86_64: '01138ea4b0ca4d1693135a7f066406b8c9eedd686cdf9e6aa566601502bc89a9'
  })

  depends_on 'elfutils' # R
  depends_on 'gcc_lib' # R
  depends_on 'libffi' # R
  depends_on 'pcre2' # R
  depends_on 'py3_pygments' => :build
  depends_on 'shared_mime_info' # L
  depends_on 'util_linux' # R
  depends_on 'zlibpkg' # R

  no_strip if %w[aarch64 armv7l].include? ARCH

  meson_options '-Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman-pages=disabled \
    -Dtests=false'

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    # Create libtool file. Needed by handbrake build.
    return if File.file?("#{CREW_DEST_LIB_PREFIX}/#{@libname}.la")

    @libname = name.to_s.start_with?('lib') ? name.downcase : "lib#{name.downcase}"
    @libnames = Dir["#{CREW_DEST_LIB_PREFIX}/#{@libname}.so*"]
    @libnames = Dir["#{CREW_DEST_LIB_PREFIX}/#{@libname}-*.so*"] if @libnames.empty?
    @libnames.each do |s|
      s.gsub!("#{CREW_DEST_LIB_PREFIX}/", '')
    end
    @dlname = @libnames.grep(/.so./).first
    @libname = @dlname.gsub(/.so.\d+/, '')
    @longest_libname = @libnames.max_by(&:length)
    @libvars = @longest_libname.rpartition('.so.')[2].split('.')

    @libtool_file = <<~LIBTOOLEOF
      # #{@libname}.la - a libtool library file
      # Generated by libtool (GNU libtool) (Created by Chromebrew)
      #
      # Please DO NOT delete this file!
      # It is necessary for linking the library.

      # The name that we can dlopen(3).
      dlname='#{@dlname}'

      # Names of this library.
      library_names='#{@libnames.reverse.join(' ')}'

      # The name of the static archive.
      old_library='#{@libname}.a'

      # Linker flags that cannot go in dependency_libs.
      inherited_linker_flags=''

      # Libraries that this one depends upon.
      dependency_libs=''

      # Names of additional weak libraries provided by this library
      weak_library_names=''

      # Version information for #{name}.
      current=#{@libvars[1]}
      age=#{@libvars[1]}
      revision=#{@libvars[2]}

      # Is this an already installed library?
      installed=yes

      # Should we warn about portability when linking against -modules?
      shouldnotlink=no

      # Files to dlopen/dlpreopen
      dlopen=''
      dlpreopen=''

      # Directory that this library needs to be installed in:
      libdir='#{CREW_LIB_PREFIX}'
    LIBTOOLEOF
    File.write("#{CREW_DEST_LIB_PREFIX}/#{@libname}.la", @libtool_file)
  end
end
