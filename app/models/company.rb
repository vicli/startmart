class Company < ActiveRecord::Base
    before_save :default_values

    attr_accessible :avg_rating, :description, :name, :url, :category, :location
    has_many :reviews, :as => :reviewable
    has_many :partners

    validates_presence_of :description, :name, :url, :category, :location

    def default_values
        self.avg_rating ||= -1
    end

    #called whenever a new review is submitted
    def recalculate_average(review)
    	#if no reviews have been submitted
    	if(self.avg_rating == -1)
    		self.update_attribute(:avg_rating, review.rating)
    	else
			oldAvg = self.avg_rating
    		numRatings = self.reviews.size
			oldTotal = oldAvg * (numRatings-1)

    		newAvg = (oldTotal + review.rating) / (numRatings)

    		self.update_attribute(:avg_rating, newAvg)
    	end
    end

    def self.search(search)
        if search
            where('name LIKE ?', "%#{search}%")
        else
            scoped
        end
    end

        def self.filter(condition)
        if condition
            where('category LIKE ?', "%#{condition}%")
        else
            scoped
        end
    end

end
