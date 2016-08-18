class FileLocationSerializer < ActiveModel::Serializer
  attributes :file_type, :path, :domain
end
