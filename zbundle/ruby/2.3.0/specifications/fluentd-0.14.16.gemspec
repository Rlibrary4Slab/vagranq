# -*- encoding: utf-8 -*-
# stub: fluentd 0.14.16 ruby lib

Gem::Specification.new do |s|
  s.name = "fluentd"
  s.version = "0.14.16"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Sadayuki Furuhashi"]
  s.date = "2017-05-14"
  s.description = "Fluentd is an open source data collector designed to scale and simplify log management. It can collect, process and ship many kinds of data in near real-time."
  s.email = ["frsyuki@gmail.com"]
  s.executables = ["fluent-binlog-reader", "fluent-cat", "fluent-debug", "fluent-gem", "fluent-plugin-config-format", "fluent-plugin-generate", "fluentd"]
  s.files = ["bin/fluent-binlog-reader", "bin/fluent-cat", "bin/fluent-debug", "bin/fluent-gem", "bin/fluent-plugin-config-format", "bin/fluent-plugin-generate", "bin/fluentd"]
  s.homepage = "http://fluentd.org/"
  s.licenses = ["Apache-2.0"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1")
  s.rubygems_version = "2.5.1"
  s.summary = "Fluentd event collector"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<msgpack>, ["< 2.0.0", ">= 0.7.0"])
      s.add_runtime_dependency(%q<yajl-ruby>, ["~> 1.0"])
      s.add_runtime_dependency(%q<cool.io>, ["< 2.0.0", ">= 1.4.5"])
      s.add_runtime_dependency(%q<serverengine>, ["< 3.0.0", ">= 2.0.4"])
      s.add_runtime_dependency(%q<http_parser.rb>, ["< 0.7.0", ">= 0.5.1"])
      s.add_runtime_dependency(%q<sigdump>, ["~> 0.2.2"])
      s.add_runtime_dependency(%q<tzinfo>, ["~> 1.0"])
      s.add_runtime_dependency(%q<tzinfo-data>, ["~> 1.0"])
      s.add_runtime_dependency(%q<strptime>, ["~> 0.1.7"])
      s.add_development_dependency(%q<rake>, ["~> 11.0"])
      s.add_development_dependency(%q<flexmock>, ["~> 2.0"])
      s.add_development_dependency(%q<parallel_tests>, ["~> 0.15.3"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.7"])
      s.add_development_dependency(%q<rr>, ["~> 1.0"])
      s.add_development_dependency(%q<timecop>, ["~> 0.3"])
      s.add_development_dependency(%q<test-unit>, ["~> 3.2"])
      s.add_development_dependency(%q<test-unit-rr>, ["~> 1.0"])
      s.add_development_dependency(%q<oj>, ["~> 2.14"])
    else
      s.add_dependency(%q<msgpack>, ["< 2.0.0", ">= 0.7.0"])
      s.add_dependency(%q<yajl-ruby>, ["~> 1.0"])
      s.add_dependency(%q<cool.io>, ["< 2.0.0", ">= 1.4.5"])
      s.add_dependency(%q<serverengine>, ["< 3.0.0", ">= 2.0.4"])
      s.add_dependency(%q<http_parser.rb>, ["< 0.7.0", ">= 0.5.1"])
      s.add_dependency(%q<sigdump>, ["~> 0.2.2"])
      s.add_dependency(%q<tzinfo>, ["~> 1.0"])
      s.add_dependency(%q<tzinfo-data>, ["~> 1.0"])
      s.add_dependency(%q<strptime>, ["~> 0.1.7"])
      s.add_dependency(%q<rake>, ["~> 11.0"])
      s.add_dependency(%q<flexmock>, ["~> 2.0"])
      s.add_dependency(%q<parallel_tests>, ["~> 0.15.3"])
      s.add_dependency(%q<simplecov>, ["~> 0.7"])
      s.add_dependency(%q<rr>, ["~> 1.0"])
      s.add_dependency(%q<timecop>, ["~> 0.3"])
      s.add_dependency(%q<test-unit>, ["~> 3.2"])
      s.add_dependency(%q<test-unit-rr>, ["~> 1.0"])
      s.add_dependency(%q<oj>, ["~> 2.14"])
    end
  else
    s.add_dependency(%q<msgpack>, ["< 2.0.0", ">= 0.7.0"])
    s.add_dependency(%q<yajl-ruby>, ["~> 1.0"])
    s.add_dependency(%q<cool.io>, ["< 2.0.0", ">= 1.4.5"])
    s.add_dependency(%q<serverengine>, ["< 3.0.0", ">= 2.0.4"])
    s.add_dependency(%q<http_parser.rb>, ["< 0.7.0", ">= 0.5.1"])
    s.add_dependency(%q<sigdump>, ["~> 0.2.2"])
    s.add_dependency(%q<tzinfo>, ["~> 1.0"])
    s.add_dependency(%q<tzinfo-data>, ["~> 1.0"])
    s.add_dependency(%q<strptime>, ["~> 0.1.7"])
    s.add_dependency(%q<rake>, ["~> 11.0"])
    s.add_dependency(%q<flexmock>, ["~> 2.0"])
    s.add_dependency(%q<parallel_tests>, ["~> 0.15.3"])
    s.add_dependency(%q<simplecov>, ["~> 0.7"])
    s.add_dependency(%q<rr>, ["~> 1.0"])
    s.add_dependency(%q<timecop>, ["~> 0.3"])
    s.add_dependency(%q<test-unit>, ["~> 3.2"])
    s.add_dependency(%q<test-unit-rr>, ["~> 1.0"])
    s.add_dependency(%q<oj>, ["~> 2.14"])
  end
end
