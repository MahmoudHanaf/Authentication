import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modules/shop_app/logIn/cubit/cubit.dart';
import 'package:flutter_app/modules/shop_app/logIn/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Shared/components/components.dart';
import '../regiser/Register.dart';

class ShopLogIn extends StatelessWidget {
  const ShopLogIn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    var  emailControler =TextEditingController();
    var passwordControler =TextEditingController();
    var formKey =GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => ShopLoginCubit(),

        child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
          listener: (context, state) {} ,
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LogIn",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Login now to brows our hot offres",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller:emailControler ,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value){},
                          validator:(value){
                            if(value!.isEmpty){
                              // print("Plese Enter your email");
                              return "Plese Enter your email";

                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Email' ,
                            prefixIcon:Icon(
                                Icons.email_outlined
                            ) ,

                            border: OutlineInputBorder(),

                          ),
                        ),
                        SizedBox(
                          height:25,
                        ),

                        TextFormField(
                          controller:passwordControler ,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black
                          ),
                         keyboardType: TextInputType.visiblePassword,
                         onChanged: (value){},
                          obscureText: !ShopLoginCubit.get(context).isPassword,
                          validator:(value){
                            if(value!.isEmpty){
                              // print("Plese Enter your Password");
                              return "Plese Enter your Password";

                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Password' ,
                            prefixIcon:Icon(
                                Icons.lock_outline
                            ) ,

                            suffixIcon:
                            MaterialButton(
                              onPressed: (){
                                ShopLoginCubit.get(context).changePasswordVisibility();
                              },
                              child: Icon(
                                  ShopLoginCubit.get(context).suffix,
                              ),
                            ) ,
                            border: OutlineInputBorder(),


                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        BuildCondition(
                          condition: true ,
                          builder: (context)=>  Container(
                            width: double.infinity,
                            color:Colors.deepOrange,
                            child: MaterialButton(onPressed: (){

                              if(formKey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailControler.text,
                                    password: passwordControler.text
                                );

                              }

                            },
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),

                          fallback: (context)=> Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                navigateTo(context,RegisterScreen());
                              },
                              child: Text(
                                "Register Now",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            );
          },

        ),
      );
  }
}
