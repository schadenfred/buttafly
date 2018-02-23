require_dependency "buttafly/application_controller"

module Buttafly
  class ArtifactsController < ApplicationController
    before_action :set_artifact, only: [:revert, :destroy]

    def destroy

      if @artifact.destroy
        redirect_back fallback_location: root_path, notice: 'Artifact was destroyed.'
      end
    end

    def revert
      mapping = @artifact.mapping
      @artifact.revert_record
      redirect_back fallback_location: root_path, notice: 'Artifact was reverted.'
    end

    private

      def set_artifact
        @artifact = Artifact.find(params[:id])
      end

      def artifact_params
        params.require(:artifact).permit(:mapping_id)
      end
  end
end
