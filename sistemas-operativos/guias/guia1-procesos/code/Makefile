CC = gcc
CFLAGS = -Wall -Wextra -pedantic 

# Lista de todos los ejecutables
TARGETS = ej5a.out ej5b.out ej6.out ej9.out ej10.out ej16.out ej17.out ej19b.out temp.out

.PHONY: all clean $(TARGETS)

# Compilar todos juntos
all: $(TARGETS)

# Reglas individuales explícitas para cada uno
ej5a: ej5a.c
	$(CC) $(CFLAGS) ej5a.c -o ej5a.out

ej5b: ej5b.c
	$(CC) $(CFLAGS) ej5b.c -o ej5b.out

ej6: ej6.c
	$(CC) $(CFLAGS) ej6.c -o ej6.out

ej9: ej9.c
	$(CC) $(CFLAGS) ej9.c -o ej9.out

ej10: ej10.c
	$(CC) $(CFLAGS) ej10.c -o ej10.out

ej16: ej16.c
	$(CC) $(CFLAGS) ej16.c -o ej16.out

ej17: ej17.c
	$(CC) $(CFLAGS) ej17.c -o ej17.out

ej19b: ej19b.c
	$(CC) $(CFLAGS) ej19b.c -o ej19b.out

temp: temp.c
	$(CC) $(CFLAGS) temp.c -o temp.out

# Limpiar ejecutables
clean:
	rm -f $(TARGETS)
