require 'formula'

class Haxby < Formula
    homepage 'https://github.com/tabletcorry/haxby'
    url "https://github.com/tabletcorry/haxby/tarball/haxby-0.4"
    head "https://github.com/tabletcorry/haxby.git"
    sha256 "64c36303f41a10462971a6a75bf7c511b4bbf75a97cb78a66bfa07475691073a"

    depends_on 'coreutils' # Specifically greadlink
    depends_on 'proctools' # Specifically pgrep
    depends_on 'postgresql' # Because thats what it does

    def install
        system "./install.sh -p #{prefix}"
    end
end
