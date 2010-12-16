# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{delicious-api-via-oauth}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Mead"]
  s.date = %q{2010-12-16}
  s.email = %q{james@floehopper.org}
  s.extra_rdoc_files = ["README.textile"]
  s.files = ["example.rb", "README.textile", "lib/delicious-api-via-oauth", "lib/delicious-api-via-oauth/delicious", "lib/delicious-api-via-oauth/delicious/api.rb", "lib/delicious-api-via-oauth/delicious.rb", "lib/delicious-api-via-oauth/oauth-extensions", "lib/delicious-api-via-oauth/oauth-extensions/delicious", "lib/delicious-api-via-oauth/oauth-extensions/delicious/access_token.rb", "lib/delicious-api-via-oauth/oauth-extensions/delicious/consumer.rb", "lib/delicious-api-via-oauth/oauth-extensions/delicious.rb", "lib/delicious-api-via-oauth/oauth-extensions/yahoo", "lib/delicious-api-via-oauth/oauth-extensions/yahoo/consumer.rb", "lib/delicious-api-via-oauth/oauth-extensions/yahoo/request_token.rb", "lib/delicious-api-via-oauth/oauth-extensions/yahoo.rb", "lib/delicious-api-via-oauth/oauth-extensions.rb", "lib/delicious-api-via-oauth.rb"]
  s.homepage = %q{http://jamesmead.org/blog/2010-01-14-ruby-wrapper-for-the-delicious-v2-api-using-the-oauth-gem}
  s.rdoc_options = ["--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby wrapper for the Delicious v2 API using the OAuth gem}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oauth>, [">= 0"])
    else
      s.add_dependency(%q<oauth>, [">= 0"])
    end
  else
    s.add_dependency(%q<oauth>, [">= 0"])
  end
end
