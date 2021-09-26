import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_info/models/city_model.dart';
import 'package:weather_info/models/home_model.dart';
import 'package:weather_info/models/select_city_model.dart';
import 'package:weather_info/widgets/app_card.dart';
import 'package:weather_info/widgets/gradient_container.dart';
import 'package:weather_info/constants/constants.dart' as Constants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectCityPage extends StatelessWidget {
  final _focusNode = FocusNode();

  SelectCityPage({Key? key}) : super(key: key);

  PreferredSizeWidget _buildAppBar({
    required BuildContext context,
    required SelectCityModel selectCity}) {
    final isFilterSelected = selectCity.isFilterSelected;
    final Widget title;
    if (isFilterSelected) {
      title = TextField(
        focusNode: _focusNode,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          prefixIcon: new Icon(Icons.search, color: Colors.white),
          hintText: AppLocalizations.of(context)!.search,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0
        ),
        onChanged: (text) {
          selectCity.changeFilterText(text);
        },
      );
    } else {
      title = Text(AppLocalizations.of(context)!.selectCity);
    }
    return AppBar(
      title: title,
      actions: [
        IconButton(
            icon: Icon(
                isFilterSelected ? Icons.cancel : Icons.search,
                color: Colors.white
            ),
            onPressed: () {
              selectCity.toggleFilter();
              if (selectCity.isFilterSelected) {
                _focusNode.requestFocus();
              }
            })
      ],
    );
  }

  Widget _buildCityRow({
    required BuildContext context,
    required CityModel city,
    required bool isSelected,
    required bool isLast,
    required VoidCallback onTap}) {
    return AppCard(
      margin: EdgeInsets.fromLTRB(
          Constants.appMargin,
          Constants.appMargin,
          Constants.appMargin,
          isLast ? Constants.appMargin : 0
      ),
      padding: EdgeInsets.zero,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(Constants.appPadding),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  city.name,
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              if (isSelected) Icon(
                  Icons.check_outlined,
                  color: Colors.red,
                  size: 35.0
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
    return Consumer2<SelectCityModel, HomeModel>(
      builder: (_, selectCity, home, __) {
        final cities = selectCity.filteredCities;
        final selectedCityId = home.selectedCityId;
        return Scaffold(
            appBar: _buildAppBar(context: context, selectCity: selectCity),
            backgroundColor: Color(0xFF398AE5),
            body: GradientContainer(
                child: ListView.builder(
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];
                      return _buildCityRow(
                          context: context,
                          city: city,
                          isSelected: city.id == selectedCityId,
                          isLast: index == cities.length - 1,
                          onTap: () {
                            final home = context.read<HomeModel>();
                            home.changeLocation(countryId: selectCity.selectedCountryId, cityId: city.id);
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          });
                    })
            )
        );
      }
    );
  }
}
