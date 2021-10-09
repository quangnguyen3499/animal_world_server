# -*- encoding: utf-8 -*-
# stub: sidekiq-status 2.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "sidekiq-status".freeze
  s.version = "2.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Evgeniy Tsvigun".freeze, "Kenaniah Cerny".freeze]
  s.date = "2021-09-23"
  s.email = ["utgarda@gmail.com".freeze, "kenaniah@gmail.com".freeze]
  s.homepage = "https://github.com/kenaniah/sidekiq-status".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.22".freeze
  s.summary = "An extension to the sidekiq message processing to track your jobs".freeze

  s.installed_by_version = "3.2.22" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<sidekiq>.freeze, [">= 5.0"])
    s.add_runtime_dependency(%q<chronic_duration>.freeze, [">= 0"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_development_dependency(%q<colorize>.freeze, [">= 0"])
    s.add_development_dependency(%q<rack-test>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<sinatra>.freeze, [">= 0"])
  else
    s.add_dependency(%q<sidekiq>.freeze, [">= 5.0"])
    s.add_dependency(%q<chronic_duration>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<colorize>.freeze, [">= 0"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<sinatra>.freeze, [">= 0"])
  end
end
