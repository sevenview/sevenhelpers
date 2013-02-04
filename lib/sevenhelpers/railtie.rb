require 'sevenhelpers'

module Sevenhelpers
  class Railtie < Rails::Railtie
    initializer "sevenhelpers.configure" do |app|
      ActiveSupport.on_load :action_view do
        require 'sevenhelpers/view_helpers'
        include Sevenhelpers::ViewHelpers
      end
    end
  end
end