Buttafly.setup do |config|  config.flat_file_col = "flat_file"

  ## If you would prefer to use an existing model for spreadsheets, change it
  ## below, along with the column the column in the model storing file path:

  config.originable_model = "Buttafly::Spreadsheet"
  config.flat_file_col = "flat_file"


  ## Buttafly makes assumptions about which models you want to expose to record
  ##   creation but can have better control using a whitelist or a
  ##   blacklist though importantly, not both. If you choose the whitelist,
  ##   only models you put into the array below will be exposed:

  # config.whitelisted_models = []

  ## Inverse to the the whitelist is the blacklist. If you choose the blacklist,
  ##   models you put into the array below will be added to the list of models
  ##   Buttafly assumes should not be exposed:

  # config.blacklisted_models = []

  ## With either choice you can add models as symbols or strings:
  ## config.whiteorblacklist = [:wine, :wineries, "winery", "Review", "owners"]

  ### TODO: config.aasm_state_column_name and create migration to model (pass a)
end
