
// POJO (Plain Old Java Object)
class Country {
  final String? name;
  final String? capital;
  final int? population;
  final String? flag;

  Country({
    required this.name,
    required this.capital,
    required this.population,
    required this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    // call back to country
    return Country(
      name: json['name'],
      capital: json['capital'],
      population: json['population'],
      flag: json['media']['flag'],
    );
  }
}

//--------------------------------------------------------------//

class BeerM {
  final String? name;
  final String? price;
  final String? image;

  BeerM({
    required this.name,
    required this.price,
    required this.image
  });

  factory BeerM.fromJson(Map<String, dynamic> json) {
    // call back to movies
    return BeerM(
      name: json['name'],
      image: json['image'],
      price: json['price']
    );
  }
}

