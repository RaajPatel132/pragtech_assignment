import 'package:flutter/material.dart';
import 'package:pragtech_assignment/provider/users_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDataProvider>(context, listen: true).loadAllData();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Users'),
            Text(Provider.of<UserDataProvider>(context, listen: true)
                .likedUsers
                .length
                .toString()),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: Provider.of<UserDataProvider>(context, listen: true)
            .usersList
            .length,
        itemBuilder: (BuildContext context, int index) {
          // return Text(Provider.of<UserDataProvider>(context, listen: true).usersList[index].id.toString());
          return ListTile(
            title: Text(Provider.of<UserDataProvider>(context, listen: true)
                .usersList[index]
                .name!),
            subtitle: Text(
                '${Provider.of<UserDataProvider>(context, listen: true).usersList[index].email!} | ${Provider.of<UserDataProvider>(context, listen: true).usersList[index].phone!}'),
            trailing: Switch(
              onChanged: (newV) {
                var id = Provider.of<UserDataProvider>(context, listen: false)
                    .usersList[index]
                    .id;
                if(newV) {
                  Provider.of<UserDataProvider>(context, listen: false)
                    .likeUser(id!);
                } else {
                  Provider.of<UserDataProvider>(context, listen: false)
                      .unlikeUser(id!);
                }
              },
              value: Provider.of<UserDataProvider>(context, listen: true)
                      .usersList[index]
                      .isLiked ??
                  false,
            ),
          );
        },
      ),
    );
  }
}
