void add_answers(bool i) {
  Answers.add(i);
}

void clear_answers() {
  Answers.clear();
}

List<bool> Answers = [];

List<Map> Questions = [
  {
    "question": "JSON stands for _______.",
    "option": [
      "JavaScript Object Notation",
      "Java Object Notation",
      "JavaScript Object Normalization",
      "JavaScript Object-Oriented Notation"
    ],
    "answer": "JavaScript Object Notation",
    "note": "JSON stands for JavaScript Object Notation."
  },
  {
    "question": "JSON is a _____ for storing and transporting data.",
    "option": ["xml format", "text format", "JavaScript", "php format"],
    "answer": "text format",
    "note": "JSON is a text format for storing and transporting data."
  },
  {
    "question": "The JSON syntax is a subset of the _____ syntax.",
    "option": ["Ajax", "Php", "HTML", "JavaScript"],
    "answer": "JavaScript",
    "note": "The JSON syntax is a subset of the JavaScript syntax."
  },
  {
    "question": "Who is the creator of JSON?",
    "option": [
      "Alvin Alexander",
      "Rasmus Lerdorf",
      "Douglas Crockford",
      "Jesse James Garrett"
    ],
    "answer": "Douglas Crockford",
    "note": "Douglas Crockford is the creator of JSON."
  },
  {
    "question": "In the JSON syntax, data is separated by _____.",
    "option": ["Semicolons", "Colons", "Commas", "Hyper"],
    "answer": "Commas",
    "note": "In the JSON syntax, data is separated by commas."
  },
  {
    "question": "In the JSON syntax, array is written within in ____.",
    "option": [
      "Square brackets",
      "Curley braces",
      "Paratheses",
      "None of the above"
    ],
    "answer": "Square brackets",
    "note": "In the JSON syntax, array is written within in square brackets."
  },
  {
    "question": "Which is the correct symbol to insert a comment in JSON?",
    "option": [
      "//",
      "/*\u2026*/",
      "<!-- \u2026 -->",
      "JSON doesn't support the comments"
    ],
    "answer": "JSON doesn't support the comments",
    "note":
        "JSON doesn't support the comments. But you can add an extra attribute to write the comments."
  },
  {
    "question": "In the JSON syntax, data is in ____ pairs.",
    "option": ["class/object", "name/value", "datatype/variable", "value/="],
    "answer": "name/value",
    "note": "In the JSON syntax, data is in name/value pairs."
  },
  {
    "question":
        "What is the correct syntax of writing JSON name/value pair, where the value is of string type?",
    "option": [
      "\"name\" : \"value\"",
      "\"name\" : value",
      "\"name\" : 'value'",
      "'name' : 'value'"
    ],
    "answer": "\"name\" : \"value\"",
    "note":
        "The correct syntax of writing JSON name/value pair, where the value is of string type: \"name\" : \"value\""
  },
  {
    "question": "What is the file type for JSON files?",
    "option": [".jsn", ".js", ".json", ".jso"],
    "answer": ".json",
    "note": "The file type for JSON files is \".json\""
  }
];
