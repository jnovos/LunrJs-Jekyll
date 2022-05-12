#!/bin/sh
if [ -f jekyll_lunrjs-1.0.1.gem ]; then
    echo "Delete File!"
    rm jekyll_lunrjs-1.0.1.gem
    gem uninstall jekyll_lunrjs
fi
gem build jekyll_lunrjs.gemspec
gem install jekyll_lunrjs-1.0.1.gem --local