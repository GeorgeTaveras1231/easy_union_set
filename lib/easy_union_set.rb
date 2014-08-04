module EasyUnionSet
  extend ActiveSupport::Concern

  module GroupMethods

    def & ar_rel
      set = self.intersect(ar_rel)
      table_alias = arel_table.create_table_alias(set, table_name)

      ancestors.first.from(table_alias)
    end

    def | ar_rel
      union = case ar_rel
              when ActiveRecord::Relation
                self.union(ar_rel)
              when Hash
                ar_rel.assert_valid_keys(:all)
                self.union(:all, ar_rel[:all])          
              end
      
      table_alias = arel_table.create_table_alias(union, table_name)

      ancestors.first.from(table_alias)
    end
  end

end


ActiveRecord::Relation.send(:include, EasyUnionSet::GroupMethods)