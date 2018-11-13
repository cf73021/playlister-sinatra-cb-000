module Slugifiable

  module InstanceMethods
    def slug
      self.name.to_s.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find do |t|
        t.slug == slug
      end
    end
  end
  
end
