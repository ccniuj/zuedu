class DiscountMatcher
  class Error < StandardError; end
  class ResourceHasNoLineItems < Error; end

  def self.match resource
    if resource.respond_to? :line_items
      group_and_earlybird_discount = Discount.group_and_earlybird_discount.
                                       where('prerequisite <= ?', resource.line_items.count).
                                       where('date_from < ? and date_to > ?', Time.now, Time.now).
                                       order(prerequisite: :DESC).
                                       first
      return group_and_earlybird_discount if group_and_earlybird_discount
      group_discount               = Discount.group_discount.
                                       where('prerequisite <= ?', resource.line_items.count).
                                       order(prerequisite: :DESC).
                                       first
      return group_discount if group_discount
      earlybird_discount           = Discount.earlybird_discount.
                                       where('date_from < ? and date_to > ?', Time.now, Time.now).
                                       order(date_from: :DESC).
                                       first
    else
      raise ResourceHasNoLineItems
    end
  end
end
