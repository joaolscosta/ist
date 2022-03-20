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

void newAirport(Airport airportList[], int j)
{
    int i = 0, counter = 0;
    char c;

    scanf("%s", airportList[j].id);
    scanf("%s", airportList[j].country);
    while ((c = getchar()) != '\n')
    {
        airportList[j].city[i] = c;
        i++;
    }

    while (airportList[j].id[counter] != '\0')
    {
        counter++;
    }

    if (counter > MAX_C_ID)
    {
        printf("invalid airport ID\n");
        return;
    }

    for (i = 0; airportList[i].id; i++)
    {
        if (airportList[j].id == airportList[i].id)
        {
            printf("duplicate airport");
            return;
        }
    }

    if (j > MAX_AIRPORTS)
    {
        printf("too many airports");
    }

    printf("airport %s\n", airportList[j].id);
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
    printf("Enter an option: ");
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
        printf("Enter an option: ");
        scanf("%c", &option);
    }

    if (option == 'q')
    {
        return 0;
    }
    return 0;
}
