#!/usr/bin/env ruby 

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
	base = File.basename(image)
	FileUtils.mv(image, "./originals/#{base}")
	system "java -jar jXsrt/jXsrt.jar ./originals/#{base} ./sorted/#{base}"
end