module BirthTypeEnum
  extend ActiveSupport::Concern

  included do
    enum birth_type: {
	    :from_clone   => 0,
	    :from_seed    => 1
	  }
  end
end