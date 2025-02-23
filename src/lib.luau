--!native

-- String similarity metric system / splinestein diffing algorithm.
-- Free to use!
-- Modified by jiwonz

--[=[
	@class stringdiff

	# [stringdiff-luau](https://pesde.dev/packages/caveful_games/stringdiff)
	A string similarity metric diffing algorithm invented by splinestein for primitive chat bot use.

	This is a fork of [splinestein/splinestein-diffing-algorithm](https://github.com/splinestein/splinestein-diffing-algorithm)

	Modified for Luau(+Roblox) and pesde.

	* Link to module: https://www.roblox.com/library/12088663460/StringDiff
	* Open source and can be viewed here: https://github.com/splinestein/splinestein-diffing-algorithm/blob/main/stringdiff.lua
	* Link to release thread: https://devforum.roblox.com/t/stringdiff-string-similarity-metric-diffing-algorithm/2131245

	**How to use?**

	Install a package via `pesde`
	```sh
	pesde add caveful_games/stringdiff
	```

	I've tested this for primitive chat bot use and it's working nicely.

	It is worth mentioning that this will have O(n) complexity if iterating over any dataset, so keep the dataset
	small unless you use better querying techniques on the dataset like FTS.

	Hope you enjoy. Feel free to suggest any changes.
]=]
local stringdiff = {}

--[=[
	@within stringdiff

	Finds the longest common match between two strings.

	```lua
	local a = "Hello, world!"
	local b = "Hello, Caveful Games!"
	local match, count = stringdiff.getLongestMatch(a, b)
	print(match, count) -- "Hello, ", 7
	```
]=]
function stringdiff.getLongestMatch(a: string, b: string): (string, number)
	-- Create an empty table to store the matches & count all matches.
	local matches: { [number]: string } = {}
	local all_match_count = 0

	-- Iterate over the characters in b for each character in a.
	for i = 1, #a do
		for j = 1, #b do
			-- Create an empty table to store the current match and iterate over the characters, starting at index i.
			local current_match: { [number]: string } = {}
			for k = i, #a do
				-- Check if the character at index k in a is the same as the character at index j in b.
				if string.sub(a, k, k) == string.sub(b, j, j) then
					-- If the characters are the same, add the character to the current match table.
					table.insert(current_match, string.sub(a, k, k))
					-- Increment j to compare the next character in b.
					j += 1
				else
					-- If the characters are different, break the inner loop.
					break
				end
			end
			-- Skip empty matches, only store those we found.
			if #table.concat(current_match) > 0 then
				all_match_count += 1
			end
			-- Update the longest match if the current one is longer.
			if #current_match > #matches then
				matches = current_match
			end
		end
	end
	-- Return both the longest match and the count.
	return table.concat(matches), all_match_count
end

--[=[
	@within stringdiff

	Calculates the perfect common match count for a given sentence.

	```lua
	local sentence = "aaabb"
	local count = stringdiff.perfectCommonMatchCalc(sentence)
	print(count) -- 13
	```
]=]
function stringdiff.perfectCommonMatchCalc(sentence: string): number
	--[[
		In an ideal scenario, how many common matches would be made?
		If both strings are "aaabb" it's (equation):
		(how many a's * how many a's) + unique letter (how many b's * how many b's) + ... = 13
	]]

	local counts: { [string]: number } = {}

	for i = 1, #sentence do
		local letter: string = string.sub(sentence, i, i)

		if counts[letter] then
			counts[letter] = counts[letter] + 1
		else
			counts[letter] = 1
		end
	end

	local total_matches = 0

	for _, count in counts do
		total_matches += count * count
	end

	return total_matches
end

--[=[
	@within stringdiff

	Compares two strings and returns a similarity ratio and the longest common match.

	```lua
	local a = "Hello, world!"
	local b = "Hello, Caveful Games!"
	local ratio, match = stringdiff.compare(a, b)
	print(ratio, match) -- 50, "Hello, "
	```
]=]
function stringdiff.compare(a: string, b: string): (number, string)
	-- Core functionality:
	if #a < #b then
		a, b = b, a
	end

	-- Just no point in comparing such small strings. Lift restriction if you feel like it.
	if #a < 1 then
		error("Strings are too short to compare.")
	end

	local perfect_match_count = stringdiff.perfectCommonMatchCalc(a)

	local longest_match, all_match_count = stringdiff.getLongestMatch(a, b)

	-- Core ratio logic calculation:
	local matches_length_compared = (#longest_match / #a) * 100 -- How big of a portion does the largest match take out of the sentence?
	local match_count_similarity = (all_match_count / perfect_match_count) * 100 -- How many matches could've been made in an ideal perfect scenario?
	local string_length_similarity = (#b / #a) * 100 -- How long both a and b are compared to each other?

	-- Finalization:
	local average_count_match_ratio = (matches_length_compared + match_count_similarity) / 2 -- Average out most important percentages, match length portion and count similarity for best result.

	-- We want to calculate how much we should change the ratio.
	local a_calc, b_calc = average_count_match_ratio, string_length_similarity -- stringdiff.longestNumber(average_count_match_ratio, string_length_similarity)
	if average_count_match_ratio < string_length_similarity then
		a_calc, b_calc = string_length_similarity, average_count_match_ratio
	end

	local ratio = average_count_match_ratio * ((b_calc / a_calc) / 100)

	--[[
		In a scenario where A and B are "Hey" and "How", you might think their general appearance,
		is similar in that they are both three letters long and contain only lowercase letters.
		However, this type of superficial similarity is not necessarily indicative of deeper similarity in meaning or usage.
		Hence why I skip extra string_length_similarity checks that I could possibily utilize in the ratio.
	]]

	return ratio, longest_match
end

return stringdiff
