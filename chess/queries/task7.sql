SELECT DISTINCT chessman.type 
FROM chessboard JOIN chessman ON chessboard.id = chessman.id
WHERE color = 'BLACK'