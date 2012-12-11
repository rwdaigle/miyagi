desc "Regenerate font from app/assets/svg/*.svg"
task :font => :environment do
  font_name = "miyagi"
  input_dir = Rails.root.join("app/assets/svg")
  output_dir = Rails.root.join("app/assets/fonts")

  # Generate the new font
  system "fontcustom compile #{input_dir} --output=#{output_dir} --name=#{font_name} --nohash"
  
  # Remove unneeded generated files
  system "rm #{output_dir}/fontcustom.css"
  system "rm #{output_dir}/#{font_name}.eot"
  system "rm #{output_dir}/#{font_name}.svg"
  system "rm #{output_dir}/#{font_name}.ttf"

  # Collect all character names from SVG filenames
  characters = Dir.entries(input_dir).select {|f| f.ends_with?('svg') }.map{|f| f.sub('.svg', '') }.sort
  
  puts "create config/font.json for characters: #{characters.join(', ')}."

  File.open(Rails.root.join("config/font.json"), "w") do |file|
    file.write characters.to_json
  end    
end
