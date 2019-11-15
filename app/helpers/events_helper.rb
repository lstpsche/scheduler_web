# frozen_string_literal: true

module EventsHelper
  def weekdays_collection
    I18n.t('weekdays').inject([]) do |collection, (key, value)|
      collection.push([value.capitalize, key])
    end
  end
end
