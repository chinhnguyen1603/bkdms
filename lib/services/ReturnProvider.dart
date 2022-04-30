import 'package:flutter/cupertino.dart';

class AmountReturnProvider with ChangeNotifier{
  List<String> lstAmount = [];
  void initList (int index, String amount){
    this.lstAmount.insert(index, amount);
    notifyListeners();
  }
  void setNewAmount(int index, String newAmount){
    this.lstAmount[index] = newAmount;
    notifyListeners();
  }
  void removeIndex(int index){
    this.lstAmount.removeAt(index);
    notifyListeners();
  }
  void clearList(){
    this.lstAmount.clear();
    notifyListeners();
  }

}