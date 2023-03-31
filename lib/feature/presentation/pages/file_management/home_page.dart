
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropboxclone/core/utils/loading/loading_screen.dart';
import 'package:dropboxclone/feature/bloc/file_management/local/local_cubit.dart';
import 'package:dropboxclone/feature/bloc/file_management/local/local_state.dart';
import 'package:dropboxclone/feature/bloc/file_management/remote/remote_cubit.dart';
import 'package:dropboxclone/feature/presentation/widgets/file_management/filelisttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
class HomePage extends StatefulWidget {
  final String userId;
  const HomePage({Key? key,required this.userId}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool internetAvailable;
  late Stream<ConnectivityResult> subscription;
  @override
  void initState() {
    super.initState();
   subscription=Connectivity().onConnectivityChanged..listen((event) async{
     internetAvailable= await InternetConnectionChecker().hasConnection;
   });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteCubit>(
      create: (_)=>RemoteCubit(),
      child: Scaffold(
          appBar:AppBar(
            title: const Text("DropBox Clone"),
          ),
          body: BlocConsumer<LocalCubit,LocalState>(
            builder: (context,state) {
              if(state is LocalStateInitialState){
                return const Center(child: Text("No Files Uploaded Till Now!"),);
              }
              if(state is LocalStateGetFiles){
                if(state.files.isEmpty){
                  return const Center(child: Text("No Files Uploaded Till Now!"),);
                }
                return ListView.builder(itemBuilder: (context,index){
                  return StreamBuilder(
                    stream: subscription,
                    builder: (context,snapshot) {
                      return FileListTile(userId:widget.userId,hasInternet:internetAvailable,file: state.files[index]);
                    }
                  );
                },
                itemCount: state.files.length,);
              }
              return Container();
            },
            listener: (context,state){
              if(state.isLoading){
                LoadingScreen.instance().show(context: context, text: "Adding Your File");
              }
              else{
                LoadingScreen.instance().hide();
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<LocalCubit>().addFile();
            },
            child: const Icon(Icons.add),
          ),
        ),
    );
  }
}