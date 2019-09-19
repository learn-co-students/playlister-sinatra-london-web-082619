require './config/environment'

begin
  fi_check_migration

  enable :sessions


  use Rack::MethodOverride
  use ArtistsController
  use SongsController
  use GenresController
  run ApplicationController
  
rescue ActiveRecord::PendingMigrationError => err
  STDERR.puts err
  exit 1
end
