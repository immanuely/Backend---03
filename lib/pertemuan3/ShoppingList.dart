class ShoppingList {
  int id;
  String name;
  int sum;
  int hrg;

  

  ShoppingList(this.id, this.name, this.sum, this.hrg);

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'sum': sum, 'harga': hrg  };
  }

  @override
  String toString() {
    return 'id : $id\nname : $name\nsum : $sum \nhrg : $hrg';
  }
}
