import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/get_api_bloc.dart';
import '../bloc/get_api_event.dart';
import '../bloc/get_api_state.dart';
import '../utils/enums.dart' show GetApiStatus;

class GetApiScreen extends StatefulWidget {
  const GetApiScreen({super.key});

  @override
  State<GetApiScreen> createState() => _GetApiScreenState();
}

class _GetApiScreenState extends State<GetApiScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetApiBloc>().add(GetApiFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Get Api')),
      body: BlocBuilder<GetApiBloc, GetApiStates>(
        builder: (context, state) {
          switch (state.getApiStatus) {
            case GetApiStatus.loading:
              return CircularProgressIndicator();
            case GetApiStatus.failure:
              return Center(child: Text(state.message.toString()));
            case GetApiStatus.success:
              return Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search with email',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (filterKey) {
                      context.read<GetApiBloc>().add(SearchItem(filterKey));
                    },
                  ),

                  Expanded(
                    child:
                        state.searchMessage.isNotEmpty
                            ? Center(
                              child: Text(state.searchMessage.toString()),
                            )
                            : ListView.builder(
                              itemCount:
                                  state.temgetList.isEmpty
                                      ? state.getList.length
                                      : state.temgetList.length,
                              itemBuilder: (context, index) {
                                if (state.temgetList.isNotEmpty) {
                                  final item = state.temgetList[index];
                                  return ListTile(
                                    title: Text(item.email.toString()),
                                    subtitle: Text(item.body.toString()),
                                  );
                                } else {
                                  final item = state.getList[index];
                                  return ListTile(
                                    title: Text(item.email.toString()),
                                    subtitle: Text(item.body.toString()),
                                  );
                                }
                              },
                            ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
