#!/bin/sh
if [ -f jekyll_lunrjs-1.0.0.gem ]; then
    echo "Delete File!"
    rm jekyll_lunrjs-1.0.0.gem
    gem uninstall jekyll_lunrjs
fi
gem build jekyll_lunrjs.gemspec
gem install jekyll_lunrjs-1.0.0.gem --local