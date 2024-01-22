class ListStaticDatas {
  static const List<String> vehicleBrands = [
    'Toyota',
    'Volkswagen',
    'Ford',
    'Honda',
    'Chevrolet',
    'Nissan',
    'Mercedes-Benz',
    'BMW',
    'Audi',
    'Hyundai',
    'Kia',
    'Tesla',
    'TATA',
    'Porsche',
    'Jaguar'
  ];

  static const List<String> fuelList = [
    'Electric',
    'Petrol',
    'Disel',
    'hybraid'
  ];
  static const List<String> transList = [
    'Automatic',
    'Manual',
    'Semi-Auto',
    'Other'
  ];
  static const List<String> seats = ['2', '4', '5', '7'];
}

List<dynamic> mainList = [
  ListStaticDatas.vehicleBrands,
  ListStaticDatas.transList,
  ListStaticDatas.fuelList,
  ListStaticDatas.seats
];
