/**
 * Family Tree Maker will add event details for fact types that don't support it.
 * Importing them is handled, but they don't show up where they should.
 * This query loads up all the facts with hidden details.
 *
 * To view/edit the fields in RootsMagic, you need to first change the fact type
 * to support displaying details. Do this _after_ running the query.
 * Lists > Fact Type List > double click Fact Type > use description
 */

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
	AND f.UsePlace = 1
	AND n.NameType = 0      -- not nicknames
	AND n.IsPrimary = 1
	And f.UseValue = 0      -- fact type does not use details
