require_dependency "buttafly/application_controller"

module Buttafly
  class MappingsController < ApplicationController
    before_action :set_mapping, only: [:show, :edit, :update, :destroy]

    # GET /mappings
    def index
      @mappings = Mapping.all
    end

    # GET /mappings/1
    def show
    end

    # GET /mappings/new
    def new
      @mapping = Mapping.new
    end

    # GET /mappings/1/edit
    def edit
    end

    # POST /mappings
    def create
      @mapping = Mapping.new(mapping_params)

      if @mapping.save
        redirect_to @mapping, notice: 'Mapping was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /mappings/1
    def update
      if @mapping.update(mapping_params)
        redirect_to @mapping, notice: 'Mapping was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /mappings/1
    def destroy
      @mapping.destroy
      redirect_to mappings_url, notice: 'Mapping was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_mapping
        @mapping = Mapping.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def mapping_params
        params.fetch(:mapping, {})
      end
  end
end
