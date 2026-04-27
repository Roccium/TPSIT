class Capo {
  final int? id;
  final String categoria;
  final String imagePath;

  Capo({this.id, required this.categoria, required this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoria': categoria,
      'imagePath': imagePath,
    };
  }

  factory Capo.fromMap(Map<String, dynamic> map) {
    
    return Capo(
      id: map['id'],
      categoria: map['categoria'],
      imagePath: map['imagePath'],
    );
  }
  
}

class SezioneArmadio {
  final String titolo;
  List<Capo> capi;
  String? coverPath;

  SezioneArmadio({
    required this.titolo,
    required this.capi,
    this.coverPath,
  });
}