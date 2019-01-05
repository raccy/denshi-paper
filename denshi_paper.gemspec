# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'denshi_paper/version'

Gem::Specification.new do |spec|
  spec.name          = 'denshi_paper'
  spec.version       = DenshiPaper::VERSION
  spec.authors       = ['IGARASHI Makoto']
  spec.email         = ['open@raccy.org']

  spec.summary       = '電子ペーパーライブラリ'
  spec.description   = <<~DESCRIPTION
    denshi_paperは富士通製電子ペーパーを操作する非公式ライブラリです。
    ソニー製についてはよくわかりません。
  DESCRIPTION
  spec.homepage      = 'https://github.com/raccy/denshi_paper'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.required_ruby_version = '>= 2.5'
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
