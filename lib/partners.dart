import 'package:babylon_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'events-info.dart'; // Assuming you have this file for navigating to events info

class PartnersScreen extends StatelessWidget {
  // Example list of partners
  final List<Partner> partners = [
    Partner(name: 'BUSINESS NAME', location: 'location of the business', discount: 'discount, deals'),
    Partner(name: 'BUSINESS NAME', location: 'location of the business', discount: 'discount, deals'),
    Partner(name: 'BUSINESS NAME', location: 'location of the business', discount: 'discount, deals'),
    Partner(name: 'BUSINESS NAME', location: 'location of the business', discount: 'discount, deals'),
    Partner(name: 'BUSINESS NAME', location: 'location of the business', discount: 'discount, deals'),
    Partner(name: 'BUSINESS NAME', location: 'location of the business', discount: 'discount, deals'),
    Partner(name: 'BUSINESS NAME', location: 'location of the business', discount: 'discount, deals'),
    Partner(name: 'BUSINESS NAME', location: 'location of the business', discount: 'discount, deals'),
    Partner(name: 'BUSINESS NAME', location: 'location of the business', discount: 'discount, deals'),
    Partner(name: 'BUSINESS NAME', location: 'location of the business', discount: 'discount, deals'),
    Partner(name: 'BUSINESS NAME', location: 'location of the business', discount: 'discount, deals'),
    Partner(name: 'BUSINESS NAME', location: 'location of the business', discount: 'discount, deals'),
    // Add more partners here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const PublicDrawer(), // Your drawer widget
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Partners'),
            SizedBox(
              height: 55,
              width: 55,
              child: Image.asset('assets/images/logowhite.png'), // Your logo asset
            ),
          ],
        ),
        backgroundColor: Colors.green, // Adjust the color as needed
      ),
      body: ListView.builder(
        itemCount: partners.length,
        itemBuilder: (context, index) {
          return PartnerTile(partner: partners[index]);
        },
      ),
    );
  }
}

class PartnerTile extends StatelessWidget {
  final Partner partner;

  PartnerTile({required this.partner});

  // Function to show details in a pop-up
  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(partner.name),
          content: Text('You can get ${partner.discount} at ${partner.location}'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(size: 56.0), // Replace with actual logo
        title: Text(partner.name),
        subtitle: Text('What you can get: ${partner.discount}'),
        trailing: Icon(Icons.view_list),
        onTap: () => _showDetails(context),
      ),
    );
  }
}

// Partner data structure
class Partner {
  final String name;
  final String location;
  final String discount;

  Partner({required this.name, required this.location, required this.discount});
}
