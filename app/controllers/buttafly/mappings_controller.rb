require_dependency "buttafly/application_controller"

module Buttafly
  class MappingsController < ApplicationController
    before_action :set_mapping, only: [:show, :edit, :update, :destroy]

    def index
      @mappings = Mapping.all
    end

    def show
    end

    def new
      @spreadsheet = Buttafly::Spreadsheet.find(params[:spreadsheet_id])
      @mapping = @spreadsheet.mappings.create
      @targetable_model = mapping_params["targetable_model"]
    end

    def edit
    end

    def create
      byebug
      @mapping = Mapping.new(mapping_params)

      if @mapping.save
        redirect_to @mapping, notice: 'Mapping was successfully created.'
      else
        render :new
      end
    end

    def update
      if @mapping.update(mapping_params)
        redirect_to @mapping, notice: 'Mapping was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @mapping.destroy
      redirect_to mappings_url, notice: 'Mapping was successfully destroyed.'
    end

    private
      def set_mapping
        @mapping = Mapping.find(params[:id])
      end

      def mapping_params
        params.permit!
      end
  end
end
