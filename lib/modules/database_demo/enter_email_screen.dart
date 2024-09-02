import 'package:assessment/modules/database_demo/realm_utils/email_realm.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realm/realm.dart';

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({super.key});

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  void readLastEnteredEmailFromDB() {
    // This will fetch last entered email from Database and show toast,
    // In case there is no entry in database then toast message will not show up
    LocalConfiguration config = Configuration.local([EmailRealm.schema]);
    Realm realm = Realm(config);

    RealmResults<EmailRealm> results = realm.all<EmailRealm>();
    if (results.isNotEmpty) {
      EmailRealm emailInfo = results.last;
      String enteredEmail = emailInfo.email;
      Fluttertoast.showToast(msg: "EMAIL : $enteredEmail");
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      readLastEnteredEmailFromDB();
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  bool checkEmailAlreadyExists({required String enteredEmail}) {
    // Returns true is email is already added in database
    LocalConfiguration config = Configuration.local([EmailRealm.schema]);
    Realm realm = Realm(config);

    RealmResults<EmailRealm> results =
        realm.query(r"email == $0", [enteredEmail]);

    return results.isNotEmpty;
  }

  void onSaveEmailClick() {
    bool isFormValid = _formKey.currentState?.validate() ?? false;

    if (!isFormValid) {
      return;
    }

    FocusScope.of(context).unfocus();

    String enteredEmail = emailController.text.toString().toLowerCase();
    bool isEmailAlreadyExists =
        checkEmailAlreadyExists(enteredEmail: enteredEmail);

    if (isEmailAlreadyExists) {
      Fluttertoast.showToast(msg: "Email Already Exists in Database");
      return;
    }

    LocalConfiguration config = Configuration.local([EmailRealm.schema]);
    Realm realm = Realm(config);

    EmailRealm emailRealm = EmailRealm(enteredEmail);

    realm.write((){
        realm.add(emailRealm);
    });

    Fluttertoast.showToast(msg: "Email Added To Database");
    emailController.clear();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Database Demo"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Enter Your Email",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xff737373),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    counterText: "",
                    prefixIcon: Icon(Icons.email),
                  ),
                  maxLength: 20,
                  validator: (value) {
                    String emailPattern =
                        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
                    RegExp emailRegex = RegExp(emailPattern);
                    String? errorMessage = (value?.isEmpty ?? true)
                        ? "Email Required"
                        : !emailRegex.hasMatch(value ?? "")
                            ? "Invalid email"
                            : null;
                    return errorMessage;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onSaveEmailClick,
          child: const Text("Save Email"),
        ),
      ),
    );
  }
}
