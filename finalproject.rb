require 'json'

puts "Entrez votre prénom, nom"
name = gets
chomped_name = name.chomp

puts "Entrez votre nom de département"
departement = gets
chomped_departement = departement.chomp

email_deputy = ""
name_deputy = ""
sexe_deputy = ""
compteur = 0
i = 0

while compteur < 575
    file = File.read('deputies/./temp' + compteur.to_s + '.json')
    data_hash = JSON.parse(file)
   while i < chomped_departement.length() + 1
        if data_hash['Departement'][i] == chomped_departement[i]
            name_deputy = data_hash['Nom']
            sexe_deputy = data_hash['Sexe']
            email_deputy = data_hash['Email']
            break
        else 
            i = i + 1
        end
    end
    compteur += 1
    i = 0
end

puts " "
puts "Bonjour " + sexe_deputy + " " + name_deputy
puts " "
puts "Je m'appelle " + chomped_name + " je réside dans " + chomped_departement + 
" et je me permet de vous contacter au sujet de la proposition de loi n° 2645 du député Mickaël Nogal concernant 
le dépot de garantie pour les locataires du privé. Je souhaite savoir quand est-ce que cette loi va être voté à l'Assemblée nationale ?"
puts " "
puts "Je vous adresse mes sincères salutations,"
puts " "
puts "Bien cordialement,"
puts name
puts " "
puts "Ps: Je suis sûr qu'en quelques mois je progresserai énormément a vos côtés chez Ding Dong !"
puts " "
puts "---------------------------------------------------"
puts " "
puts "Mail à adresser à " + email_deputy
puts " "
