var tags = [
  ["c#", 601251],
  ["java", 585413],
  ["javascript", 557407],
  ["php", 534590],
  ["android", 466436],
  ["jquery", 438303],
  ["python", 274216],
  ["c++", 269570],
  ["html", 259946]
]

var list = tags.map(function(word) {
  return [word[0], Math.round(word[1]/10000)];
});

console.log(list)
