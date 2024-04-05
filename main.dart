import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trading App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WatchlistScreen(),
    );
  }
}

class WatchlistScreen extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late final IOWebSocketChannel channel;

  final Map<int, Map<String, dynamic>> stocksData = {
    7: {
      "symbol": "AARTIIND",
      "company": "AARTI INDUSTRIES LTD",
      "industry": "Specialty Chemicals",
      "sectoralIndex": "NIFTY 500"
    },
    13: {
      "symbol": "ABB",
      "company": "ABB INDIA LIMITED",
      "industry": "Heavy Electrical Equipment",
      "sectoralIndex": "NIFTY INFRASTRUCTURE"
    },
    22: {
      "symbol": "ACC",
      "company": "ACC LIMITED",
      "industry": "Cement & Cement Products",
      "sectoralIndex": "NIFTY COMMODITIES"
    },
    25: {
      "symbol": "ADANIENT",
      "company": "ADANI ENTERPRISES LIMITED",
      "industry": "Trading - Minerals",
      "sectoralIndex": "NIFTY 500"
    },
    157: {
      "symbol": "APOLLOHOSP",
      "company": "APOLLO HOSPITALS ENTER. L",
      "industry": "Hospital",
      "sectoralIndex": "NIFTY PHARMA"
    },
    212: {
      "symbol": "ASHOKLEY",
      "company": "ASHOK LEYLAND LTD",
      "industry": "Commercial Vehicles",
      "sectoralIndex": "NIFTY 500"
    },
    383: {
      "symbol": "BEL",
      "company": "BHARAT ELECTRONICS LTD",
      "industry": "Aerospace & Defense",
      "sectoralIndex": "NIFTY 500"
    },
    6705: {
      "symbol": "PAYTM",
      "company": "ONE 97 COMMUNICATIONS LTD",
      "industry": "Financial Technology (Fintech)",
      "sectoralIndex": ""
    },
    6545: {
      "symbol": "NYKAA",
      "company": "FSN E COMMERCE VENTURES",
      "industry": "E-Retail/ E-Commerce",
      "sectoralIndex": ""
    },
    317: {
      "symbol": "BAJFINANCE",
      "company": "BAJAJ FINANCE LIMITED",
      "industry": "Non Banking Financial Company (NBFC)",
      "sectoralIndex": "NIFTY FINANCIAL SERVICES"
    },
    480: {
      "symbol": "BIRLACORPN",
      "company": "BIRLA CORPORATION LTD",
      "industry": "Cement & Cement Products",
      "sectoralIndex": "NIFTY COMMODITIES"
    },
    694: {
      "symbol": "CIPLA",
      "company": "CIPLA LTD",
      "industry": "Pharmaceuticals",
      "sectoralIndex": "NIFTY PHARMA"
    },
    772: {
      "symbol": "DABUR",
      "company": "DABUR INDIA LTD",
      "industry": "Personal Care",
      "sectoralIndex": "NIFTY FMCG"
    },
    1333: {
      "symbol": "HDFCBANK",
      "company": "HDFC BANK LTD",
      "industry": "Private Sector Bank",
      "sectoralIndex": "NIFTY BANK"
    },
    1476: {
      "symbol": "IDBI",
      "company": "IDBI BANK LIMITED",
      "industry": "Private Sector Bank",
      "sectoralIndex": "NIFTY BANK"
    },
    2475: {
      "symbol": "ONGC",
      "company": "OIL AND NATURAL GAS CORP.",
      "industry": "Oil Exploration & Production",
      "sectoralIndex": "NIFTY 500"
    },
    2868: {
      "symbol": "HITECH",
      "company": "HI-TECH PIPES LIMITED",
      "industry": "Iron & Steel Products",
      "sectoralIndex": "NIFTY METAL"
    },
    2955: {
      "symbol": "KALYANKJIL",
      "company": "KALYAN JEWELLERS IND LTD",
      "industry": "Gems Jewellery And Watches",
      "sectoralIndex": ""
    },
    2963: {
      "symbol": "SAIL",
      "company": "STEEL AUTHORITY OF INDIA",
      "industry": "Iron & Steel",
      "sectoralIndex": "NIFTY METAL"
    },
    3024: {
      "symbol": "JINDALSAW",
      "company": "JINDAL SAW LIMITED",
      "industry": "Iron & Steel Products",
      "sectoralIndex": "NIFTY METAL"
    },
    3045: {
      "symbol": "SBIN",
      "company": "STATE BANK OF INDIA",
      "industry": "Public Sector Bank",
      "sectoralIndex": "NIFTY BANK"
    },
    3150: {
      "symbol": "SIEMENS",
      "company": "SIEMENS LTD",
      "industry": "Heavy Electrical Equipment",
      "sectoralIndex": "NIFTY 500"
    },
    3389: {
      "symbol": "AGARIND",
      "company": "AGARWAL INDS CORP LTD.",
      "industry": "Petrochemicals",
      "sectoralIndex": "NIFTY INFRASTRUCTURE"
    },
    3405: {
      "symbol": "TATACHEM",
      "company": "TATA CHEMICALS LTD",
      "industry": "Commodity Chemicals",
      "sectoralIndex": "NIFTY 500"
    },
    3426: {
      "symbol": "TATAPOWER",
      "company": "TATA POWER CO LTD",
      "industry": "Integrated Power Utilities",
      "sectoralIndex": "NIFTY INFRASTRUCTURE"
    },
    3506: {
      "symbol": "TITAN",
      "company": "TITAN COMPANY LIMITED",
      "industry": "Gems Jewellery And Watches",
      "sectoralIndex": "NIFTY 500"
    },
    3626: {
      "symbol": "HEALTHIETF",
      "company": "ICICIPRAMC - ICICIPHARM",
      "industry": "Mutual Fund Scheme",
      "sectoralIndex": "NA"
    },
    3787: {
      "symbol": "WIPRO",
      "company": "WIPRO LTD",
      "industry": "Computers - Software & Consulting",
      "sectoralIndex": "NIFTY IT"
    },
    4391: {
      "symbol": "GULFOILLUB",
      "company": "GULF OIL LUB. IND. LTD.",
      "industry": "Lubricants",
      "sectoralIndex": "NIFTY 500"
    },
    5258: {
      "symbol": "INDUSINDBK",
      "company": "INDUSIND BANK LIMITED",
      "industry": "Private Sector Bank",
      "sectoralIndex": "NIFTY BANK"
    },
    5279: {
      "symbol": "ROLEXRINGS",
      "company": "ROLEX RINGS LIMITED",
      "industry": "Auto Components & Equipments",
      "sectoralIndex": ""
    }
  };


  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(
      'ws://122.179.143.201:8089/websocket?sessionID=Rohit&userID=Rohit&apiToken=Rohit',
    );
    _subscribeToStocks();
    channel.stream.listen(_receiveData);
  }

  void _subscribeToStocks() {
    final tokens = stocksData.keys.toList();
    channel.sink.add(
      jsonEncode({"Task": "subscribe", "Mode": "ltp", "Tokens": tokens}),
    );
  }

  void _unsubscribeFromStocks(List<int> tokensToUnsubscribe) {
    channel.sink.add(
      jsonEncode({"Task": "unsubscribe", "Mode": "ltp", "Tokens": tokensToUnsubscribe}),
    );
  }

  void _receiveData(dynamic data) {
    Map<String, dynamic> decodedData = jsonDecode(data);
    int token = decodedData['Token'];
    double ltp = decodedData['LTP'];
    setState(() {
      if (stocksData.containsKey(token)) {
        stocksData[token]!['ltp'] = ltp;
      }
    });
  }

  void _deleteStock(int token) {
    _unsubscribeFromStocks([token]);
    setState(() {
      stocksData.remove(token);
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: ListView.builder(
        itemCount: stocksData.length,
        itemBuilder: (context, index) {
          final int token = stocksData.keys.elementAt(index);
          final Map<String, dynamic> stock = stocksData[token]!;
          return Dismissible(
            key: Key(token.toString()),
            onDismissed: (direction) => _deleteStock(token),
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
              alignment: Alignment.centerRight,
            ),
            child: ListTile(
              title: Text(stock['symbol']),
              subtitle: Text('LTP: ${stock['ltp'] ?? "N/A"}'),
            ),
          );
        },
      ),
    );
  }
}
