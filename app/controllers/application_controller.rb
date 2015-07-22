class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :model, :model_name, :sort_column, :sort_direction

  private

    def model
      @model ||= controller_path.classify.constantize
    end

    def model_name
      @model_name ||= model.model_name.singular
    end

    def sort_column
      # @sort_column ||= model.column_names.include?(params[:sort]) ? params[:sort] : model.default_sort_column
      @sort_column ||= params[:sort].presence || model.default_sort_column
    end

    def sort_direction
      @sort_direction ||= %w[asc desc].include?(params[:dir]) ? params[:dir] : model.try(:default_sort_order) || "asc"
    end

end
