/*
File: p1_JoaoCosta_102078.c
Author: João Luis Saraiva Costa ist1102078  IAED  2022
Description:
Este progama pretende a construção de um sistema de gestão de aeroportos com
funcionalidades de definição de aeroportos e voos assim como a sua consulta.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
Estas primeiras cinco constantes correspondem aos limites de cada variável da
constituição de um aeroporto

As próximas cinco contantes definem o que ao longo do correr do sistema são
os limites das datas introduzidas tanto ao sistema como aos voos.
*/

#define MAX_C_ID 4
#define MAX_C_COUNTRY 31
#define MAX_C_CITY 51
#define MAX_AIRPORTS 40

#define MIN_DAY 1
#define MIN_MONTH 1
#define MAX_MONTH 12
#define MIN_YEAR 2022
#define MAX_YEAR 2023

/* Limite de caracteres que um código de voo pode conter */
#define MAX_C_CODE 8
#define MAX_FLIGHTS 30000
#define MIN_F_CAPACITY 10

#define MAX_C_INSTRUCTION 65535

/*  COMAND A:   */

/*
Estrutura abaixo permite no decorrer do sistema alterar os parâmetros de um
aeroporto para que este possa ser adicionado ou considerado inválido se algum
parâmetro não corresponder ao pedido.
Contém o ID, o país e cidade de origem e também o número de voos que esse
aeroporto contém.
*/

typedef struct airport
{
    char id[MAX_C_ID];
    char country[MAX_C_COUNTRY];
    char city[MAX_C_CITY];
    int flights;

} Airport;

/*
A função newAirport() é a função que permite adicionar um aeroporto ao sistema.
Após ser chamada na main() não recebe quaisquer parâmetros e para além das
variáveis declaradas na função recorre também ao contador global
airport_counter que vai preencher os vetores num vetor global airportList[]
onde são preenchidos e armazenados os aeportos criados se não forem
inválidos.
*/

int airport_counter = 0;

void newAirport(Airport airportList[])
{
    int i = 0, counter = 0;
    /* Apesar de ter sido criado uma struct já com as variáveis necessárias
    estas variáveis auxiliares declaradas abaixo são também do tipo Airport
    e são necessárias pois as variáveis lidas que são introduzidas pelo
    utilizador podem não ser válidas então antes de se armazenar o conteúdo
    passa por uma série de testes.
    */
    char id_aux[MAX_C_ID], country_aux[MAX_C_COUNTRY], city_aux[MAX_C_CITY];

    scanf("%s", id_aux);
    scanf("%s", country_aux);
    scanf(" %[^\n]", city_aux);

    /*  O pŕoximo ciclo while a condição seguinte verificam se o ID do
    aeroporto apenas contém letras maiúsculas e se apenas contém no máximo
    três caracteres.
    */
    while (id_aux[counter] != '\0')
    {
        if (id_aux[counter] < 'A' || id_aux[counter] > 'Z')
        {
            printf("invalid airport ID\n");
            return;
        }
        counter++;
    }

    if (counter > MAX_C_ID)
    {
        printf("invalid airport ID\n");
        return;
    }

    /* Verifica se ultrapassa o limite de aeroportos permitidos */
    if (airport_counter >= MAX_AIRPORTS)
    {
        printf("too many airports\n");
        return;
    }

    /* Verifica se o ID introduzido corresponde a algum aeroporto já armazenado
no vetor de aeroportos */
    for (i = 0; i < airport_counter; i++)
    {
        if (strcmp(id_aux, airportList[i].id) == 0)
        {

            printf("duplicate airport\n");
            return;
        }
    }

    /* Este é o passo de cópia das variáveis auxiliares para as variáveis
    dentro de cada posição do vetor pois até agora fizemos uma série de
    validações que se desse erro em alguma não poderia ser adicionado o
    aeroporto ao sistema então após validar que todos os parâmetros estão
    corretos é que podemos afirmar que o aeroporto é válido */
    strncpy(airportList[airport_counter].id, id_aux, MAX_C_ID);
    strncpy(airportList[airport_counter].country, country_aux, MAX_C_COUNTRY);
    strncpy(airportList[airport_counter].city, city_aux, MAX_C_CITY);

    printf("airport %s\n", airportList[airport_counter].id);
    airport_counter++;
}

Airport airportList[MAX_AIRPORTS];

/*  COMAND T:   */

/* Este comando é o que vai definir a hora do sistema.
Recorre também a uma estrutura que vai ser o método de manipulação da data.
Tem como variáveis o dia, mês e ano . */
typedef struct
{
    int day;
    int month;
    int year;

} Date;

/* Definido aqui a data inicial do sistema */
Date currentDate = {1, 1, 2022};

/* Função newDate() recebe a data atual do sistema e após uma série de
condições se a data for válida retorna a nova data atual correspondendo ao
comando pretendido por t.
*/
Date newDate(Date currentDate)
{
    Date date;

    scanf("%d-%d-%d", &date.day, &date.month, &date.year);

    /* Após ler o dia, mês e ano introduzidos pelo utilizador verifica se
    o ano é maior ou menor doque o tempo permitido e faz uma série de
    verificações para analisar se a nova data não é numa data no passado em
    relação à data atual.*/
    if (date.year > MAX_YEAR || date.year < MIN_YEAR)
    {
        printf("invalid date\n");
        return currentDate;
    }
    /* Próximas condições verificam se a data introdizida não é anterior à
    data atual do sistema */
    else if (currentDate.year > date.year)
    {
        printf("invalid date\n");
        return currentDate;
    }
    else if (currentDate.year == date.year && currentDate.month > date.month)
    {
        printf("invalid date\n");
        return currentDate;
    }
    else if (currentDate.month == date.month && currentDate.day > date.day)
    {
        printf("invalid date\n");
        return currentDate;
    }
    else if (date.day > 31 || date.day < 1 || date.month > 12 ||
             date.month < 1)
    {
        printf("invalid date\n");
        return currentDate;
    }
    /* As próximas condições verificam se a data introduzida não é 1 ano ou
    mais após a data atual */
    else if (date.year == currentDate.year + 1 &&
             date.month > currentDate.month)
    {
        printf("invalid date\n");
        return currentDate;
    }
    else if (date.year == currentDate.year + 1 &&
             date.month == currentDate.month && date.day >= currentDate.day)
    {
        printf("invalid date\n");
        return currentDate;
    }
    /* Retorna a nova data se passar em todas as condições anteriores. */
    else
    {
        printf("%02d-%02d-%d\n", date.day, date.month, date.year);
        return date;
    }
}

/*  COMAND L:   */

/* Comando que lista os aeroportos */

/* Função printAirports() é a função que vai permitir dar ocorrer os comandos
pretendidos em l e recebe o parâmtro airport_counter que vai servir de contador
para que o vetor da lista de aeroportos seja apresentado.
Podem ser todos os aeroportos listados se apenas ocorrer o comando l ou então
os resptivos aeroportos que se indicarem à frente deste.

 */

void printAirports(int airport_counter)
{
    int i, k, flights = 0;
    Airport aux;
    Airport sortedAirports[MAX_AIRPORTS];
    char airport_id[MAX_C_ID], c;
    int check = 0, index = 0;

    /* Tal como na função para o comando 'a' esta também recorre a variáveis
    auxiliares para que possa primeiro ser validado o conteúdo introduzido após
    ou não ao l. */

    /* Como de qualquer das formas em que o utilizador apenas introduza o
    comando 'l' ou posteriormente introduza quais os aeroportos que quer
    filtrar a função começa por colocar todo o conteúdo dentro do vetor global
    de aeroportos dentro de outro vetor que vai ser ordenado por
    ordem alfabética ou de identificador de comando */
    for (i = 0; i < airport_counter; i++)
    {
        sortedAirports[i] = airportList[i];
    }

    for (i = 0; i < airport_counter; ++i)
    {
        for (k = i + 1; k < airport_counter; ++k)
        {
            if (strcmp(sortedAirports[i].id, sortedAirports[k].id) > 0)
            {
                aux = sortedAirports[i];
                sortedAirports[i] = sortedAirports[k];
                sortedAirports[k] = aux;
            }
        }
    }

    /* Após o vetor de aeroportos estar ordenado está presente uma condição
    para verificar se está presente apenas o l ou se estão posteriormente
    apenas os aeroportos que queremos listar. Para isso verificamos se o
    caracter logo a seguir ao l é um \n e aí o que acontece é que lista
    todos os aeroportos. Se não acontecer isso é porque estão discriminados
    à frente os aeroportos pretendidos e enquanto o caracter não for um \n
    vai ler todos os caracteres e confirmar se os ID's introduzidos
    correspondem a algum dos ID's presentes no vetor de aeroportos.*/
    c = getchar();
    if (c == '\n')
    {
        for (i = 0; i < airport_counter; i++)
        {
            printf("%s %s %s %d\n", sortedAirports[i].id,
                   sortedAirports[i].city, sortedAirports[i].country, flights);
        }
    }
    else
    {
        while (c != '\n')
        {
            scanf("%s", airport_id);
            check = 0; /* nao existe */

            for (i = 0; i < airport_counter; i++)
            {

                if (strcmp(airport_id, sortedAirports[i].id) == 0)
                {
                    check = 1; /* id correspondido */
                    index = i;
                }
            }

            if (check == 1)
            {
                printf("%s %s %s %d\n", sortedAirports[index].id,
                       sortedAirports[index].city,
                       sortedAirports[index].country, flights);
            }

            if (check == 0)
            {
                printf("%s: ", airport_id);
                printf("no such airport ID\n");
            }

            c = getchar();
        }
    }
}

/*  COMAND V:   */

/* Adiciona um voo ou lista todos os voos */

/* Para o comando v temos duas hipóteses: Ou é apenas introduzido o v é listado
todos os voos criados ou então é criado um novo voo.
Para que possamos introduzir e manipular os valores e texto de um voo
recorre-se a duas estruturas que correpondem ao tempo e ao voo que por sua
vez vai conter também outras structs do tipo data e tempo.
*/

typedef struct time
{
    int hours;
    int minutes;

} Time;

/* depart = departure
   arriv = arrival */

typedef struct flight
{
    char code[MAX_C_CODE];
    char departAirportID[MAX_C_ID];
    char arrivAirportID[MAX_C_ID];
    Date departDate;
    Time departHour;
    Time duration;
    int capacity;

} Flight;

/* Vetor global onde são armazenados os voos */
Flight flightList[MAX_FLIGHTS];

/* Contador de voos global */
int flight_counter = 0;

/* A função flightCode() é a função que permite criar ou listar os voos
previamente criados. Mais uma vez usamos variáveis auxiliares semelhantes às
presentes nas estruturas para primeiro verificar se o conteúdo é válido e
também verificamos como já foi explicado acima no início do comando L se temos
presente apenas o v introduzido pelo utilizador ou também conteúdo posterior ao
comando que indica a criação de um voo.
*/

void flightCode()
{
    char code_aux[MAX_C_CODE], departID_aux[MAX_C_ID], arrivID_aux[MAX_C_ID];
    int capacity_aux, code_char = 0;
    Date departDate_aux;
    Time departHour_aux, duration_aux;
    int id_check = 0, i;
    char c;

    /* Se o próximo caracter após o l for \n percorre o vetor flightList[] que
    é aqui que são armazenados todos os voos criados e imprime os seus valores.

    Se não acontecer analisa o código de voo, o ID do aeroporto de sáida e
    chegada, a data, a hora, a duração e a capacidade que leva. Após isto
    executa todas as condições necessárias à validação se é um voo permitido
    e se acontecer adiciona à lista de voos.
    */
    c = getchar();
    if (c == '\n')
    {
        for (i = 0; i < flight_counter; i++)
        {
            printf("%s %s %s %02d-%02d-%d %02d:%02d\n",
                   flightList[i].code,
                   flightList[i].departAirportID,
                   flightList[i].arrivAirportID,
                   flightList[i].departDate.day,
                   flightList[i].departDate.month,
                   flightList[i].departDate.year,
                   flightList[i].departHour.hours,
                   flightList[i].departHour.minutes);
        }
    }
    else
    {
        scanf("%s", code_aux);
        scanf("%s", departID_aux);
        scanf("%s", arrivID_aux);
        scanf("%d-%d-%d", &departDate_aux.day, &departDate_aux.month,
              &departDate_aux.year);
        scanf("%d:%d", &departHour_aux.hours, &departHour_aux.minutes);
        scanf("%d:%d", &duration_aux.hours, &duration_aux.minutes);
        scanf("%d", &capacity_aux);

        /* Verificar se tem as duas primeiras letras maiusculas:
        Começa por analisar os dois primeiros caracteres se são maiúsculas
        e se após isso está um número entre 1 e 9999.*/
        code_char = 0;
        while (code_char < 2)
        {
            if (code_aux[code_char] < 'A' || code_aux[code_char] > 'Z')
            {
                printf("invalid flight code\n");
                return;
            }
            code_char++;
        }
        if (code_aux[2] < '1' || code_aux[2] > '9')
        {
            printf("invalid flight code\n");
            return;
        }
        /* Verificar o resto dos digitos depois do primeiro diferente de zero
         */
        code_char = 3;
        while (code_aux[code_char] != '\0')
        {
            if (code_aux[code_char] < '0' || code_aux[code_char] > '9')
            {
                printf("invalid flight code\n");
                return;
            }
            code_char++;
        }

        /* Verificar se nao existe voos repetidos */
        for (i = 0; i < flight_counter; i++)
        {
            if (strcmp(code_aux, flightList[i].code) == 0)
            {
                if (departDate_aux.day == flightList[i].departDate.day &&
                    departDate_aux.month == flightList[i].departDate.month &&
                    departDate_aux.year == flightList[i].departDate.year)
                {
                    printf("flight already exists\n");
                    return;
                }
            }
        }

        /* Os dois próximos ciclos verificam se tanto o ID do aeroporto de
        saída como o de chegada existem no vetor de aeroportos.*/
        id_check = 0;
        for (i = 0; i < airport_counter; i++)
        {

            if (strcmp(departID_aux, airportList[i].id) == 0)
            {
                id_check = 1;
            }
        }
        if (id_check == 0)
        {
            printf("%s: no such airport ID\n", departID_aux);
            return;
        }
        id_check = 0; /* identificador do id */
        for (i = 0; i < airport_counter; i++)
        {

            if (strcmp(arrivID_aux, airportList[i].id) == 0)
            {
                id_check = 1; /* id correspondido */
            }
        }
        if (id_check == 0)
        {
            printf("%s: no such airport ID\n", arrivID_aux);
            return;
        }

        /* Verifica se excede o número máximo de voos permitidos */
        if (flight_counter > MAX_FLIGHTS)
        {
            printf("too many flights\n");
            return;
        }

        if (departDate_aux.year > 2023 || departDate_aux.year < 2022)
        {
            printf("invalid date\n");
            return;
        }
        if (currentDate.year > departDate_aux.year)
        {
            printf("invalid date\n");
            return;
        }
        if (currentDate.year == departDate_aux.year &&
            currentDate.month > departDate_aux.month)
        {
            printf("invalid date\n");
            return;
        }
        if (currentDate.year == departDate_aux.year &&
            currentDate.month == departDate_aux.month &&
            currentDate.day > departDate_aux.day)
        {
            printf("invalid date\n");
            return;
        }
        if (departDate_aux.year == currentDate.year + 1 &&
            departDate_aux.month > currentDate.month)
        {
            printf("invalid date\n");
            return;
        }
        if (departDate_aux.year == currentDate.year + 1 &&
            departDate_aux.month == currentDate.month &&
            departDate_aux.day > currentDate.day)
        {
            printf("invalid date\n");
            return;
        }

        /* Verifica se a duração do voo ultrapassa as 12 horas máximas */
        if (duration_aux.hours > 12 || (duration_aux.hours == 12 &&
                                        duration_aux.minutes > 0))
        {
            printf("invalid duration\n");
            return;
        }

        /* Verifica se a capacidade do voo está entre os limites
        estabelecidos*/
        if (capacity_aux < MIN_F_CAPACITY)
        {
            printf("invalid capacity\n");
            return;
        }

        /* Copia cada parâmetro das variáveis auxiliares lidas se estas
        corresponderem às regras impostas para o vetor global de voos */
        strcpy(flightList[flight_counter].code, code_aux);
        strcpy(flightList[flight_counter].departAirportID,
               departID_aux);
        strcpy(flightList[flight_counter].arrivAirportID, arrivID_aux);

        flightList[flight_counter].departDate.day = departDate_aux.day;
        flightList[flight_counter].departDate.month = departDate_aux.month;
        flightList[flight_counter].departDate.year = departDate_aux.year;
        flightList[flight_counter].departHour.hours = departHour_aux.hours;
        flightList[flight_counter].departHour.minutes = departHour_aux.minutes;
        flightList[flight_counter].duration.hours = duration_aux.hours;
        flightList[flight_counter].duration.minutes = duration_aux.minutes;
        flightList[flight_counter].capacity = capacity_aux;

        flight_counter++;
    }
}

/*  COMAND P:   */

/* Lista os voos com partida de um aeroporto */

/* A próxima função departList[] é a que corresponde ao comando p e este lista
todos os voos com a partida de um dado aeroporto.
*/

/* Contaodr de voos com partida de um aeroporto */
int depart_counter = 0;

/* Vetor global de voos com partida de um aeroporto */
Flight departList_aux[MAX_FLIGHTS];

/* Esta é um função auxiliar da departList[] que ordena o vetor dos voos pela
ordem de data partida */

void departList_sort()
{
    int i, j;
    Flight aux;

    /* Usada a técnica de Bubble Sort para odenar os voos criados pela data */
    for (i = 0; i < depart_counter; ++i)
    {
        for (j = i + 1; j < depart_counter; ++j)
        {
            if (departList_aux[j].departDate.year <
                departList_aux[i].departDate.year)
            {
                aux = departList_aux[i];
                departList_aux[i] = departList_aux[j];
                departList_aux[j] = aux;
            }
            if (departList_aux[j].departDate.year ==
                    departList_aux[i].departDate.year &&
                departList_aux[j].departDate.month <
                    departList_aux[i].departDate.month)
            {
                aux = departList_aux[i];
                departList_aux[i] = departList_aux[j];
                departList_aux[j] = aux;
            }
            if (departList_aux[j].departDate.year ==
                    departList_aux[i].departDate.year &&
                departList_aux[j].departDate.month ==
                    departList_aux[i].departDate.month &&
                departList_aux[j].departDate.day <
                    departList_aux[i].departDate.day)
            {
                aux = departList_aux[i];
                departList_aux[i] = departList_aux[j];
                departList_aux[j] = aux;
            }
            if (departList_aux[j].departDate.year ==
                    departList_aux[i].departDate.year &&
                departList_aux[j].departDate.month ==
                    departList_aux[i].departDate.month &&
                departList_aux[j].departDate.day ==
                    departList_aux[i].departDate.day &&
                departList_aux[j].departHour.hours <
                    departList_aux[i].departHour.hours)
            {
                aux = departList_aux[i];
                departList_aux[i] = departList_aux[j];
                departList_aux[j] = aux;
            }
            if (departList_aux[j].departDate.year ==
                    departList_aux[i].departDate.year &&
                departList_aux[j].departDate.month ==
                    departList_aux[i].departDate.month &&
                departList_aux[j].departDate.day ==
                    departList_aux[i].departDate.day &&
                departList_aux[j].departHour.hours ==
                    departList_aux[i].departHour.hours &&
                departList_aux[j].departHour.minutes <
                    departList_aux[i].departHour.minutes)
            {
                aux = departList_aux[i];
                departList_aux[i] = departList_aux[j];
                departList_aux[j] = aux;
            }
        }
    }
}

/* Esta departList() não recebe quaisquer parâmetros e para listar os voos
com base em um ID de um aeroporto o que faz é verificar na lista de voos
quais deles correspondem e adicionar ao vetor global departList_aux[]
o conteúdo desse voo a que corresponde o ID.
Após isso ordena o vetor com auxílio da função auxiliar acima e apresenta
o pretendido.*/

void departList()
{
    char departid_aux[MAX_C_ID];
    int i, check = 0;
    depart_counter = 0;
    scanf("%s", departid_aux);

    /* Verifica que ID's da lista de voos correspondem ao ID inserido e
    armazena numa lista auxiliar esses voos */
    for (i = 0; i < flight_counter; i++)
    {
        if (strcmp(departid_aux, flightList[i].departAirportID) == 0)
        {
            departList_aux[depart_counter] = flightList[i];
            depart_counter++;
        }
    }

    for (i = 0; i < airport_counter; i++)
    {
        if (strcmp(departid_aux, airportList[i].id) == 0)
        {
            check = 1;
        }
    }
    if (check == 0)
    {
        printf("%s: no such airport ID\n", departid_aux);
        return;
    }

    /* Função auxiliar para ordenar os voos pela data de partida */
    departList_sort();

    for (i = 0; i < depart_counter; i++)
    {
        printf("%s %s %02d-%02d-%02d %02d:%02d\n", departList_aux[i].code,
               departList_aux[i].arrivAirportID,
               departList_aux[i].departDate.day,
               departList_aux[i].departDate.month,
               departList_aux[i].departDate.year,
               departList_aux[i].departHour.hours,
               departList_aux[i].departHour.minutes);
    }
}

/*  COMAND C:   */

/* Lista os voos com chegada a um aeroporto */

/* Vetor global para armazenar os voos com chegada a um aeroporto */
Flight arrivList_aux[MAX_FLIGHTS];

void arrivList_sort(Flight arrivList_aux[], int arriv_counter)
{
    int i, j;
    Flight aux;

    /* Técnica de Bubble Sort para orndenar o vetor por data */
    for (i = 0; i < arriv_counter; ++i)
    {
        for (j = i + 1; j < arriv_counter; ++j)
        {
            if (arrivList_aux[j].departDate.year <
                arrivList_aux[i].departDate.year)
            {
                aux = arrivList_aux[i];
                arrivList_aux[i] = arrivList_aux[j];
                arrivList_aux[j] = aux;
            }
            else if (arrivList_aux[j].departDate.year ==
                         arrivList_aux[i].departDate.year &&
                     arrivList_aux[j].departDate.month <
                         arrivList_aux[i].departDate.month)
            {
                aux = arrivList_aux[i];
                arrivList_aux[i] = arrivList_aux[j];
                arrivList_aux[j] = aux;
            }
            else if (arrivList_aux[j].departDate.year ==
                         arrivList_aux[i].departDate.year &&
                     arrivList_aux[j].departDate.month ==
                         arrivList_aux[i].departDate.month &&
                     arrivList_aux[j].departDate.day <
                         arrivList_aux[i].departDate.day)
            {
                aux = arrivList_aux[i];
                arrivList_aux[i] = arrivList_aux[j];
                arrivList_aux[j] = aux;
            }
            else if (arrivList_aux[j].departDate.year ==
                         arrivList_aux[i].departDate.year &&
                     arrivList_aux[j].departDate.month ==
                         arrivList_aux[i].departDate.month &&
                     arrivList_aux[j].departDate.day ==
                         arrivList_aux[i].departDate.day &&
                     arrivList_aux[j].departHour.hours <
                         arrivList_aux[i].departHour.hours)
            {
                aux = arrivList_aux[i];
                arrivList_aux[i] = arrivList_aux[j];
                arrivList_aux[j] = aux;
            }
            else if (arrivList_aux[j].departDate.year ==
                         arrivList_aux[i].departDate.year &&
                     arrivList_aux[j].departDate.month ==
                         arrivList_aux[i].departDate.month &&
                     arrivList_aux[j].departDate.day ==
                         arrivList_aux[i].departDate.day &&
                     arrivList_aux[j].departHour.hours ==
                         arrivList_aux[i].departHour.hours &&
                     arrivList_aux[j].departHour.minutes <
                         arrivList_aux[i].departHour.minutes)
            {
                aux = arrivList_aux[i];
                arrivList_aux[i] = arrivList_aux[j];
                arrivList_aux[j] = aux;
            }
        }
    }
}

void arrivList()
{
    char arrivid_aux[MAX_C_ID];
    int i, check = 0, aux;
    int temp_day;
    int day, month, year;
    int arriv_counter;

    scanf("%s", arrivid_aux);
    arriv_counter = 0;
    for (i = 0; i < airport_counter; i++)
    {
        if (strcmp(arrivid_aux, airportList[i].id) == 0)
        {
            check = 1;
        }
    }
    if (check == 0)
    {
        printf("%s: no such airport ID\n", arrivid_aux);
        return;
    }

    /* Algoritmo para calcular a data e hora de chegada */
    for (i = 0; i < flight_counter; i++)
    {
        if (strcmp(arrivid_aux, flightList[i].arrivAirportID) == 0)
        {
            arrivList_aux[arriv_counter] = flightList[i];

            /* Soma a duração em minutos aos minutos do voo */
            arrivList_aux[arriv_counter].departHour.minutes +=
                arrivList_aux[arriv_counter].duration.minutes;

            /* Armazena o resultado em horas dos minutos do voo */
            aux = arrivList_aux[arriv_counter].departHour.minutes / 60;

            /* Soma as duração em horas mais o resultado anterior armazenado
            às horas do voo */
            arrivList_aux[arriv_counter].departHour.hours +=
                arrivList_aux[arriv_counter].duration.hours + aux;

            arrivList_aux[arriv_counter].departHour.minutes =
                arrivList_aux[arriv_counter].departHour.minutes - (aux * 60);

            /* Calcula os dias através das horas */
            temp_day = arrivList_aux[arriv_counter].departHour.hours / 24;
            arrivList_aux[arriv_counter].departDate.day += temp_day;

            year = arrivList_aux[arriv_counter].departDate.year;
            month = arrivList_aux[arriv_counter].departDate.month;
            day = arrivList_aux[arriv_counter].departDate.day;

            /* Verifica se o mês for fevereiro e dia 28 passa para o
            primeiro dia de março */
            if (arrivList_aux[arriv_counter].departDate.month == 2 &&
                arrivList_aux[arriv_counter].departDate.day > 28)
            {
                month++;
                arrivList_aux[arriv_counter].departDate.day -= 28;
            }
            /* Se chegar ao último dia de cada mês cujo dia é 31 passa
            para o primeiro dia do próximo mês. */
            else if ((month == 1 || month == 3 || month == 5 || month == 7 ||
                      month == 8 || month == 10) &&
                     day > 31)
            {
                month++;
                arrivList_aux[arriv_counter].departDate.day -= 31;
            }
            /*  Se chegar ao último dia de cada mês cujo dia é 30 passa
            para o primeiro dia do próximo mês. */
            else if ((month == 4 || month == 6 || month == 9 ||
                      month == 11) &&
                     day > 30)
            {
                month++;
                arrivList_aux[arriv_counter].departDate.day -= 30;
            }
            /* Se chegar ao dia 31 de dezembro aumenta o ano e passa para
            o mês 1 dia 1. */
            else if ((month == 12) && day > 31)
            {
                year++;
                month = 1;
                arrivList_aux[arriv_counter].departDate.day -= 31;
            }

            arrivList_aux[arriv_counter].departHour.hours -= 24 * temp_day;
            arrivList_aux[arriv_counter].departDate.month = month;
            arrivList_aux[arriv_counter].departDate.year = year;
            arriv_counter++;
        }
    }

    /* Ordena a lista de voos de chegada pela data */
    arrivList_sort(arrivList_aux, arriv_counter);

    for (i = 0; i < arriv_counter; i++)
    {
        printf("%s %s %02d-%02d-%02d %02d:%02d\n", arrivList_aux[i].code,
               arrivList_aux[i].departAirportID,
               arrivList_aux[i].departDate.day,
               arrivList_aux[i].departDate.month,
               arrivList_aux[i].departDate.year,
               arrivList_aux[i].departHour.hours,
               arrivList_aux[i].departHour.minutes);
    }
}

/*  COMAND R:   */

typedef struct reserves
{
    char *reserve_code;
    int passengers_numb;
    Date date;
    char code[MAX_C_CODE];
    struct reserves *next;
} Node;

Node *head = NULL;

void add_reserve(Node *reserve)
{

    Node *reserv_aux;
    Node *temp;

    if (head == NULL)
    {
        head = reserve;
    }
    else if (strcmp(reserve->reserve_code, head->reserve_code) < 0)
    {
        reserve->next = head;
        head = reserve;
    }
    else
    {
        reserv_aux = head;
        while (reserv_aux != NULL)
        {
            if (strcmp(reserve->reserve_code, reserv_aux->reserve_code) < 0)
            {
                temp->next = reserve;
                reserve->next = reserv_aux;
                break;
            }
            else if (reserv_aux->next == NULL)
            {
                reserv_aux->next = reserve;
                break;
            }
            temp = reserv_aux;
            reserv_aux = reserv_aux->next;
        }
    }
}

int checkDate(Date date)
{
    int check = 0;

    if (date.year > MAX_YEAR || date.year < MIN_YEAR)
    {
        printf("invalid date\n");
        check = 1;
    }
    else if (currentDate.year > date.year)
    {
        printf("invalid date\n");
        check = 1;
    }
    else if (currentDate.year == date.year && currentDate.month > date.month)
    {
        printf("invalid date\n");
        check = 1;
    }
    else if (currentDate.month == date.month && currentDate.day > date.day)
    {
        printf("invalid date\n");
        check = 1;
    }
    else if (date.day > 31 || date.day < 1 || date.month > 12 ||
             date.month < 1)
    {
        printf("invalid date\n");
        check = 1;
    }
    else if (date.year == currentDate.year + 1 &&
             date.month > currentDate.month)
    {
        printf("invalid date\n");
        check = 1;
    }
    else if (date.year == currentDate.year + 1 &&
             date.month == currentDate.month && date.day >= currentDate.day)
    {
        printf("invalid date\n");
        check = 1;
    }

    return check;
}

int reserveCheck(char reserve[MAX_C_INSTRUCTION])
{
    Node *reserv_aux;
    int check = 0;

    reserv_aux = head;
    while (reserv_aux != NULL)
    {
        if (strcmp(reserve, reserv_aux->reserve_code) == 0)
        {
            check = 1;
        }
        reserv_aux = reserv_aux->next;
    }

    return check;
}

void reserves()
{
    char code_aux[MAX_C_CODE], c, word;
    char reservCode[MAX_C_INSTRUCTION];
    Date date_aux;
    int passengersNumber, reservSize = 0, i;

    int capacity = 0;
    int code_check = 0, date_check = 0, reserve_check = 0;

    Node *reserve;
    Node *aux;
    char *reserve_code;

    scanf("%s", code_aux);
    scanf("%02d-%02d-%04d", &date_aux.day, &date_aux.month, &date_aux.year);

    c = getchar();
    if (c == '\n')
    {
        aux = head;
        while (aux != NULL)
        {
            if (strcmp(code_aux, aux->code) == 0 &&
                date_aux.day == aux->date.day &&
                date_aux.month == aux->date.month &&
                date_aux.year == aux->date.year)
            {
                printf("%s %d\n", aux->reserve_code, aux->passengers_numb);
            }
            aux = aux->next;
        }
    }
    else
    {
        scanf("%s", reservCode);
        scanf("%d", &passengersNumber);

        i = 0;
        while (reservCode[i] != '\0')
        {
            reservSize += 1;
            i++;
        }

        if (reservSize < 10)
        {
            printf("invalid reservation code\n");
            return;
        }

        for (i = 0; i < reservSize; i++)
        {
            word = reservCode[i];

            if ((word > 'Z' && word < 'A') || (word > '9' && word < '0'))
            {
                printf("invalid reservation code\n");
                return;
            }
            if (word <= 'z' && word >= 'a')
            {
                printf("invalid reservation code\n");
                return;
            }
        }

        for (i = 0; i < flight_counter; i++)
        {
            if (strcmp(flightList[i].code, code_aux) == 0)
            {
                code_check = 1;
            }
        }
        if (code_check == 0)
        {
            printf("%s: flight does not exist\n", code_aux);
            return;
        }

        reserve_check = reserveCheck(reservCode);

        if (reserve_check == 1)
        {
            printf("%s: flight reservation already used\n", reservCode);
            return;
        }

        for (i = 0; i < flight_counter; i++)
        {
            if (strcmp(code_aux, flightList[i].code) == 0 &&
                date_aux.day == flightList[i].departDate.day &&
                date_aux.month == flightList[i].departDate.month &&
                date_aux.year == flightList[i].departDate.year)
            {
                capacity = flightList[i].capacity;
                if (passengersNumber > 0)
                {
                    if ((capacity -= passengersNumber) >= 0)
                    {
                        flightList[i].capacity -= passengersNumber;
                    }
                    else
                    {
                        printf("too many reservations\n");
                        return;
                    }
                }
            }
        }

        date_check = checkDate(date_aux);

        if (date_check == 1)
        {
            printf("invalid date\n");
            return;
        }

        if (passengersNumber < 1)
        {
            printf("invalid passenger number\n");
            return;
        }

        reserve_code = malloc(sizeof(char) * (reservSize + 1));
        reserve = malloc(sizeof(Node));

        if (reserve_code == NULL)
        {
            printf("No memory\n");
            exit(0);
        }
        if (reserve == NULL)
        {
            printf("No memory\n");
            exit(0);
        }

        strcpy(reserve_code, reservCode);
        strcpy(reserve->code, code_aux);
        reserve->date = date_aux;
        reserve->passengers_numb = passengersNumber;
        reserve->reserve_code = reserve_code;

        add_reserve(reserve);
    }
}

/*  COMAND E:   */

void delete ()
{
    char code[MAX_C_INSTRUCTION];
    Node *reserve_aux;
    int i, j, code_size, code_check = 0;
    int passengersNumb;

    scanf("%s", code);

    code_size = strlen(code);

    if (code_size < 10)
    {
        if (flight_counter == 0)
        {
            printf("not found\n");
            return;
        }

        for (i = 0; i < flight_counter; i++)
        {
            if (strcmp(code, flightList[i].code) == 0)
            {
                code_check = 1;
                reserve_aux = head;
                while (reserve_aux != NULL)
                {

                    if (strcmp(code, reserve_aux->reserve_code) == 0)
                    {
                        free(reserve_aux->reserve_code);
                        free(reserve_aux);
                        code_check = 1;
                    }
                    reserve_aux = reserve_aux->next;
                }

                for (j = i; j < flight_counter; j++)
                {
                    flightList[j] = flightList[j + 1];
                }
                flight_counter--;
                i--;
            }
        }

        if (code_check == 0)
        {
            printf("not found\n");
            return;
        }
    }
    else
    {
        if (head == NULL)
        {
            printf("not found\n");
            return;
        }

        if (strcmp(code, head->reserve_code) == 0)
        {
            reserve_aux = head;
            head = head->next;
            passengersNumb = reserve_aux->passengers_numb;

            for (i = 0; i < flight_counter; i++)
            {
                if (strcmp(code, flightList[i].code) == 0)
                {
                    flightList[i].capacity += passengersNumb;
                }
            }

            free(reserve_aux->reserve_code);
            free(reserve_aux);
            return;
        }

        reserve_aux = head;

        while (reserve_aux != NULL)
        {

            if (strcmp(code, reserve_aux->reserve_code) == 0)
            {
                passengersNumb = reserve_aux->passengers_numb;

                for (i = 0; i < flight_counter; i++)
                {
                    if (strcmp(code, flightList[i].code) == 0)
                    {
                        flightList[i].capacity += passengersNumb;
                    }
                }

                free(reserve_aux->reserve_code);
                free(reserve_aux);
                code_check = 1;
            }
            reserve_aux = reserve_aux->next;
        }

        if (code_check == 0)
        {
            printf("not found\n");
            return;
        }
    }
}

/* Função main() que lê um caracter que correponde ao comando pretendido pelo
utilizador e enquanto for diferente de q (termina o programa) pede
repetidamente após introduzir o comando e conteúdo desejado qual o próximo
comando que o utilizador pretende realizar.
*/
int main()
{
    char option;
    Node *aux;

    scanf("%c", &option);

    while (option != 'q')
    {
        switch (option)
        {
        case 'a':
            newAirport(airportList);
            break;
        case 'l':
            printAirports(airport_counter);
            break;
        case 'v':
            flightCode(flight_counter);
            break;
        case 'p':
            departList();
            break;
        case 'c':
            arrivList();
            break;
        case 't':
            currentDate = newDate(currentDate);
            break;
        case 'r':
            reserves();
            break;
        case 'e':
            delete ();
            break;
        }
        scanf("%c", &option);
    }

    if (option == 'q')
    {
        while (head != NULL)
        {
            aux = head;
            head = head->next;
            free(aux->reserve_code);
            free(aux);
        }
    }
    return 0;
}

/* gcc -Wall -Wextra -Werror -ansi -pedantic -o ola p.c */