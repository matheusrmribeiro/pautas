import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/pages/guideline_cadastre/guideline_cadastre_page.dart';
import 'package:pautas/src/app/pages/guideline_cadastre/widgets/step_tasks.dart';
import 'package:pautas/src/app/pages/guidelines/guidelines_detail_page.dart';
import 'package:pautas/src/app/pages/guidelines/widgets/tasks_widget.dart';
import 'package:pautas/src/app/pages/profile/profile_page.dart';
import 'package:pautas/src/app/pages/root/root_page.dart';
import 'src/app/controllers/auth_controller.dart';
import 'src/app/controllers/root_controller.dart';
import 'src/app/pages/login/login_controller.dart';
import 'src/app/pages/login/login_page.dart';
import 'src/app/pages/splash/splash_page.dart';
import 'src/app/pages/user_cadastre/user_cadastre_page.dart';
import 'src/data/repositories/auth_repository.dart';
import 'src/domain/entities/user_entity.dart';
import 'src/domain/interfaces/auth_repository_interface.dart';

class AppModule extends Module{

  @override
  List<Bind> get binds => [
    Bind((i) => AuthController()),
    Bind((i) => LoginController()),
    Bind((i) => RootController()),

    Bind<IAuthRepository>((i) => AuthRepository()),
    Bind<UserEntity>((i) => UserEntity()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute("/", child: (_, args) => SplashPage()),
    ChildRoute("/login", child: (_, args) => LoginPage(),),
    ChildRoute("/user/cadastre", child: (_, args) => UserCadastrePage(),),
    ChildRoute("/root", child: (_, args) => RootPage(),),
    ChildRoute("/profile", child: (_, args) => ProfilePage(),),
    ChildRoute("/guideline/cadastre", child: (_, args) => 
      GuidelineCadastrePage(),
    ),
    ChildRoute("/guideline/cadastre/edit", child: (_, args) => 
      GuidelineCadastrePage(index: args.data[0], guideline: args.data[1],),
    ),
    ChildRoute("/guideline/detail", 
      child: (_, args) => GuidelineDetailPage(controller: args.data[0], guideline: args.data[1])
    ),
  ];

}