require 'pxlsrt'
require 'fileutils'

formats = ['.png', '.jpg', '.jpeg', '.bmp', '.tiff']
images = []
for format in formats
	images = images.concat(Dir["./*#{format}"])
end
Dir.mkdir("./sorted") unless Dir.exists?("./sorted")
Dir.mkdir("./originals") unless Dir.exists?("./originals")
for image in images
	puts Pxlsrt::Helpers.red(image)
	FileUtils.mv(image, "./originals/#{image}")
	base = File.basename(image, File.extname(image))
	unless File.extname(image) == '.png'
		# ImageMagick
		system "convert ./originals/#{image} ./originals/#{base}.png"
	end
	# system "pxlsrt smart ./originals/#{base}.png ./sorted/#{base}.1.png -V -m alpha -r -d -t 200"
	Pxlsrt::Smart.suite("./originals/#{base}.png", "./sorted/#{base}.1.png", :verbose => true, :method => "alpha", :diagonal => true, :reverse => true, :threshold => 200)
	# system "pxlsrt smart ./sorted/#{base}.1.png ./sorted/#{base}.2.png -V -m alpha -r -d -v -t 200"
	Pxlsrt::Smart.suite("./sorted/#{base}.1.png", "./sorted/#{base}.2.png", :verbose => true, :method => "alpha", :diagonal => true, :vertical => true, :reverse => true, :threshold => 200)
end