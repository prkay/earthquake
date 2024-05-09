import 'package:earthquake/features/model/earthquake_data_model.dart';
import 'package:earthquake/features/presentation/bloc/bloc.dart';
import 'package:earthquake/features/presentation/screens/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'widgets/common_container.dart';

class EarthQuakeDataScreen extends StatefulWidget {
  @override
  _EarthQuakeDataScreenState createState() => _EarthQuakeDataScreenState();
}

class _EarthQuakeDataScreenState extends State<EarthQuakeDataScreen> {
  bool isLoading = false;

  bool landingDone = false;
  int value = 1;
  late EarthQuakeBloc earthQuakeBloc;
  late ScrollController _scrollController;
  DateTime currentDate = DateTime.now();
  late DateTime _dateTime;
  String allProfiles = "";
  String allTypes = "";
  get newValue => null;
  int indes = 0;
  final formKey = new GlobalKey<FormState>();
  FocusNode magnituedFocus = FocusNode();
  final magnituedController = TextEditingController();
  List<Features> features = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    earthQuakeBloc = EarthQuakeBloc();
    earthQuakeBloc.add(EarthQuakePageReadyEvent());

    setState(() {
      _dateTime = currentDate;
    });
    super.initState();
  }

  @override
  void dispose() {
    earthQuakeBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: earthQuakeBloc,
      listener: (context, state) {
        if (state is EarthQuakeLoadingState) {
          print(state.isLoading);
        } else if (state is EarthQuakeDataLoadingSuccessState) {
          setState(() {
            features = state.features;
          });
          Navigator.pop(context);
          if (features.isEmpty) {
            showInSnackBar("No data found matching to your input.");
          }
        } else if (state is EarthQuakeDataLoadingFailedState) {
          Navigator.pop(context);
          showInSnackBar("Unable to fetch data. Please try again.");
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              GestureDetector(
                child: Container(
                  color: Color(0xffe6e9ef),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SafeArea(
                    child: SingleChildScrollView(
                        child: Container(
                      margin: EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height,
                      child: _getBodyContent(context, state),
                    )),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _getBodyContent(BuildContext context, state) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getCalenderPicker(context),
            _getMagnitudeInputField(context),
          ],
        ),
        _getSubmitButton(context),
        _getHeading(context),
        _getDataView(context),
      ],
    );
  }

  _getCalenderPicker(BuildContext context) {
    return CommonContainer(
      width: MediaQuery.of(context).size.width * 0.4,
      bodyContent: InkWell(
        child: _getSelectedDateBody(context),
        onTap: () => _showCalender(),
      ),
    );
  }

  _getSelectedDateBody(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Container(
          width: 40,
          height: 50,
          child: Image.asset(
            "images/calender.png",
          ),
        ),
        Text(
          _getSelectedDate(context),
          style: TextStyle(
            color: Color(0xff42697c),
            fontWeight: FontWeight.normal,
            fontSize: 10.0,
            letterSpacing: 0.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }

  String _getSelectedDate(BuildContext context) {
    return DateFormat('dd-MMM-yyyy ').format(_dateTime);
  }

  _getMagnitudeInputField(BuildContext context) {
    return Container(
        height: 50,
        child: CommonContainer(
          width: MediaQuery.of(context).size.width * 0.4,
          bodyContent: Form(
              key: formKey,
              child: TextFieldWidgets(
                inputStyle: _getTextStyleForInputField(),
                focusNode: magnituedFocus,
                labelStyle: _getTextStyleForInputField(),
                inputPlaceHolder: "Magnitude",
                controller: magnituedController,
                isVisible: false,
                validator: (value) {
                  return validateMagnitude(value, context);
                },
                inputType: TextInputType.number,
              )),
        ));
  }

  _getTextStyleForInputField() {
    return TextStyle(
      color: Color(0xff42697c),
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
      height: 1.50,
      letterSpacing: 0.2,
    );
  }

  validateMagnitude(value, BuildContext context) {
    if (value.toString().isEmpty) {
      return "Please enter magnitude";
    }
  }

  Future<void> _showCalender() async {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
            height: 300,
            color: Color(0xffffffff),
            child: Column(
              children: [
                Container(
                  height: 240,
                  child: CupertinoDatePicker(
                      initialDateTime: currentDate,
                      mode: CupertinoDatePickerMode.date,
                      maximumDate: DateTime.now().add(Duration(seconds: 60)),
                      minimumDate: DateTime.now().subtract(Duration(days: 365)),
                      onDateTimeChanged: (val) {
                        currentDate = val;
                      }),
                ),
                CupertinoButton(
                  child: Text("OK"),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    setState(() {
                      _dateTime = currentDate;
                    })
                  },
                )
              ],
            )));
  }

  _getSubmitButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xffe6e9ef),
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
            backgroundColor: Color(0xff2091cc),
          ),
          onPressed: () => _getData(),
          child: Padding(
              padding: EdgeInsets.only(top: 18, bottom: 18),
              child: Text(
                "Get Data",
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  height: 1.20,
                  letterSpacing: 0.25,
                ),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }

  _getData() {
    magnituedFocus.unfocus();
    final form = formKey.currentState;
    if (form?.validate() ?? false) {
      form?.save();
      _showIndicator();
      earthQuakeBloc.add(SubmitDataRequestEvent(
          date: DateFormat('yyyy-MM-dd').format(_dateTime),
          magnitude: magnituedController.text));
    }
  }

  void _showIndicator() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _getDataView(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        height: MediaQuery.of(context).size.height * 0.65,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: features.length,
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.all(8),
                child: CommonContainer(
                    color: Color(0xffffffff),
                    bodyContent: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 5, top: 10),
                            child: Text(
                              features[index].properties.title,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color(0xff42697c),
                                fontWeight: FontWeight.normal,
                                fontSize: 18.0,
                                letterSpacing: 0.2,
                              ),
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, bottom: 5),
                            child: Text(
                              features[index].properties.place,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color(0xff42697c),
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                                letterSpacing: 0.2,
                              ),
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, bottom: 5),
                            child: Text(
                              "Alert: " +
                                  features[index]
                                      .properties
                                      .alert
                                      .toString()
                                      .toUpperCase(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: features[index]
                                            .properties
                                            .alert
                                            .toString()
                                            .toLowerCase() ==
                                        "green"
                                    ? Colors.green
                                    : features[index]
                                                .properties
                                                .alert
                                                .toString()
                                                .toLowerCase() ==
                                            "yellow"
                                        ? Colors.yellow
                                        : Colors.red,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0,
                                letterSpacing: 0.2,
                              ),
                            )),
                        Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, bottom: 5),
                            child: Text(
                              "Status: " +
                                  features[index]
                                      .properties
                                      .status
                                      .toString()
                                      .toUpperCase(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: features[index]
                                            .properties
                                            .alert
                                            .toString()
                                            .toLowerCase() ==
                                        "green"
                                    ? Colors.green
                                    : features[index]
                                                .properties
                                                .alert
                                                .toString()
                                                .toLowerCase() ==
                                            "yellow"
                                        ? Colors.yellow
                                        : Colors.red,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0,
                                letterSpacing: 0.2,
                              ),
                            ))
                      ],
                    )));
          },
        ));
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
      ),
    );
  }

  _getHeading(BuildContext context) {
    return features.isNotEmpty
        ? Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text("Earthquakes Data",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(0xff2091cc),
                  fontWeight: FontWeight.normal,
                  fontSize: 25.0,
                  letterSpacing: 0.2,
                )),
          )
        : Padding(padding: EdgeInsets.all(0));
  }
}
