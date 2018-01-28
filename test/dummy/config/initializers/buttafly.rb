Buttafly.setup do |config|
  config.originable_model = "ExcelSheet"

  ## Buttafly makes assumptions about which models you want to expose to record
  ##   creation, but you can have better control using a whitelist or a
  ##   blacklist -- but not both. If you choose the whitelist, only models you
  ##   put into the array below will be exposed:

  config.whitelisted_models = ["wine", "winery", "review", "user"]

  ## Inverse to the the whitelist is the blacklist. If you choose the blacklist,
  ##   models you put into the array below will be added to the list of models
  ##   Buttafly assumes should not be exposed:

  # config.blacklisted_models = []

  ## With either choice you can add models as symbols or strings:
  ## config.whiteorblacklist = [:wine, :wineries, "winery", "Review", "owners"]
end
