require 'formula'

class Haxby < Formula
    homepage 'https://github.com/tabletcorry/haxby'
    url "https://github.com/tabletcorry/haxby/tarball/haxby-0.2"
    head "git://github.com/tabletcorry/haxby.git"
    sha256 "91584320d97c4602ea4967ba711942351d592ff3b414d5bdad887a68b0d6ea45"

    depends_on 'coreutils' # Specifically greadlink

    def install
        bin.install Dir['bin/*']
        (share+'haxby').install Dir['lib/*']
    end
end
