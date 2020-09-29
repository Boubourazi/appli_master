class Promo {
  final String name;

  Promo(this.name);
}

class College {
  final String name;
  final int identifier;

  Future<List<Promo>> promos;
  College(this.name, this.identifier);

  int get id {
    return identifier;
  }
}
