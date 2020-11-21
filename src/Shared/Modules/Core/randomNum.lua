return function(min, max, multiplier)
    if not multiplier then
        multiplier = 1
    end
    return math.random(min * multiplier, max * multiplier) / multiplier
end