function isPressed = checkKeyInput(keyCode)
    %CHECKKEYINPUT check if spesific key is pressed
    [keyIsDown, ~, keyStates] = KbCheck;
    isPressed = keyIsDown && keyStates(keyCode) == 1;
end

