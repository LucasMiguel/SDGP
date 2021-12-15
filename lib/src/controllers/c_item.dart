import 'package:sdgp/src/connections/connection_database.dart';
import 'package:sdgp/src/models/m_item.dart';

class ItemController {
  ///Function on will save the Item data
  Future<int?> saveItems(ItemsModel itemsModel) async {
    int? idTemp;
    if (itemsModel.id != null) {
      idTemp = await ConnectionDB().getLastId("items");
      itemsModel.id = idTemp;
      return await ConnectionDB().insertData(itemsModel, "items");
    } else {
      return await ConnectionDB()
          .updateData(itemsModel, "items", itemsModel.id!);
    }
  }
}
