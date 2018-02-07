require_dependency "buttafly/application_controller"

module Buttafly

  class LegendsController < ApplicationController
    before_action :set_legend, only: [:show, :edit, :update, :destroy]

    def index
      @legends = Legend.all
    end

    def show
    end

    def new
      @spreadsheet = Buttafly::Spreadsheet.find(params["spreadsheet_id"])
      @targetable_model = params["targetable_model"]
      @legend = @spreadsheet.legends.new(targetable_model: @targetable_model)
      @originable_headers = @spreadsheet.originable_headers
    end

    def edit
      @targetable_model = @legend.data.first.first
      @originable_headers = @legend.originable_headers
    end

    def create
      @legend = Legend.new(legend_params)
      # @legend = Legend.new(
      #   originable_headers: legend_params[:originable_headers],
      #   targetable_model: legend_params[:targetable_model],
      #   data: legend_params[:data].to_json)
      if @legend.save
        redirect_to @legend, notice: 'Legend was successfully created.'
      else
        render :new
      end
    end

    def update
      if @legend.update(legend_params)
        redirect_to @legend, notice: 'Legend was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @legend.destroy
      redirect_to legends_url, notice: 'Legend was successfully destroyed.'
    end

    private
      def set_legend
        @legend = Legend.find(params[:id])
      end

      def legend_params
        params.require(:legend).permit(:originable_headers, :targetable_model, :data => {})
      end
  end
end
