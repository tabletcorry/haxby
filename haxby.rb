require 'formula'

class Haxby < Formula
    homepage 'https://github.com/tabletcorry/haxby'
    url "https://github.com/tabletcorry/haxby/tarball/haxby-0.1"
    sha256 "68671482d9b4b71b62e15e2335849aa4e48433ccf15a78c875daac983565e8ef"

    depends_on 'coreutils' # Specifically greadlink

    def install
        bin.install Dir['bin/*']
        (share+'haxby').install Dir['lib/*']
    end
end
