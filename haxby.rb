require 'formula'

class Haxby < Formula
    homepage 'https://github.com/tabletcorry/haxby'
    url "https://github.com/tabletcorry/haxby/tarball/haxby-0.3"
    head "git://github.com/tabletcorry/haxby.git"
    sha256 "7060916cd4a7698c9827842abe0d71c8a49c0d06547943508d46791a7cb13eed"

    depends_on 'coreutils' # Specifically greadlink
    depends_on 'proctools' # Specifically pgrep
    depends_on 'postgresql' # Because thats what it does

    def install
        system "./install.sh -p #{prefix}"
    end
end
