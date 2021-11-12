import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker/utility/coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  String selectedCurrency = 'USD';
  Map<String, String> cryptoPrice = {};

  updatePrice() async {
    for (String crypto in cryptoList) {
      var response = await coinData.getRate(crypto, selectedCurrency);
      cryptoPrice[crypto] = response['rate'].toStringAsFixed(0);
    }
    setState(() {});
  }

  List<Widget> cryptoCard() {
    List<Widget> cardList = [];
    for (String crypto in cryptoList) {
      cardList.add(
        Padding(
          padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          child: Card(
            color: Colors.lightBlueAccent,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
              child: Text(
                '1 $crypto = ${cryptoPrice[crypto]} $selectedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return cardList;
  }

  DropdownButton androidDropdown() {
    return DropdownButton<String>(
      value: selectedCurrency,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (String newValue) {
        selectedCurrency = newValue;
        updatePrice();
      },
      items: currenciesList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (value) {
        print(currenciesList[value]);
      },
      children: currenciesList.map((currency) {
        return Text(currency);
      }).toList(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatePrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('🤑 Coin Ticker'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: cryptoCard(),
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
              Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 30.0),
                  color: Colors.lightBlue,
                  child: Platform.isIOS ? iosPicker() : androidDropdown())
            ]));
  }
}
