require_dependency "buttafly/application_controller"

module Buttafly
  class ArtifactsController < ApplicationController
    before_action :set_artifact, only: [:show, :edit, :update, :destroy]

    # GET /artifacts
    def index
      @artifacts = Artifact.all
    end

    # GET /artifacts/1
    def show
    end

    # GET /artifacts/new
    def new
      @artifact = Artifact.new
    end

    # GET /artifacts/1/edit
    def edit
    end

    # POST /artifacts
    def create
      @artifact = Artifact.new(artifact_params)

      if @artifact.save
        redirect_to @artifact, notice: 'Artifact was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /artifacts/1
    def update
      if @artifact.update(artifact_params)
        redirect_to @artifact, notice: 'Artifact was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /artifacts/1
    def destroy
      @artifact.destroy
      redirect_to artifacts_url, notice: 'Artifact was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_artifact
        @artifact = Artifact.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def artifact_params
        params.require(:artifact).permit(:mapping_id)
      end
  end
end
