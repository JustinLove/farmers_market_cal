tag = "--tag #{ENV['TAG']}" if ENV['TAG']
example = "-e '#{ENV['EXAMPLE']}'" if ENV['EXAMPLE']
guard 'rspec',
    :cli => "--color --format d #{tag} #{example}",
    :bundler => false,
    :spec_paths => ['spec'] do

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end
