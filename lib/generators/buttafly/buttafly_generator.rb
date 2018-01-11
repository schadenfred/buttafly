# class ButtaflyGenerator < Rails::Generators::NamedBase
#   source_root File.expand_path('../templates', __FILE__)
#
#   def copy_buttafly_initializer_file
#     create_file "lib/fun_party.rb" do
#       hostname = ask("What is the virtual hostname I should use?")
#       "vhost.name = #{hostname}"
#     end
#   end
# end

class ButtaflyGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  desc "This generator creates an initializer file at
    config/initializers/buttafly.rb"

  def create_buttafly_initializer_file
    originable_model = args.first

    copy_file "buttafly.rb", "config/initializers/buttafly.rb"
    unless originable_model.nil?
      initializer = "config/initializers/buttafly.rb"
      gsub_file initializer, "Spreadsheet", originable_model.capitalize
    end
  end
end
