import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:weather_info/models/home_model.dart';
import 'package:weather_info/screens/records_page.dart';
import 'package:weather_info/screens/select_country_page.dart';
import 'package:weather_info/widgets/app_card.dart';
import 'package:weather_info/screens/temp_page.dart';
import 'package:weather_info/screens/extreme_temp_page.dart';
import 'package:weather_info/screens/chart_temp_page.dart';
import 'package:weather_info/constants/constants.dart' as Constants;
import 'package:weather_info/widgets/custom_app_button.dart';
import 'package:weather_info/widgets/gradient_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPageIndex = 0;

  void _navigateToCountriesPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectCountryPage()
        )
    );
  }

  _selectDate(BuildContext context) async {
    final homeModel = context.read<HomeModel>();
    final DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: homeModel.selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
    if (picked != null) {
      homeModel.changeDate(picked);
    }
  }

  Widget _buildInfo() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Selector<HomeModel, String>(
              selector: (_, home) => home.getSelectedLocationAsString(context),
              builder: (_, locationAsString, __) {
                return CustomAppButton(
                    iconData: Icons.location_city_outlined,
                    title: locationAsString,
                    onPressed: () {
                      _navigateToCountriesPage();
                    });
              }),
          SizedBox(height: 4.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Selector<HomeModel, String>(
                    selector: (_, home) => home.getSelectedDateAsString(context),
                    builder: (_, dateAsString, __) {
                      return CustomAppButton(
                          iconData: Icons.calendar_today_outlined,
                          title: dateAsString,
                          onPressed: () {
                            _selectDate(context);
                          });
                    }),
              CustomAppButton(
                  iconData: Icons.watch_later_outlined,
                  title: AppLocalizations.of(context)!.today,
                  onPressed: () {
                    final homeModal = context.read<HomeModel>();
                    homeModal.setTodayDate();
              })
            ],
          )
        ],
      ),
      margin: EdgeInsets.fromLTRB(Constants.appMargin, 0, Constants.appMargin, 0),
      padding: EdgeInsets.all(Constants.appPadding),
    );
  }

  PageView _buildPageView() {
    final pageController = PageController(initialPage: _selectedPageIndex);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: pageController,
      children: [
        TemperaturesPage(),
        ChartTemperaturePage(),
        ExtremeTemperaturesPage(kind: ExtremeTemperatureKind.maximum),
        ExtremeTemperaturesPage(kind: ExtremeTemperatureKind.minimum),
        RecordsPage()
      ],
      onPageChanged: (pageIndex) => _selectedPageIndex = pageIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GradientContainer(
            child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 0.5 * Constants.appMargin),
                    _buildInfo(),
                    SizedBox(height: Constants.appMargin),
                    Expanded(
                        child: Consumer<HomeModel>(
                            builder: (_, home, __) {
                              switch (home.apiStatus) {
                                case WeatherApiStatus.loaded:
                                  if (home.hasData) {
                                    return _buildPageView();
                                  } else {
                                    return Container();
                                  }
                                case WeatherApiStatus.loading:
                                  return Container(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(
                                          color: Colors.amberAccent
                                      )
                                  );
                                case WeatherApiStatus.error:
                                  return Container(
                                      child: Center(
                                        child: AppCard(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    home.apiErrorMessage ?? '',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  CustomAppButton(
                                                      iconData: Icons.error,
                                                      title: 'Retry',
                                                      onPressed: () {
                                                        final homeModel = context.read<HomeModel>();
                                                        homeModel.fetchData();
                                                      })
                                                ]),
                                            padding: EdgeInsets.all(Constants.appPadding),
                                          ),
                                      )
                                  );
                              }
                            })
                    ),
                  ],
                )
            )
        )
    );
  }
}
