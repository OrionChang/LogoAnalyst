class GlobalCompaniesController < ApplicationController
  # GET /global_companies
  # GET /global_companies.json
  def index
    Mongoid.identity_map_enabled = true

    @global_companies = GlobalCompany.includes(:country, :global_industry, :global_company_profiles).to_a.sort_by! { |entry| entry.global_company_profiles.last.rank }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @global_companies }
    end
  end

  # GET /global_companies/1
  # GET /global_companies/1.json
  def show
    Mongoid.identity_map_enabled = true

    @global_company = GlobalCompany.includes(:country, :global_industry, :global_company_profiles).find(params[:id])
    respond_to do |format|
      format.js { render :layout => false }
      format.json { render json: @global_company }
    end
  end

  # GET /global_companies/new
  # GET /global_companies/new.json
  def new
    @global_company = GlobalCompany.new
    @global_company.global_company_profiles.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @global_company }
    end
  end

  # GET /global_companies/1/edit
  def edit
    @global_company = GlobalCompany.find(params[:id])
  end

  # POST /global_companies
  # POST /global_companies.json
  def create
    @global_company = GlobalCompany.new(params[:global_company])

    respond_to do |format|
      if @global_company.save
        format.html { redirect_to @global_company, notice: 'Global company was successfully created.' }
        format.json { render json: @global_company, status: :created, location: @global_company }
      else
        format.html { render action: "new" }
        format.json { render json: @global_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /global_companies/1
  # PUT /global_companies/1.json
  def update
    @global_company = GlobalCompany.find(params[:id])

    respond_to do |format|
      if @global_company.update_attributes(params[:global_company])
        format.html { redirect_to @global_company, notice: 'Global company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @global_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /global_companies/1
  # DELETE /global_companies/1.json
  def destroy
    @global_company = GlobalCompany.find(params[:id])
    @global_company.destroy

    respond_to do |format|
      format.html { redirect_to global_companies_url }
      format.json { head :no_content }
    end
  end
end
