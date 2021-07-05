class Api::V1::EmployeesController < Api::ApiController
  before_action :set_company
  before_action :set_employee, only: %i[ show update destroy ]

  # GET /api/v1/employees
  # GET /api/v1/employees.json
  def index
    @employees = @company.employees
  end

  # GET /api/v1/employees/1
  # GET /api/v1/employees/1.json
  def show
  end

  # POST /api/v1/employees
  # POST /api/v1/employees.json
  def create
    @employee = @company.employees.new(employee_params)

    if @employee.save
      render :show, status: :created, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/employees/1
  # PATCH/PUT /api/v1/employees/1.json
  def update
    if @employee.update(employee_params)
      render :show, status: :ok, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/employees/1
  # DELETE /api/v1/employees/1.json
  def destroy
    @employee.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = @company.employees.find(params[:id])
    end

    def set_company
      @company = Company.find(params[:company_id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:email, :contact, :name, :branch_id)
    end
end
