// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torath/core/commonWidgets/Loader.dart';
import 'package:torath/core/commonWidgets/pageTemplate/page_template.dart';
import 'package:torath/cubits/getMahfalCubit/get_mahfal_cubit.dart';
import 'package:torath/cubits/getMahfalCubit/get_mahfal_state.dart';

class MahfalItemScreen extends StatefulWidget {
  String surahName;

  MahfalItemScreen({super.key, required this.surahName});

  @override
  State<MahfalItemScreen> createState() => _MahfalItemScreenState();
}

class _MahfalItemScreenState extends State<MahfalItemScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetMahfalCubit>().getMahfal(surah: widget.surahName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMahfalCubit, GetMahfalState>(
      builder: (context, state) {
        if (state is GetMahfalSuccessState) {
          return PageTemplate(
            page: Container(),
          );
        } else if (state is GetMahfalLoadingState) {
          return Loader();

        } else if(state is GetMahfalErrorState) {
          return Container(
            child: Center(
              child: Text(state.message),
            ),
          );
        }
        else{
          return Container();
        }
      },
    );
  }
}
