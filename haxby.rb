require 'formula'

class Haxby < Formula
    homepage 'https://github.com/tabletcorry/haxby'
    head "git://github.com/tabletcorry/haxby.git"

    depends_on 'coreutils' # Specifically greadlink

    def install
        bin.install Dir['bin/*']
        (share+'haxby').install Dir['lib/*']
    end
end
