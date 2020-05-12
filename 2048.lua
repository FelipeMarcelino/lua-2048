math.randomseed(os.time())
-- Suggested by authors
math.random(); math.random(); math.random()

function NewGame(board_size)
    local self = {board_size = board_size, score = 0, total_score = 0, board={}, temp_board={}}

    for line=1,board_size do
        self.board[line] = {}
        self.temp_board[line] = {}
        for column=1,board_size do
            self.board[line][column] = 0
            self.temp_board[line][column] = 0
        end
    end

    local print_table = function (board) 
        for i=1,self.board_size do
            for j=1,self.board_size do 
                io.write(board[i][j]) 
                io.write(" ")
            end
            print("")
        end
    end

    local get_board_size = function () return self.board_size end

    local transpose = function(board)

        local temp = {}

        for line=1,self.board_size do
            temp[line] = {}
            for column=1,self.board_size do
                temp[line][column] = 0
            end
        end

        for line=1,self.board_size do
            for column=1,self.board_size do
                temp[column][line] = board[line][column]
            end
        end

        return temp
    end

    local reverse = function(board)

        local temp = {}

        for line=1,self.board_size do
            temp[line] = {}
            for column=1,self.board_size do
                temp[line][column] = 0
            end
        end

        for line=1,self.board_size do
            for column=1,self.board_size do
                temp[line][column] = board[self.board_size - line + 1][column]
            end
        end

        return temp
    end

    local cover_up = function(board)

        local temp = {}

        for line=1,self.board_size do
            temp[line] = {}
            for column=1,self.board_size do
                temp[line][column] = 0
            end
        end


        for column=1,self.board_size do
            local up = 1
            for line=1,self.board_size do
                if board[line][column] ~= 0 then
                    temp[up][column] = board[line][column]
                    up = up + 1
                end
            end
        end


        return temp

    end


    local merge = function(board)
    

        for line=2,self.board_size do
            for column=2,self.board_size do
                if board[line][column] == board[line - 1][column] then
                    self.score = self.score + (board[line][column] * 2)
                    board[line - 1][column] = board[line - 1][column] * 2
                    board[line][column] = 0
                end
            end
        end

        return board
    
    end


    local up = function()

        temp = cover_up(self.board)
        temp = merge(temp)
        temp = cover_up(temp)
        self.temp_board = temp

    end

    local down = function() 

        temp = reverse(self.board)
        temp = merge(temp)
        temp = cover_up(temp)
        temp = reverse(temp)
        self.temp_board = temp

    end

    local right = function()

        temp = reverse(transpose(self.board))
        temp = merge(temp)
        temp = cover_up(temp)
        temp = transpose(reverse(temp))
        self.temp_board = temp
    end

    local left = function()

        temp = transpose(self.board)
        temp = merge(temp)
        temp = cover_up(temp)
        temp = transpose(temp)
        self.temp_board = temp

    end


    local add_two_or_four = function ()
        local indexes = {}
        local count = 0

        for line=1,self.board_size do
            for column=1,self.board_size do
                if self.board[line][column] == 0 then
                    count = count + 1
                    indexes[count] = {line,column}
                end
            end
        end

        if count == 0 then
            return 
        else
            local index = math.random(1,count)
            local prob = math.random()
            if prob > 0.9 then
                self.board[indexes[index][1]][indexes[index][2]] = 4
            else
                self.board[indexes[index][1]][indexes[index][2]] = 2
            end
        end

    end



    local confirm_move = function()
        self.total_score = self.total_score + self.score
        local equal = true

        for line=1,self.board_size do
            for column=1, self.board_size do
                if self.temp_board[line][column] ~= self.board[line][column] then
                    equal = false
                end
            end
        end


        if equal == false then
            for line=1,self.board_size do
                for column=1,self.board_size do
                    self.board[line][column] = self.temp_board[line][column]
                end
            end

            add_two_or_four()
            print_table(self.board)
        end
    end


    local make_move = function(move)
        self.score = 0

        if move == 0 then
            up()
        elseif move == 1 then
            down()
        elseif  move == 2 then
            right()
        else 
            left()
        end

        confirm_move()
        print("Total Score:",self.total_score)
        print("")
    end 

    local reset_game = function ()
        for i=1,self.board_size do
            for j=1,self.board_size do
                self.board[i][j] = 0
                self.temp_board[i][j] = 0
            end
        end
        add_two_or_four()
        add_two_or_four()
        print_table(self.board)
        print("Total Score:",self.total_score)
        print("")

    end
    return {
        get_board_size = get_board_size,
        reset_game = reset_game,
        make_move = make_move
    }
end
