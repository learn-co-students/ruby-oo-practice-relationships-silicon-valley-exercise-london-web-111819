class Startup

    attr_accessor :name
    attr_reader :domain, :founder

    @@all = []

    def initialize(name:,domain:,founder:)
        @name = name 
        @domain = domain
        @founder = founder
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_by_founder(name_string:)
        Startup.all.find{|startup|startup.founder == name_string}
    end

    def self.domains
        Startup.all.map{|startup|startup.domain}.uniq
    end

    def pivot(domain_string:,name_string:)
        private_pivot(domain_string:domain_string,name_string:name_string)
        self
    end

    def sign_contract(venture_capitalist:,type:,investment:)
        FundingRound.new(startup:self,venture_capitalist:venture_capitalist,type:type,investment:investment)
    end

    def num_funding_rounds
        FundingRound.all.select{|fundinground|fundinground.startup == self}.count
    end

    def total_funds
        FundingRound.all.select{|fundinground|fundinground.startup == self}.map{|fundinground|fundinground.investment}.reduce(0){|sum,num|sum+num}
    end

    def investors
        FundingRound.all.select{|fundinground|fundinground.startup == self}.map{|fundinground|fundinground.venture_capitalist}.uniq
    end

    def big_investors
        (VentureCapitalist.tres_commas_club)&(self.investors)
    end

    private

    def private_pivot(domain_string:,name_string:)
        @domain = domain_string
        @name = name_string
    end 

end