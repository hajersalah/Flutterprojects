import 'package:flutter/material.dart';
import 'package:movies_app/providers/users_provider.dart';
import 'package:movies_app/screens/authentication_screen.dart';
import 'package:movies_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            Container(
              color: Theme.of(context).accentColor,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'welcome',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Provider.of<UsersProvider>(context).currentUser.email,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
            //Card(
            //child:
            ListTile(
              onTap: () {
                if (ModalRoute.of(context).settings.name ==
                    HomeScreen.routeName) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                }
              },
              title: Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  //Theme.of(context).primaryColor.withOpacity(5),
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Icons.home),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                'Favorites',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Icons.favorite),
            ),
            ListTile(
              onTap: () {
                // how to log out ::
                Provider.of<UsersProvider>(context, listen: false)
                    .removeUserData();
                Navigator.of(context)
                    .pushReplacementNamed(AuthenticationScreen.routeName);
              },
              title: Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
    );
  }
}
