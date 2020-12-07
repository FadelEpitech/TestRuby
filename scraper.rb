require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'colorize'
require 'byebug'
require 'json'

URL = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
URL2 = "http://www2.assemblee-nationale.fr"

def open_url(link)
	return nil if (link.empty? || link.nil?)
	page = Nokogiri::HTML(URI.open(link))
	if page then
		puts "Success".blue + " - #{link}" + " Extraction effectuée".red
		return page
	else
		puts "Error".red + " - #{link}  Non extrait" 
		return nil
	end
end

def scraper
	index = 0;
	deputy_list = []
	#tempHash = deputy_list
	assembly_page = open_url(URL)
	list_deputy_url = assembly_page.xpath("//a[starts-with(@href, '/deputes/fiche/')]/@href")
	
	list_deputy_url = list_deputy_url.map { |deputy|
		URL2 + deputy.text
	}
	
	list_deputy_url.each_with_index { |url, index|
		deputy_list[index]= Hash.new
		deputy_list[index] = get_deputy_hash(url)
		File.open("deputies/temp" + index.to_s + ".json","w") do |f|
			f.write(JSON.pretty_generate(deputy_list[index]))
		end	
	}
	
	puts "Nous avons trouvé #{deputy_list.size + 2} députés, et récupéré leur nom/prénom/sexe/mail/département"
	
	return deputy_list
end

def get_deputy_hash (url)

	return nil if (url.empty? || url.nil?)
	
	index = 0
	deputy_page = open_url(url)
	deputy_profile = Hash.new
	full_name = deputy_page.xpath("//div[@class='titre-bandeau-bleu clearfix']/h1/text()")
	departement = deputy_page.xpath("//p[@class='deputy-healine-sub-title']/text()")
	
	if full_name.text.empty? then
		puts "Error".red + " - @#{url}  cannot find data (full_name)" 
		return nil
	end

	deputy_profile["Sexe"] = full_name.text.split(" ").at(0)
	deputy_profile["Prénom"] = full_name.text.split(" ").at(1)
	deputy_profile["Nom"] = full_name.text.split(" ").at(2)
	deputy_profile["Departement"] = departement.text.split(" ").at(0)

	mail = deputy_page.xpath("//a[contains(text(), '@')]") 

	if mail.text.empty? then
		puts "Error".red + " - @#{url}  cannot find data (mail)"
		return nil
	end
	mail = mail.text.split("@").at(0) + "@assemblee-nationale.fr"
	deputy_profile["Email"] = mail

	return deputy_profile
end

scraper