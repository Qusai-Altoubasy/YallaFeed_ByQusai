import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qusai/classes/user.dart';
import 'package:qusai/cubits/user/user_cubit.dart';
import 'package:qusai/cubits/user/user_states.dart';
import 'package:qusai/screens/user/deleviry/deleviry_main_screen.dart';
import 'package:qusai/screens/user/donor/donor_main_screen.dart';
import 'package:qusai/screens/user/receiver/receiver_main_screen.dart';
import 'package:qusai/shared/shared.dart';

class user_layout extends StatelessWidget {
  final String uid;

  const user_layout({super.key, required this.uid});
  @override
  Widget build(BuildContext context) {
     return BlocProvider(
       create: (context) {
       var cubit = user_cubit();
       cubit.getuser(uid);
       return cubit;
     },
       child: BlocConsumer<user_cubit, user_states>(
         listener: (context, state){},
         builder: (context, state){
           if(state is loading){
             return Center(child: CircularProgressIndicator());
           }
           var cubit = user_cubit.get(context);
           user? current_user = cubit.User;
          return Scaffold(
            drawer: menu(context,
                cubit.current_index==1?Color(0xFFAB47BC):
                cubit.current_index==0?Color(0xFF9BE7FF):Color(0xFF388E3C)),

            appBar: AppBar(
              elevation: 1,
              backgroundColor: cubit.current_index==1?Color(0xFFAB47BC):
              cubit.current_index==0?Color(0xFF9BE7FF):Color(0xFF388E3C),
              title: Text(
                cubit.titles[cubit.current_index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            bottomNavigationBar: ConvexAppBar(
              items: [
                TabItem(
                icon: Icon(Icons.volunteer_activism),
                title: 'Donate',
              ),
                TabItem(
                  icon: Icon(Icons.handshake),
                  title: 'Receive',
                ),
                TabItem(
                  icon: Icon(Icons.drive_eta),
                  title: 'deliver',
                ),
              ],
              initialActiveIndex: cubit.current_index,
              onTap: (int index){
                cubit.change_bottom_nav_bar(index);
              },
              style: TabStyle.titled,
              backgroundColor: cubit.current_index==1?Color(0xFFAB47BC):
              cubit.current_index==0?Color(0xFF6FB1FC):Color(0xFF43A047),
              elevation: 10,
            ),
            body: cubit.current_index==0?donor_main_screen(User: current_user,)
                :cubit.current_index==2?deleviry_main_screen(User: current_user,)
                :current_user!.havepermission?receiver_main_screen(User: current_user,)
                : Scaffold(
                  extendBodyBehindAppBar: true,
                  backgroundColor: Color(0xFFAB47BC),
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You do not have permission for receive meals,\n"
                                "if you want to,\nplease send a request by priss the button below.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFE1BEE7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: double.infinity,
                            height: 50,
                            child: MaterialButton(
                              onPressed: ()async{
                                if(current_user.askpermission){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text(
                                        'You already submitted a request. ')),
                                  );
                                }
                                else {
                                  await cubit.sendrequest(current_user.databaseID,current_user.name);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text(
                                        'You have submitted a request. ')),
                                  );
                                }
                              },
                              child: Text(
                                'Send request',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                );
               },


       ),
     );
  }
}
