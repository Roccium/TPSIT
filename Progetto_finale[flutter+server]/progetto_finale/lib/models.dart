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
  List<Capo> capi; // Assicurati che il tipo coincida con quello del DB (Capo o CapoAbbigliamento)
  String? coverPath; // <-- AGGIUNGI QUESTA RIGA

  SezioneArmadio({
    required this.titolo,
    required this.capi,
    this.coverPath, // <-- AGGIUNGI AL COSTRUTTORE
  });
}