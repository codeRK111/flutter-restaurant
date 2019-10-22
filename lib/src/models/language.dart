class Language {
  String englishName;
  String localName;
  String flag;
  bool selected;

  Language(this.englishName, this.localName, this.flag, {this.selected = false});
}

class LanguagesList {
  List<Language> _languages;

  LanguagesList() {
    this._languages = [
      new Language("English", "English", "assets/img/united-states-of-america.png", selected: true),
      new Language("Arabic", "العربية", "assets/img/united-arab-emirates.png"),
      new Language("Spanish", "Spana", "assets/img/spain.png"),
      new Language("French (France)", "Français - France", "assets/img/france.png"),
      new Language("French (Canada)", "Français - Canadien", "assets/img/canada.png"),
      new Language("Brazilian", "Brazilian", "assets/img/brazil.png"),
      new Language("Deutsh", "Deutsh", "assets/img/germany.png"),
      new Language("Chineeze", "Chineeze", "assets/img/china.png"),
      new Language("Italian", "Italiano", "assets/img/italy.png"),
      new Language("Netherlands", "Netherlands", "assets/img/netherlands.png"),
    ];
  }

  List<Language> get languages => _languages;
}
