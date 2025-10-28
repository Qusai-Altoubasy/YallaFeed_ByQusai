import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/cubits/user/user_cubit.dart';
import 'package:qusai/cubits/user/user_states.dart';

class user_layout extends StatelessWidget {
  const user_layout({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
        create: (BuildContext context)=>user_cubit(),
       child: BlocConsumer<user_cubit, user_states>(
         listener: (context, state){},
         builder: (context, state){
          var cubit = user_cubit.get(context);
          return Scaffold(
            drawer: NavigationDrawer(
                children:[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person, size: 30,),
                          title: const Text('Profile'),
                          onTap: (){},
                        ),
                        Container(
                          color: Colors.grey,
                          height: 1,
                          width: double.infinity,
                        ),
                        ListTile(
                          leading: const Icon(Icons.notifications, size: 30,),
                          title: const Text('Announcement'),
                          onTap: (){},
                        ),
                        Container(
                          color: Colors.grey,
                          height: 2,
                          width: double.infinity,
                        ),
                        ListTile(
                          leading: const Icon(Icons.support_agent, size: 30,),
                          title: const Text('Feedback'),
                          onTap: (){},
                        ),
                        Container(
                          color: Colors.grey,
                          height: 2,
                          width: double.infinity,
                        ),
                        ListTile(
                          leading: const Icon(Icons.group, size: 30,),
                          title: const Text('Contact us'),
                          onTap: (){},
                        ),
                        Container(
                          color: Colors.grey,
                          height: 2,
                          width: double.infinity,
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout, size: 30,),
                          title: const Text('Log out'),
                          onTap: (){},
                        ),

                      ],
                    ),
                  ),
                ]
            ),
            appBar: AppBar(
              title: Text(
                '${cubit.titles[cubit.current_index]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.user_nav_bar,
              currentIndex: cubit.current_index,
              onTap: (index){
                cubit.change_bottom_nav_bar(index);
              },
            ),
            body: cubit.screens[cubit.current_index],
          );
         },

       ),
     );
  }
}
