class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  add_breadcrumb "Admin"
end