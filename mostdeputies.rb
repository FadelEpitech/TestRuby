require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'colorize'
require 'byebug'
require 'json'

    stock = 0
    compteur = 0

    while compteur < 575
        file = File.read('deputies/./temp' + compteur.to_s + '.json')
        data_hash = JSON.parse(file)
        if data_hash['Departement'] = "Z"
            stock = stock + 1
        end
        compteur = compteur + 1
    end
    puts stock