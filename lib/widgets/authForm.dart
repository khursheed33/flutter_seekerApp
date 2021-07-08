import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function loginWithEmailPassword;
  final Function loginWithGoogle;
  AuthForm(this.loginWithEmailPassword, this.loginWithGoogle);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final decorationImage =
      'https://i.pinimg.com/originals/4a/a8/7f/4aa87fb76e0355db7654985cde9677e8.jpg';
  // final decorationImage =
  //     'https://image.freepik.com/free-vector/abstract-blue-pixel-background_1035-9903.jpg';
  final googleIcon =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png';
  bool _isSignIn = false;
  bool _isFocused = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      // Sign In or Sign Up
      _formKey.currentState.save();

      widget.loginWithEmailPassword(
        isSignIn: _isSignIn,
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
      );
    } else {
      // return error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          image: DecorationImage(
              image: NetworkImage(decorationImage), fit: BoxFit.cover),
        ),
        child: Center(
          child: Card(
            elevation: 5,
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        _isSignIn ? "Welcome Back!" : "Sign Up",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                    Divider(),
                    TextFormField(
                      key: ValueKey("email"),
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                      ),
                      validator: (String _email) {
                        if (_email.isEmpty) {
                          return "Email Address cannot be enpty!";
                        }
                        if (!_email.contains("@")) {
                          return "Please enter a Valid Email ID";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      key: ValueKey("password"),
                      controller: _passwordController,
                      obscureText: !_isFocused,
                      decoration: InputDecoration(
                        labelText: _isSignIn ? "Password" : "New Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isFocused
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: _isFocused
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isFocused = !_isFocused;
                            });
                            print("Make it Visible");
                          },
                        ),
                      ),
                      validator: (String _password) {
                        if (_password.isEmpty) {
                          return "Password cannot be enpty!";
                        }

                        if (_password.length < 6) {
                          return "Too weak Password, atleast 6+ chars required!";
                        }
                        return null;
                      },
                    ),
                    if (!_isSignIn)
                      SizedBox(
                        height: 10,
                      ),
                    if (!_isSignIn)
                      TextFormField(
                        key: ValueKey('confirmPassword'),
                        controller: _confirmPassController,
                        obscureText: !_isFocused,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                        ),
                        validator: (String _pass) {
                          if (_pass.isEmpty) {
                            return "This field cannot be emptry!";
                          }
                          if (_pass != _passwordController.text) {
                            return "Password must be same!";
                          }
                          return null;
                        },
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        ),
                      ),
                      onPressed: () {
                        print(
                            "${_passwordController.text} == ${_confirmPassController.text}");
                        _saveForm();
                      },
                      child: Text(_isSignIn ? "Sign In" : "Sign Up"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Switch between Sign In and Sign Up
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_isSignIn
                              ? "Don't have an Account?"
                              : "Already have an account?"),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isSignIn = !_isSignIn;
                              });
                            },
                            child: Text(
                              _isSignIn ? "Register Here." : "Sign In.",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // Google Sign Up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // margin: const EdgeInsets.only(right: 10),
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 1,
                          color: Colors.grey[400],
                        ),
                        Text(
                          "OR",
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                        Container(
                          // margin: const EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 1,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Google Signin Icon

                    GestureDetector(
                      onTap: () async {
                        widget.loginWithGoogle(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.deepOrange,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Image.network(
                                googleIcon,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              alignment: Alignment.center,
                              child: Text(
                                "Sign In with Google",
                                style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
