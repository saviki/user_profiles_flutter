class User{

  var name;
  var city;

  User(this.name, this.city);

  User.fromJson(Map<String, dynamic> json){
    name = json['name'];
    city = json['city'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['city'] = city;

    return json;
  }

}