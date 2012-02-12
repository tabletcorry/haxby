require 'formula'

class Haxby < Formula
    homepage 'https://github.com/tabletcorry/haxby'
    head "git://github.com/tabletcorry/haxby.git"

    depends_on 'coreutils'

    def install
        bin.install ['bin/haxby']
        (share+'haxby').install Dir['lib/*']
    end
end
