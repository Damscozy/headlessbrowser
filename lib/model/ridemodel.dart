class RideModel {
  String? rideTitle;
  String? rideAmount;
  String? rideDesc;
  String? rideTime;
  String? rideImg;
  RideModel({
    this.rideTitle,
    this.rideAmount,
    this.rideDesc,
    this.rideTime,
    this.rideImg,
  });
  // Map<String, dynamic> toMap() {
  //   return {
  //     'rideTitle': rideTitle,
  //     'rideAmount': rideAmount,
  //     'rideDesc': rideDesc,
  //     'rideTime': rideTime,
  //     'rideImg': rideImg,
  //   };
  // }

  factory RideModel.fromMap(Map<String, dynamic> map) {
    return RideModel(
      rideTitle: map['rideTitle'] ?? '',
      rideAmount: map['rideAmount'] ?? '',
      rideDesc: map['rideDesc'] ?? '',
      rideTime: map['rideTime'] ?? '',
      rideImg: map['rideImg'] ?? '',
    );
  }
}
