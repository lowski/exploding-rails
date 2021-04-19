require 'dry/monads/result'

class ApplicationController < ActionController::Base
  include Dry::Monads[:result]
end
