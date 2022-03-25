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

#define MAX_C_CODE 7

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
    char departAirportID[4];
    char arrivAirportID[4];
    Date departDate;
    Time departHour;
    Time duration;
    int capacity;

} Flight;

Flight flightList[MAX_FLIGHTS];

int flight_counter = 0;

void flightCode()
{
    char code_aux[MAX_C_CODE], departID_aux[4];

    scanf("%s", code_aux);
    scanf("%s", flightList[flight_counter].departAirportID);
    scanf("%s", flightList[flight_counter].arrivAirportID);

    flight_counter++;
}

int main()
{
    char option;

    Date currentDate = {1, 1, 2022};
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
            printf("newFlight / allFlights");
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
