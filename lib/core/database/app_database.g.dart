// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ChildProfilesTable extends ChildProfiles
    with TableInfo<$ChildProfilesTable, ChildProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChildProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _avatarIdMeta =
      const VerificationMeta('avatarId');
  @override
  late final GeneratedColumn<String> avatarId = GeneratedColumn<String>(
      'avatar_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        avatarId,
        createdAt,
        updatedAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'child_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<ChildProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('avatar_id')) {
      context.handle(_avatarIdMeta,
          avatarId.isAcceptableOrUnknown(data['avatar_id']!, _avatarIdMeta));
    } else if (isInserting) {
      context.missing(_avatarIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChildProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChildProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      avatarId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $ChildProfilesTable createAlias(String alias) {
    return $ChildProfilesTable(attachedDatabase, alias);
  }
}

class ChildProfile extends DataClass implements Insertable<ChildProfile> {
  final String id;
  final String name;
  final String avatarId;
  final int createdAt;
  final int updatedAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const ChildProfile(
      {required this.id,
      required this.name,
      required this.avatarId,
      required this.createdAt,
      required this.updatedAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['avatar_id'] = Variable<String>(avatarId);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  ChildProfilesCompanion toCompanion(bool nullToAbsent) {
    return ChildProfilesCompanion(
      id: Value(id),
      name: Value(name),
      avatarId: Value(avatarId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ChildProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChildProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      avatarId: serializer.fromJson<String>(json['avatarId']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'avatarId': serializer.toJson<String>(avatarId),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  ChildProfile copyWith(
          {String? id,
          String? name,
          String? avatarId,
          int? createdAt,
          int? updatedAt,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      ChildProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        avatarId: avatarId ?? this.avatarId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  ChildProfile copyWithCompanion(ChildProfilesCompanion data) {
    return ChildProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      avatarId: data.avatarId.present ? data.avatarId.value : this.avatarId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChildProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatarId: $avatarId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, avatarId, createdAt, updatedAt,
      remoteId, syncStatus, lastSyncedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChildProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.avatarId == this.avatarId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class ChildProfilesCompanion extends UpdateCompanion<ChildProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> avatarId;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const ChildProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.avatarId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChildProfilesCompanion.insert({
    required String id,
    required String name,
    required String avatarId,
    required int createdAt,
    required int updatedAt,
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        avatarId = Value(avatarId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ChildProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? avatarId,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (avatarId != null) 'avatar_id': avatarId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChildProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? avatarId,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return ChildProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarId: avatarId ?? this.avatarId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (avatarId.present) {
      map['avatar_id'] = Variable<String>(avatarId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChildProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatarId: $avatarId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncVersionsTable extends SyncVersions
    with TableInfo<$SyncVersionsTable, SyncVersion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncVersionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncKeyMeta =
      const VerificationMeta('syncKey');
  @override
  late final GeneratedColumn<String> syncKey = GeneratedColumn<String>(
      'sync_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
      'version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _appliedAtMeta =
      const VerificationMeta('appliedAt');
  @override
  late final GeneratedColumn<int> appliedAt = GeneratedColumn<int>(
      'applied_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastCheckedAtMeta =
      const VerificationMeta('lastCheckedAt');
  @override
  late final GeneratedColumn<int> lastCheckedAt = GeneratedColumn<int>(
      'last_checked_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _lastErrorMeta =
      const VerificationMeta('lastError');
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
      'last_error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, syncKey, version, source, appliedAt, lastCheckedAt, lastError];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_versions';
  @override
  VerificationContext validateIntegrity(Insertable<SyncVersion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sync_key')) {
      context.handle(_syncKeyMeta,
          syncKey.isAcceptableOrUnknown(data['sync_key']!, _syncKeyMeta));
    } else if (isInserting) {
      context.missing(_syncKeyMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('applied_at')) {
      context.handle(_appliedAtMeta,
          appliedAt.isAcceptableOrUnknown(data['applied_at']!, _appliedAtMeta));
    } else if (isInserting) {
      context.missing(_appliedAtMeta);
    }
    if (data.containsKey('last_checked_at')) {
      context.handle(
          _lastCheckedAtMeta,
          lastCheckedAt.isAcceptableOrUnknown(
              data['last_checked_at']!, _lastCheckedAtMeta));
    }
    if (data.containsKey('last_error')) {
      context.handle(_lastErrorMeta,
          lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {syncKey},
      ];
  @override
  SyncVersion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncVersion(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      syncKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_key'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}version'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      appliedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}applied_at'])!,
      lastCheckedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_checked_at']),
      lastError: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error']),
    );
  }

  @override
  $SyncVersionsTable createAlias(String alias) {
    return $SyncVersionsTable(attachedDatabase, alias);
  }
}

class SyncVersion extends DataClass implements Insertable<SyncVersion> {
  final String id;
  final String syncKey;
  final String version;
  final String source;
  final int appliedAt;
  final int? lastCheckedAt;
  final String? lastError;
  const SyncVersion(
      {required this.id,
      required this.syncKey,
      required this.version,
      required this.source,
      required this.appliedAt,
      this.lastCheckedAt,
      this.lastError});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sync_key'] = Variable<String>(syncKey);
    map['version'] = Variable<String>(version);
    map['source'] = Variable<String>(source);
    map['applied_at'] = Variable<int>(appliedAt);
    if (!nullToAbsent || lastCheckedAt != null) {
      map['last_checked_at'] = Variable<int>(lastCheckedAt);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncVersionsCompanion toCompanion(bool nullToAbsent) {
    return SyncVersionsCompanion(
      id: Value(id),
      syncKey: Value(syncKey),
      version: Value(version),
      source: Value(source),
      appliedAt: Value(appliedAt),
      lastCheckedAt: lastCheckedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCheckedAt),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncVersion.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncVersion(
      id: serializer.fromJson<String>(json['id']),
      syncKey: serializer.fromJson<String>(json['syncKey']),
      version: serializer.fromJson<String>(json['version']),
      source: serializer.fromJson<String>(json['source']),
      appliedAt: serializer.fromJson<int>(json['appliedAt']),
      lastCheckedAt: serializer.fromJson<int?>(json['lastCheckedAt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'syncKey': serializer.toJson<String>(syncKey),
      'version': serializer.toJson<String>(version),
      'source': serializer.toJson<String>(source),
      'appliedAt': serializer.toJson<int>(appliedAt),
      'lastCheckedAt': serializer.toJson<int?>(lastCheckedAt),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncVersion copyWith(
          {String? id,
          String? syncKey,
          String? version,
          String? source,
          int? appliedAt,
          Value<int?> lastCheckedAt = const Value.absent(),
          Value<String?> lastError = const Value.absent()}) =>
      SyncVersion(
        id: id ?? this.id,
        syncKey: syncKey ?? this.syncKey,
        version: version ?? this.version,
        source: source ?? this.source,
        appliedAt: appliedAt ?? this.appliedAt,
        lastCheckedAt:
            lastCheckedAt.present ? lastCheckedAt.value : this.lastCheckedAt,
        lastError: lastError.present ? lastError.value : this.lastError,
      );
  SyncVersion copyWithCompanion(SyncVersionsCompanion data) {
    return SyncVersion(
      id: data.id.present ? data.id.value : this.id,
      syncKey: data.syncKey.present ? data.syncKey.value : this.syncKey,
      version: data.version.present ? data.version.value : this.version,
      source: data.source.present ? data.source.value : this.source,
      appliedAt: data.appliedAt.present ? data.appliedAt.value : this.appliedAt,
      lastCheckedAt: data.lastCheckedAt.present
          ? data.lastCheckedAt.value
          : this.lastCheckedAt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncVersion(')
          ..write('id: $id, ')
          ..write('syncKey: $syncKey, ')
          ..write('version: $version, ')
          ..write('source: $source, ')
          ..write('appliedAt: $appliedAt, ')
          ..write('lastCheckedAt: $lastCheckedAt, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, syncKey, version, source, appliedAt, lastCheckedAt, lastError);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncVersion &&
          other.id == this.id &&
          other.syncKey == this.syncKey &&
          other.version == this.version &&
          other.source == this.source &&
          other.appliedAt == this.appliedAt &&
          other.lastCheckedAt == this.lastCheckedAt &&
          other.lastError == this.lastError);
}

class SyncVersionsCompanion extends UpdateCompanion<SyncVersion> {
  final Value<String> id;
  final Value<String> syncKey;
  final Value<String> version;
  final Value<String> source;
  final Value<int> appliedAt;
  final Value<int?> lastCheckedAt;
  final Value<String?> lastError;
  final Value<int> rowid;
  const SyncVersionsCompanion({
    this.id = const Value.absent(),
    this.syncKey = const Value.absent(),
    this.version = const Value.absent(),
    this.source = const Value.absent(),
    this.appliedAt = const Value.absent(),
    this.lastCheckedAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncVersionsCompanion.insert({
    required String id,
    required String syncKey,
    required String version,
    required String source,
    required int appliedAt,
    this.lastCheckedAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        syncKey = Value(syncKey),
        version = Value(version),
        source = Value(source),
        appliedAt = Value(appliedAt);
  static Insertable<SyncVersion> custom({
    Expression<String>? id,
    Expression<String>? syncKey,
    Expression<String>? version,
    Expression<String>? source,
    Expression<int>? appliedAt,
    Expression<int>? lastCheckedAt,
    Expression<String>? lastError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncKey != null) 'sync_key': syncKey,
      if (version != null) 'version': version,
      if (source != null) 'source': source,
      if (appliedAt != null) 'applied_at': appliedAt,
      if (lastCheckedAt != null) 'last_checked_at': lastCheckedAt,
      if (lastError != null) 'last_error': lastError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncVersionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? syncKey,
      Value<String>? version,
      Value<String>? source,
      Value<int>? appliedAt,
      Value<int?>? lastCheckedAt,
      Value<String?>? lastError,
      Value<int>? rowid}) {
    return SyncVersionsCompanion(
      id: id ?? this.id,
      syncKey: syncKey ?? this.syncKey,
      version: version ?? this.version,
      source: source ?? this.source,
      appliedAt: appliedAt ?? this.appliedAt,
      lastCheckedAt: lastCheckedAt ?? this.lastCheckedAt,
      lastError: lastError ?? this.lastError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (syncKey.present) {
      map['sync_key'] = Variable<String>(syncKey.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (appliedAt.present) {
      map['applied_at'] = Variable<int>(appliedAt.value);
    }
    if (lastCheckedAt.present) {
      map['last_checked_at'] = Variable<int>(lastCheckedAt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncVersionsCompanion(')
          ..write('id: $id, ')
          ..write('syncKey: $syncKey, ')
          ..write('version: $version, ')
          ..write('source: $source, ')
          ..write('appliedAt: $appliedAt, ')
          ..write('lastCheckedAt: $lastCheckedAt, ')
          ..write('lastError: $lastError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearningPathsTable extends LearningPaths
    with TableInfo<$LearningPathsTable, LearningPath> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningPathsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ageMinMeta = const VerificationMeta('ageMin');
  @override
  late final GeneratedColumn<int> ageMin = GeneratedColumn<int>(
      'age_min', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _ageMaxMeta = const VerificationMeta('ageMax');
  @override
  late final GeneratedColumn<int> ageMax = GeneratedColumn<int>(
      'age_max', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
      'level', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('beginner'));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        ageMin,
        ageMax,
        level,
        isActive,
        sortOrder,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_paths';
  @override
  VerificationContext validateIntegrity(Insertable<LearningPath> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('age_min')) {
      context.handle(_ageMinMeta,
          ageMin.isAcceptableOrUnknown(data['age_min']!, _ageMinMeta));
    }
    if (data.containsKey('age_max')) {
      context.handle(_ageMaxMeta,
          ageMax.isAcceptableOrUnknown(data['age_max']!, _ageMaxMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningPath map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningPath(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      ageMin: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age_min']),
      ageMax: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age_max']),
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}level'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LearningPathsTable createAlias(String alias) {
    return $LearningPathsTable(attachedDatabase, alias);
  }
}

class LearningPath extends DataClass implements Insertable<LearningPath> {
  final String id;
  final String title;
  final String? description;
  final int? ageMin;
  final int? ageMax;
  final String level;
  final bool isActive;
  final int sortOrder;
  final int createdAt;
  final int updatedAt;
  const LearningPath(
      {required this.id,
      required this.title,
      this.description,
      this.ageMin,
      this.ageMax,
      required this.level,
      required this.isActive,
      required this.sortOrder,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || ageMin != null) {
      map['age_min'] = Variable<int>(ageMin);
    }
    if (!nullToAbsent || ageMax != null) {
      map['age_max'] = Variable<int>(ageMax);
    }
    map['level'] = Variable<String>(level);
    map['is_active'] = Variable<bool>(isActive);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  LearningPathsCompanion toCompanion(bool nullToAbsent) {
    return LearningPathsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      ageMin:
          ageMin == null && nullToAbsent ? const Value.absent() : Value(ageMin),
      ageMax:
          ageMax == null && nullToAbsent ? const Value.absent() : Value(ageMax),
      level: Value(level),
      isActive: Value(isActive),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LearningPath.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningPath(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      ageMin: serializer.fromJson<int?>(json['ageMin']),
      ageMax: serializer.fromJson<int?>(json['ageMax']),
      level: serializer.fromJson<String>(json['level']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'ageMin': serializer.toJson<int?>(ageMin),
      'ageMax': serializer.toJson<int?>(ageMax),
      'level': serializer.toJson<String>(level),
      'isActive': serializer.toJson<bool>(isActive),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  LearningPath copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<int?> ageMin = const Value.absent(),
          Value<int?> ageMax = const Value.absent(),
          String? level,
          bool? isActive,
          int? sortOrder,
          int? createdAt,
          int? updatedAt}) =>
      LearningPath(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        ageMin: ageMin.present ? ageMin.value : this.ageMin,
        ageMax: ageMax.present ? ageMax.value : this.ageMax,
        level: level ?? this.level,
        isActive: isActive ?? this.isActive,
        sortOrder: sortOrder ?? this.sortOrder,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LearningPath copyWithCompanion(LearningPathsCompanion data) {
    return LearningPath(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      ageMin: data.ageMin.present ? data.ageMin.value : this.ageMin,
      ageMax: data.ageMax.present ? data.ageMax.value : this.ageMax,
      level: data.level.present ? data.level.value : this.level,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningPath(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('ageMin: $ageMin, ')
          ..write('ageMax: $ageMax, ')
          ..write('level: $level, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, ageMin, ageMax, level,
      isActive, sortOrder, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningPath &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.ageMin == this.ageMin &&
          other.ageMax == this.ageMax &&
          other.level == this.level &&
          other.isActive == this.isActive &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LearningPathsCompanion extends UpdateCompanion<LearningPath> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<int?> ageMin;
  final Value<int?> ageMax;
  final Value<String> level;
  final Value<bool> isActive;
  final Value<int> sortOrder;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const LearningPathsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.ageMin = const Value.absent(),
    this.ageMax = const Value.absent(),
    this.level = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearningPathsCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.ageMin = const Value.absent(),
    this.ageMax = const Value.absent(),
    this.level = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<LearningPath> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? ageMin,
    Expression<int>? ageMax,
    Expression<String>? level,
    Expression<bool>? isActive,
    Expression<int>? sortOrder,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (ageMin != null) 'age_min': ageMin,
      if (ageMax != null) 'age_max': ageMax,
      if (level != null) 'level': level,
      if (isActive != null) 'is_active': isActive,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearningPathsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<int?>? ageMin,
      Value<int?>? ageMax,
      Value<String>? level,
      Value<bool>? isActive,
      Value<int>? sortOrder,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<int>? rowid}) {
    return LearningPathsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      ageMin: ageMin ?? this.ageMin,
      ageMax: ageMax ?? this.ageMax,
      level: level ?? this.level,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (ageMin.present) {
      map['age_min'] = Variable<int>(ageMin.value);
    }
    if (ageMax.present) {
      map['age_max'] = Variable<int>(ageMax.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningPathsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('ageMin: $ageMin, ')
          ..write('ageMax: $ageMax, ')
          ..write('level: $level, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TopicsTable extends Topics with TableInfo<$TopicsTable, Topic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameViMeta = const VerificationMeta('nameVi');
  @override
  late final GeneratedColumn<String> nameVi = GeneratedColumn<String>(
      'name_vi', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconUrlMeta =
      const VerificationMeta('iconUrl');
  @override
  late final GeneratedColumn<String> iconUrl = GeneratedColumn<String>(
      'icon_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, nameEn, nameVi, iconUrl, colorHex, sortOrder, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topics';
  @override
  VerificationContext validateIntegrity(Insertable<Topic> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_vi')) {
      context.handle(_nameViMeta,
          nameVi.isAcceptableOrUnknown(data['name_vi']!, _nameViMeta));
    } else if (isInserting) {
      context.missing(_nameViMeta);
    }
    if (data.containsKey('icon_url')) {
      context.handle(_iconUrlMeta,
          iconUrl.isAcceptableOrUnknown(data['icon_url']!, _iconUrlMeta));
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Topic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Topic(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      nameVi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_vi'])!,
      iconUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_url']),
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $TopicsTable createAlias(String alias) {
    return $TopicsTable(attachedDatabase, alias);
  }
}

class Topic extends DataClass implements Insertable<Topic> {
  final String id;
  final String nameEn;
  final String nameVi;
  final String? iconUrl;
  final String? colorHex;
  final int sortOrder;
  final bool isActive;
  const Topic(
      {required this.id,
      required this.nameEn,
      required this.nameVi,
      this.iconUrl,
      this.colorHex,
      required this.sortOrder,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_vi'] = Variable<String>(nameVi);
    if (!nullToAbsent || iconUrl != null) {
      map['icon_url'] = Variable<String>(iconUrl);
    }
    if (!nullToAbsent || colorHex != null) {
      map['color_hex'] = Variable<String>(colorHex);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  TopicsCompanion toCompanion(bool nullToAbsent) {
    return TopicsCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameVi: Value(nameVi),
      iconUrl: iconUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(iconUrl),
      colorHex: colorHex == null && nullToAbsent
          ? const Value.absent()
          : Value(colorHex),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
    );
  }

  factory Topic.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Topic(
      id: serializer.fromJson<String>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameVi: serializer.fromJson<String>(json['nameVi']),
      iconUrl: serializer.fromJson<String?>(json['iconUrl']),
      colorHex: serializer.fromJson<String?>(json['colorHex']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameVi': serializer.toJson<String>(nameVi),
      'iconUrl': serializer.toJson<String?>(iconUrl),
      'colorHex': serializer.toJson<String?>(colorHex),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Topic copyWith(
          {String? id,
          String? nameEn,
          String? nameVi,
          Value<String?> iconUrl = const Value.absent(),
          Value<String?> colorHex = const Value.absent(),
          int? sortOrder,
          bool? isActive}) =>
      Topic(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameVi: nameVi ?? this.nameVi,
        iconUrl: iconUrl.present ? iconUrl.value : this.iconUrl,
        colorHex: colorHex.present ? colorHex.value : this.colorHex,
        sortOrder: sortOrder ?? this.sortOrder,
        isActive: isActive ?? this.isActive,
      );
  Topic copyWithCompanion(TopicsCompanion data) {
    return Topic(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameVi: data.nameVi.present ? data.nameVi.value : this.nameVi,
      iconUrl: data.iconUrl.present ? data.iconUrl.value : this.iconUrl,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Topic(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameVi: $nameVi, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('colorHex: $colorHex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nameEn, nameVi, iconUrl, colorHex, sortOrder, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Topic &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameVi == this.nameVi &&
          other.iconUrl == this.iconUrl &&
          other.colorHex == this.colorHex &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive);
}

class TopicsCompanion extends UpdateCompanion<Topic> {
  final Value<String> id;
  final Value<String> nameEn;
  final Value<String> nameVi;
  final Value<String?> iconUrl;
  final Value<String?> colorHex;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<int> rowid;
  const TopicsCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameVi = const Value.absent(),
    this.iconUrl = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TopicsCompanion.insert({
    required String id,
    required String nameEn,
    required String nameVi,
    this.iconUrl = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nameEn = Value(nameEn),
        nameVi = Value(nameVi);
  static Insertable<Topic> custom({
    Expression<String>? id,
    Expression<String>? nameEn,
    Expression<String>? nameVi,
    Expression<String>? iconUrl,
    Expression<String>? colorHex,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameVi != null) 'name_vi': nameVi,
      if (iconUrl != null) 'icon_url': iconUrl,
      if (colorHex != null) 'color_hex': colorHex,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TopicsCompanion copyWith(
      {Value<String>? id,
      Value<String>? nameEn,
      Value<String>? nameVi,
      Value<String?>? iconUrl,
      Value<String?>? colorHex,
      Value<int>? sortOrder,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return TopicsCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameVi: nameVi ?? this.nameVi,
      iconUrl: iconUrl ?? this.iconUrl,
      colorHex: colorHex ?? this.colorHex,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameVi.present) {
      map['name_vi'] = Variable<String>(nameVi.value);
    }
    if (iconUrl.present) {
      map['icon_url'] = Variable<String>(iconUrl.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicsCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameVi: $nameVi, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('colorHex: $colorHex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PathTopicsTable extends PathTopics
    with TableInfo<$PathTopicsTable, PathTopic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PathTopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathIdMeta = const VerificationMeta('pathId');
  @override
  late final GeneratedColumn<String> pathId = GeneratedColumn<String>(
      'path_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _topicIdMeta =
      const VerificationMeta('topicId');
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
      'topic_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isRequiredMeta =
      const VerificationMeta('isRequired');
  @override
  late final GeneratedColumn<bool> isRequired = GeneratedColumn<bool>(
      'is_required', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_required" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _unlockRuleJsonMeta =
      const VerificationMeta('unlockRuleJson');
  @override
  late final GeneratedColumn<String> unlockRuleJson = GeneratedColumn<String>(
      'unlock_rule_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, pathId, topicId, sortOrder, isRequired, unlockRuleJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'path_topics';
  @override
  VerificationContext validateIntegrity(Insertable<PathTopic> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('path_id')) {
      context.handle(_pathIdMeta,
          pathId.isAcceptableOrUnknown(data['path_id']!, _pathIdMeta));
    } else if (isInserting) {
      context.missing(_pathIdMeta);
    }
    if (data.containsKey('topic_id')) {
      context.handle(_topicIdMeta,
          topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta));
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('is_required')) {
      context.handle(
          _isRequiredMeta,
          isRequired.isAcceptableOrUnknown(
              data['is_required']!, _isRequiredMeta));
    }
    if (data.containsKey('unlock_rule_json')) {
      context.handle(
          _unlockRuleJsonMeta,
          unlockRuleJson.isAcceptableOrUnknown(
              data['unlock_rule_json']!, _unlockRuleJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {pathId, topicId},
      ];
  @override
  PathTopic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PathTopic(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      pathId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path_id'])!,
      topicId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}topic_id'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      isRequired: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_required'])!,
      unlockRuleJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}unlock_rule_json']),
    );
  }

  @override
  $PathTopicsTable createAlias(String alias) {
    return $PathTopicsTable(attachedDatabase, alias);
  }
}

class PathTopic extends DataClass implements Insertable<PathTopic> {
  final String id;
  final String pathId;
  final String topicId;
  final int sortOrder;
  final bool isRequired;
  final String? unlockRuleJson;
  const PathTopic(
      {required this.id,
      required this.pathId,
      required this.topicId,
      required this.sortOrder,
      required this.isRequired,
      this.unlockRuleJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['path_id'] = Variable<String>(pathId);
    map['topic_id'] = Variable<String>(topicId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_required'] = Variable<bool>(isRequired);
    if (!nullToAbsent || unlockRuleJson != null) {
      map['unlock_rule_json'] = Variable<String>(unlockRuleJson);
    }
    return map;
  }

  PathTopicsCompanion toCompanion(bool nullToAbsent) {
    return PathTopicsCompanion(
      id: Value(id),
      pathId: Value(pathId),
      topicId: Value(topicId),
      sortOrder: Value(sortOrder),
      isRequired: Value(isRequired),
      unlockRuleJson: unlockRuleJson == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockRuleJson),
    );
  }

  factory PathTopic.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PathTopic(
      id: serializer.fromJson<String>(json['id']),
      pathId: serializer.fromJson<String>(json['pathId']),
      topicId: serializer.fromJson<String>(json['topicId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isRequired: serializer.fromJson<bool>(json['isRequired']),
      unlockRuleJson: serializer.fromJson<String?>(json['unlockRuleJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pathId': serializer.toJson<String>(pathId),
      'topicId': serializer.toJson<String>(topicId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isRequired': serializer.toJson<bool>(isRequired),
      'unlockRuleJson': serializer.toJson<String?>(unlockRuleJson),
    };
  }

  PathTopic copyWith(
          {String? id,
          String? pathId,
          String? topicId,
          int? sortOrder,
          bool? isRequired,
          Value<String?> unlockRuleJson = const Value.absent()}) =>
      PathTopic(
        id: id ?? this.id,
        pathId: pathId ?? this.pathId,
        topicId: topicId ?? this.topicId,
        sortOrder: sortOrder ?? this.sortOrder,
        isRequired: isRequired ?? this.isRequired,
        unlockRuleJson:
            unlockRuleJson.present ? unlockRuleJson.value : this.unlockRuleJson,
      );
  PathTopic copyWithCompanion(PathTopicsCompanion data) {
    return PathTopic(
      id: data.id.present ? data.id.value : this.id,
      pathId: data.pathId.present ? data.pathId.value : this.pathId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isRequired:
          data.isRequired.present ? data.isRequired.value : this.isRequired,
      unlockRuleJson: data.unlockRuleJson.present
          ? data.unlockRuleJson.value
          : this.unlockRuleJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PathTopic(')
          ..write('id: $id, ')
          ..write('pathId: $pathId, ')
          ..write('topicId: $topicId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isRequired: $isRequired, ')
          ..write('unlockRuleJson: $unlockRuleJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, pathId, topicId, sortOrder, isRequired, unlockRuleJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PathTopic &&
          other.id == this.id &&
          other.pathId == this.pathId &&
          other.topicId == this.topicId &&
          other.sortOrder == this.sortOrder &&
          other.isRequired == this.isRequired &&
          other.unlockRuleJson == this.unlockRuleJson);
}

class PathTopicsCompanion extends UpdateCompanion<PathTopic> {
  final Value<String> id;
  final Value<String> pathId;
  final Value<String> topicId;
  final Value<int> sortOrder;
  final Value<bool> isRequired;
  final Value<String?> unlockRuleJson;
  final Value<int> rowid;
  const PathTopicsCompanion({
    this.id = const Value.absent(),
    this.pathId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.unlockRuleJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PathTopicsCompanion.insert({
    required String id,
    required String pathId,
    required String topicId,
    this.sortOrder = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.unlockRuleJson = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        pathId = Value(pathId),
        topicId = Value(topicId);
  static Insertable<PathTopic> custom({
    Expression<String>? id,
    Expression<String>? pathId,
    Expression<String>? topicId,
    Expression<int>? sortOrder,
    Expression<bool>? isRequired,
    Expression<String>? unlockRuleJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pathId != null) 'path_id': pathId,
      if (topicId != null) 'topic_id': topicId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isRequired != null) 'is_required': isRequired,
      if (unlockRuleJson != null) 'unlock_rule_json': unlockRuleJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PathTopicsCompanion copyWith(
      {Value<String>? id,
      Value<String>? pathId,
      Value<String>? topicId,
      Value<int>? sortOrder,
      Value<bool>? isRequired,
      Value<String?>? unlockRuleJson,
      Value<int>? rowid}) {
    return PathTopicsCompanion(
      id: id ?? this.id,
      pathId: pathId ?? this.pathId,
      topicId: topicId ?? this.topicId,
      sortOrder: sortOrder ?? this.sortOrder,
      isRequired: isRequired ?? this.isRequired,
      unlockRuleJson: unlockRuleJson ?? this.unlockRuleJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pathId.present) {
      map['path_id'] = Variable<String>(pathId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isRequired.present) {
      map['is_required'] = Variable<bool>(isRequired.value);
    }
    if (unlockRuleJson.present) {
      map['unlock_rule_json'] = Variable<String>(unlockRuleJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PathTopicsCompanion(')
          ..write('id: $id, ')
          ..write('pathId: $pathId, ')
          ..write('topicId: $topicId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isRequired: $isRequired, ')
          ..write('unlockRuleJson: $unlockRuleJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChildLearningPathsTable extends ChildLearningPaths
    with TableInfo<$ChildLearningPathsTable, ChildLearningPath> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChildLearningPathsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
      'child_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathIdMeta = const VerificationMeta('pathId');
  @override
  late final GeneratedColumn<String> pathId = GeneratedColumn<String>(
      'path_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _currentTopicIdMeta =
      const VerificationMeta('currentTopicId');
  @override
  late final GeneratedColumn<String> currentTopicId = GeneratedColumn<String>(
      'current_topic_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _currentLessonIdMeta =
      const VerificationMeta('currentLessonId');
  @override
  late final GeneratedColumn<String> currentLessonId = GeneratedColumn<String>(
      'current_lesson_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<int> startedAt = GeneratedColumn<int>(
      'started_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<int> completedAt = GeneratedColumn<int>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        pathId,
        status,
        currentTopicId,
        currentLessonId,
        startedAt,
        completedAt,
        updatedAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'child_learning_paths';
  @override
  VerificationContext validateIntegrity(Insertable<ChildLearningPath> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('path_id')) {
      context.handle(_pathIdMeta,
          pathId.isAcceptableOrUnknown(data['path_id']!, _pathIdMeta));
    } else if (isInserting) {
      context.missing(_pathIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('current_topic_id')) {
      context.handle(
          _currentTopicIdMeta,
          currentTopicId.isAcceptableOrUnknown(
              data['current_topic_id']!, _currentTopicIdMeta));
    }
    if (data.containsKey('current_lesson_id')) {
      context.handle(
          _currentLessonIdMeta,
          currentLessonId.isAcceptableOrUnknown(
              data['current_lesson_id']!, _currentLessonIdMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {childId, pathId},
      ];
  @override
  ChildLearningPath map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChildLearningPath(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}child_id'])!,
      pathId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      currentTopicId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}current_topic_id']),
      currentLessonId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}current_lesson_id']),
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}started_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}completed_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $ChildLearningPathsTable createAlias(String alias) {
    return $ChildLearningPathsTable(attachedDatabase, alias);
  }
}

class ChildLearningPath extends DataClass
    implements Insertable<ChildLearningPath> {
  final String id;
  final String childId;
  final String pathId;
  final String status;
  final String? currentTopicId;
  final String? currentLessonId;
  final int startedAt;
  final int? completedAt;
  final int updatedAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const ChildLearningPath(
      {required this.id,
      required this.childId,
      required this.pathId,
      required this.status,
      this.currentTopicId,
      this.currentLessonId,
      required this.startedAt,
      this.completedAt,
      required this.updatedAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['child_id'] = Variable<String>(childId);
    map['path_id'] = Variable<String>(pathId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || currentTopicId != null) {
      map['current_topic_id'] = Variable<String>(currentTopicId);
    }
    if (!nullToAbsent || currentLessonId != null) {
      map['current_lesson_id'] = Variable<String>(currentLessonId);
    }
    map['started_at'] = Variable<int>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<int>(completedAt);
    }
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  ChildLearningPathsCompanion toCompanion(bool nullToAbsent) {
    return ChildLearningPathsCompanion(
      id: Value(id),
      childId: Value(childId),
      pathId: Value(pathId),
      status: Value(status),
      currentTopicId: currentTopicId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentTopicId),
      currentLessonId: currentLessonId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentLessonId),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      updatedAt: Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ChildLearningPath.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChildLearningPath(
      id: serializer.fromJson<String>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      pathId: serializer.fromJson<String>(json['pathId']),
      status: serializer.fromJson<String>(json['status']),
      currentTopicId: serializer.fromJson<String?>(json['currentTopicId']),
      currentLessonId: serializer.fromJson<String?>(json['currentLessonId']),
      startedAt: serializer.fromJson<int>(json['startedAt']),
      completedAt: serializer.fromJson<int?>(json['completedAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'childId': serializer.toJson<String>(childId),
      'pathId': serializer.toJson<String>(pathId),
      'status': serializer.toJson<String>(status),
      'currentTopicId': serializer.toJson<String?>(currentTopicId),
      'currentLessonId': serializer.toJson<String?>(currentLessonId),
      'startedAt': serializer.toJson<int>(startedAt),
      'completedAt': serializer.toJson<int?>(completedAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  ChildLearningPath copyWith(
          {String? id,
          String? childId,
          String? pathId,
          String? status,
          Value<String?> currentTopicId = const Value.absent(),
          Value<String?> currentLessonId = const Value.absent(),
          int? startedAt,
          Value<int?> completedAt = const Value.absent(),
          int? updatedAt,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      ChildLearningPath(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        pathId: pathId ?? this.pathId,
        status: status ?? this.status,
        currentTopicId:
            currentTopicId.present ? currentTopicId.value : this.currentTopicId,
        currentLessonId: currentLessonId.present
            ? currentLessonId.value
            : this.currentLessonId,
        startedAt: startedAt ?? this.startedAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        updatedAt: updatedAt ?? this.updatedAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  ChildLearningPath copyWithCompanion(ChildLearningPathsCompanion data) {
    return ChildLearningPath(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      pathId: data.pathId.present ? data.pathId.value : this.pathId,
      status: data.status.present ? data.status.value : this.status,
      currentTopicId: data.currentTopicId.present
          ? data.currentTopicId.value
          : this.currentTopicId,
      currentLessonId: data.currentLessonId.present
          ? data.currentLessonId.value
          : this.currentLessonId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChildLearningPath(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('pathId: $pathId, ')
          ..write('status: $status, ')
          ..write('currentTopicId: $currentTopicId, ')
          ..write('currentLessonId: $currentLessonId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      childId,
      pathId,
      status,
      currentTopicId,
      currentLessonId,
      startedAt,
      completedAt,
      updatedAt,
      remoteId,
      syncStatus,
      lastSyncedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChildLearningPath &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.pathId == this.pathId &&
          other.status == this.status &&
          other.currentTopicId == this.currentTopicId &&
          other.currentLessonId == this.currentLessonId &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class ChildLearningPathsCompanion extends UpdateCompanion<ChildLearningPath> {
  final Value<String> id;
  final Value<String> childId;
  final Value<String> pathId;
  final Value<String> status;
  final Value<String?> currentTopicId;
  final Value<String?> currentLessonId;
  final Value<int> startedAt;
  final Value<int?> completedAt;
  final Value<int> updatedAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const ChildLearningPathsCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.pathId = const Value.absent(),
    this.status = const Value.absent(),
    this.currentTopicId = const Value.absent(),
    this.currentLessonId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChildLearningPathsCompanion.insert({
    required String id,
    required String childId,
    required String pathId,
    this.status = const Value.absent(),
    this.currentTopicId = const Value.absent(),
    this.currentLessonId = const Value.absent(),
    required int startedAt,
    this.completedAt = const Value.absent(),
    required int updatedAt,
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        childId = Value(childId),
        pathId = Value(pathId),
        startedAt = Value(startedAt),
        updatedAt = Value(updatedAt);
  static Insertable<ChildLearningPath> custom({
    Expression<String>? id,
    Expression<String>? childId,
    Expression<String>? pathId,
    Expression<String>? status,
    Expression<String>? currentTopicId,
    Expression<String>? currentLessonId,
    Expression<int>? startedAt,
    Expression<int>? completedAt,
    Expression<int>? updatedAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (pathId != null) 'path_id': pathId,
      if (status != null) 'status': status,
      if (currentTopicId != null) 'current_topic_id': currentTopicId,
      if (currentLessonId != null) 'current_lesson_id': currentLessonId,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChildLearningPathsCompanion copyWith(
      {Value<String>? id,
      Value<String>? childId,
      Value<String>? pathId,
      Value<String>? status,
      Value<String?>? currentTopicId,
      Value<String?>? currentLessonId,
      Value<int>? startedAt,
      Value<int?>? completedAt,
      Value<int>? updatedAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return ChildLearningPathsCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      pathId: pathId ?? this.pathId,
      status: status ?? this.status,
      currentTopicId: currentTopicId ?? this.currentTopicId,
      currentLessonId: currentLessonId ?? this.currentLessonId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (pathId.present) {
      map['path_id'] = Variable<String>(pathId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (currentTopicId.present) {
      map['current_topic_id'] = Variable<String>(currentTopicId.value);
    }
    if (currentLessonId.present) {
      map['current_lesson_id'] = Variable<String>(currentLessonId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<int>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<int>(completedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChildLearningPathsCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('pathId: $pathId, ')
          ..write('status: $status, ')
          ..write('currentTopicId: $currentTopicId, ')
          ..write('currentLessonId: $currentLessonId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlacementSessionsTable extends PlacementSessions
    with TableInfo<$PlacementSessionsTable, PlacementSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlacementSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
      'child_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('started'));
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _maxScoreMeta =
      const VerificationMeta('maxScore');
  @override
  late final GeneratedColumn<int> maxScore = GeneratedColumn<int>(
      'max_score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _recommendedPathIdMeta =
      const VerificationMeta('recommendedPathId');
  @override
  late final GeneratedColumn<String> recommendedPathId =
      GeneratedColumn<String>('recommended_path_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _selectedPathIdMeta =
      const VerificationMeta('selectedPathId');
  @override
  late final GeneratedColumn<String> selectedPathId = GeneratedColumn<String>(
      'selected_path_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _answersJsonMeta =
      const VerificationMeta('answersJson');
  @override
  late final GeneratedColumn<String> answersJson = GeneratedColumn<String>(
      'answers_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<int> startedAt = GeneratedColumn<int>(
      'started_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<int> completedAt = GeneratedColumn<int>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        status,
        score,
        maxScore,
        recommendedPathId,
        selectedPathId,
        answersJson,
        startedAt,
        completedAt,
        updatedAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'placement_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<PlacementSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    if (data.containsKey('max_score')) {
      context.handle(_maxScoreMeta,
          maxScore.isAcceptableOrUnknown(data['max_score']!, _maxScoreMeta));
    }
    if (data.containsKey('recommended_path_id')) {
      context.handle(
          _recommendedPathIdMeta,
          recommendedPathId.isAcceptableOrUnknown(
              data['recommended_path_id']!, _recommendedPathIdMeta));
    }
    if (data.containsKey('selected_path_id')) {
      context.handle(
          _selectedPathIdMeta,
          selectedPathId.isAcceptableOrUnknown(
              data['selected_path_id']!, _selectedPathIdMeta));
    }
    if (data.containsKey('answers_json')) {
      context.handle(
          _answersJsonMeta,
          answersJson.isAcceptableOrUnknown(
              data['answers_json']!, _answersJsonMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlacementSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlacementSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}child_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score'])!,
      maxScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_score'])!,
      recommendedPathId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}recommended_path_id']),
      selectedPathId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}selected_path_id']),
      answersJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answers_json']),
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}started_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}completed_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $PlacementSessionsTable createAlias(String alias) {
    return $PlacementSessionsTable(attachedDatabase, alias);
  }
}

class PlacementSession extends DataClass
    implements Insertable<PlacementSession> {
  final String id;
  final String childId;
  final String status;
  final int score;
  final int maxScore;
  final String? recommendedPathId;
  final String? selectedPathId;
  final String? answersJson;
  final int startedAt;
  final int? completedAt;
  final int updatedAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const PlacementSession(
      {required this.id,
      required this.childId,
      required this.status,
      required this.score,
      required this.maxScore,
      this.recommendedPathId,
      this.selectedPathId,
      this.answersJson,
      required this.startedAt,
      this.completedAt,
      required this.updatedAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['child_id'] = Variable<String>(childId);
    map['status'] = Variable<String>(status);
    map['score'] = Variable<int>(score);
    map['max_score'] = Variable<int>(maxScore);
    if (!nullToAbsent || recommendedPathId != null) {
      map['recommended_path_id'] = Variable<String>(recommendedPathId);
    }
    if (!nullToAbsent || selectedPathId != null) {
      map['selected_path_id'] = Variable<String>(selectedPathId);
    }
    if (!nullToAbsent || answersJson != null) {
      map['answers_json'] = Variable<String>(answersJson);
    }
    map['started_at'] = Variable<int>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<int>(completedAt);
    }
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  PlacementSessionsCompanion toCompanion(bool nullToAbsent) {
    return PlacementSessionsCompanion(
      id: Value(id),
      childId: Value(childId),
      status: Value(status),
      score: Value(score),
      maxScore: Value(maxScore),
      recommendedPathId: recommendedPathId == null && nullToAbsent
          ? const Value.absent()
          : Value(recommendedPathId),
      selectedPathId: selectedPathId == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedPathId),
      answersJson: answersJson == null && nullToAbsent
          ? const Value.absent()
          : Value(answersJson),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      updatedAt: Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory PlacementSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlacementSession(
      id: serializer.fromJson<String>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      status: serializer.fromJson<String>(json['status']),
      score: serializer.fromJson<int>(json['score']),
      maxScore: serializer.fromJson<int>(json['maxScore']),
      recommendedPathId:
          serializer.fromJson<String?>(json['recommendedPathId']),
      selectedPathId: serializer.fromJson<String?>(json['selectedPathId']),
      answersJson: serializer.fromJson<String?>(json['answersJson']),
      startedAt: serializer.fromJson<int>(json['startedAt']),
      completedAt: serializer.fromJson<int?>(json['completedAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'childId': serializer.toJson<String>(childId),
      'status': serializer.toJson<String>(status),
      'score': serializer.toJson<int>(score),
      'maxScore': serializer.toJson<int>(maxScore),
      'recommendedPathId': serializer.toJson<String?>(recommendedPathId),
      'selectedPathId': serializer.toJson<String?>(selectedPathId),
      'answersJson': serializer.toJson<String?>(answersJson),
      'startedAt': serializer.toJson<int>(startedAt),
      'completedAt': serializer.toJson<int?>(completedAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  PlacementSession copyWith(
          {String? id,
          String? childId,
          String? status,
          int? score,
          int? maxScore,
          Value<String?> recommendedPathId = const Value.absent(),
          Value<String?> selectedPathId = const Value.absent(),
          Value<String?> answersJson = const Value.absent(),
          int? startedAt,
          Value<int?> completedAt = const Value.absent(),
          int? updatedAt,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      PlacementSession(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        status: status ?? this.status,
        score: score ?? this.score,
        maxScore: maxScore ?? this.maxScore,
        recommendedPathId: recommendedPathId.present
            ? recommendedPathId.value
            : this.recommendedPathId,
        selectedPathId:
            selectedPathId.present ? selectedPathId.value : this.selectedPathId,
        answersJson: answersJson.present ? answersJson.value : this.answersJson,
        startedAt: startedAt ?? this.startedAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        updatedAt: updatedAt ?? this.updatedAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  PlacementSession copyWithCompanion(PlacementSessionsCompanion data) {
    return PlacementSession(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      status: data.status.present ? data.status.value : this.status,
      score: data.score.present ? data.score.value : this.score,
      maxScore: data.maxScore.present ? data.maxScore.value : this.maxScore,
      recommendedPathId: data.recommendedPathId.present
          ? data.recommendedPathId.value
          : this.recommendedPathId,
      selectedPathId: data.selectedPathId.present
          ? data.selectedPathId.value
          : this.selectedPathId,
      answersJson:
          data.answersJson.present ? data.answersJson.value : this.answersJson,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlacementSession(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('status: $status, ')
          ..write('score: $score, ')
          ..write('maxScore: $maxScore, ')
          ..write('recommendedPathId: $recommendedPathId, ')
          ..write('selectedPathId: $selectedPathId, ')
          ..write('answersJson: $answersJson, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      childId,
      status,
      score,
      maxScore,
      recommendedPathId,
      selectedPathId,
      answersJson,
      startedAt,
      completedAt,
      updatedAt,
      remoteId,
      syncStatus,
      lastSyncedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlacementSession &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.status == this.status &&
          other.score == this.score &&
          other.maxScore == this.maxScore &&
          other.recommendedPathId == this.recommendedPathId &&
          other.selectedPathId == this.selectedPathId &&
          other.answersJson == this.answersJson &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class PlacementSessionsCompanion extends UpdateCompanion<PlacementSession> {
  final Value<String> id;
  final Value<String> childId;
  final Value<String> status;
  final Value<int> score;
  final Value<int> maxScore;
  final Value<String?> recommendedPathId;
  final Value<String?> selectedPathId;
  final Value<String?> answersJson;
  final Value<int> startedAt;
  final Value<int?> completedAt;
  final Value<int> updatedAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const PlacementSessionsCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.status = const Value.absent(),
    this.score = const Value.absent(),
    this.maxScore = const Value.absent(),
    this.recommendedPathId = const Value.absent(),
    this.selectedPathId = const Value.absent(),
    this.answersJson = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlacementSessionsCompanion.insert({
    required String id,
    required String childId,
    this.status = const Value.absent(),
    this.score = const Value.absent(),
    this.maxScore = const Value.absent(),
    this.recommendedPathId = const Value.absent(),
    this.selectedPathId = const Value.absent(),
    this.answersJson = const Value.absent(),
    required int startedAt,
    this.completedAt = const Value.absent(),
    required int updatedAt,
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        childId = Value(childId),
        startedAt = Value(startedAt),
        updatedAt = Value(updatedAt);
  static Insertable<PlacementSession> custom({
    Expression<String>? id,
    Expression<String>? childId,
    Expression<String>? status,
    Expression<int>? score,
    Expression<int>? maxScore,
    Expression<String>? recommendedPathId,
    Expression<String>? selectedPathId,
    Expression<String>? answersJson,
    Expression<int>? startedAt,
    Expression<int>? completedAt,
    Expression<int>? updatedAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (status != null) 'status': status,
      if (score != null) 'score': score,
      if (maxScore != null) 'max_score': maxScore,
      if (recommendedPathId != null) 'recommended_path_id': recommendedPathId,
      if (selectedPathId != null) 'selected_path_id': selectedPathId,
      if (answersJson != null) 'answers_json': answersJson,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlacementSessionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? childId,
      Value<String>? status,
      Value<int>? score,
      Value<int>? maxScore,
      Value<String?>? recommendedPathId,
      Value<String?>? selectedPathId,
      Value<String?>? answersJson,
      Value<int>? startedAt,
      Value<int?>? completedAt,
      Value<int>? updatedAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return PlacementSessionsCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      status: status ?? this.status,
      score: score ?? this.score,
      maxScore: maxScore ?? this.maxScore,
      recommendedPathId: recommendedPathId ?? this.recommendedPathId,
      selectedPathId: selectedPathId ?? this.selectedPathId,
      answersJson: answersJson ?? this.answersJson,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (maxScore.present) {
      map['max_score'] = Variable<int>(maxScore.value);
    }
    if (recommendedPathId.present) {
      map['recommended_path_id'] = Variable<String>(recommendedPathId.value);
    }
    if (selectedPathId.present) {
      map['selected_path_id'] = Variable<String>(selectedPathId.value);
    }
    if (answersJson.present) {
      map['answers_json'] = Variable<String>(answersJson.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<int>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<int>(completedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlacementSessionsCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('status: $status, ')
          ..write('score: $score, ')
          ..write('maxScore: $maxScore, ')
          ..write('recommendedPathId: $recommendedPathId, ')
          ..write('selectedPathId: $selectedPathId, ')
          ..write('answersJson: $answersJson, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LessonsTable extends Lessons with TableInfo<$LessonsTable, Lesson> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _topicIdMeta =
      const VerificationMeta('topicId');
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
      'topic_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleEnMeta =
      const VerificationMeta('titleEn');
  @override
  late final GeneratedColumn<String> titleEn = GeneratedColumn<String>(
      'title_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleViMeta =
      const VerificationMeta('titleVi');
  @override
  late final GeneratedColumn<String> titleVi = GeneratedColumn<String>(
      'title_vi', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionViMeta =
      const VerificationMeta('descriptionVi');
  @override
  late final GeneratedColumn<String> descriptionVi = GeneratedColumn<String>(
      'description_vi', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _minXpRequiredMeta =
      const VerificationMeta('minXpRequired');
  @override
  late final GeneratedColumn<int> minXpRequired = GeneratedColumn<int>(
      'min_xp_required', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isPublishedMeta =
      const VerificationMeta('isPublished');
  @override
  late final GeneratedColumn<bool> isPublished = GeneratedColumn<bool>(
      'is_published', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_published" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _thumbnailUrlMeta =
      const VerificationMeta('thumbnailUrl');
  @override
  late final GeneratedColumn<String> thumbnailUrl = GeneratedColumn<String>(
      'thumbnail_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _vocabularyCountMeta =
      const VerificationMeta('vocabularyCount');
  @override
  late final GeneratedColumn<int> vocabularyCount = GeneratedColumn<int>(
      'vocabulary_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _questionCountMeta =
      const VerificationMeta('questionCount');
  @override
  late final GeneratedColumn<int> questionCount = GeneratedColumn<int>(
      'question_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _xpRewardMeta =
      const VerificationMeta('xpReward');
  @override
  late final GeneratedColumn<int> xpReward = GeneratedColumn<int>(
      'xp_reward', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(50));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        topicId,
        titleEn,
        titleVi,
        descriptionVi,
        level,
        sortOrder,
        minXpRequired,
        isPublished,
        thumbnailUrl,
        vocabularyCount,
        questionCount,
        xpReward
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lessons';
  @override
  VerificationContext validateIntegrity(Insertable<Lesson> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('topic_id')) {
      context.handle(_topicIdMeta,
          topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta));
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('title_en')) {
      context.handle(_titleEnMeta,
          titleEn.isAcceptableOrUnknown(data['title_en']!, _titleEnMeta));
    } else if (isInserting) {
      context.missing(_titleEnMeta);
    }
    if (data.containsKey('title_vi')) {
      context.handle(_titleViMeta,
          titleVi.isAcceptableOrUnknown(data['title_vi']!, _titleViMeta));
    } else if (isInserting) {
      context.missing(_titleViMeta);
    }
    if (data.containsKey('description_vi')) {
      context.handle(
          _descriptionViMeta,
          descriptionVi.isAcceptableOrUnknown(
              data['description_vi']!, _descriptionViMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('min_xp_required')) {
      context.handle(
          _minXpRequiredMeta,
          minXpRequired.isAcceptableOrUnknown(
              data['min_xp_required']!, _minXpRequiredMeta));
    }
    if (data.containsKey('is_published')) {
      context.handle(
          _isPublishedMeta,
          isPublished.isAcceptableOrUnknown(
              data['is_published']!, _isPublishedMeta));
    }
    if (data.containsKey('thumbnail_url')) {
      context.handle(
          _thumbnailUrlMeta,
          thumbnailUrl.isAcceptableOrUnknown(
              data['thumbnail_url']!, _thumbnailUrlMeta));
    }
    if (data.containsKey('vocabulary_count')) {
      context.handle(
          _vocabularyCountMeta,
          vocabularyCount.isAcceptableOrUnknown(
              data['vocabulary_count']!, _vocabularyCountMeta));
    }
    if (data.containsKey('question_count')) {
      context.handle(
          _questionCountMeta,
          questionCount.isAcceptableOrUnknown(
              data['question_count']!, _questionCountMeta));
    }
    if (data.containsKey('xp_reward')) {
      context.handle(_xpRewardMeta,
          xpReward.isAcceptableOrUnknown(data['xp_reward']!, _xpRewardMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lesson map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lesson(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      topicId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}topic_id'])!,
      titleEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title_en'])!,
      titleVi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title_vi'])!,
      descriptionVi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description_vi']),
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      minXpRequired: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_xp_required'])!,
      isPublished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_published'])!,
      thumbnailUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumbnail_url']),
      vocabularyCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vocabulary_count'])!,
      questionCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_count'])!,
      xpReward: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp_reward'])!,
    );
  }

  @override
  $LessonsTable createAlias(String alias) {
    return $LessonsTable(attachedDatabase, alias);
  }
}

class Lesson extends DataClass implements Insertable<Lesson> {
  final String id;
  final String topicId;
  final String titleEn;
  final String titleVi;
  final String? descriptionVi;
  final int level;
  final int sortOrder;
  final int minXpRequired;
  final bool isPublished;
  final String? thumbnailUrl;
  final int vocabularyCount;
  final int questionCount;
  final int xpReward;
  const Lesson(
      {required this.id,
      required this.topicId,
      required this.titleEn,
      required this.titleVi,
      this.descriptionVi,
      required this.level,
      required this.sortOrder,
      required this.minXpRequired,
      required this.isPublished,
      this.thumbnailUrl,
      required this.vocabularyCount,
      required this.questionCount,
      required this.xpReward});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['topic_id'] = Variable<String>(topicId);
    map['title_en'] = Variable<String>(titleEn);
    map['title_vi'] = Variable<String>(titleVi);
    if (!nullToAbsent || descriptionVi != null) {
      map['description_vi'] = Variable<String>(descriptionVi);
    }
    map['level'] = Variable<int>(level);
    map['sort_order'] = Variable<int>(sortOrder);
    map['min_xp_required'] = Variable<int>(minXpRequired);
    map['is_published'] = Variable<bool>(isPublished);
    if (!nullToAbsent || thumbnailUrl != null) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl);
    }
    map['vocabulary_count'] = Variable<int>(vocabularyCount);
    map['question_count'] = Variable<int>(questionCount);
    map['xp_reward'] = Variable<int>(xpReward);
    return map;
  }

  LessonsCompanion toCompanion(bool nullToAbsent) {
    return LessonsCompanion(
      id: Value(id),
      topicId: Value(topicId),
      titleEn: Value(titleEn),
      titleVi: Value(titleVi),
      descriptionVi: descriptionVi == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionVi),
      level: Value(level),
      sortOrder: Value(sortOrder),
      minXpRequired: Value(minXpRequired),
      isPublished: Value(isPublished),
      thumbnailUrl: thumbnailUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailUrl),
      vocabularyCount: Value(vocabularyCount),
      questionCount: Value(questionCount),
      xpReward: Value(xpReward),
    );
  }

  factory Lesson.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lesson(
      id: serializer.fromJson<String>(json['id']),
      topicId: serializer.fromJson<String>(json['topicId']),
      titleEn: serializer.fromJson<String>(json['titleEn']),
      titleVi: serializer.fromJson<String>(json['titleVi']),
      descriptionVi: serializer.fromJson<String?>(json['descriptionVi']),
      level: serializer.fromJson<int>(json['level']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      minXpRequired: serializer.fromJson<int>(json['minXpRequired']),
      isPublished: serializer.fromJson<bool>(json['isPublished']),
      thumbnailUrl: serializer.fromJson<String?>(json['thumbnailUrl']),
      vocabularyCount: serializer.fromJson<int>(json['vocabularyCount']),
      questionCount: serializer.fromJson<int>(json['questionCount']),
      xpReward: serializer.fromJson<int>(json['xpReward']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'topicId': serializer.toJson<String>(topicId),
      'titleEn': serializer.toJson<String>(titleEn),
      'titleVi': serializer.toJson<String>(titleVi),
      'descriptionVi': serializer.toJson<String?>(descriptionVi),
      'level': serializer.toJson<int>(level),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'minXpRequired': serializer.toJson<int>(minXpRequired),
      'isPublished': serializer.toJson<bool>(isPublished),
      'thumbnailUrl': serializer.toJson<String?>(thumbnailUrl),
      'vocabularyCount': serializer.toJson<int>(vocabularyCount),
      'questionCount': serializer.toJson<int>(questionCount),
      'xpReward': serializer.toJson<int>(xpReward),
    };
  }

  Lesson copyWith(
          {String? id,
          String? topicId,
          String? titleEn,
          String? titleVi,
          Value<String?> descriptionVi = const Value.absent(),
          int? level,
          int? sortOrder,
          int? minXpRequired,
          bool? isPublished,
          Value<String?> thumbnailUrl = const Value.absent(),
          int? vocabularyCount,
          int? questionCount,
          int? xpReward}) =>
      Lesson(
        id: id ?? this.id,
        topicId: topicId ?? this.topicId,
        titleEn: titleEn ?? this.titleEn,
        titleVi: titleVi ?? this.titleVi,
        descriptionVi:
            descriptionVi.present ? descriptionVi.value : this.descriptionVi,
        level: level ?? this.level,
        sortOrder: sortOrder ?? this.sortOrder,
        minXpRequired: minXpRequired ?? this.minXpRequired,
        isPublished: isPublished ?? this.isPublished,
        thumbnailUrl:
            thumbnailUrl.present ? thumbnailUrl.value : this.thumbnailUrl,
        vocabularyCount: vocabularyCount ?? this.vocabularyCount,
        questionCount: questionCount ?? this.questionCount,
        xpReward: xpReward ?? this.xpReward,
      );
  Lesson copyWithCompanion(LessonsCompanion data) {
    return Lesson(
      id: data.id.present ? data.id.value : this.id,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      titleEn: data.titleEn.present ? data.titleEn.value : this.titleEn,
      titleVi: data.titleVi.present ? data.titleVi.value : this.titleVi,
      descriptionVi: data.descriptionVi.present
          ? data.descriptionVi.value
          : this.descriptionVi,
      level: data.level.present ? data.level.value : this.level,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      minXpRequired: data.minXpRequired.present
          ? data.minXpRequired.value
          : this.minXpRequired,
      isPublished:
          data.isPublished.present ? data.isPublished.value : this.isPublished,
      thumbnailUrl: data.thumbnailUrl.present
          ? data.thumbnailUrl.value
          : this.thumbnailUrl,
      vocabularyCount: data.vocabularyCount.present
          ? data.vocabularyCount.value
          : this.vocabularyCount,
      questionCount: data.questionCount.present
          ? data.questionCount.value
          : this.questionCount,
      xpReward: data.xpReward.present ? data.xpReward.value : this.xpReward,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Lesson(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleVi: $titleVi, ')
          ..write('descriptionVi: $descriptionVi, ')
          ..write('level: $level, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('minXpRequired: $minXpRequired, ')
          ..write('isPublished: $isPublished, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('vocabularyCount: $vocabularyCount, ')
          ..write('questionCount: $questionCount, ')
          ..write('xpReward: $xpReward')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      topicId,
      titleEn,
      titleVi,
      descriptionVi,
      level,
      sortOrder,
      minXpRequired,
      isPublished,
      thumbnailUrl,
      vocabularyCount,
      questionCount,
      xpReward);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lesson &&
          other.id == this.id &&
          other.topicId == this.topicId &&
          other.titleEn == this.titleEn &&
          other.titleVi == this.titleVi &&
          other.descriptionVi == this.descriptionVi &&
          other.level == this.level &&
          other.sortOrder == this.sortOrder &&
          other.minXpRequired == this.minXpRequired &&
          other.isPublished == this.isPublished &&
          other.thumbnailUrl == this.thumbnailUrl &&
          other.vocabularyCount == this.vocabularyCount &&
          other.questionCount == this.questionCount &&
          other.xpReward == this.xpReward);
}

class LessonsCompanion extends UpdateCompanion<Lesson> {
  final Value<String> id;
  final Value<String> topicId;
  final Value<String> titleEn;
  final Value<String> titleVi;
  final Value<String?> descriptionVi;
  final Value<int> level;
  final Value<int> sortOrder;
  final Value<int> minXpRequired;
  final Value<bool> isPublished;
  final Value<String?> thumbnailUrl;
  final Value<int> vocabularyCount;
  final Value<int> questionCount;
  final Value<int> xpReward;
  final Value<int> rowid;
  const LessonsCompanion({
    this.id = const Value.absent(),
    this.topicId = const Value.absent(),
    this.titleEn = const Value.absent(),
    this.titleVi = const Value.absent(),
    this.descriptionVi = const Value.absent(),
    this.level = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.minXpRequired = const Value.absent(),
    this.isPublished = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.vocabularyCount = const Value.absent(),
    this.questionCount = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LessonsCompanion.insert({
    required String id,
    required String topicId,
    required String titleEn,
    required String titleVi,
    this.descriptionVi = const Value.absent(),
    this.level = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.minXpRequired = const Value.absent(),
    this.isPublished = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.vocabularyCount = const Value.absent(),
    this.questionCount = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        topicId = Value(topicId),
        titleEn = Value(titleEn),
        titleVi = Value(titleVi);
  static Insertable<Lesson> custom({
    Expression<String>? id,
    Expression<String>? topicId,
    Expression<String>? titleEn,
    Expression<String>? titleVi,
    Expression<String>? descriptionVi,
    Expression<int>? level,
    Expression<int>? sortOrder,
    Expression<int>? minXpRequired,
    Expression<bool>? isPublished,
    Expression<String>? thumbnailUrl,
    Expression<int>? vocabularyCount,
    Expression<int>? questionCount,
    Expression<int>? xpReward,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (topicId != null) 'topic_id': topicId,
      if (titleEn != null) 'title_en': titleEn,
      if (titleVi != null) 'title_vi': titleVi,
      if (descriptionVi != null) 'description_vi': descriptionVi,
      if (level != null) 'level': level,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (minXpRequired != null) 'min_xp_required': minXpRequired,
      if (isPublished != null) 'is_published': isPublished,
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
      if (vocabularyCount != null) 'vocabulary_count': vocabularyCount,
      if (questionCount != null) 'question_count': questionCount,
      if (xpReward != null) 'xp_reward': xpReward,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LessonsCompanion copyWith(
      {Value<String>? id,
      Value<String>? topicId,
      Value<String>? titleEn,
      Value<String>? titleVi,
      Value<String?>? descriptionVi,
      Value<int>? level,
      Value<int>? sortOrder,
      Value<int>? minXpRequired,
      Value<bool>? isPublished,
      Value<String?>? thumbnailUrl,
      Value<int>? vocabularyCount,
      Value<int>? questionCount,
      Value<int>? xpReward,
      Value<int>? rowid}) {
    return LessonsCompanion(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      titleEn: titleEn ?? this.titleEn,
      titleVi: titleVi ?? this.titleVi,
      descriptionVi: descriptionVi ?? this.descriptionVi,
      level: level ?? this.level,
      sortOrder: sortOrder ?? this.sortOrder,
      minXpRequired: minXpRequired ?? this.minXpRequired,
      isPublished: isPublished ?? this.isPublished,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      vocabularyCount: vocabularyCount ?? this.vocabularyCount,
      questionCount: questionCount ?? this.questionCount,
      xpReward: xpReward ?? this.xpReward,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (titleEn.present) {
      map['title_en'] = Variable<String>(titleEn.value);
    }
    if (titleVi.present) {
      map['title_vi'] = Variable<String>(titleVi.value);
    }
    if (descriptionVi.present) {
      map['description_vi'] = Variable<String>(descriptionVi.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (minXpRequired.present) {
      map['min_xp_required'] = Variable<int>(minXpRequired.value);
    }
    if (isPublished.present) {
      map['is_published'] = Variable<bool>(isPublished.value);
    }
    if (thumbnailUrl.present) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl.value);
    }
    if (vocabularyCount.present) {
      map['vocabulary_count'] = Variable<int>(vocabularyCount.value);
    }
    if (questionCount.present) {
      map['question_count'] = Variable<int>(questionCount.value);
    }
    if (xpReward.present) {
      map['xp_reward'] = Variable<int>(xpReward.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonsCompanion(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleVi: $titleVi, ')
          ..write('descriptionVi: $descriptionVi, ')
          ..write('level: $level, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('minXpRequired: $minXpRequired, ')
          ..write('isPublished: $isPublished, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('vocabularyCount: $vocabularyCount, ')
          ..write('questionCount: $questionCount, ')
          ..write('xpReward: $xpReward, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuizQuestionsTable extends QuizQuestions
    with TableInfo<$QuizQuestionsTable, QuizQuestion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizQuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lessonIdMeta =
      const VerificationMeta('lessonId');
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
      'lesson_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quizTypeMeta =
      const VerificationMeta('quizType');
  @override
  late final GeneratedColumn<String> quizType = GeneratedColumn<String>(
      'quiz_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
      'prompt', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentJsonMeta =
      const VerificationMeta('contentJson');
  @override
  late final GeneratedColumn<String> contentJson = GeneratedColumn<String>(
      'content_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<int> difficulty = GeneratedColumn<int>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _xpRewardMeta =
      const VerificationMeta('xpReward');
  @override
  late final GeneratedColumn<int> xpReward = GeneratedColumn<int>(
      'xp_reward', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(10));
  static const VerificationMeta _timeLimitSecMeta =
      const VerificationMeta('timeLimitSec');
  @override
  late final GeneratedColumn<int> timeLimitSec = GeneratedColumn<int>(
      'time_limit_sec', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lessonId,
        quizType,
        prompt,
        contentJson,
        difficulty,
        xpReward,
        timeLimitSec,
        sortOrder,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quiz_questions';
  @override
  VerificationContext validateIntegrity(Insertable<QuizQuestion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('lesson_id')) {
      context.handle(_lessonIdMeta,
          lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta));
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('quiz_type')) {
      context.handle(_quizTypeMeta,
          quizType.isAcceptableOrUnknown(data['quiz_type']!, _quizTypeMeta));
    } else if (isInserting) {
      context.missing(_quizTypeMeta);
    }
    if (data.containsKey('prompt')) {
      context.handle(_promptMeta,
          prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta));
    }
    if (data.containsKey('content_json')) {
      context.handle(
          _contentJsonMeta,
          contentJson.isAcceptableOrUnknown(
              data['content_json']!, _contentJsonMeta));
    } else if (isInserting) {
      context.missing(_contentJsonMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    }
    if (data.containsKey('xp_reward')) {
      context.handle(_xpRewardMeta,
          xpReward.isAcceptableOrUnknown(data['xp_reward']!, _xpRewardMeta));
    }
    if (data.containsKey('time_limit_sec')) {
      context.handle(
          _timeLimitSecMeta,
          timeLimitSec.isAcceptableOrUnknown(
              data['time_limit_sec']!, _timeLimitSecMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizQuestion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizQuestion(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lessonId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lesson_id'])!,
      quizType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}quiz_type'])!,
      prompt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prompt']),
      contentJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_json'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}difficulty'])!,
      xpReward: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp_reward'])!,
      timeLimitSec: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}time_limit_sec']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $QuizQuestionsTable createAlias(String alias) {
    return $QuizQuestionsTable(attachedDatabase, alias);
  }
}

class QuizQuestion extends DataClass implements Insertable<QuizQuestion> {
  final String id;
  final String lessonId;
  final String quizType;
  final String? prompt;
  final String contentJson;
  final int difficulty;
  final int xpReward;
  final int? timeLimitSec;
  final int sortOrder;
  final bool isActive;
  const QuizQuestion(
      {required this.id,
      required this.lessonId,
      required this.quizType,
      this.prompt,
      required this.contentJson,
      required this.difficulty,
      required this.xpReward,
      this.timeLimitSec,
      required this.sortOrder,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['lesson_id'] = Variable<String>(lessonId);
    map['quiz_type'] = Variable<String>(quizType);
    if (!nullToAbsent || prompt != null) {
      map['prompt'] = Variable<String>(prompt);
    }
    map['content_json'] = Variable<String>(contentJson);
    map['difficulty'] = Variable<int>(difficulty);
    map['xp_reward'] = Variable<int>(xpReward);
    if (!nullToAbsent || timeLimitSec != null) {
      map['time_limit_sec'] = Variable<int>(timeLimitSec);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  QuizQuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuizQuestionsCompanion(
      id: Value(id),
      lessonId: Value(lessonId),
      quizType: Value(quizType),
      prompt:
          prompt == null && nullToAbsent ? const Value.absent() : Value(prompt),
      contentJson: Value(contentJson),
      difficulty: Value(difficulty),
      xpReward: Value(xpReward),
      timeLimitSec: timeLimitSec == null && nullToAbsent
          ? const Value.absent()
          : Value(timeLimitSec),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
    );
  }

  factory QuizQuestion.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizQuestion(
      id: serializer.fromJson<String>(json['id']),
      lessonId: serializer.fromJson<String>(json['lessonId']),
      quizType: serializer.fromJson<String>(json['quizType']),
      prompt: serializer.fromJson<String?>(json['prompt']),
      contentJson: serializer.fromJson<String>(json['contentJson']),
      difficulty: serializer.fromJson<int>(json['difficulty']),
      xpReward: serializer.fromJson<int>(json['xpReward']),
      timeLimitSec: serializer.fromJson<int?>(json['timeLimitSec']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lessonId': serializer.toJson<String>(lessonId),
      'quizType': serializer.toJson<String>(quizType),
      'prompt': serializer.toJson<String?>(prompt),
      'contentJson': serializer.toJson<String>(contentJson),
      'difficulty': serializer.toJson<int>(difficulty),
      'xpReward': serializer.toJson<int>(xpReward),
      'timeLimitSec': serializer.toJson<int?>(timeLimitSec),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  QuizQuestion copyWith(
          {String? id,
          String? lessonId,
          String? quizType,
          Value<String?> prompt = const Value.absent(),
          String? contentJson,
          int? difficulty,
          int? xpReward,
          Value<int?> timeLimitSec = const Value.absent(),
          int? sortOrder,
          bool? isActive}) =>
      QuizQuestion(
        id: id ?? this.id,
        lessonId: lessonId ?? this.lessonId,
        quizType: quizType ?? this.quizType,
        prompt: prompt.present ? prompt.value : this.prompt,
        contentJson: contentJson ?? this.contentJson,
        difficulty: difficulty ?? this.difficulty,
        xpReward: xpReward ?? this.xpReward,
        timeLimitSec:
            timeLimitSec.present ? timeLimitSec.value : this.timeLimitSec,
        sortOrder: sortOrder ?? this.sortOrder,
        isActive: isActive ?? this.isActive,
      );
  QuizQuestion copyWithCompanion(QuizQuestionsCompanion data) {
    return QuizQuestion(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      quizType: data.quizType.present ? data.quizType.value : this.quizType,
      prompt: data.prompt.present ? data.prompt.value : this.prompt,
      contentJson:
          data.contentJson.present ? data.contentJson.value : this.contentJson,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      xpReward: data.xpReward.present ? data.xpReward.value : this.xpReward,
      timeLimitSec: data.timeLimitSec.present
          ? data.timeLimitSec.value
          : this.timeLimitSec,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizQuestion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('quizType: $quizType, ')
          ..write('prompt: $prompt, ')
          ..write('contentJson: $contentJson, ')
          ..write('difficulty: $difficulty, ')
          ..write('xpReward: $xpReward, ')
          ..write('timeLimitSec: $timeLimitSec, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lessonId, quizType, prompt, contentJson,
      difficulty, xpReward, timeLimitSec, sortOrder, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizQuestion &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.quizType == this.quizType &&
          other.prompt == this.prompt &&
          other.contentJson == this.contentJson &&
          other.difficulty == this.difficulty &&
          other.xpReward == this.xpReward &&
          other.timeLimitSec == this.timeLimitSec &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive);
}

class QuizQuestionsCompanion extends UpdateCompanion<QuizQuestion> {
  final Value<String> id;
  final Value<String> lessonId;
  final Value<String> quizType;
  final Value<String?> prompt;
  final Value<String> contentJson;
  final Value<int> difficulty;
  final Value<int> xpReward;
  final Value<int?> timeLimitSec;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<int> rowid;
  const QuizQuestionsCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.quizType = const Value.absent(),
    this.prompt = const Value.absent(),
    this.contentJson = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.timeLimitSec = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuizQuestionsCompanion.insert({
    required String id,
    required String lessonId,
    required String quizType,
    this.prompt = const Value.absent(),
    required String contentJson,
    this.difficulty = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.timeLimitSec = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        lessonId = Value(lessonId),
        quizType = Value(quizType),
        contentJson = Value(contentJson);
  static Insertable<QuizQuestion> custom({
    Expression<String>? id,
    Expression<String>? lessonId,
    Expression<String>? quizType,
    Expression<String>? prompt,
    Expression<String>? contentJson,
    Expression<int>? difficulty,
    Expression<int>? xpReward,
    Expression<int>? timeLimitSec,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (quizType != null) 'quiz_type': quizType,
      if (prompt != null) 'prompt': prompt,
      if (contentJson != null) 'content_json': contentJson,
      if (difficulty != null) 'difficulty': difficulty,
      if (xpReward != null) 'xp_reward': xpReward,
      if (timeLimitSec != null) 'time_limit_sec': timeLimitSec,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuizQuestionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? lessonId,
      Value<String>? quizType,
      Value<String?>? prompt,
      Value<String>? contentJson,
      Value<int>? difficulty,
      Value<int>? xpReward,
      Value<int?>? timeLimitSec,
      Value<int>? sortOrder,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return QuizQuestionsCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      quizType: quizType ?? this.quizType,
      prompt: prompt ?? this.prompt,
      contentJson: contentJson ?? this.contentJson,
      difficulty: difficulty ?? this.difficulty,
      xpReward: xpReward ?? this.xpReward,
      timeLimitSec: timeLimitSec ?? this.timeLimitSec,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    if (quizType.present) {
      map['quiz_type'] = Variable<String>(quizType.value);
    }
    if (prompt.present) {
      map['prompt'] = Variable<String>(prompt.value);
    }
    if (contentJson.present) {
      map['content_json'] = Variable<String>(contentJson.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(difficulty.value);
    }
    if (xpReward.present) {
      map['xp_reward'] = Variable<int>(xpReward.value);
    }
    if (timeLimitSec.present) {
      map['time_limit_sec'] = Variable<int>(timeLimitSec.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizQuestionsCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('quizType: $quizType, ')
          ..write('prompt: $prompt, ')
          ..write('contentJson: $contentJson, ')
          ..write('difficulty: $difficulty, ')
          ..write('xpReward: $xpReward, ')
          ..write('timeLimitSec: $timeLimitSec, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VocabularyItemsTable extends VocabularyItems
    with TableInfo<$VocabularyItemsTable, VocabularyItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabularyItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lessonIdMeta =
      const VerificationMeta('lessonId');
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
      'lesson_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneticMeta =
      const VerificationMeta('phonetic');
  @override
  late final GeneratedColumn<String> phonetic = GeneratedColumn<String>(
      'phonetic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _translationViMeta =
      const VerificationMeta('translationVi');
  @override
  late final GeneratedColumn<String> translationVi = GeneratedColumn<String>(
      'translation_vi', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _audioUrlMeta =
      const VerificationMeta('audioUrl');
  @override
  late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>(
      'audio_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _partOfSpeechMeta =
      const VerificationMeta('partOfSpeech');
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
      'part_of_speech', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isKeyWordMeta =
      const VerificationMeta('isKeyWord');
  @override
  late final GeneratedColumn<bool> isKeyWord = GeneratedColumn<bool>(
      'is_key_word', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_key_word" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lessonId,
        word,
        phonetic,
        translationVi,
        imageUrl,
        audioUrl,
        partOfSpeech,
        isKeyWord,
        sortOrder
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocabulary_items';
  @override
  VerificationContext validateIntegrity(Insertable<VocabularyItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('lesson_id')) {
      context.handle(_lessonIdMeta,
          lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta));
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('phonetic')) {
      context.handle(_phoneticMeta,
          phonetic.isAcceptableOrUnknown(data['phonetic']!, _phoneticMeta));
    }
    if (data.containsKey('translation_vi')) {
      context.handle(
          _translationViMeta,
          translationVi.isAcceptableOrUnknown(
              data['translation_vi']!, _translationViMeta));
    } else if (isInserting) {
      context.missing(_translationViMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('audio_url')) {
      context.handle(_audioUrlMeta,
          audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta));
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
          _partOfSpeechMeta,
          partOfSpeech.isAcceptableOrUnknown(
              data['part_of_speech']!, _partOfSpeechMeta));
    }
    if (data.containsKey('is_key_word')) {
      context.handle(
          _isKeyWordMeta,
          isKeyWord.isAcceptableOrUnknown(
              data['is_key_word']!, _isKeyWordMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VocabularyItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabularyItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lessonId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lesson_id'])!,
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      phonetic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phonetic']),
      translationVi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}translation_vi'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      audioUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_url']),
      partOfSpeech: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}part_of_speech']),
      isKeyWord: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_key_word'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $VocabularyItemsTable createAlias(String alias) {
    return $VocabularyItemsTable(attachedDatabase, alias);
  }
}

class VocabularyItem extends DataClass implements Insertable<VocabularyItem> {
  final String id;
  final String lessonId;
  final String word;
  final String? phonetic;
  final String translationVi;
  final String? imageUrl;
  final String? audioUrl;
  final String? partOfSpeech;
  final bool isKeyWord;
  final int sortOrder;
  const VocabularyItem(
      {required this.id,
      required this.lessonId,
      required this.word,
      this.phonetic,
      required this.translationVi,
      this.imageUrl,
      this.audioUrl,
      this.partOfSpeech,
      required this.isKeyWord,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['lesson_id'] = Variable<String>(lessonId);
    map['word'] = Variable<String>(word);
    if (!nullToAbsent || phonetic != null) {
      map['phonetic'] = Variable<String>(phonetic);
    }
    map['translation_vi'] = Variable<String>(translationVi);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || audioUrl != null) {
      map['audio_url'] = Variable<String>(audioUrl);
    }
    if (!nullToAbsent || partOfSpeech != null) {
      map['part_of_speech'] = Variable<String>(partOfSpeech);
    }
    map['is_key_word'] = Variable<bool>(isKeyWord);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  VocabularyItemsCompanion toCompanion(bool nullToAbsent) {
    return VocabularyItemsCompanion(
      id: Value(id),
      lessonId: Value(lessonId),
      word: Value(word),
      phonetic: phonetic == null && nullToAbsent
          ? const Value.absent()
          : Value(phonetic),
      translationVi: Value(translationVi),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      audioUrl: audioUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(audioUrl),
      partOfSpeech: partOfSpeech == null && nullToAbsent
          ? const Value.absent()
          : Value(partOfSpeech),
      isKeyWord: Value(isKeyWord),
      sortOrder: Value(sortOrder),
    );
  }

  factory VocabularyItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabularyItem(
      id: serializer.fromJson<String>(json['id']),
      lessonId: serializer.fromJson<String>(json['lessonId']),
      word: serializer.fromJson<String>(json['word']),
      phonetic: serializer.fromJson<String?>(json['phonetic']),
      translationVi: serializer.fromJson<String>(json['translationVi']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      audioUrl: serializer.fromJson<String?>(json['audioUrl']),
      partOfSpeech: serializer.fromJson<String?>(json['partOfSpeech']),
      isKeyWord: serializer.fromJson<bool>(json['isKeyWord']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lessonId': serializer.toJson<String>(lessonId),
      'word': serializer.toJson<String>(word),
      'phonetic': serializer.toJson<String?>(phonetic),
      'translationVi': serializer.toJson<String>(translationVi),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'audioUrl': serializer.toJson<String?>(audioUrl),
      'partOfSpeech': serializer.toJson<String?>(partOfSpeech),
      'isKeyWord': serializer.toJson<bool>(isKeyWord),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  VocabularyItem copyWith(
          {String? id,
          String? lessonId,
          String? word,
          Value<String?> phonetic = const Value.absent(),
          String? translationVi,
          Value<String?> imageUrl = const Value.absent(),
          Value<String?> audioUrl = const Value.absent(),
          Value<String?> partOfSpeech = const Value.absent(),
          bool? isKeyWord,
          int? sortOrder}) =>
      VocabularyItem(
        id: id ?? this.id,
        lessonId: lessonId ?? this.lessonId,
        word: word ?? this.word,
        phonetic: phonetic.present ? phonetic.value : this.phonetic,
        translationVi: translationVi ?? this.translationVi,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        audioUrl: audioUrl.present ? audioUrl.value : this.audioUrl,
        partOfSpeech:
            partOfSpeech.present ? partOfSpeech.value : this.partOfSpeech,
        isKeyWord: isKeyWord ?? this.isKeyWord,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  VocabularyItem copyWithCompanion(VocabularyItemsCompanion data) {
    return VocabularyItem(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      word: data.word.present ? data.word.value : this.word,
      phonetic: data.phonetic.present ? data.phonetic.value : this.phonetic,
      translationVi: data.translationVi.present
          ? data.translationVi.value
          : this.translationVi,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      isKeyWord: data.isKeyWord.present ? data.isKeyWord.value : this.isKeyWord,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyItem(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('word: $word, ')
          ..write('phonetic: $phonetic, ')
          ..write('translationVi: $translationVi, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('isKeyWord: $isKeyWord, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lessonId, word, phonetic, translationVi,
      imageUrl, audioUrl, partOfSpeech, isKeyWord, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabularyItem &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.word == this.word &&
          other.phonetic == this.phonetic &&
          other.translationVi == this.translationVi &&
          other.imageUrl == this.imageUrl &&
          other.audioUrl == this.audioUrl &&
          other.partOfSpeech == this.partOfSpeech &&
          other.isKeyWord == this.isKeyWord &&
          other.sortOrder == this.sortOrder);
}

class VocabularyItemsCompanion extends UpdateCompanion<VocabularyItem> {
  final Value<String> id;
  final Value<String> lessonId;
  final Value<String> word;
  final Value<String?> phonetic;
  final Value<String> translationVi;
  final Value<String?> imageUrl;
  final Value<String?> audioUrl;
  final Value<String?> partOfSpeech;
  final Value<bool> isKeyWord;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const VocabularyItemsCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.word = const Value.absent(),
    this.phonetic = const Value.absent(),
    this.translationVi = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.isKeyWord = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VocabularyItemsCompanion.insert({
    required String id,
    required String lessonId,
    required String word,
    this.phonetic = const Value.absent(),
    required String translationVi,
    this.imageUrl = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.isKeyWord = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        lessonId = Value(lessonId),
        word = Value(word),
        translationVi = Value(translationVi);
  static Insertable<VocabularyItem> custom({
    Expression<String>? id,
    Expression<String>? lessonId,
    Expression<String>? word,
    Expression<String>? phonetic,
    Expression<String>? translationVi,
    Expression<String>? imageUrl,
    Expression<String>? audioUrl,
    Expression<String>? partOfSpeech,
    Expression<bool>? isKeyWord,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (word != null) 'word': word,
      if (phonetic != null) 'phonetic': phonetic,
      if (translationVi != null) 'translation_vi': translationVi,
      if (imageUrl != null) 'image_url': imageUrl,
      if (audioUrl != null) 'audio_url': audioUrl,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (isKeyWord != null) 'is_key_word': isKeyWord,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VocabularyItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? lessonId,
      Value<String>? word,
      Value<String?>? phonetic,
      Value<String>? translationVi,
      Value<String?>? imageUrl,
      Value<String?>? audioUrl,
      Value<String?>? partOfSpeech,
      Value<bool>? isKeyWord,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return VocabularyItemsCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      word: word ?? this.word,
      phonetic: phonetic ?? this.phonetic,
      translationVi: translationVi ?? this.translationVi,
      imageUrl: imageUrl ?? this.imageUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      isKeyWord: isKeyWord ?? this.isKeyWord,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (phonetic.present) {
      map['phonetic'] = Variable<String>(phonetic.value);
    }
    if (translationVi.present) {
      map['translation_vi'] = Variable<String>(translationVi.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (audioUrl.present) {
      map['audio_url'] = Variable<String>(audioUrl.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (isKeyWord.present) {
      map['is_key_word'] = Variable<bool>(isKeyWord.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyItemsCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('word: $word, ')
          ..write('phonetic: $phonetic, ')
          ..write('translationVi: $translationVi, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('isKeyWord: $isKeyWord, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LessonProgressEntriesTable extends LessonProgressEntries
    with TableInfo<$LessonProgressEntriesTable, LessonProgressEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonProgressEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
      'child_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lessonIdMeta =
      const VerificationMeta('lessonId');
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
      'lesson_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('locked'));
  static const VerificationMeta _progressPercentMeta =
      const VerificationMeta('progressPercent');
  @override
  late final GeneratedColumn<double> progressPercent = GeneratedColumn<double>(
      'progress_percent', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _completedQuestionsMeta =
      const VerificationMeta('completedQuestions');
  @override
  late final GeneratedColumn<int> completedQuestions = GeneratedColumn<int>(
      'completed_questions', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalQuestionsMeta =
      const VerificationMeta('totalQuestions');
  @override
  late final GeneratedColumn<int> totalQuestions = GeneratedColumn<int>(
      'total_questions', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _bestScoreMeta =
      const VerificationMeta('bestScore');
  @override
  late final GeneratedColumn<int> bestScore = GeneratedColumn<int>(
      'best_score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _earnedXpMeta =
      const VerificationMeta('earnedXp');
  @override
  late final GeneratedColumn<int> earnedXp = GeneratedColumn<int>(
      'earned_xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _starsMeta = const VerificationMeta('stars');
  @override
  late final GeneratedColumn<int> stars = GeneratedColumn<int>(
      'stars', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _attemptsMeta =
      const VerificationMeta('attempts');
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
      'attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastQuestionIdMeta =
      const VerificationMeta('lastQuestionId');
  @override
  late final GeneratedColumn<String> lastQuestionId = GeneratedColumn<String>(
      'last_question_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<int> startedAt = GeneratedColumn<int>(
      'started_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<int> completedAt = GeneratedColumn<int>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        lessonId,
        status,
        progressPercent,
        completedQuestions,
        totalQuestions,
        bestScore,
        earnedXp,
        stars,
        attempts,
        lastQuestionId,
        startedAt,
        completedAt,
        updatedAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lesson_progress';
  @override
  VerificationContext validateIntegrity(
      Insertable<LessonProgressEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('lesson_id')) {
      context.handle(_lessonIdMeta,
          lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta));
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('progress_percent')) {
      context.handle(
          _progressPercentMeta,
          progressPercent.isAcceptableOrUnknown(
              data['progress_percent']!, _progressPercentMeta));
    }
    if (data.containsKey('completed_questions')) {
      context.handle(
          _completedQuestionsMeta,
          completedQuestions.isAcceptableOrUnknown(
              data['completed_questions']!, _completedQuestionsMeta));
    }
    if (data.containsKey('total_questions')) {
      context.handle(
          _totalQuestionsMeta,
          totalQuestions.isAcceptableOrUnknown(
              data['total_questions']!, _totalQuestionsMeta));
    }
    if (data.containsKey('best_score')) {
      context.handle(_bestScoreMeta,
          bestScore.isAcceptableOrUnknown(data['best_score']!, _bestScoreMeta));
    }
    if (data.containsKey('earned_xp')) {
      context.handle(_earnedXpMeta,
          earnedXp.isAcceptableOrUnknown(data['earned_xp']!, _earnedXpMeta));
    }
    if (data.containsKey('stars')) {
      context.handle(
          _starsMeta, stars.isAcceptableOrUnknown(data['stars']!, _starsMeta));
    }
    if (data.containsKey('attempts')) {
      context.handle(_attemptsMeta,
          attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta));
    }
    if (data.containsKey('last_question_id')) {
      context.handle(
          _lastQuestionIdMeta,
          lastQuestionId.isAcceptableOrUnknown(
              data['last_question_id']!, _lastQuestionIdMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {childId, lessonId},
      ];
  @override
  LessonProgressEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LessonProgressEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}child_id'])!,
      lessonId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lesson_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      progressPercent: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}progress_percent'])!,
      completedQuestions: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}completed_questions'])!,
      totalQuestions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_questions'])!,
      bestScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}best_score'])!,
      earnedXp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}earned_xp'])!,
      stars: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stars'])!,
      attempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempts'])!,
      lastQuestionId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_question_id']),
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}started_at']),
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}completed_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $LessonProgressEntriesTable createAlias(String alias) {
    return $LessonProgressEntriesTable(attachedDatabase, alias);
  }
}

class LessonProgressEntry extends DataClass
    implements Insertable<LessonProgressEntry> {
  final String id;
  final String childId;
  final String lessonId;
  final String status;
  final double progressPercent;
  final int completedQuestions;
  final int totalQuestions;
  final int bestScore;
  final int earnedXp;
  final int stars;
  final int attempts;
  final String? lastQuestionId;
  final int? startedAt;
  final int? completedAt;
  final int updatedAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const LessonProgressEntry(
      {required this.id,
      required this.childId,
      required this.lessonId,
      required this.status,
      required this.progressPercent,
      required this.completedQuestions,
      required this.totalQuestions,
      required this.bestScore,
      required this.earnedXp,
      required this.stars,
      required this.attempts,
      this.lastQuestionId,
      this.startedAt,
      this.completedAt,
      required this.updatedAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['child_id'] = Variable<String>(childId);
    map['lesson_id'] = Variable<String>(lessonId);
    map['status'] = Variable<String>(status);
    map['progress_percent'] = Variable<double>(progressPercent);
    map['completed_questions'] = Variable<int>(completedQuestions);
    map['total_questions'] = Variable<int>(totalQuestions);
    map['best_score'] = Variable<int>(bestScore);
    map['earned_xp'] = Variable<int>(earnedXp);
    map['stars'] = Variable<int>(stars);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || lastQuestionId != null) {
      map['last_question_id'] = Variable<String>(lastQuestionId);
    }
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<int>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<int>(completedAt);
    }
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  LessonProgressEntriesCompanion toCompanion(bool nullToAbsent) {
    return LessonProgressEntriesCompanion(
      id: Value(id),
      childId: Value(childId),
      lessonId: Value(lessonId),
      status: Value(status),
      progressPercent: Value(progressPercent),
      completedQuestions: Value(completedQuestions),
      totalQuestions: Value(totalQuestions),
      bestScore: Value(bestScore),
      earnedXp: Value(earnedXp),
      stars: Value(stars),
      attempts: Value(attempts),
      lastQuestionId: lastQuestionId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastQuestionId),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      updatedAt: Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory LessonProgressEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LessonProgressEntry(
      id: serializer.fromJson<String>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      lessonId: serializer.fromJson<String>(json['lessonId']),
      status: serializer.fromJson<String>(json['status']),
      progressPercent: serializer.fromJson<double>(json['progressPercent']),
      completedQuestions: serializer.fromJson<int>(json['completedQuestions']),
      totalQuestions: serializer.fromJson<int>(json['totalQuestions']),
      bestScore: serializer.fromJson<int>(json['bestScore']),
      earnedXp: serializer.fromJson<int>(json['earnedXp']),
      stars: serializer.fromJson<int>(json['stars']),
      attempts: serializer.fromJson<int>(json['attempts']),
      lastQuestionId: serializer.fromJson<String?>(json['lastQuestionId']),
      startedAt: serializer.fromJson<int?>(json['startedAt']),
      completedAt: serializer.fromJson<int?>(json['completedAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'childId': serializer.toJson<String>(childId),
      'lessonId': serializer.toJson<String>(lessonId),
      'status': serializer.toJson<String>(status),
      'progressPercent': serializer.toJson<double>(progressPercent),
      'completedQuestions': serializer.toJson<int>(completedQuestions),
      'totalQuestions': serializer.toJson<int>(totalQuestions),
      'bestScore': serializer.toJson<int>(bestScore),
      'earnedXp': serializer.toJson<int>(earnedXp),
      'stars': serializer.toJson<int>(stars),
      'attempts': serializer.toJson<int>(attempts),
      'lastQuestionId': serializer.toJson<String?>(lastQuestionId),
      'startedAt': serializer.toJson<int?>(startedAt),
      'completedAt': serializer.toJson<int?>(completedAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  LessonProgressEntry copyWith(
          {String? id,
          String? childId,
          String? lessonId,
          String? status,
          double? progressPercent,
          int? completedQuestions,
          int? totalQuestions,
          int? bestScore,
          int? earnedXp,
          int? stars,
          int? attempts,
          Value<String?> lastQuestionId = const Value.absent(),
          Value<int?> startedAt = const Value.absent(),
          Value<int?> completedAt = const Value.absent(),
          int? updatedAt,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      LessonProgressEntry(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        lessonId: lessonId ?? this.lessonId,
        status: status ?? this.status,
        progressPercent: progressPercent ?? this.progressPercent,
        completedQuestions: completedQuestions ?? this.completedQuestions,
        totalQuestions: totalQuestions ?? this.totalQuestions,
        bestScore: bestScore ?? this.bestScore,
        earnedXp: earnedXp ?? this.earnedXp,
        stars: stars ?? this.stars,
        attempts: attempts ?? this.attempts,
        lastQuestionId:
            lastQuestionId.present ? lastQuestionId.value : this.lastQuestionId,
        startedAt: startedAt.present ? startedAt.value : this.startedAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        updatedAt: updatedAt ?? this.updatedAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  LessonProgressEntry copyWithCompanion(LessonProgressEntriesCompanion data) {
    return LessonProgressEntry(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      status: data.status.present ? data.status.value : this.status,
      progressPercent: data.progressPercent.present
          ? data.progressPercent.value
          : this.progressPercent,
      completedQuestions: data.completedQuestions.present
          ? data.completedQuestions.value
          : this.completedQuestions,
      totalQuestions: data.totalQuestions.present
          ? data.totalQuestions.value
          : this.totalQuestions,
      bestScore: data.bestScore.present ? data.bestScore.value : this.bestScore,
      earnedXp: data.earnedXp.present ? data.earnedXp.value : this.earnedXp,
      stars: data.stars.present ? data.stars.value : this.stars,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      lastQuestionId: data.lastQuestionId.present
          ? data.lastQuestionId.value
          : this.lastQuestionId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LessonProgressEntry(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('lessonId: $lessonId, ')
          ..write('status: $status, ')
          ..write('progressPercent: $progressPercent, ')
          ..write('completedQuestions: $completedQuestions, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('bestScore: $bestScore, ')
          ..write('earnedXp: $earnedXp, ')
          ..write('stars: $stars, ')
          ..write('attempts: $attempts, ')
          ..write('lastQuestionId: $lastQuestionId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      childId,
      lessonId,
      status,
      progressPercent,
      completedQuestions,
      totalQuestions,
      bestScore,
      earnedXp,
      stars,
      attempts,
      lastQuestionId,
      startedAt,
      completedAt,
      updatedAt,
      remoteId,
      syncStatus,
      lastSyncedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LessonProgressEntry &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.lessonId == this.lessonId &&
          other.status == this.status &&
          other.progressPercent == this.progressPercent &&
          other.completedQuestions == this.completedQuestions &&
          other.totalQuestions == this.totalQuestions &&
          other.bestScore == this.bestScore &&
          other.earnedXp == this.earnedXp &&
          other.stars == this.stars &&
          other.attempts == this.attempts &&
          other.lastQuestionId == this.lastQuestionId &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class LessonProgressEntriesCompanion
    extends UpdateCompanion<LessonProgressEntry> {
  final Value<String> id;
  final Value<String> childId;
  final Value<String> lessonId;
  final Value<String> status;
  final Value<double> progressPercent;
  final Value<int> completedQuestions;
  final Value<int> totalQuestions;
  final Value<int> bestScore;
  final Value<int> earnedXp;
  final Value<int> stars;
  final Value<int> attempts;
  final Value<String?> lastQuestionId;
  final Value<int?> startedAt;
  final Value<int?> completedAt;
  final Value<int> updatedAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const LessonProgressEntriesCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.status = const Value.absent(),
    this.progressPercent = const Value.absent(),
    this.completedQuestions = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.bestScore = const Value.absent(),
    this.earnedXp = const Value.absent(),
    this.stars = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastQuestionId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LessonProgressEntriesCompanion.insert({
    required String id,
    required String childId,
    required String lessonId,
    this.status = const Value.absent(),
    this.progressPercent = const Value.absent(),
    this.completedQuestions = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.bestScore = const Value.absent(),
    this.earnedXp = const Value.absent(),
    this.stars = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastQuestionId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    required int updatedAt,
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        childId = Value(childId),
        lessonId = Value(lessonId),
        updatedAt = Value(updatedAt);
  static Insertable<LessonProgressEntry> custom({
    Expression<String>? id,
    Expression<String>? childId,
    Expression<String>? lessonId,
    Expression<String>? status,
    Expression<double>? progressPercent,
    Expression<int>? completedQuestions,
    Expression<int>? totalQuestions,
    Expression<int>? bestScore,
    Expression<int>? earnedXp,
    Expression<int>? stars,
    Expression<int>? attempts,
    Expression<String>? lastQuestionId,
    Expression<int>? startedAt,
    Expression<int>? completedAt,
    Expression<int>? updatedAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (lessonId != null) 'lesson_id': lessonId,
      if (status != null) 'status': status,
      if (progressPercent != null) 'progress_percent': progressPercent,
      if (completedQuestions != null) 'completed_questions': completedQuestions,
      if (totalQuestions != null) 'total_questions': totalQuestions,
      if (bestScore != null) 'best_score': bestScore,
      if (earnedXp != null) 'earned_xp': earnedXp,
      if (stars != null) 'stars': stars,
      if (attempts != null) 'attempts': attempts,
      if (lastQuestionId != null) 'last_question_id': lastQuestionId,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LessonProgressEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? childId,
      Value<String>? lessonId,
      Value<String>? status,
      Value<double>? progressPercent,
      Value<int>? completedQuestions,
      Value<int>? totalQuestions,
      Value<int>? bestScore,
      Value<int>? earnedXp,
      Value<int>? stars,
      Value<int>? attempts,
      Value<String?>? lastQuestionId,
      Value<int?>? startedAt,
      Value<int?>? completedAt,
      Value<int>? updatedAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return LessonProgressEntriesCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      lessonId: lessonId ?? this.lessonId,
      status: status ?? this.status,
      progressPercent: progressPercent ?? this.progressPercent,
      completedQuestions: completedQuestions ?? this.completedQuestions,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      bestScore: bestScore ?? this.bestScore,
      earnedXp: earnedXp ?? this.earnedXp,
      stars: stars ?? this.stars,
      attempts: attempts ?? this.attempts,
      lastQuestionId: lastQuestionId ?? this.lastQuestionId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (progressPercent.present) {
      map['progress_percent'] = Variable<double>(progressPercent.value);
    }
    if (completedQuestions.present) {
      map['completed_questions'] = Variable<int>(completedQuestions.value);
    }
    if (totalQuestions.present) {
      map['total_questions'] = Variable<int>(totalQuestions.value);
    }
    if (bestScore.present) {
      map['best_score'] = Variable<int>(bestScore.value);
    }
    if (earnedXp.present) {
      map['earned_xp'] = Variable<int>(earnedXp.value);
    }
    if (stars.present) {
      map['stars'] = Variable<int>(stars.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (lastQuestionId.present) {
      map['last_question_id'] = Variable<String>(lastQuestionId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<int>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<int>(completedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonProgressEntriesCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('lessonId: $lessonId, ')
          ..write('status: $status, ')
          ..write('progressPercent: $progressPercent, ')
          ..write('completedQuestions: $completedQuestions, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('bestScore: $bestScore, ')
          ..write('earnedXp: $earnedXp, ')
          ..write('stars: $stars, ')
          ..write('attempts: $attempts, ')
          ..write('lastQuestionId: $lastQuestionId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuizAttemptsTable extends QuizAttempts
    with TableInfo<$QuizAttemptsTable, QuizAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
      'child_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lessonIdMeta =
      const VerificationMeta('lessonId');
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
      'lesson_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
      'question_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quizTypeMeta =
      const VerificationMeta('quizType');
  @override
  late final GeneratedColumn<String> quizType = GeneratedColumn<String>(
      'quiz_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _attemptIndexMeta =
      const VerificationMeta('attemptIndex');
  @override
  late final GeneratedColumn<int> attemptIndex = GeneratedColumn<int>(
      'attempt_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _isCorrectMeta =
      const VerificationMeta('isCorrect');
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
      'is_correct', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_correct" IN (0, 1))'));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _starsMeta = const VerificationMeta('stars');
  @override
  late final GeneratedColumn<int> stars = GeneratedColumn<int>(
      'stars', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _xpEarnedMeta =
      const VerificationMeta('xpEarned');
  @override
  late final GeneratedColumn<int> xpEarned = GeneratedColumn<int>(
      'xp_earned', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _timeTakenMsMeta =
      const VerificationMeta('timeTakenMs');
  @override
  late final GeneratedColumn<int> timeTakenMs = GeneratedColumn<int>(
      'time_taken_ms', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _hintsUsedMeta =
      const VerificationMeta('hintsUsed');
  @override
  late final GeneratedColumn<int> hintsUsed = GeneratedColumn<int>(
      'hints_used', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _answerJsonMeta =
      const VerificationMeta('answerJson');
  @override
  late final GeneratedColumn<String> answerJson = GeneratedColumn<String>(
      'answer_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        sessionId,
        lessonId,
        questionId,
        quizType,
        attemptIndex,
        isCorrect,
        isCompleted,
        score,
        stars,
        xpEarned,
        timeTakenMs,
        hintsUsed,
        answerJson,
        createdAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quiz_attempts';
  @override
  VerificationContext validateIntegrity(Insertable<QuizAttempt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    }
    if (data.containsKey('lesson_id')) {
      context.handle(_lessonIdMeta,
          lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta));
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('quiz_type')) {
      context.handle(_quizTypeMeta,
          quizType.isAcceptableOrUnknown(data['quiz_type']!, _quizTypeMeta));
    } else if (isInserting) {
      context.missing(_quizTypeMeta);
    }
    if (data.containsKey('attempt_index')) {
      context.handle(
          _attemptIndexMeta,
          attemptIndex.isAcceptableOrUnknown(
              data['attempt_index']!, _attemptIndexMeta));
    }
    if (data.containsKey('is_correct')) {
      context.handle(_isCorrectMeta,
          isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta));
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    if (data.containsKey('stars')) {
      context.handle(
          _starsMeta, stars.isAcceptableOrUnknown(data['stars']!, _starsMeta));
    }
    if (data.containsKey('xp_earned')) {
      context.handle(_xpEarnedMeta,
          xpEarned.isAcceptableOrUnknown(data['xp_earned']!, _xpEarnedMeta));
    }
    if (data.containsKey('time_taken_ms')) {
      context.handle(
          _timeTakenMsMeta,
          timeTakenMs.isAcceptableOrUnknown(
              data['time_taken_ms']!, _timeTakenMsMeta));
    }
    if (data.containsKey('hints_used')) {
      context.handle(_hintsUsedMeta,
          hintsUsed.isAcceptableOrUnknown(data['hints_used']!, _hintsUsedMeta));
    }
    if (data.containsKey('answer_json')) {
      context.handle(
          _answerJsonMeta,
          answerJson.isAcceptableOrUnknown(
              data['answer_json']!, _answerJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizAttempt(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}child_id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id']),
      lessonId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lesson_id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_id'])!,
      quizType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}quiz_type'])!,
      attemptIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempt_index'])!,
      isCorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_correct'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score'])!,
      stars: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stars'])!,
      xpEarned: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp_earned'])!,
      timeTakenMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}time_taken_ms'])!,
      hintsUsed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hints_used'])!,
      answerJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answer_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $QuizAttemptsTable createAlias(String alias) {
    return $QuizAttemptsTable(attachedDatabase, alias);
  }
}

class QuizAttempt extends DataClass implements Insertable<QuizAttempt> {
  final String id;
  final String childId;
  final String? sessionId;
  final String lessonId;
  final String questionId;
  final String quizType;
  final int attemptIndex;
  final bool isCorrect;
  final bool isCompleted;
  final int score;
  final int stars;
  final int xpEarned;
  final int timeTakenMs;
  final int hintsUsed;
  final String? answerJson;
  final int createdAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const QuizAttempt(
      {required this.id,
      required this.childId,
      this.sessionId,
      required this.lessonId,
      required this.questionId,
      required this.quizType,
      required this.attemptIndex,
      required this.isCorrect,
      required this.isCompleted,
      required this.score,
      required this.stars,
      required this.xpEarned,
      required this.timeTakenMs,
      required this.hintsUsed,
      this.answerJson,
      required this.createdAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['child_id'] = Variable<String>(childId);
    if (!nullToAbsent || sessionId != null) {
      map['session_id'] = Variable<String>(sessionId);
    }
    map['lesson_id'] = Variable<String>(lessonId);
    map['question_id'] = Variable<String>(questionId);
    map['quiz_type'] = Variable<String>(quizType);
    map['attempt_index'] = Variable<int>(attemptIndex);
    map['is_correct'] = Variable<bool>(isCorrect);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['score'] = Variable<int>(score);
    map['stars'] = Variable<int>(stars);
    map['xp_earned'] = Variable<int>(xpEarned);
    map['time_taken_ms'] = Variable<int>(timeTakenMs);
    map['hints_used'] = Variable<int>(hintsUsed);
    if (!nullToAbsent || answerJson != null) {
      map['answer_json'] = Variable<String>(answerJson);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  QuizAttemptsCompanion toCompanion(bool nullToAbsent) {
    return QuizAttemptsCompanion(
      id: Value(id),
      childId: Value(childId),
      sessionId: sessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionId),
      lessonId: Value(lessonId),
      questionId: Value(questionId),
      quizType: Value(quizType),
      attemptIndex: Value(attemptIndex),
      isCorrect: Value(isCorrect),
      isCompleted: Value(isCompleted),
      score: Value(score),
      stars: Value(stars),
      xpEarned: Value(xpEarned),
      timeTakenMs: Value(timeTakenMs),
      hintsUsed: Value(hintsUsed),
      answerJson: answerJson == null && nullToAbsent
          ? const Value.absent()
          : Value(answerJson),
      createdAt: Value(createdAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory QuizAttempt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizAttempt(
      id: serializer.fromJson<String>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      sessionId: serializer.fromJson<String?>(json['sessionId']),
      lessonId: serializer.fromJson<String>(json['lessonId']),
      questionId: serializer.fromJson<String>(json['questionId']),
      quizType: serializer.fromJson<String>(json['quizType']),
      attemptIndex: serializer.fromJson<int>(json['attemptIndex']),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      score: serializer.fromJson<int>(json['score']),
      stars: serializer.fromJson<int>(json['stars']),
      xpEarned: serializer.fromJson<int>(json['xpEarned']),
      timeTakenMs: serializer.fromJson<int>(json['timeTakenMs']),
      hintsUsed: serializer.fromJson<int>(json['hintsUsed']),
      answerJson: serializer.fromJson<String?>(json['answerJson']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'childId': serializer.toJson<String>(childId),
      'sessionId': serializer.toJson<String?>(sessionId),
      'lessonId': serializer.toJson<String>(lessonId),
      'questionId': serializer.toJson<String>(questionId),
      'quizType': serializer.toJson<String>(quizType),
      'attemptIndex': serializer.toJson<int>(attemptIndex),
      'isCorrect': serializer.toJson<bool>(isCorrect),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'score': serializer.toJson<int>(score),
      'stars': serializer.toJson<int>(stars),
      'xpEarned': serializer.toJson<int>(xpEarned),
      'timeTakenMs': serializer.toJson<int>(timeTakenMs),
      'hintsUsed': serializer.toJson<int>(hintsUsed),
      'answerJson': serializer.toJson<String?>(answerJson),
      'createdAt': serializer.toJson<int>(createdAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  QuizAttempt copyWith(
          {String? id,
          String? childId,
          Value<String?> sessionId = const Value.absent(),
          String? lessonId,
          String? questionId,
          String? quizType,
          int? attemptIndex,
          bool? isCorrect,
          bool? isCompleted,
          int? score,
          int? stars,
          int? xpEarned,
          int? timeTakenMs,
          int? hintsUsed,
          Value<String?> answerJson = const Value.absent(),
          int? createdAt,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      QuizAttempt(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        sessionId: sessionId.present ? sessionId.value : this.sessionId,
        lessonId: lessonId ?? this.lessonId,
        questionId: questionId ?? this.questionId,
        quizType: quizType ?? this.quizType,
        attemptIndex: attemptIndex ?? this.attemptIndex,
        isCorrect: isCorrect ?? this.isCorrect,
        isCompleted: isCompleted ?? this.isCompleted,
        score: score ?? this.score,
        stars: stars ?? this.stars,
        xpEarned: xpEarned ?? this.xpEarned,
        timeTakenMs: timeTakenMs ?? this.timeTakenMs,
        hintsUsed: hintsUsed ?? this.hintsUsed,
        answerJson: answerJson.present ? answerJson.value : this.answerJson,
        createdAt: createdAt ?? this.createdAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  QuizAttempt copyWithCompanion(QuizAttemptsCompanion data) {
    return QuizAttempt(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      quizType: data.quizType.present ? data.quizType.value : this.quizType,
      attemptIndex: data.attemptIndex.present
          ? data.attemptIndex.value
          : this.attemptIndex,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      score: data.score.present ? data.score.value : this.score,
      stars: data.stars.present ? data.stars.value : this.stars,
      xpEarned: data.xpEarned.present ? data.xpEarned.value : this.xpEarned,
      timeTakenMs:
          data.timeTakenMs.present ? data.timeTakenMs.value : this.timeTakenMs,
      hintsUsed: data.hintsUsed.present ? data.hintsUsed.value : this.hintsUsed,
      answerJson:
          data.answerJson.present ? data.answerJson.value : this.answerJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizAttempt(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('sessionId: $sessionId, ')
          ..write('lessonId: $lessonId, ')
          ..write('questionId: $questionId, ')
          ..write('quizType: $quizType, ')
          ..write('attemptIndex: $attemptIndex, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('score: $score, ')
          ..write('stars: $stars, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('timeTakenMs: $timeTakenMs, ')
          ..write('hintsUsed: $hintsUsed, ')
          ..write('answerJson: $answerJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      childId,
      sessionId,
      lessonId,
      questionId,
      quizType,
      attemptIndex,
      isCorrect,
      isCompleted,
      score,
      stars,
      xpEarned,
      timeTakenMs,
      hintsUsed,
      answerJson,
      createdAt,
      remoteId,
      syncStatus,
      lastSyncedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizAttempt &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.sessionId == this.sessionId &&
          other.lessonId == this.lessonId &&
          other.questionId == this.questionId &&
          other.quizType == this.quizType &&
          other.attemptIndex == this.attemptIndex &&
          other.isCorrect == this.isCorrect &&
          other.isCompleted == this.isCompleted &&
          other.score == this.score &&
          other.stars == this.stars &&
          other.xpEarned == this.xpEarned &&
          other.timeTakenMs == this.timeTakenMs &&
          other.hintsUsed == this.hintsUsed &&
          other.answerJson == this.answerJson &&
          other.createdAt == this.createdAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class QuizAttemptsCompanion extends UpdateCompanion<QuizAttempt> {
  final Value<String> id;
  final Value<String> childId;
  final Value<String?> sessionId;
  final Value<String> lessonId;
  final Value<String> questionId;
  final Value<String> quizType;
  final Value<int> attemptIndex;
  final Value<bool> isCorrect;
  final Value<bool> isCompleted;
  final Value<int> score;
  final Value<int> stars;
  final Value<int> xpEarned;
  final Value<int> timeTakenMs;
  final Value<int> hintsUsed;
  final Value<String?> answerJson;
  final Value<int> createdAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const QuizAttemptsCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.quizType = const Value.absent(),
    this.attemptIndex = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.score = const Value.absent(),
    this.stars = const Value.absent(),
    this.xpEarned = const Value.absent(),
    this.timeTakenMs = const Value.absent(),
    this.hintsUsed = const Value.absent(),
    this.answerJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuizAttemptsCompanion.insert({
    required String id,
    required String childId,
    this.sessionId = const Value.absent(),
    required String lessonId,
    required String questionId,
    required String quizType,
    this.attemptIndex = const Value.absent(),
    required bool isCorrect,
    this.isCompleted = const Value.absent(),
    this.score = const Value.absent(),
    this.stars = const Value.absent(),
    this.xpEarned = const Value.absent(),
    this.timeTakenMs = const Value.absent(),
    this.hintsUsed = const Value.absent(),
    this.answerJson = const Value.absent(),
    required int createdAt,
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        childId = Value(childId),
        lessonId = Value(lessonId),
        questionId = Value(questionId),
        quizType = Value(quizType),
        isCorrect = Value(isCorrect),
        createdAt = Value(createdAt);
  static Insertable<QuizAttempt> custom({
    Expression<String>? id,
    Expression<String>? childId,
    Expression<String>? sessionId,
    Expression<String>? lessonId,
    Expression<String>? questionId,
    Expression<String>? quizType,
    Expression<int>? attemptIndex,
    Expression<bool>? isCorrect,
    Expression<bool>? isCompleted,
    Expression<int>? score,
    Expression<int>? stars,
    Expression<int>? xpEarned,
    Expression<int>? timeTakenMs,
    Expression<int>? hintsUsed,
    Expression<String>? answerJson,
    Expression<int>? createdAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (sessionId != null) 'session_id': sessionId,
      if (lessonId != null) 'lesson_id': lessonId,
      if (questionId != null) 'question_id': questionId,
      if (quizType != null) 'quiz_type': quizType,
      if (attemptIndex != null) 'attempt_index': attemptIndex,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (score != null) 'score': score,
      if (stars != null) 'stars': stars,
      if (xpEarned != null) 'xp_earned': xpEarned,
      if (timeTakenMs != null) 'time_taken_ms': timeTakenMs,
      if (hintsUsed != null) 'hints_used': hintsUsed,
      if (answerJson != null) 'answer_json': answerJson,
      if (createdAt != null) 'created_at': createdAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuizAttemptsCompanion copyWith(
      {Value<String>? id,
      Value<String>? childId,
      Value<String?>? sessionId,
      Value<String>? lessonId,
      Value<String>? questionId,
      Value<String>? quizType,
      Value<int>? attemptIndex,
      Value<bool>? isCorrect,
      Value<bool>? isCompleted,
      Value<int>? score,
      Value<int>? stars,
      Value<int>? xpEarned,
      Value<int>? timeTakenMs,
      Value<int>? hintsUsed,
      Value<String?>? answerJson,
      Value<int>? createdAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return QuizAttemptsCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      sessionId: sessionId ?? this.sessionId,
      lessonId: lessonId ?? this.lessonId,
      questionId: questionId ?? this.questionId,
      quizType: quizType ?? this.quizType,
      attemptIndex: attemptIndex ?? this.attemptIndex,
      isCorrect: isCorrect ?? this.isCorrect,
      isCompleted: isCompleted ?? this.isCompleted,
      score: score ?? this.score,
      stars: stars ?? this.stars,
      xpEarned: xpEarned ?? this.xpEarned,
      timeTakenMs: timeTakenMs ?? this.timeTakenMs,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      answerJson: answerJson ?? this.answerJson,
      createdAt: createdAt ?? this.createdAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (quizType.present) {
      map['quiz_type'] = Variable<String>(quizType.value);
    }
    if (attemptIndex.present) {
      map['attempt_index'] = Variable<int>(attemptIndex.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (stars.present) {
      map['stars'] = Variable<int>(stars.value);
    }
    if (xpEarned.present) {
      map['xp_earned'] = Variable<int>(xpEarned.value);
    }
    if (timeTakenMs.present) {
      map['time_taken_ms'] = Variable<int>(timeTakenMs.value);
    }
    if (hintsUsed.present) {
      map['hints_used'] = Variable<int>(hintsUsed.value);
    }
    if (answerJson.present) {
      map['answer_json'] = Variable<String>(answerJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('sessionId: $sessionId, ')
          ..write('lessonId: $lessonId, ')
          ..write('questionId: $questionId, ')
          ..write('quizType: $quizType, ')
          ..write('attemptIndex: $attemptIndex, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('score: $score, ')
          ..write('stars: $stars, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('timeTakenMs: $timeTakenMs, ')
          ..write('hintsUsed: $hintsUsed, ')
          ..write('answerJson: $answerJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MissionTemplatesTable extends MissionTemplates
    with TableInfo<$MissionTemplatesTable, MissionTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MissionTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _topicScopeMeta =
      const VerificationMeta('topicScope');
  @override
  late final GeneratedColumn<String> topicScope = GeneratedColumn<String>(
      'topic_scope', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('any'));
  static const VerificationMeta _conditionJsonMeta =
      const VerificationMeta('conditionJson');
  @override
  late final GeneratedColumn<String> conditionJson = GeneratedColumn<String>(
      'condition_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _targetMetricMeta =
      const VerificationMeta('targetMetric');
  @override
  late final GeneratedColumn<String> targetMetric = GeneratedColumn<String>(
      'target_metric', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetValueMeta =
      const VerificationMeta('targetValue');
  @override
  late final GeneratedColumn<int> targetValue = GeneratedColumn<int>(
      'target_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _xpRewardMeta =
      const VerificationMeta('xpReward');
  @override
  late final GeneratedColumn<int> xpReward = GeneratedColumn<int>(
      'xp_reward', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _durationEstMinMeta =
      const VerificationMeta('durationEstMin');
  @override
  late final GeneratedColumn<int> durationEstMin = GeneratedColumn<int>(
      'duration_est_min', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        difficulty,
        topicScope,
        conditionJson,
        title,
        description,
        targetMetric,
        targetValue,
        xpReward,
        durationEstMin,
        isActive,
        sortOrder,
        createdAt,
        updatedAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mission_templates';
  @override
  VerificationContext validateIntegrity(Insertable<MissionTemplate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('topic_scope')) {
      context.handle(
          _topicScopeMeta,
          topicScope.isAcceptableOrUnknown(
              data['topic_scope']!, _topicScopeMeta));
    }
    if (data.containsKey('condition_json')) {
      context.handle(
          _conditionJsonMeta,
          conditionJson.isAcceptableOrUnknown(
              data['condition_json']!, _conditionJsonMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('target_metric')) {
      context.handle(
          _targetMetricMeta,
          targetMetric.isAcceptableOrUnknown(
              data['target_metric']!, _targetMetricMeta));
    } else if (isInserting) {
      context.missing(_targetMetricMeta);
    }
    if (data.containsKey('target_value')) {
      context.handle(
          _targetValueMeta,
          targetValue.isAcceptableOrUnknown(
              data['target_value']!, _targetValueMeta));
    } else if (isInserting) {
      context.missing(_targetValueMeta);
    }
    if (data.containsKey('xp_reward')) {
      context.handle(_xpRewardMeta,
          xpReward.isAcceptableOrUnknown(data['xp_reward']!, _xpRewardMeta));
    } else if (isInserting) {
      context.missing(_xpRewardMeta);
    }
    if (data.containsKey('duration_est_min')) {
      context.handle(
          _durationEstMinMeta,
          durationEstMin.isAcceptableOrUnknown(
              data['duration_est_min']!, _durationEstMinMeta));
    } else if (isInserting) {
      context.missing(_durationEstMinMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MissionTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MissionTemplate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}difficulty'])!,
      topicScope: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}topic_scope'])!,
      conditionJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}condition_json']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      targetMetric: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_metric'])!,
      targetValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_value'])!,
      xpReward: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp_reward'])!,
      durationEstMin: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_est_min'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $MissionTemplatesTable createAlias(String alias) {
    return $MissionTemplatesTable(attachedDatabase, alias);
  }
}

class MissionTemplate extends DataClass implements Insertable<MissionTemplate> {
  final String id;
  final String type;
  final String difficulty;
  final String topicScope;
  final String? conditionJson;
  final String title;
  final String? description;
  final String targetMetric;
  final int targetValue;
  final int xpReward;
  final int durationEstMin;
  final bool isActive;
  final int sortOrder;
  final int createdAt;
  final int updatedAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const MissionTemplate(
      {required this.id,
      required this.type,
      required this.difficulty,
      required this.topicScope,
      this.conditionJson,
      required this.title,
      this.description,
      required this.targetMetric,
      required this.targetValue,
      required this.xpReward,
      required this.durationEstMin,
      required this.isActive,
      required this.sortOrder,
      required this.createdAt,
      required this.updatedAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['difficulty'] = Variable<String>(difficulty);
    map['topic_scope'] = Variable<String>(topicScope);
    if (!nullToAbsent || conditionJson != null) {
      map['condition_json'] = Variable<String>(conditionJson);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['target_metric'] = Variable<String>(targetMetric);
    map['target_value'] = Variable<int>(targetValue);
    map['xp_reward'] = Variable<int>(xpReward);
    map['duration_est_min'] = Variable<int>(durationEstMin);
    map['is_active'] = Variable<bool>(isActive);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  MissionTemplatesCompanion toCompanion(bool nullToAbsent) {
    return MissionTemplatesCompanion(
      id: Value(id),
      type: Value(type),
      difficulty: Value(difficulty),
      topicScope: Value(topicScope),
      conditionJson: conditionJson == null && nullToAbsent
          ? const Value.absent()
          : Value(conditionJson),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      targetMetric: Value(targetMetric),
      targetValue: Value(targetValue),
      xpReward: Value(xpReward),
      durationEstMin: Value(durationEstMin),
      isActive: Value(isActive),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory MissionTemplate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MissionTemplate(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      topicScope: serializer.fromJson<String>(json['topicScope']),
      conditionJson: serializer.fromJson<String?>(json['conditionJson']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      targetMetric: serializer.fromJson<String>(json['targetMetric']),
      targetValue: serializer.fromJson<int>(json['targetValue']),
      xpReward: serializer.fromJson<int>(json['xpReward']),
      durationEstMin: serializer.fromJson<int>(json['durationEstMin']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'difficulty': serializer.toJson<String>(difficulty),
      'topicScope': serializer.toJson<String>(topicScope),
      'conditionJson': serializer.toJson<String?>(conditionJson),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'targetMetric': serializer.toJson<String>(targetMetric),
      'targetValue': serializer.toJson<int>(targetValue),
      'xpReward': serializer.toJson<int>(xpReward),
      'durationEstMin': serializer.toJson<int>(durationEstMin),
      'isActive': serializer.toJson<bool>(isActive),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  MissionTemplate copyWith(
          {String? id,
          String? type,
          String? difficulty,
          String? topicScope,
          Value<String?> conditionJson = const Value.absent(),
          String? title,
          Value<String?> description = const Value.absent(),
          String? targetMetric,
          int? targetValue,
          int? xpReward,
          int? durationEstMin,
          bool? isActive,
          int? sortOrder,
          int? createdAt,
          int? updatedAt,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      MissionTemplate(
        id: id ?? this.id,
        type: type ?? this.type,
        difficulty: difficulty ?? this.difficulty,
        topicScope: topicScope ?? this.topicScope,
        conditionJson:
            conditionJson.present ? conditionJson.value : this.conditionJson,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        targetMetric: targetMetric ?? this.targetMetric,
        targetValue: targetValue ?? this.targetValue,
        xpReward: xpReward ?? this.xpReward,
        durationEstMin: durationEstMin ?? this.durationEstMin,
        isActive: isActive ?? this.isActive,
        sortOrder: sortOrder ?? this.sortOrder,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  MissionTemplate copyWithCompanion(MissionTemplatesCompanion data) {
    return MissionTemplate(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      topicScope:
          data.topicScope.present ? data.topicScope.value : this.topicScope,
      conditionJson: data.conditionJson.present
          ? data.conditionJson.value
          : this.conditionJson,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      targetMetric: data.targetMetric.present
          ? data.targetMetric.value
          : this.targetMetric,
      targetValue:
          data.targetValue.present ? data.targetValue.value : this.targetValue,
      xpReward: data.xpReward.present ? data.xpReward.value : this.xpReward,
      durationEstMin: data.durationEstMin.present
          ? data.durationEstMin.value
          : this.durationEstMin,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MissionTemplate(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('difficulty: $difficulty, ')
          ..write('topicScope: $topicScope, ')
          ..write('conditionJson: $conditionJson, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('targetMetric: $targetMetric, ')
          ..write('targetValue: $targetValue, ')
          ..write('xpReward: $xpReward, ')
          ..write('durationEstMin: $durationEstMin, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      type,
      difficulty,
      topicScope,
      conditionJson,
      title,
      description,
      targetMetric,
      targetValue,
      xpReward,
      durationEstMin,
      isActive,
      sortOrder,
      createdAt,
      updatedAt,
      remoteId,
      syncStatus,
      lastSyncedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MissionTemplate &&
          other.id == this.id &&
          other.type == this.type &&
          other.difficulty == this.difficulty &&
          other.topicScope == this.topicScope &&
          other.conditionJson == this.conditionJson &&
          other.title == this.title &&
          other.description == this.description &&
          other.targetMetric == this.targetMetric &&
          other.targetValue == this.targetValue &&
          other.xpReward == this.xpReward &&
          other.durationEstMin == this.durationEstMin &&
          other.isActive == this.isActive &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class MissionTemplatesCompanion extends UpdateCompanion<MissionTemplate> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> difficulty;
  final Value<String> topicScope;
  final Value<String?> conditionJson;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> targetMetric;
  final Value<int> targetValue;
  final Value<int> xpReward;
  final Value<int> durationEstMin;
  final Value<bool> isActive;
  final Value<int> sortOrder;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const MissionTemplatesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.topicScope = const Value.absent(),
    this.conditionJson = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.targetMetric = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.durationEstMin = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MissionTemplatesCompanion.insert({
    required String id,
    required String type,
    required String difficulty,
    this.topicScope = const Value.absent(),
    this.conditionJson = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required String targetMetric,
    required int targetValue,
    required int xpReward,
    required int durationEstMin,
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        difficulty = Value(difficulty),
        title = Value(title),
        targetMetric = Value(targetMetric),
        targetValue = Value(targetValue),
        xpReward = Value(xpReward),
        durationEstMin = Value(durationEstMin),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<MissionTemplate> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? difficulty,
    Expression<String>? topicScope,
    Expression<String>? conditionJson,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? targetMetric,
    Expression<int>? targetValue,
    Expression<int>? xpReward,
    Expression<int>? durationEstMin,
    Expression<bool>? isActive,
    Expression<int>? sortOrder,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (difficulty != null) 'difficulty': difficulty,
      if (topicScope != null) 'topic_scope': topicScope,
      if (conditionJson != null) 'condition_json': conditionJson,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (targetMetric != null) 'target_metric': targetMetric,
      if (targetValue != null) 'target_value': targetValue,
      if (xpReward != null) 'xp_reward': xpReward,
      if (durationEstMin != null) 'duration_est_min': durationEstMin,
      if (isActive != null) 'is_active': isActive,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MissionTemplatesCompanion copyWith(
      {Value<String>? id,
      Value<String>? type,
      Value<String>? difficulty,
      Value<String>? topicScope,
      Value<String?>? conditionJson,
      Value<String>? title,
      Value<String?>? description,
      Value<String>? targetMetric,
      Value<int>? targetValue,
      Value<int>? xpReward,
      Value<int>? durationEstMin,
      Value<bool>? isActive,
      Value<int>? sortOrder,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return MissionTemplatesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      difficulty: difficulty ?? this.difficulty,
      topicScope: topicScope ?? this.topicScope,
      conditionJson: conditionJson ?? this.conditionJson,
      title: title ?? this.title,
      description: description ?? this.description,
      targetMetric: targetMetric ?? this.targetMetric,
      targetValue: targetValue ?? this.targetValue,
      xpReward: xpReward ?? this.xpReward,
      durationEstMin: durationEstMin ?? this.durationEstMin,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (topicScope.present) {
      map['topic_scope'] = Variable<String>(topicScope.value);
    }
    if (conditionJson.present) {
      map['condition_json'] = Variable<String>(conditionJson.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (targetMetric.present) {
      map['target_metric'] = Variable<String>(targetMetric.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<int>(targetValue.value);
    }
    if (xpReward.present) {
      map['xp_reward'] = Variable<int>(xpReward.value);
    }
    if (durationEstMin.present) {
      map['duration_est_min'] = Variable<int>(durationEstMin.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MissionTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('difficulty: $difficulty, ')
          ..write('topicScope: $topicScope, ')
          ..write('conditionJson: $conditionJson, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('targetMetric: $targetMetric, ')
          ..write('targetValue: $targetValue, ')
          ..write('xpReward: $xpReward, ')
          ..write('durationEstMin: $durationEstMin, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyMissionsTable extends DailyMissions
    with TableInfo<$DailyMissionsTable, DailyMission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyMissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
      'child_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
      'slot', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _missionTemplateIdMeta =
      const VerificationMeta('missionTemplateId');
  @override
  late final GeneratedColumn<String> missionTemplateId =
      GeneratedColumn<String>('mission_template_id', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paramsJsonMeta =
      const VerificationMeta('paramsJson');
  @override
  late final GeneratedColumn<String> paramsJson = GeneratedColumn<String>(
      'params_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _progressValueMeta =
      const VerificationMeta('progressValue');
  @override
  late final GeneratedColumn<int> progressValue = GeneratedColumn<int>(
      'progress_value', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _targetValueMeta =
      const VerificationMeta('targetValue');
  @override
  late final GeneratedColumn<int> targetValue = GeneratedColumn<int>(
      'target_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _xpRewardMeta =
      const VerificationMeta('xpReward');
  @override
  late final GeneratedColumn<int> xpReward = GeneratedColumn<int>(
      'xp_reward', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<int> completedAt = GeneratedColumn<int>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        date,
        slot,
        missionTemplateId,
        paramsJson,
        status,
        progressValue,
        targetValue,
        xpReward,
        completedAt,
        createdAt,
        updatedAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_missions';
  @override
  VerificationContext validateIntegrity(Insertable<DailyMission> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
          _slotMeta, slot.isAcceptableOrUnknown(data['slot']!, _slotMeta));
    }
    if (data.containsKey('mission_template_id')) {
      context.handle(
          _missionTemplateIdMeta,
          missionTemplateId.isAcceptableOrUnknown(
              data['mission_template_id']!, _missionTemplateIdMeta));
    } else if (isInserting) {
      context.missing(_missionTemplateIdMeta);
    }
    if (data.containsKey('params_json')) {
      context.handle(
          _paramsJsonMeta,
          paramsJson.isAcceptableOrUnknown(
              data['params_json']!, _paramsJsonMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('progress_value')) {
      context.handle(
          _progressValueMeta,
          progressValue.isAcceptableOrUnknown(
              data['progress_value']!, _progressValueMeta));
    }
    if (data.containsKey('target_value')) {
      context.handle(
          _targetValueMeta,
          targetValue.isAcceptableOrUnknown(
              data['target_value']!, _targetValueMeta));
    } else if (isInserting) {
      context.missing(_targetValueMeta);
    }
    if (data.containsKey('xp_reward')) {
      context.handle(_xpRewardMeta,
          xpReward.isAcceptableOrUnknown(data['xp_reward']!, _xpRewardMeta));
    } else if (isInserting) {
      context.missing(_xpRewardMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {childId, date, missionTemplateId},
      ];
  @override
  DailyMission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyMission(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}child_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      slot: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}slot'])!,
      missionTemplateId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}mission_template_id'])!,
      paramsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}params_json'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      progressValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}progress_value'])!,
      targetValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_value'])!,
      xpReward: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp_reward'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}completed_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $DailyMissionsTable createAlias(String alias) {
    return $DailyMissionsTable(attachedDatabase, alias);
  }
}

class DailyMission extends DataClass implements Insertable<DailyMission> {
  final String id;
  final String childId;
  final String date;
  final int slot;
  final String missionTemplateId;
  final String paramsJson;
  final String status;
  final int progressValue;
  final int targetValue;
  final int xpReward;
  final int? completedAt;
  final int createdAt;
  final int updatedAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const DailyMission(
      {required this.id,
      required this.childId,
      required this.date,
      required this.slot,
      required this.missionTemplateId,
      required this.paramsJson,
      required this.status,
      required this.progressValue,
      required this.targetValue,
      required this.xpReward,
      this.completedAt,
      required this.createdAt,
      required this.updatedAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['child_id'] = Variable<String>(childId);
    map['date'] = Variable<String>(date);
    map['slot'] = Variable<int>(slot);
    map['mission_template_id'] = Variable<String>(missionTemplateId);
    map['params_json'] = Variable<String>(paramsJson);
    map['status'] = Variable<String>(status);
    map['progress_value'] = Variable<int>(progressValue);
    map['target_value'] = Variable<int>(targetValue);
    map['xp_reward'] = Variable<int>(xpReward);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<int>(completedAt);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  DailyMissionsCompanion toCompanion(bool nullToAbsent) {
    return DailyMissionsCompanion(
      id: Value(id),
      childId: Value(childId),
      date: Value(date),
      slot: Value(slot),
      missionTemplateId: Value(missionTemplateId),
      paramsJson: Value(paramsJson),
      status: Value(status),
      progressValue: Value(progressValue),
      targetValue: Value(targetValue),
      xpReward: Value(xpReward),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory DailyMission.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyMission(
      id: serializer.fromJson<String>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      date: serializer.fromJson<String>(json['date']),
      slot: serializer.fromJson<int>(json['slot']),
      missionTemplateId: serializer.fromJson<String>(json['missionTemplateId']),
      paramsJson: serializer.fromJson<String>(json['paramsJson']),
      status: serializer.fromJson<String>(json['status']),
      progressValue: serializer.fromJson<int>(json['progressValue']),
      targetValue: serializer.fromJson<int>(json['targetValue']),
      xpReward: serializer.fromJson<int>(json['xpReward']),
      completedAt: serializer.fromJson<int?>(json['completedAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'childId': serializer.toJson<String>(childId),
      'date': serializer.toJson<String>(date),
      'slot': serializer.toJson<int>(slot),
      'missionTemplateId': serializer.toJson<String>(missionTemplateId),
      'paramsJson': serializer.toJson<String>(paramsJson),
      'status': serializer.toJson<String>(status),
      'progressValue': serializer.toJson<int>(progressValue),
      'targetValue': serializer.toJson<int>(targetValue),
      'xpReward': serializer.toJson<int>(xpReward),
      'completedAt': serializer.toJson<int?>(completedAt),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  DailyMission copyWith(
          {String? id,
          String? childId,
          String? date,
          int? slot,
          String? missionTemplateId,
          String? paramsJson,
          String? status,
          int? progressValue,
          int? targetValue,
          int? xpReward,
          Value<int?> completedAt = const Value.absent(),
          int? createdAt,
          int? updatedAt,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      DailyMission(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        date: date ?? this.date,
        slot: slot ?? this.slot,
        missionTemplateId: missionTemplateId ?? this.missionTemplateId,
        paramsJson: paramsJson ?? this.paramsJson,
        status: status ?? this.status,
        progressValue: progressValue ?? this.progressValue,
        targetValue: targetValue ?? this.targetValue,
        xpReward: xpReward ?? this.xpReward,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  DailyMission copyWithCompanion(DailyMissionsCompanion data) {
    return DailyMission(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      date: data.date.present ? data.date.value : this.date,
      slot: data.slot.present ? data.slot.value : this.slot,
      missionTemplateId: data.missionTemplateId.present
          ? data.missionTemplateId.value
          : this.missionTemplateId,
      paramsJson:
          data.paramsJson.present ? data.paramsJson.value : this.paramsJson,
      status: data.status.present ? data.status.value : this.status,
      progressValue: data.progressValue.present
          ? data.progressValue.value
          : this.progressValue,
      targetValue:
          data.targetValue.present ? data.targetValue.value : this.targetValue,
      xpReward: data.xpReward.present ? data.xpReward.value : this.xpReward,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyMission(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('date: $date, ')
          ..write('slot: $slot, ')
          ..write('missionTemplateId: $missionTemplateId, ')
          ..write('paramsJson: $paramsJson, ')
          ..write('status: $status, ')
          ..write('progressValue: $progressValue, ')
          ..write('targetValue: $targetValue, ')
          ..write('xpReward: $xpReward, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      childId,
      date,
      slot,
      missionTemplateId,
      paramsJson,
      status,
      progressValue,
      targetValue,
      xpReward,
      completedAt,
      createdAt,
      updatedAt,
      remoteId,
      syncStatus,
      lastSyncedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyMission &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.date == this.date &&
          other.slot == this.slot &&
          other.missionTemplateId == this.missionTemplateId &&
          other.paramsJson == this.paramsJson &&
          other.status == this.status &&
          other.progressValue == this.progressValue &&
          other.targetValue == this.targetValue &&
          other.xpReward == this.xpReward &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class DailyMissionsCompanion extends UpdateCompanion<DailyMission> {
  final Value<String> id;
  final Value<String> childId;
  final Value<String> date;
  final Value<int> slot;
  final Value<String> missionTemplateId;
  final Value<String> paramsJson;
  final Value<String> status;
  final Value<int> progressValue;
  final Value<int> targetValue;
  final Value<int> xpReward;
  final Value<int?> completedAt;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const DailyMissionsCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.date = const Value.absent(),
    this.slot = const Value.absent(),
    this.missionTemplateId = const Value.absent(),
    this.paramsJson = const Value.absent(),
    this.status = const Value.absent(),
    this.progressValue = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyMissionsCompanion.insert({
    required String id,
    required String childId,
    required String date,
    this.slot = const Value.absent(),
    required String missionTemplateId,
    this.paramsJson = const Value.absent(),
    this.status = const Value.absent(),
    this.progressValue = const Value.absent(),
    required int targetValue,
    required int xpReward,
    this.completedAt = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        childId = Value(childId),
        date = Value(date),
        missionTemplateId = Value(missionTemplateId),
        targetValue = Value(targetValue),
        xpReward = Value(xpReward),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<DailyMission> custom({
    Expression<String>? id,
    Expression<String>? childId,
    Expression<String>? date,
    Expression<int>? slot,
    Expression<String>? missionTemplateId,
    Expression<String>? paramsJson,
    Expression<String>? status,
    Expression<int>? progressValue,
    Expression<int>? targetValue,
    Expression<int>? xpReward,
    Expression<int>? completedAt,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (date != null) 'date': date,
      if (slot != null) 'slot': slot,
      if (missionTemplateId != null) 'mission_template_id': missionTemplateId,
      if (paramsJson != null) 'params_json': paramsJson,
      if (status != null) 'status': status,
      if (progressValue != null) 'progress_value': progressValue,
      if (targetValue != null) 'target_value': targetValue,
      if (xpReward != null) 'xp_reward': xpReward,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyMissionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? childId,
      Value<String>? date,
      Value<int>? slot,
      Value<String>? missionTemplateId,
      Value<String>? paramsJson,
      Value<String>? status,
      Value<int>? progressValue,
      Value<int>? targetValue,
      Value<int>? xpReward,
      Value<int?>? completedAt,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return DailyMissionsCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      date: date ?? this.date,
      slot: slot ?? this.slot,
      missionTemplateId: missionTemplateId ?? this.missionTemplateId,
      paramsJson: paramsJson ?? this.paramsJson,
      status: status ?? this.status,
      progressValue: progressValue ?? this.progressValue,
      targetValue: targetValue ?? this.targetValue,
      xpReward: xpReward ?? this.xpReward,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (missionTemplateId.present) {
      map['mission_template_id'] = Variable<String>(missionTemplateId.value);
    }
    if (paramsJson.present) {
      map['params_json'] = Variable<String>(paramsJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (progressValue.present) {
      map['progress_value'] = Variable<int>(progressValue.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<int>(targetValue.value);
    }
    if (xpReward.present) {
      map['xp_reward'] = Variable<int>(xpReward.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<int>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyMissionsCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('date: $date, ')
          ..write('slot: $slot, ')
          ..write('missionTemplateId: $missionTemplateId, ')
          ..write('paramsJson: $paramsJson, ')
          ..write('status: $status, ')
          ..write('progressValue: $progressValue, ')
          ..write('targetValue: $targetValue, ')
          ..write('xpReward: $xpReward, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkillTargetsTable extends SkillTargets
    with TableInfo<$SkillTargetsTable, SkillTarget> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkillTargetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathIdMeta = const VerificationMeta('pathId');
  @override
  late final GeneratedColumn<String> pathId = GeneratedColumn<String>(
      'path_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _skillKeyMeta =
      const VerificationMeta('skillKey');
  @override
  late final GeneratedColumn<String> skillKey = GeneratedColumn<String>(
      'skill_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _requiredUnitsMeta =
      const VerificationMeta('requiredUnits');
  @override
  late final GeneratedColumn<int> requiredUnits = GeneratedColumn<int>(
      'required_units', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _unitTypeMeta =
      const VerificationMeta('unitType');
  @override
  late final GeneratedColumn<String> unitType = GeneratedColumn<String>(
      'unit_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        pathId,
        level,
        skillKey,
        requiredUnits,
        unitType,
        isActive,
        createdAt,
        updatedAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skill_targets';
  @override
  VerificationContext validateIntegrity(Insertable<SkillTarget> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('path_id')) {
      context.handle(_pathIdMeta,
          pathId.isAcceptableOrUnknown(data['path_id']!, _pathIdMeta));
    } else if (isInserting) {
      context.missing(_pathIdMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('skill_key')) {
      context.handle(_skillKeyMeta,
          skillKey.isAcceptableOrUnknown(data['skill_key']!, _skillKeyMeta));
    } else if (isInserting) {
      context.missing(_skillKeyMeta);
    }
    if (data.containsKey('required_units')) {
      context.handle(
          _requiredUnitsMeta,
          requiredUnits.isAcceptableOrUnknown(
              data['required_units']!, _requiredUnitsMeta));
    } else if (isInserting) {
      context.missing(_requiredUnitsMeta);
    }
    if (data.containsKey('unit_type')) {
      context.handle(_unitTypeMeta,
          unitType.isAcceptableOrUnknown(data['unit_type']!, _unitTypeMeta));
    } else if (isInserting) {
      context.missing(_unitTypeMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {pathId, level, skillKey},
      ];
  @override
  SkillTarget map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkillTarget(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      pathId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path_id'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      skillKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}skill_key'])!,
      requiredUnits: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}required_units'])!,
      unitType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_type'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $SkillTargetsTable createAlias(String alias) {
    return $SkillTargetsTable(attachedDatabase, alias);
  }
}

class SkillTarget extends DataClass implements Insertable<SkillTarget> {
  final String id;
  final String pathId;
  final int level;
  final String skillKey;
  final int requiredUnits;
  final String unitType;
  final bool isActive;
  final int createdAt;
  final int updatedAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const SkillTarget(
      {required this.id,
      required this.pathId,
      required this.level,
      required this.skillKey,
      required this.requiredUnits,
      required this.unitType,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['path_id'] = Variable<String>(pathId);
    map['level'] = Variable<int>(level);
    map['skill_key'] = Variable<String>(skillKey);
    map['required_units'] = Variable<int>(requiredUnits);
    map['unit_type'] = Variable<String>(unitType);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  SkillTargetsCompanion toCompanion(bool nullToAbsent) {
    return SkillTargetsCompanion(
      id: Value(id),
      pathId: Value(pathId),
      level: Value(level),
      skillKey: Value(skillKey),
      requiredUnits: Value(requiredUnits),
      unitType: Value(unitType),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory SkillTarget.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkillTarget(
      id: serializer.fromJson<String>(json['id']),
      pathId: serializer.fromJson<String>(json['pathId']),
      level: serializer.fromJson<int>(json['level']),
      skillKey: serializer.fromJson<String>(json['skillKey']),
      requiredUnits: serializer.fromJson<int>(json['requiredUnits']),
      unitType: serializer.fromJson<String>(json['unitType']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pathId': serializer.toJson<String>(pathId),
      'level': serializer.toJson<int>(level),
      'skillKey': serializer.toJson<String>(skillKey),
      'requiredUnits': serializer.toJson<int>(requiredUnits),
      'unitType': serializer.toJson<String>(unitType),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  SkillTarget copyWith(
          {String? id,
          String? pathId,
          int? level,
          String? skillKey,
          int? requiredUnits,
          String? unitType,
          bool? isActive,
          int? createdAt,
          int? updatedAt,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      SkillTarget(
        id: id ?? this.id,
        pathId: pathId ?? this.pathId,
        level: level ?? this.level,
        skillKey: skillKey ?? this.skillKey,
        requiredUnits: requiredUnits ?? this.requiredUnits,
        unitType: unitType ?? this.unitType,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  SkillTarget copyWithCompanion(SkillTargetsCompanion data) {
    return SkillTarget(
      id: data.id.present ? data.id.value : this.id,
      pathId: data.pathId.present ? data.pathId.value : this.pathId,
      level: data.level.present ? data.level.value : this.level,
      skillKey: data.skillKey.present ? data.skillKey.value : this.skillKey,
      requiredUnits: data.requiredUnits.present
          ? data.requiredUnits.value
          : this.requiredUnits,
      unitType: data.unitType.present ? data.unitType.value : this.unitType,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkillTarget(')
          ..write('id: $id, ')
          ..write('pathId: $pathId, ')
          ..write('level: $level, ')
          ..write('skillKey: $skillKey, ')
          ..write('requiredUnits: $requiredUnits, ')
          ..write('unitType: $unitType, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      pathId,
      level,
      skillKey,
      requiredUnits,
      unitType,
      isActive,
      createdAt,
      updatedAt,
      remoteId,
      syncStatus,
      lastSyncedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkillTarget &&
          other.id == this.id &&
          other.pathId == this.pathId &&
          other.level == this.level &&
          other.skillKey == this.skillKey &&
          other.requiredUnits == this.requiredUnits &&
          other.unitType == this.unitType &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class SkillTargetsCompanion extends UpdateCompanion<SkillTarget> {
  final Value<String> id;
  final Value<String> pathId;
  final Value<int> level;
  final Value<String> skillKey;
  final Value<int> requiredUnits;
  final Value<String> unitType;
  final Value<bool> isActive;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const SkillTargetsCompanion({
    this.id = const Value.absent(),
    this.pathId = const Value.absent(),
    this.level = const Value.absent(),
    this.skillKey = const Value.absent(),
    this.requiredUnits = const Value.absent(),
    this.unitType = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkillTargetsCompanion.insert({
    required String id,
    required String pathId,
    required int level,
    required String skillKey,
    required int requiredUnits,
    required String unitType,
    this.isActive = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        pathId = Value(pathId),
        level = Value(level),
        skillKey = Value(skillKey),
        requiredUnits = Value(requiredUnits),
        unitType = Value(unitType),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SkillTarget> custom({
    Expression<String>? id,
    Expression<String>? pathId,
    Expression<int>? level,
    Expression<String>? skillKey,
    Expression<int>? requiredUnits,
    Expression<String>? unitType,
    Expression<bool>? isActive,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pathId != null) 'path_id': pathId,
      if (level != null) 'level': level,
      if (skillKey != null) 'skill_key': skillKey,
      if (requiredUnits != null) 'required_units': requiredUnits,
      if (unitType != null) 'unit_type': unitType,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkillTargetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? pathId,
      Value<int>? level,
      Value<String>? skillKey,
      Value<int>? requiredUnits,
      Value<String>? unitType,
      Value<bool>? isActive,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return SkillTargetsCompanion(
      id: id ?? this.id,
      pathId: pathId ?? this.pathId,
      level: level ?? this.level,
      skillKey: skillKey ?? this.skillKey,
      requiredUnits: requiredUnits ?? this.requiredUnits,
      unitType: unitType ?? this.unitType,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pathId.present) {
      map['path_id'] = Variable<String>(pathId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (skillKey.present) {
      map['skill_key'] = Variable<String>(skillKey.value);
    }
    if (requiredUnits.present) {
      map['required_units'] = Variable<int>(requiredUnits.value);
    }
    if (unitType.present) {
      map['unit_type'] = Variable<String>(unitType.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkillTargetsCompanion(')
          ..write('id: $id, ')
          ..write('pathId: $pathId, ')
          ..write('level: $level, ')
          ..write('skillKey: $skillKey, ')
          ..write('requiredUnits: $requiredUnits, ')
          ..write('unitType: $unitType, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkillProgressEntriesTable extends SkillProgressEntries
    with TableInfo<$SkillProgressEntriesTable, SkillProgressEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkillProgressEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
      'child_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathIdMeta = const VerificationMeta('pathId');
  @override
  late final GeneratedColumn<String> pathId = GeneratedColumn<String>(
      'path_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _skillKeyMeta =
      const VerificationMeta('skillKey');
  @override
  late final GeneratedColumn<String> skillKey = GeneratedColumn<String>(
      'skill_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _completedUnitsMeta =
      const VerificationMeta('completedUnits');
  @override
  late final GeneratedColumn<int> completedUnits = GeneratedColumn<int>(
      'completed_units', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _requiredUnitsMeta =
      const VerificationMeta('requiredUnits');
  @override
  late final GeneratedColumn<int> requiredUnits = GeneratedColumn<int>(
      'required_units', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _progressPercentMeta =
      const VerificationMeta('progressPercent');
  @override
  late final GeneratedColumn<double> progressPercent = GeneratedColumn<double>(
      'progress_percent', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _correctCountMeta =
      const VerificationMeta('correctCount');
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
      'correct_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _attemptCountMeta =
      const VerificationMeta('attemptCount');
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
      'attempt_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _earnedXpMeta =
      const VerificationMeta('earnedXp');
  @override
  late final GeneratedColumn<int> earnedXp = GeneratedColumn<int>(
      'earned_xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        pathId,
        level,
        skillKey,
        completedUnits,
        requiredUnits,
        progressPercent,
        correctCount,
        attemptCount,
        earnedXp,
        updatedAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skill_progress';
  @override
  VerificationContext validateIntegrity(Insertable<SkillProgressEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('path_id')) {
      context.handle(_pathIdMeta,
          pathId.isAcceptableOrUnknown(data['path_id']!, _pathIdMeta));
    } else if (isInserting) {
      context.missing(_pathIdMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('skill_key')) {
      context.handle(_skillKeyMeta,
          skillKey.isAcceptableOrUnknown(data['skill_key']!, _skillKeyMeta));
    } else if (isInserting) {
      context.missing(_skillKeyMeta);
    }
    if (data.containsKey('completed_units')) {
      context.handle(
          _completedUnitsMeta,
          completedUnits.isAcceptableOrUnknown(
              data['completed_units']!, _completedUnitsMeta));
    }
    if (data.containsKey('required_units')) {
      context.handle(
          _requiredUnitsMeta,
          requiredUnits.isAcceptableOrUnknown(
              data['required_units']!, _requiredUnitsMeta));
    } else if (isInserting) {
      context.missing(_requiredUnitsMeta);
    }
    if (data.containsKey('progress_percent')) {
      context.handle(
          _progressPercentMeta,
          progressPercent.isAcceptableOrUnknown(
              data['progress_percent']!, _progressPercentMeta));
    }
    if (data.containsKey('correct_count')) {
      context.handle(
          _correctCountMeta,
          correctCount.isAcceptableOrUnknown(
              data['correct_count']!, _correctCountMeta));
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
          _attemptCountMeta,
          attemptCount.isAcceptableOrUnknown(
              data['attempt_count']!, _attemptCountMeta));
    }
    if (data.containsKey('earned_xp')) {
      context.handle(_earnedXpMeta,
          earnedXp.isAcceptableOrUnknown(data['earned_xp']!, _earnedXpMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {childId, pathId, level, skillKey},
      ];
  @override
  SkillProgressEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkillProgressEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}child_id'])!,
      pathId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path_id'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      skillKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}skill_key'])!,
      completedUnits: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}completed_units'])!,
      requiredUnits: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}required_units'])!,
      progressPercent: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}progress_percent'])!,
      correctCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}correct_count'])!,
      attemptCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempt_count'])!,
      earnedXp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}earned_xp'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $SkillProgressEntriesTable createAlias(String alias) {
    return $SkillProgressEntriesTable(attachedDatabase, alias);
  }
}

class SkillProgressEntry extends DataClass
    implements Insertable<SkillProgressEntry> {
  final String id;
  final String childId;
  final String pathId;
  final int level;
  final String skillKey;
  final int completedUnits;
  final int requiredUnits;
  final double progressPercent;
  final int correctCount;
  final int attemptCount;
  final int earnedXp;
  final int updatedAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const SkillProgressEntry(
      {required this.id,
      required this.childId,
      required this.pathId,
      required this.level,
      required this.skillKey,
      required this.completedUnits,
      required this.requiredUnits,
      required this.progressPercent,
      required this.correctCount,
      required this.attemptCount,
      required this.earnedXp,
      required this.updatedAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['child_id'] = Variable<String>(childId);
    map['path_id'] = Variable<String>(pathId);
    map['level'] = Variable<int>(level);
    map['skill_key'] = Variable<String>(skillKey);
    map['completed_units'] = Variable<int>(completedUnits);
    map['required_units'] = Variable<int>(requiredUnits);
    map['progress_percent'] = Variable<double>(progressPercent);
    map['correct_count'] = Variable<int>(correctCount);
    map['attempt_count'] = Variable<int>(attemptCount);
    map['earned_xp'] = Variable<int>(earnedXp);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  SkillProgressEntriesCompanion toCompanion(bool nullToAbsent) {
    return SkillProgressEntriesCompanion(
      id: Value(id),
      childId: Value(childId),
      pathId: Value(pathId),
      level: Value(level),
      skillKey: Value(skillKey),
      completedUnits: Value(completedUnits),
      requiredUnits: Value(requiredUnits),
      progressPercent: Value(progressPercent),
      correctCount: Value(correctCount),
      attemptCount: Value(attemptCount),
      earnedXp: Value(earnedXp),
      updatedAt: Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory SkillProgressEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkillProgressEntry(
      id: serializer.fromJson<String>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      pathId: serializer.fromJson<String>(json['pathId']),
      level: serializer.fromJson<int>(json['level']),
      skillKey: serializer.fromJson<String>(json['skillKey']),
      completedUnits: serializer.fromJson<int>(json['completedUnits']),
      requiredUnits: serializer.fromJson<int>(json['requiredUnits']),
      progressPercent: serializer.fromJson<double>(json['progressPercent']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      earnedXp: serializer.fromJson<int>(json['earnedXp']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'childId': serializer.toJson<String>(childId),
      'pathId': serializer.toJson<String>(pathId),
      'level': serializer.toJson<int>(level),
      'skillKey': serializer.toJson<String>(skillKey),
      'completedUnits': serializer.toJson<int>(completedUnits),
      'requiredUnits': serializer.toJson<int>(requiredUnits),
      'progressPercent': serializer.toJson<double>(progressPercent),
      'correctCount': serializer.toJson<int>(correctCount),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'earnedXp': serializer.toJson<int>(earnedXp),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  SkillProgressEntry copyWith(
          {String? id,
          String? childId,
          String? pathId,
          int? level,
          String? skillKey,
          int? completedUnits,
          int? requiredUnits,
          double? progressPercent,
          int? correctCount,
          int? attemptCount,
          int? earnedXp,
          int? updatedAt,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      SkillProgressEntry(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        pathId: pathId ?? this.pathId,
        level: level ?? this.level,
        skillKey: skillKey ?? this.skillKey,
        completedUnits: completedUnits ?? this.completedUnits,
        requiredUnits: requiredUnits ?? this.requiredUnits,
        progressPercent: progressPercent ?? this.progressPercent,
        correctCount: correctCount ?? this.correctCount,
        attemptCount: attemptCount ?? this.attemptCount,
        earnedXp: earnedXp ?? this.earnedXp,
        updatedAt: updatedAt ?? this.updatedAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  SkillProgressEntry copyWithCompanion(SkillProgressEntriesCompanion data) {
    return SkillProgressEntry(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      pathId: data.pathId.present ? data.pathId.value : this.pathId,
      level: data.level.present ? data.level.value : this.level,
      skillKey: data.skillKey.present ? data.skillKey.value : this.skillKey,
      completedUnits: data.completedUnits.present
          ? data.completedUnits.value
          : this.completedUnits,
      requiredUnits: data.requiredUnits.present
          ? data.requiredUnits.value
          : this.requiredUnits,
      progressPercent: data.progressPercent.present
          ? data.progressPercent.value
          : this.progressPercent,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      earnedXp: data.earnedXp.present ? data.earnedXp.value : this.earnedXp,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkillProgressEntry(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('pathId: $pathId, ')
          ..write('level: $level, ')
          ..write('skillKey: $skillKey, ')
          ..write('completedUnits: $completedUnits, ')
          ..write('requiredUnits: $requiredUnits, ')
          ..write('progressPercent: $progressPercent, ')
          ..write('correctCount: $correctCount, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('earnedXp: $earnedXp, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      childId,
      pathId,
      level,
      skillKey,
      completedUnits,
      requiredUnits,
      progressPercent,
      correctCount,
      attemptCount,
      earnedXp,
      updatedAt,
      remoteId,
      syncStatus,
      lastSyncedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkillProgressEntry &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.pathId == this.pathId &&
          other.level == this.level &&
          other.skillKey == this.skillKey &&
          other.completedUnits == this.completedUnits &&
          other.requiredUnits == this.requiredUnits &&
          other.progressPercent == this.progressPercent &&
          other.correctCount == this.correctCount &&
          other.attemptCount == this.attemptCount &&
          other.earnedXp == this.earnedXp &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class SkillProgressEntriesCompanion
    extends UpdateCompanion<SkillProgressEntry> {
  final Value<String> id;
  final Value<String> childId;
  final Value<String> pathId;
  final Value<int> level;
  final Value<String> skillKey;
  final Value<int> completedUnits;
  final Value<int> requiredUnits;
  final Value<double> progressPercent;
  final Value<int> correctCount;
  final Value<int> attemptCount;
  final Value<int> earnedXp;
  final Value<int> updatedAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const SkillProgressEntriesCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.pathId = const Value.absent(),
    this.level = const Value.absent(),
    this.skillKey = const Value.absent(),
    this.completedUnits = const Value.absent(),
    this.requiredUnits = const Value.absent(),
    this.progressPercent = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.earnedXp = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkillProgressEntriesCompanion.insert({
    required String id,
    required String childId,
    required String pathId,
    required int level,
    required String skillKey,
    this.completedUnits = const Value.absent(),
    required int requiredUnits,
    this.progressPercent = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.earnedXp = const Value.absent(),
    required int updatedAt,
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        childId = Value(childId),
        pathId = Value(pathId),
        level = Value(level),
        skillKey = Value(skillKey),
        requiredUnits = Value(requiredUnits),
        updatedAt = Value(updatedAt);
  static Insertable<SkillProgressEntry> custom({
    Expression<String>? id,
    Expression<String>? childId,
    Expression<String>? pathId,
    Expression<int>? level,
    Expression<String>? skillKey,
    Expression<int>? completedUnits,
    Expression<int>? requiredUnits,
    Expression<double>? progressPercent,
    Expression<int>? correctCount,
    Expression<int>? attemptCount,
    Expression<int>? earnedXp,
    Expression<int>? updatedAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (pathId != null) 'path_id': pathId,
      if (level != null) 'level': level,
      if (skillKey != null) 'skill_key': skillKey,
      if (completedUnits != null) 'completed_units': completedUnits,
      if (requiredUnits != null) 'required_units': requiredUnits,
      if (progressPercent != null) 'progress_percent': progressPercent,
      if (correctCount != null) 'correct_count': correctCount,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (earnedXp != null) 'earned_xp': earnedXp,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkillProgressEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? childId,
      Value<String>? pathId,
      Value<int>? level,
      Value<String>? skillKey,
      Value<int>? completedUnits,
      Value<int>? requiredUnits,
      Value<double>? progressPercent,
      Value<int>? correctCount,
      Value<int>? attemptCount,
      Value<int>? earnedXp,
      Value<int>? updatedAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return SkillProgressEntriesCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      pathId: pathId ?? this.pathId,
      level: level ?? this.level,
      skillKey: skillKey ?? this.skillKey,
      completedUnits: completedUnits ?? this.completedUnits,
      requiredUnits: requiredUnits ?? this.requiredUnits,
      progressPercent: progressPercent ?? this.progressPercent,
      correctCount: correctCount ?? this.correctCount,
      attemptCount: attemptCount ?? this.attemptCount,
      earnedXp: earnedXp ?? this.earnedXp,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (pathId.present) {
      map['path_id'] = Variable<String>(pathId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (skillKey.present) {
      map['skill_key'] = Variable<String>(skillKey.value);
    }
    if (completedUnits.present) {
      map['completed_units'] = Variable<int>(completedUnits.value);
    }
    if (requiredUnits.present) {
      map['required_units'] = Variable<int>(requiredUnits.value);
    }
    if (progressPercent.present) {
      map['progress_percent'] = Variable<double>(progressPercent.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (earnedXp.present) {
      map['earned_xp'] = Variable<int>(earnedXp.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkillProgressEntriesCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('pathId: $pathId, ')
          ..write('level: $level, ')
          ..write('skillKey: $skillKey, ')
          ..write('completedUnits: $completedUnits, ')
          ..write('requiredUnits: $requiredUnits, ')
          ..write('progressPercent: $progressPercent, ')
          ..write('correctCount: $correctCount, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('earnedXp: $earnedXp, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LevelDefinitionsTable extends LevelDefinitions
    with TableInfo<$LevelDefinitionsTable, LevelDefinition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LevelDefinitionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _xpRequiredMeta =
      const VerificationMeta('xpRequired');
  @override
  late final GeneratedColumn<int> xpRequired = GeneratedColumn<int>(
      'xp_required', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _xpDeltaMeta =
      const VerificationMeta('xpDelta');
  @override
  late final GeneratedColumn<int> xpDelta = GeneratedColumn<int>(
      'xp_delta', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _minAccuracyMeta =
      const VerificationMeta('minAccuracy');
  @override
  late final GeneratedColumn<double> minAccuracy = GeneratedColumn<double>(
      'min_accuracy', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _minWordsMeta =
      const VerificationMeta('minWords');
  @override
  late final GeneratedColumn<int> minWords = GeneratedColumn<int>(
      'min_words', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _badgeRewardIdMeta =
      const VerificationMeta('badgeRewardId');
  @override
  late final GeneratedColumn<String> badgeRewardId = GeneratedColumn<String>(
      'badge_reward_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unlockFeatureMeta =
      const VerificationMeta('unlockFeature');
  @override
  late final GeneratedColumn<String> unlockFeature = GeneratedColumn<String>(
      'unlock_feature', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        level,
        xpRequired,
        xpDelta,
        minAccuracy,
        minWords,
        title,
        badgeRewardId,
        unlockFeature,
        isActive,
        createdAt,
        updatedAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'level_definitions';
  @override
  VerificationContext validateIntegrity(Insertable<LevelDefinition> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('xp_required')) {
      context.handle(
          _xpRequiredMeta,
          xpRequired.isAcceptableOrUnknown(
              data['xp_required']!, _xpRequiredMeta));
    } else if (isInserting) {
      context.missing(_xpRequiredMeta);
    }
    if (data.containsKey('xp_delta')) {
      context.handle(_xpDeltaMeta,
          xpDelta.isAcceptableOrUnknown(data['xp_delta']!, _xpDeltaMeta));
    } else if (isInserting) {
      context.missing(_xpDeltaMeta);
    }
    if (data.containsKey('min_accuracy')) {
      context.handle(
          _minAccuracyMeta,
          minAccuracy.isAcceptableOrUnknown(
              data['min_accuracy']!, _minAccuracyMeta));
    }
    if (data.containsKey('min_words')) {
      context.handle(_minWordsMeta,
          minWords.isAcceptableOrUnknown(data['min_words']!, _minWordsMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('badge_reward_id')) {
      context.handle(
          _badgeRewardIdMeta,
          badgeRewardId.isAcceptableOrUnknown(
              data['badge_reward_id']!, _badgeRewardIdMeta));
    }
    if (data.containsKey('unlock_feature')) {
      context.handle(
          _unlockFeatureMeta,
          unlockFeature.isAcceptableOrUnknown(
              data['unlock_feature']!, _unlockFeatureMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {level};
  @override
  LevelDefinition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LevelDefinition(
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      xpRequired: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp_required'])!,
      xpDelta: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp_delta'])!,
      minAccuracy: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}min_accuracy'])!,
      minWords: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_words'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      badgeRewardId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}badge_reward_id']),
      unlockFeature: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unlock_feature']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $LevelDefinitionsTable createAlias(String alias) {
    return $LevelDefinitionsTable(attachedDatabase, alias);
  }
}

class LevelDefinition extends DataClass implements Insertable<LevelDefinition> {
  final int level;
  final int xpRequired;
  final int xpDelta;
  final double minAccuracy;
  final int minWords;
  final String title;
  final String? badgeRewardId;
  final String? unlockFeature;
  final bool isActive;
  final int createdAt;
  final int updatedAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const LevelDefinition(
      {required this.level,
      required this.xpRequired,
      required this.xpDelta,
      required this.minAccuracy,
      required this.minWords,
      required this.title,
      this.badgeRewardId,
      this.unlockFeature,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['level'] = Variable<int>(level);
    map['xp_required'] = Variable<int>(xpRequired);
    map['xp_delta'] = Variable<int>(xpDelta);
    map['min_accuracy'] = Variable<double>(minAccuracy);
    map['min_words'] = Variable<int>(minWords);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || badgeRewardId != null) {
      map['badge_reward_id'] = Variable<String>(badgeRewardId);
    }
    if (!nullToAbsent || unlockFeature != null) {
      map['unlock_feature'] = Variable<String>(unlockFeature);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  LevelDefinitionsCompanion toCompanion(bool nullToAbsent) {
    return LevelDefinitionsCompanion(
      level: Value(level),
      xpRequired: Value(xpRequired),
      xpDelta: Value(xpDelta),
      minAccuracy: Value(minAccuracy),
      minWords: Value(minWords),
      title: Value(title),
      badgeRewardId: badgeRewardId == null && nullToAbsent
          ? const Value.absent()
          : Value(badgeRewardId),
      unlockFeature: unlockFeature == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockFeature),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory LevelDefinition.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LevelDefinition(
      level: serializer.fromJson<int>(json['level']),
      xpRequired: serializer.fromJson<int>(json['xpRequired']),
      xpDelta: serializer.fromJson<int>(json['xpDelta']),
      minAccuracy: serializer.fromJson<double>(json['minAccuracy']),
      minWords: serializer.fromJson<int>(json['minWords']),
      title: serializer.fromJson<String>(json['title']),
      badgeRewardId: serializer.fromJson<String?>(json['badgeRewardId']),
      unlockFeature: serializer.fromJson<String?>(json['unlockFeature']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'level': serializer.toJson<int>(level),
      'xpRequired': serializer.toJson<int>(xpRequired),
      'xpDelta': serializer.toJson<int>(xpDelta),
      'minAccuracy': serializer.toJson<double>(minAccuracy),
      'minWords': serializer.toJson<int>(minWords),
      'title': serializer.toJson<String>(title),
      'badgeRewardId': serializer.toJson<String?>(badgeRewardId),
      'unlockFeature': serializer.toJson<String?>(unlockFeature),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  LevelDefinition copyWith(
          {int? level,
          int? xpRequired,
          int? xpDelta,
          double? minAccuracy,
          int? minWords,
          String? title,
          Value<String?> badgeRewardId = const Value.absent(),
          Value<String?> unlockFeature = const Value.absent(),
          bool? isActive,
          int? createdAt,
          int? updatedAt,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      LevelDefinition(
        level: level ?? this.level,
        xpRequired: xpRequired ?? this.xpRequired,
        xpDelta: xpDelta ?? this.xpDelta,
        minAccuracy: minAccuracy ?? this.minAccuracy,
        minWords: minWords ?? this.minWords,
        title: title ?? this.title,
        badgeRewardId:
            badgeRewardId.present ? badgeRewardId.value : this.badgeRewardId,
        unlockFeature:
            unlockFeature.present ? unlockFeature.value : this.unlockFeature,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  LevelDefinition copyWithCompanion(LevelDefinitionsCompanion data) {
    return LevelDefinition(
      level: data.level.present ? data.level.value : this.level,
      xpRequired:
          data.xpRequired.present ? data.xpRequired.value : this.xpRequired,
      xpDelta: data.xpDelta.present ? data.xpDelta.value : this.xpDelta,
      minAccuracy:
          data.minAccuracy.present ? data.minAccuracy.value : this.minAccuracy,
      minWords: data.minWords.present ? data.minWords.value : this.minWords,
      title: data.title.present ? data.title.value : this.title,
      badgeRewardId: data.badgeRewardId.present
          ? data.badgeRewardId.value
          : this.badgeRewardId,
      unlockFeature: data.unlockFeature.present
          ? data.unlockFeature.value
          : this.unlockFeature,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LevelDefinition(')
          ..write('level: $level, ')
          ..write('xpRequired: $xpRequired, ')
          ..write('xpDelta: $xpDelta, ')
          ..write('minAccuracy: $minAccuracy, ')
          ..write('minWords: $minWords, ')
          ..write('title: $title, ')
          ..write('badgeRewardId: $badgeRewardId, ')
          ..write('unlockFeature: $unlockFeature, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      level,
      xpRequired,
      xpDelta,
      minAccuracy,
      minWords,
      title,
      badgeRewardId,
      unlockFeature,
      isActive,
      createdAt,
      updatedAt,
      remoteId,
      syncStatus,
      lastSyncedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LevelDefinition &&
          other.level == this.level &&
          other.xpRequired == this.xpRequired &&
          other.xpDelta == this.xpDelta &&
          other.minAccuracy == this.minAccuracy &&
          other.minWords == this.minWords &&
          other.title == this.title &&
          other.badgeRewardId == this.badgeRewardId &&
          other.unlockFeature == this.unlockFeature &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class LevelDefinitionsCompanion extends UpdateCompanion<LevelDefinition> {
  final Value<int> level;
  final Value<int> xpRequired;
  final Value<int> xpDelta;
  final Value<double> minAccuracy;
  final Value<int> minWords;
  final Value<String> title;
  final Value<String?> badgeRewardId;
  final Value<String?> unlockFeature;
  final Value<bool> isActive;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  const LevelDefinitionsCompanion({
    this.level = const Value.absent(),
    this.xpRequired = const Value.absent(),
    this.xpDelta = const Value.absent(),
    this.minAccuracy = const Value.absent(),
    this.minWords = const Value.absent(),
    this.title = const Value.absent(),
    this.badgeRewardId = const Value.absent(),
    this.unlockFeature = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  LevelDefinitionsCompanion.insert({
    this.level = const Value.absent(),
    required int xpRequired,
    required int xpDelta,
    this.minAccuracy = const Value.absent(),
    this.minWords = const Value.absent(),
    required String title,
    this.badgeRewardId = const Value.absent(),
    this.unlockFeature = const Value.absent(),
    this.isActive = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  })  : xpRequired = Value(xpRequired),
        xpDelta = Value(xpDelta),
        title = Value(title),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<LevelDefinition> custom({
    Expression<int>? level,
    Expression<int>? xpRequired,
    Expression<int>? xpDelta,
    Expression<double>? minAccuracy,
    Expression<int>? minWords,
    Expression<String>? title,
    Expression<String>? badgeRewardId,
    Expression<String>? unlockFeature,
    Expression<bool>? isActive,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (level != null) 'level': level,
      if (xpRequired != null) 'xp_required': xpRequired,
      if (xpDelta != null) 'xp_delta': xpDelta,
      if (minAccuracy != null) 'min_accuracy': minAccuracy,
      if (minWords != null) 'min_words': minWords,
      if (title != null) 'title': title,
      if (badgeRewardId != null) 'badge_reward_id': badgeRewardId,
      if (unlockFeature != null) 'unlock_feature': unlockFeature,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  LevelDefinitionsCompanion copyWith(
      {Value<int>? level,
      Value<int>? xpRequired,
      Value<int>? xpDelta,
      Value<double>? minAccuracy,
      Value<int>? minWords,
      Value<String>? title,
      Value<String?>? badgeRewardId,
      Value<String?>? unlockFeature,
      Value<bool>? isActive,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt}) {
    return LevelDefinitionsCompanion(
      level: level ?? this.level,
      xpRequired: xpRequired ?? this.xpRequired,
      xpDelta: xpDelta ?? this.xpDelta,
      minAccuracy: minAccuracy ?? this.minAccuracy,
      minWords: minWords ?? this.minWords,
      title: title ?? this.title,
      badgeRewardId: badgeRewardId ?? this.badgeRewardId,
      unlockFeature: unlockFeature ?? this.unlockFeature,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (xpRequired.present) {
      map['xp_required'] = Variable<int>(xpRequired.value);
    }
    if (xpDelta.present) {
      map['xp_delta'] = Variable<int>(xpDelta.value);
    }
    if (minAccuracy.present) {
      map['min_accuracy'] = Variable<double>(minAccuracy.value);
    }
    if (minWords.present) {
      map['min_words'] = Variable<int>(minWords.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (badgeRewardId.present) {
      map['badge_reward_id'] = Variable<String>(badgeRewardId.value);
    }
    if (unlockFeature.present) {
      map['unlock_feature'] = Variable<String>(unlockFeature.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LevelDefinitionsCompanion(')
          ..write('level: $level, ')
          ..write('xpRequired: $xpRequired, ')
          ..write('xpDelta: $xpDelta, ')
          ..write('minAccuracy: $minAccuracy, ')
          ..write('minWords: $minWords, ')
          ..write('title: $title, ')
          ..write('badgeRewardId: $badgeRewardId, ')
          ..write('unlockFeature: $unlockFeature, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $WordMasteryEntriesTable extends WordMasteryEntries
    with TableInfo<$WordMasteryEntriesTable, WordMasteryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordMasteryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
      'child_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<String> wordId = GeneratedColumn<String>(
      'word_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timesSeenMeta =
      const VerificationMeta('timesSeen');
  @override
  late final GeneratedColumn<int> timesSeen = GeneratedColumn<int>(
      'times_seen', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _timesCorrectMeta =
      const VerificationMeta('timesCorrect');
  @override
  late final GeneratedColumn<int> timesCorrect = GeneratedColumn<int>(
      'times_correct', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _timesWrongMeta =
      const VerificationMeta('timesWrong');
  @override
  late final GeneratedColumn<int> timesWrong = GeneratedColumn<int>(
      'times_wrong', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _masteryScoreMeta =
      const VerificationMeta('masteryScore');
  @override
  late final GeneratedColumn<double> masteryScore = GeneratedColumn<double>(
      'mastery_score', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastSeenAtMeta =
      const VerificationMeta('lastSeenAt');
  @override
  late final GeneratedColumn<int> lastSeenAt = GeneratedColumn<int>(
      'last_seen_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nextReviewAtMeta =
      const VerificationMeta('nextReviewAt');
  @override
  late final GeneratedColumn<int> nextReviewAt = GeneratedColumn<int>(
      'next_review_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('learning'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        childId,
        wordId,
        word,
        timesSeen,
        timesCorrect,
        timesWrong,
        masteryScore,
        lastSeenAt,
        nextReviewAt,
        status,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_mastery';
  @override
  VerificationContext validateIntegrity(Insertable<WordMasteryEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('word_id')) {
      context.handle(_wordIdMeta,
          wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta));
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    }
    if (data.containsKey('times_seen')) {
      context.handle(_timesSeenMeta,
          timesSeen.isAcceptableOrUnknown(data['times_seen']!, _timesSeenMeta));
    }
    if (data.containsKey('times_correct')) {
      context.handle(
          _timesCorrectMeta,
          timesCorrect.isAcceptableOrUnknown(
              data['times_correct']!, _timesCorrectMeta));
    }
    if (data.containsKey('times_wrong')) {
      context.handle(
          _timesWrongMeta,
          timesWrong.isAcceptableOrUnknown(
              data['times_wrong']!, _timesWrongMeta));
    }
    if (data.containsKey('mastery_score')) {
      context.handle(
          _masteryScoreMeta,
          masteryScore.isAcceptableOrUnknown(
              data['mastery_score']!, _masteryScoreMeta));
    }
    if (data.containsKey('last_seen_at')) {
      context.handle(
          _lastSeenAtMeta,
          lastSeenAt.isAcceptableOrUnknown(
              data['last_seen_at']!, _lastSeenAtMeta));
    }
    if (data.containsKey('next_review_at')) {
      context.handle(
          _nextReviewAtMeta,
          nextReviewAt.isAcceptableOrUnknown(
              data['next_review_at']!, _nextReviewAtMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {childId, wordId};
  @override
  WordMasteryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordMasteryEntry(
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}child_id'])!,
      wordId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word_id'])!,
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word']),
      timesSeen: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}times_seen'])!,
      timesCorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}times_correct'])!,
      timesWrong: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}times_wrong'])!,
      masteryScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}mastery_score'])!,
      lastSeenAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_seen_at']),
      nextReviewAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}next_review_at']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $WordMasteryEntriesTable createAlias(String alias) {
    return $WordMasteryEntriesTable(attachedDatabase, alias);
  }
}

class WordMasteryEntry extends DataClass
    implements Insertable<WordMasteryEntry> {
  final String childId;
  final String wordId;
  final String? word;
  final int timesSeen;
  final int timesCorrect;
  final int timesWrong;
  final double masteryScore;
  final int? lastSeenAt;
  final int? nextReviewAt;
  final String status;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const WordMasteryEntry(
      {required this.childId,
      required this.wordId,
      this.word,
      required this.timesSeen,
      required this.timesCorrect,
      required this.timesWrong,
      required this.masteryScore,
      this.lastSeenAt,
      this.nextReviewAt,
      required this.status,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['child_id'] = Variable<String>(childId);
    map['word_id'] = Variable<String>(wordId);
    if (!nullToAbsent || word != null) {
      map['word'] = Variable<String>(word);
    }
    map['times_seen'] = Variable<int>(timesSeen);
    map['times_correct'] = Variable<int>(timesCorrect);
    map['times_wrong'] = Variable<int>(timesWrong);
    map['mastery_score'] = Variable<double>(masteryScore);
    if (!nullToAbsent || lastSeenAt != null) {
      map['last_seen_at'] = Variable<int>(lastSeenAt);
    }
    if (!nullToAbsent || nextReviewAt != null) {
      map['next_review_at'] = Variable<int>(nextReviewAt);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  WordMasteryEntriesCompanion toCompanion(bool nullToAbsent) {
    return WordMasteryEntriesCompanion(
      childId: Value(childId),
      wordId: Value(wordId),
      word: word == null && nullToAbsent ? const Value.absent() : Value(word),
      timesSeen: Value(timesSeen),
      timesCorrect: Value(timesCorrect),
      timesWrong: Value(timesWrong),
      masteryScore: Value(masteryScore),
      lastSeenAt: lastSeenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSeenAt),
      nextReviewAt: nextReviewAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextReviewAt),
      status: Value(status),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory WordMasteryEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordMasteryEntry(
      childId: serializer.fromJson<String>(json['childId']),
      wordId: serializer.fromJson<String>(json['wordId']),
      word: serializer.fromJson<String?>(json['word']),
      timesSeen: serializer.fromJson<int>(json['timesSeen']),
      timesCorrect: serializer.fromJson<int>(json['timesCorrect']),
      timesWrong: serializer.fromJson<int>(json['timesWrong']),
      masteryScore: serializer.fromJson<double>(json['masteryScore']),
      lastSeenAt: serializer.fromJson<int?>(json['lastSeenAt']),
      nextReviewAt: serializer.fromJson<int?>(json['nextReviewAt']),
      status: serializer.fromJson<String>(json['status']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'childId': serializer.toJson<String>(childId),
      'wordId': serializer.toJson<String>(wordId),
      'word': serializer.toJson<String?>(word),
      'timesSeen': serializer.toJson<int>(timesSeen),
      'timesCorrect': serializer.toJson<int>(timesCorrect),
      'timesWrong': serializer.toJson<int>(timesWrong),
      'masteryScore': serializer.toJson<double>(masteryScore),
      'lastSeenAt': serializer.toJson<int?>(lastSeenAt),
      'nextReviewAt': serializer.toJson<int?>(nextReviewAt),
      'status': serializer.toJson<String>(status),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  WordMasteryEntry copyWith(
          {String? childId,
          String? wordId,
          Value<String?> word = const Value.absent(),
          int? timesSeen,
          int? timesCorrect,
          int? timesWrong,
          double? masteryScore,
          Value<int?> lastSeenAt = const Value.absent(),
          Value<int?> nextReviewAt = const Value.absent(),
          String? status,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      WordMasteryEntry(
        childId: childId ?? this.childId,
        wordId: wordId ?? this.wordId,
        word: word.present ? word.value : this.word,
        timesSeen: timesSeen ?? this.timesSeen,
        timesCorrect: timesCorrect ?? this.timesCorrect,
        timesWrong: timesWrong ?? this.timesWrong,
        masteryScore: masteryScore ?? this.masteryScore,
        lastSeenAt: lastSeenAt.present ? lastSeenAt.value : this.lastSeenAt,
        nextReviewAt:
            nextReviewAt.present ? nextReviewAt.value : this.nextReviewAt,
        status: status ?? this.status,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  WordMasteryEntry copyWithCompanion(WordMasteryEntriesCompanion data) {
    return WordMasteryEntry(
      childId: data.childId.present ? data.childId.value : this.childId,
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      word: data.word.present ? data.word.value : this.word,
      timesSeen: data.timesSeen.present ? data.timesSeen.value : this.timesSeen,
      timesCorrect: data.timesCorrect.present
          ? data.timesCorrect.value
          : this.timesCorrect,
      timesWrong:
          data.timesWrong.present ? data.timesWrong.value : this.timesWrong,
      masteryScore: data.masteryScore.present
          ? data.masteryScore.value
          : this.masteryScore,
      lastSeenAt:
          data.lastSeenAt.present ? data.lastSeenAt.value : this.lastSeenAt,
      nextReviewAt: data.nextReviewAt.present
          ? data.nextReviewAt.value
          : this.nextReviewAt,
      status: data.status.present ? data.status.value : this.status,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordMasteryEntry(')
          ..write('childId: $childId, ')
          ..write('wordId: $wordId, ')
          ..write('word: $word, ')
          ..write('timesSeen: $timesSeen, ')
          ..write('timesCorrect: $timesCorrect, ')
          ..write('timesWrong: $timesWrong, ')
          ..write('masteryScore: $masteryScore, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('status: $status, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      childId,
      wordId,
      word,
      timesSeen,
      timesCorrect,
      timesWrong,
      masteryScore,
      lastSeenAt,
      nextReviewAt,
      status,
      remoteId,
      syncStatus,
      lastSyncedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordMasteryEntry &&
          other.childId == this.childId &&
          other.wordId == this.wordId &&
          other.word == this.word &&
          other.timesSeen == this.timesSeen &&
          other.timesCorrect == this.timesCorrect &&
          other.timesWrong == this.timesWrong &&
          other.masteryScore == this.masteryScore &&
          other.lastSeenAt == this.lastSeenAt &&
          other.nextReviewAt == this.nextReviewAt &&
          other.status == this.status &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class WordMasteryEntriesCompanion extends UpdateCompanion<WordMasteryEntry> {
  final Value<String> childId;
  final Value<String> wordId;
  final Value<String?> word;
  final Value<int> timesSeen;
  final Value<int> timesCorrect;
  final Value<int> timesWrong;
  final Value<double> masteryScore;
  final Value<int?> lastSeenAt;
  final Value<int?> nextReviewAt;
  final Value<String> status;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const WordMasteryEntriesCompanion({
    this.childId = const Value.absent(),
    this.wordId = const Value.absent(),
    this.word = const Value.absent(),
    this.timesSeen = const Value.absent(),
    this.timesCorrect = const Value.absent(),
    this.timesWrong = const Value.absent(),
    this.masteryScore = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.status = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordMasteryEntriesCompanion.insert({
    required String childId,
    required String wordId,
    this.word = const Value.absent(),
    this.timesSeen = const Value.absent(),
    this.timesCorrect = const Value.absent(),
    this.timesWrong = const Value.absent(),
    this.masteryScore = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.status = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : childId = Value(childId),
        wordId = Value(wordId);
  static Insertable<WordMasteryEntry> custom({
    Expression<String>? childId,
    Expression<String>? wordId,
    Expression<String>? word,
    Expression<int>? timesSeen,
    Expression<int>? timesCorrect,
    Expression<int>? timesWrong,
    Expression<double>? masteryScore,
    Expression<int>? lastSeenAt,
    Expression<int>? nextReviewAt,
    Expression<String>? status,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (childId != null) 'child_id': childId,
      if (wordId != null) 'word_id': wordId,
      if (word != null) 'word': word,
      if (timesSeen != null) 'times_seen': timesSeen,
      if (timesCorrect != null) 'times_correct': timesCorrect,
      if (timesWrong != null) 'times_wrong': timesWrong,
      if (masteryScore != null) 'mastery_score': masteryScore,
      if (lastSeenAt != null) 'last_seen_at': lastSeenAt,
      if (nextReviewAt != null) 'next_review_at': nextReviewAt,
      if (status != null) 'status': status,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordMasteryEntriesCompanion copyWith(
      {Value<String>? childId,
      Value<String>? wordId,
      Value<String?>? word,
      Value<int>? timesSeen,
      Value<int>? timesCorrect,
      Value<int>? timesWrong,
      Value<double>? masteryScore,
      Value<int?>? lastSeenAt,
      Value<int?>? nextReviewAt,
      Value<String>? status,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return WordMasteryEntriesCompanion(
      childId: childId ?? this.childId,
      wordId: wordId ?? this.wordId,
      word: word ?? this.word,
      timesSeen: timesSeen ?? this.timesSeen,
      timesCorrect: timesCorrect ?? this.timesCorrect,
      timesWrong: timesWrong ?? this.timesWrong,
      masteryScore: masteryScore ?? this.masteryScore,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      status: status ?? this.status,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (wordId.present) {
      map['word_id'] = Variable<String>(wordId.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (timesSeen.present) {
      map['times_seen'] = Variable<int>(timesSeen.value);
    }
    if (timesCorrect.present) {
      map['times_correct'] = Variable<int>(timesCorrect.value);
    }
    if (timesWrong.present) {
      map['times_wrong'] = Variable<int>(timesWrong.value);
    }
    if (masteryScore.present) {
      map['mastery_score'] = Variable<double>(masteryScore.value);
    }
    if (lastSeenAt.present) {
      map['last_seen_at'] = Variable<int>(lastSeenAt.value);
    }
    if (nextReviewAt.present) {
      map['next_review_at'] = Variable<int>(nextReviewAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordMasteryEntriesCompanion(')
          ..write('childId: $childId, ')
          ..write('wordId: $wordId, ')
          ..write('word: $word, ')
          ..write('timesSeen: $timesSeen, ')
          ..write('timesCorrect: $timesCorrect, ')
          ..write('timesWrong: $timesWrong, ')
          ..write('masteryScore: $masteryScore, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('status: $status, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChildProgressEntriesTable extends ChildProgressEntries
    with TableInfo<$ChildProgressEntriesTable, ChildProgressEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChildProgressEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
      'child_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentLevelMeta =
      const VerificationMeta('currentLevel');
  @override
  late final GeneratedColumn<int> currentLevel = GeneratedColumn<int>(
      'current_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _currentXpMeta =
      const VerificationMeta('currentXp');
  @override
  late final GeneratedColumn<int> currentXp = GeneratedColumn<int>(
      'current_xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalXpMeta =
      const VerificationMeta('totalXp');
  @override
  late final GeneratedColumn<int> totalXp = GeneratedColumn<int>(
      'total_xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _xpToNextLevelMeta =
      const VerificationMeta('xpToNextLevel');
  @override
  late final GeneratedColumn<int> xpToNextLevel = GeneratedColumn<int>(
      'xp_to_next_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(150));
  static const VerificationMeta _accuracy7dMeta =
      const VerificationMeta('accuracy7d');
  @override
  late final GeneratedColumn<double> accuracy7d = GeneratedColumn<double>(
      'accuracy7d', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _wordsMasteredMeta =
      const VerificationMeta('wordsMastered');
  @override
  late final GeneratedColumn<int> wordsMastered = GeneratedColumn<int>(
      'words_mastered', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _streakDaysMeta =
      const VerificationMeta('streakDays');
  @override
  late final GeneratedColumn<int> streakDays = GeneratedColumn<int>(
      'streak_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _masteryBlockedMeta =
      const VerificationMeta('masteryBlocked');
  @override
  late final GeneratedColumn<bool> masteryBlocked = GeneratedColumn<bool>(
      'mastery_blocked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("mastery_blocked" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        childId,
        currentLevel,
        currentXp,
        totalXp,
        xpToNextLevel,
        accuracy7d,
        wordsMastered,
        streakDays,
        masteryBlocked,
        updatedAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'child_progress';
  @override
  VerificationContext validateIntegrity(Insertable<ChildProgressEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('current_level')) {
      context.handle(
          _currentLevelMeta,
          currentLevel.isAcceptableOrUnknown(
              data['current_level']!, _currentLevelMeta));
    }
    if (data.containsKey('current_xp')) {
      context.handle(_currentXpMeta,
          currentXp.isAcceptableOrUnknown(data['current_xp']!, _currentXpMeta));
    }
    if (data.containsKey('total_xp')) {
      context.handle(_totalXpMeta,
          totalXp.isAcceptableOrUnknown(data['total_xp']!, _totalXpMeta));
    }
    if (data.containsKey('xp_to_next_level')) {
      context.handle(
          _xpToNextLevelMeta,
          xpToNextLevel.isAcceptableOrUnknown(
              data['xp_to_next_level']!, _xpToNextLevelMeta));
    }
    if (data.containsKey('accuracy7d')) {
      context.handle(
          _accuracy7dMeta,
          accuracy7d.isAcceptableOrUnknown(
              data['accuracy7d']!, _accuracy7dMeta));
    }
    if (data.containsKey('words_mastered')) {
      context.handle(
          _wordsMasteredMeta,
          wordsMastered.isAcceptableOrUnknown(
              data['words_mastered']!, _wordsMasteredMeta));
    }
    if (data.containsKey('streak_days')) {
      context.handle(
          _streakDaysMeta,
          streakDays.isAcceptableOrUnknown(
              data['streak_days']!, _streakDaysMeta));
    }
    if (data.containsKey('mastery_blocked')) {
      context.handle(
          _masteryBlockedMeta,
          masteryBlocked.isAcceptableOrUnknown(
              data['mastery_blocked']!, _masteryBlockedMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {childId};
  @override
  ChildProgressEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChildProgressEntry(
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}child_id'])!,
      currentLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_level'])!,
      currentXp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_xp'])!,
      totalXp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_xp'])!,
      xpToNextLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp_to_next_level'])!,
      accuracy7d: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}accuracy7d'])!,
      wordsMastered: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}words_mastered'])!,
      streakDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak_days'])!,
      masteryBlocked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}mastery_blocked'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $ChildProgressEntriesTable createAlias(String alias) {
    return $ChildProgressEntriesTable(attachedDatabase, alias);
  }
}

class ChildProgressEntry extends DataClass
    implements Insertable<ChildProgressEntry> {
  final String childId;
  final int currentLevel;
  final int currentXp;
  final int totalXp;
  final int xpToNextLevel;
  final double accuracy7d;
  final int wordsMastered;
  final int streakDays;
  final bool masteryBlocked;
  final int updatedAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const ChildProgressEntry(
      {required this.childId,
      required this.currentLevel,
      required this.currentXp,
      required this.totalXp,
      required this.xpToNextLevel,
      required this.accuracy7d,
      required this.wordsMastered,
      required this.streakDays,
      required this.masteryBlocked,
      required this.updatedAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['child_id'] = Variable<String>(childId);
    map['current_level'] = Variable<int>(currentLevel);
    map['current_xp'] = Variable<int>(currentXp);
    map['total_xp'] = Variable<int>(totalXp);
    map['xp_to_next_level'] = Variable<int>(xpToNextLevel);
    map['accuracy7d'] = Variable<double>(accuracy7d);
    map['words_mastered'] = Variable<int>(wordsMastered);
    map['streak_days'] = Variable<int>(streakDays);
    map['mastery_blocked'] = Variable<bool>(masteryBlocked);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  ChildProgressEntriesCompanion toCompanion(bool nullToAbsent) {
    return ChildProgressEntriesCompanion(
      childId: Value(childId),
      currentLevel: Value(currentLevel),
      currentXp: Value(currentXp),
      totalXp: Value(totalXp),
      xpToNextLevel: Value(xpToNextLevel),
      accuracy7d: Value(accuracy7d),
      wordsMastered: Value(wordsMastered),
      streakDays: Value(streakDays),
      masteryBlocked: Value(masteryBlocked),
      updatedAt: Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ChildProgressEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChildProgressEntry(
      childId: serializer.fromJson<String>(json['childId']),
      currentLevel: serializer.fromJson<int>(json['currentLevel']),
      currentXp: serializer.fromJson<int>(json['currentXp']),
      totalXp: serializer.fromJson<int>(json['totalXp']),
      xpToNextLevel: serializer.fromJson<int>(json['xpToNextLevel']),
      accuracy7d: serializer.fromJson<double>(json['accuracy7d']),
      wordsMastered: serializer.fromJson<int>(json['wordsMastered']),
      streakDays: serializer.fromJson<int>(json['streakDays']),
      masteryBlocked: serializer.fromJson<bool>(json['masteryBlocked']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'childId': serializer.toJson<String>(childId),
      'currentLevel': serializer.toJson<int>(currentLevel),
      'currentXp': serializer.toJson<int>(currentXp),
      'totalXp': serializer.toJson<int>(totalXp),
      'xpToNextLevel': serializer.toJson<int>(xpToNextLevel),
      'accuracy7d': serializer.toJson<double>(accuracy7d),
      'wordsMastered': serializer.toJson<int>(wordsMastered),
      'streakDays': serializer.toJson<int>(streakDays),
      'masteryBlocked': serializer.toJson<bool>(masteryBlocked),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  ChildProgressEntry copyWith(
          {String? childId,
          int? currentLevel,
          int? currentXp,
          int? totalXp,
          int? xpToNextLevel,
          double? accuracy7d,
          int? wordsMastered,
          int? streakDays,
          bool? masteryBlocked,
          int? updatedAt,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      ChildProgressEntry(
        childId: childId ?? this.childId,
        currentLevel: currentLevel ?? this.currentLevel,
        currentXp: currentXp ?? this.currentXp,
        totalXp: totalXp ?? this.totalXp,
        xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
        accuracy7d: accuracy7d ?? this.accuracy7d,
        wordsMastered: wordsMastered ?? this.wordsMastered,
        streakDays: streakDays ?? this.streakDays,
        masteryBlocked: masteryBlocked ?? this.masteryBlocked,
        updatedAt: updatedAt ?? this.updatedAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  ChildProgressEntry copyWithCompanion(ChildProgressEntriesCompanion data) {
    return ChildProgressEntry(
      childId: data.childId.present ? data.childId.value : this.childId,
      currentLevel: data.currentLevel.present
          ? data.currentLevel.value
          : this.currentLevel,
      currentXp: data.currentXp.present ? data.currentXp.value : this.currentXp,
      totalXp: data.totalXp.present ? data.totalXp.value : this.totalXp,
      xpToNextLevel: data.xpToNextLevel.present
          ? data.xpToNextLevel.value
          : this.xpToNextLevel,
      accuracy7d:
          data.accuracy7d.present ? data.accuracy7d.value : this.accuracy7d,
      wordsMastered: data.wordsMastered.present
          ? data.wordsMastered.value
          : this.wordsMastered,
      streakDays:
          data.streakDays.present ? data.streakDays.value : this.streakDays,
      masteryBlocked: data.masteryBlocked.present
          ? data.masteryBlocked.value
          : this.masteryBlocked,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChildProgressEntry(')
          ..write('childId: $childId, ')
          ..write('currentLevel: $currentLevel, ')
          ..write('currentXp: $currentXp, ')
          ..write('totalXp: $totalXp, ')
          ..write('xpToNextLevel: $xpToNextLevel, ')
          ..write('accuracy7d: $accuracy7d, ')
          ..write('wordsMastered: $wordsMastered, ')
          ..write('streakDays: $streakDays, ')
          ..write('masteryBlocked: $masteryBlocked, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      childId,
      currentLevel,
      currentXp,
      totalXp,
      xpToNextLevel,
      accuracy7d,
      wordsMastered,
      streakDays,
      masteryBlocked,
      updatedAt,
      remoteId,
      syncStatus,
      lastSyncedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChildProgressEntry &&
          other.childId == this.childId &&
          other.currentLevel == this.currentLevel &&
          other.currentXp == this.currentXp &&
          other.totalXp == this.totalXp &&
          other.xpToNextLevel == this.xpToNextLevel &&
          other.accuracy7d == this.accuracy7d &&
          other.wordsMastered == this.wordsMastered &&
          other.streakDays == this.streakDays &&
          other.masteryBlocked == this.masteryBlocked &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class ChildProgressEntriesCompanion
    extends UpdateCompanion<ChildProgressEntry> {
  final Value<String> childId;
  final Value<int> currentLevel;
  final Value<int> currentXp;
  final Value<int> totalXp;
  final Value<int> xpToNextLevel;
  final Value<double> accuracy7d;
  final Value<int> wordsMastered;
  final Value<int> streakDays;
  final Value<bool> masteryBlocked;
  final Value<int> updatedAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const ChildProgressEntriesCompanion({
    this.childId = const Value.absent(),
    this.currentLevel = const Value.absent(),
    this.currentXp = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.xpToNextLevel = const Value.absent(),
    this.accuracy7d = const Value.absent(),
    this.wordsMastered = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.masteryBlocked = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChildProgressEntriesCompanion.insert({
    required String childId,
    this.currentLevel = const Value.absent(),
    this.currentXp = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.xpToNextLevel = const Value.absent(),
    this.accuracy7d = const Value.absent(),
    this.wordsMastered = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.masteryBlocked = const Value.absent(),
    required int updatedAt,
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : childId = Value(childId),
        updatedAt = Value(updatedAt);
  static Insertable<ChildProgressEntry> custom({
    Expression<String>? childId,
    Expression<int>? currentLevel,
    Expression<int>? currentXp,
    Expression<int>? totalXp,
    Expression<int>? xpToNextLevel,
    Expression<double>? accuracy7d,
    Expression<int>? wordsMastered,
    Expression<int>? streakDays,
    Expression<bool>? masteryBlocked,
    Expression<int>? updatedAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (childId != null) 'child_id': childId,
      if (currentLevel != null) 'current_level': currentLevel,
      if (currentXp != null) 'current_xp': currentXp,
      if (totalXp != null) 'total_xp': totalXp,
      if (xpToNextLevel != null) 'xp_to_next_level': xpToNextLevel,
      if (accuracy7d != null) 'accuracy7d': accuracy7d,
      if (wordsMastered != null) 'words_mastered': wordsMastered,
      if (streakDays != null) 'streak_days': streakDays,
      if (masteryBlocked != null) 'mastery_blocked': masteryBlocked,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChildProgressEntriesCompanion copyWith(
      {Value<String>? childId,
      Value<int>? currentLevel,
      Value<int>? currentXp,
      Value<int>? totalXp,
      Value<int>? xpToNextLevel,
      Value<double>? accuracy7d,
      Value<int>? wordsMastered,
      Value<int>? streakDays,
      Value<bool>? masteryBlocked,
      Value<int>? updatedAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return ChildProgressEntriesCompanion(
      childId: childId ?? this.childId,
      currentLevel: currentLevel ?? this.currentLevel,
      currentXp: currentXp ?? this.currentXp,
      totalXp: totalXp ?? this.totalXp,
      xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
      accuracy7d: accuracy7d ?? this.accuracy7d,
      wordsMastered: wordsMastered ?? this.wordsMastered,
      streakDays: streakDays ?? this.streakDays,
      masteryBlocked: masteryBlocked ?? this.masteryBlocked,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (currentLevel.present) {
      map['current_level'] = Variable<int>(currentLevel.value);
    }
    if (currentXp.present) {
      map['current_xp'] = Variable<int>(currentXp.value);
    }
    if (totalXp.present) {
      map['total_xp'] = Variable<int>(totalXp.value);
    }
    if (xpToNextLevel.present) {
      map['xp_to_next_level'] = Variable<int>(xpToNextLevel.value);
    }
    if (accuracy7d.present) {
      map['accuracy7d'] = Variable<double>(accuracy7d.value);
    }
    if (wordsMastered.present) {
      map['words_mastered'] = Variable<int>(wordsMastered.value);
    }
    if (streakDays.present) {
      map['streak_days'] = Variable<int>(streakDays.value);
    }
    if (masteryBlocked.present) {
      map['mastery_blocked'] = Variable<bool>(masteryBlocked.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChildProgressEntriesCompanion(')
          ..write('childId: $childId, ')
          ..write('currentLevel: $currentLevel, ')
          ..write('currentXp: $currentXp, ')
          ..write('totalXp: $totalXp, ')
          ..write('xpToNextLevel: $xpToNextLevel, ')
          ..write('accuracy7d: $accuracy7d, ')
          ..write('wordsMastered: $wordsMastered, ')
          ..write('streakDays: $streakDays, ')
          ..write('masteryBlocked: $masteryBlocked, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChildSignalsTable extends ChildSignals
    with TableInfo<$ChildSignalsTable, ChildSignal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChildSignalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
      'child_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _accuracy7dMeta =
      const VerificationMeta('accuracy7d');
  @override
  late final GeneratedColumn<double> accuracy7d = GeneratedColumn<double>(
      'accuracy7d', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _accuracyByTopicMeta =
      const VerificationMeta('accuracyByTopic');
  @override
  late final GeneratedColumn<String> accuracyByTopic = GeneratedColumn<String>(
      'accuracy_by_topic', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _accuracyByTypeMeta =
      const VerificationMeta('accuracyByType');
  @override
  late final GeneratedColumn<String> accuracyByType = GeneratedColumn<String>(
      'accuracy_by_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _avgResponseSecMeta =
      const VerificationMeta('avgResponseSec');
  @override
  late final GeneratedColumn<double> avgResponseSec = GeneratedColumn<double>(
      'avg_response_sec', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _weakTopicsMeta =
      const VerificationMeta('weakTopics');
  @override
  late final GeneratedColumn<String> weakTopics = GeneratedColumn<String>(
      'weak_topics', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _dueForReviewMeta =
      const VerificationMeta('dueForReview');
  @override
  late final GeneratedColumn<String> dueForReview = GeneratedColumn<String>(
      'due_for_review', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _daysSinceNewWordsMeta =
      const VerificationMeta('daysSinceNewWords');
  @override
  late final GeneratedColumn<int> daysSinceNewWords = GeneratedColumn<int>(
      'days_since_new_words', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _streakDaysMeta =
      const VerificationMeta('streakDays');
  @override
  late final GeneratedColumn<int> streakDays = GeneratedColumn<int>(
      'streak_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _streakAtRiskMeta =
      const VerificationMeta('streakAtRisk');
  @override
  late final GeneratedColumn<bool> streakAtRisk = GeneratedColumn<bool>(
      'streak_at_risk', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("streak_at_risk" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _missionCompletion7dMeta =
      const VerificationMeta('missionCompletion7d');
  @override
  late final GeneratedColumn<double> missionCompletion7d =
      GeneratedColumn<double>('mission_completion7d', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _preferredMissionTypesMeta =
      const VerificationMeta('preferredMissionTypes');
  @override
  late final GeneratedColumn<String> preferredMissionTypes =
      GeneratedColumn<String>('preferred_mission_types', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _preferredHourMeta =
      const VerificationMeta('preferredHour');
  @override
  late final GeneratedColumn<int> preferredHour = GeneratedColumn<int>(
      'preferred_hour', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(19));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        childId,
        accuracy7d,
        accuracyByTopic,
        accuracyByType,
        avgResponseSec,
        weakTopics,
        dueForReview,
        daysSinceNewWords,
        streakDays,
        streakAtRisk,
        missionCompletion7d,
        preferredMissionTypes,
        preferredHour,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'child_signals';
  @override
  VerificationContext validateIntegrity(Insertable<ChildSignal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('accuracy7d')) {
      context.handle(
          _accuracy7dMeta,
          accuracy7d.isAcceptableOrUnknown(
              data['accuracy7d']!, _accuracy7dMeta));
    }
    if (data.containsKey('accuracy_by_topic')) {
      context.handle(
          _accuracyByTopicMeta,
          accuracyByTopic.isAcceptableOrUnknown(
              data['accuracy_by_topic']!, _accuracyByTopicMeta));
    }
    if (data.containsKey('accuracy_by_type')) {
      context.handle(
          _accuracyByTypeMeta,
          accuracyByType.isAcceptableOrUnknown(
              data['accuracy_by_type']!, _accuracyByTypeMeta));
    }
    if (data.containsKey('avg_response_sec')) {
      context.handle(
          _avgResponseSecMeta,
          avgResponseSec.isAcceptableOrUnknown(
              data['avg_response_sec']!, _avgResponseSecMeta));
    }
    if (data.containsKey('weak_topics')) {
      context.handle(
          _weakTopicsMeta,
          weakTopics.isAcceptableOrUnknown(
              data['weak_topics']!, _weakTopicsMeta));
    }
    if (data.containsKey('due_for_review')) {
      context.handle(
          _dueForReviewMeta,
          dueForReview.isAcceptableOrUnknown(
              data['due_for_review']!, _dueForReviewMeta));
    }
    if (data.containsKey('days_since_new_words')) {
      context.handle(
          _daysSinceNewWordsMeta,
          daysSinceNewWords.isAcceptableOrUnknown(
              data['days_since_new_words']!, _daysSinceNewWordsMeta));
    }
    if (data.containsKey('streak_days')) {
      context.handle(
          _streakDaysMeta,
          streakDays.isAcceptableOrUnknown(
              data['streak_days']!, _streakDaysMeta));
    }
    if (data.containsKey('streak_at_risk')) {
      context.handle(
          _streakAtRiskMeta,
          streakAtRisk.isAcceptableOrUnknown(
              data['streak_at_risk']!, _streakAtRiskMeta));
    }
    if (data.containsKey('mission_completion7d')) {
      context.handle(
          _missionCompletion7dMeta,
          missionCompletion7d.isAcceptableOrUnknown(
              data['mission_completion7d']!, _missionCompletion7dMeta));
    }
    if (data.containsKey('preferred_mission_types')) {
      context.handle(
          _preferredMissionTypesMeta,
          preferredMissionTypes.isAcceptableOrUnknown(
              data['preferred_mission_types']!, _preferredMissionTypesMeta));
    }
    if (data.containsKey('preferred_hour')) {
      context.handle(
          _preferredHourMeta,
          preferredHour.isAcceptableOrUnknown(
              data['preferred_hour']!, _preferredHourMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {childId};
  @override
  ChildSignal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChildSignal(
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}child_id'])!,
      accuracy7d: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}accuracy7d'])!,
      accuracyByTopic: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}accuracy_by_topic'])!,
      accuracyByType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}accuracy_by_type'])!,
      avgResponseSec: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}avg_response_sec'])!,
      weakTopics: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}weak_topics'])!,
      dueForReview: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}due_for_review'])!,
      daysSinceNewWords: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}days_since_new_words'])!,
      streakDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak_days'])!,
      streakAtRisk: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}streak_at_risk'])!,
      missionCompletion7d: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}mission_completion7d'])!,
      preferredMissionTypes: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}preferred_mission_types'])!,
      preferredHour: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}preferred_hour'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ChildSignalsTable createAlias(String alias) {
    return $ChildSignalsTable(attachedDatabase, alias);
  }
}

class ChildSignal extends DataClass implements Insertable<ChildSignal> {
  final String childId;
  final double accuracy7d;
  final String accuracyByTopic;
  final String accuracyByType;
  final double avgResponseSec;
  final String weakTopics;
  final String dueForReview;
  final int daysSinceNewWords;
  final int streakDays;
  final bool streakAtRisk;
  final double missionCompletion7d;
  final String preferredMissionTypes;
  final int preferredHour;
  final int updatedAt;
  const ChildSignal(
      {required this.childId,
      required this.accuracy7d,
      required this.accuracyByTopic,
      required this.accuracyByType,
      required this.avgResponseSec,
      required this.weakTopics,
      required this.dueForReview,
      required this.daysSinceNewWords,
      required this.streakDays,
      required this.streakAtRisk,
      required this.missionCompletion7d,
      required this.preferredMissionTypes,
      required this.preferredHour,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['child_id'] = Variable<String>(childId);
    map['accuracy7d'] = Variable<double>(accuracy7d);
    map['accuracy_by_topic'] = Variable<String>(accuracyByTopic);
    map['accuracy_by_type'] = Variable<String>(accuracyByType);
    map['avg_response_sec'] = Variable<double>(avgResponseSec);
    map['weak_topics'] = Variable<String>(weakTopics);
    map['due_for_review'] = Variable<String>(dueForReview);
    map['days_since_new_words'] = Variable<int>(daysSinceNewWords);
    map['streak_days'] = Variable<int>(streakDays);
    map['streak_at_risk'] = Variable<bool>(streakAtRisk);
    map['mission_completion7d'] = Variable<double>(missionCompletion7d);
    map['preferred_mission_types'] = Variable<String>(preferredMissionTypes);
    map['preferred_hour'] = Variable<int>(preferredHour);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  ChildSignalsCompanion toCompanion(bool nullToAbsent) {
    return ChildSignalsCompanion(
      childId: Value(childId),
      accuracy7d: Value(accuracy7d),
      accuracyByTopic: Value(accuracyByTopic),
      accuracyByType: Value(accuracyByType),
      avgResponseSec: Value(avgResponseSec),
      weakTopics: Value(weakTopics),
      dueForReview: Value(dueForReview),
      daysSinceNewWords: Value(daysSinceNewWords),
      streakDays: Value(streakDays),
      streakAtRisk: Value(streakAtRisk),
      missionCompletion7d: Value(missionCompletion7d),
      preferredMissionTypes: Value(preferredMissionTypes),
      preferredHour: Value(preferredHour),
      updatedAt: Value(updatedAt),
    );
  }

  factory ChildSignal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChildSignal(
      childId: serializer.fromJson<String>(json['childId']),
      accuracy7d: serializer.fromJson<double>(json['accuracy7d']),
      accuracyByTopic: serializer.fromJson<String>(json['accuracyByTopic']),
      accuracyByType: serializer.fromJson<String>(json['accuracyByType']),
      avgResponseSec: serializer.fromJson<double>(json['avgResponseSec']),
      weakTopics: serializer.fromJson<String>(json['weakTopics']),
      dueForReview: serializer.fromJson<String>(json['dueForReview']),
      daysSinceNewWords: serializer.fromJson<int>(json['daysSinceNewWords']),
      streakDays: serializer.fromJson<int>(json['streakDays']),
      streakAtRisk: serializer.fromJson<bool>(json['streakAtRisk']),
      missionCompletion7d:
          serializer.fromJson<double>(json['missionCompletion7d']),
      preferredMissionTypes:
          serializer.fromJson<String>(json['preferredMissionTypes']),
      preferredHour: serializer.fromJson<int>(json['preferredHour']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'childId': serializer.toJson<String>(childId),
      'accuracy7d': serializer.toJson<double>(accuracy7d),
      'accuracyByTopic': serializer.toJson<String>(accuracyByTopic),
      'accuracyByType': serializer.toJson<String>(accuracyByType),
      'avgResponseSec': serializer.toJson<double>(avgResponseSec),
      'weakTopics': serializer.toJson<String>(weakTopics),
      'dueForReview': serializer.toJson<String>(dueForReview),
      'daysSinceNewWords': serializer.toJson<int>(daysSinceNewWords),
      'streakDays': serializer.toJson<int>(streakDays),
      'streakAtRisk': serializer.toJson<bool>(streakAtRisk),
      'missionCompletion7d': serializer.toJson<double>(missionCompletion7d),
      'preferredMissionTypes': serializer.toJson<String>(preferredMissionTypes),
      'preferredHour': serializer.toJson<int>(preferredHour),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  ChildSignal copyWith(
          {String? childId,
          double? accuracy7d,
          String? accuracyByTopic,
          String? accuracyByType,
          double? avgResponseSec,
          String? weakTopics,
          String? dueForReview,
          int? daysSinceNewWords,
          int? streakDays,
          bool? streakAtRisk,
          double? missionCompletion7d,
          String? preferredMissionTypes,
          int? preferredHour,
          int? updatedAt}) =>
      ChildSignal(
        childId: childId ?? this.childId,
        accuracy7d: accuracy7d ?? this.accuracy7d,
        accuracyByTopic: accuracyByTopic ?? this.accuracyByTopic,
        accuracyByType: accuracyByType ?? this.accuracyByType,
        avgResponseSec: avgResponseSec ?? this.avgResponseSec,
        weakTopics: weakTopics ?? this.weakTopics,
        dueForReview: dueForReview ?? this.dueForReview,
        daysSinceNewWords: daysSinceNewWords ?? this.daysSinceNewWords,
        streakDays: streakDays ?? this.streakDays,
        streakAtRisk: streakAtRisk ?? this.streakAtRisk,
        missionCompletion7d: missionCompletion7d ?? this.missionCompletion7d,
        preferredMissionTypes:
            preferredMissionTypes ?? this.preferredMissionTypes,
        preferredHour: preferredHour ?? this.preferredHour,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ChildSignal copyWithCompanion(ChildSignalsCompanion data) {
    return ChildSignal(
      childId: data.childId.present ? data.childId.value : this.childId,
      accuracy7d:
          data.accuracy7d.present ? data.accuracy7d.value : this.accuracy7d,
      accuracyByTopic: data.accuracyByTopic.present
          ? data.accuracyByTopic.value
          : this.accuracyByTopic,
      accuracyByType: data.accuracyByType.present
          ? data.accuracyByType.value
          : this.accuracyByType,
      avgResponseSec: data.avgResponseSec.present
          ? data.avgResponseSec.value
          : this.avgResponseSec,
      weakTopics:
          data.weakTopics.present ? data.weakTopics.value : this.weakTopics,
      dueForReview: data.dueForReview.present
          ? data.dueForReview.value
          : this.dueForReview,
      daysSinceNewWords: data.daysSinceNewWords.present
          ? data.daysSinceNewWords.value
          : this.daysSinceNewWords,
      streakDays:
          data.streakDays.present ? data.streakDays.value : this.streakDays,
      streakAtRisk: data.streakAtRisk.present
          ? data.streakAtRisk.value
          : this.streakAtRisk,
      missionCompletion7d: data.missionCompletion7d.present
          ? data.missionCompletion7d.value
          : this.missionCompletion7d,
      preferredMissionTypes: data.preferredMissionTypes.present
          ? data.preferredMissionTypes.value
          : this.preferredMissionTypes,
      preferredHour: data.preferredHour.present
          ? data.preferredHour.value
          : this.preferredHour,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChildSignal(')
          ..write('childId: $childId, ')
          ..write('accuracy7d: $accuracy7d, ')
          ..write('accuracyByTopic: $accuracyByTopic, ')
          ..write('accuracyByType: $accuracyByType, ')
          ..write('avgResponseSec: $avgResponseSec, ')
          ..write('weakTopics: $weakTopics, ')
          ..write('dueForReview: $dueForReview, ')
          ..write('daysSinceNewWords: $daysSinceNewWords, ')
          ..write('streakDays: $streakDays, ')
          ..write('streakAtRisk: $streakAtRisk, ')
          ..write('missionCompletion7d: $missionCompletion7d, ')
          ..write('preferredMissionTypes: $preferredMissionTypes, ')
          ..write('preferredHour: $preferredHour, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      childId,
      accuracy7d,
      accuracyByTopic,
      accuracyByType,
      avgResponseSec,
      weakTopics,
      dueForReview,
      daysSinceNewWords,
      streakDays,
      streakAtRisk,
      missionCompletion7d,
      preferredMissionTypes,
      preferredHour,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChildSignal &&
          other.childId == this.childId &&
          other.accuracy7d == this.accuracy7d &&
          other.accuracyByTopic == this.accuracyByTopic &&
          other.accuracyByType == this.accuracyByType &&
          other.avgResponseSec == this.avgResponseSec &&
          other.weakTopics == this.weakTopics &&
          other.dueForReview == this.dueForReview &&
          other.daysSinceNewWords == this.daysSinceNewWords &&
          other.streakDays == this.streakDays &&
          other.streakAtRisk == this.streakAtRisk &&
          other.missionCompletion7d == this.missionCompletion7d &&
          other.preferredMissionTypes == this.preferredMissionTypes &&
          other.preferredHour == this.preferredHour &&
          other.updatedAt == this.updatedAt);
}

class ChildSignalsCompanion extends UpdateCompanion<ChildSignal> {
  final Value<String> childId;
  final Value<double> accuracy7d;
  final Value<String> accuracyByTopic;
  final Value<String> accuracyByType;
  final Value<double> avgResponseSec;
  final Value<String> weakTopics;
  final Value<String> dueForReview;
  final Value<int> daysSinceNewWords;
  final Value<int> streakDays;
  final Value<bool> streakAtRisk;
  final Value<double> missionCompletion7d;
  final Value<String> preferredMissionTypes;
  final Value<int> preferredHour;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const ChildSignalsCompanion({
    this.childId = const Value.absent(),
    this.accuracy7d = const Value.absent(),
    this.accuracyByTopic = const Value.absent(),
    this.accuracyByType = const Value.absent(),
    this.avgResponseSec = const Value.absent(),
    this.weakTopics = const Value.absent(),
    this.dueForReview = const Value.absent(),
    this.daysSinceNewWords = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.streakAtRisk = const Value.absent(),
    this.missionCompletion7d = const Value.absent(),
    this.preferredMissionTypes = const Value.absent(),
    this.preferredHour = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChildSignalsCompanion.insert({
    required String childId,
    this.accuracy7d = const Value.absent(),
    this.accuracyByTopic = const Value.absent(),
    this.accuracyByType = const Value.absent(),
    this.avgResponseSec = const Value.absent(),
    this.weakTopics = const Value.absent(),
    this.dueForReview = const Value.absent(),
    this.daysSinceNewWords = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.streakAtRisk = const Value.absent(),
    this.missionCompletion7d = const Value.absent(),
    this.preferredMissionTypes = const Value.absent(),
    this.preferredHour = const Value.absent(),
    required int updatedAt,
    this.rowid = const Value.absent(),
  })  : childId = Value(childId),
        updatedAt = Value(updatedAt);
  static Insertable<ChildSignal> custom({
    Expression<String>? childId,
    Expression<double>? accuracy7d,
    Expression<String>? accuracyByTopic,
    Expression<String>? accuracyByType,
    Expression<double>? avgResponseSec,
    Expression<String>? weakTopics,
    Expression<String>? dueForReview,
    Expression<int>? daysSinceNewWords,
    Expression<int>? streakDays,
    Expression<bool>? streakAtRisk,
    Expression<double>? missionCompletion7d,
    Expression<String>? preferredMissionTypes,
    Expression<int>? preferredHour,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (childId != null) 'child_id': childId,
      if (accuracy7d != null) 'accuracy7d': accuracy7d,
      if (accuracyByTopic != null) 'accuracy_by_topic': accuracyByTopic,
      if (accuracyByType != null) 'accuracy_by_type': accuracyByType,
      if (avgResponseSec != null) 'avg_response_sec': avgResponseSec,
      if (weakTopics != null) 'weak_topics': weakTopics,
      if (dueForReview != null) 'due_for_review': dueForReview,
      if (daysSinceNewWords != null) 'days_since_new_words': daysSinceNewWords,
      if (streakDays != null) 'streak_days': streakDays,
      if (streakAtRisk != null) 'streak_at_risk': streakAtRisk,
      if (missionCompletion7d != null)
        'mission_completion7d': missionCompletion7d,
      if (preferredMissionTypes != null)
        'preferred_mission_types': preferredMissionTypes,
      if (preferredHour != null) 'preferred_hour': preferredHour,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChildSignalsCompanion copyWith(
      {Value<String>? childId,
      Value<double>? accuracy7d,
      Value<String>? accuracyByTopic,
      Value<String>? accuracyByType,
      Value<double>? avgResponseSec,
      Value<String>? weakTopics,
      Value<String>? dueForReview,
      Value<int>? daysSinceNewWords,
      Value<int>? streakDays,
      Value<bool>? streakAtRisk,
      Value<double>? missionCompletion7d,
      Value<String>? preferredMissionTypes,
      Value<int>? preferredHour,
      Value<int>? updatedAt,
      Value<int>? rowid}) {
    return ChildSignalsCompanion(
      childId: childId ?? this.childId,
      accuracy7d: accuracy7d ?? this.accuracy7d,
      accuracyByTopic: accuracyByTopic ?? this.accuracyByTopic,
      accuracyByType: accuracyByType ?? this.accuracyByType,
      avgResponseSec: avgResponseSec ?? this.avgResponseSec,
      weakTopics: weakTopics ?? this.weakTopics,
      dueForReview: dueForReview ?? this.dueForReview,
      daysSinceNewWords: daysSinceNewWords ?? this.daysSinceNewWords,
      streakDays: streakDays ?? this.streakDays,
      streakAtRisk: streakAtRisk ?? this.streakAtRisk,
      missionCompletion7d: missionCompletion7d ?? this.missionCompletion7d,
      preferredMissionTypes:
          preferredMissionTypes ?? this.preferredMissionTypes,
      preferredHour: preferredHour ?? this.preferredHour,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (accuracy7d.present) {
      map['accuracy7d'] = Variable<double>(accuracy7d.value);
    }
    if (accuracyByTopic.present) {
      map['accuracy_by_topic'] = Variable<String>(accuracyByTopic.value);
    }
    if (accuracyByType.present) {
      map['accuracy_by_type'] = Variable<String>(accuracyByType.value);
    }
    if (avgResponseSec.present) {
      map['avg_response_sec'] = Variable<double>(avgResponseSec.value);
    }
    if (weakTopics.present) {
      map['weak_topics'] = Variable<String>(weakTopics.value);
    }
    if (dueForReview.present) {
      map['due_for_review'] = Variable<String>(dueForReview.value);
    }
    if (daysSinceNewWords.present) {
      map['days_since_new_words'] = Variable<int>(daysSinceNewWords.value);
    }
    if (streakDays.present) {
      map['streak_days'] = Variable<int>(streakDays.value);
    }
    if (streakAtRisk.present) {
      map['streak_at_risk'] = Variable<bool>(streakAtRisk.value);
    }
    if (missionCompletion7d.present) {
      map['mission_completion7d'] = Variable<double>(missionCompletion7d.value);
    }
    if (preferredMissionTypes.present) {
      map['preferred_mission_types'] =
          Variable<String>(preferredMissionTypes.value);
    }
    if (preferredHour.present) {
      map['preferred_hour'] = Variable<int>(preferredHour.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChildSignalsCompanion(')
          ..write('childId: $childId, ')
          ..write('accuracy7d: $accuracy7d, ')
          ..write('accuracyByTopic: $accuracyByTopic, ')
          ..write('accuracyByType: $accuracyByType, ')
          ..write('avgResponseSec: $avgResponseSec, ')
          ..write('weakTopics: $weakTopics, ')
          ..write('dueForReview: $dueForReview, ')
          ..write('daysSinceNewWords: $daysSinceNewWords, ')
          ..write('streakDays: $streakDays, ')
          ..write('streakAtRisk: $streakAtRisk, ')
          ..write('missionCompletion7d: $missionCompletion7d, ')
          ..write('preferredMissionTypes: $preferredMissionTypes, ')
          ..write('preferredHour: $preferredHour, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $XpEventsTable extends XpEvents with TableInfo<$XpEventsTable, XpEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $XpEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
      'child_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceTypeMeta =
      const VerificationMeta('sourceType');
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
      'source_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
      'source_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _xpAmountMeta =
      const VerificationMeta('xpAmount');
  @override
  late final GeneratedColumn<int> xpAmount = GeneratedColumn<int>(
      'xp_amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _baseXpMeta = const VerificationMeta('baseXp');
  @override
  late final GeneratedColumn<int> baseXp = GeneratedColumn<int>(
      'base_xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _accuracyMultiplierMeta =
      const VerificationMeta('accuracyMultiplier');
  @override
  late final GeneratedColumn<double> accuracyMultiplier =
      GeneratedColumn<double>('accuracy_multiplier', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(1));
  static const VerificationMeta _streakMultiplierMeta =
      const VerificationMeta('streakMultiplier');
  @override
  late final GeneratedColumn<double> streakMultiplier = GeneratedColumn<double>(
      'streak_multiplier', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _firstTryBonusMeta =
      const VerificationMeta('firstTryBonus');
  @override
  late final GeneratedColumn<int> firstTryBonus = GeneratedColumn<int>(
      'first_try_bonus', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _metadataJsonMeta =
      const VerificationMeta('metadataJson');
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
      'metadata_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        sourceType,
        sourceId,
        xpAmount,
        baseXp,
        accuracyMultiplier,
        streakMultiplier,
        firstTryBonus,
        metadataJson,
        createdAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'xp_events';
  @override
  VerificationContext validateIntegrity(Insertable<XpEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
          _sourceTypeMeta,
          sourceType.isAcceptableOrUnknown(
              data['source_type']!, _sourceTypeMeta));
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('xp_amount')) {
      context.handle(_xpAmountMeta,
          xpAmount.isAcceptableOrUnknown(data['xp_amount']!, _xpAmountMeta));
    } else if (isInserting) {
      context.missing(_xpAmountMeta);
    }
    if (data.containsKey('base_xp')) {
      context.handle(_baseXpMeta,
          baseXp.isAcceptableOrUnknown(data['base_xp']!, _baseXpMeta));
    }
    if (data.containsKey('accuracy_multiplier')) {
      context.handle(
          _accuracyMultiplierMeta,
          accuracyMultiplier.isAcceptableOrUnknown(
              data['accuracy_multiplier']!, _accuracyMultiplierMeta));
    }
    if (data.containsKey('streak_multiplier')) {
      context.handle(
          _streakMultiplierMeta,
          streakMultiplier.isAcceptableOrUnknown(
              data['streak_multiplier']!, _streakMultiplierMeta));
    }
    if (data.containsKey('first_try_bonus')) {
      context.handle(
          _firstTryBonusMeta,
          firstTryBonus.isAcceptableOrUnknown(
              data['first_try_bonus']!, _firstTryBonusMeta));
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
          _metadataJsonMeta,
          metadataJson.isAcceptableOrUnknown(
              data['metadata_json']!, _metadataJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  XpEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return XpEvent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}child_id'])!,
      sourceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_type'])!,
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_id'])!,
      xpAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp_amount'])!,
      baseXp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}base_xp'])!,
      accuracyMultiplier: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}accuracy_multiplier'])!,
      streakMultiplier: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}streak_multiplier'])!,
      firstTryBonus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}first_try_bonus'])!,
      metadataJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $XpEventsTable createAlias(String alias) {
    return $XpEventsTable(attachedDatabase, alias);
  }
}

class XpEvent extends DataClass implements Insertable<XpEvent> {
  final String id;
  final String childId;
  final String sourceType;
  final String sourceId;
  final int xpAmount;
  final int baseXp;
  final double accuracyMultiplier;
  final double streakMultiplier;
  final int firstTryBonus;
  final String? metadataJson;
  final int createdAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const XpEvent(
      {required this.id,
      required this.childId,
      required this.sourceType,
      required this.sourceId,
      required this.xpAmount,
      required this.baseXp,
      required this.accuracyMultiplier,
      required this.streakMultiplier,
      required this.firstTryBonus,
      this.metadataJson,
      required this.createdAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['child_id'] = Variable<String>(childId);
    map['source_type'] = Variable<String>(sourceType);
    map['source_id'] = Variable<String>(sourceId);
    map['xp_amount'] = Variable<int>(xpAmount);
    map['base_xp'] = Variable<int>(baseXp);
    map['accuracy_multiplier'] = Variable<double>(accuracyMultiplier);
    map['streak_multiplier'] = Variable<double>(streakMultiplier);
    map['first_try_bonus'] = Variable<int>(firstTryBonus);
    if (!nullToAbsent || metadataJson != null) {
      map['metadata_json'] = Variable<String>(metadataJson);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  XpEventsCompanion toCompanion(bool nullToAbsent) {
    return XpEventsCompanion(
      id: Value(id),
      childId: Value(childId),
      sourceType: Value(sourceType),
      sourceId: Value(sourceId),
      xpAmount: Value(xpAmount),
      baseXp: Value(baseXp),
      accuracyMultiplier: Value(accuracyMultiplier),
      streakMultiplier: Value(streakMultiplier),
      firstTryBonus: Value(firstTryBonus),
      metadataJson: metadataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataJson),
      createdAt: Value(createdAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory XpEvent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return XpEvent(
      id: serializer.fromJson<String>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      xpAmount: serializer.fromJson<int>(json['xpAmount']),
      baseXp: serializer.fromJson<int>(json['baseXp']),
      accuracyMultiplier:
          serializer.fromJson<double>(json['accuracyMultiplier']),
      streakMultiplier: serializer.fromJson<double>(json['streakMultiplier']),
      firstTryBonus: serializer.fromJson<int>(json['firstTryBonus']),
      metadataJson: serializer.fromJson<String?>(json['metadataJson']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'childId': serializer.toJson<String>(childId),
      'sourceType': serializer.toJson<String>(sourceType),
      'sourceId': serializer.toJson<String>(sourceId),
      'xpAmount': serializer.toJson<int>(xpAmount),
      'baseXp': serializer.toJson<int>(baseXp),
      'accuracyMultiplier': serializer.toJson<double>(accuracyMultiplier),
      'streakMultiplier': serializer.toJson<double>(streakMultiplier),
      'firstTryBonus': serializer.toJson<int>(firstTryBonus),
      'metadataJson': serializer.toJson<String?>(metadataJson),
      'createdAt': serializer.toJson<int>(createdAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  XpEvent copyWith(
          {String? id,
          String? childId,
          String? sourceType,
          String? sourceId,
          int? xpAmount,
          int? baseXp,
          double? accuracyMultiplier,
          double? streakMultiplier,
          int? firstTryBonus,
          Value<String?> metadataJson = const Value.absent(),
          int? createdAt,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      XpEvent(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        sourceType: sourceType ?? this.sourceType,
        sourceId: sourceId ?? this.sourceId,
        xpAmount: xpAmount ?? this.xpAmount,
        baseXp: baseXp ?? this.baseXp,
        accuracyMultiplier: accuracyMultiplier ?? this.accuracyMultiplier,
        streakMultiplier: streakMultiplier ?? this.streakMultiplier,
        firstTryBonus: firstTryBonus ?? this.firstTryBonus,
        metadataJson:
            metadataJson.present ? metadataJson.value : this.metadataJson,
        createdAt: createdAt ?? this.createdAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  XpEvent copyWithCompanion(XpEventsCompanion data) {
    return XpEvent(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      sourceType:
          data.sourceType.present ? data.sourceType.value : this.sourceType,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      xpAmount: data.xpAmount.present ? data.xpAmount.value : this.xpAmount,
      baseXp: data.baseXp.present ? data.baseXp.value : this.baseXp,
      accuracyMultiplier: data.accuracyMultiplier.present
          ? data.accuracyMultiplier.value
          : this.accuracyMultiplier,
      streakMultiplier: data.streakMultiplier.present
          ? data.streakMultiplier.value
          : this.streakMultiplier,
      firstTryBonus: data.firstTryBonus.present
          ? data.firstTryBonus.value
          : this.firstTryBonus,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('XpEvent(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('xpAmount: $xpAmount, ')
          ..write('baseXp: $baseXp, ')
          ..write('accuracyMultiplier: $accuracyMultiplier, ')
          ..write('streakMultiplier: $streakMultiplier, ')
          ..write('firstTryBonus: $firstTryBonus, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      childId,
      sourceType,
      sourceId,
      xpAmount,
      baseXp,
      accuracyMultiplier,
      streakMultiplier,
      firstTryBonus,
      metadataJson,
      createdAt,
      remoteId,
      syncStatus,
      lastSyncedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is XpEvent &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.sourceType == this.sourceType &&
          other.sourceId == this.sourceId &&
          other.xpAmount == this.xpAmount &&
          other.baseXp == this.baseXp &&
          other.accuracyMultiplier == this.accuracyMultiplier &&
          other.streakMultiplier == this.streakMultiplier &&
          other.firstTryBonus == this.firstTryBonus &&
          other.metadataJson == this.metadataJson &&
          other.createdAt == this.createdAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class XpEventsCompanion extends UpdateCompanion<XpEvent> {
  final Value<String> id;
  final Value<String> childId;
  final Value<String> sourceType;
  final Value<String> sourceId;
  final Value<int> xpAmount;
  final Value<int> baseXp;
  final Value<double> accuracyMultiplier;
  final Value<double> streakMultiplier;
  final Value<int> firstTryBonus;
  final Value<String?> metadataJson;
  final Value<int> createdAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const XpEventsCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.xpAmount = const Value.absent(),
    this.baseXp = const Value.absent(),
    this.accuracyMultiplier = const Value.absent(),
    this.streakMultiplier = const Value.absent(),
    this.firstTryBonus = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  XpEventsCompanion.insert({
    required String id,
    required String childId,
    required String sourceType,
    required String sourceId,
    required int xpAmount,
    this.baseXp = const Value.absent(),
    this.accuracyMultiplier = const Value.absent(),
    this.streakMultiplier = const Value.absent(),
    this.firstTryBonus = const Value.absent(),
    this.metadataJson = const Value.absent(),
    required int createdAt,
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        childId = Value(childId),
        sourceType = Value(sourceType),
        sourceId = Value(sourceId),
        xpAmount = Value(xpAmount),
        createdAt = Value(createdAt);
  static Insertable<XpEvent> custom({
    Expression<String>? id,
    Expression<String>? childId,
    Expression<String>? sourceType,
    Expression<String>? sourceId,
    Expression<int>? xpAmount,
    Expression<int>? baseXp,
    Expression<double>? accuracyMultiplier,
    Expression<double>? streakMultiplier,
    Expression<int>? firstTryBonus,
    Expression<String>? metadataJson,
    Expression<int>? createdAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceId != null) 'source_id': sourceId,
      if (xpAmount != null) 'xp_amount': xpAmount,
      if (baseXp != null) 'base_xp': baseXp,
      if (accuracyMultiplier != null) 'accuracy_multiplier': accuracyMultiplier,
      if (streakMultiplier != null) 'streak_multiplier': streakMultiplier,
      if (firstTryBonus != null) 'first_try_bonus': firstTryBonus,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (createdAt != null) 'created_at': createdAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  XpEventsCompanion copyWith(
      {Value<String>? id,
      Value<String>? childId,
      Value<String>? sourceType,
      Value<String>? sourceId,
      Value<int>? xpAmount,
      Value<int>? baseXp,
      Value<double>? accuracyMultiplier,
      Value<double>? streakMultiplier,
      Value<int>? firstTryBonus,
      Value<String?>? metadataJson,
      Value<int>? createdAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return XpEventsCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      xpAmount: xpAmount ?? this.xpAmount,
      baseXp: baseXp ?? this.baseXp,
      accuracyMultiplier: accuracyMultiplier ?? this.accuracyMultiplier,
      streakMultiplier: streakMultiplier ?? this.streakMultiplier,
      firstTryBonus: firstTryBonus ?? this.firstTryBonus,
      metadataJson: metadataJson ?? this.metadataJson,
      createdAt: createdAt ?? this.createdAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (xpAmount.present) {
      map['xp_amount'] = Variable<int>(xpAmount.value);
    }
    if (baseXp.present) {
      map['base_xp'] = Variable<int>(baseXp.value);
    }
    if (accuracyMultiplier.present) {
      map['accuracy_multiplier'] = Variable<double>(accuracyMultiplier.value);
    }
    if (streakMultiplier.present) {
      map['streak_multiplier'] = Variable<double>(streakMultiplier.value);
    }
    if (firstTryBonus.present) {
      map['first_try_bonus'] = Variable<int>(firstTryBonus.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('XpEventsCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('xpAmount: $xpAmount, ')
          ..write('baseXp: $baseXp, ')
          ..write('accuracyMultiplier: $accuracyMultiplier, ')
          ..write('streakMultiplier: $streakMultiplier, ')
          ..write('firstTryBonus: $firstTryBonus, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TitlesTable extends Titles with TableInfo<$TitlesTable, Title> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TitlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<int> tier = GeneratedColumn<int>(
      'tier', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _animationMeta =
      const VerificationMeta('animation');
  @override
  late final GeneratedColumn<String> animation = GeneratedColumn<String>(
      'animation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _flavorTextMeta =
      const VerificationMeta('flavorText');
  @override
  late final GeneratedColumn<String> flavorText = GeneratedColumn<String>(
      'flavor_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unlockConditionJsonMeta =
      const VerificationMeta('unlockConditionJson');
  @override
  late final GeneratedColumn<String> unlockConditionJson =
      GeneratedColumn<String>('unlock_condition_json', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        code,
        name,
        type,
        tier,
        imageUrl,
        animation,
        colorHex,
        description,
        flavorText,
        unlockConditionJson,
        priority,
        isActive,
        createdAt,
        updatedAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'titles';
  @override
  VerificationContext validateIntegrity(Insertable<Title> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('tier')) {
      context.handle(
          _tierMeta, tier.isAcceptableOrUnknown(data['tier']!, _tierMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('animation')) {
      context.handle(_animationMeta,
          animation.isAcceptableOrUnknown(data['animation']!, _animationMeta));
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('flavor_text')) {
      context.handle(
          _flavorTextMeta,
          flavorText.isAcceptableOrUnknown(
              data['flavor_text']!, _flavorTextMeta));
    }
    if (data.containsKey('unlock_condition_json')) {
      context.handle(
          _unlockConditionJsonMeta,
          unlockConditionJson.isAcceptableOrUnknown(
              data['unlock_condition_json']!, _unlockConditionJsonMeta));
    } else if (isInserting) {
      context.missing(_unlockConditionJsonMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Title map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Title(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      tier: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tier']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      animation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}animation']),
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      flavorText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}flavor_text']),
      unlockConditionJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}unlock_condition_json'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $TitlesTable createAlias(String alias) {
    return $TitlesTable(attachedDatabase, alias);
  }
}

class Title extends DataClass implements Insertable<Title> {
  final String id;
  final String code;
  final String name;
  final String type;
  final int? tier;
  final String? imageUrl;
  final String? animation;
  final String? colorHex;
  final String? description;
  final String? flavorText;
  final String unlockConditionJson;
  final int priority;
  final bool isActive;
  final int createdAt;
  final int updatedAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const Title(
      {required this.id,
      required this.code,
      required this.name,
      required this.type,
      this.tier,
      this.imageUrl,
      this.animation,
      this.colorHex,
      this.description,
      this.flavorText,
      required this.unlockConditionJson,
      required this.priority,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || tier != null) {
      map['tier'] = Variable<int>(tier);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || animation != null) {
      map['animation'] = Variable<String>(animation);
    }
    if (!nullToAbsent || colorHex != null) {
      map['color_hex'] = Variable<String>(colorHex);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || flavorText != null) {
      map['flavor_text'] = Variable<String>(flavorText);
    }
    map['unlock_condition_json'] = Variable<String>(unlockConditionJson);
    map['priority'] = Variable<int>(priority);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  TitlesCompanion toCompanion(bool nullToAbsent) {
    return TitlesCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      type: Value(type),
      tier: tier == null && nullToAbsent ? const Value.absent() : Value(tier),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      animation: animation == null && nullToAbsent
          ? const Value.absent()
          : Value(animation),
      colorHex: colorHex == null && nullToAbsent
          ? const Value.absent()
          : Value(colorHex),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      flavorText: flavorText == null && nullToAbsent
          ? const Value.absent()
          : Value(flavorText),
      unlockConditionJson: Value(unlockConditionJson),
      priority: Value(priority),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Title.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Title(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      tier: serializer.fromJson<int?>(json['tier']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      animation: serializer.fromJson<String?>(json['animation']),
      colorHex: serializer.fromJson<String?>(json['colorHex']),
      description: serializer.fromJson<String?>(json['description']),
      flavorText: serializer.fromJson<String?>(json['flavorText']),
      unlockConditionJson:
          serializer.fromJson<String>(json['unlockConditionJson']),
      priority: serializer.fromJson<int>(json['priority']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'tier': serializer.toJson<int?>(tier),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'animation': serializer.toJson<String?>(animation),
      'colorHex': serializer.toJson<String?>(colorHex),
      'description': serializer.toJson<String?>(description),
      'flavorText': serializer.toJson<String?>(flavorText),
      'unlockConditionJson': serializer.toJson<String>(unlockConditionJson),
      'priority': serializer.toJson<int>(priority),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  Title copyWith(
          {String? id,
          String? code,
          String? name,
          String? type,
          Value<int?> tier = const Value.absent(),
          Value<String?> imageUrl = const Value.absent(),
          Value<String?> animation = const Value.absent(),
          Value<String?> colorHex = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> flavorText = const Value.absent(),
          String? unlockConditionJson,
          int? priority,
          bool? isActive,
          int? createdAt,
          int? updatedAt,
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      Title(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        type: type ?? this.type,
        tier: tier.present ? tier.value : this.tier,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        animation: animation.present ? animation.value : this.animation,
        colorHex: colorHex.present ? colorHex.value : this.colorHex,
        description: description.present ? description.value : this.description,
        flavorText: flavorText.present ? flavorText.value : this.flavorText,
        unlockConditionJson: unlockConditionJson ?? this.unlockConditionJson,
        priority: priority ?? this.priority,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Title copyWithCompanion(TitlesCompanion data) {
    return Title(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      tier: data.tier.present ? data.tier.value : this.tier,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      animation: data.animation.present ? data.animation.value : this.animation,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      description:
          data.description.present ? data.description.value : this.description,
      flavorText:
          data.flavorText.present ? data.flavorText.value : this.flavorText,
      unlockConditionJson: data.unlockConditionJson.present
          ? data.unlockConditionJson.value
          : this.unlockConditionJson,
      priority: data.priority.present ? data.priority.value : this.priority,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Title(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('tier: $tier, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('animation: $animation, ')
          ..write('colorHex: $colorHex, ')
          ..write('description: $description, ')
          ..write('flavorText: $flavorText, ')
          ..write('unlockConditionJson: $unlockConditionJson, ')
          ..write('priority: $priority, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      code,
      name,
      type,
      tier,
      imageUrl,
      animation,
      colorHex,
      description,
      flavorText,
      unlockConditionJson,
      priority,
      isActive,
      createdAt,
      updatedAt,
      remoteId,
      syncStatus,
      lastSyncedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Title &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.type == this.type &&
          other.tier == this.tier &&
          other.imageUrl == this.imageUrl &&
          other.animation == this.animation &&
          other.colorHex == this.colorHex &&
          other.description == this.description &&
          other.flavorText == this.flavorText &&
          other.unlockConditionJson == this.unlockConditionJson &&
          other.priority == this.priority &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class TitlesCompanion extends UpdateCompanion<Title> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> name;
  final Value<String> type;
  final Value<int?> tier;
  final Value<String?> imageUrl;
  final Value<String?> animation;
  final Value<String?> colorHex;
  final Value<String?> description;
  final Value<String?> flavorText;
  final Value<String> unlockConditionJson;
  final Value<int> priority;
  final Value<bool> isActive;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const TitlesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.tier = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.animation = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.description = const Value.absent(),
    this.flavorText = const Value.absent(),
    this.unlockConditionJson = const Value.absent(),
    this.priority = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TitlesCompanion.insert({
    required String id,
    required String code,
    required String name,
    required String type,
    this.tier = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.animation = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.description = const Value.absent(),
    this.flavorText = const Value.absent(),
    required String unlockConditionJson,
    this.priority = const Value.absent(),
    this.isActive = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        code = Value(code),
        name = Value(name),
        type = Value(type),
        unlockConditionJson = Value(unlockConditionJson),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Title> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? tier,
    Expression<String>? imageUrl,
    Expression<String>? animation,
    Expression<String>? colorHex,
    Expression<String>? description,
    Expression<String>? flavorText,
    Expression<String>? unlockConditionJson,
    Expression<int>? priority,
    Expression<bool>? isActive,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (tier != null) 'tier': tier,
      if (imageUrl != null) 'image_url': imageUrl,
      if (animation != null) 'animation': animation,
      if (colorHex != null) 'color_hex': colorHex,
      if (description != null) 'description': description,
      if (flavorText != null) 'flavor_text': flavorText,
      if (unlockConditionJson != null)
        'unlock_condition_json': unlockConditionJson,
      if (priority != null) 'priority': priority,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TitlesCompanion copyWith(
      {Value<String>? id,
      Value<String>? code,
      Value<String>? name,
      Value<String>? type,
      Value<int?>? tier,
      Value<String?>? imageUrl,
      Value<String?>? animation,
      Value<String?>? colorHex,
      Value<String?>? description,
      Value<String?>? flavorText,
      Value<String>? unlockConditionJson,
      Value<int>? priority,
      Value<bool>? isActive,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return TitlesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
      tier: tier ?? this.tier,
      imageUrl: imageUrl ?? this.imageUrl,
      animation: animation ?? this.animation,
      colorHex: colorHex ?? this.colorHex,
      description: description ?? this.description,
      flavorText: flavorText ?? this.flavorText,
      unlockConditionJson: unlockConditionJson ?? this.unlockConditionJson,
      priority: priority ?? this.priority,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (tier.present) {
      map['tier'] = Variable<int>(tier.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (animation.present) {
      map['animation'] = Variable<String>(animation.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (flavorText.present) {
      map['flavor_text'] = Variable<String>(flavorText.value);
    }
    if (unlockConditionJson.present) {
      map['unlock_condition_json'] =
          Variable<String>(unlockConditionJson.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TitlesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('tier: $tier, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('animation: $animation, ')
          ..write('colorHex: $colorHex, ')
          ..write('description: $description, ')
          ..write('flavorText: $flavorText, ')
          ..write('unlockConditionJson: $unlockConditionJson, ')
          ..write('priority: $priority, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChildTitlesTable extends ChildTitles
    with TableInfo<$ChildTitlesTable, ChildTitle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChildTitlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
      'child_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleIdMeta =
      const VerificationMeta('titleId');
  @override
  late final GeneratedColumn<String> titleId = GeneratedColumn<String>(
      'title_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleTypeMeta =
      const VerificationMeta('titleType');
  @override
  late final GeneratedColumn<String> titleType = GeneratedColumn<String>(
      'title_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unlockedAtMeta =
      const VerificationMeta('unlockedAt');
  @override
  late final GeneratedColumn<int> unlockedAt = GeneratedColumn<int>(
      'unlocked_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isEquippedMeta =
      const VerificationMeta('isEquipped');
  @override
  late final GeneratedColumn<bool> isEquipped = GeneratedColumn<bool>(
      'is_equipped', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_equipped" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _equippedAtMeta =
      const VerificationMeta('equippedAt');
  @override
  late final GeneratedColumn<int> equippedAt = GeneratedColumn<int>(
      'equipped_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        titleId,
        titleType,
        unlockedAt,
        isEquipped,
        equippedAt,
        remoteId,
        syncStatus,
        lastSyncedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'child_titles';
  @override
  VerificationContext validateIntegrity(Insertable<ChildTitle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('title_id')) {
      context.handle(_titleIdMeta,
          titleId.isAcceptableOrUnknown(data['title_id']!, _titleIdMeta));
    } else if (isInserting) {
      context.missing(_titleIdMeta);
    }
    if (data.containsKey('title_type')) {
      context.handle(_titleTypeMeta,
          titleType.isAcceptableOrUnknown(data['title_type']!, _titleTypeMeta));
    } else if (isInserting) {
      context.missing(_titleTypeMeta);
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
          _unlockedAtMeta,
          unlockedAt.isAcceptableOrUnknown(
              data['unlocked_at']!, _unlockedAtMeta));
    } else if (isInserting) {
      context.missing(_unlockedAtMeta);
    }
    if (data.containsKey('is_equipped')) {
      context.handle(
          _isEquippedMeta,
          isEquipped.isAcceptableOrUnknown(
              data['is_equipped']!, _isEquippedMeta));
    }
    if (data.containsKey('equipped_at')) {
      context.handle(
          _equippedAtMeta,
          equippedAt.isAcceptableOrUnknown(
              data['equipped_at']!, _equippedAtMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {childId, titleId},
      ];
  @override
  ChildTitle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChildTitle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}child_id'])!,
      titleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title_id'])!,
      titleType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title_type'])!,
      unlockedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unlocked_at'])!,
      isEquipped: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_equipped'])!,
      equippedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}equipped_at']),
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      lastSyncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_synced_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $ChildTitlesTable createAlias(String alias) {
    return $ChildTitlesTable(attachedDatabase, alias);
  }
}

class ChildTitle extends DataClass implements Insertable<ChildTitle> {
  final String id;
  final String childId;
  final String titleId;
  final String titleType;
  final int unlockedAt;
  final bool isEquipped;
  final int? equippedAt;
  final String? remoteId;
  final String syncStatus;
  final int? lastSyncedAt;
  final int? deletedAt;
  const ChildTitle(
      {required this.id,
      required this.childId,
      required this.titleId,
      required this.titleType,
      required this.unlockedAt,
      required this.isEquipped,
      this.equippedAt,
      this.remoteId,
      required this.syncStatus,
      this.lastSyncedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['child_id'] = Variable<String>(childId);
    map['title_id'] = Variable<String>(titleId);
    map['title_type'] = Variable<String>(titleType);
    map['unlocked_at'] = Variable<int>(unlockedAt);
    map['is_equipped'] = Variable<bool>(isEquipped);
    if (!nullToAbsent || equippedAt != null) {
      map['equipped_at'] = Variable<int>(equippedAt);
    }
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  ChildTitlesCompanion toCompanion(bool nullToAbsent) {
    return ChildTitlesCompanion(
      id: Value(id),
      childId: Value(childId),
      titleId: Value(titleId),
      titleType: Value(titleType),
      unlockedAt: Value(unlockedAt),
      isEquipped: Value(isEquipped),
      equippedAt: equippedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(equippedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ChildTitle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChildTitle(
      id: serializer.fromJson<String>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      titleId: serializer.fromJson<String>(json['titleId']),
      titleType: serializer.fromJson<String>(json['titleType']),
      unlockedAt: serializer.fromJson<int>(json['unlockedAt']),
      isEquipped: serializer.fromJson<bool>(json['isEquipped']),
      equippedAt: serializer.fromJson<int?>(json['equippedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'childId': serializer.toJson<String>(childId),
      'titleId': serializer.toJson<String>(titleId),
      'titleType': serializer.toJson<String>(titleType),
      'unlockedAt': serializer.toJson<int>(unlockedAt),
      'isEquipped': serializer.toJson<bool>(isEquipped),
      'equippedAt': serializer.toJson<int?>(equippedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  ChildTitle copyWith(
          {String? id,
          String? childId,
          String? titleId,
          String? titleType,
          int? unlockedAt,
          bool? isEquipped,
          Value<int?> equippedAt = const Value.absent(),
          Value<String?> remoteId = const Value.absent(),
          String? syncStatus,
          Value<int?> lastSyncedAt = const Value.absent(),
          Value<int?> deletedAt = const Value.absent()}) =>
      ChildTitle(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        titleId: titleId ?? this.titleId,
        titleType: titleType ?? this.titleType,
        unlockedAt: unlockedAt ?? this.unlockedAt,
        isEquipped: isEquipped ?? this.isEquipped,
        equippedAt: equippedAt.present ? equippedAt.value : this.equippedAt,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        syncStatus: syncStatus ?? this.syncStatus,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  ChildTitle copyWithCompanion(ChildTitlesCompanion data) {
    return ChildTitle(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      titleId: data.titleId.present ? data.titleId.value : this.titleId,
      titleType: data.titleType.present ? data.titleType.value : this.titleType,
      unlockedAt:
          data.unlockedAt.present ? data.unlockedAt.value : this.unlockedAt,
      isEquipped:
          data.isEquipped.present ? data.isEquipped.value : this.isEquipped,
      equippedAt:
          data.equippedAt.present ? data.equippedAt.value : this.equippedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChildTitle(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('titleId: $titleId, ')
          ..write('titleType: $titleType, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('isEquipped: $isEquipped, ')
          ..write('equippedAt: $equippedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, childId, titleId, titleType, unlockedAt,
      isEquipped, equippedAt, remoteId, syncStatus, lastSyncedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChildTitle &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.titleId == this.titleId &&
          other.titleType == this.titleType &&
          other.unlockedAt == this.unlockedAt &&
          other.isEquipped == this.isEquipped &&
          other.equippedAt == this.equippedAt &&
          other.remoteId == this.remoteId &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.deletedAt == this.deletedAt);
}

class ChildTitlesCompanion extends UpdateCompanion<ChildTitle> {
  final Value<String> id;
  final Value<String> childId;
  final Value<String> titleId;
  final Value<String> titleType;
  final Value<int> unlockedAt;
  final Value<bool> isEquipped;
  final Value<int?> equippedAt;
  final Value<String?> remoteId;
  final Value<String> syncStatus;
  final Value<int?> lastSyncedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const ChildTitlesCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.titleId = const Value.absent(),
    this.titleType = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.isEquipped = const Value.absent(),
    this.equippedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChildTitlesCompanion.insert({
    required String id,
    required String childId,
    required String titleId,
    required String titleType,
    required int unlockedAt,
    this.isEquipped = const Value.absent(),
    this.equippedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        childId = Value(childId),
        titleId = Value(titleId),
        titleType = Value(titleType),
        unlockedAt = Value(unlockedAt);
  static Insertable<ChildTitle> custom({
    Expression<String>? id,
    Expression<String>? childId,
    Expression<String>? titleId,
    Expression<String>? titleType,
    Expression<int>? unlockedAt,
    Expression<bool>? isEquipped,
    Expression<int>? equippedAt,
    Expression<String>? remoteId,
    Expression<String>? syncStatus,
    Expression<int>? lastSyncedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (titleId != null) 'title_id': titleId,
      if (titleType != null) 'title_type': titleType,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (isEquipped != null) 'is_equipped': isEquipped,
      if (equippedAt != null) 'equipped_at': equippedAt,
      if (remoteId != null) 'remote_id': remoteId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChildTitlesCompanion copyWith(
      {Value<String>? id,
      Value<String>? childId,
      Value<String>? titleId,
      Value<String>? titleType,
      Value<int>? unlockedAt,
      Value<bool>? isEquipped,
      Value<int?>? equippedAt,
      Value<String?>? remoteId,
      Value<String>? syncStatus,
      Value<int?>? lastSyncedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return ChildTitlesCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      titleId: titleId ?? this.titleId,
      titleType: titleType ?? this.titleType,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      isEquipped: isEquipped ?? this.isEquipped,
      equippedAt: equippedAt ?? this.equippedAt,
      remoteId: remoteId ?? this.remoteId,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (titleId.present) {
      map['title_id'] = Variable<String>(titleId.value);
    }
    if (titleType.present) {
      map['title_type'] = Variable<String>(titleType.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<int>(unlockedAt.value);
    }
    if (isEquipped.present) {
      map['is_equipped'] = Variable<bool>(isEquipped.value);
    }
    if (equippedAt.present) {
      map['equipped_at'] = Variable<int>(equippedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChildTitlesCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('titleId: $titleId, ')
          ..write('titleType: $titleType, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('isEquipped: $isEquipped, ')
          ..write('equippedAt: $equippedAt, ')
          ..write('remoteId: $remoteId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ChildProfilesTable childProfiles = $ChildProfilesTable(this);
  late final $SyncVersionsTable syncVersions = $SyncVersionsTable(this);
  late final $LearningPathsTable learningPaths = $LearningPathsTable(this);
  late final $TopicsTable topics = $TopicsTable(this);
  late final $PathTopicsTable pathTopics = $PathTopicsTable(this);
  late final $ChildLearningPathsTable childLearningPaths =
      $ChildLearningPathsTable(this);
  late final $PlacementSessionsTable placementSessions =
      $PlacementSessionsTable(this);
  late final $LessonsTable lessons = $LessonsTable(this);
  late final $QuizQuestionsTable quizQuestions = $QuizQuestionsTable(this);
  late final $VocabularyItemsTable vocabularyItems =
      $VocabularyItemsTable(this);
  late final $LessonProgressEntriesTable lessonProgressEntries =
      $LessonProgressEntriesTable(this);
  late final $QuizAttemptsTable quizAttempts = $QuizAttemptsTable(this);
  late final $MissionTemplatesTable missionTemplates =
      $MissionTemplatesTable(this);
  late final $DailyMissionsTable dailyMissions = $DailyMissionsTable(this);
  late final $SkillTargetsTable skillTargets = $SkillTargetsTable(this);
  late final $SkillProgressEntriesTable skillProgressEntries =
      $SkillProgressEntriesTable(this);
  late final $LevelDefinitionsTable levelDefinitions =
      $LevelDefinitionsTable(this);
  late final $WordMasteryEntriesTable wordMasteryEntries =
      $WordMasteryEntriesTable(this);
  late final $ChildProgressEntriesTable childProgressEntries =
      $ChildProgressEntriesTable(this);
  late final $ChildSignalsTable childSignals = $ChildSignalsTable(this);
  late final $XpEventsTable xpEvents = $XpEventsTable(this);
  late final $TitlesTable titles = $TitlesTable(this);
  late final $ChildTitlesTable childTitles = $ChildTitlesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        childProfiles,
        syncVersions,
        learningPaths,
        topics,
        pathTopics,
        childLearningPaths,
        placementSessions,
        lessons,
        quizQuestions,
        vocabularyItems,
        lessonProgressEntries,
        quizAttempts,
        missionTemplates,
        dailyMissions,
        skillTargets,
        skillProgressEntries,
        levelDefinitions,
        wordMasteryEntries,
        childProgressEntries,
        childSignals,
        xpEvents,
        titles,
        childTitles
      ];
}

typedef $$ChildProfilesTableCreateCompanionBuilder = ChildProfilesCompanion
    Function({
  required String id,
  required String name,
  required String avatarId,
  required int createdAt,
  required int updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$ChildProfilesTableUpdateCompanionBuilder = ChildProfilesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> avatarId,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$ChildProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ChildProfilesTable> {
  $$ChildProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarId => $composableBuilder(
      column: $table.avatarId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$ChildProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChildProfilesTable> {
  $$ChildProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarId => $composableBuilder(
      column: $table.avatarId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$ChildProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChildProfilesTable> {
  $$ChildProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get avatarId =>
      $composableBuilder(column: $table.avatarId, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$ChildProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChildProfilesTable,
    ChildProfile,
    $$ChildProfilesTableFilterComposer,
    $$ChildProfilesTableOrderingComposer,
    $$ChildProfilesTableAnnotationComposer,
    $$ChildProfilesTableCreateCompanionBuilder,
    $$ChildProfilesTableUpdateCompanionBuilder,
    (
      ChildProfile,
      BaseReferences<_$AppDatabase, $ChildProfilesTable, ChildProfile>
    ),
    ChildProfile,
    PrefetchHooks Function()> {
  $$ChildProfilesTableTableManager(_$AppDatabase db, $ChildProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChildProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChildProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChildProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> avatarId = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildProfilesCompanion(
            id: id,
            name: name,
            avatarId: avatarId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String avatarId,
            required int createdAt,
            required int updatedAt,
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildProfilesCompanion.insert(
            id: id,
            name: name,
            avatarId: avatarId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChildProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChildProfilesTable,
    ChildProfile,
    $$ChildProfilesTableFilterComposer,
    $$ChildProfilesTableOrderingComposer,
    $$ChildProfilesTableAnnotationComposer,
    $$ChildProfilesTableCreateCompanionBuilder,
    $$ChildProfilesTableUpdateCompanionBuilder,
    (
      ChildProfile,
      BaseReferences<_$AppDatabase, $ChildProfilesTable, ChildProfile>
    ),
    ChildProfile,
    PrefetchHooks Function()>;
typedef $$SyncVersionsTableCreateCompanionBuilder = SyncVersionsCompanion
    Function({
  required String id,
  required String syncKey,
  required String version,
  required String source,
  required int appliedAt,
  Value<int?> lastCheckedAt,
  Value<String?> lastError,
  Value<int> rowid,
});
typedef $$SyncVersionsTableUpdateCompanionBuilder = SyncVersionsCompanion
    Function({
  Value<String> id,
  Value<String> syncKey,
  Value<String> version,
  Value<String> source,
  Value<int> appliedAt,
  Value<int?> lastCheckedAt,
  Value<String?> lastError,
  Value<int> rowid,
});

class $$SyncVersionsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncVersionsTable> {
  $$SyncVersionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncKey => $composableBuilder(
      column: $table.syncKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get appliedAt => $composableBuilder(
      column: $table.appliedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastCheckedAt => $composableBuilder(
      column: $table.lastCheckedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnFilters(column));
}

class $$SyncVersionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncVersionsTable> {
  $$SyncVersionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncKey => $composableBuilder(
      column: $table.syncKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get appliedAt => $composableBuilder(
      column: $table.appliedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastCheckedAt => $composableBuilder(
      column: $table.lastCheckedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnOrderings(column));
}

class $$SyncVersionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncVersionsTable> {
  $$SyncVersionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncKey =>
      $composableBuilder(column: $table.syncKey, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get appliedAt =>
      $composableBuilder(column: $table.appliedAt, builder: (column) => column);

  GeneratedColumn<int> get lastCheckedAt => $composableBuilder(
      column: $table.lastCheckedAt, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncVersionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncVersionsTable,
    SyncVersion,
    $$SyncVersionsTableFilterComposer,
    $$SyncVersionsTableOrderingComposer,
    $$SyncVersionsTableAnnotationComposer,
    $$SyncVersionsTableCreateCompanionBuilder,
    $$SyncVersionsTableUpdateCompanionBuilder,
    (
      SyncVersion,
      BaseReferences<_$AppDatabase, $SyncVersionsTable, SyncVersion>
    ),
    SyncVersion,
    PrefetchHooks Function()> {
  $$SyncVersionsTableTableManager(_$AppDatabase db, $SyncVersionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncVersionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncVersionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncVersionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> syncKey = const Value.absent(),
            Value<String> version = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<int> appliedAt = const Value.absent(),
            Value<int?> lastCheckedAt = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncVersionsCompanion(
            id: id,
            syncKey: syncKey,
            version: version,
            source: source,
            appliedAt: appliedAt,
            lastCheckedAt: lastCheckedAt,
            lastError: lastError,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String syncKey,
            required String version,
            required String source,
            required int appliedAt,
            Value<int?> lastCheckedAt = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncVersionsCompanion.insert(
            id: id,
            syncKey: syncKey,
            version: version,
            source: source,
            appliedAt: appliedAt,
            lastCheckedAt: lastCheckedAt,
            lastError: lastError,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncVersionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncVersionsTable,
    SyncVersion,
    $$SyncVersionsTableFilterComposer,
    $$SyncVersionsTableOrderingComposer,
    $$SyncVersionsTableAnnotationComposer,
    $$SyncVersionsTableCreateCompanionBuilder,
    $$SyncVersionsTableUpdateCompanionBuilder,
    (
      SyncVersion,
      BaseReferences<_$AppDatabase, $SyncVersionsTable, SyncVersion>
    ),
    SyncVersion,
    PrefetchHooks Function()>;
typedef $$LearningPathsTableCreateCompanionBuilder = LearningPathsCompanion
    Function({
  required String id,
  required String title,
  Value<String?> description,
  Value<int?> ageMin,
  Value<int?> ageMax,
  Value<String> level,
  Value<bool> isActive,
  Value<int> sortOrder,
  required int createdAt,
  required int updatedAt,
  Value<int> rowid,
});
typedef $$LearningPathsTableUpdateCompanionBuilder = LearningPathsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<int?> ageMin,
  Value<int?> ageMax,
  Value<String> level,
  Value<bool> isActive,
  Value<int> sortOrder,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int> rowid,
});

class $$LearningPathsTableFilterComposer
    extends Composer<_$AppDatabase, $LearningPathsTable> {
  $$LearningPathsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ageMin => $composableBuilder(
      column: $table.ageMin, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ageMax => $composableBuilder(
      column: $table.ageMax, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LearningPathsTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningPathsTable> {
  $$LearningPathsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ageMin => $composableBuilder(
      column: $table.ageMin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ageMax => $composableBuilder(
      column: $table.ageMax, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LearningPathsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningPathsTable> {
  $$LearningPathsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get ageMin =>
      $composableBuilder(column: $table.ageMin, builder: (column) => column);

  GeneratedColumn<int> get ageMax =>
      $composableBuilder(column: $table.ageMax, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LearningPathsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LearningPathsTable,
    LearningPath,
    $$LearningPathsTableFilterComposer,
    $$LearningPathsTableOrderingComposer,
    $$LearningPathsTableAnnotationComposer,
    $$LearningPathsTableCreateCompanionBuilder,
    $$LearningPathsTableUpdateCompanionBuilder,
    (
      LearningPath,
      BaseReferences<_$AppDatabase, $LearningPathsTable, LearningPath>
    ),
    LearningPath,
    PrefetchHooks Function()> {
  $$LearningPathsTableTableManager(_$AppDatabase db, $LearningPathsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningPathsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningPathsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningPathsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int?> ageMin = const Value.absent(),
            Value<int?> ageMax = const Value.absent(),
            Value<String> level = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LearningPathsCompanion(
            id: id,
            title: title,
            description: description,
            ageMin: ageMin,
            ageMax: ageMax,
            level: level,
            isActive: isActive,
            sortOrder: sortOrder,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<int?> ageMin = const Value.absent(),
            Value<int?> ageMax = const Value.absent(),
            Value<String> level = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            required int createdAt,
            required int updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LearningPathsCompanion.insert(
            id: id,
            title: title,
            description: description,
            ageMin: ageMin,
            ageMax: ageMax,
            level: level,
            isActive: isActive,
            sortOrder: sortOrder,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LearningPathsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LearningPathsTable,
    LearningPath,
    $$LearningPathsTableFilterComposer,
    $$LearningPathsTableOrderingComposer,
    $$LearningPathsTableAnnotationComposer,
    $$LearningPathsTableCreateCompanionBuilder,
    $$LearningPathsTableUpdateCompanionBuilder,
    (
      LearningPath,
      BaseReferences<_$AppDatabase, $LearningPathsTable, LearningPath>
    ),
    LearningPath,
    PrefetchHooks Function()>;
typedef $$TopicsTableCreateCompanionBuilder = TopicsCompanion Function({
  required String id,
  required String nameEn,
  required String nameVi,
  Value<String?> iconUrl,
  Value<String?> colorHex,
  Value<int> sortOrder,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$TopicsTableUpdateCompanionBuilder = TopicsCompanion Function({
  Value<String> id,
  Value<String> nameEn,
  Value<String> nameVi,
  Value<String?> iconUrl,
  Value<String?> colorHex,
  Value<int> sortOrder,
  Value<bool> isActive,
  Value<int> rowid,
});

class $$TopicsTableFilterComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameVi => $composableBuilder(
      column: $table.nameVi, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconUrl => $composableBuilder(
      column: $table.iconUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));
}

class $$TopicsTableOrderingComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameVi => $composableBuilder(
      column: $table.nameVi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconUrl => $composableBuilder(
      column: $table.iconUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$TopicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameVi =>
      $composableBuilder(column: $table.nameVi, builder: (column) => column);

  GeneratedColumn<String> get iconUrl =>
      $composableBuilder(column: $table.iconUrl, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$TopicsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TopicsTable,
    Topic,
    $$TopicsTableFilterComposer,
    $$TopicsTableOrderingComposer,
    $$TopicsTableAnnotationComposer,
    $$TopicsTableCreateCompanionBuilder,
    $$TopicsTableUpdateCompanionBuilder,
    (Topic, BaseReferences<_$AppDatabase, $TopicsTable, Topic>),
    Topic,
    PrefetchHooks Function()> {
  $$TopicsTableTableManager(_$AppDatabase db, $TopicsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TopicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nameEn = const Value.absent(),
            Value<String> nameVi = const Value.absent(),
            Value<String?> iconUrl = const Value.absent(),
            Value<String?> colorHex = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TopicsCompanion(
            id: id,
            nameEn: nameEn,
            nameVi: nameVi,
            iconUrl: iconUrl,
            colorHex: colorHex,
            sortOrder: sortOrder,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nameEn,
            required String nameVi,
            Value<String?> iconUrl = const Value.absent(),
            Value<String?> colorHex = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TopicsCompanion.insert(
            id: id,
            nameEn: nameEn,
            nameVi: nameVi,
            iconUrl: iconUrl,
            colorHex: colorHex,
            sortOrder: sortOrder,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TopicsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TopicsTable,
    Topic,
    $$TopicsTableFilterComposer,
    $$TopicsTableOrderingComposer,
    $$TopicsTableAnnotationComposer,
    $$TopicsTableCreateCompanionBuilder,
    $$TopicsTableUpdateCompanionBuilder,
    (Topic, BaseReferences<_$AppDatabase, $TopicsTable, Topic>),
    Topic,
    PrefetchHooks Function()>;
typedef $$PathTopicsTableCreateCompanionBuilder = PathTopicsCompanion Function({
  required String id,
  required String pathId,
  required String topicId,
  Value<int> sortOrder,
  Value<bool> isRequired,
  Value<String?> unlockRuleJson,
  Value<int> rowid,
});
typedef $$PathTopicsTableUpdateCompanionBuilder = PathTopicsCompanion Function({
  Value<String> id,
  Value<String> pathId,
  Value<String> topicId,
  Value<int> sortOrder,
  Value<bool> isRequired,
  Value<String?> unlockRuleJson,
  Value<int> rowid,
});

class $$PathTopicsTableFilterComposer
    extends Composer<_$AppDatabase, $PathTopicsTable> {
  $$PathTopicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pathId => $composableBuilder(
      column: $table.pathId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get topicId => $composableBuilder(
      column: $table.topicId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRequired => $composableBuilder(
      column: $table.isRequired, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unlockRuleJson => $composableBuilder(
      column: $table.unlockRuleJson,
      builder: (column) => ColumnFilters(column));
}

class $$PathTopicsTableOrderingComposer
    extends Composer<_$AppDatabase, $PathTopicsTable> {
  $$PathTopicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pathId => $composableBuilder(
      column: $table.pathId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get topicId => $composableBuilder(
      column: $table.topicId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRequired => $composableBuilder(
      column: $table.isRequired, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unlockRuleJson => $composableBuilder(
      column: $table.unlockRuleJson,
      builder: (column) => ColumnOrderings(column));
}

class $$PathTopicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PathTopicsTable> {
  $$PathTopicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pathId =>
      $composableBuilder(column: $table.pathId, builder: (column) => column);

  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isRequired => $composableBuilder(
      column: $table.isRequired, builder: (column) => column);

  GeneratedColumn<String> get unlockRuleJson => $composableBuilder(
      column: $table.unlockRuleJson, builder: (column) => column);
}

class $$PathTopicsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PathTopicsTable,
    PathTopic,
    $$PathTopicsTableFilterComposer,
    $$PathTopicsTableOrderingComposer,
    $$PathTopicsTableAnnotationComposer,
    $$PathTopicsTableCreateCompanionBuilder,
    $$PathTopicsTableUpdateCompanionBuilder,
    (PathTopic, BaseReferences<_$AppDatabase, $PathTopicsTable, PathTopic>),
    PathTopic,
    PrefetchHooks Function()> {
  $$PathTopicsTableTableManager(_$AppDatabase db, $PathTopicsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PathTopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PathTopicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PathTopicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> pathId = const Value.absent(),
            Value<String> topicId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isRequired = const Value.absent(),
            Value<String?> unlockRuleJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PathTopicsCompanion(
            id: id,
            pathId: pathId,
            topicId: topicId,
            sortOrder: sortOrder,
            isRequired: isRequired,
            unlockRuleJson: unlockRuleJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String pathId,
            required String topicId,
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isRequired = const Value.absent(),
            Value<String?> unlockRuleJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PathTopicsCompanion.insert(
            id: id,
            pathId: pathId,
            topicId: topicId,
            sortOrder: sortOrder,
            isRequired: isRequired,
            unlockRuleJson: unlockRuleJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PathTopicsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PathTopicsTable,
    PathTopic,
    $$PathTopicsTableFilterComposer,
    $$PathTopicsTableOrderingComposer,
    $$PathTopicsTableAnnotationComposer,
    $$PathTopicsTableCreateCompanionBuilder,
    $$PathTopicsTableUpdateCompanionBuilder,
    (PathTopic, BaseReferences<_$AppDatabase, $PathTopicsTable, PathTopic>),
    PathTopic,
    PrefetchHooks Function()>;
typedef $$ChildLearningPathsTableCreateCompanionBuilder
    = ChildLearningPathsCompanion Function({
  required String id,
  required String childId,
  required String pathId,
  Value<String> status,
  Value<String?> currentTopicId,
  Value<String?> currentLessonId,
  required int startedAt,
  Value<int?> completedAt,
  required int updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$ChildLearningPathsTableUpdateCompanionBuilder
    = ChildLearningPathsCompanion Function({
  Value<String> id,
  Value<String> childId,
  Value<String> pathId,
  Value<String> status,
  Value<String?> currentTopicId,
  Value<String?> currentLessonId,
  Value<int> startedAt,
  Value<int?> completedAt,
  Value<int> updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$ChildLearningPathsTableFilterComposer
    extends Composer<_$AppDatabase, $ChildLearningPathsTable> {
  $$ChildLearningPathsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pathId => $composableBuilder(
      column: $table.pathId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentTopicId => $composableBuilder(
      column: $table.currentTopicId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentLessonId => $composableBuilder(
      column: $table.currentLessonId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$ChildLearningPathsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChildLearningPathsTable> {
  $$ChildLearningPathsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pathId => $composableBuilder(
      column: $table.pathId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentTopicId => $composableBuilder(
      column: $table.currentTopicId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentLessonId => $composableBuilder(
      column: $table.currentLessonId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$ChildLearningPathsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChildLearningPathsTable> {
  $$ChildLearningPathsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get pathId =>
      $composableBuilder(column: $table.pathId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get currentTopicId => $composableBuilder(
      column: $table.currentTopicId, builder: (column) => column);

  GeneratedColumn<String> get currentLessonId => $composableBuilder(
      column: $table.currentLessonId, builder: (column) => column);

  GeneratedColumn<int> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$ChildLearningPathsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChildLearningPathsTable,
    ChildLearningPath,
    $$ChildLearningPathsTableFilterComposer,
    $$ChildLearningPathsTableOrderingComposer,
    $$ChildLearningPathsTableAnnotationComposer,
    $$ChildLearningPathsTableCreateCompanionBuilder,
    $$ChildLearningPathsTableUpdateCompanionBuilder,
    (
      ChildLearningPath,
      BaseReferences<_$AppDatabase, $ChildLearningPathsTable, ChildLearningPath>
    ),
    ChildLearningPath,
    PrefetchHooks Function()> {
  $$ChildLearningPathsTableTableManager(
      _$AppDatabase db, $ChildLearningPathsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChildLearningPathsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChildLearningPathsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChildLearningPathsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> childId = const Value.absent(),
            Value<String> pathId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> currentTopicId = const Value.absent(),
            Value<String?> currentLessonId = const Value.absent(),
            Value<int> startedAt = const Value.absent(),
            Value<int?> completedAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildLearningPathsCompanion(
            id: id,
            childId: childId,
            pathId: pathId,
            status: status,
            currentTopicId: currentTopicId,
            currentLessonId: currentLessonId,
            startedAt: startedAt,
            completedAt: completedAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String childId,
            required String pathId,
            Value<String> status = const Value.absent(),
            Value<String?> currentTopicId = const Value.absent(),
            Value<String?> currentLessonId = const Value.absent(),
            required int startedAt,
            Value<int?> completedAt = const Value.absent(),
            required int updatedAt,
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildLearningPathsCompanion.insert(
            id: id,
            childId: childId,
            pathId: pathId,
            status: status,
            currentTopicId: currentTopicId,
            currentLessonId: currentLessonId,
            startedAt: startedAt,
            completedAt: completedAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChildLearningPathsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChildLearningPathsTable,
    ChildLearningPath,
    $$ChildLearningPathsTableFilterComposer,
    $$ChildLearningPathsTableOrderingComposer,
    $$ChildLearningPathsTableAnnotationComposer,
    $$ChildLearningPathsTableCreateCompanionBuilder,
    $$ChildLearningPathsTableUpdateCompanionBuilder,
    (
      ChildLearningPath,
      BaseReferences<_$AppDatabase, $ChildLearningPathsTable, ChildLearningPath>
    ),
    ChildLearningPath,
    PrefetchHooks Function()>;
typedef $$PlacementSessionsTableCreateCompanionBuilder
    = PlacementSessionsCompanion Function({
  required String id,
  required String childId,
  Value<String> status,
  Value<int> score,
  Value<int> maxScore,
  Value<String?> recommendedPathId,
  Value<String?> selectedPathId,
  Value<String?> answersJson,
  required int startedAt,
  Value<int?> completedAt,
  required int updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$PlacementSessionsTableUpdateCompanionBuilder
    = PlacementSessionsCompanion Function({
  Value<String> id,
  Value<String> childId,
  Value<String> status,
  Value<int> score,
  Value<int> maxScore,
  Value<String?> recommendedPathId,
  Value<String?> selectedPathId,
  Value<String?> answersJson,
  Value<int> startedAt,
  Value<int?> completedAt,
  Value<int> updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$PlacementSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $PlacementSessionsTable> {
  $$PlacementSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxScore => $composableBuilder(
      column: $table.maxScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recommendedPathId => $composableBuilder(
      column: $table.recommendedPathId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selectedPathId => $composableBuilder(
      column: $table.selectedPathId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answersJson => $composableBuilder(
      column: $table.answersJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$PlacementSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlacementSessionsTable> {
  $$PlacementSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxScore => $composableBuilder(
      column: $table.maxScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recommendedPathId => $composableBuilder(
      column: $table.recommendedPathId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selectedPathId => $composableBuilder(
      column: $table.selectedPathId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answersJson => $composableBuilder(
      column: $table.answersJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$PlacementSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlacementSessionsTable> {
  $$PlacementSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get maxScore =>
      $composableBuilder(column: $table.maxScore, builder: (column) => column);

  GeneratedColumn<String> get recommendedPathId => $composableBuilder(
      column: $table.recommendedPathId, builder: (column) => column);

  GeneratedColumn<String> get selectedPathId => $composableBuilder(
      column: $table.selectedPathId, builder: (column) => column);

  GeneratedColumn<String> get answersJson => $composableBuilder(
      column: $table.answersJson, builder: (column) => column);

  GeneratedColumn<int> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$PlacementSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlacementSessionsTable,
    PlacementSession,
    $$PlacementSessionsTableFilterComposer,
    $$PlacementSessionsTableOrderingComposer,
    $$PlacementSessionsTableAnnotationComposer,
    $$PlacementSessionsTableCreateCompanionBuilder,
    $$PlacementSessionsTableUpdateCompanionBuilder,
    (
      PlacementSession,
      BaseReferences<_$AppDatabase, $PlacementSessionsTable, PlacementSession>
    ),
    PlacementSession,
    PrefetchHooks Function()> {
  $$PlacementSessionsTableTableManager(
      _$AppDatabase db, $PlacementSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlacementSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlacementSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlacementSessionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> childId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> score = const Value.absent(),
            Value<int> maxScore = const Value.absent(),
            Value<String?> recommendedPathId = const Value.absent(),
            Value<String?> selectedPathId = const Value.absent(),
            Value<String?> answersJson = const Value.absent(),
            Value<int> startedAt = const Value.absent(),
            Value<int?> completedAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlacementSessionsCompanion(
            id: id,
            childId: childId,
            status: status,
            score: score,
            maxScore: maxScore,
            recommendedPathId: recommendedPathId,
            selectedPathId: selectedPathId,
            answersJson: answersJson,
            startedAt: startedAt,
            completedAt: completedAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String childId,
            Value<String> status = const Value.absent(),
            Value<int> score = const Value.absent(),
            Value<int> maxScore = const Value.absent(),
            Value<String?> recommendedPathId = const Value.absent(),
            Value<String?> selectedPathId = const Value.absent(),
            Value<String?> answersJson = const Value.absent(),
            required int startedAt,
            Value<int?> completedAt = const Value.absent(),
            required int updatedAt,
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlacementSessionsCompanion.insert(
            id: id,
            childId: childId,
            status: status,
            score: score,
            maxScore: maxScore,
            recommendedPathId: recommendedPathId,
            selectedPathId: selectedPathId,
            answersJson: answersJson,
            startedAt: startedAt,
            completedAt: completedAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlacementSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlacementSessionsTable,
    PlacementSession,
    $$PlacementSessionsTableFilterComposer,
    $$PlacementSessionsTableOrderingComposer,
    $$PlacementSessionsTableAnnotationComposer,
    $$PlacementSessionsTableCreateCompanionBuilder,
    $$PlacementSessionsTableUpdateCompanionBuilder,
    (
      PlacementSession,
      BaseReferences<_$AppDatabase, $PlacementSessionsTable, PlacementSession>
    ),
    PlacementSession,
    PrefetchHooks Function()>;
typedef $$LessonsTableCreateCompanionBuilder = LessonsCompanion Function({
  required String id,
  required String topicId,
  required String titleEn,
  required String titleVi,
  Value<String?> descriptionVi,
  Value<int> level,
  Value<int> sortOrder,
  Value<int> minXpRequired,
  Value<bool> isPublished,
  Value<String?> thumbnailUrl,
  Value<int> vocabularyCount,
  Value<int> questionCount,
  Value<int> xpReward,
  Value<int> rowid,
});
typedef $$LessonsTableUpdateCompanionBuilder = LessonsCompanion Function({
  Value<String> id,
  Value<String> topicId,
  Value<String> titleEn,
  Value<String> titleVi,
  Value<String?> descriptionVi,
  Value<int> level,
  Value<int> sortOrder,
  Value<int> minXpRequired,
  Value<bool> isPublished,
  Value<String?> thumbnailUrl,
  Value<int> vocabularyCount,
  Value<int> questionCount,
  Value<int> xpReward,
  Value<int> rowid,
});

class $$LessonsTableFilterComposer
    extends Composer<_$AppDatabase, $LessonsTable> {
  $$LessonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get topicId => $composableBuilder(
      column: $table.topicId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titleEn => $composableBuilder(
      column: $table.titleEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titleVi => $composableBuilder(
      column: $table.titleVi, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descriptionVi => $composableBuilder(
      column: $table.descriptionVi, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minXpRequired => $composableBuilder(
      column: $table.minXpRequired, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPublished => $composableBuilder(
      column: $table.isPublished, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get thumbnailUrl => $composableBuilder(
      column: $table.thumbnailUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get vocabularyCount => $composableBuilder(
      column: $table.vocabularyCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get questionCount => $composableBuilder(
      column: $table.questionCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xpReward => $composableBuilder(
      column: $table.xpReward, builder: (column) => ColumnFilters(column));
}

class $$LessonsTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonsTable> {
  $$LessonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get topicId => $composableBuilder(
      column: $table.topicId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titleEn => $composableBuilder(
      column: $table.titleEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titleVi => $composableBuilder(
      column: $table.titleVi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descriptionVi => $composableBuilder(
      column: $table.descriptionVi,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minXpRequired => $composableBuilder(
      column: $table.minXpRequired,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPublished => $composableBuilder(
      column: $table.isPublished, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get thumbnailUrl => $composableBuilder(
      column: $table.thumbnailUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get vocabularyCount => $composableBuilder(
      column: $table.vocabularyCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get questionCount => $composableBuilder(
      column: $table.questionCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xpReward => $composableBuilder(
      column: $table.xpReward, builder: (column) => ColumnOrderings(column));
}

class $$LessonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonsTable> {
  $$LessonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<String> get titleEn =>
      $composableBuilder(column: $table.titleEn, builder: (column) => column);

  GeneratedColumn<String> get titleVi =>
      $composableBuilder(column: $table.titleVi, builder: (column) => column);

  GeneratedColumn<String> get descriptionVi => $composableBuilder(
      column: $table.descriptionVi, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get minXpRequired => $composableBuilder(
      column: $table.minXpRequired, builder: (column) => column);

  GeneratedColumn<bool> get isPublished => $composableBuilder(
      column: $table.isPublished, builder: (column) => column);

  GeneratedColumn<String> get thumbnailUrl => $composableBuilder(
      column: $table.thumbnailUrl, builder: (column) => column);

  GeneratedColumn<int> get vocabularyCount => $composableBuilder(
      column: $table.vocabularyCount, builder: (column) => column);

  GeneratedColumn<int> get questionCount => $composableBuilder(
      column: $table.questionCount, builder: (column) => column);

  GeneratedColumn<int> get xpReward =>
      $composableBuilder(column: $table.xpReward, builder: (column) => column);
}

class $$LessonsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LessonsTable,
    Lesson,
    $$LessonsTableFilterComposer,
    $$LessonsTableOrderingComposer,
    $$LessonsTableAnnotationComposer,
    $$LessonsTableCreateCompanionBuilder,
    $$LessonsTableUpdateCompanionBuilder,
    (Lesson, BaseReferences<_$AppDatabase, $LessonsTable, Lesson>),
    Lesson,
    PrefetchHooks Function()> {
  $$LessonsTableTableManager(_$AppDatabase db, $LessonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LessonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LessonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LessonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> topicId = const Value.absent(),
            Value<String> titleEn = const Value.absent(),
            Value<String> titleVi = const Value.absent(),
            Value<String?> descriptionVi = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> minXpRequired = const Value.absent(),
            Value<bool> isPublished = const Value.absent(),
            Value<String?> thumbnailUrl = const Value.absent(),
            Value<int> vocabularyCount = const Value.absent(),
            Value<int> questionCount = const Value.absent(),
            Value<int> xpReward = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LessonsCompanion(
            id: id,
            topicId: topicId,
            titleEn: titleEn,
            titleVi: titleVi,
            descriptionVi: descriptionVi,
            level: level,
            sortOrder: sortOrder,
            minXpRequired: minXpRequired,
            isPublished: isPublished,
            thumbnailUrl: thumbnailUrl,
            vocabularyCount: vocabularyCount,
            questionCount: questionCount,
            xpReward: xpReward,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String topicId,
            required String titleEn,
            required String titleVi,
            Value<String?> descriptionVi = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> minXpRequired = const Value.absent(),
            Value<bool> isPublished = const Value.absent(),
            Value<String?> thumbnailUrl = const Value.absent(),
            Value<int> vocabularyCount = const Value.absent(),
            Value<int> questionCount = const Value.absent(),
            Value<int> xpReward = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LessonsCompanion.insert(
            id: id,
            topicId: topicId,
            titleEn: titleEn,
            titleVi: titleVi,
            descriptionVi: descriptionVi,
            level: level,
            sortOrder: sortOrder,
            minXpRequired: minXpRequired,
            isPublished: isPublished,
            thumbnailUrl: thumbnailUrl,
            vocabularyCount: vocabularyCount,
            questionCount: questionCount,
            xpReward: xpReward,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LessonsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LessonsTable,
    Lesson,
    $$LessonsTableFilterComposer,
    $$LessonsTableOrderingComposer,
    $$LessonsTableAnnotationComposer,
    $$LessonsTableCreateCompanionBuilder,
    $$LessonsTableUpdateCompanionBuilder,
    (Lesson, BaseReferences<_$AppDatabase, $LessonsTable, Lesson>),
    Lesson,
    PrefetchHooks Function()>;
typedef $$QuizQuestionsTableCreateCompanionBuilder = QuizQuestionsCompanion
    Function({
  required String id,
  required String lessonId,
  required String quizType,
  Value<String?> prompt,
  required String contentJson,
  Value<int> difficulty,
  Value<int> xpReward,
  Value<int?> timeLimitSec,
  Value<int> sortOrder,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$QuizQuestionsTableUpdateCompanionBuilder = QuizQuestionsCompanion
    Function({
  Value<String> id,
  Value<String> lessonId,
  Value<String> quizType,
  Value<String?> prompt,
  Value<String> contentJson,
  Value<int> difficulty,
  Value<int> xpReward,
  Value<int?> timeLimitSec,
  Value<int> sortOrder,
  Value<bool> isActive,
  Value<int> rowid,
});

class $$QuizQuestionsTableFilterComposer
    extends Composer<_$AppDatabase, $QuizQuestionsTable> {
  $$QuizQuestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lessonId => $composableBuilder(
      column: $table.lessonId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get quizType => $composableBuilder(
      column: $table.quizType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prompt => $composableBuilder(
      column: $table.prompt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xpReward => $composableBuilder(
      column: $table.xpReward, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeLimitSec => $composableBuilder(
      column: $table.timeLimitSec, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));
}

class $$QuizQuestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuizQuestionsTable> {
  $$QuizQuestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lessonId => $composableBuilder(
      column: $table.lessonId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get quizType => $composableBuilder(
      column: $table.quizType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prompt => $composableBuilder(
      column: $table.prompt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xpReward => $composableBuilder(
      column: $table.xpReward, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeLimitSec => $composableBuilder(
      column: $table.timeLimitSec,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$QuizQuestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuizQuestionsTable> {
  $$QuizQuestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<String> get quizType =>
      $composableBuilder(column: $table.quizType, builder: (column) => column);

  GeneratedColumn<String> get prompt =>
      $composableBuilder(column: $table.prompt, builder: (column) => column);

  GeneratedColumn<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => column);

  GeneratedColumn<int> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<int> get xpReward =>
      $composableBuilder(column: $table.xpReward, builder: (column) => column);

  GeneratedColumn<int> get timeLimitSec => $composableBuilder(
      column: $table.timeLimitSec, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$QuizQuestionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuizQuestionsTable,
    QuizQuestion,
    $$QuizQuestionsTableFilterComposer,
    $$QuizQuestionsTableOrderingComposer,
    $$QuizQuestionsTableAnnotationComposer,
    $$QuizQuestionsTableCreateCompanionBuilder,
    $$QuizQuestionsTableUpdateCompanionBuilder,
    (
      QuizQuestion,
      BaseReferences<_$AppDatabase, $QuizQuestionsTable, QuizQuestion>
    ),
    QuizQuestion,
    PrefetchHooks Function()> {
  $$QuizQuestionsTableTableManager(_$AppDatabase db, $QuizQuestionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuizQuestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuizQuestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuizQuestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> lessonId = const Value.absent(),
            Value<String> quizType = const Value.absent(),
            Value<String?> prompt = const Value.absent(),
            Value<String> contentJson = const Value.absent(),
            Value<int> difficulty = const Value.absent(),
            Value<int> xpReward = const Value.absent(),
            Value<int?> timeLimitSec = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuizQuestionsCompanion(
            id: id,
            lessonId: lessonId,
            quizType: quizType,
            prompt: prompt,
            contentJson: contentJson,
            difficulty: difficulty,
            xpReward: xpReward,
            timeLimitSec: timeLimitSec,
            sortOrder: sortOrder,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String lessonId,
            required String quizType,
            Value<String?> prompt = const Value.absent(),
            required String contentJson,
            Value<int> difficulty = const Value.absent(),
            Value<int> xpReward = const Value.absent(),
            Value<int?> timeLimitSec = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuizQuestionsCompanion.insert(
            id: id,
            lessonId: lessonId,
            quizType: quizType,
            prompt: prompt,
            contentJson: contentJson,
            difficulty: difficulty,
            xpReward: xpReward,
            timeLimitSec: timeLimitSec,
            sortOrder: sortOrder,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QuizQuestionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuizQuestionsTable,
    QuizQuestion,
    $$QuizQuestionsTableFilterComposer,
    $$QuizQuestionsTableOrderingComposer,
    $$QuizQuestionsTableAnnotationComposer,
    $$QuizQuestionsTableCreateCompanionBuilder,
    $$QuizQuestionsTableUpdateCompanionBuilder,
    (
      QuizQuestion,
      BaseReferences<_$AppDatabase, $QuizQuestionsTable, QuizQuestion>
    ),
    QuizQuestion,
    PrefetchHooks Function()>;
typedef $$VocabularyItemsTableCreateCompanionBuilder = VocabularyItemsCompanion
    Function({
  required String id,
  required String lessonId,
  required String word,
  Value<String?> phonetic,
  required String translationVi,
  Value<String?> imageUrl,
  Value<String?> audioUrl,
  Value<String?> partOfSpeech,
  Value<bool> isKeyWord,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$VocabularyItemsTableUpdateCompanionBuilder = VocabularyItemsCompanion
    Function({
  Value<String> id,
  Value<String> lessonId,
  Value<String> word,
  Value<String?> phonetic,
  Value<String> translationVi,
  Value<String?> imageUrl,
  Value<String?> audioUrl,
  Value<String?> partOfSpeech,
  Value<bool> isKeyWord,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$VocabularyItemsTableFilterComposer
    extends Composer<_$AppDatabase, $VocabularyItemsTable> {
  $$VocabularyItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lessonId => $composableBuilder(
      column: $table.lessonId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phonetic => $composableBuilder(
      column: $table.phonetic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get translationVi => $composableBuilder(
      column: $table.translationVi, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get audioUrl => $composableBuilder(
      column: $table.audioUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
      column: $table.partOfSpeech, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isKeyWord => $composableBuilder(
      column: $table.isKeyWord, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));
}

class $$VocabularyItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabularyItemsTable> {
  $$VocabularyItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lessonId => $composableBuilder(
      column: $table.lessonId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phonetic => $composableBuilder(
      column: $table.phonetic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translationVi => $composableBuilder(
      column: $table.translationVi,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get audioUrl => $composableBuilder(
      column: $table.audioUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
      column: $table.partOfSpeech,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isKeyWord => $composableBuilder(
      column: $table.isKeyWord, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));
}

class $$VocabularyItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabularyItemsTable> {
  $$VocabularyItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get phonetic =>
      $composableBuilder(column: $table.phonetic, builder: (column) => column);

  GeneratedColumn<String> get translationVi => $composableBuilder(
      column: $table.translationVi, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get audioUrl =>
      $composableBuilder(column: $table.audioUrl, builder: (column) => column);

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
      column: $table.partOfSpeech, builder: (column) => column);

  GeneratedColumn<bool> get isKeyWord =>
      $composableBuilder(column: $table.isKeyWord, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$VocabularyItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VocabularyItemsTable,
    VocabularyItem,
    $$VocabularyItemsTableFilterComposer,
    $$VocabularyItemsTableOrderingComposer,
    $$VocabularyItemsTableAnnotationComposer,
    $$VocabularyItemsTableCreateCompanionBuilder,
    $$VocabularyItemsTableUpdateCompanionBuilder,
    (
      VocabularyItem,
      BaseReferences<_$AppDatabase, $VocabularyItemsTable, VocabularyItem>
    ),
    VocabularyItem,
    PrefetchHooks Function()> {
  $$VocabularyItemsTableTableManager(
      _$AppDatabase db, $VocabularyItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabularyItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabularyItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabularyItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> lessonId = const Value.absent(),
            Value<String> word = const Value.absent(),
            Value<String?> phonetic = const Value.absent(),
            Value<String> translationVi = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> audioUrl = const Value.absent(),
            Value<String?> partOfSpeech = const Value.absent(),
            Value<bool> isKeyWord = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VocabularyItemsCompanion(
            id: id,
            lessonId: lessonId,
            word: word,
            phonetic: phonetic,
            translationVi: translationVi,
            imageUrl: imageUrl,
            audioUrl: audioUrl,
            partOfSpeech: partOfSpeech,
            isKeyWord: isKeyWord,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String lessonId,
            required String word,
            Value<String?> phonetic = const Value.absent(),
            required String translationVi,
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> audioUrl = const Value.absent(),
            Value<String?> partOfSpeech = const Value.absent(),
            Value<bool> isKeyWord = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VocabularyItemsCompanion.insert(
            id: id,
            lessonId: lessonId,
            word: word,
            phonetic: phonetic,
            translationVi: translationVi,
            imageUrl: imageUrl,
            audioUrl: audioUrl,
            partOfSpeech: partOfSpeech,
            isKeyWord: isKeyWord,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VocabularyItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VocabularyItemsTable,
    VocabularyItem,
    $$VocabularyItemsTableFilterComposer,
    $$VocabularyItemsTableOrderingComposer,
    $$VocabularyItemsTableAnnotationComposer,
    $$VocabularyItemsTableCreateCompanionBuilder,
    $$VocabularyItemsTableUpdateCompanionBuilder,
    (
      VocabularyItem,
      BaseReferences<_$AppDatabase, $VocabularyItemsTable, VocabularyItem>
    ),
    VocabularyItem,
    PrefetchHooks Function()>;
typedef $$LessonProgressEntriesTableCreateCompanionBuilder
    = LessonProgressEntriesCompanion Function({
  required String id,
  required String childId,
  required String lessonId,
  Value<String> status,
  Value<double> progressPercent,
  Value<int> completedQuestions,
  Value<int> totalQuestions,
  Value<int> bestScore,
  Value<int> earnedXp,
  Value<int> stars,
  Value<int> attempts,
  Value<String?> lastQuestionId,
  Value<int?> startedAt,
  Value<int?> completedAt,
  required int updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$LessonProgressEntriesTableUpdateCompanionBuilder
    = LessonProgressEntriesCompanion Function({
  Value<String> id,
  Value<String> childId,
  Value<String> lessonId,
  Value<String> status,
  Value<double> progressPercent,
  Value<int> completedQuestions,
  Value<int> totalQuestions,
  Value<int> bestScore,
  Value<int> earnedXp,
  Value<int> stars,
  Value<int> attempts,
  Value<String?> lastQuestionId,
  Value<int?> startedAt,
  Value<int?> completedAt,
  Value<int> updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$LessonProgressEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LessonProgressEntriesTable> {
  $$LessonProgressEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lessonId => $composableBuilder(
      column: $table.lessonId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get progressPercent => $composableBuilder(
      column: $table.progressPercent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get completedQuestions => $composableBuilder(
      column: $table.completedQuestions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalQuestions => $composableBuilder(
      column: $table.totalQuestions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bestScore => $composableBuilder(
      column: $table.bestScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get earnedXp => $composableBuilder(
      column: $table.earnedXp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stars => $composableBuilder(
      column: $table.stars, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastQuestionId => $composableBuilder(
      column: $table.lastQuestionId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$LessonProgressEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonProgressEntriesTable> {
  $$LessonProgressEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lessonId => $composableBuilder(
      column: $table.lessonId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get progressPercent => $composableBuilder(
      column: $table.progressPercent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get completedQuestions => $composableBuilder(
      column: $table.completedQuestions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalQuestions => $composableBuilder(
      column: $table.totalQuestions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bestScore => $composableBuilder(
      column: $table.bestScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get earnedXp => $composableBuilder(
      column: $table.earnedXp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stars => $composableBuilder(
      column: $table.stars, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastQuestionId => $composableBuilder(
      column: $table.lastQuestionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$LessonProgressEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonProgressEntriesTable> {
  $$LessonProgressEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get progressPercent => $composableBuilder(
      column: $table.progressPercent, builder: (column) => column);

  GeneratedColumn<int> get completedQuestions => $composableBuilder(
      column: $table.completedQuestions, builder: (column) => column);

  GeneratedColumn<int> get totalQuestions => $composableBuilder(
      column: $table.totalQuestions, builder: (column) => column);

  GeneratedColumn<int> get bestScore =>
      $composableBuilder(column: $table.bestScore, builder: (column) => column);

  GeneratedColumn<int> get earnedXp =>
      $composableBuilder(column: $table.earnedXp, builder: (column) => column);

  GeneratedColumn<int> get stars =>
      $composableBuilder(column: $table.stars, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get lastQuestionId => $composableBuilder(
      column: $table.lastQuestionId, builder: (column) => column);

  GeneratedColumn<int> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$LessonProgressEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LessonProgressEntriesTable,
    LessonProgressEntry,
    $$LessonProgressEntriesTableFilterComposer,
    $$LessonProgressEntriesTableOrderingComposer,
    $$LessonProgressEntriesTableAnnotationComposer,
    $$LessonProgressEntriesTableCreateCompanionBuilder,
    $$LessonProgressEntriesTableUpdateCompanionBuilder,
    (
      LessonProgressEntry,
      BaseReferences<_$AppDatabase, $LessonProgressEntriesTable,
          LessonProgressEntry>
    ),
    LessonProgressEntry,
    PrefetchHooks Function()> {
  $$LessonProgressEntriesTableTableManager(
      _$AppDatabase db, $LessonProgressEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LessonProgressEntriesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$LessonProgressEntriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LessonProgressEntriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> childId = const Value.absent(),
            Value<String> lessonId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<double> progressPercent = const Value.absent(),
            Value<int> completedQuestions = const Value.absent(),
            Value<int> totalQuestions = const Value.absent(),
            Value<int> bestScore = const Value.absent(),
            Value<int> earnedXp = const Value.absent(),
            Value<int> stars = const Value.absent(),
            Value<int> attempts = const Value.absent(),
            Value<String?> lastQuestionId = const Value.absent(),
            Value<int?> startedAt = const Value.absent(),
            Value<int?> completedAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LessonProgressEntriesCompanion(
            id: id,
            childId: childId,
            lessonId: lessonId,
            status: status,
            progressPercent: progressPercent,
            completedQuestions: completedQuestions,
            totalQuestions: totalQuestions,
            bestScore: bestScore,
            earnedXp: earnedXp,
            stars: stars,
            attempts: attempts,
            lastQuestionId: lastQuestionId,
            startedAt: startedAt,
            completedAt: completedAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String childId,
            required String lessonId,
            Value<String> status = const Value.absent(),
            Value<double> progressPercent = const Value.absent(),
            Value<int> completedQuestions = const Value.absent(),
            Value<int> totalQuestions = const Value.absent(),
            Value<int> bestScore = const Value.absent(),
            Value<int> earnedXp = const Value.absent(),
            Value<int> stars = const Value.absent(),
            Value<int> attempts = const Value.absent(),
            Value<String?> lastQuestionId = const Value.absent(),
            Value<int?> startedAt = const Value.absent(),
            Value<int?> completedAt = const Value.absent(),
            required int updatedAt,
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LessonProgressEntriesCompanion.insert(
            id: id,
            childId: childId,
            lessonId: lessonId,
            status: status,
            progressPercent: progressPercent,
            completedQuestions: completedQuestions,
            totalQuestions: totalQuestions,
            bestScore: bestScore,
            earnedXp: earnedXp,
            stars: stars,
            attempts: attempts,
            lastQuestionId: lastQuestionId,
            startedAt: startedAt,
            completedAt: completedAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LessonProgressEntriesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $LessonProgressEntriesTable,
        LessonProgressEntry,
        $$LessonProgressEntriesTableFilterComposer,
        $$LessonProgressEntriesTableOrderingComposer,
        $$LessonProgressEntriesTableAnnotationComposer,
        $$LessonProgressEntriesTableCreateCompanionBuilder,
        $$LessonProgressEntriesTableUpdateCompanionBuilder,
        (
          LessonProgressEntry,
          BaseReferences<_$AppDatabase, $LessonProgressEntriesTable,
              LessonProgressEntry>
        ),
        LessonProgressEntry,
        PrefetchHooks Function()>;
typedef $$QuizAttemptsTableCreateCompanionBuilder = QuizAttemptsCompanion
    Function({
  required String id,
  required String childId,
  Value<String?> sessionId,
  required String lessonId,
  required String questionId,
  required String quizType,
  Value<int> attemptIndex,
  required bool isCorrect,
  Value<bool> isCompleted,
  Value<int> score,
  Value<int> stars,
  Value<int> xpEarned,
  Value<int> timeTakenMs,
  Value<int> hintsUsed,
  Value<String?> answerJson,
  required int createdAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$QuizAttemptsTableUpdateCompanionBuilder = QuizAttemptsCompanion
    Function({
  Value<String> id,
  Value<String> childId,
  Value<String?> sessionId,
  Value<String> lessonId,
  Value<String> questionId,
  Value<String> quizType,
  Value<int> attemptIndex,
  Value<bool> isCorrect,
  Value<bool> isCompleted,
  Value<int> score,
  Value<int> stars,
  Value<int> xpEarned,
  Value<int> timeTakenMs,
  Value<int> hintsUsed,
  Value<String?> answerJson,
  Value<int> createdAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$QuizAttemptsTableFilterComposer
    extends Composer<_$AppDatabase, $QuizAttemptsTable> {
  $$QuizAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lessonId => $composableBuilder(
      column: $table.lessonId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get quizType => $composableBuilder(
      column: $table.quizType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attemptIndex => $composableBuilder(
      column: $table.attemptIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stars => $composableBuilder(
      column: $table.stars, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xpEarned => $composableBuilder(
      column: $table.xpEarned, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeTakenMs => $composableBuilder(
      column: $table.timeTakenMs, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hintsUsed => $composableBuilder(
      column: $table.hintsUsed, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answerJson => $composableBuilder(
      column: $table.answerJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$QuizAttemptsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuizAttemptsTable> {
  $$QuizAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lessonId => $composableBuilder(
      column: $table.lessonId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get quizType => $composableBuilder(
      column: $table.quizType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attemptIndex => $composableBuilder(
      column: $table.attemptIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stars => $composableBuilder(
      column: $table.stars, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xpEarned => $composableBuilder(
      column: $table.xpEarned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeTakenMs => $composableBuilder(
      column: $table.timeTakenMs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hintsUsed => $composableBuilder(
      column: $table.hintsUsed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answerJson => $composableBuilder(
      column: $table.answerJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$QuizAttemptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuizAttemptsTable> {
  $$QuizAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => column);

  GeneratedColumn<String> get quizType =>
      $composableBuilder(column: $table.quizType, builder: (column) => column);

  GeneratedColumn<int> get attemptIndex => $composableBuilder(
      column: $table.attemptIndex, builder: (column) => column);

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get stars =>
      $composableBuilder(column: $table.stars, builder: (column) => column);

  GeneratedColumn<int> get xpEarned =>
      $composableBuilder(column: $table.xpEarned, builder: (column) => column);

  GeneratedColumn<int> get timeTakenMs => $composableBuilder(
      column: $table.timeTakenMs, builder: (column) => column);

  GeneratedColumn<int> get hintsUsed =>
      $composableBuilder(column: $table.hintsUsed, builder: (column) => column);

  GeneratedColumn<String> get answerJson => $composableBuilder(
      column: $table.answerJson, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$QuizAttemptsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuizAttemptsTable,
    QuizAttempt,
    $$QuizAttemptsTableFilterComposer,
    $$QuizAttemptsTableOrderingComposer,
    $$QuizAttemptsTableAnnotationComposer,
    $$QuizAttemptsTableCreateCompanionBuilder,
    $$QuizAttemptsTableUpdateCompanionBuilder,
    (
      QuizAttempt,
      BaseReferences<_$AppDatabase, $QuizAttemptsTable, QuizAttempt>
    ),
    QuizAttempt,
    PrefetchHooks Function()> {
  $$QuizAttemptsTableTableManager(_$AppDatabase db, $QuizAttemptsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuizAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuizAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuizAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> childId = const Value.absent(),
            Value<String?> sessionId = const Value.absent(),
            Value<String> lessonId = const Value.absent(),
            Value<String> questionId = const Value.absent(),
            Value<String> quizType = const Value.absent(),
            Value<int> attemptIndex = const Value.absent(),
            Value<bool> isCorrect = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> score = const Value.absent(),
            Value<int> stars = const Value.absent(),
            Value<int> xpEarned = const Value.absent(),
            Value<int> timeTakenMs = const Value.absent(),
            Value<int> hintsUsed = const Value.absent(),
            Value<String?> answerJson = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuizAttemptsCompanion(
            id: id,
            childId: childId,
            sessionId: sessionId,
            lessonId: lessonId,
            questionId: questionId,
            quizType: quizType,
            attemptIndex: attemptIndex,
            isCorrect: isCorrect,
            isCompleted: isCompleted,
            score: score,
            stars: stars,
            xpEarned: xpEarned,
            timeTakenMs: timeTakenMs,
            hintsUsed: hintsUsed,
            answerJson: answerJson,
            createdAt: createdAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String childId,
            Value<String?> sessionId = const Value.absent(),
            required String lessonId,
            required String questionId,
            required String quizType,
            Value<int> attemptIndex = const Value.absent(),
            required bool isCorrect,
            Value<bool> isCompleted = const Value.absent(),
            Value<int> score = const Value.absent(),
            Value<int> stars = const Value.absent(),
            Value<int> xpEarned = const Value.absent(),
            Value<int> timeTakenMs = const Value.absent(),
            Value<int> hintsUsed = const Value.absent(),
            Value<String?> answerJson = const Value.absent(),
            required int createdAt,
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuizAttemptsCompanion.insert(
            id: id,
            childId: childId,
            sessionId: sessionId,
            lessonId: lessonId,
            questionId: questionId,
            quizType: quizType,
            attemptIndex: attemptIndex,
            isCorrect: isCorrect,
            isCompleted: isCompleted,
            score: score,
            stars: stars,
            xpEarned: xpEarned,
            timeTakenMs: timeTakenMs,
            hintsUsed: hintsUsed,
            answerJson: answerJson,
            createdAt: createdAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QuizAttemptsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuizAttemptsTable,
    QuizAttempt,
    $$QuizAttemptsTableFilterComposer,
    $$QuizAttemptsTableOrderingComposer,
    $$QuizAttemptsTableAnnotationComposer,
    $$QuizAttemptsTableCreateCompanionBuilder,
    $$QuizAttemptsTableUpdateCompanionBuilder,
    (
      QuizAttempt,
      BaseReferences<_$AppDatabase, $QuizAttemptsTable, QuizAttempt>
    ),
    QuizAttempt,
    PrefetchHooks Function()>;
typedef $$MissionTemplatesTableCreateCompanionBuilder
    = MissionTemplatesCompanion Function({
  required String id,
  required String type,
  required String difficulty,
  Value<String> topicScope,
  Value<String?> conditionJson,
  required String title,
  Value<String?> description,
  required String targetMetric,
  required int targetValue,
  required int xpReward,
  required int durationEstMin,
  Value<bool> isActive,
  Value<int> sortOrder,
  required int createdAt,
  required int updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$MissionTemplatesTableUpdateCompanionBuilder
    = MissionTemplatesCompanion Function({
  Value<String> id,
  Value<String> type,
  Value<String> difficulty,
  Value<String> topicScope,
  Value<String?> conditionJson,
  Value<String> title,
  Value<String?> description,
  Value<String> targetMetric,
  Value<int> targetValue,
  Value<int> xpReward,
  Value<int> durationEstMin,
  Value<bool> isActive,
  Value<int> sortOrder,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$MissionTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $MissionTemplatesTable> {
  $$MissionTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get topicScope => $composableBuilder(
      column: $table.topicScope, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get conditionJson => $composableBuilder(
      column: $table.conditionJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetMetric => $composableBuilder(
      column: $table.targetMetric, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xpReward => $composableBuilder(
      column: $table.xpReward, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationEstMin => $composableBuilder(
      column: $table.durationEstMin,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$MissionTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $MissionTemplatesTable> {
  $$MissionTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get topicScope => $composableBuilder(
      column: $table.topicScope, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get conditionJson => $composableBuilder(
      column: $table.conditionJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetMetric => $composableBuilder(
      column: $table.targetMetric,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xpReward => $composableBuilder(
      column: $table.xpReward, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationEstMin => $composableBuilder(
      column: $table.durationEstMin,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$MissionTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MissionTemplatesTable> {
  $$MissionTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<String> get topicScope => $composableBuilder(
      column: $table.topicScope, builder: (column) => column);

  GeneratedColumn<String> get conditionJson => $composableBuilder(
      column: $table.conditionJson, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get targetMetric => $composableBuilder(
      column: $table.targetMetric, builder: (column) => column);

  GeneratedColumn<int> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => column);

  GeneratedColumn<int> get xpReward =>
      $composableBuilder(column: $table.xpReward, builder: (column) => column);

  GeneratedColumn<int> get durationEstMin => $composableBuilder(
      column: $table.durationEstMin, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$MissionTemplatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MissionTemplatesTable,
    MissionTemplate,
    $$MissionTemplatesTableFilterComposer,
    $$MissionTemplatesTableOrderingComposer,
    $$MissionTemplatesTableAnnotationComposer,
    $$MissionTemplatesTableCreateCompanionBuilder,
    $$MissionTemplatesTableUpdateCompanionBuilder,
    (
      MissionTemplate,
      BaseReferences<_$AppDatabase, $MissionTemplatesTable, MissionTemplate>
    ),
    MissionTemplate,
    PrefetchHooks Function()> {
  $$MissionTemplatesTableTableManager(
      _$AppDatabase db, $MissionTemplatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MissionTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MissionTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MissionTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> difficulty = const Value.absent(),
            Value<String> topicScope = const Value.absent(),
            Value<String?> conditionJson = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> targetMetric = const Value.absent(),
            Value<int> targetValue = const Value.absent(),
            Value<int> xpReward = const Value.absent(),
            Value<int> durationEstMin = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MissionTemplatesCompanion(
            id: id,
            type: type,
            difficulty: difficulty,
            topicScope: topicScope,
            conditionJson: conditionJson,
            title: title,
            description: description,
            targetMetric: targetMetric,
            targetValue: targetValue,
            xpReward: xpReward,
            durationEstMin: durationEstMin,
            isActive: isActive,
            sortOrder: sortOrder,
            createdAt: createdAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String type,
            required String difficulty,
            Value<String> topicScope = const Value.absent(),
            Value<String?> conditionJson = const Value.absent(),
            required String title,
            Value<String?> description = const Value.absent(),
            required String targetMetric,
            required int targetValue,
            required int xpReward,
            required int durationEstMin,
            Value<bool> isActive = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            required int createdAt,
            required int updatedAt,
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MissionTemplatesCompanion.insert(
            id: id,
            type: type,
            difficulty: difficulty,
            topicScope: topicScope,
            conditionJson: conditionJson,
            title: title,
            description: description,
            targetMetric: targetMetric,
            targetValue: targetValue,
            xpReward: xpReward,
            durationEstMin: durationEstMin,
            isActive: isActive,
            sortOrder: sortOrder,
            createdAt: createdAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MissionTemplatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MissionTemplatesTable,
    MissionTemplate,
    $$MissionTemplatesTableFilterComposer,
    $$MissionTemplatesTableOrderingComposer,
    $$MissionTemplatesTableAnnotationComposer,
    $$MissionTemplatesTableCreateCompanionBuilder,
    $$MissionTemplatesTableUpdateCompanionBuilder,
    (
      MissionTemplate,
      BaseReferences<_$AppDatabase, $MissionTemplatesTable, MissionTemplate>
    ),
    MissionTemplate,
    PrefetchHooks Function()>;
typedef $$DailyMissionsTableCreateCompanionBuilder = DailyMissionsCompanion
    Function({
  required String id,
  required String childId,
  required String date,
  Value<int> slot,
  required String missionTemplateId,
  Value<String> paramsJson,
  Value<String> status,
  Value<int> progressValue,
  required int targetValue,
  required int xpReward,
  Value<int?> completedAt,
  required int createdAt,
  required int updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$DailyMissionsTableUpdateCompanionBuilder = DailyMissionsCompanion
    Function({
  Value<String> id,
  Value<String> childId,
  Value<String> date,
  Value<int> slot,
  Value<String> missionTemplateId,
  Value<String> paramsJson,
  Value<String> status,
  Value<int> progressValue,
  Value<int> targetValue,
  Value<int> xpReward,
  Value<int?> completedAt,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$DailyMissionsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyMissionsTable> {
  $$DailyMissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get slot => $composableBuilder(
      column: $table.slot, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get missionTemplateId => $composableBuilder(
      column: $table.missionTemplateId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paramsJson => $composableBuilder(
      column: $table.paramsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get progressValue => $composableBuilder(
      column: $table.progressValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xpReward => $composableBuilder(
      column: $table.xpReward, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$DailyMissionsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyMissionsTable> {
  $$DailyMissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get slot => $composableBuilder(
      column: $table.slot, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get missionTemplateId => $composableBuilder(
      column: $table.missionTemplateId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paramsJson => $composableBuilder(
      column: $table.paramsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get progressValue => $composableBuilder(
      column: $table.progressValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xpReward => $composableBuilder(
      column: $table.xpReward, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$DailyMissionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyMissionsTable> {
  $$DailyMissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumn<String> get missionTemplateId => $composableBuilder(
      column: $table.missionTemplateId, builder: (column) => column);

  GeneratedColumn<String> get paramsJson => $composableBuilder(
      column: $table.paramsJson, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get progressValue => $composableBuilder(
      column: $table.progressValue, builder: (column) => column);

  GeneratedColumn<int> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => column);

  GeneratedColumn<int> get xpReward =>
      $composableBuilder(column: $table.xpReward, builder: (column) => column);

  GeneratedColumn<int> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$DailyMissionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyMissionsTable,
    DailyMission,
    $$DailyMissionsTableFilterComposer,
    $$DailyMissionsTableOrderingComposer,
    $$DailyMissionsTableAnnotationComposer,
    $$DailyMissionsTableCreateCompanionBuilder,
    $$DailyMissionsTableUpdateCompanionBuilder,
    (
      DailyMission,
      BaseReferences<_$AppDatabase, $DailyMissionsTable, DailyMission>
    ),
    DailyMission,
    PrefetchHooks Function()> {
  $$DailyMissionsTableTableManager(_$AppDatabase db, $DailyMissionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyMissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyMissionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyMissionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> childId = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<int> slot = const Value.absent(),
            Value<String> missionTemplateId = const Value.absent(),
            Value<String> paramsJson = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> progressValue = const Value.absent(),
            Value<int> targetValue = const Value.absent(),
            Value<int> xpReward = const Value.absent(),
            Value<int?> completedAt = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyMissionsCompanion(
            id: id,
            childId: childId,
            date: date,
            slot: slot,
            missionTemplateId: missionTemplateId,
            paramsJson: paramsJson,
            status: status,
            progressValue: progressValue,
            targetValue: targetValue,
            xpReward: xpReward,
            completedAt: completedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String childId,
            required String date,
            Value<int> slot = const Value.absent(),
            required String missionTemplateId,
            Value<String> paramsJson = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> progressValue = const Value.absent(),
            required int targetValue,
            required int xpReward,
            Value<int?> completedAt = const Value.absent(),
            required int createdAt,
            required int updatedAt,
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyMissionsCompanion.insert(
            id: id,
            childId: childId,
            date: date,
            slot: slot,
            missionTemplateId: missionTemplateId,
            paramsJson: paramsJson,
            status: status,
            progressValue: progressValue,
            targetValue: targetValue,
            xpReward: xpReward,
            completedAt: completedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailyMissionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DailyMissionsTable,
    DailyMission,
    $$DailyMissionsTableFilterComposer,
    $$DailyMissionsTableOrderingComposer,
    $$DailyMissionsTableAnnotationComposer,
    $$DailyMissionsTableCreateCompanionBuilder,
    $$DailyMissionsTableUpdateCompanionBuilder,
    (
      DailyMission,
      BaseReferences<_$AppDatabase, $DailyMissionsTable, DailyMission>
    ),
    DailyMission,
    PrefetchHooks Function()>;
typedef $$SkillTargetsTableCreateCompanionBuilder = SkillTargetsCompanion
    Function({
  required String id,
  required String pathId,
  required int level,
  required String skillKey,
  required int requiredUnits,
  required String unitType,
  Value<bool> isActive,
  required int createdAt,
  required int updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$SkillTargetsTableUpdateCompanionBuilder = SkillTargetsCompanion
    Function({
  Value<String> id,
  Value<String> pathId,
  Value<int> level,
  Value<String> skillKey,
  Value<int> requiredUnits,
  Value<String> unitType,
  Value<bool> isActive,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$SkillTargetsTableFilterComposer
    extends Composer<_$AppDatabase, $SkillTargetsTable> {
  $$SkillTargetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pathId => $composableBuilder(
      column: $table.pathId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get skillKey => $composableBuilder(
      column: $table.skillKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get requiredUnits => $composableBuilder(
      column: $table.requiredUnits, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unitType => $composableBuilder(
      column: $table.unitType, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$SkillTargetsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkillTargetsTable> {
  $$SkillTargetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pathId => $composableBuilder(
      column: $table.pathId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get skillKey => $composableBuilder(
      column: $table.skillKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get requiredUnits => $composableBuilder(
      column: $table.requiredUnits,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unitType => $composableBuilder(
      column: $table.unitType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$SkillTargetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkillTargetsTable> {
  $$SkillTargetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pathId =>
      $composableBuilder(column: $table.pathId, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get skillKey =>
      $composableBuilder(column: $table.skillKey, builder: (column) => column);

  GeneratedColumn<int> get requiredUnits => $composableBuilder(
      column: $table.requiredUnits, builder: (column) => column);

  GeneratedColumn<String> get unitType =>
      $composableBuilder(column: $table.unitType, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$SkillTargetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SkillTargetsTable,
    SkillTarget,
    $$SkillTargetsTableFilterComposer,
    $$SkillTargetsTableOrderingComposer,
    $$SkillTargetsTableAnnotationComposer,
    $$SkillTargetsTableCreateCompanionBuilder,
    $$SkillTargetsTableUpdateCompanionBuilder,
    (
      SkillTarget,
      BaseReferences<_$AppDatabase, $SkillTargetsTable, SkillTarget>
    ),
    SkillTarget,
    PrefetchHooks Function()> {
  $$SkillTargetsTableTableManager(_$AppDatabase db, $SkillTargetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkillTargetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkillTargetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkillTargetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> pathId = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String> skillKey = const Value.absent(),
            Value<int> requiredUnits = const Value.absent(),
            Value<String> unitType = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SkillTargetsCompanion(
            id: id,
            pathId: pathId,
            level: level,
            skillKey: skillKey,
            requiredUnits: requiredUnits,
            unitType: unitType,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String pathId,
            required int level,
            required String skillKey,
            required int requiredUnits,
            required String unitType,
            Value<bool> isActive = const Value.absent(),
            required int createdAt,
            required int updatedAt,
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SkillTargetsCompanion.insert(
            id: id,
            pathId: pathId,
            level: level,
            skillKey: skillKey,
            requiredUnits: requiredUnits,
            unitType: unitType,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SkillTargetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SkillTargetsTable,
    SkillTarget,
    $$SkillTargetsTableFilterComposer,
    $$SkillTargetsTableOrderingComposer,
    $$SkillTargetsTableAnnotationComposer,
    $$SkillTargetsTableCreateCompanionBuilder,
    $$SkillTargetsTableUpdateCompanionBuilder,
    (
      SkillTarget,
      BaseReferences<_$AppDatabase, $SkillTargetsTable, SkillTarget>
    ),
    SkillTarget,
    PrefetchHooks Function()>;
typedef $$SkillProgressEntriesTableCreateCompanionBuilder
    = SkillProgressEntriesCompanion Function({
  required String id,
  required String childId,
  required String pathId,
  required int level,
  required String skillKey,
  Value<int> completedUnits,
  required int requiredUnits,
  Value<double> progressPercent,
  Value<int> correctCount,
  Value<int> attemptCount,
  Value<int> earnedXp,
  required int updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$SkillProgressEntriesTableUpdateCompanionBuilder
    = SkillProgressEntriesCompanion Function({
  Value<String> id,
  Value<String> childId,
  Value<String> pathId,
  Value<int> level,
  Value<String> skillKey,
  Value<int> completedUnits,
  Value<int> requiredUnits,
  Value<double> progressPercent,
  Value<int> correctCount,
  Value<int> attemptCount,
  Value<int> earnedXp,
  Value<int> updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$SkillProgressEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SkillProgressEntriesTable> {
  $$SkillProgressEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pathId => $composableBuilder(
      column: $table.pathId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get skillKey => $composableBuilder(
      column: $table.skillKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get completedUnits => $composableBuilder(
      column: $table.completedUnits,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get requiredUnits => $composableBuilder(
      column: $table.requiredUnits, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get progressPercent => $composableBuilder(
      column: $table.progressPercent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get correctCount => $composableBuilder(
      column: $table.correctCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get earnedXp => $composableBuilder(
      column: $table.earnedXp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$SkillProgressEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SkillProgressEntriesTable> {
  $$SkillProgressEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pathId => $composableBuilder(
      column: $table.pathId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get skillKey => $composableBuilder(
      column: $table.skillKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get completedUnits => $composableBuilder(
      column: $table.completedUnits,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get requiredUnits => $composableBuilder(
      column: $table.requiredUnits,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get progressPercent => $composableBuilder(
      column: $table.progressPercent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get correctCount => $composableBuilder(
      column: $table.correctCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get earnedXp => $composableBuilder(
      column: $table.earnedXp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$SkillProgressEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkillProgressEntriesTable> {
  $$SkillProgressEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get pathId =>
      $composableBuilder(column: $table.pathId, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get skillKey =>
      $composableBuilder(column: $table.skillKey, builder: (column) => column);

  GeneratedColumn<int> get completedUnits => $composableBuilder(
      column: $table.completedUnits, builder: (column) => column);

  GeneratedColumn<int> get requiredUnits => $composableBuilder(
      column: $table.requiredUnits, builder: (column) => column);

  GeneratedColumn<double> get progressPercent => $composableBuilder(
      column: $table.progressPercent, builder: (column) => column);

  GeneratedColumn<int> get correctCount => $composableBuilder(
      column: $table.correctCount, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => column);

  GeneratedColumn<int> get earnedXp =>
      $composableBuilder(column: $table.earnedXp, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$SkillProgressEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SkillProgressEntriesTable,
    SkillProgressEntry,
    $$SkillProgressEntriesTableFilterComposer,
    $$SkillProgressEntriesTableOrderingComposer,
    $$SkillProgressEntriesTableAnnotationComposer,
    $$SkillProgressEntriesTableCreateCompanionBuilder,
    $$SkillProgressEntriesTableUpdateCompanionBuilder,
    (
      SkillProgressEntry,
      BaseReferences<_$AppDatabase, $SkillProgressEntriesTable,
          SkillProgressEntry>
    ),
    SkillProgressEntry,
    PrefetchHooks Function()> {
  $$SkillProgressEntriesTableTableManager(
      _$AppDatabase db, $SkillProgressEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkillProgressEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkillProgressEntriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkillProgressEntriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> childId = const Value.absent(),
            Value<String> pathId = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String> skillKey = const Value.absent(),
            Value<int> completedUnits = const Value.absent(),
            Value<int> requiredUnits = const Value.absent(),
            Value<double> progressPercent = const Value.absent(),
            Value<int> correctCount = const Value.absent(),
            Value<int> attemptCount = const Value.absent(),
            Value<int> earnedXp = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SkillProgressEntriesCompanion(
            id: id,
            childId: childId,
            pathId: pathId,
            level: level,
            skillKey: skillKey,
            completedUnits: completedUnits,
            requiredUnits: requiredUnits,
            progressPercent: progressPercent,
            correctCount: correctCount,
            attemptCount: attemptCount,
            earnedXp: earnedXp,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String childId,
            required String pathId,
            required int level,
            required String skillKey,
            Value<int> completedUnits = const Value.absent(),
            required int requiredUnits,
            Value<double> progressPercent = const Value.absent(),
            Value<int> correctCount = const Value.absent(),
            Value<int> attemptCount = const Value.absent(),
            Value<int> earnedXp = const Value.absent(),
            required int updatedAt,
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SkillProgressEntriesCompanion.insert(
            id: id,
            childId: childId,
            pathId: pathId,
            level: level,
            skillKey: skillKey,
            completedUnits: completedUnits,
            requiredUnits: requiredUnits,
            progressPercent: progressPercent,
            correctCount: correctCount,
            attemptCount: attemptCount,
            earnedXp: earnedXp,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SkillProgressEntriesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SkillProgressEntriesTable,
        SkillProgressEntry,
        $$SkillProgressEntriesTableFilterComposer,
        $$SkillProgressEntriesTableOrderingComposer,
        $$SkillProgressEntriesTableAnnotationComposer,
        $$SkillProgressEntriesTableCreateCompanionBuilder,
        $$SkillProgressEntriesTableUpdateCompanionBuilder,
        (
          SkillProgressEntry,
          BaseReferences<_$AppDatabase, $SkillProgressEntriesTable,
              SkillProgressEntry>
        ),
        SkillProgressEntry,
        PrefetchHooks Function()>;
typedef $$LevelDefinitionsTableCreateCompanionBuilder
    = LevelDefinitionsCompanion Function({
  Value<int> level,
  required int xpRequired,
  required int xpDelta,
  Value<double> minAccuracy,
  Value<int> minWords,
  required String title,
  Value<String?> badgeRewardId,
  Value<String?> unlockFeature,
  Value<bool> isActive,
  required int createdAt,
  required int updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
});
typedef $$LevelDefinitionsTableUpdateCompanionBuilder
    = LevelDefinitionsCompanion Function({
  Value<int> level,
  Value<int> xpRequired,
  Value<int> xpDelta,
  Value<double> minAccuracy,
  Value<int> minWords,
  Value<String> title,
  Value<String?> badgeRewardId,
  Value<String?> unlockFeature,
  Value<bool> isActive,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
});

class $$LevelDefinitionsTableFilterComposer
    extends Composer<_$AppDatabase, $LevelDefinitionsTable> {
  $$LevelDefinitionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xpRequired => $composableBuilder(
      column: $table.xpRequired, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xpDelta => $composableBuilder(
      column: $table.xpDelta, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get minAccuracy => $composableBuilder(
      column: $table.minAccuracy, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minWords => $composableBuilder(
      column: $table.minWords, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get badgeRewardId => $composableBuilder(
      column: $table.badgeRewardId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unlockFeature => $composableBuilder(
      column: $table.unlockFeature, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$LevelDefinitionsTableOrderingComposer
    extends Composer<_$AppDatabase, $LevelDefinitionsTable> {
  $$LevelDefinitionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xpRequired => $composableBuilder(
      column: $table.xpRequired, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xpDelta => $composableBuilder(
      column: $table.xpDelta, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get minAccuracy => $composableBuilder(
      column: $table.minAccuracy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minWords => $composableBuilder(
      column: $table.minWords, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get badgeRewardId => $composableBuilder(
      column: $table.badgeRewardId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unlockFeature => $composableBuilder(
      column: $table.unlockFeature,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$LevelDefinitionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LevelDefinitionsTable> {
  $$LevelDefinitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get xpRequired => $composableBuilder(
      column: $table.xpRequired, builder: (column) => column);

  GeneratedColumn<int> get xpDelta =>
      $composableBuilder(column: $table.xpDelta, builder: (column) => column);

  GeneratedColumn<double> get minAccuracy => $composableBuilder(
      column: $table.minAccuracy, builder: (column) => column);

  GeneratedColumn<int> get minWords =>
      $composableBuilder(column: $table.minWords, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get badgeRewardId => $composableBuilder(
      column: $table.badgeRewardId, builder: (column) => column);

  GeneratedColumn<String> get unlockFeature => $composableBuilder(
      column: $table.unlockFeature, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$LevelDefinitionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LevelDefinitionsTable,
    LevelDefinition,
    $$LevelDefinitionsTableFilterComposer,
    $$LevelDefinitionsTableOrderingComposer,
    $$LevelDefinitionsTableAnnotationComposer,
    $$LevelDefinitionsTableCreateCompanionBuilder,
    $$LevelDefinitionsTableUpdateCompanionBuilder,
    (
      LevelDefinition,
      BaseReferences<_$AppDatabase, $LevelDefinitionsTable, LevelDefinition>
    ),
    LevelDefinition,
    PrefetchHooks Function()> {
  $$LevelDefinitionsTableTableManager(
      _$AppDatabase db, $LevelDefinitionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LevelDefinitionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LevelDefinitionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LevelDefinitionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> level = const Value.absent(),
            Value<int> xpRequired = const Value.absent(),
            Value<int> xpDelta = const Value.absent(),
            Value<double> minAccuracy = const Value.absent(),
            Value<int> minWords = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> badgeRewardId = const Value.absent(),
            Value<String?> unlockFeature = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
          }) =>
              LevelDefinitionsCompanion(
            level: level,
            xpRequired: xpRequired,
            xpDelta: xpDelta,
            minAccuracy: minAccuracy,
            minWords: minWords,
            title: title,
            badgeRewardId: badgeRewardId,
            unlockFeature: unlockFeature,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> level = const Value.absent(),
            required int xpRequired,
            required int xpDelta,
            Value<double> minAccuracy = const Value.absent(),
            Value<int> minWords = const Value.absent(),
            required String title,
            Value<String?> badgeRewardId = const Value.absent(),
            Value<String?> unlockFeature = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            required int createdAt,
            required int updatedAt,
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
          }) =>
              LevelDefinitionsCompanion.insert(
            level: level,
            xpRequired: xpRequired,
            xpDelta: xpDelta,
            minAccuracy: minAccuracy,
            minWords: minWords,
            title: title,
            badgeRewardId: badgeRewardId,
            unlockFeature: unlockFeature,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LevelDefinitionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LevelDefinitionsTable,
    LevelDefinition,
    $$LevelDefinitionsTableFilterComposer,
    $$LevelDefinitionsTableOrderingComposer,
    $$LevelDefinitionsTableAnnotationComposer,
    $$LevelDefinitionsTableCreateCompanionBuilder,
    $$LevelDefinitionsTableUpdateCompanionBuilder,
    (
      LevelDefinition,
      BaseReferences<_$AppDatabase, $LevelDefinitionsTable, LevelDefinition>
    ),
    LevelDefinition,
    PrefetchHooks Function()>;
typedef $$WordMasteryEntriesTableCreateCompanionBuilder
    = WordMasteryEntriesCompanion Function({
  required String childId,
  required String wordId,
  Value<String?> word,
  Value<int> timesSeen,
  Value<int> timesCorrect,
  Value<int> timesWrong,
  Value<double> masteryScore,
  Value<int?> lastSeenAt,
  Value<int?> nextReviewAt,
  Value<String> status,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$WordMasteryEntriesTableUpdateCompanionBuilder
    = WordMasteryEntriesCompanion Function({
  Value<String> childId,
  Value<String> wordId,
  Value<String?> word,
  Value<int> timesSeen,
  Value<int> timesCorrect,
  Value<int> timesWrong,
  Value<double> masteryScore,
  Value<int?> lastSeenAt,
  Value<int?> nextReviewAt,
  Value<String> status,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$WordMasteryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $WordMasteryEntriesTable> {
  $$WordMasteryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wordId => $composableBuilder(
      column: $table.wordId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timesSeen => $composableBuilder(
      column: $table.timesSeen, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timesCorrect => $composableBuilder(
      column: $table.timesCorrect, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timesWrong => $composableBuilder(
      column: $table.timesWrong, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get masteryScore => $composableBuilder(
      column: $table.masteryScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSeenAt => $composableBuilder(
      column: $table.lastSeenAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get nextReviewAt => $composableBuilder(
      column: $table.nextReviewAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$WordMasteryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WordMasteryEntriesTable> {
  $$WordMasteryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wordId => $composableBuilder(
      column: $table.wordId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timesSeen => $composableBuilder(
      column: $table.timesSeen, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timesCorrect => $composableBuilder(
      column: $table.timesCorrect,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timesWrong => $composableBuilder(
      column: $table.timesWrong, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get masteryScore => $composableBuilder(
      column: $table.masteryScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSeenAt => $composableBuilder(
      column: $table.lastSeenAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get nextReviewAt => $composableBuilder(
      column: $table.nextReviewAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$WordMasteryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordMasteryEntriesTable> {
  $$WordMasteryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get wordId =>
      $composableBuilder(column: $table.wordId, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<int> get timesSeen =>
      $composableBuilder(column: $table.timesSeen, builder: (column) => column);

  GeneratedColumn<int> get timesCorrect => $composableBuilder(
      column: $table.timesCorrect, builder: (column) => column);

  GeneratedColumn<int> get timesWrong => $composableBuilder(
      column: $table.timesWrong, builder: (column) => column);

  GeneratedColumn<double> get masteryScore => $composableBuilder(
      column: $table.masteryScore, builder: (column) => column);

  GeneratedColumn<int> get lastSeenAt => $composableBuilder(
      column: $table.lastSeenAt, builder: (column) => column);

  GeneratedColumn<int> get nextReviewAt => $composableBuilder(
      column: $table.nextReviewAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$WordMasteryEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WordMasteryEntriesTable,
    WordMasteryEntry,
    $$WordMasteryEntriesTableFilterComposer,
    $$WordMasteryEntriesTableOrderingComposer,
    $$WordMasteryEntriesTableAnnotationComposer,
    $$WordMasteryEntriesTableCreateCompanionBuilder,
    $$WordMasteryEntriesTableUpdateCompanionBuilder,
    (
      WordMasteryEntry,
      BaseReferences<_$AppDatabase, $WordMasteryEntriesTable, WordMasteryEntry>
    ),
    WordMasteryEntry,
    PrefetchHooks Function()> {
  $$WordMasteryEntriesTableTableManager(
      _$AppDatabase db, $WordMasteryEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordMasteryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordMasteryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordMasteryEntriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> childId = const Value.absent(),
            Value<String> wordId = const Value.absent(),
            Value<String?> word = const Value.absent(),
            Value<int> timesSeen = const Value.absent(),
            Value<int> timesCorrect = const Value.absent(),
            Value<int> timesWrong = const Value.absent(),
            Value<double> masteryScore = const Value.absent(),
            Value<int?> lastSeenAt = const Value.absent(),
            Value<int?> nextReviewAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WordMasteryEntriesCompanion(
            childId: childId,
            wordId: wordId,
            word: word,
            timesSeen: timesSeen,
            timesCorrect: timesCorrect,
            timesWrong: timesWrong,
            masteryScore: masteryScore,
            lastSeenAt: lastSeenAt,
            nextReviewAt: nextReviewAt,
            status: status,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String childId,
            required String wordId,
            Value<String?> word = const Value.absent(),
            Value<int> timesSeen = const Value.absent(),
            Value<int> timesCorrect = const Value.absent(),
            Value<int> timesWrong = const Value.absent(),
            Value<double> masteryScore = const Value.absent(),
            Value<int?> lastSeenAt = const Value.absent(),
            Value<int?> nextReviewAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WordMasteryEntriesCompanion.insert(
            childId: childId,
            wordId: wordId,
            word: word,
            timesSeen: timesSeen,
            timesCorrect: timesCorrect,
            timesWrong: timesWrong,
            masteryScore: masteryScore,
            lastSeenAt: lastSeenAt,
            nextReviewAt: nextReviewAt,
            status: status,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WordMasteryEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WordMasteryEntriesTable,
    WordMasteryEntry,
    $$WordMasteryEntriesTableFilterComposer,
    $$WordMasteryEntriesTableOrderingComposer,
    $$WordMasteryEntriesTableAnnotationComposer,
    $$WordMasteryEntriesTableCreateCompanionBuilder,
    $$WordMasteryEntriesTableUpdateCompanionBuilder,
    (
      WordMasteryEntry,
      BaseReferences<_$AppDatabase, $WordMasteryEntriesTable, WordMasteryEntry>
    ),
    WordMasteryEntry,
    PrefetchHooks Function()>;
typedef $$ChildProgressEntriesTableCreateCompanionBuilder
    = ChildProgressEntriesCompanion Function({
  required String childId,
  Value<int> currentLevel,
  Value<int> currentXp,
  Value<int> totalXp,
  Value<int> xpToNextLevel,
  Value<double> accuracy7d,
  Value<int> wordsMastered,
  Value<int> streakDays,
  Value<bool> masteryBlocked,
  required int updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$ChildProgressEntriesTableUpdateCompanionBuilder
    = ChildProgressEntriesCompanion Function({
  Value<String> childId,
  Value<int> currentLevel,
  Value<int> currentXp,
  Value<int> totalXp,
  Value<int> xpToNextLevel,
  Value<double> accuracy7d,
  Value<int> wordsMastered,
  Value<int> streakDays,
  Value<bool> masteryBlocked,
  Value<int> updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$ChildProgressEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $ChildProgressEntriesTable> {
  $$ChildProgressEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentLevel => $composableBuilder(
      column: $table.currentLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentXp => $composableBuilder(
      column: $table.currentXp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalXp => $composableBuilder(
      column: $table.totalXp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xpToNextLevel => $composableBuilder(
      column: $table.xpToNextLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get accuracy7d => $composableBuilder(
      column: $table.accuracy7d, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wordsMastered => $composableBuilder(
      column: $table.wordsMastered, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get masteryBlocked => $composableBuilder(
      column: $table.masteryBlocked,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$ChildProgressEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChildProgressEntriesTable> {
  $$ChildProgressEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentLevel => $composableBuilder(
      column: $table.currentLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentXp => $composableBuilder(
      column: $table.currentXp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalXp => $composableBuilder(
      column: $table.totalXp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xpToNextLevel => $composableBuilder(
      column: $table.xpToNextLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get accuracy7d => $composableBuilder(
      column: $table.accuracy7d, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wordsMastered => $composableBuilder(
      column: $table.wordsMastered,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get masteryBlocked => $composableBuilder(
      column: $table.masteryBlocked,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$ChildProgressEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChildProgressEntriesTable> {
  $$ChildProgressEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<int> get currentLevel => $composableBuilder(
      column: $table.currentLevel, builder: (column) => column);

  GeneratedColumn<int> get currentXp =>
      $composableBuilder(column: $table.currentXp, builder: (column) => column);

  GeneratedColumn<int> get totalXp =>
      $composableBuilder(column: $table.totalXp, builder: (column) => column);

  GeneratedColumn<int> get xpToNextLevel => $composableBuilder(
      column: $table.xpToNextLevel, builder: (column) => column);

  GeneratedColumn<double> get accuracy7d => $composableBuilder(
      column: $table.accuracy7d, builder: (column) => column);

  GeneratedColumn<int> get wordsMastered => $composableBuilder(
      column: $table.wordsMastered, builder: (column) => column);

  GeneratedColumn<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => column);

  GeneratedColumn<bool> get masteryBlocked => $composableBuilder(
      column: $table.masteryBlocked, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$ChildProgressEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChildProgressEntriesTable,
    ChildProgressEntry,
    $$ChildProgressEntriesTableFilterComposer,
    $$ChildProgressEntriesTableOrderingComposer,
    $$ChildProgressEntriesTableAnnotationComposer,
    $$ChildProgressEntriesTableCreateCompanionBuilder,
    $$ChildProgressEntriesTableUpdateCompanionBuilder,
    (
      ChildProgressEntry,
      BaseReferences<_$AppDatabase, $ChildProgressEntriesTable,
          ChildProgressEntry>
    ),
    ChildProgressEntry,
    PrefetchHooks Function()> {
  $$ChildProgressEntriesTableTableManager(
      _$AppDatabase db, $ChildProgressEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChildProgressEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChildProgressEntriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChildProgressEntriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> childId = const Value.absent(),
            Value<int> currentLevel = const Value.absent(),
            Value<int> currentXp = const Value.absent(),
            Value<int> totalXp = const Value.absent(),
            Value<int> xpToNextLevel = const Value.absent(),
            Value<double> accuracy7d = const Value.absent(),
            Value<int> wordsMastered = const Value.absent(),
            Value<int> streakDays = const Value.absent(),
            Value<bool> masteryBlocked = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildProgressEntriesCompanion(
            childId: childId,
            currentLevel: currentLevel,
            currentXp: currentXp,
            totalXp: totalXp,
            xpToNextLevel: xpToNextLevel,
            accuracy7d: accuracy7d,
            wordsMastered: wordsMastered,
            streakDays: streakDays,
            masteryBlocked: masteryBlocked,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String childId,
            Value<int> currentLevel = const Value.absent(),
            Value<int> currentXp = const Value.absent(),
            Value<int> totalXp = const Value.absent(),
            Value<int> xpToNextLevel = const Value.absent(),
            Value<double> accuracy7d = const Value.absent(),
            Value<int> wordsMastered = const Value.absent(),
            Value<int> streakDays = const Value.absent(),
            Value<bool> masteryBlocked = const Value.absent(),
            required int updatedAt,
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildProgressEntriesCompanion.insert(
            childId: childId,
            currentLevel: currentLevel,
            currentXp: currentXp,
            totalXp: totalXp,
            xpToNextLevel: xpToNextLevel,
            accuracy7d: accuracy7d,
            wordsMastered: wordsMastered,
            streakDays: streakDays,
            masteryBlocked: masteryBlocked,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChildProgressEntriesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ChildProgressEntriesTable,
        ChildProgressEntry,
        $$ChildProgressEntriesTableFilterComposer,
        $$ChildProgressEntriesTableOrderingComposer,
        $$ChildProgressEntriesTableAnnotationComposer,
        $$ChildProgressEntriesTableCreateCompanionBuilder,
        $$ChildProgressEntriesTableUpdateCompanionBuilder,
        (
          ChildProgressEntry,
          BaseReferences<_$AppDatabase, $ChildProgressEntriesTable,
              ChildProgressEntry>
        ),
        ChildProgressEntry,
        PrefetchHooks Function()>;
typedef $$ChildSignalsTableCreateCompanionBuilder = ChildSignalsCompanion
    Function({
  required String childId,
  Value<double> accuracy7d,
  Value<String> accuracyByTopic,
  Value<String> accuracyByType,
  Value<double> avgResponseSec,
  Value<String> weakTopics,
  Value<String> dueForReview,
  Value<int> daysSinceNewWords,
  Value<int> streakDays,
  Value<bool> streakAtRisk,
  Value<double> missionCompletion7d,
  Value<String> preferredMissionTypes,
  Value<int> preferredHour,
  required int updatedAt,
  Value<int> rowid,
});
typedef $$ChildSignalsTableUpdateCompanionBuilder = ChildSignalsCompanion
    Function({
  Value<String> childId,
  Value<double> accuracy7d,
  Value<String> accuracyByTopic,
  Value<String> accuracyByType,
  Value<double> avgResponseSec,
  Value<String> weakTopics,
  Value<String> dueForReview,
  Value<int> daysSinceNewWords,
  Value<int> streakDays,
  Value<bool> streakAtRisk,
  Value<double> missionCompletion7d,
  Value<String> preferredMissionTypes,
  Value<int> preferredHour,
  Value<int> updatedAt,
  Value<int> rowid,
});

class $$ChildSignalsTableFilterComposer
    extends Composer<_$AppDatabase, $ChildSignalsTable> {
  $$ChildSignalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get accuracy7d => $composableBuilder(
      column: $table.accuracy7d, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accuracyByTopic => $composableBuilder(
      column: $table.accuracyByTopic,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accuracyByType => $composableBuilder(
      column: $table.accuracyByType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get avgResponseSec => $composableBuilder(
      column: $table.avgResponseSec,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get weakTopics => $composableBuilder(
      column: $table.weakTopics, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dueForReview => $composableBuilder(
      column: $table.dueForReview, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get daysSinceNewWords => $composableBuilder(
      column: $table.daysSinceNewWords,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get streakAtRisk => $composableBuilder(
      column: $table.streakAtRisk, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get missionCompletion7d => $composableBuilder(
      column: $table.missionCompletion7d,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get preferredMissionTypes => $composableBuilder(
      column: $table.preferredMissionTypes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get preferredHour => $composableBuilder(
      column: $table.preferredHour, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ChildSignalsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChildSignalsTable> {
  $$ChildSignalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get accuracy7d => $composableBuilder(
      column: $table.accuracy7d, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accuracyByTopic => $composableBuilder(
      column: $table.accuracyByTopic,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accuracyByType => $composableBuilder(
      column: $table.accuracyByType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get avgResponseSec => $composableBuilder(
      column: $table.avgResponseSec,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get weakTopics => $composableBuilder(
      column: $table.weakTopics, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dueForReview => $composableBuilder(
      column: $table.dueForReview,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get daysSinceNewWords => $composableBuilder(
      column: $table.daysSinceNewWords,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get streakAtRisk => $composableBuilder(
      column: $table.streakAtRisk,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get missionCompletion7d => $composableBuilder(
      column: $table.missionCompletion7d,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preferredMissionTypes => $composableBuilder(
      column: $table.preferredMissionTypes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get preferredHour => $composableBuilder(
      column: $table.preferredHour,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ChildSignalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChildSignalsTable> {
  $$ChildSignalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<double> get accuracy7d => $composableBuilder(
      column: $table.accuracy7d, builder: (column) => column);

  GeneratedColumn<String> get accuracyByTopic => $composableBuilder(
      column: $table.accuracyByTopic, builder: (column) => column);

  GeneratedColumn<String> get accuracyByType => $composableBuilder(
      column: $table.accuracyByType, builder: (column) => column);

  GeneratedColumn<double> get avgResponseSec => $composableBuilder(
      column: $table.avgResponseSec, builder: (column) => column);

  GeneratedColumn<String> get weakTopics => $composableBuilder(
      column: $table.weakTopics, builder: (column) => column);

  GeneratedColumn<String> get dueForReview => $composableBuilder(
      column: $table.dueForReview, builder: (column) => column);

  GeneratedColumn<int> get daysSinceNewWords => $composableBuilder(
      column: $table.daysSinceNewWords, builder: (column) => column);

  GeneratedColumn<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => column);

  GeneratedColumn<bool> get streakAtRisk => $composableBuilder(
      column: $table.streakAtRisk, builder: (column) => column);

  GeneratedColumn<double> get missionCompletion7d => $composableBuilder(
      column: $table.missionCompletion7d, builder: (column) => column);

  GeneratedColumn<String> get preferredMissionTypes => $composableBuilder(
      column: $table.preferredMissionTypes, builder: (column) => column);

  GeneratedColumn<int> get preferredHour => $composableBuilder(
      column: $table.preferredHour, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ChildSignalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChildSignalsTable,
    ChildSignal,
    $$ChildSignalsTableFilterComposer,
    $$ChildSignalsTableOrderingComposer,
    $$ChildSignalsTableAnnotationComposer,
    $$ChildSignalsTableCreateCompanionBuilder,
    $$ChildSignalsTableUpdateCompanionBuilder,
    (
      ChildSignal,
      BaseReferences<_$AppDatabase, $ChildSignalsTable, ChildSignal>
    ),
    ChildSignal,
    PrefetchHooks Function()> {
  $$ChildSignalsTableTableManager(_$AppDatabase db, $ChildSignalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChildSignalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChildSignalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChildSignalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> childId = const Value.absent(),
            Value<double> accuracy7d = const Value.absent(),
            Value<String> accuracyByTopic = const Value.absent(),
            Value<String> accuracyByType = const Value.absent(),
            Value<double> avgResponseSec = const Value.absent(),
            Value<String> weakTopics = const Value.absent(),
            Value<String> dueForReview = const Value.absent(),
            Value<int> daysSinceNewWords = const Value.absent(),
            Value<int> streakDays = const Value.absent(),
            Value<bool> streakAtRisk = const Value.absent(),
            Value<double> missionCompletion7d = const Value.absent(),
            Value<String> preferredMissionTypes = const Value.absent(),
            Value<int> preferredHour = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildSignalsCompanion(
            childId: childId,
            accuracy7d: accuracy7d,
            accuracyByTopic: accuracyByTopic,
            accuracyByType: accuracyByType,
            avgResponseSec: avgResponseSec,
            weakTopics: weakTopics,
            dueForReview: dueForReview,
            daysSinceNewWords: daysSinceNewWords,
            streakDays: streakDays,
            streakAtRisk: streakAtRisk,
            missionCompletion7d: missionCompletion7d,
            preferredMissionTypes: preferredMissionTypes,
            preferredHour: preferredHour,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String childId,
            Value<double> accuracy7d = const Value.absent(),
            Value<String> accuracyByTopic = const Value.absent(),
            Value<String> accuracyByType = const Value.absent(),
            Value<double> avgResponseSec = const Value.absent(),
            Value<String> weakTopics = const Value.absent(),
            Value<String> dueForReview = const Value.absent(),
            Value<int> daysSinceNewWords = const Value.absent(),
            Value<int> streakDays = const Value.absent(),
            Value<bool> streakAtRisk = const Value.absent(),
            Value<double> missionCompletion7d = const Value.absent(),
            Value<String> preferredMissionTypes = const Value.absent(),
            Value<int> preferredHour = const Value.absent(),
            required int updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildSignalsCompanion.insert(
            childId: childId,
            accuracy7d: accuracy7d,
            accuracyByTopic: accuracyByTopic,
            accuracyByType: accuracyByType,
            avgResponseSec: avgResponseSec,
            weakTopics: weakTopics,
            dueForReview: dueForReview,
            daysSinceNewWords: daysSinceNewWords,
            streakDays: streakDays,
            streakAtRisk: streakAtRisk,
            missionCompletion7d: missionCompletion7d,
            preferredMissionTypes: preferredMissionTypes,
            preferredHour: preferredHour,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChildSignalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChildSignalsTable,
    ChildSignal,
    $$ChildSignalsTableFilterComposer,
    $$ChildSignalsTableOrderingComposer,
    $$ChildSignalsTableAnnotationComposer,
    $$ChildSignalsTableCreateCompanionBuilder,
    $$ChildSignalsTableUpdateCompanionBuilder,
    (
      ChildSignal,
      BaseReferences<_$AppDatabase, $ChildSignalsTable, ChildSignal>
    ),
    ChildSignal,
    PrefetchHooks Function()>;
typedef $$XpEventsTableCreateCompanionBuilder = XpEventsCompanion Function({
  required String id,
  required String childId,
  required String sourceType,
  required String sourceId,
  required int xpAmount,
  Value<int> baseXp,
  Value<double> accuracyMultiplier,
  Value<double> streakMultiplier,
  Value<int> firstTryBonus,
  Value<String?> metadataJson,
  required int createdAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$XpEventsTableUpdateCompanionBuilder = XpEventsCompanion Function({
  Value<String> id,
  Value<String> childId,
  Value<String> sourceType,
  Value<String> sourceId,
  Value<int> xpAmount,
  Value<int> baseXp,
  Value<double> accuracyMultiplier,
  Value<double> streakMultiplier,
  Value<int> firstTryBonus,
  Value<String?> metadataJson,
  Value<int> createdAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$XpEventsTableFilterComposer
    extends Composer<_$AppDatabase, $XpEventsTable> {
  $$XpEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceId => $composableBuilder(
      column: $table.sourceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xpAmount => $composableBuilder(
      column: $table.xpAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get baseXp => $composableBuilder(
      column: $table.baseXp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get accuracyMultiplier => $composableBuilder(
      column: $table.accuracyMultiplier,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get streakMultiplier => $composableBuilder(
      column: $table.streakMultiplier,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get firstTryBonus => $composableBuilder(
      column: $table.firstTryBonus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metadataJson => $composableBuilder(
      column: $table.metadataJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$XpEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $XpEventsTable> {
  $$XpEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceId => $composableBuilder(
      column: $table.sourceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xpAmount => $composableBuilder(
      column: $table.xpAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get baseXp => $composableBuilder(
      column: $table.baseXp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get accuracyMultiplier => $composableBuilder(
      column: $table.accuracyMultiplier,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get streakMultiplier => $composableBuilder(
      column: $table.streakMultiplier,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get firstTryBonus => $composableBuilder(
      column: $table.firstTryBonus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadataJson => $composableBuilder(
      column: $table.metadataJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$XpEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $XpEventsTable> {
  $$XpEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<int> get xpAmount =>
      $composableBuilder(column: $table.xpAmount, builder: (column) => column);

  GeneratedColumn<int> get baseXp =>
      $composableBuilder(column: $table.baseXp, builder: (column) => column);

  GeneratedColumn<double> get accuracyMultiplier => $composableBuilder(
      column: $table.accuracyMultiplier, builder: (column) => column);

  GeneratedColumn<double> get streakMultiplier => $composableBuilder(
      column: $table.streakMultiplier, builder: (column) => column);

  GeneratedColumn<int> get firstTryBonus => $composableBuilder(
      column: $table.firstTryBonus, builder: (column) => column);

  GeneratedColumn<String> get metadataJson => $composableBuilder(
      column: $table.metadataJson, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$XpEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $XpEventsTable,
    XpEvent,
    $$XpEventsTableFilterComposer,
    $$XpEventsTableOrderingComposer,
    $$XpEventsTableAnnotationComposer,
    $$XpEventsTableCreateCompanionBuilder,
    $$XpEventsTableUpdateCompanionBuilder,
    (XpEvent, BaseReferences<_$AppDatabase, $XpEventsTable, XpEvent>),
    XpEvent,
    PrefetchHooks Function()> {
  $$XpEventsTableTableManager(_$AppDatabase db, $XpEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$XpEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$XpEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$XpEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> childId = const Value.absent(),
            Value<String> sourceType = const Value.absent(),
            Value<String> sourceId = const Value.absent(),
            Value<int> xpAmount = const Value.absent(),
            Value<int> baseXp = const Value.absent(),
            Value<double> accuracyMultiplier = const Value.absent(),
            Value<double> streakMultiplier = const Value.absent(),
            Value<int> firstTryBonus = const Value.absent(),
            Value<String?> metadataJson = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              XpEventsCompanion(
            id: id,
            childId: childId,
            sourceType: sourceType,
            sourceId: sourceId,
            xpAmount: xpAmount,
            baseXp: baseXp,
            accuracyMultiplier: accuracyMultiplier,
            streakMultiplier: streakMultiplier,
            firstTryBonus: firstTryBonus,
            metadataJson: metadataJson,
            createdAt: createdAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String childId,
            required String sourceType,
            required String sourceId,
            required int xpAmount,
            Value<int> baseXp = const Value.absent(),
            Value<double> accuracyMultiplier = const Value.absent(),
            Value<double> streakMultiplier = const Value.absent(),
            Value<int> firstTryBonus = const Value.absent(),
            Value<String?> metadataJson = const Value.absent(),
            required int createdAt,
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              XpEventsCompanion.insert(
            id: id,
            childId: childId,
            sourceType: sourceType,
            sourceId: sourceId,
            xpAmount: xpAmount,
            baseXp: baseXp,
            accuracyMultiplier: accuracyMultiplier,
            streakMultiplier: streakMultiplier,
            firstTryBonus: firstTryBonus,
            metadataJson: metadataJson,
            createdAt: createdAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$XpEventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $XpEventsTable,
    XpEvent,
    $$XpEventsTableFilterComposer,
    $$XpEventsTableOrderingComposer,
    $$XpEventsTableAnnotationComposer,
    $$XpEventsTableCreateCompanionBuilder,
    $$XpEventsTableUpdateCompanionBuilder,
    (XpEvent, BaseReferences<_$AppDatabase, $XpEventsTable, XpEvent>),
    XpEvent,
    PrefetchHooks Function()>;
typedef $$TitlesTableCreateCompanionBuilder = TitlesCompanion Function({
  required String id,
  required String code,
  required String name,
  required String type,
  Value<int?> tier,
  Value<String?> imageUrl,
  Value<String?> animation,
  Value<String?> colorHex,
  Value<String?> description,
  Value<String?> flavorText,
  required String unlockConditionJson,
  Value<int> priority,
  Value<bool> isActive,
  required int createdAt,
  required int updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$TitlesTableUpdateCompanionBuilder = TitlesCompanion Function({
  Value<String> id,
  Value<String> code,
  Value<String> name,
  Value<String> type,
  Value<int?> tier,
  Value<String?> imageUrl,
  Value<String?> animation,
  Value<String?> colorHex,
  Value<String?> description,
  Value<String?> flavorText,
  Value<String> unlockConditionJson,
  Value<int> priority,
  Value<bool> isActive,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$TitlesTableFilterComposer
    extends Composer<_$AppDatabase, $TitlesTable> {
  $$TitlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tier => $composableBuilder(
      column: $table.tier, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get animation => $composableBuilder(
      column: $table.animation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get flavorText => $composableBuilder(
      column: $table.flavorText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unlockConditionJson => $composableBuilder(
      column: $table.unlockConditionJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$TitlesTableOrderingComposer
    extends Composer<_$AppDatabase, $TitlesTable> {
  $$TitlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tier => $composableBuilder(
      column: $table.tier, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get animation => $composableBuilder(
      column: $table.animation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get flavorText => $composableBuilder(
      column: $table.flavorText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unlockConditionJson => $composableBuilder(
      column: $table.unlockConditionJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$TitlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TitlesTable> {
  $$TitlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get animation =>
      $composableBuilder(column: $table.animation, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get flavorText => $composableBuilder(
      column: $table.flavorText, builder: (column) => column);

  GeneratedColumn<String> get unlockConditionJson => $composableBuilder(
      column: $table.unlockConditionJson, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$TitlesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TitlesTable,
    Title,
    $$TitlesTableFilterComposer,
    $$TitlesTableOrderingComposer,
    $$TitlesTableAnnotationComposer,
    $$TitlesTableCreateCompanionBuilder,
    $$TitlesTableUpdateCompanionBuilder,
    (Title, BaseReferences<_$AppDatabase, $TitlesTable, Title>),
    Title,
    PrefetchHooks Function()> {
  $$TitlesTableTableManager(_$AppDatabase db, $TitlesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TitlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TitlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TitlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int?> tier = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> animation = const Value.absent(),
            Value<String?> colorHex = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> flavorText = const Value.absent(),
            Value<String> unlockConditionJson = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TitlesCompanion(
            id: id,
            code: code,
            name: name,
            type: type,
            tier: tier,
            imageUrl: imageUrl,
            animation: animation,
            colorHex: colorHex,
            description: description,
            flavorText: flavorText,
            unlockConditionJson: unlockConditionJson,
            priority: priority,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String code,
            required String name,
            required String type,
            Value<int?> tier = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> animation = const Value.absent(),
            Value<String?> colorHex = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> flavorText = const Value.absent(),
            required String unlockConditionJson,
            Value<int> priority = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            required int createdAt,
            required int updatedAt,
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TitlesCompanion.insert(
            id: id,
            code: code,
            name: name,
            type: type,
            tier: tier,
            imageUrl: imageUrl,
            animation: animation,
            colorHex: colorHex,
            description: description,
            flavorText: flavorText,
            unlockConditionJson: unlockConditionJson,
            priority: priority,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TitlesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TitlesTable,
    Title,
    $$TitlesTableFilterComposer,
    $$TitlesTableOrderingComposer,
    $$TitlesTableAnnotationComposer,
    $$TitlesTableCreateCompanionBuilder,
    $$TitlesTableUpdateCompanionBuilder,
    (Title, BaseReferences<_$AppDatabase, $TitlesTable, Title>),
    Title,
    PrefetchHooks Function()>;
typedef $$ChildTitlesTableCreateCompanionBuilder = ChildTitlesCompanion
    Function({
  required String id,
  required String childId,
  required String titleId,
  required String titleType,
  required int unlockedAt,
  Value<bool> isEquipped,
  Value<int?> equippedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$ChildTitlesTableUpdateCompanionBuilder = ChildTitlesCompanion
    Function({
  Value<String> id,
  Value<String> childId,
  Value<String> titleId,
  Value<String> titleType,
  Value<int> unlockedAt,
  Value<bool> isEquipped,
  Value<int?> equippedAt,
  Value<String?> remoteId,
  Value<String> syncStatus,
  Value<int?> lastSyncedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$ChildTitlesTableFilterComposer
    extends Composer<_$AppDatabase, $ChildTitlesTable> {
  $$ChildTitlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titleId => $composableBuilder(
      column: $table.titleId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titleType => $composableBuilder(
      column: $table.titleType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unlockedAt => $composableBuilder(
      column: $table.unlockedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEquipped => $composableBuilder(
      column: $table.isEquipped, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get equippedAt => $composableBuilder(
      column: $table.equippedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$ChildTitlesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChildTitlesTable> {
  $$ChildTitlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get childId => $composableBuilder(
      column: $table.childId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titleId => $composableBuilder(
      column: $table.titleId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titleType => $composableBuilder(
      column: $table.titleType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unlockedAt => $composableBuilder(
      column: $table.unlockedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEquipped => $composableBuilder(
      column: $table.isEquipped, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get equippedAt => $composableBuilder(
      column: $table.equippedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$ChildTitlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChildTitlesTable> {
  $$ChildTitlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get titleId =>
      $composableBuilder(column: $table.titleId, builder: (column) => column);

  GeneratedColumn<String> get titleType =>
      $composableBuilder(column: $table.titleType, builder: (column) => column);

  GeneratedColumn<int> get unlockedAt => $composableBuilder(
      column: $table.unlockedAt, builder: (column) => column);

  GeneratedColumn<bool> get isEquipped => $composableBuilder(
      column: $table.isEquipped, builder: (column) => column);

  GeneratedColumn<int> get equippedAt => $composableBuilder(
      column: $table.equippedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$ChildTitlesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChildTitlesTable,
    ChildTitle,
    $$ChildTitlesTableFilterComposer,
    $$ChildTitlesTableOrderingComposer,
    $$ChildTitlesTableAnnotationComposer,
    $$ChildTitlesTableCreateCompanionBuilder,
    $$ChildTitlesTableUpdateCompanionBuilder,
    (ChildTitle, BaseReferences<_$AppDatabase, $ChildTitlesTable, ChildTitle>),
    ChildTitle,
    PrefetchHooks Function()> {
  $$ChildTitlesTableTableManager(_$AppDatabase db, $ChildTitlesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChildTitlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChildTitlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChildTitlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> childId = const Value.absent(),
            Value<String> titleId = const Value.absent(),
            Value<String> titleType = const Value.absent(),
            Value<int> unlockedAt = const Value.absent(),
            Value<bool> isEquipped = const Value.absent(),
            Value<int?> equippedAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildTitlesCompanion(
            id: id,
            childId: childId,
            titleId: titleId,
            titleType: titleType,
            unlockedAt: unlockedAt,
            isEquipped: isEquipped,
            equippedAt: equippedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String childId,
            required String titleId,
            required String titleType,
            required int unlockedAt,
            Value<bool> isEquipped = const Value.absent(),
            Value<int?> equippedAt = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int?> lastSyncedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChildTitlesCompanion.insert(
            id: id,
            childId: childId,
            titleId: titleId,
            titleType: titleType,
            unlockedAt: unlockedAt,
            isEquipped: isEquipped,
            equippedAt: equippedAt,
            remoteId: remoteId,
            syncStatus: syncStatus,
            lastSyncedAt: lastSyncedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChildTitlesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChildTitlesTable,
    ChildTitle,
    $$ChildTitlesTableFilterComposer,
    $$ChildTitlesTableOrderingComposer,
    $$ChildTitlesTableAnnotationComposer,
    $$ChildTitlesTableCreateCompanionBuilder,
    $$ChildTitlesTableUpdateCompanionBuilder,
    (ChildTitle, BaseReferences<_$AppDatabase, $ChildTitlesTable, ChildTitle>),
    ChildTitle,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ChildProfilesTableTableManager get childProfiles =>
      $$ChildProfilesTableTableManager(_db, _db.childProfiles);
  $$SyncVersionsTableTableManager get syncVersions =>
      $$SyncVersionsTableTableManager(_db, _db.syncVersions);
  $$LearningPathsTableTableManager get learningPaths =>
      $$LearningPathsTableTableManager(_db, _db.learningPaths);
  $$TopicsTableTableManager get topics =>
      $$TopicsTableTableManager(_db, _db.topics);
  $$PathTopicsTableTableManager get pathTopics =>
      $$PathTopicsTableTableManager(_db, _db.pathTopics);
  $$ChildLearningPathsTableTableManager get childLearningPaths =>
      $$ChildLearningPathsTableTableManager(_db, _db.childLearningPaths);
  $$PlacementSessionsTableTableManager get placementSessions =>
      $$PlacementSessionsTableTableManager(_db, _db.placementSessions);
  $$LessonsTableTableManager get lessons =>
      $$LessonsTableTableManager(_db, _db.lessons);
  $$QuizQuestionsTableTableManager get quizQuestions =>
      $$QuizQuestionsTableTableManager(_db, _db.quizQuestions);
  $$VocabularyItemsTableTableManager get vocabularyItems =>
      $$VocabularyItemsTableTableManager(_db, _db.vocabularyItems);
  $$LessonProgressEntriesTableTableManager get lessonProgressEntries =>
      $$LessonProgressEntriesTableTableManager(_db, _db.lessonProgressEntries);
  $$QuizAttemptsTableTableManager get quizAttempts =>
      $$QuizAttemptsTableTableManager(_db, _db.quizAttempts);
  $$MissionTemplatesTableTableManager get missionTemplates =>
      $$MissionTemplatesTableTableManager(_db, _db.missionTemplates);
  $$DailyMissionsTableTableManager get dailyMissions =>
      $$DailyMissionsTableTableManager(_db, _db.dailyMissions);
  $$SkillTargetsTableTableManager get skillTargets =>
      $$SkillTargetsTableTableManager(_db, _db.skillTargets);
  $$SkillProgressEntriesTableTableManager get skillProgressEntries =>
      $$SkillProgressEntriesTableTableManager(_db, _db.skillProgressEntries);
  $$LevelDefinitionsTableTableManager get levelDefinitions =>
      $$LevelDefinitionsTableTableManager(_db, _db.levelDefinitions);
  $$WordMasteryEntriesTableTableManager get wordMasteryEntries =>
      $$WordMasteryEntriesTableTableManager(_db, _db.wordMasteryEntries);
  $$ChildProgressEntriesTableTableManager get childProgressEntries =>
      $$ChildProgressEntriesTableTableManager(_db, _db.childProgressEntries);
  $$ChildSignalsTableTableManager get childSignals =>
      $$ChildSignalsTableTableManager(_db, _db.childSignals);
  $$XpEventsTableTableManager get xpEvents =>
      $$XpEventsTableTableManager(_db, _db.xpEvents);
  $$TitlesTableTableManager get titles =>
      $$TitlesTableTableManager(_db, _db.titles);
  $$ChildTitlesTableTableManager get childTitles =>
      $$ChildTitlesTableTableManager(_db, _db.childTitles);
}
