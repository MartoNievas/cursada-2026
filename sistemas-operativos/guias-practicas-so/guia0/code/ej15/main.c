#include "utils.h"

void verInformacionUsuario(void);
void agregarInformacionUsuario(void);
void buscarInformacionUsuario(void);

int main(void) {
  char *option = malloc(sizeof(char) * 3);
  const char *verInfo = "verInformacionUsuario";
  const char *agregarInfo = "agregarInformacionUsuario";
  const char *buscarInfo = "buscarInformacionUsuario";

  while (1) {
    printf("Ingrese una opcion:\n");
    printf("1) %s \n", verInfo);
    printf("2) %s \n", agregarInfo);
    printf("3) %s\n", buscarInfo);
    scanf("%2s", option);

    if (strcmp("1", option) == 0) {
      verInformacionUsuario();

    } else if (strcmp("2", option) == 0) {
      agregarInformacionUsuario();
    } else if (strcmp(option, "3") == 0) {
      buscarInformacionUsuario();
    } else {
      printf("Error: Opcion no soportada\n");
    }

    free(option);
    return 0;
  }
}
