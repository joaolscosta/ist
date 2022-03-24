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
#define MAX_C_CODE 4

#define MIN_DAY 1
#define MIN_MONTH 1
#define MAX_MONTH 12
#define MIN_YEAR 2022
#define MAX_YEAR 2023

/*  COMAND A:   */

typedef struct airport
{
    char id[MAX_C_ID];
    char country[MAX_C_COUNTRY];
    char city[MAX_C_CITY];
    int flights[MAX_FLIGHTS];

} Airport;

int j = 0;

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

    for (i = 0; i < j; i++)
    {
        if (strcmp(id_aux, airportList[i].id) == 0)
        {

            printf("duplicate airport\n");
            return;
        }
    }

    if (j > MAX_AIRPORTS)
    {
        printf("too many airports\n");
        return;
    }

    strncpy(airportList[j].id, id_aux, MAX_C_ID);
    strncpy(airportList[j].country, country_aux, MAX_C_COUNTRY);
    strncpy(airportList[j].city, city_aux, MAX_C_CITY);

    printf("airport %s\n", airportList[j].id);
    j++;
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
    }
    else if (currentDate.year > date.year)
    {
        printf("invalid date\n");
    }
    else if (currentDate.year == date.year && currentDate.month > date.month)
    {
        printf("invalid date\n");
    }
    else if (currentDate.month == date.month && currentDate.day > date.day)
    {
        printf("invalid date\n");
    }
    else
    {
        printf("%02d-%02d-%d", date.day, date.month, date.year);
        return date;
    }
    return currentDate;
}

/*  COMAND L:   */

void printAirports(int j)
{
    int i, k, id_counter = 0;
    Airport aux;
    Airport sortedAirports[MAX_AIRPORTS];
    char airport_id[MAX_C_ID], c;

    for (i = 0; i < j; i++)
    {
        sortedAirports[i] = airportList[i];
    }

    for (i = 0; i < j; ++i)
    {
        for (k = i + 1; k < j; ++k)
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
        for (i = 0; i < j; i++)
        {
            printf("%s %s %s\n", sortedAirports[i].id,
                   sortedAirports[i].country, sortedAirports[i].city);
        }
    }
    else
    {

        while (c != '\n')
        {
            scanf("%s", airport_id);

            for (i = 0; i < MAX_AIRPORTS; i++)
            {
                if (strcmp(airport_id, sortedAirports[i].id) == 0)
                {
                    id_counter += 1;
                    printf("%s %s %s\n", sortedAirports[i].id,
                           sortedAirports[i].country, sortedAirports[i].city);
                }
            }

            if (id_counter == 0)
            {
                printf("%s", airport_id);
                printf("no such airport ID\n");
                return;
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
    char id[4];
    char departAirportID[4];
    char arrivAirportID[4];
    Date departDate;
    Time departHour;
    Time duration;
    int capacity;

} Flight;

Flight flightList[MAX_FLIGHTS];

int f_counter = 0;
void flightCode()
{
    scanf("%s", flightList[f_counter].id);
    scanf("%s", flightList[f_counter].departAirportID);
    scanf("%s", flightList[f_counter].arrivAirportID);

    f_counter++;
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
            printAirports(j);
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
