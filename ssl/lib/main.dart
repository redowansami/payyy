// import 'package:flutter/material.dart';
// import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
// import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
// import 'package:flutter_sslcommerz/model/SSLCShipmentInfoInitializer.dart';
// import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
// import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
// import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
// import 'package:flutter_sslcommerz/sslcommerz.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SSLCommerzScreen(),
//     );
//   }
// }

// class SSLCommerzScreen extends StatefulWidget {
//   @override
//   _SSLCommerzScreenState createState() => _SSLCommerzScreenState();
// }

// class _SSLCommerzScreenState extends State<SSLCommerzScreen> {
//   // Variable to hold payment status
//   String paymentStatus = '';

//   // Function to start SSLCommerz payment when "Pay Now" is pressed
//   Future<void> _startSSLCommerzTransaction() async {
//     try {
//       // Initialize SSLCommerz SDK
//       Sslcommerz sslcommerz = Sslcommerz(
//         initializer: SSLCommerzInitialization(
//           sdkType: SSLCSdkType.TESTBOX, // Change to LIVE for live transactions
//           store_id: "parkk67bde9fc11501", // Replace with your store id
//           store_passwd: "parkk67bde9fc11501@ssl", // Replace with your store password
//           total_amount: 100, // Replace with the amount
//           tran_id: "1234567890", // Replace with a unique transaction ID
//           currency: SSLCurrencyType.BDT,
//           product_category: "Food",
//           multi_card_name: "visa,master,bkash", // Example of multi-card
//         ),
//       );

//       // Adding Shipment Information
//       sslcommerz.addShipmentInfoInitializer(
//         sslcShipmentInfoInitializer: SSLCShipmentInfoInitializer(
//           shipmentMethod: "yes",
//           numOfItems: 1,
//           shipmentDetails: ShipmentDetails(
//             shipAddress1: "123 Main Street",
//             shipCity: "Dhaka",
//             shipCountry: "Bangladesh",
//             shipName: "John Doe",
//             shipPostCode: "1200",
//           ),
//         ),
//       );

//       // Adding Customer Information
//       sslcommerz.addCustomerInfoInitializer(
//         customerInfoInitializer: SSLCCustomerInfoInitializer(
//           customerName: "John Doe",
//           customerEmail: "johndoe@example.com",
//           customerAddress1: "123 Main Street",
//           customerCity: "Dhaka",
//           customerPostCode: "1200",
//           customerCountry: "Bangladesh",
//           customerPhone: "017XXXXXXXX",
//           customerState: 'D1',
//         ),
//       );

//       // Initiating Payment
//       SSLCTransactionInfoModel result = await sslcommerz.payNow();

//       // Displaying the payment result
//       if (result.status?.toLowerCase() == "success") {
//         setState(() {
//           paymentStatus = 'Success';
//         });
//       } else {
//         setState(() {
//           paymentStatus = 'Failed';
//         });
//       }

//       // Show Payment Status Screen
//       _showPaymentStatusScreen(result);
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }

//   // Function to display payment status screen
//   void _showPaymentStatusScreen(SSLCTransactionInfoModel result) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Payment Status'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text("Transaction Status: ${result.status ?? 'Unknown'}"),
//             SizedBox(height: 20),
//             Text("Amount: ${result.amount ?? 0} BDT"),
//           ],
//         ),
//         actions: <Widget>[
//           ElevatedButton(
//             onPressed: () {
//               // Handle Success
//               Navigator.of(context).pop();
//               setState(() {
//                 paymentStatus = 'Payment Successful';
//               });
//               Fluttertoast.showToast(msg: "Payment Successful");
//             },
//             child: Text('Success'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Handle Failure
//               Navigator.of(context).pop();
//               setState(() {
//                 paymentStatus = 'Payment Failed';
//               });
//               Fluttertoast.showToast(msg: "Payment Failed");
//             },
//             child: Text('Failed'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SSLCommerz Payment'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _startSSLCommerzTransaction,
//               child: Text('Pay Now'),
//             ),
//             SizedBox(height: 20),
//             Text(
//               paymentStatus,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: paymentStatus == 'Payment Successful'
//                     ? Colors.green
//                     : Colors.red,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCShipmentInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SSLCommerzScreen(),
    );
  }
}

class SSLCommerzScreen extends StatefulWidget {
  @override
  _SSLCommerzScreenState createState() => _SSLCommerzScreenState();
}

class _SSLCommerzScreenState extends State<SSLCommerzScreen> {
  

  // Function to start SSLCommerz payment when "Pay Now" is pressed
  Future<void> _startSSLCommerzTransaction() async {
    try {
      // Initialize SSLCommerz SDK
      Sslcommerz sslcommerz = Sslcommerz(
        initializer: SSLCommerzInitialization(
          sdkType: SSLCSdkType.TESTBOX, // Change to LIVE for live transactions
          store_id: "parkk67bde9fc11501", // Replace with your store id
          store_passwd: "parkk67bde9fc11501@ssl", // Replace with your store password
          total_amount: 100, // Replace with the amount
          tran_id: "1234567890", // Replace with a unique transaction ID
          currency: SSLCurrencyType.BDT,
          product_category: "Food",
          multi_card_name: "visa,master,bkash", // Example of multi-card
        ),
      );

      // Adding Shipment Information
      sslcommerz.addShipmentInfoInitializer(
        sslcShipmentInfoInitializer: SSLCShipmentInfoInitializer(
          shipmentMethod: "yes",
          numOfItems: 1,
          shipmentDetails: ShipmentDetails(
            shipAddress1: "123 Main Street",
            shipCity: "Dhaka",
            shipCountry: "Bangladesh",
            shipName: "John Doe",
            shipPostCode: "1200",
          ),
        ),
      );

      // Adding Customer Information
      sslcommerz.addCustomerInfoInitializer(
        customerInfoInitializer: SSLCCustomerInfoInitializer(
          customerName: "John Doe",
          customerEmail: "johndoe@example.com",
          customerAddress1: "123 Main Street",
          customerCity: "Dhaka",
          customerPostCode: "1200",
          customerCountry: "Bangladesh",
          customerPhone: "017XXXXXXXX", 
          customerState: 'D1',
        ),
      );

      // Initiating Payment
      SSLCTransactionInfoModel result = await sslcommerz.payNow();

      // Displaying the payment result
      _displayPaymentStatus(result);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  // Function to display payment status
  void _displayPaymentStatus(SSLCTransactionInfoModel result) {
    String message;
    Color bgColor;

    switch (result.status?.toLowerCase()) {
      case "failed":
        message = "Transaction Failed";
        bgColor = Colors.red;
        break;
      case "closed":
        message = "SDK Closed by User";
        bgColor = Colors.orange;
        break;
      default:
        message = "Transaction ${result.status} - Amount: ${result.amount ?? 0}";
        bgColor = Colors.green;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: bgColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SSLCommerz Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _startSSLCommerzTransaction,
          child: Text('Pay Now'),
        ),
      ),
    );
  }
}
