CC = gcc
CFLAGS = -Wall -Wextra -pedantic 

# Lista de todos los ejecutables
TARGETS = ej5a ej5b ej6 ej9 ej10 ej16 ej17 ej19b temp

.PHONY: all clean $(TARGETS)

# Compilar todos juntos
all: $(TARGETS)

# Reglas individuales explícitas para cada uno
ej5a: ej5a.c
	$(CC) $(CFLAGS) ej5a.c -o ej5a

ej5b: ej5b.c
	$(CC) $(CFLAGS) ej5b.c -o ej5b

ej6: ej6.c
	$(CC) $(CFLAGS) ej6.c -o ej6

ej9: ej9.c
	$(CC) $(CFLAGS) ej9.c -o ej9

ej10: ej10.c
	$(CC) $(CFLAGS) ej10.c -o ej10

ej16: ej16.c
	$(CC) $(CFLAGS) ej16.c -o ej16

ej17: ej17.c
	$(CC) $(CFLAGS) ej17.c -o ej17

ej19b: ej19b.c
	$(CC) $(CFLAGS) ej19b.c -o ej19b

temp: temp.c
	$(CC) $(CFLAGS) temp.c -o temp

# Limpiar ejecutables
clean:
	rm -f $(TARGETS)
