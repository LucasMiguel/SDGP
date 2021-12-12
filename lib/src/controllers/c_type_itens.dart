import 'package:sdgp/src/connections/connection_database.dart';
import 'package:sdgp/src/models/m_type_item.dart';

class TypeItensController {
  Future<List<TypeItemModel>> getAll() async {
    List<Map<String, dynamic>> map;
    List<TypeItemModel> listTypes = [];
    map = await ConnectionDB().getAllData(
        query: 'type_items', columnsWhere: 'status = ?', valueWhere: [1]);
    for (var item in map) {
      listTypes.add(TypeItemModel.fromJson(item));
    }
    return listTypes;
  }
}
