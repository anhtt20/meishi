class CompanySerializer < ActiveModel::Serializer
  attributes :company_id, :name, :address, :email, :tel, :fax, :url, :post_code
end