
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:refermate/Login.dart';

class Signup extends StatefulWidget {
  @override
  const Signup({super.key});
  State<Signup> createState() => _SignupState();
}
@override
class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'assets/user.jpg',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Signup",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                ),),

                // Email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                // Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                // Referral Code
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    controller: _referralController,
                    decoration: const InputDecoration(
                      hintText: "Enter Your Referral Code (Optional)",
                      prefixIcon: Icon(Icons.card_giftcard),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Signup Button
                ElevatedButton(
                  onPressed: () async {
                    String name = _nameController.text.trim();
                    String mail = _emailController.text.trim();
                    String mobile = _mobileController.text.trim();
                    String pass = _passwordController.text.trim();
                    String referal = _referralController.text.trim();

                    if (name.isEmpty || mail.isEmpty || pass.isEmpty || mobile.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter all the fields")),
                      );
                      return;
                    }

                    try {
                      UserCredential userCred = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: mail,
                        password: pass,
                      );
                      User? user = userCred.user;

                      if (user != null) {
                        final String uid = user.uid;
                        print("UserId: $uid, Email: ${user.email}");

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .set({
                          'username': name,
                          'email': mail,
                          'referralCode': referal,
                          'mobile':mobile
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Signup Successful")),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      }
                    } catch (e) {
                      print("Error: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Signup Failed: $e")),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.blue),
                  ),
                  child: const Text("Signup"),
                ),

                const SizedBox(height: 15),

                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text("Already Signed Up? Log In"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
