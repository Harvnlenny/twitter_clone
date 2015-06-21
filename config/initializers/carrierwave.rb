CarrierWave.configure do |config|

    require 'carrierwave/orm/activerecord'

    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                'us-east-1'
    }

    #config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
    
    config.fog_directory  = ENV['AWS_BUCKET_NAME']
    config.fog_public     = false
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  end