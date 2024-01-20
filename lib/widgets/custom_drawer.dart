import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../screens/settings_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
//logout method
  void logout() {
    //get authservice
    final auth = AuthService();
    auth.signOut();
    print("signout");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.15;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: EdgeInsets.only(left: 25.0, bottom: height * 0.30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //logo
              Column(
                children: [
                  DrawerHeader(
                    ///  decoration: BoxDecoration(color: Colors.red),
                    margin: EdgeInsets.only(
                      top: height * 0.15,
                    ),
                    child: const Text("C H A T"),
                  ),
                  //home settings tile
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("H O M E"),
                    onTap: () => Navigator.of(context).pop(),
                  ),

                  //settings tile=theme
                  ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text("S E T T I N G S"),
                      onTap: () {
                        //pop the drawer
                        Navigator.of(context).pop();
                        //navigate to settings screen
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SettingsScreen()));
                      }),
                ],
              ),
              //logout tile
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("L O G O U T"),
                onTap: logout,
              ),
            ]),
      ),
    );
  }
}
