class VentureCapitalist

    attr_accessor :name

    @@all = []

    def initialize(name:)
        @name = name
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def total_worth
        FundingRound.all.select{|fundinground|fundinground.venture_capitalist == self}.map{|his_fundinground|his_fundinground.investment}.reduce(0){|sum,num|sum+num}
    end

    def self.tres_commas_club
        vc_totals_hash = self.bring_vc_totals_hash
        #Find out which vcs are in the club - has invested more than 1Billion
        #vc_totals_hash.max_by{|vc,vc_total|vc_total}
        vc_totals_hash.select{|vc,vc_total|vc_total>1000000000}.map{|vc,amount|vc}
    end

    def offer_contract(startup:,type:,investment:)
        FundingRound.new(startup:startup,venture_capitalist:self,type:type,investment:investment)
    end

    def funding_rounds
        FundingRound.all.select{|fundinground|fundinground.venture_capitalist == self}
    end

    def portfolio
        funding_rounds.map{|fundinground|fundinground.startup}.uniq
    end

    def biggest_investment
        funding_rounds.select{|fundinground|fundinground.investment == funding_rounds.map{|fundinground|fundinground.investment}.max }
    end

    def invested(domain:)
        funding_rounds.select{|fundinground|fundinground.startup.domain == domain}.map{|fundinground|fundinground.investment}.reduce(0){|sum,num|sum+num}

    end


    private

    def self.bring_vc_totals_hash
        #define a hash - key: vc object, value: 0
        vc_totals_hash={}
        VentureCapitalist.all.each{|vc|vc_totals_hash[vc]=0}
        #group funding rounds by vc object and find out total investments per vc. assign those to the hash above
        FundingRound.all.group_by{|fundinground|fundinground.venture_capitalist}.each{|venture_capitalist,array_of_fundinground|vc_totals_hash[venture_capitalist] = array_of_fundinground.map{|fundinground|fundinground.investment}.reduce(0){|sum,num|sum+num}
        }
        vc_totals_hash
    end
        
end
