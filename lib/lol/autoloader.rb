Dir['lib/lol/*.rb'].each do |file|
  filename  = File.basename file
  classname = filename.split('.rb').first.camelize
  Lol.autoload classname, File.expand_path("../#{filename}", __FILE__)
end
