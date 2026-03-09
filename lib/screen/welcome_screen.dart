import 'package:flutter/material.dart';
import 'package:medical_health_app/screen/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>))
                },
                child: Text("Skip", style: TextStyle(fontSize: 16, color: Color(0xFF7165D6))),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/images/doctors.png"),
            ),
            SizedBox(height: 40),
            Text(
              "Doctors Appointment",
              style: TextStyle(
                color: Color(0xFF7165D6),
                fontSize: 35,
                fontWeight: FontWeight.bold,
                wordSpacing: 2,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Appoint Your Doctors",
              style: TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color: Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
