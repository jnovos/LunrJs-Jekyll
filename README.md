# LunarJs-Jekyll

Index LunarJs plugin for Jekyll

  Gem Version : 1.0.0

## Installation

  You can install the gem in local with shell script 

    $ ./make_gem.sh

  You have to install lunr.js into the javascript folder of middlemanapp project

    $ bower install lunr.js


## Usage

Add the following to your site's `Gemfile`

```
gem 'jekyll_lunrjs'
```

And add the following to your site's `_config.yml`

```yml
plugins:
  - jekyll_lunrjs

#lunrjs indexer options
lunr_folder_json: '/_site/assets/json' # 
folder_lunar_js: '/_site/assets/js/lunr/lunr.js' # folder to javascript lunrjs
```

Add into Front Matter block(post,pages):

```yml
metadata:
    tags: gems,ruby,develop
```

## Contributing

1. Fork it ( https://github.com/jnovos/LunrJs-Jekyll/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

See the [LunrJs-Jekyll](https://github.com/jnovos/LunrJs-Jekyll) documentation for generating Indexing.
