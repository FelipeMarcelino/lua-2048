require(2048)
local hex = require("hexmaniac")

-- io.write("Please, chose a number for board size: ")
-- local board_size = io.read("*n")
--
-- local game =  NewGame(board_size)
--
-- game.reset_game()
-- game.make_move(0)
-- game.make_move(1)
-- game.make_move(2)
-- game.make_move(3)
--
--
--
function love.load()
    love.graphics.setNewFont(30)

    game = NewGame(4)
    game.reset_game()


    background_color_game = "92877d"
    background_color_cell_empty = "9e948a"
    background_color_dict = {[2]= "eee4da", [4]= "ede0c8", [8]= "f2b179",
                            [16]= "f59563", [32]= "f67c5f", [64]= "f65e3b",
                            [128]= "edcf72", [256]= "edcc61", [512]= "edc850",
                            [1024]= "edc53f", [2048]= "edc22e",

                            [4096]= "eee4da", [8192]= "edc22e", [16384]= "f2b179",
                            [32768]= "f59563", [65536]= "f67c5f" }

    cell_color_dict = {[2]= "776e65", [4]= "776e65", [8]= "f9f6f2", [16]= "f9f6f2",
                    [32]= "f9f6f2", [64]= "f9f6f2", [128]= "f9f6f2",
                    [256]= "f9f6f2", [512]= "f9f6f2", [1024]= "f9f6f2",
                    [2048]= "f9f6f2",
                    [4096]= "776e65", [8192]= "f9f6f2", [16384]= "776e65",
                    [32768]= "776e65", [65536]= "f9f6f2" }

    function move(direction)

        if direction == 'up' then
            game.make_move(0)
        elseif direction == 'down' then
            game.make_move(1)
        elseif direction == 'right' then
            game.make_move(2)
        elseif direction == 'left' then
            game.make_move(3)
        end

    end
end


function love.draw()
    grid  = game.get_board()
    love.graphics.setBackgroundColor(hex.rgb(background_color_game))

    for line = 1, game.get_board_size() do
        for column = 1, game.get_board_size() do
            local border = 20
            local piece_size = 100
            local piece_draw_size = piece_size - border
            if grid[column][line] == 0 then
                love.graphics.setColor(hex.rgb(background_color_cell_empty))
                love.graphics.rectangle('fill',(line - 1) * piece_size,(column - 1) * piece_size,piece_draw_size,piece_draw_size)
            else
                love.graphics.setColor(hex.rgb(background_color_dict[grid[column][line]]))
                love.graphics.rectangle('fill',(line - 1) * piece_size,(column - 1) * piece_size,piece_draw_size,piece_draw_size)
                love.graphics.setColor(hex.rgb(cell_color_dict[grid[column][line]]))
                love.graphics.printf(grid[column][line],(line - 1) * piece_size,(column - 0.8) * piece_size,80,"center")
            end

        end
    end
    love.graphics.setColor(hex.rgb(background_color_cell_empty))
    love.graphics.rectangle('fill',0,400,380,40)
    love.graphics.setColor(hex.rgb(background_color_dict[2]))
    love.graphics.print("Total Score: ",0,400)
    love.graphics.print(game.get_total_score(),250,400)
end

function reset()
    love.timer.sleep(5)
    game.reset_game()
end

function love.keypressed(key)

    if key == 'down' or key == "j" then
        move('down')
    elseif key == 'up' or key == "k" then
        move('up')
    elseif key == 'right' or key == "l" then
        move('right')
    elseif key == 'left' or key == "h" then
        move('left')
    end

    if game.verify_game_state() then
        reset()
    end
end
