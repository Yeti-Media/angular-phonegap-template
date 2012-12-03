namespace :package do
  desc "package and compress for mobile client"
  task :mobile, [:client, :env, :emulator] do |t, args|
    require 'erb'
    `cp -Rf app/* packager/android/assets/www/`
    `cp -Rf app/* packager/ios/www/`
    client_types = ['web', 'mobile']
    enviroments = ['development','staging','production']
    @client_type = args.client
    @environment = args.env
    @emulator = args.emulator
    if client_types.include? @client_type and enviroments.include? @environment
      index = ERB.new File.open('./src/index.html').read
      if @client_type == 'mobile'
        dirs = ['./packager/android/assets/www/', './packager/ios/www/']
        dirs.each do |dir|
          file = File.open(dir + 'index.html', 'w+')
          file.puts(index.result)
          file.close
        end
      else
        file = File.open('./app/index.html', 'w+')
        file.puts(index.result)
        file.close
      end
    else
      raise 'enviroment or client_type invalid'
    end
  end
end
