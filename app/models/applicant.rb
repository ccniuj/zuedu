class Applicant < ActiveRecord::Base
  belongs_to :product
  belongs_to :member
  belongs_to :order
end
