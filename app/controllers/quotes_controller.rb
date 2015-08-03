class QuotesController < AdminController

  authorize_resource

  before_action :set_item, only: [:show, :update, :upload_offer]

  def upload_offer
    qc = @quote.quote_companies.by_company(current_user.userable_id).first
    qc.update!(quote_company_params)

    redirect_to quotes_path
  end

  private

    def set_item
      instance_variable_set(:"@#{model_name}", model.find_by_number!(params[:id]))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.fetch(:quote, {}).permit()
    end

    def quote_company_params
      params.fetch(:quote_company, {}).permit(:offer)
    end

end
