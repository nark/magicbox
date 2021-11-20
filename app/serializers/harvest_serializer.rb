class HarvestSerializer < ActiveModel::Serializer
  attributes :id, :grow, :havested_trim_weight, :havested_waste_weight, :havested_bud_weight, :dry_trim_weight, :dry_bud_weight
end
