
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/news_bloc.dart';
import '../../../bloc/news_event.dart';
import '../../categories_screen.dart';

enum FilterList { bbcNews, aryNews , independent , reuters, cnn, alJazeera, weather}
FilterList? selectedMenu ;

class HomeAppBarWidget extends StatelessWidget {
  HomeAppBarWidget({super.key});

  String name = 'bbc-news' ;
  // String name1 = 'weather';

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      leading: IconButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoriesScreen()));
        },
        icon: Image.asset('images/category_icon.png' ,
          height: 20,
          width: 20,
        ),
      ),
      title: Text('News' , style: GoogleFonts.poppins(fontSize: 24 , fontWeight: FontWeight.w700),),
      actions: [
        PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
            icon: const Icon(Icons.more_vert , color: Colors.black,),
            onSelected: (FilterList item){

              if(FilterList.bbcNews.name == item.name){
                name = 'bbc-news' ;
              }
              if(FilterList.aryNews.name == item.name){
                name  = 'ary-news';
              }

              if(FilterList.alJazeera.name == item.name){
                name  = 'al-jazeera-english';
              }
              // if(FilterList.weather.name == item.name){
              //   name1 = 'weather';
              // }
              context.read<NewsBloc>().add(FetchNewsChannelHeadlines(name));
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>> [
              const PopupMenuItem<FilterList>(
                value: FilterList.bbcNews ,
                child: Text('BBC News'),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.aryNews ,
                child: Text('Ary News'),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.alJazeera ,
                child: Text('Al-Jazeera News'),
              ),
            ]
        )
      ],
    );
  }

}