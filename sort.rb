#!/usr/bin/env jruby 

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
	puts image
	base = File.basename(image)
	extless = File.basename(image, File.extname(image))
	FileUtils.mv(image, "./originals/#{base}")
	img1 = PxlsrtJ::Smart.suite("./originals/#{base}", "./sorted/#{extless}.1.png", :method => "none", :diagonal => true, :reverse => true, :threshold => 200)
	img2 = PxlsrtJ::Smart.suite("./sorted/#{extless}.1.png", "./sorted/#{extless}.2.png", :method => "none", :diagonal => true, :vertical => true, :reverse => true, :threshold => 200)
end