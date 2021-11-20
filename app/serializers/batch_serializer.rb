class BatchSerializer < ActiveModel::Serializer
  attributes :id, :grow_id, :harvest_id, :name, :total_weight, :batch_weight, :batch_count
end
