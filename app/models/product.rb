class Product < ApplicationRecord
  # TODO add validations, etc

  def self.from_param(param)
    find_by_gtin!(param)
  end

  def to_param
    gtin
  end

  scope :full_text_search, ->(terms) {
    where([
      FULL_TEXT_SEARCH_SQL,
      { terms: map_search_terms(terms) }
    ])
  }

  private

  FULL_TEXT_SEARCH_SQL = <<~SQL
    to_tsvector('english', products.properties) @@ to_tsquery(:terms)
    OR to_tsvector('english', products.name) @@ to_tsquery(:terms)
    OR to_tsvector('english', products.brand_name) @@ to_tsquery(:terms)
  SQL

  private_constant :FULL_TEXT_SEARCH_SQL

  def self.map_search_terms(terms)
    Array
      .wrap(terms)
      .map{ |term| "#{term}:*" }
      .join(' & ')
  end
end
