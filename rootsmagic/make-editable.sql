/**
 * converts a RootsMagic database into one that can be edited
 * without complications from RMNOCASE callation sequence
 * run me with: sqlite3 <database>.rmgc < make-editable.sql
 */

PRAGMA foreign_keys=off;

BEGIN TRANSACTION;

/** AddressTable */
CREATE TABLE AddressTable_new (
  AddressID INTEGER PRIMARY KEY,
  AddressType INTEGER, Name TEXT COLLATE NOCASE,
  Street1 TEXT,
  Street2 TEXT,
  City TEXT,
  State TEXT,
  Zip TEXT,
  Country TEXT,
  Phone1 TEXT,
  Phone2 TEXT,
  Fax TEXT,
  Email TEXT,
  URL TEXT,
  Latitude INTEGER,
  Longitude INTEGER,
  Note BLOB
);

INSERT INTO AddressTable_new (
  AddressID, AddressType, Street1, Street2, City, State, Zip,
  Country, Phone1, Phone2, Fax, Email, URL, Latitude, Longitude,
  Note
)
SELECT
  AddressID, AddressType, Street1, Street2, City, State, Zip,
  Country, Phone1, Phone2, Fax, Email, URL, Latitude, Longitude,
  Note
FROM AddressTable;

DROP TABLE AddressTable;

CREATE TABLE AddressTable (
  AddressID INTEGER PRIMARY KEY,
  AddressType INTEGER, Name TEXT COLLATE NOCASE,
  Street1 TEXT,
  Street2 TEXT,
  City TEXT,
  State TEXT,
  Zip TEXT,
  Country TEXT,
  Phone1 TEXT,
  Phone2 TEXT,
  Fax TEXT,
  Email TEXT,
  URL TEXT,
  Latitude INTEGER,
  Longitude INTEGER,
  Note BLOB
);

INSERT INTO AddressTable (
  AddressID, AddressType, Street1, Street2, City, State, Zip,
  Country, Phone1, Phone2, Fax, Email, URL, Latitude, Longitude,
  Note
)
SELECT
  AddressID, AddressType, Street1, Street2, City, State, Zip,
  Country, Phone1, Phone2, Fax, Email, URL, Latitude, Longitude,
  Note
FROM AddressTable_new;

DROP TABLE AddressTable_new;

CREATE INDEX idxAddressName ON AddressTable (Name);


/** FactTypeTable */
CREATE TABLE FactTypeTable_new (
  FactTypeID INTEGER PRIMARY KEY,
  OwnerType INTEGER,
  Name TEXT COLLATE NOCASE,
  Abbrev TEXT,
  GedcomTag TEXT,
  UseValue INTEGER,
  UseDate INTEGER,
  UsePlace INTEGER,
  Sentence BLOB,
  Flags INTEGER
);

INSERT INTO FactTypeTable_new (
  FactTypeID, OwnerType, Name, Abbrev, GedcomTag, UseValue,
  UseDate, UsePlace, Sentence, Flags
)
SELECT
  FactTypeID, OwnerType, Name, Abbrev, GedcomTag, UseValue,
  UseDate, UsePlace, Sentence, Flags
FROM FactTypeTable;

DROP TABLE FactTypeTable;

CREATE TABLE FactTypeTable (
  FactTypeID INTEGER PRIMARY KEY,
  OwnerType INTEGER,
  Name TEXT COLLATE NOCASE,
  Abbrev TEXT,
  GedcomTag TEXT,
  UseValue INTEGER,
  UseDate INTEGER,
  UsePlace INTEGER,
  Sentence BLOB,
  Flags INTEGER
);

INSERT INTO FactTypeTable (
  FactTypeID, OwnerType, Name, Abbrev, GedcomTag, UseValue,
  UseDate, UsePlace, Sentence, Flags
)
SELECT
  FactTypeID, OwnerType, Name, Abbrev, GedcomTag, UseValue,
  UseDate, UsePlace, Sentence, Flags
FROM FactTypeTable_new;

DROP TABLE FactTypeTable_new;

CREATE INDEX idxFactTypeName ON FactTypeTable (Name);
CREATE INDEX idxFactTypeAbbrev ON FactTypeTable (Abbrev);
CREATE INDEX idxFactTypeGedcomTag ON FactTypeTable (GedcomTag);


/** MultimediaTable */
CREATE TABLE MultimediaTable_new (
  MediaID INTEGER PRIMARY KEY,
  MediaType INTEGER,
  MediaPath TEXT,
  MediaFile TEXT COLLATE NOCASE,
  URL TEXT,
  Thumbnail BLOB,
  Caption TEXT COLLATE NOCASE,
  RefNumber TEXT COLLATE NOCASE,
  Date TEXT,
  SortDate INTEGER,
  Description BLOB
);

INSERT INTO MultimediaTable_new (
  MediaID, MediaType, MediaPath, MediaFile, URL, Thumbnail,
  Caption, RefNumber, Date, SortDate, Description
)
SELECT
  MediaID, MediaType, MediaPath, MediaFile, URL, Thumbnail,
  Caption, RefNumber, Date, SortDate, Description
FROM MultimediaTable;

DROP TABLE MultimediaTable;

CREATE TABLE MultimediaTable (
  MediaID INTEGER PRIMARY KEY,
  MediaType INTEGER,
  MediaPath TEXT,
  MediaFile TEXT COLLATE NOCASE,
  URL TEXT,
  Thumbnail BLOB,
  Caption TEXT COLLATE NOCASE,
  RefNumber TEXT COLLATE NOCASE,
  Date TEXT,
  SortDate INTEGER,
  Description BLOB
);

INSERT INTO MultimediaTable (
  MediaID, MediaType, MediaPath, MediaFile, URL, Thumbnail,
  Caption, RefNumber, Date, SortDate, Description
)
SELECT
  MediaID, MediaType, MediaPath, MediaFile, URL, Thumbnail,
  Caption, RefNumber, Date, SortDate, Description
FROM MultimediaTable_new;

DROP TABLE MultimediaTable_new;

CREATE INDEX idxMediaFile ON MultimediaTable (MediaFile);
CREATE INDEX idxMediaURL ON MultimediaTable (URL);

/** MediaLinkTable */
CREATE TABLE MediaLinkTable_new (
  LinkID INTEGER PRIMARY KEY,
  MediaID INTEGER,
  OwnerType INTEGER,
  OwnerID INTEGER,
  IsPrimary INTEGER,
  Include1 INTEGER,
  Include2 INTEGER,
  Include3 INTEGER,
  Include4 INTEGER,
  SortOrder INTEGER,
  RectLeft INTEGER,
  RectTop INTEGER,
  RectRight INTEGER,
  RectBottom INTEGER,
  Note TEXT,
  Caption TEXT COLLATE NOCASE,
  RefNumber TEXT COLLATE NOCASE,
  Date TEXT,
  SortDate INTEGER,
  Description BLOB
);

INSERT INTO MediaLinkTable_new (
  LinkID, MediaID, OwnerType, OwnerID, IsPrimary, Include1,
  Include2, Include3, Include4, SortOrder, RectLeft, RectTop,
  RectRight, RectBottom, Note, Caption, RefNumber, Date,
  SortDate, Description
)
SELECT
  LinkID, MediaID, OwnerType, OwnerID, IsPrimary, Include1,
  Include2, Include3, Include4, SortOrder, RectLeft, RectTop,
  RectRight, RectBottom, Note, Caption, RefNumber, Date,
  SortDate, Description
FROM MediaLinkTable;

DROP TABLE MediaLinkTable;

CREATE TABLE MediaLinkTable (
  LinkID INTEGER PRIMARY KEY,
  MediaID INTEGER,
  OwnerType INTEGER,
  OwnerID INTEGER,
  IsPrimary INTEGER,
  Include1 INTEGER,
  Include2 INTEGER,
  Include3 INTEGER,
  Include4 INTEGER,
  SortOrder INTEGER,
  RectLeft INTEGER,
  RectTop INTEGER,
  RectRight INTEGER,
  RectBottom INTEGER,
  Note TEXT,
  Caption TEXT COLLATE NOCASE,
  RefNumber TEXT COLLATE NOCASE,
  Date TEXT,
  SortDate INTEGER,
  Description BLOB
);

INSERT INTO MediaLinkTable (
  LinkID, MediaID, OwnerType, OwnerID, IsPrimary, Include1,
  Include2, Include3, Include4, SortOrder, RectLeft, RectTop,
  RectRight, RectBottom, Note, Caption, RefNumber, Date,
  SortDate, Description
)
SELECT
  LinkID, MediaID, OwnerType, OwnerID, IsPrimary, Include1,
  Include2, Include3, Include4, SortOrder, RectLeft, RectTop,
  RectRight, RectBottom, Note, Caption, RefNumber, Date,
  SortDate, Description
FROM MediaLinkTable_new;

DROP TABLE MediaLinkTable_new;

CREATE INDEX idxMediaOwnerID ON MediaLinkTable (OwnerID);
CREATE INDEX idxMediaCaption ON MediaLinkTable (Caption);


/** NameTable */
CREATE TABLE NameTable_new (
  NameID INTEGER PRIMARY KEY,
  OwnerID INTEGER,
  Surname TEXT COLLATE NOCASE,
  Given TEXT COLLATE NOCASE,
  Prefix TEXT COLLATE NOCASE,
  Suffix TEXT COLLATE NOCASE,
  Nickname TEXT COLLATE NOCASE,
  NameType INTEGER,
  Date TEXT,
  SortDate INTEGER,
  IsPrimary INTEGER,
  IsPrivate INTEGER,
  Proof INTEGER,
  EditDate FLOAT,
  Sentence BLOB,
  Note BLOB,
  BirthYear INTEGER,
  DeathYear INTEGER
);

INSERT INTO NameTable_new (
  NameID, OwnerID, Surname, Given, Prefix, Suffix, Nickname,
  NameType, Date, SortDate, IsPrimary, IsPrivate, Proof,
  EditDate, Sentence, Note, BirthYear, DeathYear
)
SELECT
  NameID, OwnerID, Surname, Given, Prefix, Suffix, Nickname,
  NameType, Date, SortDate, IsPrimary, IsPrivate, Proof,
  EditDate, Sentence, Note, BirthYear, DeathYear
FROM NameTable;

DROP TABLE NameTable;

CREATE TABLE NameTable (
  NameID INTEGER PRIMARY KEY,
  OwnerID INTEGER,
  Surname TEXT COLLATE NOCASE,
  Given TEXT COLLATE NOCASE,
  Prefix TEXT COLLATE NOCASE,
  Suffix TEXT COLLATE NOCASE,
  Nickname TEXT COLLATE NOCASE,
  NameType INTEGER,
  Date TEXT,
  SortDate INTEGER,
  IsPrimary INTEGER,
  IsPrivate INTEGER,
  Proof INTEGER,
  EditDate FLOAT,
  Sentence BLOB,
  Note BLOB,
  BirthYear INTEGER,
  DeathYear INTEGER
);

INSERT INTO NameTable (
  NameID, OwnerID, Surname, Given, Prefix, Suffix, Nickname,
  NameType, Date, SortDate, IsPrimary, IsPrivate, Proof,
  EditDate, Sentence, Note, BirthYear, DeathYear
)
SELECT
  NameID, OwnerID, Surname, Given, Prefix, Suffix, Nickname,
  NameType, Date, SortDate, IsPrimary, IsPrivate, Proof,
  EditDate, Sentence, Note, BirthYear, DeathYear
FROM NameTable_new;

DROP TABLE NameTable_new;

CREATE INDEX idxNameOwnerID ON NameTable (OwnerID);
CREATE INDEX idxSurname ON NameTable (Surname);
CREATE INDEX idxGiven ON NameTable (Given);
CREATE INDEX idxSurnameGiven ON NameTable (Surname, Given, BirthYear, DeathYear);
CREATE INDEX idxNamePrimary ON NameTable (IsPrimary);


/** PlaceTable */
CREATE TABLE PlaceTable_new (
  PlaceID INTEGER PRIMARY KEY,
  PlaceType INTEGER,
  Name TEXT COLLATE NOCASE,
  Abbrev TEXT,
  Normalized TEXT,
  Latitude INTEGER,
  Longitude INTEGER,
  LatLongExact INTEGER,
  MasterID INTEGER,
  Note BLOB
);

INSERT INTO PlaceTable_new (
  PlaceID, PlaceType, Name, Abbrev, Normalized, Latitude,
  Longitude, LatLongExact, MasterID, Note
)
SELECT
  PlaceID, PlaceType, Name, Abbrev, Normalized, Latitude,
  Longitude, LatLongExact, MasterID, Note
FROM PlaceTable;

DROP TABLE PlaceTable;

CREATE TABLE PlaceTable (
  PlaceID INTEGER PRIMARY KEY,
  PlaceType INTEGER,
  Name TEXT COLLATE NOCASE,
  Abbrev TEXT,
  Normalized TEXT,
  Latitude INTEGER,
  Longitude INTEGER,
  LatLongExact INTEGER,
  MasterID INTEGER,
  Note BLOB
);

INSERT INTO PlaceTable (
  PlaceID, PlaceType, Name, Abbrev, Normalized, Latitude,
  Longitude, LatLongExact, MasterID, Note
)
SELECT
  PlaceID, PlaceType, Name, Abbrev, Normalized, Latitude,
  Longitude, LatLongExact, MasterID, Note
FROM PlaceTable_new;

DROP TABLE PlaceTable_new;

CREATE INDEX idxPlaceName ON PlaceTable (Name);
CREATE INDEX idxPlaceAbbrev ON PlaceTable (Abbrev);


/** ResearchTable */
CREATE TABLE ResearchTable_new (
  TaskID INTEGER PRIMARY KEY,
  TaskType INTEGER,
  OwnerID INTEGER,
  OwnerType INTEGER,
  RefNumber TEXT,
  Name TEXT COLLATE NOCASE,
  Status INTEGER,
  Priority INTEGER,
  Date1 TEXT,
  Date2 TEXT,
  Date3 TEXT,
  SortDate1 INTEGER,
  SortDate2 INTEGER,
  SortDate3 INTEGER,
  Filename TEXT,
  Details BLOB
);

INSERT INTO ResearchTable_new (
  TaskID, TaskType, OwnerID, OwnerType, RefNumber, Name, Status,
  Priority, Date1, Date2, Date3, SortDate1, SortDate2, SortDate3,
  Filename, Details
)
SELECT
  TaskID, TaskType, OwnerID, OwnerType, RefNumber, Name, Status,
  Priority, Date1, Date2, Date3, SortDate1, SortDate2, SortDate3,
  Filename, Details
FROM ResearchTable;

DROP TABLE ResearchTable;

CREATE TABLE ResearchTable (
  TaskID INTEGER PRIMARY KEY,
  TaskType INTEGER,
  OwnerID INTEGER,
  OwnerType INTEGER,
  RefNumber TEXT,
  Name TEXT COLLATE NOCASE,
  Status INTEGER,
  Priority INTEGER,
  Date1 TEXT,
  Date2 TEXT,
  Date3 TEXT,
  SortDate1 INTEGER,
  SortDate2 INTEGER,
  SortDate3 INTEGER,
  Filename TEXT,
  Details BLOB
);

INSERT INTO ResearchTable (
  TaskID, TaskType, OwnerID, OwnerType, RefNumber, Name, Status,
  Priority, Date1, Date2, Date3, SortDate1, SortDate2, SortDate3,
  Filename, Details
)
SELECT
  TaskID, TaskType, OwnerID, OwnerType, RefNumber, Name, Status,
  Priority, Date1, Date2, Date3, SortDate1, SortDate2, SortDate3,
  Filename, Details
FROM ResearchTable_new;

DROP TABLE ResearchTable_new;

CREATE INDEX idxResearchOwnerID ON ResearchTable (OwnerID);
CREATE INDEX idxResearchName ON ResearchTable (Name);


/** SourceTable */
CREATE TABLE SourceTable_new (
  SourceID INTEGER PRIMARY KEY,
  Name TEXT COLLATE NOCASE,
  RefNumber TEXT,
  ActualText TEXT,
  Comments TEXT,
  IsPrivate INTEGER,
  TemplateID INTEGER,
  Fields BLOB
);

INSERT INTO SourceTable_new (
  SourceID, Name, RefNumber, ActualText, Comments, IsPrivate,
  TemplateID, Fields
)
SELECT
  SourceID, Name, RefNumber, ActualText, Comments, IsPrivate,
  TemplateID, Fields
FROM SourceTable;

DROP TABLE SourceTable;

CREATE TABLE SourceTable (
  SourceID INTEGER PRIMARY KEY,
  Name TEXT COLLATE NOCASE,
  RefNumber TEXT,
  ActualText TEXT,
  Comments TEXT,
  IsPrivate INTEGER,
  TemplateID INTEGER,
  Fields BLOB
);

INSERT INTO SourceTable (
  SourceID, Name, RefNumber, ActualText, Comments, IsPrivate,
  TemplateID, Fields
)
SELECT
  SourceID, Name, RefNumber, ActualText, Comments, IsPrivate,
  TemplateID, Fields
FROM SourceTable_new;

DROP TABLE SourceTable_new;

CREATE INDEX idxSourceName ON SourceTable (Name);


/** WitnessTable */
CREATE TABLE WitnessTable_new (
  WitnessID INTEGER PRIMARY KEY,
  EventID INTEGER,
  PersonID INTEGER,
  WitnessOrder INTEGER,
  Role INTEGER,
  Sentence TEXT,
  Note BLOB,
  Given TEXT COLLATE NOCASE,
  Surname TEXT COLLATE NOCASE,
  Prefix TEXT COLLATE NOCASE,
  Suffix TEXT COLLATE NOCASE
);

INSERT INTO WitnessTable_new (
  WitnessID, EventID, PersonID, WitnessOrder, Role, Sentence,
  Note, Given, Surname, Prefix, Suffix
)
SELECT
  WitnessID, EventID, PersonID, WitnessOrder, Role, Sentence,
  Note, Given, Surname, Prefix, Suffix
FROM WitnessTable;

DROP TABLE WitnessTable;

CREATE TABLE WitnessTable (
  WitnessID INTEGER PRIMARY KEY,
  EventID INTEGER,
  PersonID INTEGER,
  WitnessOrder INTEGER,
  Role INTEGER,
  Sentence TEXT,
  Note BLOB,
  Given TEXT COLLATE NOCASE,
  Surname TEXT COLLATE NOCASE,
  Prefix TEXT COLLATE NOCASE,
  Suffix TEXT COLLATE NOCASE
);

INSERT INTO WitnessTable (
  WitnessID, EventID, PersonID, WitnessOrder, Role, Sentence,
  Note, Given, Surname, Prefix, Suffix
)
SELECT
  WitnessID, EventID, PersonID, WitnessOrder, Role, Sentence,
  Note, Given, Surname, Prefix, Suffix
FROM WitnessTable_new;

DROP TABLE WitnessTable_new;

CREATE INDEX idxWitnessEventID ON WitnessTable (EventID);
CREATE INDEX idxWitnessPersonID ON WitnessTable (PersonID);


/** RoleTable */
CREATE TABLE RoleTable_new (
  RoleID INTEGER PRIMARY KEY,
  RoleName TEXT COLLATE NOCASE,
  EventType INTEGER,
  RoleType INTEGER,
  Sentence TEXT
);

INSERT INTO RoleTable_new (
  RoleID, RoleName, EventType, RoleType, Sentence
)
SELECT
  RoleID, RoleName, EventType, RoleType, Sentence
FROM RoleTable;

DROP TABLE RoleTable;

CREATE TABLE RoleTable (
  RoleID INTEGER PRIMARY KEY,
  RoleName TEXT COLLATE NOCASE,
  EventType INTEGER,
  RoleType INTEGER,
  Sentence TEXT
);

INSERT INTO RoleTable (
  RoleID, RoleName, EventType, RoleType, Sentence
)
SELECT
  RoleID, RoleName, EventType, RoleType, Sentence
FROM RoleTable_new;

DROP TABLE RoleTable_new;

CREATE INDEX idxRoleEventType ON RoleTable (EventType);


/** SourceTemplateTable */
CREATE TABLE SourceTemplateTable_new (
  TemplateID INTEGER PRIMARY KEY,
  Name TEXT COLLATE NOCASE,
  Description TEXT,
  Favorite INTEGER,
  Category TEXT,
  Footnote TEXT,
  ShortFootnote TEXT,
  Bibliography TEXT,
  FieldDefs BLOB
);

INSERT INTO SourceTemplateTable_new (
  TemplateID, Name, Description, Favorite, Category, Footnote, ShortFootnote,
  Bibliography, FieldDefs
)
SELECT
  TemplateID, Name, Description, Favorite, Category, Footnote, ShortFootnote,
  Bibliography, FieldDefs
FROM SourceTemplateTable;

DROP TABLE SourceTemplateTable;

CREATE TABLE SourceTemplateTable (
  TemplateID INTEGER PRIMARY KEY,
  Name TEXT COLLATE NOCASE,
  Description TEXT,
  Favorite INTEGER,
  Category TEXT,
  Footnote TEXT,
  ShortFootnote TEXT,
  Bibliography TEXT,
  FieldDefs BLOB
);

INSERT INTO SourceTemplateTable (
  TemplateID, Name, Description, Favorite, Category, Footnote, ShortFootnote,
  Bibliography, FieldDefs
)
SELECT
  TemplateID, Name, Description, Favorite, Category, Footnote, ShortFootnote,
  Bibliography, FieldDefs
FROM SourceTemplateTable_new;

DROP TABLE SourceTemplateTable_new;

CREATE INDEX idxSourceTemplateName ON SourceTemplateTable (Name);


/** LabelTable */
CREATE TABLE LabelTable_new (
  LabelID INTEGER PRIMARY KEY,
  LabelType INTEGER,
  LabelValue INTEGER,
  LabelName TEXT COLLATE NOCASE,
  Description TEXT
);

INSERT INTO LabelTable_new (
  LabelID, LabelType, LabelValue, LabelName, Description
)
SELECT
  LabelID, LabelType, LabelValue, LabelName, Description
FROM LabelTable;

DROP TABLE LabelTable;

CREATE TABLE LabelTable (
  LabelID INTEGER PRIMARY KEY,
  LabelType INTEGER,
  LabelValue INTEGER,
  LabelName TEXT COLLATE NOCASE,
  Description TEXT
);

INSERT INTO LabelTable (
  LabelID, LabelType, LabelValue, LabelName, Description
)
SELECT
  LabelID, LabelType, LabelValue, LabelName, Description
FROM LabelTable_new;

DROP TABLE LabelTable_new;

CREATE INDEX idxLabelType ON LabelTable (LabelType);

COMMIT;

PRAGMA foreign_keys=on;
