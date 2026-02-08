String phraseDefinitionPrompt(String phrase, String language) => """
You are a dictionary AI.

Input:
phrase: "$phrase"
language: "$language"

Instructions:
1. Provide a **short dictionary-style explanation** of the phrase.
2. If the phrase is famous (idiom, lyric, movie quote, cultural reference), briefly explain its meaning and context.
3. Respond **only with the explanation** as plain text.
4. Do **not** include quotation marks, JSON, markdown, or any extra text.
5. Keep it to **one or two concise sentences**.

""";

/// Generates a single prompt asking Gemini to return explanation, examples, and synonyms
String phraseFullDataPrompt(String phrase, String language) => """
You are a dictionary AI.

Input:
phrase: "$phrase"
language: "$language"

Instructions:
1. Return a single JSON object with the following fields:

{
  "definition": "short dictionary-style explanation",
  "examples": [
    "Example 1",
    "Example 2",
    "Example 3",
    "Example 4",
    "Example 5"
  ],
  "synonyms": [
    "synonym1",
    "synonym2",
    "synonym3",
    "synonym4",
    "synonym5"
  ]
}

2. Fill exactly 5 examples and 5 synonyms. If some are unknown, use empty strings.
3. Definition should be 1–2 concise sentences.
4. Respond **ONLY with valid JSON**, no extra text, logs, quotes, fences, or markdown.
""";
