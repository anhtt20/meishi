class CompanySerializer < ActiveModel::Serializer
  attribute :company_id
  attribute :name
  attribute :address, if: :is_display?
  attribute :email, if: :is_display?
  attribute :tel, if: :is_display?
  attribute :fax, if: :is_display?
  attribute :url, if: :is_display?
  attribute :post_code, if: :is_display?

  def is_display?
    scope[:controller] != 'api/v1/companies'
  end
end