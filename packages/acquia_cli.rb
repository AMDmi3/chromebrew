require 'package'

class Acquia_cli < Package
  description 'Acquia CLI - The official command-line tool for interacting with the Drupal Cloud Platform and services.'
  homepage 'https://github.com/acquia/cli'
  version '2.27.0'
  license 'GPL-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/acquia/cli/releases/download/2.27.0/acli.phar'
  source_sha256 '4ebbddcfdf37aac3c46f307476f93136380086fc2241edf27dd31f26c3720841'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.preflight
    major = `php -v 2> /dev/null | head -1 | cut -d' ' -f2 | cut -d'.' -f1`
    minor = `php -v 2> /dev/null | head -1 | cut -d' ' -f2 | cut -d'.' -f2`
    abort "acli requires php >= 8.0. php#{major.chomp}#{minor.chomp} does not meet the minimum requirement.".lightred unless major.empty? || minor.empty? || ((major.to_i >= 8) && (minor.to_i >= 0))
  end

  def self.install
    FileUtils.install 'acli.phar', "#{CREW_DEST_PREFIX}/bin/acli", mode: 0o755
  end
end
