import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  String value = '?';

  //TODO 7: Figure out a way of displaying a '?' on screen while we're waiting for the price data to come back. Hint: You'll need a ternary operator.

  //TODO 6: Update this method to receive a Map containing the crypto:price key value pairs. Then use that map to update the CryptoCards.
  Map<String, String> coinValues = {};
  //7: Figure out a way of displaying a '?' on screen while we're waiting for the price data to come back. First we have to create a variable to keep track of when we're waiting on the request to complete.
  bool isWaiting = false;

  void getData() async {
    //7: Second, we set it to true when we initiate the request for prices.
    isWaiting = true;
    try {
      //6: Update this method to receive a Map containing the crypto:price key value pairs.
      var data = await CoinData().getCoinData(selectedCurrency);
      //7. Third, as soon the above line of code completes, we now have the data and no longer need to wait. So we can set isWaiting to false.
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  //TODO: For bonus points, create a method that loops through the cryptoList and generates a CryptoCard for each.
  // Column makeCards() {
//    List<CryptoCard> cryptoCards = [];
//    for (String crypto in cryptoList) {
//      cryptoCards.add(
//        CryptoCard(
//          cryptoCurrency: crypto,
//          selectedCurrency: selectedCurrency,
//          value: isWaiting ? '?' : coinValues[crypto],
//        ),
//      );
//    }
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.stretch,
//      children: cryptoCards,
//    );
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0f0f33),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF2eb075),
        title: Text(
          'Coin Ticker',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Roboto Condensed',
          ),
        ),
        toolbarHeight: 70,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //TODO 1: Refactor this Padding Widget into a separate Stateless Widget called CryptoCard, so we can create 3 of them, one for each cryptocurrency.
          //TODO 2: You'll need to able to pass the selectedCurrency, value and cryptoCurrency to the constructor of this CryptoCard Widget.
          //TODO 3: You'll need to use a Column Widget to contain the three CryptoCards.
          Flexible(
            child: ListView(
              children: [
                CryptoCard(
                    iconUrl:
                        'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/4caf2b16a0174e26a3482cea69c34cba.png',
                    crypto: 'BTC',
                    value: isWaiting ? '...' : coinValues['BTC'],
                    selectedCurrency: selectedCurrency),
                CryptoCard(
                    iconUrl:
                        'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/604ae4533d9f4ad09a489905cce617c2.png',
                    crypto: 'ETH',
                    value: isWaiting ? '...' : coinValues['ETH'],
                    selectedCurrency: selectedCurrency),
                CryptoCard(
                    iconUrl:
                        'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/e652b0cdc9b54ad4af4c28a2804c51dc.png',
                    crypto: 'LTC',
                    value: isWaiting ? '...' : coinValues['LTC'],
                    selectedCurrency: selectedCurrency),
                CryptoCard(
                    iconUrl:
                        'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/2701173b1b7740f286939659359e225c.png',
                    crypto: 'ADA',
                    value: isWaiting ? '...' : coinValues['ADA'],
                    selectedCurrency: selectedCurrency),
                CryptoCard(
                    iconUrl:
                        'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/b9afd327327a435c80448040e8d4a2eb.png',
                    crypto: 'DOT',
                    value: isWaiting ? '...' : coinValues['DOT'],
                    selectedCurrency: selectedCurrency),
                CryptoCard(
                    iconUrl:
                        'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/a7587cc1505544ecbc577b56f17d38f9.png',
                    crypto: 'BCH',
                    value: isWaiting ? '...' : coinValues['BCH'],
                    selectedCurrency: selectedCurrency),
                CryptoCard(
                    iconUrl:
                        'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/99ab21c646f04f17b919a433eeeb816d.png',
                    crypto: 'XLM',
                    value: isWaiting ? '...' : coinValues['XLM'],
                    selectedCurrency: selectedCurrency),
                CryptoCard(
                    iconUrl:
                        'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/63e240f3047f41c791796784bc719f63.png',
                    crypto: 'DOGE',
                    value: isWaiting ? '...' : coinValues['DOGE'],
                    selectedCurrency: selectedCurrency),
                CryptoCard(
                    iconUrl:
                        'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/5ed65416963e4e57998a3c302da8936e.png',
                    crypto: 'USDT',
                    value: isWaiting ? '...' : coinValues['USDT'],
                    selectedCurrency: selectedCurrency),
                CryptoCard(
                    iconUrl:
                        'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/e342d99d4648423e9fb5f68785dd2adf.png',
                    crypto: 'XMR',
                    value: isWaiting ? '...' : coinValues['XMR'],
                    selectedCurrency: selectedCurrency),
                CryptoCard(
                    iconUrl:
                        'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/964e1d58e1a2461fa14d399e2dffeae6.png',
                    crypto: 'AVA',
                    value: isWaiting ? '...' : coinValues['AVA'],
                    selectedCurrency: selectedCurrency),
              ],
            ),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            //   children: [
            //     CryptoCard(
            //         iconUrl:
            //             'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/4caf2b16a0174e26a3482cea69c34cba.png',
            //         crypto: 'BTC',
            //         value: isWaiting ? '?' : coinValues['BTC'],
            //         selectedCurrency: selectedCurrency),
            //     CryptoCard(
            //         iconUrl:
            //             'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/604ae4533d9f4ad09a489905cce617c2.png',
            //         crypto: 'ETH',
            //         value: isWaiting ? '?' : coinValues['ETH'],
            //         selectedCurrency: selectedCurrency),
            //     CryptoCard(
            //         iconUrl:
            //             'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/e652b0cdc9b54ad4af4c28a2804c51dc.png',
            //         crypto: 'LTC',
            //         value: isWaiting ? '?' : coinValues['LTC'],
            //         selectedCurrency: selectedCurrency),
            //     CryptoCard(
            //         iconUrl:
            //             'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/2701173b1b7740f286939659359e225c.png',
            //         crypto: 'ADA',
            //         value: isWaiting ? '?' : coinValues['ADA'],
            //         selectedCurrency: selectedCurrency),
            //     CryptoCard(
            //         iconUrl:
            //             'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/b9afd327327a435c80448040e8d4a2eb.png',
            //         crypto: 'DOT',
            //         value: isWaiting ? '?' : coinValues['DOT'],
            //         selectedCurrency: selectedCurrency),
            //     CryptoCard(
            //         iconUrl:
            //             'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/a7587cc1505544ecbc577b56f17d38f9.png',
            //         crypto: 'BCH',
            //         value: isWaiting ? '?' : coinValues['BCH'],
            //         selectedCurrency: selectedCurrency),
            //     // CryptoCard(
            //     //     crypto: 'XLM',
            //     //     value: isWaiting ? '?' : coinValues['XLM'],
            //     //     selectedCurrency: selectedCurrency),
            //     // CryptoCard(
            //     //     crypto: 'DOGE',
            //     //     value: isWaiting ? '?' : coinValues['DOGE'],
            //     //     selectedCurrency: selectedCurrency),
            //     // CryptoCard(
            //     //     crypto: 'BNB',
            //     //     value: isWaiting ? '?' : coinValues['BNB'],
            //     //     selectedCurrency: selectedCurrency),
            //     // CryptoCard(
            //     //     crypto: 'USDT',
            //     //     value: isWaiting ? '?' : coinValues['USDT'],
            //     //     selectedCurrency: selectedCurrency),
            //     // CryptoCard(
            //     //     crypto: 'XMR',
            //     //     value: isWaiting ? '?' : coinValues['XMR'],
            //     //     selectedCurrency: selectedCurrency),
            //   ],
            // ),
          ),
          Container(
            height: 100.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFF1a2947),
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.value,
    @required this.selectedCurrency,
    @required this.crypto,
    @required this.iconUrl,
  }) : super(key: key);

  final String value;
  final String selectedCurrency;
  final String crypto;
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 5.0, 18.0, 0),
      child: Card(
        color: Color(0xFF1a2947),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Image.network(
                      '$iconUrl',
                      height: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '1 $crypto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '$value $selectedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto Condensed',
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
