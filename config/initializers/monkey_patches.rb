require "fileutils"
# ratyrate patch
FileUtils.cp("/myapp/lib/monkey_patches/ratyrate/helpers.rb", "/usr/local/bundle/gems/ratyrate-1.2.2.alpha/lib/ratyrate/helpers.rb")