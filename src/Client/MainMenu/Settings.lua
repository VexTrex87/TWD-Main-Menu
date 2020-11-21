return {
    switch = {
        disabledPos = UDim2.new(0, 0, 0, 0),
        disabledColor = Color3.fromRGB(137, 61, 72),
        enabledPos = UDim2.new(0.4, 0, 0, 0),
        enabledColor = Color3.fromRGB(80, 107, 67),
        tweenInfo = {Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.2, true},
    },
    camera = {
        tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
        moveOffset = 1,
        moveInterruptionDelay = 1,
    },
    defaultCharacter = "Rick"
}