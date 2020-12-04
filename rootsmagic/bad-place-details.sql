/**
 * Family Tree Maker will add event details for fact types that don't support it.
 * Importing them is handled, but they don't show up where they should.
 * This query loads up all the facts with hidden details.
 *
 * To view/edit the fields in RootsMagic, you need to first change the fact type
 * to support displaying details. Do this _after_ running the query.
 * Lists > Fact Type List > double click Fact Type > use description
 */

/** Individual Events */
SELECT
	e.OwnerID PersonID,
	n.Given,
	n.Surname,
	f.name Fact_Type,
	quote(e.Details) Details,
	quote(e.Note) Note
FROM
	EventTable e
	LEFT JOIN FactTypeTable f ON f.FactTypeID = e.EventType
	LEFT JOIN NameTable n ON n.OwnerID = e.OwnerID
WHERE
	LENGTH(e.Details) != 0  -- non-empty event details
	AND e.OwnerType = 0     -- single-person events
	AND f.UsePlace = 1
	AND n.NameType = 0      -- not nicknames
	AND n.IsPrimary = 1
	And f.UseValue = 0      -- fact type does not use details


/** Family Events */
SELECT
	e.OwnerID FamilyID,
	fam.FatherID Person1,
	p1.Given 'Person1 Given',
	p1.Surname 'Person1 Surname',
	fam.MotherID Person2,
	p2.Given 'Person2 Given',
	p2.Surname 'Person2 Surname',
	fam.ChildID ChildID,
	f.name Fact_Type,
	quote(e.Details) Details,
	quote(e.Note) Note
FROM
	EventTable e
	LEFT JOIN FactTypeTable f ON f.FactTypeID = e.EventType
	LEFT JOIN FamilyTable fam ON fam.FamilyID = e.OwnerID
	LEFT JOIN NameTable p1 ON fam.FatherID = p1.OwnerID
	LEFT JOIN NameTable p2 ON fam.MotherID = p2.OwnerID
WHERE
	LENGTH(e.Details) != 0  -- non-empty event details
	AND e.OwnerType = 1     -- family events
	AND f.UsePlace = 1
	AND p1.NameType = 0     -- not nicknames
	AND p2.NameType = 0
	AND p1.IsPrimary = 1
	AND p2.IsPrimary = 1
	AND f.UseValue = 0      -- fact type does not use details
