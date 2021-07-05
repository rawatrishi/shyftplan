class Api::V1::CountriesController < Api::ApiController
  before_action :set_country, only: %i[ show update destroy ]

  # GET /api/v1/countries
  # GET /api/v1/countries.json
  def index
    @countries = Country.all
  end

  # GET /api/v1/countries/1
  # GET /api/v1/countries/1.json
  def show
  end

  # POST /api/v1/countries
  # POST /api/v1/countries.json
  def create
    @country = Country.new(country_params)

    if @country.save
      render :show, status: :created, location: @country
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/countries/1
  # PATCH/PUT /api/v1/countries/1.json
  def update
    if @country.update(country_params)
      render :show, status: :ok, location: @country
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/countries/1
  # DELETE /api/v1/countries/1.json
  def destroy
    @country.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def country_params
      params.require(:country).permit(:name)
    end
end
