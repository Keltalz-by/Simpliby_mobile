// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CartDao? _cartDaoInstance;

  FavStoresDao? _favDaoInstance;

  ToBuyModelDao? _toBuyDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ItemCartDetails` (`id` INTEGER NOT NULL, `storeName` TEXT NOT NULL, `storeId` INTEGER NOT NULL, `itemName` TEXT NOT NULL, `itemPieces` INTEGER NOT NULL, `itemPrice` REAL NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FavStoresModel` (`id` TEXT NOT NULL, `storeName` TEXT NOT NULL, `location` TEXT NOT NULL, `storeAddress` TEXT NOT NULL, `imageLogo` TEXT NOT NULL, `rating` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ItemToBuy` (`id` INTEGER NOT NULL, `item` TEXT NOT NULL, `isBought` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CartDao get cartDao {
    return _cartDaoInstance ??= _$CartDao(database, changeListener);
  }

  @override
  FavStoresDao get favDao {
    return _favDaoInstance ??= _$FavStoresDao(database, changeListener);
  }

  @override
  ToBuyModelDao get toBuyDao {
    return _toBuyDaoInstance ??= _$ToBuyModelDao(database, changeListener);
  }
}

class _$CartDao extends CartDao {
  _$CartDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _itemCartDetailsInsertionAdapter = InsertionAdapter(
            database,
            'ItemCartDetails',
            (ItemCartDetails item) => <String, Object?>{
                  'id': item.id,
                  'storeName': item.storeName,
                  'storeId': item.storeId,
                  'itemName': item.itemName,
                  'itemPieces': item.itemPieces,
                  'itemPrice': item.itemPrice
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ItemCartDetails> _itemCartDetailsInsertionAdapter;

  @override
  Future<double?> totalResults() async {
    return _queryAdapter.query('SELECT  SUM(totalPrice) FROM ItemCartDetails',
        mapper: (Map<String, Object?> row) => row.values.first as double);
  }

  @override
  Stream<List<ItemCartDetails>> getAllCartItems() {
    return _queryAdapter.queryListStream('SELECT * FROM ItemCartDetails',
        mapper: (Map<String, Object?> row) => ItemCartDetails(
            id: row['id'] as int,
            storeName: row['storeName'] as String,
            storeId: row['storeId'] as int,
            itemName: row['itemName'] as String,
            itemPieces: row['itemPieces'] as int,
            itemPrice: row['itemPrice'] as double),
        queryableName: 'ItemCartDetails',
        isView: false);
  }

  @override
  Future<void> removeFromCart(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM ItemCartDetails WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> updateNumberOfItems(
    int number,
    int id,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE ItemCartDetails SET itemPieces = ?1 WHERE id = ?2',
        arguments: [number, id]);
  }

  @override
  Future<void> addToCart(ItemCartDetails item) async {
    await _itemCartDetailsInsertionAdapter.insert(
        item, OnConflictStrategy.replace);
  }
}

class _$FavStoresDao extends FavStoresDao {
  _$FavStoresDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _favStoresModelInsertionAdapter = InsertionAdapter(
            database,
            'FavStoresModel',
            (FavStoresModel item) => <String, Object?>{
                  'id': item.id,
                  'storeName': item.storeName,
                  'location': item.location,
                  'storeAddress': item.storeAddress,
                  'imageLogo': item.imageLogo,
                  'rating': item.rating
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavStoresModel> _favStoresModelInsertionAdapter;

  @override
  Stream<List<FavStoresModel>> getAllFavStores() {
    return _queryAdapter.queryListStream('SELECT * FROM FavStoresModel',
        mapper: (Map<String, Object?> row) => FavStoresModel(
            id: row['id'] as String,
            storeName: row['storeName'] as String,
            imageLogo: row['imageLogo'] as String,
            location: row['location'] as String,
            storeAddress: row['storeAddress'] as String,
            rating: row['rating'] as int),
        queryableName: 'FavStoresModel',
        isView: false);
  }

  @override
  Future<void> removeFromFav(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM FavStoresModel WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> addToFavorite(FavStoresModel item) async {
    await _favStoresModelInsertionAdapter.insert(
        item, OnConflictStrategy.replace);
  }
}

class _$ToBuyModelDao extends ToBuyModelDao {
  _$ToBuyModelDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _itemToBuyInsertionAdapter = InsertionAdapter(
            database,
            'ItemToBuy',
            (ItemToBuy item) => <String, Object?>{
                  'id': item.id,
                  'item': item.item,
                  'isBought': item.isBought ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ItemToBuy> _itemToBuyInsertionAdapter;

  @override
  Future<List<ItemToBuy>> getAllItemsToBuy() async {
    return _queryAdapter.queryList('SELECT * FROM ToBuyModel',
        mapper: (Map<String, Object?> row) => ItemToBuy(
            id: row['id'] as int,
            item: row['item'] as String,
            isBought: (row['isBought'] as int) != 0));
  }

  @override
  Future<void> deleteItemToBuy(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM ToBuyModel WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> updateNewItemToBuy(
    int id,
    String newValue,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE ToBuyModel SET item = ?2 WHERE id = ?1',
        arguments: [id, newValue]);
  }

  @override
  Future<void> changeIsBought(
    int id,
    bool isBought,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE ToBuyModel SET isBought = ?2 WHERE id = ?1',
        arguments: [id, isBought ? 1 : 0]);
  }

  @override
  Future<void> insertNewItemsToBuy(ItemToBuy model) async {
    await _itemToBuyInsertionAdapter.insert(model, OnConflictStrategy.replace);
  }
}
