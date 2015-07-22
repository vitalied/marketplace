class LocationsController < AdminController

  authorize_resource

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.fetch(:location, {}).permit(:company_id, :name, :website, :address, :city, :state, :zip, :country)
    end
end
