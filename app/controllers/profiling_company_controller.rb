class ProfilingCompanyController < ApplicationController
  def index
    @company = Company.random(1)


    @profile = @company.profiles.build


  end

  def create
    @company = Company.find(params[:company])
    @profile = @company.profiles.new(params[:profile])

    respond_to do |format|
      if @profile.save
        format.html { redirect_to root_path, notice: 'Experiment was successfully created.' }
        format.json { render json: root_path, status: :created, location: @profile }
      else
        format.html { render action: "index" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end
end
