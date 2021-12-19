import 'package:sdgp/src/connections/connection_database.dart';
import 'package:sdgp/src/models/m_item.dart';

class ItemController {
  ///This function will save the item
  Future<int?> saveItem(ItemsModel itemsModel) async {
    if (itemsModel.id == null) {
      int tempId = await ConnectionDB().getLastId("items") + 1;
      itemsModel.id = tempId;
      return await ConnectionDB().insertData(itemsModel, "items");
    } else {
      return await ConnectionDB()
          .updateData(itemsModel, "items", itemsModel.id!);
    }
  }
}
