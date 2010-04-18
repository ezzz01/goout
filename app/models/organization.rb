class Organization < Concept 
  belongs_to :country
  has_many :users, :through => :activities
  has_many :activities
  validates_uniqueness_of :title
  validates_presence_of :country

 def self.model_name
    name = "organization"
    name.instance_eval do
      def plural;   pluralize;   end
      def singular; singularize; end
    end
    return name
  end

end
