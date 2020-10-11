require_relative '../config/environment.rb'

def reload
  load 'config/environment.rb'
end

hot = Startup.new(name:"London AI Startup",domain:"AI",founder:"Hussein")
cold = Startup.new(name:"Amsterdam AI Startup",domain:"AI",founder:"John")
warm = Startup.new(name:"Another startup by John",domain:"AI",founder:"John")
money_boy = VentureCapitalist.new(name:"Trump")
money_girl = VentureCapitalist.new(name:"Melinda")
money_cousin = VentureCapitalist.new(name:"Calvey")
FundingA =FundingRound.new(startup:hot,venture_capitalist:money_boy,type:"Series A",investment:1111111)
FundingB =FundingRound.new(startup:hot,venture_capitalist:money_girl,type:"Series B",investment:22222222)
FundingC =FundingRound.new(startup:hot,venture_capitalist:money_boy,type:"Series C",investment:333333)
FundingCalvey1 =FundingRound.new(startup:hot,venture_capitalist:money_cousin,type:"Series C",investment:4444444)
FundingCalvey2 =FundingRound.new(startup:cold,venture_capitalist:money_cousin,type:"Series C",investment:2300333)
FundingCalvey3 =FundingRound.new(startup:hot,venture_capitalist:money_cousin,type:"Series C",investment:1000000000)
#AI_startup.founder = "New Founder" #Was atest. expected to fail and it did!


find1 = Startup.find_by_founder(name_string:"John")
pivot1 = hot.pivot(domain_string:"AI",name_string:"London 2")
#hot.domain = "test" #failed as expected
hot.name = "New NAme"
hot.sign_contract(venture_capitalist:money_cousin,type:"Series A",investment:666666.0)
offered = money_cousin.offer_contract(startup:cold,type:"IPO",investment:9999999999)
binding.pry
0 #leave this here to ensure binding.pry isn't the last line