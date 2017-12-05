
desc "Import CSV"
  task :import_csv => :environment do
    Bowl.csv_import
  end