require(2048)

io.write("Please, chose a number for board size: ")
local board_size = io.read("*n")

local game =  NewGame(board_size)

game.reset_game()
game.make_move(0)
game.make_move(1)
game.make_move(2)
game.make_move(3)

