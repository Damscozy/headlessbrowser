import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:ekcab/model/ridemodel.dart';
import 'package:flutter/foundation.dart';

class ScraperService {
  static List<RideModel> run(String html) {
    try {
      final soup = BeautifulSoup(html);
      final items = soup.findAll('div', class_: 'show_cab_list_current');
      List<RideModel> rides = [];
      for (var item in items) {
        final rideTitle = item.find('span', class_: 'brand_names')?.text ?? '';
        // final carName = item.find('div', class_: '_css-cshipr')?.text ?? '';
        final imgUrl = item.find('img  ', class_: 'cab_list')?.text ?? '';
        final tripMin = item
                .find('span', class_: 'cabs_brand_list_brand_name_city_airport')
                ?.text ??
            '';
        final tripPrice = item.find('span', class_: 'exact_fares')?.text ?? '';
        final rideDescription = item
                .find('div', class_: 'cabs_brand_list_brand_name_city_airport')
                ?.text ??
            '';
        RideModel rideModel = RideModel(
          rideTitle: rideTitle,
          rideAmount: tripPrice,
          rideDesc: rideDescription,
          rideTime: tripMin,
          rideImg: imgUrl,
        );

        rides.add(rideModel);
      }
      return rides;
    } catch (ex) {
      if (kDebugMode) {
        print('Scrapping Response $ex');
      }
    }
    return [];
  }
}
