class Applicant < ActiveRecord::Base
  belongs_to :products
  belongs_to :members

end
