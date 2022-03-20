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

typedef struct airport
{
    char id[MAX_C_ID];
    char country[MAX_C_COUNTRY];
    char city[MAX_C_CITY];

} Airport;

void newAirport(Airport airportList[MAX_AIRPORTS], int j)
{
    Airport airport;
    int i = 0;
    char c;

    scanf("%s", airport.id);
    scanf("%s", airport.country);

    while ((c = getchar()) != '\n')
    {
        airport.id[i] = c;
        if (c > 'Z' || c < 'A')
        {
            printf("invalid airport id");
        }
        i++;
    }

    while ((c = getchar()) != '\n')
    {
        airport.city[i] = c;
        i++;
    }

    airport = airportList[j];

    printf("airport %s", airport.id);
}

typedef struct
{
    int day;
    int month;
    int year;

} Date;

Date newDate(Date currentDate)
{
    Date date;
    char c1, c2;

    scanf("%d", &date.day);
    scanf("%c", &c1);
    scanf("%d", &date.month);
    scanf("%c", &c2);
    scanf("%d", &date.year);

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

int main()
{
    char option;
    int j = 0;
    Airport airportList[MAX_AIRPORTS];

    Date currentDate = {1, 1, 2022};
    printf("Enter a option: ");
    scanf("%c", &option);

    while (option != 'q')
    {
        switch (option)
        {
        case 'a':
            newAirport(airportList, j);
            j++;
            break;
        case 'l':
            printf("airportList()");
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
