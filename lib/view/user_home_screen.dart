
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import '../data/response/status.dart';
import '../model/providers_list_model.dart';
import '../res/app_url.dart';
import '../res/components/check_loading_progress.dart';
import '../res/components/formatted_date.dart';
import '../res/components/info_text.dart';
import '../utils/utils.dart';
import '../view model/user_home_view_model.dart';


class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  UserHomeViewModel _userHomeViewModel = UserHomeViewModel();

  double _height = 0.0;

  ProvidersListModel providersListModel = ProvidersListModel();

  @override
  void initState() {
    super.initState();
    _userHomeViewModel.fetchProvidersList();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        // Using "provider.properties" because "UserHomeViewModel" has same name properties.
        // To resolve ambiguity (duplicacy), we use "provider.properties"
        body: provider.ChangeNotifierProvider<UserHomeViewModel>(
          create: (context) => _userHomeViewModel,
          child: provider.Consumer<UserHomeViewModel>(
            builder: (context, value, child) {
              debugPrint(value.apiResponse.status.toString());
              switch (value.apiResponse.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.ERROR:
                  return Utils.toastMessage(
                      value.apiResponse.message.toString());
                case Status.COMPLETED:
                  providersListModel = value.apiResponse.data!;
                  debugPrint(value.apiResponse.data.toString());
                  return _buildUserHome();
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUserHome() {
    return Column(
      children: [
        _buildInfoBar(),
        scrollableList(),
      ],
    );
  }

  Expanded scrollableList() {
    return Expanded(
      child: ListView(
        children: [
          ItemsSlider(providersListModel: providersListModel),
          SizedBox(height: _height * .03),

          // List of List Tile Business Items
          ..._buildBusinessLIst(), // Spread Operator to assign single widget from list of widgets, one by one.
        ],
      ),
    );
  }

  Container _buildInfoBar() {
    // Info Background
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),

      // Info Items
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cashSmartText(),
          SizedBox(height: _height * .02),
          FormattedDate(),
          SizedBox(height: _height * .01),
          SearchBar(),
        ],
      ),
    );
  }

  List<Widget> _buildBusinessLIst() {
    List<Widget> businessCards = [];
    int index = 0;
    for (final businessInfo in providersListModel.data ?? []) {
      businessCards.add(_buildBusinessCard(index, businessInfo));
      index++;
    }
    return businessCards;
  }

  Card _buildBusinessCard(int index, Data businessInfo) {
    return Card(
      elevation: 5,
      child: ListTile(
          minVerticalPadding: 15, // Increase height of the listTile
          leading: _buildCompanyImage(index),
          title: BusinessListItem(
            percentage: businessInfo.percentage.toString(),
            note: businessInfo.provider!.note.toString(),
            businessName: businessInfo.provider!.businessName.toString(),
          )),
    );
  }

  Widget _buildCompanyImage(int index) {
    return Container(
      width: 100, // Distance between text & image
      child: Transform.scale(
        // Increase the size of image
        scale: 1.3,
        child: Image(
          image: NetworkImage(
            AppUrl.baseUrl +
                providersListModel.data![index].provider!.imagePath.toString(),
          ),
          loadingBuilder: (context, child, loadingProgress) {
            return CheckLoadingProgress(
                loadingProgress: loadingProgress, child: child);
          },
        ),
      ),
    );
  }

  Text cashSmartText() {
    return Text(
      "Cash Smart",
      style: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
    );
  }
}

class BusinessListItem extends StatelessWidget {
  final String percentage;
  final String note;
  final String businessName;

  BusinessListItem({
    required this.percentage,
    required this.note,
    required this.businessName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoText(
            color: Colors.pinkAccent,
            title: '$percentage% Cashback',
            fontSize: 16),
        infoText(color: Colors.black, title: note, fontSize: 16),
        infoText(color: Colors.amber, title: businessName, fontSize: 16),
      ],
    );
  }
}

class ItemsSlider extends StatefulWidget {
  final ProvidersListModel providersListModel;
  const ItemsSlider({super.key, required this.providersListModel});

  @override
  State<ItemsSlider> createState() => _ItemsSliderState();
}

class _ItemsSliderState extends State<ItemsSlider> {
  List<Data> highlightedList = [];

  void addHighlightedData() {
    for (Data data in widget.providersListModel.data!) {
      // Condition: Show only those objects which have only 1 highlight
      if (data.provider!.highlight == 1) highlightedList.add(data);
    }
  }

  @override
  void initState() {
    super.initState();
    addHighlightedData();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: highlightedList.length,
      itemBuilder: (context, index, realIndex) {
        final business = highlightedList[index];
        return Card(
          elevation: 3,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              bgImage(business),
              SizedBox(height: 06),
              Expanded(
                child: ListView(
                  // In order to ignore overflow case, when "enlargeCenterPage" enabled
                  children: [
                    infoListTile(business),
                  ],
                ),
              )
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 260,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 3500),
      ),
    );
  }

  Widget infoListTile(Data business) {
    return ListTile(
      leading: companyImage(business),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoText(
                title: business.provider!.businessName.toString(),
                color: Colors.black),
            infoText(
                title: "${business.percentage.toString()}% Cashback",
                color: Colors.pinkAccent),
            infoText(
                title: business.provider!.note.toString(),
                color: Colors.black38),
          ],
        ),
      ),
    );
  }

  Widget companyImage(Data business) {
    return Image(
      image: NetworkImage(
        AppUrl.baseUrl + business.provider!.imagePath.toString(),
      ),
      loadingBuilder: (context, child, loadingProgress) =>
          CheckLoadingProgress(loadingProgress: loadingProgress, child: child),
    );
  }

  Widget bgImage(Data business) {
    return Container(
      height: 150,
      width:
          double.infinity, // To fixed the height and width of background image
      child: Image(
        image: NetworkImage(
            AppUrl.baseUrl + business.provider!.backgroundImagePath.toString()),

        // Stretch the image
        fit: BoxFit.cover,

        loadingBuilder: (context, child, loadingProgress) =>
            CheckLoadingProgress(
                loadingProgress: loadingProgress, child: child),
      ),
    );
  }
}
