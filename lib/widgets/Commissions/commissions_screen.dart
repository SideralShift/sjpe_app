import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommissionCard extends StatelessWidget {
  final String commissionName;
  final String imagePath;

  CommissionCard({Key? key, required this.commissionName, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Rounded borders
      ),
      child: Container(
        height: 150, // Fixed height of 300px
        child: Center(child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15.0), // Rounded corners for the image
            child: Image.asset(imagePath, fit: BoxFit.cover, width: 80,), // Replace with the actual image
          ),
          title: Text(
            commissionName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),),
      ),
    ), onTap: () => {},);
  }
}

class CommissionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppStyles.mainBackgroundColor,
          foregroundColor: Colors.black,
          title: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text('Comisiones',
                style: GoogleFonts.openSans(
                    color:
                        Colors.black, // Change this color to your desired color
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          )),
      body: ListView(
      children: <Widget>[
        CommissionCard(commissionName: 'PRO-ANIVERSARIO', imagePath: 'lib/assets/commission_images/proaniversario.png'),
        CommissionCard(commissionName: 'AUXILIOS', imagePath: 'lib/assets/commission_images/auxilios.png'),
        CommissionCard(commissionName: 'DONATIVOS', imagePath: 'lib/assets/commission_images/donativos.png'),
        CommissionCard(commissionName: 'EVANGELISMO', imagePath: 'lib/assets/commission_images/evangelismo.png'),
        CommissionCard(commissionName: 'VIGILANCIA', imagePath: 'lib/assets/commission_images/vigilancia.png'),
      ],
    ));
  }
}
