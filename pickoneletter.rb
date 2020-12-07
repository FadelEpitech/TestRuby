require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'colorize'
require 'byebug'
require 'json'


def pickoneletter(argv)

    compteur = 0
    i = 0

    puts "Voici la liste des député(e)s possédant cette lettre dans leur nom :"

    while compteur < 575
        file = File.read('deputies/./temp' + compteur.to_s + '.json')
        data_hash = JSON.parse(file)
        while i < data_hash['Nom'].length + 1
            if data_hash['Nom'][i] == argv
                puts "- " + data_hash['Prénom'] + " " + data_hash['Nom']
                break
            else
                i = i + 1 
            end
        end
        compteur = compteur + 1
            i = 0
    end
end 

pickoneletter('B')