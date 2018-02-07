# require "test_helper"
#
# describe "meta testing" do
#
#   describe "yaml" do
#
#     Given(:data_hash) { { "name" => "Barbara Billingsley" } }
#
#     Given { (write_hash_to_yaml(data_hash, "billingsley") ) }
#
#     describe "write_hash_to_yaml(hash, file)" do
#
#       Then { File.exist?(engine("test/support/yaml/billingsley.yml")).must_equal true}
#     end
#
#     describe "read_hash_from_yaml(file)" do
#
#       Then { read_hash_from_yaml("billingsley").must_equal data_hash}
#     end
#   end
#
#   describe "dummy(file)" do
#
#     describe "must return the file name in the dummy app directory" do
#       Given(:file) { "config/routes.rb"}
#       Then { dummy(file).must_equal Rails.root.join(file)}
#     end
#   end
#
#   describe "engine(file)" do
#
#     describe "must return the file name in the dummy app directory" do
#       Given(:file) { "config/routes.rb"}
#       Then { engine(file).must_equal Buttafly::Engine.root.join(file)}
#     end
#   end
#
#   describe "file creation and destruction" do
#
#     Given(:engine_file) { engine( "test/support/temporary/test_file_name.rb" ) }
#     Given(:engine_file_two) { engine( "test/support/temporary/test_file_name_two.rb" ) }
#     Given(:dummy_file) { dummy( "public/temporary/test_file_name.rb" ) }
#
#     Given { create_file_for_testing( engine_file ) }
#     Given { create_file_for_testing( engine_file_two ) }
#     Given { create_file_for_testing( dummy_file ) }
#
#     describe "create_file_for_testing(file, dir=nil)" do
#
#       Then { File.exist?( engine_file ).must_equal true }
#       And { File.exist?( engine_file_two ).must_equal true }
#       And { File.exist?( dummy_file ).must_equal true }
#
#       describe "file_exists(directory, pattern)" do
#
#       end
#     end
#
#     describe "remove_file_for_testing(file)" do
#
#       Given { remove_file_for_testing( engine_file ) }
#       Given { remove_file_for_testing( engine_file_two ) }
#       Given { remove_file_for_testing( dummy_file ) }
#
#       Then { File.exist?( engine_file ).wont_equal true }
#       Then { File.exist?( engine_file_two ).wont_equal true }
#       And { File.exist?( dummy_file ).wont_equal true }
#     end
#   end
# end
