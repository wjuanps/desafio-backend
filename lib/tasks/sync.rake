namespace :sync do
  desc 'Synchronize deputies from CSV file.'
  task :csv, [:csv_file] => :environment do |task, args|
    require_relative '../sync/csv_data/synchronizer'

    LOCAL_CSV_FILE = 'lib/tasks/seed/seed_files/csv/ano-2021.csv'.freeze

    synchronizer = Sync::CSVData::Synchronizer.new
    csv_file = args[:csv_file].present? ? args[:csv_file] : LOCAL_CSV_FILE

    synchronizer.sync(csv_file)
  end
end
