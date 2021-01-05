class InquiriesController < ApplicationController
  def index
    @inquiries = Inquiry.all
  end

  def new
    @inquire = Inquiry.new
  end
end
