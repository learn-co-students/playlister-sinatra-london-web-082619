module Slug
  #Instance method: Return an instance's name as a slug
  def slug
    slug = self.name.downcase.gsub(" ", "-")
    # slug.scan(/[\^$.|?*+()]/) { | match | slug.gsub!(match, "") }
  end
end

module FindBySlug
  #Class method: Find an object of a given class by its slug
  def find_by_slug(slug)
    name = slug.split("-").join(" ")
    self.where("lower(name) = ?", name).first
  end
end