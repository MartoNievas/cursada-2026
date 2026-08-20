#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void process_word(char *s) {
  int n = strlen(s);

  for (int i = 0; i < n; i++) {
    s[i] = toupper(s[i]);
  }

  for (int i = 0; i < n / 2; i++) {
    char temp = s[i];
    s[i] = s[n - 1 - i];
    s[n - 1 - i] = temp;
  }
}

int main(int argc, char *argv[]) {
  if (argc != 3) {
    printf("Usage: <N> <Word>\n");
    return 1;
  }

  int n = atoi(argv[1]);
  char *word = argv[2];

  int len = strlen(word);

  if (len > n) {
    process_word(word);
    printf("%s\n", word);
  }

  return 0;
}
