require 'google_drive'

module Google
  CREDENTIALS = CREDENTIALS['google']
  GATEWAY = GoogleDrive.login(*CREDENTIALS.values_at('username', 'password')).spreadsheet_by_key(CREDENTIALS['spreadsheet']).worksheets[0]
end
