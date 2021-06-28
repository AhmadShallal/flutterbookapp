import 'package:scoped_model/scoped_model.dart';

class BaseModel extends Model{
  //which screen
  int stackIndex = 0;

  //list of entities
  List entityList =[];

  //to move from list screen to entry screen
  var entityBeingEdited;

  //store date chosen by user in entry screen
  String chosenDate = '';


  //whenever user selects a new date vis popup
  void setChosenDate(String inDate) {
    chosenDate = inDate;
    //to rebuild widgets with data stored in model
    notifyListeners();
  }

  //when entity added or removed from list
  void loadData(String inEntityType, dynamic inDataBase) async {
    entityList = await inDataBase.getAll();
    //to rebuild widgets
    notifyListeners();
  }

  //called when user navigate between screens
  void setStackIndex (int inStackIndex){
    stackIndex = inStackIndex;
    //rebuild widgets
    notifyListeners();
  }

}