namespace :crucible do
  namespace :db do
    desc 'Reset DB; by default pulls from a local dump under the db directory.'
    task :reset => :environment do
      dump_archive = File.join('db','crucible_reset.tar.gz')
      dump_extract = File.join('tmp','crucible_reset')
      target_db = Mongoid.default_session.options[:database]
      puts "Resetting #{target_db} from #{dump_archive}"
      Mongoid.default_session.with(database: target_db) { |db| db.drop }
      system "tar xf #{dump_archive} -C tmp"
      system "mongorestore -d #{target_db} #{dump_extract}"
      FileUtils.rm_r dump_extract
      reset_test_runs
    end
  end

  desc 'generate ctl'
  task :generate_ctl do |t, args|
    Crucible::Tests::Executor.generate_ctl
    FileUtils.rm_rf("public/ctl") if Dir.exists?("public/ctl")
    FileUtils.mv("ctl", "public/ctl")
  end

  # Simple helper method for shifting test runs to align to the current date
  def reset_test_runs
    today = Time.now

    # Define the left-shift for each test run by id, currently up to 30
    days_offset = {
      "5514ed474d4d3109c5fd3b00" => 6,
      "5514f0a14d4d3109c5f14300" => 5,
      "5514f1234d4d3109c5f54300" => 4,
      "5514f1ca4d4d3109c5fa4300" => 2,
      "5514ee7e4d4d3109c5003c00" => 5,
      "5514eedd4d4d3109c5043c00" => 4,
      "55150cef4d4d310f63fe0b00" => 3,
      "55150d754d4d310f63030c00" => 3,
      "5515fbbc4d4d311e4ffe0b00" => 2,
      "55198d9f4d4d3130e62f0600" => 1,
      "551998904d4d3130e6cc1800" => 1,
      "5519a00a4d4d3130e60b1f00" => 0,
      "551abacd4d4d3141ee2e0600" => 10,
      "551abb1d4d4d3141ee310600" => 8,
      "551abbc24d4d3141ee350600" => 7,
      "551abd054d4d3141ee3a1200" => 9,
      "551abd4d4d4d3141ee3c1200" => 7,
      "551abe3e4d4d3141ee3e1e00" => 12,
      "551abef44d4d3141ee481e00" => 9,
      "551ac05f4d4d3141ee7b2400" => 11
    }

    TestRun.all.each do |test_run|
      if days_offset[test_run.id.to_s]
        shifted_date = today - (days_offset[test_run.id.to_s]).days
        puts "Shifting #{test_run.id.to_s} from #{test_run.date} to #{shifted_date}."
        test_run.date = shifted_date
        test_run.save!
      else
        puts "Error! Could not find offset for #{test_run.id.to_s} at #{test_run.date}."
      end
    end

  end
end
