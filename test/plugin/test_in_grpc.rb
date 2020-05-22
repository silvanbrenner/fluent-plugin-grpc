require "helper"
require "fluent/plugin/in_grpc-2.rb"

class GrpcInputTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Input.new(Fluent::Plugin::GrpcInput).configure(conf)
  end
end
