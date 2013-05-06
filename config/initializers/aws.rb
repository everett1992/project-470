# load the libraries
require 'aws-sdk'
# log requests using the default rails logger
AWS.config(:logger => Rails.logger)

# load credentials from config/aws.yml
config_path = File.expand_path(File.dirname(__FILE__)+"/../aws.yml")
AWS.config(YAML.load(File.read(config_path)))
AWS::Rails.add_action_mailer_delivery_method(:amazon_ses)

# Set S3 bucket
ROOMIE_BUCKET = "#{AWS.config.credentials[:access_key_id][0..5]}_roomie-photo-store"
