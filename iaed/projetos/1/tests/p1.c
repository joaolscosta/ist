

/* gcc -Wall -Wextra -Werror -ansi -pedantic -o p1 p1.c */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define MAX_C_ID 4
#define MAX_C_COUNTRY 30
#define MAX_C_CITY 50
#define MAX_AIRPORTS 40
#define MAX_FLIGHTS 30000

#define MIN_DAY 1
#define MIN_MONTH 1
#define MAX_MONTH 12
#define MIN_YEAR 2022
#define MAX_YEAR 2023

#define MAX_C_CODE 8

/*  COMAND A:   */

typedef struct airport
{
    char id[MAX_C_ID];
    char country[MAX_C_COUNTRY];
    char city[MAX_C_CITY];
    int flights[MAX_FLIGHTS];

} Airport;

int airport_counter = 0;

void newAirport(Airport airportList[])
{
    int i = 0, counter = 0;
    char id_aux[MAX_C_ID], country_aux[MAX_C_COUNTRY], city_aux[MAX_C_CITY];

    scanf("%s", id_aux);
    scanf("%s", country_aux);
    scanf(" %[^\n]", city_aux);

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

    for (i = 0; i < airport_counter; i++)
    {
        if (strcmp(id_aux, airportList[i].id) == 0)
        {

            printf("duplicate airport\n");
            return;
        }
    }

    if (airport_counter >= MAX_AIRPORTS)
    {
        printf("too many airports\n");
        return;
    }

    strncpy(airportList[airport_counter].id, id_aux, MAX_C_ID);
    strncpy(airportList[airport_counter].country, country_aux, MAX_C_COUNTRY);
    strncpy(airportList[airport_counter].city, city_aux, MAX_C_CITY);

    printf("airport %s\n", airportList[airport_counter].id);
    airport_counter++;
}

Airport airportList[MAX_AIRPORTS];

/*  COMAND T:   */

typedef struct
{
    int day;
    int month;
    int year;

} Date;

Date currentDate = {1, 1, 2022};

Date newDate(Date currentDate)
{
    Date date;

    scanf("%d-%d-%d", &date.day, &date.month, &date.year);

    if (date.year > MAX_YEAR || date.year < MIN_YEAR)
    {
        printf("invalid date\n");
        return currentDate;
    }
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
    else if (date.year == currentDate.year + 1 &&
             date.month > currentDate.month)
    {
        printf("invalid date\n");
        return currentDate;
    }
    else if (date.year == currentDate.year + 1 &&
             date.month == currentDate.month && date.day > currentDate.day)
    {
        printf("invalid date\n");
        return currentDate;
    }
    else
    {
        printf("%02d-%02d-%d\n", date.day, date.month, date.year);
        return date;
    }
}

/*  COMAND L:   */

void printAirports(int airport_counter)
{
    int i, k, flights = 0;
    Airport aux;
    Airport sortedAirports[MAX_AIRPORTS];
    char airport_id[MAX_C_ID], c;
    int check = 0, index = 0;

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
                    check = 1;
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

typedef struct time
{
    int hours;
    int minutes;

} Time;

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

Flight flightList[MAX_FLIGHTS];

int flight_counter = 0;

void flightCode()
{
    char code_aux[MAX_C_CODE], departID_aux[MAX_C_ID], arrivID_aux[MAX_C_ID];
    int capacity_aux, code_char = 0;
    Date departDate_aux;
    Time departHour_aux, duration_aux;
    int id_check = 0, i;
    char c;

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
        /* Verificar se tem as duas primeiras letras maiusculas */
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

        /* Verificar se nao existe voos repetidos */
        for (i = 0; i < flight_counter; i++)
        {
            if (strcmp(code_aux, flightList[i].code) == 0)
            {
                if (departDate_aux.day == flightList[i].departDate.day && departDate_aux.month == flightList[i].departDate.month && departDate_aux.year == flightList[i].departDate.year)
                {
                    printf("flight already exists\n");
                    return;
                }
            }
        }

        /* Os dois próximos ciclos é para verificar se nao existem os id's de
            partida e chegada
            v AC12 ABC DEF 10-1-2022 09:10 01:10 40*/

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
        id_check = 0;
        for (i = 0; i < airport_counter; i++)
        {

            if (strcmp(arrivID_aux, airportList[i].id) == 0)
            {
                id_check = 1;
            }
        }
        if (id_check == 0)
        {
            printf("%s: no such airport ID\n", arrivID_aux);
            return;
        }

        if (flight_counter > MAX_FLIGHTS)
        {
            printf("too many flights\n");
            return;
        }

        if (duration_aux.hours > 12 || (duration_aux.hours == 12 &&
                                        duration_aux.minutes > 0))
        {
            printf("invalid duration\n");
            return;
        }

        if (capacity_aux > 100 || capacity_aux < 10)
        {
            printf("invalid capacity\n");
            return;
        }

        strncpy(flightList[flight_counter].code, code_aux, MAX_C_CODE);
        strncpy(flightList[flight_counter].departAirportID,
                departID_aux, MAX_C_ID);
        strncpy(flightList[flight_counter].arrivAirportID, arrivID_aux,
                MAX_C_ID);

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

int depart_counter = 0;

Flight departList_aux[MAX_FLIGHTS];

void departList()
{
    char id_aux[MAX_C_ID];

    int i, j, check = 0;
    int day_aux, month_aux, year_aux, hour_aux, minutes_aux;
    char code_aux[MAX_C_CODE], departid_aux[MAX_C_ID];

    scanf("%s", id_aux);

    for (i = 0; i < flight_counter; i++)
    {
        if (strcmp(id_aux, flightList[i].departAirportID) == 0)
        {
            check = 1;
            strcpy(departList_aux[depart_counter].code, flightList[i].code);
            strcpy(departList_aux[depart_counter].departAirportID,
                   flightList[i].departAirportID);

            departList_aux[depart_counter].departDate.day = flightList[i].departDate.day;
            departList_aux[depart_counter].departDate.month = flightList[i].departDate.month;
            departList_aux[depart_counter].departDate.year = flightList[i].departDate.year;
        }
    }
    if (check == 0)
    {
        printf("no such airport ID");
        return;
    }

    for (i = 0; i < depart_counter; ++i)
    {
        for (j = i + 1; j < depart_counter; ++j)
        {
            if (departList_aux[i].departDate.year <
                departList_aux[j].departDate.year)
            {
                day_aux = departList_aux[i].departDate.day;
                month_aux = departList_aux[i].departDate.month;
                year_aux = departList_aux[i].departDate.year;
                hour_aux = departList_aux[i].departHour.hours;
                minutes_aux = departList_aux[i].departHour.minutes;
                strcpy(departid_aux, departList_aux[i].departAirportID);
                strcpy(code_aux, departList_aux[i].code);

                departList_aux[i].departDate.day =
                    departList_aux[j].departDate.day;
                departList_aux[i].departDate.month =
                    departList_aux[j].departDate.month;
                departList_aux[i].departDate.year =
                    departList_aux[j].departDate.year;
                departList_aux[i].departHour.hours =
                    departList_aux[j].departHour.hours;
                departList_aux[i].departHour.minutes =
                    departList_aux[j].departHour.minutes;
                strcpy(departList_aux[i].departAirportID,
                       departList_aux[j].departAirportID);
                strcpy(departList_aux[i].code,
                       departList_aux[j].code);

                departList_aux[j].departDate.day = day_aux;
                departList_aux[j].departDate.month = month_aux;
                departList_aux[j].departDate.year = year_aux;
                departList_aux[j].departHour.hours = hour_aux;
                departList_aux[j].departHour.minutes = minutes_aux;
                strcpy(departList_aux[j].departAirportID, departid_aux);
                strcpy(departList_aux[j].code, code_aux);
            }
        }
    }

    for (i = 0; i < depart_counter; i++)
    {
        printf("%s %s %02d-%02d-%02d %d:%d", departList_aux[i].code,
               departList_aux[i].departAirportID,
               departList_aux[i].departDate.day,
               departList_aux[i].departDate.month,
               departList_aux[i].departDate.year,
               departList_aux[i].departHour.hours,
               departList_aux[i].departHour.minutes);
    }
}

int main()
{
    char option;

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
            printf("airportDepartures");
            break;
        case 'c':
            printf("airportArrivals");
            break;
        case 't':
            currentDate = newDate(currentDate);
            break;
        }
        scanf("%c", &option);
    }

    if (option == 'q')
    {
        return 0;
    }
    return 0;
}
