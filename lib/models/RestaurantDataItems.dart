class RestaurantDataItems{
  List<FoodRecords> records;
  int records_count;

  RestaurantDataItems( {
    this.records,
    this.records_count,
  });

  factory RestaurantDataItems.fromJson(Map<String, dynamic> parsedJson){

    var records_list = parsedJson['records'] as List;
    print(records_list.runtimeType);
    List<FoodRecords> recordList = records_list.map((i) => FoodRecords.fromJson(i)).toList();

    return RestaurantDataItems(
        records:recordList,
        records_count:parsedJson['records_count']
    );
  }
}

class FoodRecords{
  String uuid;
  int weight;
  String name;
  String comment;
  bool available;
  int price;
  String image;
  String store_uuid;
  List<Toppings>toppings;
  String category;
  List<Variants>variants;
  int created_at_unix;

  FoodRecords( {
    this.uuid,
    this.weight,
    this.name,
    this.comment,
    this.available,
    this.price,
    this.image,
    this.store_uuid,
    this.toppings,
    this.category,
    this.variants,
    this.created_at_unix,
  });

  factory FoodRecords.fromJson(Map<String, dynamic> parsedJson){

    var toppings_list = parsedJson['toppings'] as List;
    List<Toppings> toppingsList = null;
    if(toppings_list != null){
      toppingsList = toppings_list.map((i) =>
          Toppings.fromJson(i)).toList();
    }

    var variants_list = parsedJson['variants'] as List;
    List<Variants> variantsList = null;
    if(variants_list != null){
      variantsList = variants_list.map((i) =>
          Variants.fromJson(i)).toList();
    }

    return FoodRecords(
      uuid: parsedJson['uuid'],
      weight: parsedJson['weight'],
      name: parsedJson['name'],
      comment: parsedJson['comment'],
      available: parsedJson['available'],
      price: parsedJson['price'],
      image: parsedJson['image'],
      store_uuid: parsedJson['store_uuid'],
      toppings: toppingsList,
      category: parsedJson['category'],
      variants: variantsList,
      created_at_unix: parsedJson['created_at_unix'],
    );
  }

}

class Toppings{
  String uuid;
  String name;
  int price;
  String comment;

  Toppings( {
    this.uuid,
    this.name,
    this.price,
    this.comment,
  });

  factory Toppings.fromJson(Map<String, dynamic> parsedJson){
    return Toppings(
      uuid:parsedJson['uuid'],
      name:parsedJson['name'],
      price:parsedJson['price'],
      comment:parsedJson['comment'],
    );
  }
}

class Variants{
  String uuid;
  String name;
  bool standard;
  int price;
  String comment;

  Variants( {
    this.uuid,
    this.name,
    this.standard,
    this.price,
    this.comment,
  });

  factory Variants.fromJson(Map<String, dynamic> parsedJson){
    return Variants(
      uuid:parsedJson['uuid'],
      name:parsedJson['name'],
      standard:parsedJson['standard'],
      price:parsedJson['price'],
      comment:parsedJson['comment'],
    );
  }
}