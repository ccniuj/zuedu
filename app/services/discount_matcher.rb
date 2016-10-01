class DiscountMatcher
  class Error < StandardError; end
  class ResourceHasNoLineItems < Error; end

  def self.match resource
    if resource.respond_to? :line_items
      group_and_earlybird_discount_id = Discount.group_and_earlybird_discount.
                                       where('prerequisite <= ?', resource.line_items.count).
                                       where('date_from < ? and date_to > ?', Time.now, Time.now).
                                       order(prerequisite: :DESC).
                                       first&.id
      return group_and_earlybird_discount_id if group_and_earlybird_discount_id
      group_discount_id              = Discount.group_discount.
                                         where('prerequisite <= ?', resource.line_items.count).
                                         order(prerequisite: :DESC).
                                         first&.id
      return group_discount_id if group_discount_id
      earlybird_discount_id          = Discount.earlybird_discount.
                                         where('date_from < ? and date_to > ?', Time.now, Time.now).
                                         order(date_from: :DESC).
                                         first&.id
    else
      raise ResourceHasNoLineItems
    end
  end
end
