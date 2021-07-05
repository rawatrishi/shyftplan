class Api::V1::CompaniesController < Api::ApiController
  before_action :set_company, only: %i[ show update destroy ]

  # GET /api/v1/companies
  # GET /api/v1/companies.json
  def index
    @companies = Company.c_filter(index_filter)
  end

  # GET /api/v1/companies/1
  # GET /api/v1/companies/1.json
  def show
  end

  # POST /api/v1/companies
  # POST /api/v1/companies.json
  def create
    @company = Company.new(company_params)

    if @company.save
      render :show, status: :created, location: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/companies/1
  # PATCH/PUT /api/v1/companies/1.json
  def update
    if @company.update(company_params)
      render :show, status: :ok, location: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/companies/1
  # DELETE /api/v1/companies/1.json
  def destroy
    @company.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name, :parent_id, :required_employee, :total_employee)
    end

    def index_filter
      params.permit(:employees_less_than_required)
    end
end
