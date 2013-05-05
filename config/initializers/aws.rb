# load the libraries
require 'aws-sdk'
# log requests using the default rails logger
AWS.config(:logger => Rails.logger)

# load credentials from config/aws.yml
config_path = File.expand_path(File.dirname(__FILE__)+"/../aws.yml")
AWS.config(YAML.load(File.read(config_path)))
AWS::Rails.add_action_mailer_delivery_method(:amazon_ses)

PROFILE_BUCKET = 'roomie_profiles'
