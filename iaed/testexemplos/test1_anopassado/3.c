typedef struct
{
    char destino[4];
    int partida;
    int chegada;
} Voo;

typedef struct
{
    char nome[50];
    char calling_code[7];
    int n_voos;
    Voo voos[50];

} Companhia;
