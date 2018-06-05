class Import
  include ActiveModel::Model
  extend CarrierWave::Mount

  attr_accessor :import_file, :name, :result

  validates :import_file, presence: true

  mount_uploader :import_file, DataUploader

  def do_import
    xml = File.read(import_file.path)
    data = Hash.from_xml(xml).deep_symbolize_keys!

    self.result = []
    data.each do |key, value|
      case key
        when :floor
          self.result += Floor.import(value)
        when :building
          self.result += Building.import(value)
        when :org
          self.result += Org.import(value)
        else
          self.result << I18n.t('import.key_unknown', item: key.to_s)
      end
    end
  end
end