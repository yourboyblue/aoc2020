module FileHelper
  def read_data(filename)
    puts data_path(filename)
    File.readlines(data_path(filename), "\n")
  end

  def data_path(filename)
    File.join(File.dirname(__FILE__), '..', 'data', filename)
  end
end
