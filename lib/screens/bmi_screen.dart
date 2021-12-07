import 'package:flutter/material.dart';
import '../shared/menu_bottom.dart';
import '../shared/menu_drawer.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  TextEditingController txtHeight = TextEditingController();
  TextEditingController txtWeight = TextEditingController();
  final double fontSize = 18;
  late List<bool> isSelected;
  String result = '';
  String heightMessage = '';
  String weightMessage = '';
  bool isMetric = true;
  bool isImperial = false;
  double? height;
  double? weight;

  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightMessage = 'Please enter your height in ' + (isMetric ? 'meters' : 'inches');
    weightMessage = 'Please enter your weight in ' + (isMetric ? 'kilos' : 'pounds');

    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      drawer: const MenuDrawer(),
      bottomNavigationBar: const MenuBottom(),
      body: Column(
        children: [
          ToggleButtons(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Metric', style: TextStyle(fontSize: fontSize))
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Imperial', style: TextStyle(fontSize: fontSize))
              ),
            ],
            isSelected: [isMetric, isImperial],
            onPressed: toggleMeasure,
          ),
          TextField(
            controller: txtHeight,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: heightMessage)
          ),
          TextField(
            controller: txtWeight,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: weightMessage)
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Calculate BMI', style: TextStyle(fontSize: fontSize))
          ),
          Text(result, style: TextStyle(fontSize: fontSize))
        ],
      ),
    );
  }

  void toggleMeasure(value) {
    if (value == 0) {
      isMetric = true;
      isImperial = false;
    } else {
      isMetric = false;
      isImperial = true;
    }
    setState(() {
      isSelected = isSelected;
    });
  }
}
