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
5. Do not return any JSON formatting like  ```json. Just the plain JSON object 
""";

String definitionDistractorsPrompt({
  required String word,
  required String correctDefinition,
}) {
  return '''
You are helping create a vocabulary multiple-choice exercise.

Word: "$word"
Correct definition: "$correctDefinition"

Generate exactly 3 incorrect but plausible definitions.
They must be clearly wrong, but realistic.
Do NOT repeat the correct definition.
Ensure one of the distractors is the definition of an antonym
Return ONLY valid JSON in this format:

{
  "distractors": [
    "definition 1",
    "definition 2",
    "definition 3"
  ]
}
''';
}

String fillInTheBlankPrompt({
  required String word,
  required String language,
}) {
  return '''
You are creating a language-learning exercise.

Task:
- Create ONE natural sentence in $language.
- Replace the target word/s with "____".
- Provide the correct word/s.
- Provide 3 plausible but incorrect distractors.

Rules:
- The sentence must be realistic and common.
- The blank must be replaceable by the correct word or phrase expression provided.
- Distractors must be grammatically valid but incorrect. They wouldn't make sense in a real situation
- Output ONLY valid JSON.
- Do NOT include explanations.

JSON format:
{
  "sentence": "... ____ ...",
  "correct": "...",
  "distractors": ["...", "...", "..."]
}

Target word/phrase: "$word"
''';
}

String journalFeedbackPrompt(String text) {
  return '''
You are a language teacher.

Return ONLY valid JSON.
DO NOT include explanations outside JSON.
DO NOT include markdown.

Rules:
- Use character indices (0-based) for start/end based on the EXACT text below
- end is exclusive
- type must be one of: grammar, style, suggestion
- correctedContent must be fully corrected and natural
- conceptsLearned must list the grammatical concepts practiced or corrected

JSON format:
{
  "correctedContent": "",
  "corrections": [
    {
      "start": 0,
      "end": 0,
      "wrong": "",
      "right": "",
      "explanation": "",
      "example": "",
      "type": "",
      "concept": ""
    }
  ],
  "conceptsLearned": []
}

Example:

Sentence: "I go to the park yesterday"

Expected JSON:
{
  "correctedContent": "I went to the park yesterday",
  "corrections": [
    {
      "start": 2,
      "end": 4,
      "wrong": "go",
      "right": "went",
      "explanation": "The verb 'go' is irregular, and its past tense is 'went'.",
      "example": "I went to school yesterday.",
      "type": "grammar",
      "concept": "Past tense of go"
    }
  ],
  "conceptsLearned": ["Past tense of go"]
}

TEXT (do not rewrite it):
$text
''';
}

String grammarFeedbackPrompt({
  required String concept,
  required String sentence,
}) {
  return '''
You are a language teacher.

Grammar concept: "$concept"
Student sentence:
"$sentence"

Analyze the sentence.

Rules:
- If the sentence is correct, isCorrect = true
- If incorrect, correct it naturally
- Provide short, clear explanations
- Focus ONLY on the given grammar concept
- Do NOT rewrite stylistically unless needed for correctness

Return ONLY valid JSON in this format:

{
  "isCorrect": true | false,
  "correctedSentence": "corrected version",
  "explanations": [
    "explanation 1",
    "explanation 2"
  ]
}
''';
}

String grammarMultipleChoicePrompt({
  required String concept,
}) {
  return '''
You are a language teacher creating a grammar multiple-choice exercise.

Grammar concept: "$concept"

Generate:
- ONE sentence that uses the concept correctly
- THREE sentences that are incorrect but realistic learner mistakes

Rules:
- Only one sentence must be correct
- Incorrect sentences must clearly violate the concept
- Sentences should be natural and similar in difficulty

Return ONLY valid JSON in this format:

{
  "correct": "Correct sentence here",
  "distractors": [
    "Incorrect sentence 1",
    "Incorrect sentence 2",
    "Incorrect sentence 3"
  ]
}
''';
}
