class CompanyController < ApplicationController
  def index
    @industries = IndustryGroup.all
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end
end
