class CompaniesController < AdminController

  authorize_resource

  before_action :set_item, only: [:show, :update, :create_user]

  def search
    respond_to do |format|
      format.json do
        @companies = Company.where("name ILIKE ?", "%#{params[:q]}%").order(:name)
        @companies_count = @companies.count
        @companies = @companies.page(params[:page]).per(25)
      end
    end
  end

  def create_user
    respond_to do |format|
      format.js do
        @item = @company.company_users.new
        @item.save(validate: false)
        instance_variable_set(:"@user", @item)
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params[:company] ||= params[:datacenter_company]
      params.fetch(:company, {}).permit(:name, :description, :website)
    end

end
