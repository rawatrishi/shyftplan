class Api::V1::BranchesController < Api::ApiController
  before_action :set_branch, only: %i[ show update destroy ]

  # GET /api/v1/branches
  # GET /api/v1/branches.json
  def index
    @branches = Branch.all
  end

  # GET /api/v1/branches/1
  # GET /api/v1/branches/1.json
  def show
  end

  # POST /api/v1/branches
  # POST /api/v1/branches.json
  def create
    @branch = Branch.new(branch_params)

    if @branch.save
      render :show, status: :created, location: @branch
    else
      render json: @branch.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/branches/1
  # PATCH/PUT /api/v1/branches/1.json
  def update
    if @branch.update(branch_params)
      render :show, status: :ok, location: @branch
    else
      render json: @branch.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/branches/1
  # DELETE /api/v1/branches/1.json
  def destroy
    @branch.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def branch_params
      params.require(:branch).permit(:name, :company_id)
    end
end
