class HomeController < ApplicationController
  before_action :skip_if_logged_in, only: [:index]

  def index
  end
end
