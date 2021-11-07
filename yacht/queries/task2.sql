SELECT quality, people, price, STRING_AGG(name, ', ') AS yachts 
FROM Yacht JOIN YachtType ON YachtType.id = Yacht.yacht_type
GROUP BY yacht_type, quality, people, price