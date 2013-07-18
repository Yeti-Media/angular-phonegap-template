require 'erb'

namespace :package do
  desc "package and compress for mobile client"
  task :mobile, [:env] do |t, args|
    `cp -Rf app/* packager/android/assets/www/`
    `cp -Rf app/* packager/ios/www/`
    enviroments = ['development','staging','production']
    @client_type = 'mobile'
    @environment = args.env
    if enviroments.include? @environment
      index = ERB.new File.open('./src/index.html').read
      dirs = ['./packager/android/assets/www/', './packager/ios/www/']
      dirs.each do |dir|
        file = File.open(dir + 'index.html', 'w+')
        file.puts(index.result)
        file.close
      end
    else
      raise 'enviroment or client_type invalid'
    end
  end



  desc "package and compress for web client"
  task :web, [:env] do |t, args|
    enviroments = ['development','staging','production']
    @client_type = 'mobile'
    @environment = args.env
    if enviroments.include? @environment
      index = ERB.new File.open('./src/index.html').read
      file = File.open('./app/index.html', 'w+')
      file.puts(index.result)
      file.close
    else
      raise 'enviroment or client_type invalid'
    end
  end
end
