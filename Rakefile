# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'prmd/rake_tasks/combine'
require 'prmd/rake_tasks/verify'
require 'prmd/rake_tasks/doc'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

namespace :schema do
  schema_root = 'docs/schema'

  Prmd::RakeTasks::Combine.new do |t|
    t.options[:meta] = "#{schema_root}/meta.yml"
    t.paths << "#{schema_root}/schemata"
    t.output_file = "#{schema_root}/schema.json"
  end

  Prmd::RakeTasks::Verify.new do |t|
    t.files << "#{schema_root}/schema.json"
  end

  Prmd::RakeTasks::Doc.new do |t|
    t.options[:template] = "#{schema_root}/templates"
    t.options[:settings] = "#{schema_root}/config.yml"
    t.options[:prepend] = ["#{schema_root}/overview.md"]
    t.files = { "#{schema_root}/schema.json" => "#{schema_root}/schema.md" }
  end

end

task schema: ['schema:combine', 'schema:verify', 'schema:doc']
task doc: :schema
