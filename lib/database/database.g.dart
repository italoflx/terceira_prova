// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

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

  PokemonDao? _pokemonDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Pokemon` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL, `baseExperience` INTEGER NOT NULL, `height` INTEGER NOT NULL, `weight` INTEGER NOT NULL, `image` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PokemonDao get pokemonDao {
    return _pokemonDaoInstance ??= _$PokemonDao(database, changeListener);
  }
}

class _$PokemonDao extends PokemonDao {
  _$PokemonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _pokemonInsertionAdapter = InsertionAdapter(
            database,
            'Pokemon',
            (Pokemon item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'baseExperience': item.baseExperience,
                  'height': item.height,
                  'weight': item.weight,
                  'image': item.image
                },
            changeListener),
        _pokemonDeletionAdapter = DeletionAdapter(
            database,
            'Pokemon',
            ['id'],
            (Pokemon item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'baseExperience': item.baseExperience,
                  'height': item.height,
                  'weight': item.weight,
                  'image': item.image
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Pokemon> _pokemonInsertionAdapter;

  final DeletionAdapter<Pokemon> _pokemonDeletionAdapter;

  @override
  Future<List<Pokemon>> findAllPokemons() async {
    return _queryAdapter.queryList('SELECT * FROM Pokemon',
        mapper: (Map<String, Object?> row) => Pokemon(
            id: row['id'] as int,
            name: row['name'] as String,
            baseExperience: row['baseExperience'] as int,
            height: row['height'] as int,
            weight: row['weight'] as int,
            image: row['image'] as String));
  }

  @override
  Stream<Pokemon?> findPokemonById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Pokemon WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Pokemon(
            id: row['id'] as int,
            name: row['name'] as String,
            baseExperience: row['baseExperience'] as int,
            height: row['height'] as int,
            weight: row['weight'] as int,
            image: row['image'] as String),
        arguments: [id],
        queryableName: 'Pokemon',
        isView: false);
  }

  @override
  Future<int?> isPokemonCapturado(int id) async {
    return _queryAdapter.query('SELECT COUNT(*) FROM Pokemon WHERE id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<void> insertPokemon(Pokemon pokemon) async {
    await _pokemonInsertionAdapter.insert(pokemon, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePokemon(Pokemon pokemon) async {
    await _pokemonDeletionAdapter.delete(pokemon);
  }
}
