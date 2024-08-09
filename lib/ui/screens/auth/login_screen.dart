import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/auth/login/login_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/user/user_data/user_data_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/ui/widgets/widgets.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';
import 'package:test_flutter_developer_enterkomputer/utils/extensions.dart';
import 'package:test_flutter_developer_enterkomputer/utils/textstyles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.isFromRoot});

  final bool isFromRoot;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late LoginCubit _loginCubit;

  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  bool isSubmitLoading = false;

  @override
  void initState() {
    _loginCubit = LoginCubit();
    super.initState();
  }

  String? validationRequired(String? value) {
    if (value!.isEmpty) {
      return "Wajib diisi";
    }
    return null;
  }

  void handleSubmit() {
    hideKeyboard(context);
    setState(() => isSubmitLoading = true);
    if (_formKey.currentState!.validate()) {
      _loginCubit.login(
          username: usernameCtrl.text, password: passwordCtrl.text);
    } else {
      setState(() => isSubmitLoading = false);
    }
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    _loginCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => _loginCubit,
      child: BlocListener(
        bloc: _loginCubit,
        listener: (context, state) {
          if (state is LoginSuccess) {
             BlocProvider.of<UserDataCubit>(context).loadUser();
            setState(() {
              isSubmitLoading = false;
            });
            if (widget.isFromRoot) {
              BlocProvider.of<BottomNavCubit>(context).navItemTapped(0);
             
            }else{
              popScreen(context);
            }
             showSnackbar(context,message: "Success Login",colors: success);
          }
          if (state is LoginFailure) {
             setState(() {
              isSubmitLoading = false;
            });
            showSnackbar(context,message: state.message,colors: danger);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _screenWidth * (5 / 100), vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login MovieDB App",
                        style: latoBold.copyWith(fontSize: 30),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Come on, enter the MovieDB App application and get various interesting features in the application",
                        style: latoRegular.copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Username TMDB",
                            style: latoBold.copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          EditTextInput(
                            hintText: "Input username",
                            validator: validationRequired,
                            controller: usernameCtrl,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Password",
                            style: latoBold.copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          EditTextInput(
                            hintText: "Input password",
                            inputType: InputType.password,
                            validator: validationRequired,
                            controller: passwordCtrl,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton.contained(
                              isLoading: isSubmitLoading,
                              label: "Login",
                              isUpperCase: false,
                              onPressed: handleSubmit),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                toWebUrl(context, "https://www.themoviedb.org/signup");
                              },
                              child: RichText(
                                  text: TextSpan(
                                      style: latoRegular.copyWith(
                                          color: Colors.black),
                                      children: [
                                    TextSpan(
                                      text: "Havent got an account ?",
                                    ),
                                    TextSpan(
                                        text: " Sign Up",
                                        style: latoRegular.copyWith(
                                            color: primary))
                                  ])),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
