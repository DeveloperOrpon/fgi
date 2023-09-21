class DivisionsRes {
  List<Divisions>? divisions;

  DivisionsRes({this.divisions});

  DivisionsRes.fromJson(Map<String, dynamic> json) {
    if (json['divisions'] != null) {
      divisions = <Divisions>[];
      json['divisions'].forEach((v) {
        divisions!.add(new Divisions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.divisions != null) {
      data['divisions'] = this.divisions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Divisions {
  String? id;
  String? name;
  String? bnName;
  String? lat;
  String? long;

  Divisions({this.id, this.name, this.bnName, this.lat, this.long});

  Divisions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bnName = json['bn_name'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['bn_name'] = this.bnName;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}

Map<String,dynamic> division={
  "divisions": [
    {
      "id": "1",
      "name": "Barishal",
      "bn_name": "বরিশাল",
      "lat": "22.701002",
      "long": "90.353451"
    },
    {
      "id": "2",
      "name": "Chattogram",
      "bn_name": "চট্টগ্রাম",
      "lat": "22.356851",
      "long": "91.783182"
    },
    {
      "id": "3",
      "name": "Dhaka",
      "bn_name": "ঢাকা",
      "lat": "23.810332",
      "long": "90.412518"
    },
    {
      "id": "4",
      "name": "Khulna",
      "bn_name": "খুলনা",
      "lat": "22.845641",
      "long": "89.540328"
    },
    {
      "id": "5",
      "name": "Rajshahi",
      "bn_name": "রাজশাহী",
      "lat": "24.363589",
      "long": "88.624135"
    },
    {
      "id": "6",
      "name": "Rangpur",
      "bn_name": "রংপুর",
      "lat": "25.743892",
      "long": "89.275227"
    },
    {
      "id": "7",
      "name": "Sylhet",
      "bn_name": "সিলেট",
      "lat": "24.894929",
      "long": "91.868706"
    },
    {
      "id": "8",
      "name": "Mymensingh",
      "bn_name": "ময়মনসিংহ",
      "lat": "24.747149",
      "long": "90.420273"
    }
  ]
};