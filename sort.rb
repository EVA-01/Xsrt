require 'pxlsrt'
require 'fileutils'

jpg = Dir["./*.jpg"]
png = Dir["./*.png"]
images = jpg.concat(png)
Dir.mkdir("./sorted") unless Dir.exists?("./sorted")
Dir.mkdir("./originals") unless Dir.exists?("./originals")
for image in images
	puts Pxlsrt::Helpers.red(image)
	FileUtils.mv(image, "./originals/#{image}")
	if File.extname(image) == '.jpg'
		base = File.basename(image, '.jpg')
		# ImageMagick
		system "convert ./originals/#{image} ./originals/#{base}.png"
	else
		base = File.basename(image, '.png')
	end
	# Use system because I want to, idc
	system "pxlsrt smart ./originals/#{base}.png ./sorted/#{base}.1.png -V -m alpha -r -d -t 200"
	system "pxlsrt smart ./sorted/#{base}.1.png ./sorted/#{base}.2.png -V -m alpha -r -d -v -t 200"
end