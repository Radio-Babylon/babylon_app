import 'package:babylon_app/models/partner.dart';
import 'package:babylon_app/services/partner/partnerService.dart';
import 'package:babylon_app/views/navigation_menu.dart';
import 'package:flutter/material.dart';

class PartnersScreen extends StatelessWidget {
  const PartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FutureBuilderPartners(),
    );
  }
}

class FutureBuilderPartners extends StatefulWidget {
  const FutureBuilderPartners({super.key});

  @override
  State<FutureBuilderPartners> createState() => _FutureBuilderPartnersState();
}

class _FutureBuilderPartnersState extends State<FutureBuilderPartners> {
  final Future<List<Partner>> _partners = PartnerService.getPartners();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // Your drawer widget
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
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.displayMedium!,
        textAlign: TextAlign.center,
        child: FutureBuilder<List<Partner>>(
          future: _partners, // a previously-obtained Future<String> or null
          builder:
              (BuildContext context, AsyncSnapshot<List<Partner>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              print(1);
              print(snapshot.data);
              children = <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text("OUR PARTNERS",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  ...snapshot.data!.map((aPartner) =>  
                    Card(
                      child: ListTile(
                        leading: Image.network(aPartner.PictureURL!),
                        title: Text(aPartner.Name!),
                        subtitle: Text('What you can get: ${aPartner.Discount}'),
                        trailing: Icon(Icons.view_list),
                        onTap: () => 
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(aPartner.Name!),
                                content: Text('You can get ${aPartner.Discount} at ${aPartner.Location}'),
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
                          )
                      ),
                  ))
              ];
            } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ];
              } else {
                children = <Widget>[
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(
                              color: Color(0xFF006400)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Loading...'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 128),
                        child: Image.asset('assets/images/logoSquare.png',
                            height: 185, width: 185),
                      ),
                    ],
                  )
                ];
              }
            return ListView(
              children: children,
            );
          },
        ),
      )
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
          title: Text(partner.Name!),
          content: Text('You can get ${partner.Discount} at ${partner.Location}'),
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
        title: Text(partner.Name!),
        subtitle: Text('What you can get: ${partner.Discount}'),
        trailing: Icon(Icons.view_list),
        onTap: () => _showDetails(context),
      ),
    );
  }
}
