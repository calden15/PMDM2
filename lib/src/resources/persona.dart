class Persona {
  late String nom, cognoms, email, password;
  late DateTime dataNaixament;

  Persona(String nom, String cognoms, DateTime dataNaixament, String email,
      String password) {
    this.nom = nom;
    this.cognoms = cognoms;
    this.dataNaixament = dataNaixament;
    this.email = email;
    this.password = password;
  }
}
