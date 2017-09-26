class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Clearance::Controller
  protect_from_forgery with: :exception
end
