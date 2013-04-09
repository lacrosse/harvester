require 'google_drive'

module Google
  CREDENTIALS = CREDENTIALS['google'].values_at('username', 'password')
  GATEWAY = GoogleDrive.login(*CREDENTIALS)
end
