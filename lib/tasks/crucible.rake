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
    end
  end
end
