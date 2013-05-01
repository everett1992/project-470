#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)


# AWS Tasks
namespace :aws do
	namespace :sns do

		# Used for SNS housekeeping if something goes wrong
		# Under normal circumstances, dont do this
		desc "Delete All SNS Topics (all of them, not just ones associated with this project)"
		task :delete => :environment do
			puts "This will delete all SNS topics associated with your AWS Account."
			print " Is this really what you want to do? [Y/n] "

			if STDIN.gets.chomp.downcase == 'n'
				puts 'Aborting'
			else
				# If we dont delete these topics we'll have problems
				stub_requests = AWS.config.stub_requests
				AWS.config(:stub_requests => false)

				print "Deleting all sns topics:"
				sns = AWS::SNS.new
				sns.topics.each { |topic| topic.delete }
				puts " Done."

				# Reset stub settings
				AWS.config(:stub_requests => stub_requests)
			end
		end
	end
end

namespace :db do
	desc "Delete SNS Topics"
	task :delete_topics => :environment do

		# If we dont delete these topics we'll have problems
		stub_requests = AWS.config.stub_requests
		AWS.config(:stub_requests => false)

		print 'Deleting Dwelling SNS Topics:'
		Dwelling.all.each do |dwelling|
			dwelling.destroy
		end
		puts ' Done.'

		# Reset stub settings
		AWS.config(:stub_requests => stub_requests)
	end

	desc "Delete SNS Topics"
	task :reset => :delete_topics
	desc "Delete SNS Topics"
	task :drop => :delete_topics
end
Roomie::Application.load_tasks


