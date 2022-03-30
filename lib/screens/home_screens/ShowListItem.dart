import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:bkdms/screens/home_screens/DetailItem.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'package:bkdms/models/Item.dart';
import 'package:bkdms/models/CountBadge.dart';

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
  void initState() {
    super.initState();
    _isSearching = false;
     //mặc định searchList phải bằng lstItem để auto hiện khi xóa search
  } 



  @override
  Widget build(BuildContext context) {
    int counter = Provider.of<CountBadge>(context).counter;// khởi tạo counter là số mặt hàng trong cart = 0
    double heigtDevice = MediaQuery.of(context).size.height;// chiều cao thiết bị
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double widthContainerItem = widthDevice*0.4;
    
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
          Badge(
             position: BadgePosition.topEnd(top: 0, end: 3),
             animationDuration: Duration(milliseconds: 300),
             animationType: BadgeAnimationType.slide,
             badgeContent: Text(
                counter.toString(),
                style: TextStyle(color: Colors.white),
             ),
             child: IconButton(
               icon: Icon(Icons.shopping_cart, color: darkGrey,), 
               onPressed: () {

               }
             ),
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
                    //thêm dấu chấm vào giá sản phẩm
                    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
                    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
                    //Xử lý đơn vị và chuyển đơn vị
                    var baseUnit;
                    List<dynamic> switchUnit = [];
                    for(var unit in itemProvider.lstItem[index].units){
                        if(unit['isBaseUnit'] == true) {
                          baseUnit = unit;
                        } else {
                          switchUnit.add(unit);
                        }
                    }                  
                    return  Container(
                            color: Colors.white,
                            child: Column(
                                children: [
                                    // ảnh sản phẩm
                                    GestureDetector(
                                        onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem(searchList[index],baseUnit,switchUnit,itemProvider.lstItem[index].units)));
                                       },
                                        child: Image.network(
                                            getUrlFromLinkImg("${searchList[index].linkImg}"),
                                            width: widthDevice*0.38, 
                                            height: widthDevice * 0.38,                    
                                       ),
                                    ),
                                    SizedBox(height: 10, ),
                                    //Tên sản phẩm
                                    GestureDetector(
                                        onTap: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem(searchList[index],baseUnit,switchUnit,itemProvider.lstItem[index].units)));
                                        },
                                        child: SizedBox(
                                            height: 28 ,
                                            width: widthContainerItem,
                                            child: Text(
                                               "${searchList[index].name}",
                                               maxLines: 2, 
                                               overflow: TextOverflow.ellipsis,
                                               softWrap: false,
                                               style: TextStyle(fontSize: 12),
                                        )
                                    ),),
                                    // Price Agency + icon addCart
                                    SizedBox(
                                        height: 20,
                                        width: widthContainerItem,
                                        child: Row(
                                          children: [
                                             // Price baseUnit Agency
                                             SizedBox(
                                               height: 20,
                                               width: widthContainerItem*0.8,
                                               child: Text(
                                                 "${baseUnit['agencyPrice'].replaceAllMapped(reg, mathFunc)}" + 'đ',
                                                 style: TextStyle(fontSize:16, color: Color(0xffb01313))
                                               ),
                                             ),
                                             // icon add cart
                                             GestureDetector(
                                               //Show modal bottom sheet khi nhấn vào icon add cart
                                               onTap: (){
                                                  //Provider.of<CountBadge>(context, listen: false).updatePlus();
                                                  showModalBottomSheet<void>(
                                                     backgroundColor: Colors.white,
                                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                                                     context: ctxItemProvider,
                                                     builder: (BuildContext context) {
                                                        return Container(
                                                           height: heigtDevice*0.6,
                                                           child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              mainAxisSize: MainAxisSize.max,
                                                              children: <Widget>[
                                                                // icon button xóa 
                                                                SizedBox(
                                                                  width: widthDevice,
                                                                  height: 20,
                                                                  child: IconButton(
                                                                    icon: Icon(Icons.cancel_presentation, size: 20,),
                                                                    alignment: Alignment.centerRight,
                                                                    onPressed: () => Navigator.pop(context),
                                                                  ),
                                                                ),
                                                                // ảnh sp + tên + giá + số lượng
                                                              ],
                                                           ),
                                                        );
                                                     },//builder
                                                  );//showmodal bottom sheet
                                               },
                                               child: Container(
                                                  height: 20,
                                                  width: widthContainerItem*0.2,
                                                  child: Icon(Icons.add_shopping_cart_sharp, size: 19, color: Color(0xff7b2626),),
                                               ),
                                             )
                                          ]
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
                    // thêm dấu chấm vào giá sản phẩm 
                    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
                    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
                    //Xử lý đơn vị và chuyển đơn vị
                    var baseUnit;
                    List<dynamic> switchUnit = [];
                    for(var unit in itemProvider.lstItem[index].units){
                        if(unit['isBaseUnit'] == true) {
                          baseUnit = unit;
                        } else {
                          switchUnit.add(unit);
                        }
                    }
                    return  Container(
                            color: Colors.white,
                            child: Column(
                                children: [
                                    // Ảnh sản phẩm
                                    GestureDetector(
                                        onTap: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem(itemProvider.lstItem[index],baseUnit,switchUnit,itemProvider.lstItem[index].units)));
                                       },
                                        child: Image.network(
                                            getUrlFromLinkImg("${itemProvider.lstItem[index].linkImg}"),
                                            width: widthDevice*0.38,
                                            height: widthDevice * 0.38,                       
                                       ),
                                    ),
                                    //Tên sản phẩm
                                    SizedBox(height: 10, ),
                                    GestureDetector(
                                        onTap: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem(itemProvider.lstItem[index],baseUnit,switchUnit,itemProvider.lstItem[index].units)));
                                        },
                                        child: SizedBox(
                                            height: 28 ,
                                            width: widthDevice*0.4,
                                            child: Text(
                                               "${itemProvider.lstItem[index].name}",
                                               maxLines: 2, 
                                               overflow: TextOverflow.ellipsis,
                                               softWrap: false,
                                               style: TextStyle(fontSize: 12),
                                        )
                                    ),),
                                    // Price Agency + icon addCart
                                    SizedBox(
                                        height: 20,
                                        width: widthContainerItem,
                                        child: Row(
                                          children: [
                                             // Price baseUnit Agency
                                             SizedBox(
                                               height: 20,
                                               width: widthContainerItem*0.8,
                                               child: Text(
                                                 "${baseUnit['agencyPrice'].replaceAllMapped(reg, mathFunc)}" + 'đ',
                                                 style: TextStyle(fontSize:16, color: Color(0xffb01313))
                                               ),
                                             ),
                                             // icon add cart
                                             GestureDetector(
                                               onTap: (){
                                                  Provider.of<CountBadge>(context, listen: false).updatePlus();
                                               },
                                               child: Container(
                                                  height: 20,
                                                  width: widthContainerItem*0.2,
                                                  child: Icon(Icons.add_shopping_cart_sharp, size: 19, color: Color(0xff7b2626),),
                                               ),
                                             )
                                          ]
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
        //linkImg receive from server as Public Id
        final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", linkImg);
        String transformedUrl = cloudinaryImage.transform().width(256).thumb().generate() !;
        return transformedUrl;
  }    
}