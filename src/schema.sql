PRAGMA foreign_keys = ON;


CREATE TABLE shows (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    production_company TEXT NOT NULL,
    duration_minutes INTEGER NOT NULL,
    age_rating TEXT NOT NULL
    )
;

/*
If a show is cancelled, delete all the viewings associated with that show. If a venue doesn't exist, delete all the viewings associated with that venue.

Valid status values are "scheduled", "cancelled", and "past". When a viewing is created and is expected to go as planned, the status should be "scheduled". If the viewing is cancelled, the status should be "cancelled". If the viewing has already happened, the status should be "past".
*/

CREATE TABLE viewings (
    id INTEGER PRIMARY KEY,
    status TEXT NOT NULL DEFAULT "scheduled",
    show_id INTEGER NOT NULL,
    venue_id INTEGER NOT NULL,
    start_time TEXT NOT NULL,
    end_time TEXT NOT NULL,
    available_seats INTEGER NOT NULL,
    last_updated TEXT NOT NULL,
    additional_notes TEXT,
    FOREIGN KEY (show_id) REFERENCES shows(id) ON DELETE CASCADE,
    FOREIGN KEY (venue_id) REFERENCES venues(id) ON DELETE CASCADE)
;

CREATE TABLE venues (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    capacity INTEGER NOT NULL,
    latitude REAL NOT NULL,
    longitude REAL NOT NULL,
    wheelchair_available BOOLEAN DEFAULT FALSE,
    accessible_washroom BOOLEAN DEFAULT FALSE,
    adult_only BOOLEAN DEFAULT FALSE,
    additional_notes TEXT)
;

/*
There will be a one-to-many relationship between shows and genres. That is, a show can have multiple genres, and a genre can be associated with multiple shows. When querying, use a join to get the genres associated with a show.
*/

CREATE TABLE genres (
    id INTEGER PRIMARY KEY,
    genre TEXT NOT NULL UNIQUE)
;

CREATE TABLE show_genres(
    id INTEGER PRIMARY KEY,
    show_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    FOREIGN KEY (show_id) REFERENCES shows(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE)
;

/*
A show can have multiple price bands. For example, a show can have general pricing, student pricing, and senior pricing. Each price band will have a price associated with it. When querying, use a join to get the price bands associated with a show.

The prices are set by the production company and are not affected by the venue. The price bands are set when the show is created and cannot be changed.

Use a join query to get the price bands associated with a show.

I will use this table primarily for whether the client is a student or senior, and the price will be calculated in the application when considering the schedule.
*/

CREATE TABLE price_bands(
    id INTEGER PRIMARY KEY,
    show_id INTEGER NOT NULL,
    band_category TEXT NOT NULL DEFAULT "general",
    price REAL NOT NULL,
    FOREIGN KEY (show_id) REFERENCES shows(id) ON DELETE CASCADE)
);
