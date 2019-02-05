function trans_to_numb(symb)
	if symb == string.byte("M") then
		return 1000
	elseif symb == string.byte("D") then
		return 500
	elseif symb == string.byte("C") then
		return 100
	elseif symb == string.byte("L") then
		return 50
	elseif symb == string.byte("X") then
		return 10
	elseif symb == string.byte("V") then
		return 5
	else
		return 1
	end
end

function print_res(res)
	local outstr = ""
	while (res >= 1000) do
		outstr = outstr.."M"
		res = res - 1000
	end
	if res >= 900 then
		outstr = outstr.."CM"
		res = res - 900
	end
	if res >= 500 then
		outstr = outstr.."D"
		res = res - 500
	end
	if res >= 400 then
		outstr = outstr.."CD"
		res = res - 400
	end
	while (res >= 100) do
		outstr = outstr.."C"
		res = res - 100
	end
	if res >= 90 then
		outstr = outstr.."XC"
		res = res - 90
	end
	if res >= 50 then
		outstr = outstr.."L"
		res = res - 50
	end
	if res >= 40 then
		outstr = outstr.."XL"
		res = res - 40
	end
	while (res >= 10) do
		outstr = outstr.."X"
		res = res - 10
	end
	if res == 9 then
		outstr = outstr.."IX"
		res = res - 9
	end
	if res >= 5 then
		outstr = outstr.."V"
		res = res - 5
	end
	if res == 4 then
		outstr = outstr.."IV"
		res = res - 5
	end
	while (res > 0) do
		outstr = outstr.."I"
		res = res - 1
	end
	print (outstr) --result - min pos
end

function desc_order(lf, rt)
	if rt == nil then
		return true
	end
	if trans_to_numb(lf) < trans_to_numb(rt) then
		return false
	end
	return true
end

function logic_rom(line)
	local result = 0
	local skip = false -- boolean for cases: 9[00], 4[00]
	for i = 1, #line do --find the number
		if skip then
			skip = false
		elseif desc_order(line:byte(i), line:byte(i + 1)) then --check 4[00] or 9[00]
			result = result + trans_to_numb(line:byte(i))
		else
			result = result + trans_to_numb(line:byte(i + 1)) - trans_to_numb(line:byte(i))
			skip = true
		end
	end
	print_res(result) --number to roman
end

--check if file exists
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

	for line in io.lines(file) do 
		logic_rom(line)
	end
end

local file = "p089_roman.txt" --name of file can be chaged
read_file(file)
