if Module.const_defined?(:Debase)
  dirs = [Dir.pwd, 'lib', 'app'] # include non-rooted directories for rake

  dirs.each do |d|
    Debase.file_filter.include(d)
    puts("Debase configured with filter: #{d}")
  end

  Debase.file_filter.enable
end
