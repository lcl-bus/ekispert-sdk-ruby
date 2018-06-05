module UtilHelper
  def read_xml(xml_path)
    file_path = "spec/sample_xml/#{xml_path}"
    File.read(file_path).gsub(/\n\s*/, '')
  end
end
