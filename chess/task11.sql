SELECT id
FROM chessboard
WHERE 
col IN (SELECT col FROM chessboard WHERE type = 'ROOK')
OR
row IN (SELECT row FROM chessboard WHERE type = 'ROOK')