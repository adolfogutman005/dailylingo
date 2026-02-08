final Map<String, String> _langCodes = {
  "english": "EN",
  "spanish": "ES",
  "french": "FR",
  "german": "DE",
  "portuguese": "PT",
  "italian": "IT",
  "chinese": "ZH",
  "japanese": "JA",
  "korean": "KO",
  "arabic": "AR",
};

String deeplLangCode(String lang) {
  return _langCodes[lang.toLowerCase()] ?? "EN"; // default to English
}
