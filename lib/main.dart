import 'package:flutter/material.dart';
import 'package:tip_calculator/utils/colors_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentSliderValue = 1;
  TextEditingController sliderController = TextEditingController();
  TextEditingController billAmountController = TextEditingController();
  int amount = 0;

  @override
  Widget build(BuildContext context) {

    void calculateTip(){
      if(billAmountController.text.isNotEmpty){
        setState(() {
          amount = ((_currentSliderValue / 100)* int.parse(billAmountController.text)).toInt();
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(amount.toString()),),);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter bill amount"),),);
      }

    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Tip Calculator",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorPrimary),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter Your Bill Amount:",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: billAmountController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.paypal_rounded),
                    hintText: "Enter your bill amount",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26)),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select Tip Percentage:",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 8,
                ),
                Slider(
                  value: _currentSliderValue.toDouble(),
                  max: 100,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value.toInt();
                      sliderController.text = _currentSliderValue.toString();
                    });
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                Center(
                    child: Container(
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.all(Radius.circular(13))),
                        child: Center(
                            child: Text(
                          _currentSliderValue.toString(),
                          style: TextStyle(color: Colors.white),
                        )))),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: (){
                    calculateTip();
                  },
                  child: Container(
                      height: 52,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.all(Radius.circular(26))),
                      child: Center(
                        child: Text(
                          "Calculate Tip",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      )),
                ),
                SizedBox(
                  height: 100,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tip Amount:",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 8,
                ),
                Container(
                    height: 52,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.all(Radius.circular(26))),
                    child: Center(
                      child: Text(
                        amount.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
