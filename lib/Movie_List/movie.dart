class Movie{  // model/pojo class
  final String id, name, languages, year, rating /*,earning*/;
  Movie({
    required this.id,
    required this.name,
    required this.languages,
    required this.year,
    required this.rating,
    //required this.earning,
  });
  factory Movie.fromJson(String id, Map<String, dynamic> json){
    return Movie(
      id: id,
      name: json['name'],
      languages: json['languages'],
      year: json['year'],
      rating: json['rating'],
      //earning: json['earning']??'Unknown',
    );
  }
}