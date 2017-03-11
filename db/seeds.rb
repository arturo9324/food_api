# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: "pdao113787@gmail.com", password: "12345678", password_confirmation: "12345678")
user.be_admin

measures_product = Measure.create([{nombre: "Kilogramos", abreviacion: "kg"}, {nombre: "Mililitros", abreviacion: "ml"}, 
	{nombre: "Litros", abreviacion: "lt"}, {nombre: "Onzas", abreviacion: "oz"}, {nombre: "Gramos", abreviacion: "gr"}])

measures_nutrients = Measure.create([{nombre: "Miligramos", abreviacion: "mg"}, {nombre: "kilocalorias/calorias", abreviacion: "Kcal"}, 
	{nombre: "Microgramos", abreviacion: "mcg"}])

nutrients = Nutrient.create([{nombre: "Proteina", measure: measures_product.last}, {nombre: "Carbohidratos", measure: measures_nutrients.second}, 
	{nombre: "Fibra dietética", measure: measures_product.last}, {nombre: "Lipidos/Grasas", measure: measures_nutrients.second}, 
	{nombre: "Grasas saturadas", measure: measures_nutrients.second}, {nombre: "Grasas poliinsaturadas", measure: measures_nutrients.second},
	{nombre: "Grasas monoinsaturadas", measure: measures_nutrients.second}, {nombre: "Grasas trans (Hidrogenada / Parcialmente hidrogenada)", measure: measures_nutrients.second},
	{nombre: "Azucares", measure: measures_nutrients.second}, {nombre: "Vitamina A", measure: measures_nutrients.last},
	{nombre: "Tiamina", measure: measures_nutrients.first}, {nombre: "Riboflavina", measure: measures_nutrients.first},
	{nombre: "Niacina", measure: measures_nutrients.first}, {nombre: "Vitamina B6", measure: measures_nutrients.first},
	{nombre: "Ácido fólico", measure: measures_nutrients.last}, {nombre: "Vitamina B12", measure: measures_nutrients.last},
	{nombre: "Vitamina C", measure: measures_nutrients.first}, {nombre: "Calcio (Ca)", measure: measures_nutrients.first},
	{nombre: "Sodio (Na)", measure: measures_nutrients.first}, {nombre: "Potasio (K)", measure: measures_nutrients.first},
	{nombre: "Fósforo (P)", measure: measures_nutrients.first}, {nombre: "Manganeso (Mn)", measure: measures_nutrients.first},
	{nombre: "Hierro (Fe)", measure: measures_nutrients.first}, {nombre: "Zinc (Zn)", measure: measures_nutrients.first}, 
	{nombre: "Vitamina D", measure: measures_nutrients.last}, {nombre: "Vitamina E", measure: measures_nutrients.first},
	{nombre: "Vitamina K", measure: measures_nutrients.last}, {nombre: "Biotina", measure: measures_nutrients.last},
	{nombre: "Vitamina B5 (Ácido pantoténico)", measure: measures_nutrients.first}, {nombre: "Magnesio (Mg)", measure: measures_nutrients.first},
	{nombre: "Yodo (I)", measure: measures_nutrients.last}, {nombre: "Flúor (F)", measure: measures_nutrients.first}, {nombre: "Cobre (Cu)", measure: measures_nutrients.last},
	{nombre: "Selenio (Se)", measure: measures_nutrients.last}, {nombre: "Cloro (Cl)", measure: measures_nutrients.first}, {nombre: "Cromo (Cr)", measure: measures_nutrients.last},
	{nombre: "Molibdeno (Mo)", measure: measures_nutrients.last}, {nombre: "Vitamina B7 (Colina)", measure: measures_nutrients.first}])

diseases = Disease.create([{nombre: "Diabetes"},{nombre: "Hipertensión"}])