require_dependency "buttafly/application_controller"

module Buttafly

  class LegendsController < ApplicationController

    before_action :set_legend, only: [:show, :edit, :update, :destroy]

    def show
    end

    def edit
      @targetable_model = @legend.targetable_model
      @originable_headers = @legend.originable_headers
    end

    def create
      @spreadsheet = Buttafly::Spreadsheet.find(params["spreadsheet_id"])
      @legend = @spreadsheet.legends.create(legend_params.merge(originable_headers: @spreadsheet.originable_headers))

      if @legend.save

        redirect_to edit_legend_path(@legend), notice: 'Legend was successfully created.'
      else
        render "spredsheets/show", @spreadsheet
      end
    end

    def update

      if @legend.update(legend_params)
        redirect_to edit_legend_url(@legend), notice: 'Legend was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @legend.destroy
      redirect_to root_url, notice: 'Legend was successfully destroyed.'
    end

    private
      def set_legend
        @legend = Legend.find(params[:id])
      end

      def legend_params
        params.require(:legend).permit!# (:originable_headers, :targetable_model, :data => {})
      end
  end
end
