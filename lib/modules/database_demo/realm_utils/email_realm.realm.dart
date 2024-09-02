// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_realm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class EmailRealm extends _EmailRealm
    with RealmEntity, RealmObjectBase, RealmObject {
  EmailRealm(
    String email,
  ) {
    RealmObjectBase.set(this, 'email', email);
  }

  EmailRealm._();

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  Stream<RealmObjectChanges<EmailRealm>> get changes =>
      RealmObjectBase.getChanges<EmailRealm>(this);

  @override
  Stream<RealmObjectChanges<EmailRealm>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<EmailRealm>(this, keyPaths);

  @override
  EmailRealm freeze() => RealmObjectBase.freezeObject<EmailRealm>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'email': email.toEJson(),
    };
  }

  static EJsonValue _toEJson(EmailRealm value) => value.toEJson();
  static EmailRealm _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'email': EJsonValue email,
      } =>
        EmailRealm(
          fromEJson(email),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(EmailRealm._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, EmailRealm, 'EmailRealm', [
      SchemaProperty('email', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
