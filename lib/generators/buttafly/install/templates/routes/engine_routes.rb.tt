module EngineRoutes
  def self.extended(router)
    router.instance_exec do
      mount Buttafly::Engine => "/buttafly"
    end
  end
end
