import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_info/models/country_model.dart';
import 'package:weather_info/models/home_model.dart';
import 'package:weather_info/models/locations_model.dart';
import 'package:weather_info/models/select_city_model.dart';
import 'package:weather_info/screens/select_city_page.dart';
import 'package:weather_info/widgets/app_card.dart';
import 'package:weather_info/widgets/gradient_container.dart';
import 'package:weather_info/constants/constants.dart' as Constants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectCountryPage extends StatelessWidget {
  const SelectCountryPage({Key? key}) : super(key: key);

  void _navigateToCitiesPage({
    required BuildContext context,
    required CountryModel country}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProxyProvider<LocationsModel, SelectCityModel>(
              create: (_) => SelectCityModel(selectedCountryId: country.id),
              update: (_, locations, selectedCityModel) {
                if (selectedCityModel == null) throw ArgumentError.notNull('selectedCityModel');
                selectedCityModel.locations = locations;
                return selectedCityModel;
              },
              child: SelectCityPage(),
            )
        )
    );
  }

  Widget _buildCountryRow({
    required BuildContext context,
    required CountryModel country,
    required bool isSelected,
    required VoidCallback onTap}) {
    return AppCard(
      margin: EdgeInsets.fromLTRB(
          Constants.appMargin,
          Constants.appMargin,
          Constants.appMargin,
          0
      ),
      padding: EdgeInsets.zero,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(Constants.appPadding),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: Colors.grey
                    )
                ),
                child: Image(
                    image: country.assetImage,
                    width: 24.0,
                    height: 24.0),
              ),
              SizedBox(width: 9.0),
              Expanded(
                  child: Text(
                    country.name,
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500
                    ),
                  )
              ),
              if (isSelected) Icon(
                  Icons.check_outlined,
                  color: Colors.red,
                  size: 35.0
              ),
              Icon(
                Icons.chevron_right_outlined,
                size: 35.0,
              ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.selectCounty)
        ),
        body: GradientContainer(
            child: Consumer2<HomeModel, LocationsModel>(
                builder: (_, home, locations, __) {
                  final countries = locations.countries;
                  final selectedCountryId = home.selectedCountryId;
                  return ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        final country = countries[index];
                        return _buildCountryRow(
                            context: context,
                            country: country,
                            isSelected: country.id == selectedCountryId,
                            onTap: () {
                              _navigateToCitiesPage(
                                  context: context,
                                  country: country);
                            });
                      });
                })
        )
    );
  }
}