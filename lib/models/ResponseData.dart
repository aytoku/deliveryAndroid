import 'dart:ffi';

class DeliveryResponseData {
  List<Records> records;
  int records_count;

  DeliveryResponseData( {
    this.records,
    this.records_count,
  });

  factory DeliveryResponseData.fromJson(Map<String, dynamic> parsedJson){


    var records_list = parsedJson['records'] as List;
    print(records_list.runtimeType);
    List<Records> recordList = records_list.map((i) => Records.fromJson(i)).toList();

    return DeliveryResponseData(
      records:recordList,
      records_count:parsedJson['records_count']
    );
  }
}

class Records{
  String uuid;
  String name;
  String comment;
  bool own_delivery;
  String image;
  bool available;
  List<WorkSchedule> work_schedule;
  String type;
  List<String> product_category;
  List<DestinationPoints> destination_points;
  List<String> destination_points_uuid;
  int order_preparation_time_second;
  int created_at_unix;

  Records( {
    this.uuid,
    this.name,
    this.comment,
    this.own_delivery,
    this.image,
    this.available,
    this.work_schedule,
    this.type,
    this.product_category,
    this.destination_points,
    this.destination_points_uuid,
    this.order_preparation_time_second,
    this.created_at_unix,
  });

  factory Records.fromJson(Map<String, dynamic> parsedJson){

    var work_schedule_list = parsedJson['work_schedule'] as List;
    List<WorkSchedule> workScheduleList = null;
    if(work_schedule_list != null){
      workScheduleList = work_schedule_list.map((i) =>
          WorkSchedule.fromJson(i)).toList();
    }

    var destination_points_list = parsedJson['destination_points'] as List;
    List<DestinationPoints> destinationPointsList = null;
    if(destination_points_list != null){
      destinationPointsList = destination_points_list.map((i) =>
          DestinationPoints.fromJson(i)).toList();
    }

    var product_category_list = parsedJson['product_category'] as List;
    List<String> productCategoryList = new List<String>();
    if(product_category_list !=null) {
      product_category_list.forEach((element) {
        productCategoryList.add(element as String);
      });
    }

    var destination_points_uuid_list = parsedJson['destination_points_uuid'] as List;
    List<String> destinationPointsUuidList = new List<String>();
    if(destinationPointsUuidList != null){
      destination_points_uuid_list.forEach((element) {
        destinationPointsUuidList.add(element as String);
      });
    }

    return Records(
      uuid: parsedJson['uuid'],
      name: parsedJson['name'],
      comment: parsedJson['comment'],
      image: parsedJson['image'],
      work_schedule: workScheduleList,
      type: parsedJson['type'],
      product_category: productCategoryList,
      available: parsedJson['available'],
      destination_points: destinationPointsList,
      destination_points_uuid: destinationPointsUuidList,
      order_preparation_time_second: parsedJson['order_preparation_time_second'],
      created_at_unix: parsedJson['created_at_unix'],
    );
  }
}

class WorkSchedule{
  int week_day;
  bool day_off;
  int work_beginning;
  int work_ending;

  WorkSchedule( {
    this.week_day,
    this.day_off,
    this.work_beginning,
    this.work_ending,
  });

  factory WorkSchedule.fromJson(Map<String, dynamic> parsedJson){
    return WorkSchedule(
        week_day:parsedJson['week_day'],
        day_off:parsedJson['day_off'],
        work_beginning:parsedJson['work_beginning'],
        work_ending:parsedJson['work_ending'],
    );
  }
}

class DestinationPoints{
  String uuid;
  String point_type;
  String unrestricted_value;
  String value;
  String country;
  String region;
  String region_type;
  String type;
  String city;
  String category;
  String city_type;
  String street;
  String street_type;
  String street_with_type;
  String house;
  int front_door;
  String comment;
  bool out_of_town;
  String house_type;
  int accuracy_level;
  int radius;
  double lat;
  double lon;

  DestinationPoints( {
    this.uuid,
    this.point_type,
    this.unrestricted_value,
    this.value,
    this.country,
    this.region,
    this.region_type,
    this.type,
    this.city,
    this.category,
    this.city_type,
    this.street,
    this.street_type,
    this.street_with_type,
    this.house,
    this.front_door,
    this.comment,
    this.out_of_town,
    this.house_type,
    this.accuracy_level,
    this.radius,
    this.lat,
    this.lon,
  });

  factory DestinationPoints.fromJson(Map<String, dynamic> parsedJson){

    return DestinationPoints(
      uuid:parsedJson['uuid'],
      point_type:parsedJson['point_type'],
      unrestricted_value:parsedJson['unrestricted_value'],
      value:parsedJson['value'],
      country:parsedJson['country'],
      region:parsedJson['region'],
      region_type:parsedJson['region_type'],
      type:parsedJson['type'],
      city:parsedJson['city'],
      category:parsedJson['category'],
      city_type:parsedJson['city_type'],
      street:parsedJson['street'],
      street_type:parsedJson['street_type'],
      street_with_type:parsedJson['street_with_type'],
      house:parsedJson['house'],
      front_door:parsedJson['front_door'],
      comment:parsedJson['comment'],
      out_of_town:parsedJson['out_of_town'],
      house_type:parsedJson['house_type'],
      accuracy_level:parsedJson['accuracy_level'],
      radius:parsedJson['radius'],
      lat:parsedJson['lat'],
      lon:parsedJson['lon'],
    );
  }
}