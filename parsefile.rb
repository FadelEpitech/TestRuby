require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'colorize'
require 'byebug'
require 'json'

compteur = 0
stock = 0
mycounter = 0

while compteur < 575
    file = File.read('deputies/./temp' + compteur.to_s + '.json')
    data_hash = JSON.parse(file)
    if data_hash['Sexe'] == "Mme"
        stock = 1
    else
        stock = 0
    end
    mycounter += stock 
    compteur += 1
end
puts "Vous souhaitez savoir combien il y a de femmes députées ?"
puts "Il y en a " + mycounter.to_s