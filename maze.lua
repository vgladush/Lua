
function create_map(line)
	local result = 0
	local skip = false
	map[y] = {}
	for i = 1, #line do
		if line:byte(i) == 32 then --32 is spase (from ascii)
			map[y][i] = 0
		elseif line:byte(i) == 73 then --73 is I (from ascii)
			map[y][i] = 1
		elseif line:byte(i) == 69 then --69 is E (from ascii)
			exit_["y"] = y
			exit_["x"] = i
			map[y][i] = "E"
		else
			map[y][i] = -2
		end
	end
	y = y + 1
end

function find_shortest_way()
	step = step - 1
	if map[exit_.y][exit_.x - 1] == 1 then
		map[exit_.y][exit_.x - 1] = "I"
	elseif map[exit_.y][exit_.x + 1] == 1 then
		map[exit_.y][exit_.x + 1] = "I"
	elseif map[exit_.y + 1][exit_.x] == 1 then
		map[exit_.y + 1][exit_.x] = "I"
	elseif map[exit_.y - 1][exit_.x] == 1 then
		map[exit_.y - 1][exit_.x] = "I"
	elseif map[exit_.y][exit_.x + 1] == step then
		map[exit_.y][exit_.x + 1] = "*"
		exit_["x"] = exit_.x + 1
		find_shortest_way()
	elseif map[exit_.y][exit_.x - 1] == step then
		map[exit_.y][exit_.x - 1] = "*"
		exit_["x"] = exit_.x - 1
		find_shortest_way()
	elseif map[exit_.y + 1][exit_.x] == step then
		map[exit_.y + 1][exit_.x] = "*"
		exit_["y"] = exit_.y + 1
		find_shortest_way()
	elseif map[exit_.y - 1][exit_.x] == step then
		map[exit_.y - 1][exit_.x] = "*"
		exit_["y"] = exit_.y - 1
		find_shortest_way()
	end
end

function pave_ways()
	for i = 1, #map do
		for j = 1, #map[i] do
			if map[i][j] == step then
				if map[i][j + 1] == 0 then
					map[i][j + 1] = step + 1
				end
				if map[i][j - 1] == 0 then
					map[i][j - 1] = step + 1
				end
				if map[i + 1][j] == 0 then
					map[i + 1][j] = step + 1
				end
				if map[i - 1][j] == 0 then
					map[i - 1][j] = step + 1
				end
				if map[i][j + 1] == "E" or map[i][j - 1] == "E" or map[i + 1][j] == "E" or map[i - 1][j] == "E" then
					return true
				end
			end
		end
	end
	return false
end

function write_way_into_file()
	for i = 1, #map do
		for j = 1, #map[i] do
			if j == #map[i] and i ~= #map then
				map[i][j] = nil
			elseif map[i][j] == -2 then
				map[i][j] = "0"
			elseif map[i][j] ~= "I" and map[i][j] ~= "E" and map[i][j] ~= "*" then
				map[i][j] = " "
			end
		end
	end
	res = io.open("res.txt", "w")
	for i = 1, #map do
		res:write(table.concat(map[i]).."\n")
	end
	res:close()
end

function file_exists(file)
	local fl = io.open(file, "rb")
	if fl then 
		fl:close()
	else
		error("file not exist")
	end
end

function read_file(file)
	file_exists(file)
	map = {}
	exit_ = {y = 0, x = 0}
	y = 1
	for line in io.lines(file) do 
		create_map(line) --fill the map by line
	end
	step = 1
	while (1) do
		if pave_ways() then
			break
		end
		step = step + 1
	end
	step = step + 1
	find_shortest_way()
	write_way_into_file()
end

local file = "Maze.txt" -- there may be other file with maze
read_file(file)
