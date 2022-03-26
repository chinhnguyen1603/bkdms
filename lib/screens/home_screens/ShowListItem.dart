import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/screens/home_screens/DetailItem.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'package:bkdms/models/Item.dart';

class ShowListItem extends StatefulWidget {
  const ShowListItem({ Key? key }) : super(key: key);

  @override
  State<ShowListItem> createState() => ShowListItemState();
}



class ShowListItemState extends State<ShowListItem> {
  static const darkGrey = Color(0xff544C4C); 
  FloatingSearchBarController? searchController;
  List<Item> searchList = [];
  bool _isSearching = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    List<Item> lstItem = Provider.of<ItemProvider>(context).lstItem;
    print(lstItem);
    _isSearching = false;
     //mặc định searchList phải bằng lstItem để auto hiện khi xóa search
    searchList = lstItem;
  } 




  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: darkGrey,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: (){
            
            }, 
            icon: Icon(
              Icons.shopping_cart,
              size: 24,
              color: darkGrey,
            )
          )
        ], 
        centerTitle: true,
        title: Text(
            "Sản phẩm",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: darkGrey,),
        )
      ),
      backgroundColor: Color(0xfff0ecec),
      body: Consumer<ItemProvider>( builder: (ctxItemProvider, itemProvider, child) {  
        return SingleChildScrollView(

         child: Center(
          child: Column(
          children: [
            SizedBox(height: 20,),

            // SizedBox Search
            SizedBox(
              height: 100,
              child: Center(
                child: FloatingSearchBar(
                    controller: searchController,
                    hint: 'Tìm kiếm',
                    width: widthDevice*0.8,
                    height: 40,
                    backdropColor: Color(0xfff0ecec),
                    borderRadius: BorderRadius.circular(20),
                    onQueryChanged: (query) {
                       // Call your model, bloc, controller here.
                      setState(() {
                         searchList = itemProvider.lstItem
                                  .where((element) =>
                                     element.name.toLowerCase().contains(query.toLowerCase()) ||
                                     element.retailPrice.toLowerCase().contains(query.toLowerCase()))
                                  .toList();                
                         _isSearching = true;
                      });
                      print(searchList);
                    },
                      // Specify a custom transition to be used for
                      // animating between opened and closed stated.
                    builder: (context, transition) { 
                       return Container(
                       );
                    },
                )
              ),
            ),
            
            //GridView Item
            SizedBox(
              height: 1500,
              width: widthDevice*0.98,
              child: _isSearching
              // Mặc định là false nên trả về dấu 2 chấm trước dấu hỏi. Đang search thì trả về dấu hỏi
              //Grid View của dấu hỏi là của searchList
              ?  GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1/1.2,
                ),
                padding: EdgeInsets.all(8),
                primary: false,
                itemCount: searchList.length,
                itemBuilder: (BuildContext context, int index) {
                    return  Container(
                            color: Colors.white,
                            child: Column(
                                children: [
                                    GestureDetector(
                                        onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem()));
                                       },
                                        child: Image.network(
                                            getUrlFromLinkImg("${searchList[index].linkImg}"),
                                            width: widthDevice*0.38,                     
                                       ),
                                    ),

                                    //Tên sản phẩm
                                    GestureDetector(
                                        onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem()));
                                        },
                                        child: SizedBox(
                                            height: 32 ,
                                            width: widthDevice*0.4,
                                            child: Text(
                                               "${searchList[index].name}",
                                               maxLines: 2, 
                                               overflow: TextOverflow.ellipsis,
                                               softWrap: false,
                                               style: TextStyle(fontSize: 12),
                                        )
                                    ),),
                                    // Price Agency
                                    SizedBox(
                                        height: 25,
                                        width: widthDevice*0.4,
                                        child: Text(
                                          "${searchList[index].retailPrice}" + 'đ̳',
                                          style: TextStyle(fontSize:16, color: Color(0xffb01313))
                                        ) 
                                    ),
                                ]
                            )
                        );
                },
        
               
              )          

              //Không search thì trả về nguyên mẫu. Gridview của lstItem
              : GridView.builder(
                
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1/1.2,
                ),
                padding: EdgeInsets.all(8),
                primary: false,
                itemCount: itemProvider.lstItem.length,
                itemBuilder: (BuildContext context, int index) {
                    return  Container(
                            color: Colors.white,
                            child: Column(
                                children: [
                                    // Ảnh sản phẩm
                                    GestureDetector(
                                        onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem()));
                                       },
                                        child: Image.network(
                                            getUrlFromLinkImg("${itemProvider.lstItem[index].linkImg}"),
                                            width: widthDevice*0.38,                     
                                       ),
                                    ),
                                    //Tên sản phẩm
                                    GestureDetector(
                                        onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem()));
                                        },
                                        child: SizedBox(
                                            height: 32 ,
                                            width: widthDevice*0.4,
                                            child: Text(
                                               "${itemProvider.lstItem[index].name}",
                                               maxLines: 2, 
                                               overflow: TextOverflow.ellipsis,
                                               softWrap: false,
                                               style: TextStyle(fontSize: 12),
                                        )
                                    ),),
                                    // Price Agency
                                    SizedBox(
                                        height: 25,
                                        width: widthDevice*0.4,
                                        child: Text(
                                          "${itemProvider.lstItem[index].retailPrice}" + 'đ',
                                          style: TextStyle(fontSize:16, color: Color(0xffb01313))
                                        ) 
                                    ),
                                ]
                            )
                        );
                },
        
               
              )
              )                 
          ]
        ))
        
        );
      })
    );
  }




    String getUrlFromLinkImg(String linkImg) {
        final cloudinary = Cloudinary("975745475279556", "S9YIG_sABPRTmZKb0mGNTiJsAkg", "di6dsngnr");
        //linkImg receive from server as Public Id
        final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", linkImg);
        String transformedUrl = cloudinaryImage.transform().width(256).thumb().generate()!;
        return transformedUrl;
    }  
}