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

  AlcoolDAO? _alcoolDaoInstance;

  DatahealthDAO? _datahealthDaoInstance;

  P_accessDAO? _p_accessDaoInstance;

  ResthealthDAO? _resthealthDaoInstance;

  StepsDAO? _stepsDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Alcool` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `day` TEXT NOT NULL, `type` TEXT NOT NULL, `quantity` INTEGER NOT NULL, `hour` INTEGER NOT NULL, `volume` REAL, `percentage` REAL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `P_access` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `surname` TEXT, `sex` TEXT, `birth` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Resthealth` (`id` INTEGER, `date` TEXT NOT NULL, `restv` REAL NOT NULL, FOREIGN KEY (`id`) REFERENCES `P_access` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`, `date`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Datahealth` (`id` INTEGER, `day` TEXT NOT NULL, `hour` INTEGER NOT NULL, `value` REAL NOT NULL, FOREIGN KEY (`id`, `day`) REFERENCES `Resthealth` (`id`, `date`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`, `day`, `hour`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Steps` (`id` INTEGER, `day` TEXT NOT NULL, `num_steps` INTEGER NOT NULL, FOREIGN KEY (`id`) REFERENCES `P_access` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`, `day`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AlcoolDAO get alcoolDao {
    return _alcoolDaoInstance ??= _$AlcoolDAO(database, changeListener);
  }

  @override
  DatahealthDAO get datahealthDao {
    return _datahealthDaoInstance ??= _$DatahealthDAO(database, changeListener);
  }

  @override
  P_accessDAO get p_accessDao {
    return _p_accessDaoInstance ??= _$P_accessDAO(database, changeListener);
  }

  @override
  ResthealthDAO get resthealthDao {
    return _resthealthDaoInstance ??= _$ResthealthDAO(database, changeListener);
  }

  @override
  StepsDAO get stepsDao {
    return _stepsDaoInstance ??= _$StepsDAO(database, changeListener);
  }
}

class _$AlcoolDAO extends AlcoolDAO {
  _$AlcoolDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _alcoolInsertionAdapter = InsertionAdapter(
            database,
            'Alcool',
            (Alcool item) => <String, Object?>{
                  'id': item.id,
                  'day': item.day,
                  'type': item.type,
                  'quantity': item.quantity,
                  'hour': item.hour,
                  'volume': item.volume,
                  'percentage': item.percentage
                }),
        _alcoolUpdateAdapter = UpdateAdapter(
            database,
            'Alcool',
            ['id'],
            (Alcool item) => <String, Object?>{
                  'id': item.id,
                  'day': item.day,
                  'type': item.type,
                  'quantity': item.quantity,
                  'hour': item.hour,
                  'volume': item.volume,
                  'percentage': item.percentage
                }),
        _alcoolDeletionAdapter = DeletionAdapter(
            database,
            'Alcool',
            ['id'],
            (Alcool item) => <String, Object?>{
                  'id': item.id,
                  'day': item.day,
                  'type': item.type,
                  'quantity': item.quantity,
                  'hour': item.hour,
                  'volume': item.volume,
                  'percentage': item.percentage
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Alcool> _alcoolInsertionAdapter;

  final UpdateAdapter<Alcool> _alcoolUpdateAdapter;

  final DeletionAdapter<Alcool> _alcoolDeletionAdapter;

  @override
  Future<List<Alcool>> findAllAlcool() async {
    return _queryAdapter.queryList('SELECT * FROM Alcool',
        mapper: (Map<String, Object?> row) => Alcool(
            row['id'] as int?,
            row['day'] as String,
            row['type'] as String,
            row['quantity'] as int,
            row['hour'] as int,
            row['volume'] as double?,
            row['percentage'] as double?));
  }

  @override
  Future<void> insertAlcool(Alcool newAlcool) async {
    await _alcoolInsertionAdapter.insert(newAlcool, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAlcool(Alcool newAlcool) async {
    await _alcoolUpdateAdapter.update(newAlcool, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteAlcool(Alcool aAlcool) async {
    await _alcoolDeletionAdapter.delete(aAlcool);
  }
}

class _$DatahealthDAO extends DatahealthDAO {
  _$DatahealthDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _datahealthInsertionAdapter = InsertionAdapter(
            database,
            'Datahealth',
            (Datahealth item) => <String, Object?>{
                  'id': item.id,
                  'day': item.day,
                  'hour': item.hour,
                  'value': item.value
                }),
        _datahealthDeletionAdapter = DeletionAdapter(
            database,
            'Datahealth',
            ['id', 'day', 'hour'],
            (Datahealth item) => <String, Object?>{
                  'id': item.id,
                  'day': item.day,
                  'hour': item.hour,
                  'value': item.value
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Datahealth> _datahealthInsertionAdapter;

  final DeletionAdapter<Datahealth> _datahealthDeletionAdapter;

  @override
  Future<List<Datahealth>> findAllDatahealth() async {
    return _queryAdapter.queryList('SELECT * FROM Datahealth',
        mapper: (Map<String, Object?> row) => Datahealth(row['id'] as int?,
            row['day'] as String, row['hour'] as int, row['value'] as double));
  }

  @override
  Future<void> insertDatahealth(Datahealth newdatahealth) async {
    await _datahealthInsertionAdapter.insert(
        newdatahealth, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDatahealth(Datahealth adatahealth) async {
    await _datahealthDeletionAdapter.delete(adatahealth);
  }
}

class _$P_accessDAO extends P_accessDAO {
  _$P_accessDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _p_accessInsertionAdapter = InsertionAdapter(
            database,
            'P_access',
            (P_access item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'surname': item.surname,
                  'sex': item.sex,
                  'birth': item.birth
                }),
        _p_accessDeletionAdapter = DeletionAdapter(
            database,
            'P_access',
            ['id'],
            (P_access item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'surname': item.surname,
                  'sex': item.sex,
                  'birth': item.birth
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<P_access> _p_accessInsertionAdapter;

  final DeletionAdapter<P_access> _p_accessDeletionAdapter;

  @override
  Future<List<P_access>> findAllP_access() async {
    return _queryAdapter.queryList('SELECT * FROM P_access',
        mapper: (Map<String, Object?> row) => P_access(
            row['id'] as int?,
            row['name'] as String?,
            row['surname'] as String?,
            row['sex'] as String?,
            row['birth'] as String?));
  }

  @override
  Future<void> insertP_access(P_access newaccess) async {
    await _p_accessInsertionAdapter.insert(newaccess, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteP_access(P_access pAccess) async {
    await _p_accessDeletionAdapter.delete(pAccess);
  }
}

class _$ResthealthDAO extends ResthealthDAO {
  _$ResthealthDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _resthealthInsertionAdapter = InsertionAdapter(
            database,
            'Resthealth',
            (Resthealth item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'restv': item.restv
                }),
        _resthealthDeletionAdapter = DeletionAdapter(
            database,
            'Resthealth',
            ['id', 'date'],
            (Resthealth item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'restv': item.restv
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Resthealth> _resthealthInsertionAdapter;

  final DeletionAdapter<Resthealth> _resthealthDeletionAdapter;

  @override
  Future<List<Resthealth>> findAllResthealth() async {
    return _queryAdapter.queryList('SELECT * FROM Resthealth',
        mapper: (Map<String, Object?> row) => Resthealth(
            row['id'] as int?, row['date'] as String, row['restv'] as double));
  }

  @override
  Future<void> insertResthealth(Resthealth newResthealth) async {
    await _resthealthInsertionAdapter.insert(
        newResthealth, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteResthealth(Resthealth aResthealth) async {
    await _resthealthDeletionAdapter.delete(aResthealth);
  }
}

class _$StepsDAO extends StepsDAO {
  _$StepsDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _stepsInsertionAdapter = InsertionAdapter(
            database,
            'Steps',
            (Steps item) => <String, Object?>{
                  'id': item.id,
                  'day': item.day,
                  'num_steps': item.num_steps
                }),
        _stepsDeletionAdapter = DeletionAdapter(
            database,
            'Steps',
            ['id', 'day'],
            (Steps item) => <String, Object?>{
                  'id': item.id,
                  'day': item.day,
                  'num_steps': item.num_steps
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Steps> _stepsInsertionAdapter;

  final DeletionAdapter<Steps> _stepsDeletionAdapter;

  @override
  Future<List<Steps>> findAllSteps() async {
    return _queryAdapter.queryList('SELECT * FROM Steps',
        mapper: (Map<String, Object?> row) => Steps(
            row['id'] as int?, row['day'] as String, row['num_steps'] as int));
  }

  @override
  Future<void> insertSteps(Steps newsteps) async {
    await _stepsInsertionAdapter.insert(newsteps, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSteps(Steps step) async {
    await _stepsDeletionAdapter.delete(step);
  }
}
