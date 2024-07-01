# frozen_string_literal: true

require_relative "lib/jekyll_lunrjs/version"

Gem::Specification.new do |s|
  s.name        = "jekyll_lunrjs"
  s.summary     = "Index LunarJs plugin for Jekyll"
  s.version     = Jekyll::LunrJs::VERSION
  s.authors     = ["Jorge Novo"]
  s.email       = "jnovos@gmail.com"

  s.homepage = "https://github.com/jnovos/LunrJs-Jekyll"
  s.licenses = ["MIT"]
  s.files    = ["lib/jekyll_lunrjs.rb"]

  s.required_ruby_version = ">= 2.4.0"

  s.add_dependency "jekyll", ">= 3.0", "< 5.0"
  
  s.add_runtime_dependency "therubyracer", "~>  0.12.3"
  
  s.add_development_dependency "bundler"
  s.add_development_dependency "rake", "~> 12.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "rubocop-jekyll", "~> 0.4"
end
