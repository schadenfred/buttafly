guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html|png|jpg))).*}) { |m| "/assets/#{m[3]}" }
end

guard :minitest do

  watch(%r{^app/(.+)\.rb$})                               { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^test/dummy/app/(.+)\.rb$})                    { |m| "test/dummy/test/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/application_controller\.rb$}) { 'test/controllers' }
  watch(%r{^app/models/concerns/(.+)\.rb$})               { ['test/integration', 'test/models/buttafly/spreadsheet_test.rb'] }
  watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                    { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^lib/(.+)\.rb$})                               { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^lib/buttafly.rb$})                            { 'test' }
  watch(%r{^test/.+_test\.rb$})
  # watch(%r{^test/test_helper\.rb$})                       { 'test' }
  # watch(%r{^test/support/(.+)$})                          { 'test' }
  watch(%r{^test/features/*\.rb$})
  watch(%r{^app/views/(.+)\.haml$})                          { 'test' }
  # watch(%r{^lib/generators/(.+).rb$})                     { "test/lib/generators/" }
  # watch(%r{^lib/generators/buttafly/install/install_generator.rb$}) { |m| "test/lib/generators/buttafly/buttafly/install_generator_test.rb" }
end
