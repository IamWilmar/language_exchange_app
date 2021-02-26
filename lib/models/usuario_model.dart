class Usuario {
    Usuario({
        this.speakLanguage,
        this.learnLanguage,
        this.biography,
        this.photo,
        this.gender,
        this.age,
        this.nombre,
        this.email,
        this.uid,
    });

    String speakLanguage;
    String learnLanguage;
    String biography;
    String photo;
    String gender;
    int age;
    String nombre;
    String email;
    String uid;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        speakLanguage: json["speak_language"],
        learnLanguage: json["learn_language"],
        biography: json["biography"],
        photo: json["photo"],
        gender: json["gender"],
        age: json["age"],
        nombre: json["nombre"],
        email: json["email"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "speak_language": speakLanguage,
        "learn_language": learnLanguage,
        "biography": biography,
        "photo": photo,
        "gender": gender,
        "age": age,
        "nombre": nombre,
        "email": email,
        "uid": uid,
    };
}
