require_dependency "buttafly/application_controller"

module Buttafly
  class MappingsController < ApplicationController
    before_action :set_mapping, only: [:import, :revert, :destroy]

    def create

      @spreadsheet = Buttafly::Spreadsheet.find(params[:spreadsheet_id])
      @mapping = @spreadsheet.mappings.new(legend_id: mapping_params[:legend_id] )
      if @mapping.save
        redirect_to @spreadsheet, notice: 'Mapping was successfully created.'
      else
        render :new
      end
    end

    def import

      if @mapping.transmogrify
        redirect_to @mapping.originable, notice: "#{@mapping.originable.name} successfully imported."
      else
        redirect_to @mapping.originable, alert: "Could not import #{@mapping.originable.name}."
      end
    end

    def revert
      if @originable.transmogrify!
        redirect_to :back, notice: "#{@originable.name} successfully archived."
      else
        redirect_to :back, notice: "#{@originable.name} could not be archived."
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
        params.require(:mapping).permit!
      end
  end
end
