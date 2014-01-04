library thermodynamic_model_ui_controller;
import 'dart:core';
import 'package:angular/angular.dart' as ng;

class Reaction {
  // TODO: _id

  Reaction(String s) {

  }
}

class Parameter {
  static int nextId = 0; // TODO: factor this out
  static int getId() {
    return nextId++;
  }

  int _id;
  String _name;
  String _unit;
  String _description;

  Parameter(this._name, this._unit, this._description);
}

class Constant {
  static int nextId = 0;
  static int getId() {
    return nextId++;
  }

  int _id;
  String _name;
  num _value;
  String _description = "";

  get id => _id;
  get name => _name;
  get value => _value;
  get description => _description;

  // TODO: figure out what to do with the unit
  Constant(this._name, String value, String unit, String description){
    this._id = getId();
    this._value = double.parse(value, (s){throw new ArgumentError(s);});
    this._description = description;
  }
}

class Species {
  static int nextId = 0;
  static int getId() {
    return nextId++;
  }

  int _id;
  String _name;
  String _description;

  get id => _id;
  get name => _name;
  get description => _description;

  Species(this._name, this._description) {
    this._id = getId();
  }
}

@ng.NgController(
    selector: '[thermodynamic-model-ul]',
    publishAs: 'ctrl')
class ThermodynamicModelUIController {

  static const String LOADING_MESSAGE = "Loading thermodynamic model...";
  static const String ERROR_MESSAGE = """Sorry! Boltzman hang himself and took the constant with him.
Thermodynamic model is now unavailable!""";

//  Http _http;
//  QueryService _queryService;
//  QueryService get queryService => _queryService;

  // Determine the initial load state of the app
  String message = LOADING_MESSAGE;
  bool recipesLoaded = false;
  bool categoriesLoaded = false;

  List<Constant> _constants;
  get constants => _constants;

  List<Species> _species;
  List<Species> get species => _species;

  List _reactions = [];
  get reactions => _reactions;

  List _ratelaws = [];
  get ratelaws => _ratelaws;

  List _parameters = [];
  get parameters => _parameters;

  Constant selectedConstant;

  void selectConstant(Constant constant) {
    selectedConstant = constant;
  }

  ThermodynamicModelUIController() {
    _reactions = [
      // yPrime[M_B] = psi_tau_B - (mu + xi_M) * vars[M_B];
      new Reaction(" -> M_B"),
      new Reaction("M_B -> "), // mu
      new Reaction("M_B -> "), // xi_M
      //yPrime[M_P] = psi_tau_P - (mu + xi_M) * vars[M_P];
      new Reaction(" -> M_P"),
      new Reaction("M_P -> "), // mu
      new Reaction("M_P -> "), // xi_M
      //yPrime[B] = 1.0 / 4 * k_B * vars[M_B] * T_B - (mu + xi_B) * vars[B];
      new Reaction(" -> B"),
      new Reaction("B -> "),
      new Reaction("B -> "),
      //yPrime[P] = k_P * vars[M_P] * T_P - (mu + xi_P) * vars[P];
      new Reaction(""),
      //yPrime[cAMP_T] = v_cAMP - xi_cAMP * cAMP - mu * vars[cAMP_T];
      new Reaction(""),
      //yPrime[A_T] = (vL1 - vL2) / 2 - (xi_A + mu) * vars[A_T];
      new Reaction(""),
    ];
    _parameters = [
      new Parameter("M_B", "", "Initial concentration of "),
      new Parameter("M_P", "", "Initial concentration of "),
      new Parameter("B", "", "Initial concentration of \$\\beta\$gallactose"),
      new Parameter("P", "", "Initial concentration of "),
      //new Parameter("", "", ""),
      new Parameter("A\$_T\$", "", "Initial total concentration of allolactose"),
      new Parameter("cAMP", "", "Initial concentration of cAMP"),
      new Parameter("\$G_E\$", "", "Extracellular glucose concentration"),
      new Parameter("\$L_E\$", "", "Lactose concentration in the external medium")
    ];
    _species = [
      new Species("\$\\rm{M_B}\$", "\$\\beta\$-galactosidase mRNA"),
      new Species("\$\\rm{M_P}\$", "Lac permease mRNA"),
      new Species("B", "\$\\beta\$-galactosidase protein"),
      new Species("P", "Lac permease protein"),
      new Species("\$\\rm{cAMP_T}\$", "Total cAMP"),
      new Species("\$\\rm{A_T}\$", "Allolactose"),
    ];
    _constants = [
      new Constant("\$\\mu\$", "0.02", "min\$^{-1}\$", "growth rate"),
      new Constant("[mRNAP]", "3.0", "\$\\mu M\$", "mRNA polymerase concentration"),
      new Constant("[P1]", "5.0e-3 ", "\$\\mu M\$", "Promoter concentration"),
      new Constant("[CRP]", "2.6", "\$\\mu M\$", "CRP concentration"),
      new Constant("\$[\\rm{R_T}]\$", "2.9e-2", "\$\\mu M\$", "Total repressor concentration"),
      new Constant("\$k_m\$", "0.18", "min\$^-1\$", "Transcription initiation rate"),
      new Constant("\$\\xi_M\$", "0.46", "min\$^-1\$", "mRNA degradation rate"),
      new Constant("\$K_{\\rm CAP}\$", "3.0", "\$\\mu M\$", "Equilibrium dissociation constant between CRP and cAMP"),
      new Constant("\$\\tau_B\$", "5.1e-3", "min", "Time delay between transcription initiation and appearance of a lacZ ribosome binding site"),
      new Constant("\$\\tau_P\$", "0.1", "min", "Time delay between transcription initiation and appearance of a lacY ribosome binding site"),
      new Constant("\$\\xi_P\$", "0.01", "min\$^{-1}\$", "lac permease degradation rate"),
      new Constant("\$k_P\$", "18.8", "min\$^{-1}\$", "lacY mRNA translation initiation rate"),

      //new Constant("", "", "", ""),
      //new Constant("", "", "", ""),
      //new Constant("", "", "", ""),
      //new Constant("", "", "", ""),
      //new Constant("", "", "", ""),

      new Constant("\$\\phi_{L_1}\$", "1.08e3", "min\$^-1\$", "Lactose hydrolisis rate"),
      new Constant("\$\\Phi_{L_1}\$", "5.0e-2", "\$\\mu M\$", "Lactose saturation constant"),
      new Constant("\$\\Phi_{G_2}\$", "2.71e2", "\$\\mu M\$", "Lactose transport constant for inhibition by glucose"),
      new Constant("\$\\xi_P\$", "0.0", "min\$^{-1}\$", "Allolactose degradation rate constant"),
      new Constant("\$\\phi_{cAMP}\$", "5.5", "\$\\mu M\$min\$^-1\$", "cAMP synthesis rate constant"),
      new Constant("\$\\Phi_{cAMP}\$", "40.0", "\$\\mu M\$", "cAMP synthesis saturation constant"),
      new Constant("\$\\xi_{cAMP}\$", "2.1", "min\$^{-1}\$", "cAMP excretion and degradation rate"),
      new Constant("\$K_A\$", "1.0", "\$\\mu M\$", "Repressor-allolactose dissociation constant"),
    ];

    //TODO: rewrite all this to the form above
//    /**
//     * β-galactosidase degradation rate
//     */
//    double xi_B = 8.33e-4; // min^{-1}
//
//    /**
//     * lacZ mRNA translation initiation rate
//     */
//    double k_B = 18.8; // min^{-1}
//
//    /**
//     * Time delay due to translation of gene lacY
//     */
//    double T_P = 0.42; // min
//
//    /**
//     * Time delay due to translation of gene lacZ
//     */
//    double T_B = 1.0; // min
//
//    /**
//     * Repressor-allocatose dissociation constant
//     */
//    double K_A = 1.0; // uM
//
//    /**
//     * lactose transport constant for inhibition by glucose
//     */
//    double PhiG1 = 2.71e2; // FIXME: I am putting here the value of PhiG2 since PhiG1 is not in the article.
//
//    /**
//     * Lactose transport constant for inhibition by glucose
//     */
//    double PhiG2 = 2.71e2; // uM
//
//    /**
//     * Lactose transport rate constant
//     */
//    double psiL1 = 1.08e3; // min^{-1}
//
//    /**
//     * Lactose transport saturation constant
//     */
//    double PhiL1 = 5.0e-2; // uM
//
//    /**
//     * Lactose hydrolysis rate
//     */
//    double phiL2 = 3.60e3; // min^{-1}
//    /**
//     * Lactose hydrolysis saturation constant
//     */
//    double PhiL2 = 1.4e3; // uM;
//
//    /**
//     * cAMP synthesis rate constant
//     */
//    double phicAMP = 5.5; // uM min^{-1}
//    //TODO: rewrite this to the form above
//    /**
//     * cAMP synthesis saturation constant
//     */
//    double PhicAMP = 40.0; // uM
//
//    /**
//     * Allolactose degradation rate constant
//     */
//    double xi_A = 0.0; // min^{-1}
//
//    /**
//     * Promoter concentration
//     */
//    double P1 = 5.0e-3; // uM
//
//    /**
//     * Transcription initiation rate
//     */
//    double k_m = 0.18;
//
//    double mRNAP = 3.0; // uM
//
//    // we have a big bottle, therefore these concentrations
//    // practically do not change
//

//  }

//  Map<String, Recipe> _recipeMap = {};
//  get recipeMap => _recipeMap;
//  get allRecipes => _recipeMap.values.toList();
  }
  // Filter box
  //Map<String, bool> categoryFilterMap = {};
  //String nameFilter = "";

//  RecipeBookController(Http this._http, QueryService this._queryService) {
//    _loadData();
//  }

  // Tooltip
//  static final tooltip = new Expando<TooltipModel>();
//  TooltipModel tooltipForRecipe(Recipe recipe) {
//    if (tooltip[recipe] == null) {
//      tooltip[recipe] = new TooltipModel(recipe.imgUrl,
//          "I don't have a picture of these recipes, "
//          "so here's one of my cat instead!",
//          80);
//    }
//    return tooltip[recipe]; // recipe.tooltip
//  }

//  void _loadData() {
//    _queryService.getAllRecipes()
//      .then((Map<String, Recipe> allRecipes) {
//        _recipeMap = allRecipes;
//        recipesLoaded = true;
//      },
//      onError: (Object obj) {
//        recipesLoaded = false;
//        message = ERROR_MESSAGE;
//      });
//
//    _queryService.getAllCategories()
//      .then((List<String> allCategories) {
//        _categories = allCategories;
//        for (String category in _categories) {
//          categoryFilterMap[category] = false;
//        }
//        categoriesLoaded = true;
//      },
//      onError: (Object obj) {
//        categoriesLoaded = false;
//        message = ERROR_MESSAGE;
//      });
//  }
}